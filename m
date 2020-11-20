Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6055CC64EBC
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177B42240C
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgKTXQV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:16:21 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:33568 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgKTXQU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:16:20 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdb-006TpF-0e; Fri, 20 Nov 2020 16:16:19 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdZ-00EG00-Uv; Fri, 20 Nov 2020 16:16:18 -0700
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
Date:   Fri, 20 Nov 2020 17:14:23 -0600
Message-Id: <20201120231441.29911-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdZ-00EG00-Uv;;;mid=<20201120231441.29911-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19C41iZMJEug1eAQ9SvOh64q2n0pWvaffg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 06/24] proc/fd: In proc_fd_link use fget_task
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

Simplifying proc_fd_link is a little bit tricky.  It is necessary to
know that there is a reference to fd_f	 ile while path_get is running.
This reference can either be guaranteed to exist either by locking the
fdtable as the code currently does or by taking a reference on the
file in question.

Use fget_task to remove the need for get_files_struct and
to take a reference to file in question.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-8-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/fd.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..d58960f6ee52 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -146,29 +146,22 @@ static const struct dentry_operations tid_fd_dentry_operations = {
 
 static int proc_fd_link(struct dentry *dentry, struct path *path)
 {
-	struct files_struct *files = NULL;
 	struct task_struct *task;
 	int ret = -ENOENT;
 
 	task = get_proc_task(d_inode(dentry));
 	if (task) {
-		files = get_files_struct(task);
-		put_task_struct(task);
-	}
-
-	if (files) {
 		unsigned int fd = proc_fd(d_inode(dentry));
 		struct file *fd_file;
 
-		spin_lock(&files->file_lock);
-		fd_file = fcheck_files(files, fd);
+		fd_file = fget_task(task, fd);
 		if (fd_file) {
 			*path = fd_file->f_path;
 			path_get(&fd_file->f_path);
 			ret = 0;
+			fput(fd_file);
 		}
-		spin_unlock(&files->file_lock);
-		put_files_struct(files);
+		put_task_struct(task);
 	}
 
 	return ret;
-- 
2.25.0

