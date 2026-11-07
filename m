Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024733;
	b=P3KuoQ847vlP/34EBJc/rVqktZp3KNjgv0eM8GeH3XpSbDoidNRCWw8RmcW5jXPnL3pk
	 Jy4bGUO4xp7o2PX0wRxsFVkAfd0yrAYF0aVA7I92dekgA1W/0Jv/xT2tWVNEQ4diqkjl6
	 Lfpsm+hokg56ffkP5YZhd4+NhpXqaA4gWZm5fIBeR/DZ6mwWv1aNKPElyYBYCUR9EYkYs
	 gupCG3/dxQX+G7pV6cxqDZZ3o40hqcjX3Wv1DeVaDYg6fr6fjn2sg7WxIvX594e3kcDVQ
	 2iKB1YDd+nVkqOYwwhRPKGRGdlVgpP58M+CzHR4NYmeaZKXA+cTm3Z2L6TRNvwUqIuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024733;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y0SogXKs8SRMzLzS5AU7M7xO8kuSusgx8QTxE/KLmKo=;
	b=484ntn0D8iwfOL8G5V6yT5VT933RbXqp64mO3Q952hZC7yz2f2W2nI50A7B+KsJNiqzb
	 fcsS2ZYb13H047svCmSYesqfd1w0hz5AB4HANXwmBbzXCUA7FcWg0AH4teMJuRVzJryYz
	 PvOMSjF3jTyL/ldecsv6DnxKdrrX/dNs4uGGablqz0M329XSQX7jqKg+zV8/d8wCDwzWg
	 D7/4loaf3lfCNI+uobeYJaju/UD8CHJcpzTj1M+MBzzQiHFjJWaotsMXIoNws/gbqZC9J
	 wdtUH8hqPUOJlhfNpPWrOvQaQ+5vNZ6O5x6r6Cehvjqs1T5ieaK/IYo9AgxfwDrCxKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnK1OxH6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36191606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnK1OxH6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991651F0089F;
	Sat,  7 Nov 2026 04:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794024732;
	bh=Y0SogXKs8SRMzLzS5AU7M7xO8kuSusgx8QTxE/KLmKo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CnK1OxH6mqB8heePbV36ujDrgmEzHvXxuRKP4QuT2+Wz7LE8oPZAZPxc7RpyC0Xmx
	 fuw+AEluQ8ZEvBjTxi2g8bHQafGdWKNM/ojiY/VRTaPK2f3iswys7ytckrCl1XZplP
	 3+MzoZ6FgzUU0HLcFdklsaLyKHTdgkAaKBU3UJ4M0EwUSwhFdwz2XjsuhLTAxxj8J8
	 7CKn9sMnvnoSB8QUnMpBX+jOQmiCu20daCttT1L6f/XhLyMBMkzk3Gk5QefaHQIiJa
	 pV/BtiVjV0/YdaTDWj5CZoK0oN3UVU65ij4dShpFETYk9vXiyEchv9iSJ6HOmAwxJt
	 wxtnnQYMLyw/Q==
Message-ID: <sashiko-outbox-202560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 01/46] bpf: Add may_goto to the loops that
 the verifier marks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-2-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:12:12 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: bpf_insert_loop_guards() logs shifted insn index instead of
  orig_idx
--

commit 4c080c1282306b111e989d48659533beacc7c4d9
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Add may_goto to the loops that the verifier marks

This commit introduces bpf_insert_loop_guards() to insert may_goto
instructions and subprogram exit sequences for loops marked by the
verifier during the main pass.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index f95af2ca3591b..6fd79c2fbdc1e 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -587,6 +587,225 @@ static int bpf_adj_moved_insn(struct bpf_insn *insn=
, u32 delta)
[ ... ]
> +int bpf_insert_loop_guards(struct bpf_verifier_env *env)
> +{
[ ... ]
> +	for (s =3D 0; s < env->subprog_cnt && !err; s++) {
> +		leave[s] =3D append_budget_exit(env, s);
> +		if (leave[s] < 0)
> +			err =3D leave[s];
> +	}
> +	/* A guard cannot jump into a patch that is in the list: 'r0 =3D 0' has=
 no index yet. */
> +	err =3D err ?: bpf_patch_list_commit(env);
[ ... ]
> +		if (off > S16_MAX || off < S16_MIN) {
> +			verbose(env, "exit of the loop is too far from insn %d for may_goto\n=
", i);
> +			err =3D -ERANGE;
> +			break;
> +		}
> +		patch[jmp] =3D BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, off, 0);
> +		if (to =3D=3D -2)
> +			patch[jmp] =3D budget_exit_insn(env, bpf_find_containing_subprog(env,=
 i));
> +		patch[n] =3D env->prog->insnsi[i];
> +		/* A jump to itself is a back edge. It goes through may_goto like the =
others. */
> +		if (jumps_to_itself(&patch[n]))
> +			patch[n].off -=3D n;
> +		else
> +			err =3D bpf_adj_moved_insn(&patch[n], n);
> +		if (err) {
> +			verbose(env, "insn %d cannot be patched due to 16-bit range\n", i);
> +			break;
> +		}

[Severity: Low]
Should these two verbose() messages log aux[i].orig_idx instead of i?

The earlier bpf_patch_list_commit() call inserts append_budget_exit()
sequences at the end of subprograms, which shifts instruction indices i in
later subprograms away from their original positions in the user-supplied
program.

In addition, calling bpf_insert_loop_guards() in bpf_check() before
check_max_stack_depth() shifts the raw instruction indices reported by
check_exception_cb(), check_recursion(), and check_callbacks() when
check_max_stack_depth() rejects a program.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D1
