Return-Path: <SRS0=Eo6L=B3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ADCC433F4
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A5920674
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgHQWMD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:12:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33606 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgHQWLv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 18:11:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nM5-001H8C-Vy; Mon, 17 Aug 2020 16:11:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKm-0004PB-L7; Mon, 17 Aug 2020 16:10:29 -0600
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
Date:   Mon, 17 Aug 2020 17:04:22 -0500
Message-Id: <20200817220425.9389-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKm-0004PB-L7;;;mid=<20200817220425.9389-14-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/b1FqIJGp7GfPLwyPwndSgsGRDfb1vTc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 14/17] file: Merge __fd_install into fd_install
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function __fd_install was added to support binder[1].  With binder
fixed[2] there are no more users.  Further with get_files_struct
removed there can be no more users of __fd_install that pass anything
except current->files.

As fd_install just calls __fd_install with "files=current->files",
merge them together by transforming the files parameter into a
local variable initialized to current->files.

[1] f869e8a7f753 ("expose a low-level variant of fd_install() for binder")
[2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 25 ++++++-------------------
 include/linux/fdtable.h |  2 --
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 605e756f3c63..1a755811669d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -157,7 +157,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	spin_unlock(&files->file_lock);
 	new_fdt = alloc_fdtable(nr);
 
-	/* make sure all __fd_install() have seen resize_in_progress
+	/* make sure all fd_install() have seen resize_in_progress
 	 * or have finished their rcu_read_lock_sched() section.
 	 */
 	if (atomic_read(&files->count) > 1)
@@ -180,7 +180,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	rcu_assign_pointer(files->fdt, new_fdt);
 	if (cur_fdt != &files->fdtab)
 		call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
-	/* coupled with smp_rmb() in __fd_install() */
+	/* coupled with smp_rmb() in fd_install() */
 	smp_wmb();
 	return 1;
 }
@@ -569,17 +569,13 @@ EXPORT_SYMBOL(put_unused_fd);
  * It should never happen - if we allow dup2() do it, _really_ bad things
  * will follow.
  *
- * NOTE: __fd_install() variant is really, really low-level; don't
- * use it unless you are forced to by truly lousy API shoved down
- * your throat.  'files' *MUST* be either current->files or obtained
- * by get_files_struct(current) done by whoever had given it to you,
- * or really bad things will happen.  Normally you want to use
- * fd_install() instead.
+ * This consumes the "file" refcount, so callers should treat it
+ * as if they had called fput(file).
  */
 
-void __fd_install(struct files_struct *files, unsigned int fd,
-		struct file *file)
+void fd_install(unsigned int fd, struct file *file)
 {
+	struct files_struct *files = current->files;
 	struct fdtable *fdt;
 
 	rcu_read_lock_sched();
@@ -601,15 +597,6 @@ void __fd_install(struct files_struct *files, unsigned int fd,
 	rcu_read_unlock_sched();
 }
 
-/*
- * This consumes the "file" refcount, so callers should treat it
- * as if they had called fput(file).
- */
-void fd_install(unsigned int fd, struct file *file)
-{
-	__fd_install(current->files, fd, file);
-}
-
 EXPORT_SYMBOL(fd_install);
 
 static struct file *pick_file(struct files_struct *files, unsigned fd)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 8c4bc6aa19c9..4da8aacc461a 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -118,8 +118,6 @@ int iterate_fd(struct files_struct *, unsigned,
 
 extern int __alloc_fd(struct files_struct *files,
 		      unsigned start, unsigned end, unsigned flags);
-extern void __fd_install(struct files_struct *files,
-		      unsigned int fd, struct file *file);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-- 
2.25.0

