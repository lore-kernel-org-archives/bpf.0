Return-Path: <SRS0=US5c=RX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF4FC43381
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C36D2146E
	for <bpf@archiver.kernel.org>; Wed, 20 Mar 2019 12:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfCTM6u (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:58:50 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:32987 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTM6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 08:58:49 -0400
Received: by mail-wr1-f43.google.com with SMTP id q1so2685223wrp.0;
        Wed, 20 Mar 2019 05:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=79AkYrKvo1FceDNlSsZ2AQc2HPuh0PWsBDVU4GCKu4I=;
        b=P40I+1RFjPIGs/kLSOiTPDxZKnfeBOsrmC1Ln6iH1SxnXZ/CVyX3AX32uCxkJ3lq85
         0TAvWzbQuREgzSXNaWs0CaM0lwxUhydcAH3TKgz8MNxCG4fLK9OVopJBsRTDpnsX8JEz
         ZloJqfSk6fHtWk7MO41oxuVTammN2lcU4j4nDGXghUR2XF6OTzqukrVdIQFhbeOCXLtG
         RDoVERMjJbK4T09xxRr1qOK1zy1NcvSxUgwtWTpKIh9qBxe7Mge3Ct4d5aVke0f+3DCq
         zNqf7s308T1vpqERh6vth24uWjptQnCLF9QvhcrziWG/IfKYxaWERvJfZfnNcJLEiLwm
         y2Aw==
X-Gm-Message-State: APjAAAWHFRTpMA2cHFIZD8m/9QG/hk17GCMIZHBmPl49g5hDWh68blmA
        BB4sW2ULTI4g3ghRgjLgLPY=
X-Google-Smtp-Source: APXvYqzlKqp6AV8/kI1bnV7bnGYJVrQ7ewRx44BKhn9rEuPL0DrWKb/cpK12CYQoqbhydJQZeyJVsw==
X-Received: by 2002:adf:f088:: with SMTP id n8mr20034620wro.112.1553086727817;
        Wed, 20 Mar 2019 05:58:47 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id w12sm2621917wrt.97.2019.03.20.05.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 05:58:47 -0700 (PDT)
Date:   Wed, 20 Mar 2019 13:58:50 +0100
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     xiao.han@orange.com, paul.chaignon@gmail.com,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: test case for invalid call stack
 in dead code
Message-ID: <ea79f2c1e155346b1ff09b046de5c74b576aaa3a.1553085539.git.paul.chaignon@orange.com>
References: <cover.1553085539.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553085539.git.paul.chaignon@orange.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a test case with an excessive number of call stack frames
in dead code.

Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
Tested-by: Xiao Han <xiao.han@orange.com>
---
 tools/testing/selftests/bpf/verifier/calls.c | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 4004891afa9c..ff147fcda82b 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -907,6 +907,44 @@
 	.errstr = "call stack",
 	.result = REJECT,
 },
+{
+	"calls: stack depth check in dead code",
+	.insns = {
+	/* main */
+	BPF_MOV64_IMM(BPF_REG_1, 0),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call A */
+	BPF_EXIT_INSN(),
+	/* A */
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 2), /* call B */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* B */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call C */
+	BPF_EXIT_INSN(),
+	/* C */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call D */
+	BPF_EXIT_INSN(),
+	/* D */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call E */
+	BPF_EXIT_INSN(),
+	/* E */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call F */
+	BPF_EXIT_INSN(),
+	/* F */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call G */
+	BPF_EXIT_INSN(),
+	/* G */
+	BPF_RAW_INSN(BPF_JMP|BPF_CALL, 0, 1, 0, 1), /* call H */
+	BPF_EXIT_INSN(),
+	/* H */
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.errstr = "call stack",
+	.result = REJECT,
+},
 {
 	"calls: spill into caller stack frame",
 	.insns = {
-- 
2.17.1

