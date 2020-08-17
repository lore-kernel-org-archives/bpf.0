Return-Path: <SRS0=Eo6L=B3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9CEC433E1
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207A820758
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgHQWJ6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:09:58 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:32902 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730109AbgHQWJs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 18:09:48 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nK6-001Gxa-RI; Mon, 17 Aug 2020 16:09:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nK6-0004PB-4C; Mon, 17 Aug 2020 16:09:46 -0600
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
Date:   Mon, 17 Aug 2020 17:04:12 -0500
Message-Id: <20200817220425.9389-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nK6-0004PB-4C;;;mid=<20200817220425.9389-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Nzbhdhel0ydRCsizgoz48WncZtpCAk0g=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 04/17] kcmp: In kcmp_epoll_target use fget_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the helper fget_task and simplify the code.

As well as simplifying the code this removes one unnecessary increment of
struct files_struct.  This unnecessary increment of files_struct.count can
result in exec unnecessarily unsharing files_struct and breaking posix
locks, and it can result in fget_light having to fallback to fget reducing
performance.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/kcmp.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index b3ff9288c6cc..87c48c0104ad 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -107,7 +107,6 @@ static int kcmp_epoll_target(struct task_struct *task1,
 {
 	struct file *filp, *filp_epoll, *filp_tgt;
 	struct kcmp_epoll_slot slot;
-	struct files_struct *files;
 
 	if (copy_from_user(&slot, uslot, sizeof(slot)))
 		return -EFAULT;
@@ -116,23 +115,12 @@ static int kcmp_epoll_target(struct task_struct *task1,
 	if (!filp)
 		return -EBADF;
 
-	files = get_files_struct(task2);
-	if (!files)
+	filp_epoll = fget_task(task2, slot.efd);
+	if (!filp_epoll)
 		return -EBADF;
 
-	spin_lock(&files->file_lock);
-	filp_epoll = fcheck_files(files, slot.efd);
-	if (filp_epoll)
-		get_file(filp_epoll);
-	else
-		filp_tgt = ERR_PTR(-EBADF);
-	spin_unlock(&files->file_lock);
-	put_files_struct(files);
-
-	if (filp_epoll) {
-		filp_tgt = get_epoll_tfile_raw_ptr(filp_epoll, slot.tfd, slot.toff);
-		fput(filp_epoll);
-	}
+	filp_tgt = get_epoll_tfile_raw_ptr(filp_epoll, slot.tfd, slot.toff);
+	fput(filp_epoll);
 
 	if (IS_ERR(filp_tgt))
 		return PTR_ERR(filp_tgt);
-- 
2.25.0

