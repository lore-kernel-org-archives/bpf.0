Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEDDC71156
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D051122470
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgKTXUO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:20:14 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36008 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgKTXUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:20:03 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFhB-006UZ1-ND; Fri, 20 Nov 2020 16:20:01 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdv-00EG00-Bh; Fri, 20 Nov 2020 16:16:39 -0700
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
Date:   Fri, 20 Nov 2020 17:14:29 -0600
Message-Id: <20201120231441.29911-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdv-00EG00-Bh;;;mid=<20201120231441.29911-12-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ToDHw4ikimbGSvYMEodDbQxjX7BmZcnc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 12/24] proc/fd: In tid_fd_mode use task_lookup_fd_rcu
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

Instead of manually coding finding the files struct for a task and
then calling files_lookup_fd_rcu, use the helper task_lookup_fd_rcu
that combines those to steps.   Making the code simpler and removing
the need to get a reference on a files_struct.

[1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-7-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/proc/fd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 3dec44d7c5c5..c1a984f3c4df 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -83,18 +83,13 @@ static const struct file_operations proc_fdinfo_file_operations = {
 
 static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
 {
-	struct files_struct *files = get_files_struct(task);
 	struct file *file;
 
-	if (!files)
-		return false;
-
 	rcu_read_lock();
-	file = files_lookup_fd_rcu(files, fd);
+	file = task_lookup_fd_rcu(task, fd);
 	if (file)
 		*mode = file->f_mode;
 	rcu_read_unlock();
-	put_files_struct(files);
 	return !!file;
 }
 
-- 
2.25.0

