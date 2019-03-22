Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F6EC10F00
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4183F21902
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="vPEgK/ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfCVByo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:54:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46728 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfCVByn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 21:54:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so364010pfj.13
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 18:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxEbRfduSc+AGv0GejYc8Zor9ObdlMKkIW/U80dwh2k=;
        b=vPEgK/ns8MhiofwF4lNymgaVfFr0c8RtNcZspWyzw4m7cc4tT2k3XvoROWlQoxQQ4H
         axCB5DYZfXHkeRTNsi2xwBsXWzX6/89fsDzH663I47JKRGbxzN5w3yiKXRwS2wDCRoTm
         nqDEA2hzHSgb/b81hwRcpVbZjz+yfLIhrIZbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxEbRfduSc+AGv0GejYc8Zor9ObdlMKkIW/U80dwh2k=;
        b=SpS6VZ5DgM+hpr2qyGv5dRGvEUwbtUg5qdXLaHQiEARrMsHlT8wwoKQfLEGjp7ddOZ
         FIk8BCzm7tcGGvWYL8PM4izeDz9/SGUAcOtImrPkU55PEEQyIh+KpAxOXCRiEcIArfI+
         DBK54uhrjdbAVvKGj2rGCyGlSre9q2jPHOjy/IsDtDIiT48ohF3ss1/x7PqUgzraJNCz
         REal+kroKyNlkt6cbVgG18TFGSFdh0J1WOUNJHkDHGPTatA17sAjxWLOOdVvVmsADbR6
         skFJiTHqs4hh+TMb7xfdMbMnk6wMwDgZSJtQW0F6/wyA8djFKlwPVGHu9CFW/hUtQHRh
         pqYg==
X-Gm-Message-State: APjAAAUvH9aZyToRaRrIiOLziIfahULz73FM3AkODgeJNL69FQqvBzPx
        HAJg3x1z2t6IcM7CyvXLDRUiXA==
X-Google-Smtp-Source: APXvYqxgbJut7kJPgDYEW4lZSYbTf+t3zFnEMd2LIZCDjP8GuxvO0oB2qwACACLXrV1i36EvLvDPUw==
X-Received: by 2002:a17:902:9683:: with SMTP id n3mr6908046plp.333.1553219681881;
        Thu, 21 Mar 2019 18:54:41 -0700 (PDT)
Received: from localhost.localdomain ([157.120.241.186])
        by smtp.gmail.com with ESMTPSA id i10sm7161799pgs.26.2019.03.21.18.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:54:41 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 7/8] selftests/bpf: test references to sock_common
Date:   Fri, 22 Mar 2019 09:54:05 +0800
Message-Id: <20190322015406.26453-8-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190322015406.26453-1-lmb@cloudflare.com>
References: <20190319102103.7380-1-lmb@cloudflare.com>
 <20190322015406.26453-1-lmb@cloudflare.com>
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

