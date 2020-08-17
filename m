Return-Path: <SRS0=Eo6L=B3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C3AC433F4
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D6B20674
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgHQWLu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:11:50 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47158 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgHQWLu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 18:11:50 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nM5-004wA5-4v; Mon, 17 Aug 2020 16:11:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKq-0004PB-Nn; Mon, 17 Aug 2020 16:10:33 -0600
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
Date:   Mon, 17 Aug 2020 17:04:23 -0500
Message-Id: <20200817220425.9389-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKq-0004PB-Nn;;;mid=<20200817220425.9389-15-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+4cpNrHwZELt8oSRiOq1yzCRzmHtQx5rY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 15/17] file: In f_dupfd read RLIMIT_NOFILE once.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Simplify the code, and remove the chance of races by reading
RLIMIT_NOFILE only once in f_dupfd.

Pass the read value of RLIMIT_NOFILE into alloc_fd which is the other
location the rlimit was read in f_dupfd.  As f_dupfd is the only
caller of alloc_fd this changing alloc_fd is trivially safe.

Further this causes alloc_fd to take all of the same arguments as
__alloc_fd except for the files_struct argument.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 1a755811669d..505b2e81ad3e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -523,9 +523,9 @@ int __alloc_fd(struct files_struct *files,
 	return error;
 }
 
-static int alloc_fd(unsigned start, unsigned flags)
+static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 {
-	return __alloc_fd(current->files, start, rlimit(RLIMIT_NOFILE), flags);
+	return __alloc_fd(current->files, start, end, flags);
 }
 
 int __get_unused_fd_flags(unsigned flags, unsigned long nofile)
@@ -1158,10 +1158,11 @@ SYSCALL_DEFINE1(dup, unsigned int, fildes)
 
 int f_dupfd(unsigned int from, struct file *file, unsigned flags)
 {
+	unsigned long nofile = rlimit(RLIMIT_NOFILE);
 	int err;
-	if (from >= rlimit(RLIMIT_NOFILE))
+	if (from >= nofile)
 		return -EINVAL;
-	err = alloc_fd(from, flags);
+	err = alloc_fd(from, nofile, flags);
 	if (err >= 0) {
 		get_file(file);
 		fd_install(err, file);
-- 
2.25.0

