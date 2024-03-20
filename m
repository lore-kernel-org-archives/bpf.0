Received: from smtp5.epfl.ch (smtp5.epfl.ch [128.178.224.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19B3FB97
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710937736; cv=none; b=qOdnS8hzVKbHGFnAkZj7il8MAxehNx1AjuyW/coATTSVLkh32LOIVERocixjJfO16COOybXz/qUl8VCWGGT9uBkTQdE742I/OJFLKfteFhaWhVJWJLU3zFNzYPaJ6VoIYdz/0AOQnbyAFbFmc5kKMrXjgX1ere1fIr9QH49Xq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710937736; c=relaxed/simple;
	bh=6Z42uYiOqSGYvenZ4bt9LJYVy4QAJgvgkWMm+tbpdzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SMzar3neatMndJXrVAzwIgMyv6BxQH2lqxTbsLSv4K09An+cg0pD4Qb+x1Q0F5JKBNoV8AhV79DXq1pAi0RM/7wUTTaEHn6oRyWKvKJl/Id/mzOvNoG7FwlahfEGNGCz5vHumnzQ9cQuAxSLeHr7hCldbeD67/sRqepqy7VwkrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=Dx6sBvSO; arc=none smtp.client-ip=128.178.224.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="Dx6sBvSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1710937329;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
      bh=6Z42uYiOqSGYvenZ4bt9LJYVy4QAJgvgkWMm+tbpdzA=;
      b=Dx6sBvSO5rxWe/bdmhcOa6wQXHo85S8MetDYyLf/dmkkG2xNOsE4LT+t0fKU/mZv2
        ZaDrehYHn4r0caTxB3w13ctakKyC8bo+WSwlZH7hL9E7LbeVUpsrZX4R+HAW2cqF3
        K1Pw1pMRMTPnX2/+7fhyhZAidCsG9I3FUE8hU7/BY=
Received: (qmail 21879 invoked by uid 107); 20 Mar 2024 12:22:09 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Wed, 20 Mar 2024 13:22:09 +0100
X-EPFL-Auth: SMcwnticD3p7nQtFNFWvVOds0J+IW5SMv4GRH/nA9qoPy84lhvo=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 13:22:08 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <andrii@kernel.org>, <yonghong.song@linux.dev>
CC: <bpf@vger.kernel.org>, <sanidhya.kashyap@epfl.ch>,
	<mathias.payer@nebelwelt.net>, <meng.xu.cs@uwaterloo.ca>, Tao Lyu
	<tao.lyu@epfl.ch>
Subject: [PATCH] Inaccurate rejection conditions
Date: Wed, 20 Mar 2024 13:21:53 +0100
Message-ID: <20240320122153.3622252-1-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ewa12.intranet.epfl.ch (128.178.224.187) To
 ewa07.intranet.epfl.ch (128.178.224.178)

Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

Hi,

I am sorry to bother you due to my confusion on constraints about stack writes.

1. When an instruction stores 64-bit values onto the stack with fixed offset and BPF_CAP only,
   the verifier marks the stack slot type as STACK_SPILL, no matter whether they are scalar or pointers.

2. Then, a store instruction with a **32-bit scalar value** on the same stack slot leads to a verification rejection.
   As it says, this might corrupt the stack pointer by asserting if the stack slot type is STACK_SPILL. 
   However, even if the stack slot type is STACK_SPILL, it might store a 64-bit scalar and not a stack pointer.
   IMHO, this "issue" might originate from the incomplete conditions in the check_stack_write_fixed_off() function below.
   It only checks if the stack slot is a spilled register but forgets to check if the spilled register type is a pointer.

 4479 static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 ...
 4494     if (!env->allow_ptr_leaks &&
 4495         is_spilled_reg(&state->stack[spi]) &&
 4496         size != BPF_REG_SIZE) {
 4497         verbose(env, "attempt to corrupt spilled pointer on stack\n");
 4498         return -EACCES;
 4499     }
 ...
 4600 }

Below is an example bpf program, which stores a 64-bit and 32-bit immediate value on the same stack slot.
But the second one gets rejected due to the above.

0: R1=ctx() R10=fp0
; asm volatile ( @ repro.bpf.c:679
0: (7a) *(u64 *)(r10 -8) = 1          ; R10=fp0 fp-8_w=1
1: (62) *(u32 *)(r10 -8) = 1
attempt to corrupt spilled pointer on stack
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0.

If my understanding is correct, then we can apply the attached patch.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de7813947981..65f7eb315e9c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4493,6 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	 */
 	if (!env->allow_ptr_leaks &&
 	    is_spilled_reg(&state->stack[spi]) &&
+	    state->stack[spi].spilled_ptr.type != SCALAR_VALUE &&
 	    size != BPF_REG_SIZE) {
 		verbose(env, "attempt to corrupt spilled pointer on stack\n");
 		return -EACCES;
-- 
2.25.1

