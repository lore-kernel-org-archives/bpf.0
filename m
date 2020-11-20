Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259AEC83012
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CA62242A
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgKTXUU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:20:20 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:46984 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgKTXUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:20:00 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh8-002RbD-NX; Fri, 20 Nov 2020 16:19:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdy-00EG00-Lx; Fri, 20 Nov 2020 16:16:43 -0700
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
Date:   Fri, 20 Nov 2020 17:14:30 -0600
Message-Id: <20201120231441.29911-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdy-00EG00-Lx;;;mid=<20201120231441.29911-13-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194cx44q+KvkyQRjsxLSGAq1iGzNebFjbg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 13/24] kcmp: In get_file_raw_ptr use task_lookup_fd_rcu
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Modify get_file_raw_ptr to use task_lookup_fd_rcu.  The helper
task_lookup_fd_rcu does the work of taking the task lock and verifying
that task->files != NULL and then calls files_lookup_fd_rcu.  So let
use the helper to make a simpler implementation of get_file_raw_ptr.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/kcmp.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 990717c1aed3..36e58eb5a11d 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -61,16 +61,11 @@ static int kcmp_ptr(void *v1, void *v2, enum kcmp_type type)
 static struct file *
 get_file_raw_ptr(struct task_struct *task, unsigned int idx)
 {
-	struct file *file = NULL;
+	struct file *file;
 
-	task_lock(task);
 	rcu_read_lock();
-
-	if (task->files)
-		file = files_lookup_fd_rcu(task->files, idx);
-
+	file = task_lookup_fd_rcu(task, idx);
 	rcu_read_unlock();
-	task_unlock(task);
 
 	return file;
 }
-- 
2.25.0

