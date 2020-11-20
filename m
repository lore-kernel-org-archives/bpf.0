Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479E9C64E7A
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131612240C
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgKTXQc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:16:32 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:48262 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgKTXQb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:16:31 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdl-006XdA-P4; Fri, 20 Nov 2020 16:16:29 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdk-00EG00-Kf; Fri, 20 Nov 2020 16:16:29 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, criu@openvz.org,
        bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri, 20 Nov 2020 17:14:26 -0600
Message-Id: <20201120231441.29911-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdk-00EG00-Kf;;;mid=<20201120231441.29911-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/iyicyOORGjJR68+3TCVNRFyQygIkeLVU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 09/24] file: Replace fcheck_files with files_lookup_fd_rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change renames fcheck_files to files_lookup_fd_rcu.  All of the
remaining callers take the rcu_read_lock before calling this function
so the _rcu suffix is appropriate.  This change also tightens up the
debug check to verify that all callers hold the rcu_read_lock.

All callers that used to call files_check with the files->file_lock
held have now been changed to call files_lookup_fd_locked.

This change of name has helped remind me of which locks and which
guarantees are in place helping me to catch bugs later in the
patchset.

The need for better names became apparent in the last round of
discussion of this set of changes[1].

[1] https://lkml.kernel.org/r/CAHk-=wj8BQbgJFLa+J0e=iT-1qpmCRTbPAJ8gd6MJQ=kbRPqyQ@mail.gmail.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Documentation/filesystems/files.rst | 6 +++---
 fs/file.c                           | 4 ++--
 fs/proc/fd.c                        | 4 ++--
 include/linux/fdtable.h             | 7 +++----
 kernel/bpf/task_iter.c              | 2 +-
 kernel/kcmp.c                       | 2 +-
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/Documentation/filesystems/files.rst b/Documentation/filesystems/files.rst
index cbf8e57376bf..ea75acdb632c 100644
--- a/Documentation/filesystems/files.rst
+++ b/Documentation/filesystems/files.rst
@@ -62,7 +62,7 @@ the fdtable structure -
    be held.
 
 4. To look up the file structure given an fd, a reader
-   must use either fcheck() or fcheck_files() APIs. These
+   must use either fcheck() or files_lookup_fd_rcu() APIs. These
    take care of barrier requirements due to lock-free lookup.
 
    An example::
@@ -84,7 +84,7 @@ the fdtable structure -
    on ->f_count::
 
 	rcu_read_lock();
-	file = fcheck_files(files, fd);
+	file = files_lookup_fd_rcu(files, fd);
 	if (file) {
 		if (atomic_long_inc_not_zero(&file->f_count))
 			*fput_needed = 1;
@@ -104,7 +104,7 @@ the fdtable structure -
    lock-free, they must be installed using rcu_assign_pointer()
    API. If they are looked up lock-free, rcu_dereference()
    must be used. However it is advisable to use files_fdtable()
-   and fcheck()/fcheck_files() which take care of these issues.
+   and fcheck()/files_lookup_fd_rcu() which take care of these issues.
 
 7. While updating, the fdtable pointer must be looked up while
    holding files->file_lock. If ->file_lock is dropped, then
diff --git a/fs/file.c b/fs/file.c
index 9d0e91168be1..5861c4f89419 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -814,7 +814,7 @@ static struct file *__fget_files(struct files_struct *files, unsigned int fd,
 
 	rcu_read_lock();
 loop:
-	file = fcheck_files(files, fd);
+	file = files_lookup_fd_rcu(files, fd);
 	if (file) {
 		/* File object ref couldn't be taken.
 		 * dup2() atomicity guarantee is the reason
@@ -1127,7 +1127,7 @@ SYSCALL_DEFINE2(dup2, unsigned int, oldfd, unsigned int, newfd)
 		int retval = oldfd;
 
 		rcu_read_lock();
-		if (!fcheck_files(files, oldfd))
+		if (!files_lookup_fd_rcu(files, oldfd))
 			retval = -EBADF;
 		rcu_read_unlock();
 		return retval;
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 2cca9bca3b3a..3dec44d7c5c5 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -90,7 +90,7 @@ static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
 		return false;
 
 	rcu_read_lock();
-	file = fcheck_files(files, fd);
+	file = files_lookup_fd_rcu(files, fd);
 	if (file)
 		*mode = file->f_mode;
 	rcu_read_unlock();
@@ -243,7 +243,7 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 		char name[10 + 1];
 		unsigned int len;
 
-		f = fcheck_files(files, fd);
+		f = files_lookup_fd_rcu(files, fd);
 		if (!f)
 			continue;
 		data.mode = f->f_mode;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index fda4b81dd735..fa8c402a7790 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -98,10 +98,9 @@ static inline struct file *files_lookup_fd_locked(struct files_struct *files, un
 	return files_lookup_fd_raw(files, fd);
 }
 
-static inline struct file *fcheck_files(struct files_struct *files, unsigned int fd)
+static inline struct file *files_lookup_fd_rcu(struct files_struct *files, unsigned int fd)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&
-			   !lockdep_is_held(&files->file_lock),
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
 			   "suspicious rcu_dereference_check() usage");
 	return files_lookup_fd_raw(files, fd);
 }
@@ -109,7 +108,7 @@ static inline struct file *fcheck_files(struct files_struct *files, unsigned int
 /*
  * Check whether the specified fd has an open file.
  */
-#define fcheck(fd)	fcheck_files(current->files, fd)
+#define fcheck(fd)	files_lookup_fd_rcu(current->files, fd)
 
 struct task_struct;
 
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 5b6af30bfbcd..5ab2ccfb96cb 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -183,7 +183,7 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
 	for (; curr_fd < max_fds; curr_fd++) {
 		struct file *f;
 
-		f = fcheck_files(curr_files, curr_fd);
+		f = files_lookup_fd_rcu(curr_files, curr_fd);
 		if (!f)
 			continue;
 		if (!get_file_rcu(f))
diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 87c48c0104ad..990717c1aed3 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -67,7 +67,7 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
 	rcu_read_lock();
 
 	if (task->files)
-		file = fcheck_files(task->files, idx);
+		file = files_lookup_fd_rcu(task->files, idx);
 
 	rcu_read_unlock();
 	task_unlock(task);
-- 
2.25.0

