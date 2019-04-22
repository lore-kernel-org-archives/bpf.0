Return-Path: <SRS0=ACyN=SY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0395C10F11
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA40D21738
	for <bpf@archiver.kernel.org>; Mon, 22 Apr 2019 18:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDVSfd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:35:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42500 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfDVSfd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Apr 2019 14:35:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so16787382wrx.9;
        Mon, 22 Apr 2019 11:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ClcVW4nCI1l5GPqid8mIK0QFGmp1UaerpT4ClQAxa6A=;
        b=d/k0SryMRvk+v7NRUNZKHBp8oxaEHBsttFiCXvAl6SeP1bCI/YDY/LnRnSf44+Kypx
         s6+9VAL5gVl7TmMo/uDHEkcM+EdiFTcJpbiytCbOJyqFwXWMfCGhjOb4SMLjEuLYHzov
         bJtu6bceNq/UcJUzF6bdFOqUhzkrTSQtrbtX8lwzbN2bJauH8MyyhWnb8F8EOUv8U6Jn
         Ulv7KcG4SrBvLdsgNENk1w3ojxJkbqxC/uIchhGf/hHfEAKVxRWz6G9RZcTiaNOspFPA
         DPsY4nd/C9m1c7C4xkJeS4d1Cziwv6rq/xbU8g+fmQGeKUu0Hso0IZ9qP7flAx0UiZL3
         /lbA==
X-Gm-Message-State: APjAAAW04PD2oDWpFupO9CSps/SiKPMXvj2mUV0t854Rs3QgbFCbbG0J
        Ovjo7MXLRfyeFxBUYVcW9KM=
X-Google-Smtp-Source: APXvYqy8vEfxkNmbUlRYtW72Cr2s2hPFAeTvFtZfFL7SRshMZ6goWCplxThJdHorCEia77QyS7B7Bw==
X-Received: by 2002:a5d:630d:: with SMTP id i13mr5895797wru.36.1555958131635;
        Mon, 22 Apr 2019 11:35:31 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id p8sm10601953wrx.62.2019.04.22.11.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 11:35:31 -0700 (PDT)
Date:   Mon, 22 Apr 2019 20:35:22 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: test case for pointer null check
 in subprog
Message-ID: <0502713bb8c7480119a85e22d2069688e874b00a.1555957346.git.paul.chaignon@orange.com>
References: <cover.1555957346.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555957346.git.paul.chaignon@orange.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test case is equivalent to the following pseudo-code.  It checks that
the verifier does not complain on line 6 and recognizes that ptr isn't
null.

1: ptr = bpf_map_lookup_elem(map, &key);
2: ret = subprog(ptr) {
3:   return ptr != NULL;
4: }
5: if (ret)
6:   value = *ptr;

Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
---
 tools/testing/selftests/bpf/verifier/calls.c | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index fb11240b758b..9093a8f64dc6 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -374,6 +374,31 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
+{
+	"calls: ptr null check in subprog",
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+	BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 3),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6, 0),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.errstr_unpriv = "function calls to other bpf functions are allowed for root only",
+	.fixup_map_hash_48b = { 3 },
+	.result_unpriv = REJECT,
+	.result = ACCEPT,
+	.retval = 0,
+},
 {
 	"calls: two calls with args",
 	.insns = {
-- 
2.17.1

