Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91221394793
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595347; cv=none; b=sZDLipRsqNOnGorTteTKh2ohCzsxjDgZoKFHVvVC25GB7tzrsim9scjMadwvaeq3qeUpqltbC7sDiAL/CoWRQdkzp44qglGxyk3tZoNB2vtf2JsnkmzSgO+vPDpVgSydiATFuad98FDgN7Ykp747Lu1Pz6IcYcgTh6MC5IhuBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595347; c=relaxed/simple;
	bh=vhnqDah4EcxdtMFwQWkeZBGGmXmaNblKShGFHlk6AWQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K6wVCuEhKE0adkMpybkxb4imrVk811mxqO6xnbxxKrasjeOMatBKJtxluOHS0JC9ypGHQHq0M3ecIDmg18uTSHWixljAgLawbOxIL7Ed7OrJ/vItZCzOXFRjJPt5AUZRUY32PuXi/D/01o8PIwjFI2qpNSfAdFSK4yjwWkGEh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJOpLoBS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJOpLoBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804051F00A3D;
	Sat,  5 Sep 2026 08:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788595345;
	bh=k+j0iVqP34q3Y629CQrB3WBuRy3qAY+u1vY2xvT7CGA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZJOpLoBSEfdYUua9gh+VlCuhu0WHpmePXB9MditdoZLJw+tfuRgm7fe50+IpUvLC4
	 0mauPL+59WHrx7z6ru4dYF3dNS8JncYvDq+Jow2EGb3KnR9aANy6lXyQGh8oJvp1En
	 Aj+7WWSYBeO5S1gPpOixn8tH+rE23laE3Xto+L5gJ7vguO0887PbtZsyv54iwpJ1Kd
	 K8fXnqwZvCVhbEgRJjhlH7W5lzJValcnasFUHvm5vswoWaUVgUNc+mKBJe6RU3mPWS
	 NXCUtxc+e6t10Y93EtCSXMEOMmZUvCt+knyS9IUreN8xXjjUZXfIuQuWYLGkhsbFYS
	 QFlcBjGj6foFg==
Content-Type: multipart/mixed; boundary="===============4698210227410485498=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a9644fdbe7dd25d1d2ea0e4bcf474c720c66835b2f5f9b18186c67ea60e8bcf8@mail.kernel.org>
In-Reply-To: <20260905070003.3193366-5-memxor@gmail.com>
References: <20260905070003.3193366-5-memxor@gmail.com>
Subject: Re: [PATCH bpf v1 4/8] selftests/bpf: Test packet pointer class displacement pruning
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 08:02:24 +0000 (UTC)

--===============4698210227410485498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
> index 0b86d95a4133..692a8468f3d7 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
> @@ -5,6 +5,50 @@
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
>  
> +SEC("xdp")
> +__description("XDP pkt regsafe preserves packet pointer class displacement")
> +__failure __msg("R2 min value is outside of the allowed memory range")
> +__flag(BPF_F_ANY_ALIGNMENT)
> +__naked void pkt_regsafe_class_displacement(void)
> +{
> +	asm volatile ("\
> +	r8 = *(u32 *)(r1 + %[xdp_md_data_end]);\
> +	r9 = *(u32 *)(r1 + %[xdp_md_data]);\
> +	r6 = r9;\
> +	r6 += 8;\
> +	if r6 > r8 goto l_exit_%=;\
> +	r0 = *(u64 *)(r9 + 0);\
> +	r4 = r0;\
> +	r4 &= 15;\
> +	r7 = r0;\
> +	r7 >>= 63;\
> +	if r7 != 0 goto l_path_b_%=;\
> +	r2 = r9;\
> +	r2 += r4;\
> +	r3 = r2;\
> +	r3 += 4;\
> +	goto l_join_%=;\
> +l_path_b_%=: \
> +	r4 &= 3;\
> +	r4 += 8;\
> +	r2 = r9;\
> +	r2 += r4;\
> +	r3 = r2;\
> +	r3 -= 4;\
> +l_join_%=: \
> +	r5 = r3;\
> +	r5 += 4;\
> +	if r5 > r8 goto l_exit_%=;\
> +	r0 = *(u64 *)(r2 + 0);\
> +l_exit_%=: \
> +	r0 = 0;\
> +	exit;\
> +"	:
> +	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
> +	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
> +	: __clobber_all);
> +}

A subsystem pattern flags this as potentially concerning:

The test only detects the bug if the verifier happens to checkpoint a
state at the join label. Nothing in the test pins that. do_check() calls
bpf_is_state_visited() at the goto l_join target (marked a prune point
in kernel/bpf/cfg.c), but a state is stored there only if the heuristic
in kernel/bpf/states.c holds: env->jmps_processed - env->prev_jmps_processed
>= 2 && env->insn_processed - env->prev_insn_processed >= 8.

For this program the first path reaches the join with 3 jumps and 16
processed instructions and no previous checkpoint, so the state is stored
today and the test does discriminate. If that ever stops being true
(heuristic retuned, one more instruction or jump added to the test, an
extra checkpoint created earlier), the second path is simply walked
instead of pruned and it still fails with the exact asserted string, so
the test would keep passing on a kernel without 6ab7e7c0e9c6 and silently
stop testing anything.

The analogous regsafe pruning test in the tree pins this explicitly:
tools/testing/selftests/bpf/progs/verifier_linked_scalars.c uses
__flag(BPF_F_TEST_STATE_FREQ) on scalars_alu32_alu64_regsafe_pruning()
(85 progs in the tree use that flag). Adding it here would force a
checkpoint at every prune point and make the pruning attempt independent
of the heuristic.

Related gap in what the test pins: the kernel patch makes two claims -
that displacement-changing classes no longer prune, and that safe uniform
translation of the whole class still prunes - and only the first is
covered. Would a companion __success case where every member of the
packet-pointer class is translated by the same amount help guard
check_pkt_ptr_ids()'s single-delta allowance against a future tightening
to plain r64.base equality?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952325041
--===============4698210227410485498==--
