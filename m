Return-Path: <SRS0=Eo6L=B3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98944C433F1
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F79A2063A
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgHQWKi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:10:38 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33104 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbgHQWKK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 18:10:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKS-001H0V-Pl; Mon, 17 Aug 2020 16:10:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKS-0004PB-0O; Mon, 17 Aug 2020 16:10:08 -0600
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
Date:   Mon, 17 Aug 2020 17:04:17 -0500
Message-Id: <20200817220425.9389-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKS-0004PB-0O;;;mid=<20200817220425.9389-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18XoryakreQpr9Brl3/jR/BCv6ZPxl9B9A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 09/17] file: Implement fnext_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As a companion to fget_task and fcheck_task implement fnext_task that
will return the struct file for the first file descriptor show number
is equal or greater than the fd argument value, or NULL if there is
no such struct file.

This allows file descriptors of foreign processes to be iterated through
safely, without needed to increment the count on files_struct.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 21 +++++++++++++++++++++
 include/linux/fdtable.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 8d4b385055e9..88f9f78869f8 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -876,6 +876,27 @@ struct file *fcheck_task(struct task_struct *task, unsigned int fd)
 	return file;
 }
 
+struct file *fnext_task(struct task_struct *task, unsigned int *ret_fd)
+{
+	/* Must be called with rcu_read_lock held */
+	struct files_struct *files;
+	unsigned int fd = *ret_fd;
+	struct file *file = NULL;
+
+	task_lock(task);
+	files = task->files;
+	if (files) {
+		for (; fd < files_fdtable(files)->max_fds; fd++) {
+			file = fcheck_files(files, fd);
+			if (file)
+				break;
+		}
+	}
+	task_unlock(task);
+	*ret_fd = fd;
+	return file;
+}
+
 /*
  * Lightweight file lookup - no refcnt increment if fd table isn't shared.
  *
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index def9debd2ce2..a3a054084f49 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -104,6 +104,7 @@ static inline struct file *fcheck_files(struct files_struct *files, unsigned int
  */
 #define fcheck(fd)	fcheck_files(current->files, fd)
 struct file *fcheck_task(struct task_struct *task, unsigned int fd);
+struct file *fnext_task(struct task_struct *task, unsigned int *fd);
 
 struct task_struct;
 
-- 
2.25.0

