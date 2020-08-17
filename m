Return-Path: <SRS0=Eo6L=B3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D9FC433DF
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659DE2063A
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgHQWNP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:13:15 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60688 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbgHQWLu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 18:11:50 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nM5-001r1r-Cb; Mon, 17 Aug 2020 16:11:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKy-0004PB-SS; Mon, 17 Aug 2020 16:10:41 -0600
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
        =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon, 17 Aug 2020 17:04:25 -0500
Message-Id: <20200817220425.9389-17-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKy-0004PB-SS;;;mid=<20200817220425.9389-17-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX189SIbJBN8xtDSgqAOp2uiQOVALu5yFTAQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 17/17] file: Rename __close_fd to close_fd and remove the files parameter
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function __close_fd was added to support binder[1].  Now that
binder has been fixed to no longer need __close_fd[2] and
get_files_struct has been removed it is no longer possible to
correctly call __close_fd with anything current->files pass as it's
files parameter.

Therefore transform the files parameter into a local variable
initialized to current->files, and rename __close_fd to close_fd to
reflect this change, and keep it in sync with the similar changes to
__alloc_fd, and __fd_install.

This removes the need for callers to care about the extra care that
needs to be take if anything except current->files is passed, by
limiting the callers to only operation on current->files.

[1] 483ce1d4b8c3 ("take descriptor-related part of close() to file.c")
[2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c                | 10 ++++------
 fs/open.c                |  2 +-
 include/linux/fdtable.h  |  3 +--
 include/linux/syscalls.h |  6 +++---
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 221fc4f97f61..b06b04d65070 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -614,11 +614,9 @@ static struct file *pick_file(struct files_struct *files, unsigned fd)
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
@@ -627,7 +625,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
 
 	return filp_close(file, files);
 }
-EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
+EXPORT_SYMBOL(close_fd); /* for ksys_close() */
 
 /**
  * __close_range() - Close all file descriptors in a given range.
@@ -1010,7 +1008,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
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
index d8f6c4921d85..d1b8f3d85493 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -116,8 +116,7 @@ int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
 
-extern int __close_fd(struct files_struct *files,
-		      unsigned int fd);
+extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern int __close_fd_get_file(unsigned int fd, struct file **res);
 extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 75ac7f8ae93c..a3f48cf49206 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1293,16 +1293,16 @@ static inline long ksys_ftruncate(unsigned int fd, loff_t length)
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

