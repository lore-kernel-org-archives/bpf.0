Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D6BC282CE
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF0D20674
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfDXTvm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:51:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46202 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDXTvm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 15:51:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so26761757wrw.13;
        Wed, 24 Apr 2019 12:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rh5qhnoAv3yU8a5Sv2ZK94DVmnmXyyn/pnS40rntt88=;
        b=VYoxM8ojCHt/wJqjNxtrkUZu8xkpAF+NZonp37tb8ekgm9rQ+yeSpXqawQKBH3jEZ5
         a42jmX6PS0+Odb6p0rdyilusxjnzcez8vhcvxMGuUYFIiYolAlgRUqkirSv+g85Uu1q9
         OFgRj2KWI4Ot3aDNMIXkIecovy4E1Biptkccvx1XIyR8ZUvaXqyOreSrcbumXkfWJty3
         Ah2C0KoBX1A+/VsCCrd72nIaPsBzcj90KPwD8Hsut1M+L9jhiGf1cUgRWq8McGaIqseM
         3OZtTZuxksW2USjvgSye7aD1iD3Z2vUzAhtTGoSGvZHQs8WbZEEK5wNueOEy7jsQ38iq
         C9Gg==
X-Gm-Message-State: APjAAAVPprUPNuodak0jg2LPVjxPciV2WdbS1hXHyaxBjp542oYFPcaF
        7WIL+86knO/3GrnDHjYd/8g=
X-Google-Smtp-Source: APXvYqz/7/AZrzJEaGCEu6L8IY4P/xQ8E7VkJQMrF9S/fbJKXk2OuDs2CN9U3hj1S+tG5uoXLHfQBA==
X-Received: by 2002:a5d:4a4c:: with SMTP id v12mr6215907wrs.230.1556135500139;
        Wed, 24 Apr 2019 12:51:40 -0700 (PDT)
Received: from Nover ([161.105.209.130])
        by smtp.gmail.com with ESMTPSA id w130sm20570370wma.36.2019.04.24.12.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:51:39 -0700 (PDT)
Date:   Wed, 24 Apr 2019 21:51:26 +0200
From:   Paul Chaignon <paul.chaignon@orange.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Xiao Han <xiao.han@orange.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: test cases for pkt/null checks in
 subprogs
Message-ID: <54d4081b9c5db7318feb180df13b7689a09128f8.1556127906.git.paul.chaignon@orange.com>
References: <cover.1556127905.git.paul.chaignon@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556127905.git.paul.chaignon@orange.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The first test case, for pointer null checks, is equivalent to the
following pseudo-code.  It checks that the verifier does not complain on
line 6 and recognizes that ptr isn't null.

1: ptr = bpf_map_lookup_elem(map, &key);
2: ret = subprog(ptr) {
3:   return ptr != NULL;
4: }
5: if (ret)
6:   value = *ptr;

The second test case, for packet bound checks, is equivalent to the
following pseudo-code.  It checks that the verifier does not complain on
line 7 and recognizes that the packet is at least 1 byte long.

1: pkt_end = ctx.pkt_end;
2: ptr = ctx.pkt + 8;
3: ret = subprog(ptr, pkt_end) {
4:   return ptr <= pkt_end;
5: }
6: if (ret)
7:   value = *(u8 *)ctx.pkt;

Signed-off-by: Paul Chaignon <paul.chaignon@orange.com>
---
 tools/testing/selftests/bpf/verifier/calls.c  | 25 +++++++++++++++++++
 .../bpf/verifier/direct_packet_access.c       | 22 ++++++++++++++++
 2 files changed, 47 insertions(+)

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
diff --git a/tools/testing/selftests/bpf/verifier/direct_packet_access.c b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
index e3fc22e672c2..d5c596fdc4b9 100644
--- a/tools/testing/selftests/bpf/verifier/direct_packet_access.c
+++ b/tools/testing/selftests/bpf/verifier/direct_packet_access.c
@@ -631,3 +631,25 @@
 	.errstr = "invalid access to packet",
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 },
+{
+	"direct packet access: test29 (reg > pkt_end in subprog)",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_6),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 8),
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 4),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+	BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_JMP_REG(BPF_JGT, BPF_REG_3, BPF_REG_2, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 1),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
-- 
2.17.1

