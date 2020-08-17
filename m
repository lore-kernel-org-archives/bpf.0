Return-Path: <SRS0=Eo6L=B3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CAC433E1
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFCC32063A
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgHQWLv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:11:51 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33570 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgHQWLt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 18:11:49 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nM4-001H7q-Gf; Mon, 17 Aug 2020 16:11:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKa-0004PB-2m; Mon, 17 Aug 2020 16:10:16 -0600
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
Date:   Mon, 17 Aug 2020 17:04:19 -0500
Message-Id: <20200817220425.9389-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKa-0004PB-2m;;;mid=<20200817220425.9389-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18GsEQJ0oPPoD5n5diUwjvIvO0UyKBadWU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 11/17] bpf/task_iter: In task_file_seq_get_next use fnext_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When discussing[1] exec and posix file locks it was realized that none
of the callers of get_files_struct fundamentally needed to call
get_files_struct, and that by switching them to helper functions
instead it will both simplify their code and remove unnecessary
increments of files_struct.count.  Those unnecessary increments can
result in exec unnecessarily unsharing files_struct which breaking
posix locks, and it can result in fget_light having to fallback to
fget reducing system performance.

Using fnext_task simplifies task_file_seq_get_next, by moving the
checking for the maximum file descritor into the generic code, and by
remvoing the need for capturing and releasing a reference on
files_struct.  As the reference count of files_struct no longer needs
to be maintained bpf_iter_seq_task_file_info can have it's files member
removed and task_file_seq_get_next no longer it's fstruct argument.

The curr_fd local variable does need to become unsigned to be used
with fnext_task.  As curr_fd is assigned from and assigned a u32
making curr_fd an unsigned int won't cause problems and might prevent
them.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/bpf/task_iter.c | 43 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 232df29793e9..831d42d7543a 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -122,45 +122,33 @@ struct bpf_iter_seq_task_file_info {
 	 */
 	struct bpf_iter_seq_task_common common;
 	struct task_struct *task;
-	struct files_struct *files;
 	u32 tid;
 	u32 fd;
 };
 
 static struct file *
 task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
-		       struct task_struct **task, struct files_struct **fstruct)
+		       struct task_struct **task)
 {
 	struct pid_namespace *ns = info->common.ns;
-	u32 curr_tid = info->tid, max_fds;
-	struct files_struct *curr_files;
+	u32 curr_tid = info->tid;
 	struct task_struct *curr_task;
-	int curr_fd = info->fd;
+	unsigned int curr_fd = info->fd;
 
 	/* If this function returns a non-NULL file object,
-	 * it held a reference to the task/files_struct/file.
+	 * it held a reference to the task/file.
 	 * Otherwise, it does not hold any reference.
 	 */
 again:
 	if (*task) {
 		curr_task = *task;
-		curr_files = *fstruct;
 		curr_fd = info->fd;
 	} else {
 		curr_task = task_seq_get_next(ns, &curr_tid);
 		if (!curr_task)
 			return NULL;
 
-		curr_files = get_files_struct(curr_task);
-		if (!curr_files) {
-			put_task_struct(curr_task);
-			curr_tid = ++(info->tid);
-			info->fd = 0;
-			goto again;
-		}
-
-		/* set *fstruct, *task and info->tid */
-		*fstruct = curr_files;
+		/* set *task and info->tid */
 		*task = curr_task;
 		if (curr_tid == info->tid) {
 			curr_fd = info->fd;
@@ -171,13 +159,12 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
 	}
 
 	rcu_read_lock();
-	max_fds = files_fdtable(curr_files)->max_fds;
-	for (; curr_fd < max_fds; curr_fd++) {
+	for (;; curr_fd++) {
 		struct file *f;
 
-		f = fcheck_files(curr_files, curr_fd);
+		f = fnext_task(curr_task, &curr_fd);
 		if (!f)
-			continue;
+			break;
 
 		/* set info->fd */
 		info->fd = curr_fd;
@@ -188,10 +175,8 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
 
 	/* the current task is done, go to the next task */
 	rcu_read_unlock();
-	put_files_struct(curr_files);
 	put_task_struct(curr_task);
 	*task = NULL;
-	*fstruct = NULL;
 	info->fd = 0;
 	curr_tid = ++(info->tid);
 	goto again;
@@ -200,13 +185,11 @@ task_file_seq_get_next(struct bpf_iter_seq_task_file_info *info,
 static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	struct bpf_iter_seq_task_file_info *info = seq->private;
-	struct files_struct *files = NULL;
 	struct task_struct *task = NULL;
 	struct file *file;
 
-	file = task_file_seq_get_next(info, &task, &files);
+	file = task_file_seq_get_next(info, &task);
 	if (!file) {
-		info->files = NULL;
 		info->task = NULL;
 		return NULL;
 	}
@@ -214,7 +197,6 @@ static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
 	if (*pos == 0)
 		++*pos;
 	info->task = task;
-	info->files = files;
 
 	return file;
 }
@@ -222,22 +204,19 @@ static void *task_file_seq_start(struct seq_file *seq, loff_t *pos)
 static void *task_file_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	struct bpf_iter_seq_task_file_info *info = seq->private;
-	struct files_struct *files = info->files;
 	struct task_struct *task = info->task;
 	struct file *file;
 
 	++*pos;
 	++info->fd;
 	fput((struct file *)v);
-	file = task_file_seq_get_next(info, &task, &files);
+	file = task_file_seq_get_next(info, &task);
 	if (!file) {
-		info->files = NULL;
 		info->task = NULL;
 		return NULL;
 	}
 
 	info->task = task;
-	info->files = files;
 
 	return file;
 }
@@ -286,9 +265,7 @@ static void task_file_seq_stop(struct seq_file *seq, void *v)
 		(void)__task_file_seq_show(seq, v, true);
 	} else {
 		fput((struct file *)v);
-		put_files_struct(info->files);
 		put_task_struct(info->task);
-		info->files = NULL;
 		info->task = NULL;
 	}
 }
-- 
2.25.0

