Return-Path: <SRS0=/NIo=RH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D8FC43381
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD266206B6
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 15:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfCDP7X (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:59:23 -0500
Received: from www62.your-server.de ([213.133.104.62]:50072 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfCDP7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Mar 2019 10:59:23 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h0pzq-00084x-TQ; Mon, 04 Mar 2019 16:59:18 +0100
Received: from [2a02:1205:34ea:9e0:5681:e3d2:fbd:7e53] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h0pzq-000UTu-NJ; Mon, 04 Mar 2019 16:59:18 +0100
Subject: Re: [PATCH bpf-next v2 1/7] bpf: implement lookup-free direct value
 access
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        john fastabend <john.fastabend@gmail.com>, tgraf@suug.ch,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        lmb@cloudflare.com
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-2-daniel@iogearbox.net>
 <CAEf4BzZr1OQhiXS6+jraq_=HtjhTPvsNqcbizKKQvxPmOgZgXg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3311ac2f-2947-62d7-2be8-dcb4b23c6b5b@iogearbox.net>
Date:   Mon, 4 Mar 2019 16:59:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZr1OQhiXS6+jraq_=HtjhTPvsNqcbizKKQvxPmOgZgXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25378/Mon Mar  4 11:47:26 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/04/2019 07:03 AM, Andrii Nakryiko wrote:
> On Thu, Feb 28, 2019 at 3:31 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
[...]
>> @@ -6664,8 +6669,10 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
>>                 }
>>
>>                 if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
>> +                       struct bpf_insn_aux_data *aux;
>>                         struct bpf_map *map;
>>                         struct fd f;
>> +                       u64 addr;
>>
>>                         if (i == insn_cnt - 1 || insn[1].code != 0 ||
>>                             insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
> 
> Next line after this one rejects ldimm64 instructions with off != 0.
> This check needs to be changed, depending on whether src_reg ==
> BPF_PSEUDO_MAP_VALUE, right?

Yes, that's correct, I already have that changed in my local branch for
supporting non-zero off.

> This is also to the previously discussed question of not enforcing
> offset (imm=0 in 2nd part of insn) for BPF_PSEUDO_MAP_FD. Seems like
> verifier *does* enforce that (not that I'm advocating for re-using
> BPF_PSEUDO_MAP_FD, just stumbled on this bit when going through
> verifier code).

Not really, lets test:

[...]
        .insns = {
        BPF_MOV64_IMM(BPF_REG_0, 0),
        BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_1,
                     BPF_PSEUDO_MAP_FD, 0, 0),
        BPF_RAW_INSN(0, 0, 0, 0, 0xfefefe),
        BPF_EXIT_INSN(),
        },
[...]

#545/p test14 ld_imm64: reject 2nd imm != 0 FAIL
Unexpected success to load!
0: (b7) r0 = 0
1: (18) r1 = 0xffff97e612486400
3: (95) exit
processed 3 insns (limit 131072), stack depth 0
Summary: 0 PASSED, 0 SKIPPED, 2 FAILED

So I still think it would be worth doing something like the below
for bpf:

From 290f739ae6bab7b0709d327855a1812f9022beed Mon Sep 17 00:00:00 2001
From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 4 Mar 2019 14:22:41 +0000
Subject: [PATCH bpf] bpf: fix replace_map_fd_with_map_ptr wrt ldimm64 wrt second imm field

Non-zero imm value in the second part of the ldimm64 instruction for
BPF_PSEUDO_MAP_FD is invalid, and thus must be rejected. The map fd
only ever sits in the first instructions' imm field. None of the BPF
loaders known to us are using it, so risk of regression is minimal.
For clarity and consistency, the few insn->{src_reg,imm} occurences
are rewritten into insn[0].{src_reg,imm}. Add a test case to the BPF
selftest suite as well.

Fixes: 0246e64d9a5f ("bpf: handle pseudo BPF_LD_IMM64 insn")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c                           | 10 +++++-----
 tools/testing/selftests/bpf/verifier/ld_imm64.c | 17 +++++++++++++++--
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0e4edd7e3c5f..c8d2a948db37 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6678,17 +6678,17 @@ static int replace_map_fd_with_map_ptr(struct bpf_verifier_env *env)
 				/* valid generic load 64-bit imm */
 				goto next_insn;

-			if (insn->src_reg != BPF_PSEUDO_MAP_FD) {
-				verbose(env,
-					"unrecognized bpf_ld_imm64 insn\n");
+			if (insn[0].src_reg != BPF_PSEUDO_MAP_FD ||
+			    insn[1].imm != 0) {
+				verbose(env, "unrecognized bpf_ld_imm64 insn\n");
 				return -EINVAL;
 			}

-			f = fdget(insn->imm);
+			f = fdget(insn[0].imm);
 			map = __bpf_map_get(f);
 			if (IS_ERR(map)) {
 				verbose(env, "fd %d is not pointing to valid bpf_map\n",
-					insn->imm);
+					insn[0].imm);
 				return PTR_ERR(map);
 			}

diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
index 28b8c805a293..4a1ff4560a8a 100644
--- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
+++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
@@ -121,8 +121,8 @@
 	"test12 ld_imm64",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_1, 0),
-	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, BPF_REG_1, 0, 1),
-	BPF_RAW_INSN(0, 0, 0, 0, 1),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, BPF_REG_1, 0, 999),
+	BPF_RAW_INSN(0, 0, 0, 0, 0),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "not pointing to valid bpf_map",
@@ -139,3 +139,16 @@
 	.errstr = "invalid bpf_ld_imm64 insn",
 	.result = REJECT,
 },
+{
+	"test14 ld_imm64: reject 2nd imm != 0",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_1,
+		     BPF_PSEUDO_MAP_FD, 0, 0),
+	BPF_RAW_INSN(0, 0, 0, 0, 0xfefefe),
+	BPF_EXIT_INSN(),
+	},
+	.fixup_map_hash_48b = { 1 },
+	.errstr = "unrecognized bpf_ld_imm64 insn",
+	.result = REJECT,
+},
-- 
2.17.1

