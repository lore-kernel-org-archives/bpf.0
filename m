Return-Path: <SRS0=Eo6L=B3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F1CC433DF
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AD42063A
	for <bpf@archiver.kernel.org>; Mon, 17 Aug 2020 22:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgHQWM4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:12:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60738 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbgHQWLw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 18:11:52 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nM6-001r3z-LL; Mon, 17 Aug 2020 16:11:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k7nKu-0004PB-RU; Mon, 17 Aug 2020 16:10:37 -0600
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
Date:   Mon, 17 Aug 2020 17:04:24 -0500
Message-Id: <20200817220425.9389-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1k7nKu-0004PB-RU;;;mid=<20200817220425.9389-16-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0S5jwtFNklOV06k8NI64kO/U96GXuYSw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 16/17] file: Merge __alloc_fd into alloc_fd
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function __alloc_fd was added to support binder[1].  With binder
fixed[2] there are no more users.  Further with get_files_struct
removed there can be no more users of __alloc_fd that pass anything
except current->files.

As alloc_fd just calls __alloc_fd with "files=current->files",
merge them together by transforming the files parameter into a
ocal variable initialized to current->files.

[1] dcfadfa4ec5a ("new helper: __alloc_fd()")
[2] 44d8047f1d87 ("binder: use standard functions to allocate fds")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 11 +++--------
 include/linux/fdtable.h |  2 --
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 505b2e81ad3e..221fc4f97f61 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -465,9 +465,9 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
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
@@ -523,14 +523,9 @@ int __alloc_fd(struct files_struct *files,
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
index 4da8aacc461a..d8f6c4921d85 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -116,8 +116,6 @@ int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
 
-extern int __alloc_fd(struct files_struct *files,
-		      unsigned start, unsigned end, unsigned flags);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
-- 
2.25.0

