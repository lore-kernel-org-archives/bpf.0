Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE078C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF6B20828
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="f8uNzOG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCSKVi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:21:38 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38108 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfCSKVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 06:21:36 -0400
Received: by mail-wm1-f48.google.com with SMTP id a188so15771945wmf.3
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 03:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxEbRfduSc+AGv0GejYc8Zor9ObdlMKkIW/U80dwh2k=;
        b=f8uNzOG0bje/2lA+at3/fZ1E6jJOvQ+V6I+a29mJxcNRAS6b+ZzS0OK6Lu+Q3iK9Wr
         QdT7tJyG9q2CmwatRRmq0nDMnb1lpaRhmUnRI5QWmaxcsJozNqAlZ7uwSuKqKT/dBzon
         SQaveWwLDYnuqU4fMmTcBSOgIEx+cUF8iTAeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxEbRfduSc+AGv0GejYc8Zor9ObdlMKkIW/U80dwh2k=;
        b=kdZ3ykuYopCZU9loyqJKEFtU2SP6GDFFg462hLnVtmFOCgAMRAvtecrMthZMzDYIeO
         B62bNCUUMfa8jQCswAmfwQVxCf36s2+6UuKoRgX4JBNp5KhPb18bGY5KYbYKecGtMI33
         6j4XMHjX5APrnNDSmd94M9AT8bEe3VsrdCKq1KbF1XWD2YQ3xT3f/ARCyE0CC7CLR1Rp
         RdxH13Brnb4DaD83YP/5bnFg8+K7eDdGUHqUjZAIfXI6Bl5Y7axdRtYjM7/q2UfWHdMx
         mJno2eIEdxCUC55+nRtQL/SpJei1ijcOk2ZKOMcYwXqnyl1dIopYZ9NrMOuT3v8ZRupC
         cHwA==
X-Gm-Message-State: APjAAAWdh0JhIAVF8kuZOVlkdceZSvS4TTQ3XJk3pAiVPYpkpnYi84tA
        3p95hFVPLzf/oj2pRd7UDXX7lQ==
X-Google-Smtp-Source: APXvYqyBG5yQm3DWVT/F2LuAqmcocDDnRU3SC221zmRabV7F61YiEwPaUjqPFgxc5N0b4Pc3R/mvsA==
X-Received: by 2002:a1c:f102:: with SMTP id p2mr3003073wmh.36.1552990894751;
        Tue, 19 Mar 2019 03:21:34 -0700 (PDT)
Received: from localhost.localdomain ([217.138.62.245])
        by smtp.gmail.com with ESMTPSA id q2sm27895781wrd.46.2019.03.19.03.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:21:34 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 7/8] selftests/bpf: test references to sock_common
Date:   Tue, 19 Mar 2019 10:21:02 +0000
Message-Id: <20190319102103.7380-8-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190319102103.7380-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190319102103.7380-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure that returning a struct sock_common * reference invokes
the reference tracking machinery in the verifier.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/verifier/ref_tracking.c     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index a6905e5017dc..ebcbf154c460 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -9,6 +9,17 @@
 	.errstr = "Unreleased reference",
 	.result = REJECT,
 },
+{
+	"reference tracking: leak potential reference to sock_common",
+	.insns = {
+	BPF_SK_LOOKUP(skc_lookup_tcp),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0), /* leak reference */
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.errstr = "Unreleased reference",
+	.result = REJECT,
+},
 {
 	"reference tracking: leak potential reference on stack",
 	.insns = {
@@ -49,6 +60,17 @@
 	.errstr = "Unreleased reference",
 	.result = REJECT,
 },
+{
+	"reference tracking: zero potential reference to sock_common",
+	.insns = {
+	BPF_SK_LOOKUP(skc_lookup_tcp),
+	BPF_MOV64_IMM(BPF_REG_0, 0), /* leak reference */
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.errstr = "Unreleased reference",
+	.result = REJECT,
+},
 {
 	"reference tracking: copy and zero potential references",
 	.insns = {
@@ -76,6 +98,20 @@
 	.errstr = "type=sock_or_null expected=sock",
 	.result = REJECT,
 },
+{
+	"reference tracking: release reference to sock_common without check",
+	.insns = {
+	BPF_SK_LOOKUP(skc_lookup_tcp),
+	/* reference in r0 may be NULL */
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_MOV64_IMM(BPF_REG_2, 0),
+	BPF_EMIT_CALL(BPF_FUNC_sk_release),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.errstr = "type=sock_common_or_null expected=sock",
+	.result = REJECT,
+},
 {
 	"reference tracking: release reference",
 	.insns = {
@@ -88,6 +124,18 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = ACCEPT,
 },
+{
+	"reference tracking: release reference to sock_common",
+	.insns = {
+	BPF_SK_LOOKUP(skc_lookup_tcp),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_EMIT_CALL(BPF_FUNC_sk_release),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.result = ACCEPT,
+},
 {
 	"reference tracking: release reference 2",
 	.insns = {
-- 
2.19.1

