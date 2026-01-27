Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05D334C27;
	Tue, 27 Jan 2026 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515845; cv=none; b=CV0T78LlAu8N6OBXzeq19m4YZzS8yIjXLCP0SzrQCwX9z+3qY7Dzf/1Aw4dt0s460ax9YGPKWCuIoUt75CVOBtamqq+LEOUXMa8iGp1LdgNFxr78UqzFhNHFL6dUpXTmwwVUkU1P4/dCz0cqb4jwUkumGKG4LRsdvf6A5sdjCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515845; c=relaxed/simple;
	bh=dr2eJx0AGMOiACOfHv2a++ANA/ZfYMyl7pXJI+5g3vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/PAAi0SNUp4qrP0a2vP5GrFj/anyM32rDDUmpUXfoA5qxF+oAFgqbZ6llLCleTqlKbK21uEcWiOImgZfLEyBY3qoVDi6VkZDKCsZ/YWYLtsWE7JVwXKXf+Wp186azKFzR77vwo/PPp0xyhb9M1dZgO2lAiMCgO//WkxAkzi40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=OZq/i/CR; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="OZq/i/CR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1769515386; bh=HUnxlQMGA5QnlWkBCPNLQetlCj3hCWlm8SxfDSPkKW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=OZq/i/CRcW4ASwJQXBCKdzE/5+t9cBJjkg7ckp9GiAHf4mcorHRi2sxt2JtK/Ue5g
	 d80dnhc7UC+Fam3ze8gU3UqIbDtcwwmMofKVNOvc8OlwHBd2lInn9v3h1Dyiv9eHr/
	 ggu9evRaIDqvYiQYVFGQSGeocYpLXxOA360abRj/huLgyNAclbRGC/3991HPFRFz4t
	 i6R+LI6NhePmut8brz+TnRtacirNcsYCH1WW98p2QMgcqmdrzsCYzwuJLgBv0NiQ0o
	 9hhSqtRkqk6NE8zvrh3nuoIM+SRStjmqBjhNmuPtpaQcgoN0UyZflhP4eah38AHTGH
	 UUXcZves1Pa+g==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4f0kZ23WN4z1yJf;
	Tue, 27 Jan 2026 13:03:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.20.40.230
Received: from luis-tp.pool.uni-erlangen.de (faustaff-010-020-040-230.pool.uni-erlangen.de [10.20.40.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/Bo9po6XFoCqGF6taN//KOcDOxeuewqqk=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4f0kYy6dCZz1yD8;
	Tue, 27 Jan 2026 13:03:02 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Ihor Solodrai <isolodrai@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: [PATCH bpf-next 1/2] bpf: Fix verifier_bug_if to account for BPF_CALL
Date: Tue, 27 Jan 2026 12:59:11 +0100
Message-ID: <20260127115912.3026761-2-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127115912.3026761-1-luis.gerhorst@fau.de>
References: <20260127115912.3026761-1-luis.gerhorst@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The BPF verifier assumes `insn_aux->nospec_result` is only set for
direct memory writes (e.g., `*(u32*)(r1+off) = r2`). However, the
assertion fails to account for helper calls (e.g.,
`bpf_skb_load_bytes_relative`) that perform writes to stack memory. Make
the check more precise to resolve this.

The problem is that `BPF_CALL` instructions have `BPF_CLASS(insn->code)
== BPF_JMP`, which triggers the warning check:

- Helpers like `bpf_skb_load_bytes_relative` write to stack memory
- `check_helper_call()` loops through `meta.access_size`, calling
  `check_mem_access(..., BPF_WRITE)`
- `check_stack_write()` sets `insn_aux->nospec_result = 1`
- Since `BPF_CALL` is encoded as `BPF_JMP | BPF_CALL`, the warning fires

Execution flow:

```
1. Drop capabilities → Enable Spectre mitigation
2. Load BPF program
   └─> do_check()
       ├─> check_cond_jmp_op() → Marks dead branch as speculative
       │   └─> push_stack(..., speculative=true)
       ├─> pop_stack() → state->speculative = 1
       ├─> check_helper_call() → Processes helper in dead branch
       │   └─> check_mem_access(..., BPF_WRITE)
       │       └─> insn_aux->nospec_result = 1
       └─> Checks: state->speculative && insn_aux->nospec_result
           └─> BPF_CLASS(insn->code) == BPF_JMP → WARNING
```

To fix the assert, it would be nice to be able to reuse
bpf_insn_successors() here, but bpf_insn_successors()->cnt is not
exactly what we want as it may also be 1 for BPF_JA. Instead, we could
check opcode_info.can_jump, but then we would have to share the table
between the functions. This would mean moving the table out of the
function and adding bpf_opcode_info(). As the verifier_bug_if() only
runs for insns with nospec_result set, the impact on verification time
would likely still be negligible. However, I assume sharing
bpf_opcode_info() between liveness.c and verifier.c will not be worth
it. It seems as only adjust_jmp_off() could also be simplified using it,
and there imm/off is touched. Thus it is maybe better to rely on exact
opcode/class matching there.

Therefore, to avoid this sharing only for a verifier_bug_if(), just
check the opcode. This should now cover all opcodes for which can_jump
in bpf_insn_successors() is true.

Parts of the description and example are taken from the bug report.

Fixes: dadb59104c64 ("bpf: Fix aux usage after do_check_insn()")
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/7678017d-b760-4053-a2d8-a6879b0dbeeb@hust.edu.cn/
---
 kernel/bpf/verifier.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c2f2650db9fd..e7ff8394e0da 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21065,17 +21065,19 @@ static int do_check(struct bpf_verifier_env *env)
 			 * may skip a nospec patched-in after the jump. This can
 			 * currently never happen because nospec_result is only
 			 * used for the write-ops
-			 * `*(size*)(dst_reg+off)=src_reg|imm32` which must
-			 * never skip the following insn. Still, add a warning
-			 * to document this in case nospec_result is used
-			 * elsewhere in the future.
+			 * `*(size*)(dst_reg+off)=src_reg|imm32` and helper
+			 * calls. These must never skip the following insn
+			 * (i.e., bpf_insn_successors()'s opcode_info.can_jump
+			 * is false). Still, add a warning to document this in
+			 * case nospec_result is used elsewhere in the future.
 			 *
 			 * All non-branch instructions have a single
 			 * fall-through edge. For these, nospec_result should
 			 * already work.
 			 */
-			if (verifier_bug_if(BPF_CLASS(insn->code) == BPF_JMP ||
-					    BPF_CLASS(insn->code) == BPF_JMP32, env,
+			if (verifier_bug_if((BPF_CLASS(insn->code) == BPF_JMP ||
+					     BPF_CLASS(insn->code) == BPF_JMP32) &&
+					    BPF_OP(insn->code) != BPF_CALL, env,
 					    "speculation barrier after jump instruction may not have the desired effect"))
 				return -EFAULT;
 process_bpf_exit:
-- 
2.52.0

