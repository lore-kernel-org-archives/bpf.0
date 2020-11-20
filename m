Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19A1C83010
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA482242A
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgKTXUA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:20:00 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:49098 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgKTXT5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:19:57 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh6-006Xzd-1h; Fri, 20 Nov 2020 16:19:56 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFe5-00EG00-JV; Fri, 20 Nov 2020 16:16:50 -0700
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
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lavr <andy.lavr@gmail.com>
Date:   Fri, 20 Nov 2020 17:14:32 -0600
Message-Id: <20201120231441.29911-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFe5-00EG00-JV;;;mid=<20201120231441.29911-15-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+q5zppczWnIGjDjmGmiwzeRnfW/aWDbwE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 15/24] proc/fd: In proc_readfd_common use task_lookup_next_fd_rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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

Using task_lookup_next_fd_rcu simplifies proc_readfd_common, by moving
the checking for the maximum file descritor into the generic code, and
by remvoing the need for capturing and releasing a reference on
files_struct.

As task_lookup_fd_rcu may update the fd ctx->pos has been changed
to be the fd +2 after task_lookup_fd_rcu returns.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Tested-by: Andy Lavr <andy.lavr@gmail.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-10-ebiederm@xmission.com
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/fd.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index c1a984f3c4df..72c1525b4b3e 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -217,7 +217,6 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 			      instantiate_t instantiate)
 {
 	struct task_struct *p = get_proc_task(file_inode(file));
-	struct files_struct *files;
 	unsigned int fd;
 
 	if (!p)
@@ -225,22 +224,18 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 
 	if (!dir_emit_dots(file, ctx))
 		goto out;
-	files = get_files_struct(p);
-	if (!files)
-		goto out;
 
 	rcu_read_lock();
-	for (fd = ctx->pos - 2;
-	     fd < files_fdtable(files)->max_fds;
-	     fd++, ctx->pos++) {
+	for (fd = ctx->pos - 2;; fd++) {
 		struct file *f;
 		struct fd_data data;
 		char name[10 + 1];
 		unsigned int len;
 
-		f = files_lookup_fd_rcu(files, fd);
+		f = task_lookup_next_fd_rcu(p, &fd);
+		ctx->pos = fd + 2LL;
 		if (!f)
-			continue;
+			break;
 		data.mode = f->f_mode;
 		rcu_read_unlock();
 		data.fd = fd;
@@ -249,13 +244,11 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 		if (!proc_fill_cache(file, ctx,
 				     name, len, instantiate, p,
 				     &data))
-			goto out_fd_loop;
+			goto out;
 		cond_resched();
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
-out_fd_loop:
-	put_files_struct(files);
 out:
 	put_task_struct(p);
 	return 0;
-- 
2.25.0

