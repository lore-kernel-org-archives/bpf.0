Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EEAC4360F
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72863217F5
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bH3QFuFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfCNLky (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:40:54 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38702 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfCNLkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 07:40:45 -0400
Received: by mail-wm1-f53.google.com with SMTP id a188so2342137wmf.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 04:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxEbRfduSc+AGv0GejYc8Zor9ObdlMKkIW/U80dwh2k=;
        b=bH3QFuFDXoiV1Z1Fh2l9/3IK2InQ35gLzWp0AQte/dKTKXA2MYCcsrc9TozONUezqs
         tcF3L4KmQhonsk8RfdulmdyzLLLlHJvLjfz8dssAWqNyFv9z2zSSy2U1UUwIm54rpYay
         kb63VnolM/Lm0NtDZmbBJvk6rRyVfY3Pc11TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxEbRfduSc+AGv0GejYc8Zor9ObdlMKkIW/U80dwh2k=;
        b=sM66KuEUd9gh3Hp0pIAqhiux/Yjj6OXjsIMmRSc1cyLeItwLlKHpfHMjM1BI6O3DZ8
         v2CtwwMu1qcdb182xtuPuc9bjmiOHWDPbF6mk55JyySHvOoZDxuCZ/WxRXIxQwK3R/ER
         QJs0BiCTfPXATkKp4EVJrf+TcI+yHQB3RQx9Kb3CIPPTzBy8z5E4LCFD7blM9HkcWyaF
         HwpYv+81r+/VbJpOSKYiy5wUCcl8qShMKJq5dLpGOC3X+JUfDPd2wtkp8Lst1ckw+2Rl
         m1c7E6bZRevLYmuZ4c9GY6fwSQ5ECZyZjMXoXi7+m7tnedqbeFxTKWSneqhnCBXgNz2h
         OfAw==
X-Gm-Message-State: APjAAAUi/nSdjikMriEjUtwKXtfrIn3XloFVu/egxJ63wmRrSqCT5tMD
        r5jzbuAU/+KoshW8z2GY/ovpmw==
X-Google-Smtp-Source: APXvYqzo5ud2BQbntcijl1KxbRwHWf1mcr61z8M2I4fGDAazlQLP9bgPOVlUYoQKMiwo+yTX9tlRng==
X-Received: by 2002:a1c:7a07:: with SMTP id v7mr2162997wmc.30.1552563643887;
        Thu, 14 Mar 2019 04:40:43 -0700 (PDT)
Received: from antares.lan (5.8.9.5.4.5.2.4.f.f.6.d.4.1.5.8.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:8514:d6ff:4254:5985])
        by smtp.gmail.com with ESMTPSA id a9sm1804017wmb.30.2019.03.14.04.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:40:42 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, theojulienne@github.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 7/8] selftests/bpf: test references to sock_common
Date:   Thu, 14 Mar 2019 11:39:53 +0000
Message-Id: <20190314113954.10210-8-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314113954.10210-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190314113954.10210-1-lmb@cloudflare.com>
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

