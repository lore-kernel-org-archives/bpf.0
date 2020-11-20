Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B5C2D0E4
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DC62240B
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgKTXQR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:16:17 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:46004 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKTXQR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:16:17 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Nov 2020 18:16:16 EST
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdX-002RDz-J2; Fri, 20 Nov 2020 16:16:15 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdW-00EG00-K1; Fri, 20 Nov 2020 16:16:15 -0700
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
Date:   Fri, 20 Nov 2020 17:14:22 -0600
Message-Id: <20201120231441.29911-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdW-00EG00-K1;;;mid=<20201120231441.29911-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Xhwlps+6lJ3cvlbGlrhm0qEn5witM5cY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 05/24] bpf: In bpf_task_fd_query use fget_task
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the helper fget_task to simplify bpf_task_fd_query.

As well as simplifying the code this removes one unnecessary increment of
struct files_struct.  This unnecessary increment of files_struct.count can
result in exec unnecessarily unsharing files_struct and breaking posix
locks, and it can result in fget_light having to fallback to fget reducing
performance.

This simplification comes from the observation that none of the
callers of get_files_struct actually need to call get_files_struct
that was made when discussing[1] exec and posix file locks.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-5-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/bpf/syscall.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8f50c9c19f1b..6d49c2e1634c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3878,7 +3878,6 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	pid_t pid = attr->task_fd_query.pid;
 	u32 fd = attr->task_fd_query.fd;
 	const struct perf_event *event;
-	struct files_struct *files;
 	struct task_struct *task;
 	struct file *file;
 	int err;
@@ -3896,23 +3895,11 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	if (!task)
 		return -ENOENT;
 
-	files = get_files_struct(task);
-	put_task_struct(task);
-	if (!files)
-		return -ENOENT;
-
 	err = 0;
-	spin_lock(&files->file_lock);
-	file = fcheck_files(files, fd);
+	file = fget_task(task, fd);
+	put_task_struct(task);
 	if (!file)
-		err = -EBADF;
-	else
-		get_file(file);
-	spin_unlock(&files->file_lock);
-	put_files_struct(files);
-
-	if (err)
-		goto out;
+		return -EBADF;
 
 	if (file->f_op == &bpf_link_fops) {
 		struct bpf_link *link = file->private_data;
@@ -3952,7 +3939,6 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
 	err = -ENOTSUPP;
 put_file:
 	fput(file);
-out:
 	return err;
 }
 
-- 
2.25.0

