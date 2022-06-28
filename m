Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3A6CCA47E
	for <bpf@archiver.kernel.org>; Tue, 28 Jun 2022 16:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348198AbiF1QCj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348286AbiF1QCY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 12:02:24 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499A9B85
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 09:01:45 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 7276524010F
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 18:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656432103; bh=99zNdqlo8R46wTYQGC58/P3RDaRr+yek5vt1JniASgA=;
        h=From:To:Cc:Subject:Date:From;
        b=jcPF9PzR4zWU+0B5NPwY3fKhgI7SsR9Zxd1wwRADA9+XfNaXrDB493PNuLI6m1fUK
         WdMKESvLhaZS6bcCphwvi4hLHPEL3PkyYhdXuhFy51mOCMsbzXRn1+lxv4O60uMItS
         /FYaTX8SXNIOU9fSuOAcXB79tjmgvdRLh9ZUzi6WGNYWbhZmzlOvg+O6pH14dK1rQH
         t6gQA5oNh93YcR4kymDqRnFgG0McVoYxsImbyMczzp9wzfuOni+R0ew+EKc7Ce7ptp
         QkZSJFw4Q/czQr/WerBvVzADYRuOX/+IENOGhr6RWaOM7Q+X7DeB+AQcDEMyLVEtXJ
         yD9hiOR+RQk8Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LXTqV32wjz6tm4;
        Tue, 28 Jun 2022 18:01:42 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     joannelkoong@gmail.com
Subject: [PATCH bpf-next v3 01/10] bpf: Introduce TYPE_MATCH related constants/macros
Date:   Tue, 28 Jun 2022 16:01:18 +0000
Message-Id: <20220628160127.607834-2-deso@posteo.net>
In-Reply-To: <20220628160127.607834-1-deso@posteo.net>
References: <20220628160127.607834-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to provide type match support we require a new type of
relocation which, in turn, requires toolchain support. Recent LLVM/Clang
versions support a new value for the last argument to the
__builtin_preserve_type_info builtin, for example.
With this change we introduce the necessary constants into relevant
header files, mirroring what the compiler may support.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 include/uapi/linux/bpf.h       | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 tools/lib/bpf/bpf_core_read.h  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e81362..42605c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6782,6 +6782,7 @@ enum bpf_core_relo_kind {
 	BPF_CORE_TYPE_SIZE = 9,              /* type size in bytes */
 	BPF_CORE_ENUMVAL_EXISTS = 10,        /* enum value existence in target kernel */
 	BPF_CORE_ENUMVAL_VALUE = 11,         /* enum value integer value */
+	BPF_CORE_TYPE_MATCHES = 12,          /* type match in target kernel */
 };
 
 /*
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e81362..42605c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6782,6 +6782,7 @@ enum bpf_core_relo_kind {
 	BPF_CORE_TYPE_SIZE = 9,              /* type size in bytes */
 	BPF_CORE_ENUMVAL_EXISTS = 10,        /* enum value existence in target kernel */
 	BPF_CORE_ENUMVAL_VALUE = 11,         /* enum value integer value */
+	BPF_CORE_TYPE_MATCHES = 12,          /* type match in target kernel */
 };
 
 /*
diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index fd48b1..2308f49 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -29,6 +29,7 @@ enum bpf_type_id_kind {
 enum bpf_type_info_kind {
 	BPF_TYPE_EXISTS = 0,		/* type existence in target kernel */
 	BPF_TYPE_SIZE = 1,		/* type size in target kernel */
+	BPF_TYPE_MATCHES = 2,		/* type match in target kernel */
 };
 
 /* second argument to __builtin_preserve_enum_value() built-in */
-- 
2.30.2

