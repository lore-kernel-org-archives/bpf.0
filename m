Return-Path: <SRS0=qOzI=SW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A8BC282DD
	for <bpf@archiver.kernel.org>; Sat, 20 Apr 2019 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495222183F
	for <bpf@archiver.kernel.org>; Sat, 20 Apr 2019 12:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfDTMkh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:40:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38376 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDTMkh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Apr 2019 08:40:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so9129387wmc.3;
        Sat, 20 Apr 2019 05:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ClcVW4nCI1l5GPqid8mIK0QFGmp1UaerpT4ClQAxa6A=;
        b=ITAPC207ERZWMGd9hTtKuj0i+v5RJLawC2xvVe9ddtaDPDxffva22vm4ptW8Quya3K
         zEHD60YG7I3f91DLqrjpatQC9dqZHhFzu9lK25zyETZ6+B51bG5NgpyOJjOzZgdu8Aw6
         gpuIksjoII8hIHCpSPxQW3GF/hzCqC7Yr06meNBuWJQ6eBUj3FiZMMOipjRzgJczyQbo
         cF4pcyLoiIqmkisfPVCtq+QTrHQ6btfHFlx6Xq8+5QUALRpMzY18X57BQGiPXEBdcnr4
         ehaBkbb74S+npWKdephuDg7vGm6W1rC6vk3M5F8729nxiApJdYSVD3o/ibbfxUsjjUuy
         jRgQ==
X-Gm-Message-State: APjAAAVS5sw+BplnK3WHn7MfgmE/rx3+/JPRNqssDLMnNDShJYwfxxtX
        QpYyUGloNqPU4CPbE9WFNI50Aktyawg=
X-Google-Smtp-Source: APXvYqxTIaY4Bi0yFjCed2+2ysWVNVc8k1+sB1DKoCs6TlabOwSD6qEvZTH3ml/HJr18BFZNpKWlgQ==
X-Received: by 2002:a7b:c3d7:: with SMTP id t23mr5803735wmj.62.1555764035672;
        Sat, 20 Apr 2019 05:40:35 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id d4sm7179868wrv.42.2019.04.20.05.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Apr 2019 05:40:35 -0700 (PDT)
Date:   Sat, 20 Apr 2019 14:40:24 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf 2/2] selftests/bpf: test case for pointer null check in
 subprog
Message-ID: <cc1b8cd3588b12701edd5a5177c47b52d27d3090.1555761008.git.paul.chaignon@orange.com>
References: <cover.1555761008.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555761008.git.paul.chaignon@orange.com>
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

