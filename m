Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE17C2D0E4
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D0A2240C
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgKTXUU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:20:20 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:47022 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbgKTXUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:20:00 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFh9-002RbQ-B6; Fri, 20 Nov 2020 16:19:59 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFeN-00EG00-Df; Fri, 20 Nov 2020 16:17:07 -0700
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
Date:   Fri, 20 Nov 2020 17:14:37 -0600
Message-Id: <20201120231441.29911-20-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFeN-00EG00-Df;;;mid=<20201120231441.29911-20-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/hX9lwaOnMXrM0YEb54E/d3ReYkLxNKoQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 20/24] file: Merge __alloc_fd into alloc_fd
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function __alloc_fd was added to support binder[1].  With binder
fixed[2] there are no more users.

As alloc_fd just calls __alloc_fd with "files=current->files",
merge them together by transforming the files parameter into a
local variable initialized to current->files.

[1] dcfadfa4ec5a ("new helper: __alloc_fd()")
[2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
v1: https://lkml.kernel.org/r/20200817220425.9389-16-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 11 +++--------
 include/linux/fdtable.h |  2 --
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 07e25f1b9dfd..621563701bd9 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -480,9 +480,9 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 /*
  * allocate a file descriptor, mark it busy.
  */
-int __alloc_fd(struct files_struct *files,
-	       unsigned start, unsigned end, unsigned flags)
+static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 {
+	struct files_struct *files = current->files;
 	unsigned int fd;
 	int error;
 	struct fdtable *fdt;
@@ -538,14 +538,9 @@ int __alloc_fd(struct files_struct *files,
 	return error;
 }
 
-static int alloc_fd(unsigned start, unsigned end, unsigned flags)
-{
-	return __alloc_fd(current->files, start, end, flags);
-}
-
 int __get_unused_fd_flags(unsigned flags, unsigned long nofile)
 {
-	return __alloc_fd(current->files, 0, nofile, flags);
+	return alloc_fd(0, nofile, flags);
 }
 
 int get_unused_fd_flags(unsigned flags)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index a5ec736d74a5..dc476ae92f56 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -124,8 +124,6 @@ int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
 
-extern int __alloc_fd(struct files_struct *files,
-		      unsigned start, unsigned end, unsigned flags);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-- 
2.25.0

