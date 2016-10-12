gisting() {
   _GIST_SYNC_TARGET_DIR=$1
   _GIST_SYNC_URL=
   _GIST_SYNC_DESCRIPTION="NO TITLE"

   if [ ! "$_GIST_SYNC_TARGET_DIR" ]
   then
      _GIST_SYNC_TARGET_DIR=$(pwd)
   fi

   if [ -e "$_GIST_SYNC_TARGET_DIR/.gist_url" ]
   then
       _GIST_SYNC_URL=$(head -n 1 $_GIST_SYNC_TARGET_DIR/.gist_url | cut -d "/" -f4)
   fi

   if [ -e $_GIST_SYNC_TARGET_DIR/README* ]
   then
       _GIST_SYNC_DESCRIPTION=$(head -n 1 $_GIST_SYNC_TARGET_DIR/README* | awk 'sub(/^#[ ]*/, ""); sub(/[\t]/, "");')
   fi

   if [ "$_GIST_SYNC_URL" ]
   then  # 更新
       for _GIST_SYNC_TARGET_FILE in `git ls-files $_GIST_SYNC_TARGET_DIR | grep -v .gitignore`
       do
           if [ "$(git diff $_GIST_SYNC_TARGET_FILE )" ]
           then
               gist -u $_GIST_SYNC_URL -d $_GIST_SYNC_DESCRIPTION -f `basename $_GIST_SYNC_TARGET_FILE` $_GIST_SYNC_TARGET_FILE | tee $_GIST_SYNC_TARGET_DIR/.gist_url
               git commit -m "update gist" $_GIST_SYNC_TARGET_FILE
           else
               echo "No updated:" $_GIST_SYNC_TARGET_FILE
           fi
       done
   else  # 登録
       echo gist -d "$_GIST_SYNC_DESCRIPTION" $_GIST_SYNC_TARGET_DIR/*
       git add $_GIST_SYNC_TARGET_DIR
       git commit $_GIST_SYNC_TARGET_DIR -m "updated gist"
       gist -d $_GIST_SYNC_DESCRIPTION `git ls-files $_GIST_SYNC_TARGET_DIR | grep -v .gitignore` | tee $_GIST_SYNC_TARGET_DIR/.gist_url
   fi
}
