Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3B18A92F
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778288357; cv=none; b=qpoxWCCaIYuodrqjudnrVo3TYduzNEal1AA88B6RzTb2JdGWWJ8hIlN9kSbpvB24M/z9lA4rrbZzOzW7bMrE2RQmUV5ttSsf3UKOpIFkF/H1rlL1OdNGy7Eph6p0VluAHnAc1nfM4H6FLXWxXsqdeHyE0qB4Y1HwreB5utFvRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778288357; c=relaxed/simple;
	bh=7l2Vuy3GPzzSs8n/+P5Pf0tuvTCIXC4uR1xTrg/HHmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mwB42YPzErRqBZNuevPi+NW6Ltgyv5l7lm5xtniYTaBjHVeSUaBqHLrhu62Ha+/Aj0YEnKGeRuubtCrzQ5nxoZT9UiJ6/53svpTlEjt8cyg4bZsbsHYC8UCn738RoqlFWF8IPTF/cQgDfA+J59jq0J/BV/CabbCVFj2ZN2L4XN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD02RPtV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD02RPtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22DAC2BCB4;
	Sat,  9 May 2026 00:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778288357;
	bh=7l2Vuy3GPzzSs8n/+P5Pf0tuvTCIXC4uR1xTrg/HHmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WD02RPtVlOBXGNfzY8Yl92qfObpCXN9+pR1KArKyoByoib8wX3DU4ont9WDJA+1jx
	 OiZBjIybQ0RExSUrHwGgS/SXHftCw91hC4kllKROCUKAa4hlKLpB0C6PL/fXNqeMVi
	 sVl/R4lmXG9d6/DiFje0+/tJOvapcqU2Qm+0dfGaDpz0vmCPgDK2ypyq+FvSiSCVzK
	 BSodeo3HkV5QQ2Gx8Ui2cII4xsU20fOet6meXZJffP3uKMNYxfidKsvi8rslbOHDLC
	 uvViSDrPVwaJsajhfFQawd5BRQcKqD1F4xLkz7B2Wa4C+lBWKW6CDn4ukMY0WuyDpk
	 m38no5aYdKTvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 09/23] bpf: Extend liveness analysis to
 track stack argument slots
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260507213029.1130085-1-yonghong.song@linux.dev>
References: <20260507213029.1130085-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 00:59:16 +0000
Message-Id: <20260509005916.E22DAC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] record_load_store_access() mistakenly uses the tracking state of s=
tack argument slot 0 as the base pointer for R11-based memory accesses, lea=
ding to spurious liveness marks.
- [Low] Missing verifier logging for stack argument liveness state transiti=
ons.
--

commit 00a5fce117daa13f26c61ec5ffa3622241608fc1
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Extend liveness analysis to track stack argument slots

This commit extends liveness analysis to handle stack argument slots, preve=
nting
pointers passed through stack args from incorrectly poisoning the pointed-to
stack slots. It explicitly handles BPF_REG_PARAMS (R11) to avoid out-of-bou=
nds
accesses and extends tracking arrays.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index de0b4c6263ff2..eed7260f2bb0a 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -610,6 +610,24 @@ enum arg_track_state {
>  /* Track callee stack slots fp-8 through fp-512 (64 slots of 8 bytes eac=
h) */
>  #define MAX_ARG_SPILL_SLOTS 64
> =20
> +/* Track stack arg slots: outgoing starts at -(i+1)*8, incoming at +(i+1=
)*8 */
> +#define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
> +
> +/*
> + * Combined register + stack arg tracking: R0-R10 at indices 0-10,
> + * outgoing stack arg slots at indices MAX_BPF_REG..MAX_BPF_REG+6.
> + */
> +#define MAX_AT_TRACK_REGS (MAX_BPF_REG + MAX_STACK_ARG_SLOTS)

Could this repurposed index cause a spurious liveness mark in
record_load_store_access()?

Because at[MAX_BPF_REG] is repurposed to track the value stored in outgoing
stack argument slot 0, what happens when record_load_store_access() process=
es
stack argument instructions like is_stack_arg_stx()?

record_load_store_access() does this:

	case BPF_STX:
		if (BPF_MODE(insn->code) =3D=3D BPF_ATOMIC) {
			...
		} else {
			ptr =3D &at[insn->dst_reg];
			sz =3D -sz;
		}

If the instruction is a stack argument access, insn->dst_reg is BPF_REG_PAR=
AMS
(which equals MAX_BPF_REG). It will fetch &at[MAX_BPF_REG]. If a BPF program
previously stored a frame pointer (FP) into slot 0, at[MAX_BPF_REG] will re=
flect
that FP.

Does this mean record_load_store_access() will spuriously treat this FP as =
the
base pointer and incorrectly mark the resulting local stack frame slot as
accessed, corrupting the local stack liveness mask?

[ ... ]
> @@ -1616,7 +1663,8 @@ static int compute_subprog_args(struct bpf_verifier=
_env *env,
>  		memcpy(at_out, at_in[i], sizeof(at_out));
>  		memcpy(at_stack_out, at_stack_in[i], MAX_ARG_SPILL_SLOTS * sizeof(*at_=
stack_out));
> =20
> -		arg_track_xfer(env, insn, idx, at_out, at_stack_out, instance, callsit=
es);
> +		arg_track_xfer(env, insn, idx, at_out, at_stack_out,
> +			       at_stack_arg_entry, instance, callsites);
>  		arg_track_log(env, insn, idx, at_in[i], at_stack_in[i], at_out, at_sta=
ck_out);

Are the state transitions for stack arguments logged here?

In arg_track_log(), the loop for logging register transitions is strictly
bounded by MAX_BPF_REG:

	for (i =3D 0; i < MAX_BPF_REG; i++) {
		if (arg_track_eq(&at_out[i], &at_in[i]))
			continue;

Since the tracking arrays at_in and at_out were extended to MAX_AT_TRACK_RE=
GS to
include state for outgoing stack arguments at indices MAX_BPF_REG through
MAX_AT_TRACK_REGS - 1, does arg_track_log() silently omit logging their sta=
te
transitions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507212942.1122=
000-1-yonghong.song@linux.dev?part=3D9
