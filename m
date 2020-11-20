Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F848C2D0E4
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93C42240C
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgKTXT5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:19:57 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:49062 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgKTXT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:19:56 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh4-006Xz9-SC; Fri, 20 Nov 2020 16:19:54 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFeQ-00EG00-MH; Fri, 20 Nov 2020 16:17:11 -0700
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
Date:   Fri, 20 Nov 2020 17:14:38 -0600
Message-Id: <20201120231441.29911-21-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFeQ-00EG00-MH;;;mid=<20201120231441.29911-21-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18yZsJQg7Sob1TmifEv7F2Q+rtBQX59b5c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 21/24] file: Rename __close_fd to close_fd and remove the files parameter
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function __close_fd was added to support binder[1].  Now that
binder has been fixed to no longer need __close_fd[2] all calls
to __close_fd pass current->files.

Therefore transform the files parameter into a local variable
initialized to current->files, and rename __close_fd to close_fd to
reflect this change, and keep it in sync with the similar changes to
__alloc_fd, and __fd_install.

This removes the need for callers to care about the extra care that
needs to be take if anything except current->files is passed, by
limiting the callers to only operation on current->files.

[1] 483ce1d4b8c3 ("take descriptor-related part of close() to file.c")
[2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-17-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c                | 10 ++++------
 fs/open.c                |  2 +-
 include/linux/fdtable.h  |  3 +--
 include/linux/syscalls.h |  6 +++---
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 621563701bd9..987ea51630b4 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -629,11 +629,9 @@ static struct file *pick_file(struct files_struct *files, unsigned fd)
 	return file;
 }
 
-/*
- * The same warnings as for __alloc_fd()/__fd_install() apply here...
- */
-int __close_fd(struct files_struct *files, unsigned fd)
+int close_fd(unsigned fd)
 {
+	struct files_struct *files = current->files;
 	struct file *file;
 
 	file = pick_file(files, fd);
@@ -642,7 +640,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
 
 	return filp_close(file, files);
 }
-EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
+EXPORT_SYMBOL(close_fd); /* for ksys_close() */
 
 /**
  * __close_range() - Close all file descriptors in a given range.
@@ -1027,7 +1025,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	struct files_struct *files = current->files;
 
 	if (!file)
-		return __close_fd(files, fd);
+		return close_fd(fd);
 
 	if (fd >= rlimit(RLIMIT_NOFILE))
 		return -EBADF;
diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..581a674d7eee 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1292,7 +1292,7 @@ EXPORT_SYMBOL(filp_close);
  */
 SYSCALL_DEFINE1(close, unsigned int, fd)
 {
-	int retval = __close_fd(current->files, fd);
+	int retval = close_fd(fd);
 
 	/* can't restart close syscall because file table entry was cleared */
 	if (unlikely(retval == -ERESTARTSYS ||
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index dc476ae92f56..dad4a488ce60 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -124,8 +124,7 @@ int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
 
-extern int __close_fd(struct files_struct *files,
-		      unsigned int fd);
+extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern int __close_fd_get_file(unsigned int fd, struct file **res);
 extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 37bea07c12f2..9e055a0579f8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1295,16 +1295,16 @@ static inline long ksys_ftruncate(unsigned int fd, loff_t length)
 	return do_sys_ftruncate(fd, length, 1);
 }
 
-extern int __close_fd(struct files_struct *files, unsigned int fd);
+extern int close_fd(unsigned int fd);
 
 /*
  * In contrast to sys_close(), this stub does not check whether the syscall
  * should or should not be restarted, but returns the raw error codes from
- * __close_fd().
+ * close_fd().
  */
 static inline int ksys_close(unsigned int fd)
 {
-	return __close_fd(current->files, fd);
+	return close_fd(fd);
 }
 
 extern long do_sys_truncate(const char __user *pathname, loff_t length);
-- 
2.25.0

