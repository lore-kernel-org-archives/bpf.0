Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952BFC71155
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A1D2242A
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 23:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgKTXQY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:16:24 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:48200 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgKTXQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:16:23 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFde-006XcK-FR; Fri, 20 Nov 2020 16:16:22 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFdd-00EG00-Cj; Fri, 20 Nov 2020 16:16:21 -0700
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
Date:   Fri, 20 Nov 2020 17:14:24 -0600
Message-Id: <20201120231441.29911-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87r1on1v62.fsf@x220.int.ebiederm.org>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1kgFdd-00EG00-Cj;;;mid=<20201120231441.29911-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19gFZpO2kzio9Bgb51WV6i/yMyxVgnYUHc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v2 07/24] file: Rename __fcheck_files to files_lookup_fd_raw
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The function fcheck despite it's comment is poorly named
as it has no callers that only check it's return value.
All of fcheck's callers use the returned file descriptor.
The same is true for fcheck_files and __fcheck_files.

A new less confusing name is needed.  In addition the names
of these functions are confusing as they do not report
the kind of locks that are needed to be held when these
functions are called making error prone to use them.

To remedy this I am making the base functio name lookup_fd
and will and prefixes and sufficies to indicate the rest
of the context.

Name the function (previously called __fcheck_files) that proceeds
from a struct files_struct, looks up the struct file of a file
descriptor, and requires it's callers to verify all of the appropriate
locks are held files_lookup_fd_raw.

The need for better names became apparent in the last round of
discussion of this set of changes[1].

[1] https://lkml.kernel.org/r/CAHk-=wj8BQbgJFLa+J0e=iT-1qpmCRTbPAJ8gd6MJQ=kbRPqyQ@mail.gmail.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/file.c               | 2 +-
 include/linux/fdtable.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index beae7c55c84c..b5591efb87f5 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -887,7 +887,7 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 	struct file *file;
 
 	if (atomic_read(&files->count) == 1) {
-		file = __fcheck_files(files, fd);
+		file = files_lookup_fd_raw(files, fd);
 		if (!file || unlikely(file->f_mode & mask))
 			return 0;
 		return (unsigned long)file;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 7cc9885044d9..639933f37da9 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -80,7 +80,7 @@ struct dentry;
 /*
  * The caller must ensure that fd table isn't shared or hold rcu or file lock
  */
-static inline struct file *__fcheck_files(struct files_struct *files, unsigned int fd)
+static inline struct file *files_lookup_fd_raw(struct files_struct *files, unsigned int fd)
 {
 	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
 
@@ -96,7 +96,7 @@ static inline struct file *fcheck_files(struct files_struct *files, unsigned int
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&
 			   !lockdep_is_held(&files->file_lock),
 			   "suspicious rcu_dereference_check() usage");
-	return __fcheck_files(files, fd);
+	return files_lookup_fd_raw(files, fd);
 }
 
 /*
-- 
2.25.0

