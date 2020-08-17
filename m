Return-Path: <SRS0=Eo6L=B3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE04C433E4
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825242078D
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgHQWJl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:09:41 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:32812 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgHQWJk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 18:09:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nJy-001GwP-OE; Mon, 17 Aug 2020 16:09:38 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nJx-0004PB-Pg; Mon, 17 Aug 2020 16:09:38 -0600
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
Date:   Mon, 17 Aug 2020 17:04:10 -0500
Message-Id: <20200817220425.9389-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nJx-0004PB-Pg;;;mid=<20200817220425.9389-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xNEwjlJ8evEae+YxPr4wPgZFD/xy0je8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 02/17] exec: Simplify unshare_files
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that exec no longer needs to return the unshared files to their
previous value there is no reason to return displaced.

Instead when unshare_fd creates a copy of the file table, call
put_files_struct before returning from unshare_files.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/coredump.c           |  5 +----
 fs/exec.c               |  5 +----
 include/linux/fdtable.h |  2 +-
 kernel/fork.c           | 12 ++++++------
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 76e7c10edfc0..568d6e391082 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -585,7 +585,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	int ispipe;
 	size_t *argv = NULL;
 	int argc = 0;
-	struct files_struct *displaced;
 	/* require nonrelative corefile path and be extra careful */
 	bool need_suid_safe = false;
 	bool core_dumped = false;
@@ -791,11 +790,9 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	}
 
 	/* get us an unshared descriptor table; almost always a no-op */
-	retval = unshare_files(&displaced);
+	retval = unshare_files();
 	if (retval)
 		goto close_fail;
-	if (displaced)
-		put_files_struct(displaced);
 	if (!dump_interrupted()) {
 		/*
 		 * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH="" would
diff --git a/fs/exec.c b/fs/exec.c
index 17c007bba712..9b723d2560d1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1354,7 +1354,6 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 int begin_new_exec(struct linux_binprm * bprm)
 {
 	struct task_struct *me = current;
-	struct files_struct *displaced;
 	int retval;
 
 	/* Once we are committed compute the creds */
@@ -1375,11 +1374,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 		goto out;
 
 	/* Ensure the files table is not shared. */
-	retval = unshare_files(&displaced);
+	retval = unshare_files();
 	if (retval)
 		goto out;
-	if (displaced)
-		put_files_struct(displaced);
 
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index a32bf47c593e..f46a084b60b2 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -109,7 +109,7 @@ struct task_struct;
 struct files_struct *get_files_struct(struct task_struct *);
 void put_files_struct(struct files_struct *fs);
 void reset_files_struct(struct files_struct *);
-int unshare_files(struct files_struct **);
+int unshare_files(void);
 struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
diff --git a/kernel/fork.c b/kernel/fork.c
index 4d32190861bd..3049a41076f3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2995,21 +2995,21 @@ SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
  *	the exec layer of the kernel.
  */
 
-int unshare_files(struct files_struct **displaced)
+int unshare_files(void)
 {
 	struct task_struct *task = current;
-	struct files_struct *copy = NULL;
+	struct files_struct *old, *copy = NULL;
 	int error;
 
 	error = unshare_fd(CLONE_FILES, NR_OPEN_MAX, &copy);
-	if (error || !copy) {
-		*displaced = NULL;
+	if (error || !copy)
 		return error;
-	}
-	*displaced = task->files;
+
+	old = task->files;
 	task_lock(task);
 	task->files = copy;
 	task_unlock(task);
+	put_files_struct(old);
 	return 0;
 }
 
-- 
2.25.0

