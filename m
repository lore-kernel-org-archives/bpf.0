Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B9382385
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622850; cv=none; b=ClIdcgZbhWpSiZvZS2Qtb3pbKZm9idvbf1TwsQPDmG3h5Uu6feW3YbxPfuRJ+zVFZSFMBO6lA1SLR9t2NRN9qB55Tg/ugT0DQVK9NSf/bvYvbKkZ296X1cXUK62SPDFE6G2IlqKKHw6OFeBrLRX35H+Z01/sUe1uOin9zIq2yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622850; c=relaxed/simple;
	bh=/8vlfvNrvR1aGFuSSFfQLcmfmdbizQk0Lpg9eACEkCM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfSH6iK5MWGBGqAWg09sXcrBHSv3qyiSnMfjfhvPMGzFWrnUCJr3rv4SYOGr+wUR2QQ/VGkwqMrF1Oc1h+Ll1N0M/Aj7H0cAEVpJ1xufhyq3ZbmiTRmj3hcyZ0YxRITpxC0SpuCiLFamB3f6VddbQoDdmGi4PUTLfWbjxW2rrFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRWx1eeJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRWx1eeJ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83ea84df1d0so1213114b3a.2
        for <bpf@vger.kernel.org>; Tue, 12 May 2026 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778622849; x=1779227649; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A1P/ffNTC/uTmWQnj8+NsiRNWozKHpYui9I+/xOHTR8=;
        b=mRWx1eeJ/RrBTNVuzctyQhQhn8WFKqtUP7/j5HjtkklU4+knznXCMD+ZdFMulT1JYJ
         eEH4HwTVsUWrVHdFTWE4rM+BzruXZ67F9cHKyeZPQevUh1hH2H3UcCSTreZFyuGDSUUG
         PnPwIYbv/Iw74zSbNak5TElVfJLJtOqoQJpU2IylCwa+Vtkm8GhCL9ETIvEoTiuwyzD6
         SW6RuKkmFSWhu6RV5dcACGElYrf4MK6B50K022uIUR+ybGnenv4VOoFaAKOvddeC+MgR
         +WHGIaCtTpWpQWnohTRVrXPlIY+eLSBS+sXdw9s8bvyDlJMwHYHncj74JpfMwDPO4z4c
         GS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622849; x=1779227649;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1P/ffNTC/uTmWQnj8+NsiRNWozKHpYui9I+/xOHTR8=;
        b=OUP7zJUlJJ49eDm+b7H1ejK+ouRWhDBqwt0PPfxs/mPbLu2BrbREUBTQLnjHZte6NB
         BcuvmRNMoLqRY3PmbIRy2ZoSFivRFz4gsjLl6pt1MsnNXfls1InJE+ZH65UJRRvoV5it
         1LxHEWebgrmRAVMhWiFee3Fcs4ukOYX0l30q6V4YGXP6/xfjn/Y8G+Pvu+vk/4g5pnFV
         DtwVNGqX+SlXg/H/MoE2NPnk67cFWt80df6+arIUL+Iyt8ZQiZ9yop6NFClTI7+hA2V/
         KinmhkRk0gVcyus8wRBx+GeLC9/Mw3KHw30QUzJHd4kPPkbHv2fBhrOqwdMbEmBbW+X+
         qWZA==
X-Forwarded-Encrypted: i=1; AFNElJ+mWZbBq1MHlZZ5kIgUptphkFHz1HBELTH1BgLOEIKDk+wLDRzHB5h/zglS/PBkYGgXowI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4eSNlCN5oXb8sJ2hWv5p9CJakQJB1GvGwWJoSuyJ5qG1mGET
	pDLwewTP83WcpU3hTb1ohH46ijyx+w566dAurfR2j1Vh++ZuA6LHStTPSe0gdbRc
X-Gm-Gg: Acq92OE1DJgIbjABicchVP6GXxDLpSo0dNqveDEJIvnNSeleo0IgGENK5WzNr3BMJbN
	+6f0Wg5wq+SFZlQa3dUeH0vvZdAwC2+LSKIg4tdWGsPpnT0Aeky1pGoc5UYtqZ5qJievv6WER5I
	UG9kd4W8aOio3wgWdM3MI4z2rXJJ76ztaEbyiX9K78TOrR/mNgpML4+SlpyOdMugZ28/viqniK1
	2BWdCEaPOYhrdFEBTttptzoD+DpSiox9EzWGCWAeMh1/cFEgEdkJIzgJYJEi8NmXhWSUJPVizco
	Q/LTTwWdIvFgAmuf7ZXLbUxyelJWKCPvcjfcfRNrCxDcSAQp4WmjJvSt/FkW7jjINMRULwdgER1
	6aIHuzpJiNorp+XayxxEM0yjuxf5IerAqUOCDn7FLI6tcAkvthfN8XICSddiSCyEtBKlLNuzUls
	wsjvVzkB91lfukYhSZROQVbrfo2HuotKZSrCYVb/+KhPPaztizgEao
X-Received: by 2002:a05:6a00:b483:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-83f058b68cfmr96544b3a.23.1778622848695;
        Tue, 12 May 2026 14:54:08 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965645140sm25292016b3a.12.2026.05.12.14.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:54:08 -0700 (PDT)
Message-ID: <2a6d16baade6d1d22ebda367c67f49ad9aeb4dc5.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Report maximum combined stack depth
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 14:53:33 -0700
In-Reply-To: <05f82d1180b68e856bb0cc03a5cd86305f5b7669.1778604369.git.paul.chaignon@gmail.com>
References: 
	<05f82d1180b68e856bb0cc03a5cd86305f5b7669.1778604369.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 19:19 +0200, Paul Chaignon wrote:
> We've hit the 512 bytes limit on stack depth a few times in Cilium
> recently. As a result, we started reporting in CI our current maximum
> stack depth across all configurations for each BPF program.
>=20
> Unfortunately, that is not trivial to compute in userspace. The
> verifier reports the stack depths of individual subprogs at the end of
> the logs. However the maximum combined stack depth also depends on the
> callgraph of those subprogs (the max combined stack depth is the height
> of the callgraph weighted by per-subprog stack depths). We can compute
> a callgraph in userspace from the loaded instructions, but it often
> doesn't match the verifier's own callgraph because of dead code
> elimination. Our current approach relies on dumping the BPF_LOG_LEVEL2
> logs, but this feels overkill considering the verifier already has the
> information we need.
>=20
> The patch lets the verifier dump the maximum combined stack depth in
> the logs, on the same line as the per-subprog stack depths:
>=20
>     stack depth 16+256 max 272
>=20
> The per-subprog stack depths and the new max stack depth are not
> directly comparable. The former is sometimes updated during fixups,
> while the latter is not. As a result, even with a single subprog, we
> may end up with two slightly different values. The aim of the new max
> value is to be closest to what is actually enforced by the verifier.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
>  include/linux/bpf_verifier.h | 2 ++
>  kernel/bpf/verifier.c        | 6 +++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 976e2b2f40e8..d91843994c82 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -936,6 +936,8 @@ struct bpf_verifier_env {
>  	u32 prev_insn_processed, insn_processed;
>  	/* number of jmps, calls, exits analyzed so far */
>  	u32 prev_jmps_processed, jmps_processed;
> +	/* maximum combined stack depth */
> +	u32 max_stack_depth;
>  	/* total verification time */
>  	u64 verification_time;
>  	/* maximum number of verifier states kept in 'branching' instructions *=
/
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 11054ad89c14..896dbb4515d7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5045,6 +5045,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>  		}
>  	} else {
>  		depth +=3D subprog_depth;
> +		if (depth > env->max_stack_depth)
> +			env->max_stack_depth =3D depth;
>  		if (depth > MAX_BPF_STACK) {
>  			total =3D 0;
>  			for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller)
> @@ -5185,6 +5187,8 @@ static int check_max_stack_depth(struct bpf_verifie=
r_env *env)
>  	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
>  		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
> =20
> +	env->max_stack_depth =3D env->subprog_info[0].stack_depth;
> +

I think this line is redundant, the loop below would call
check_max_stack_depth_subprog() for the main subprogram anyway.
Additionally it does not round the value same way
check_max_stack_depth_subprog() does. Also note that if main
subprogram uses private stack it's depth is omitted in cumulative
depth computation.

>  	/* All async_cb subprogs use normal kernel stack. If a particular
>  	 * subprog appears in both main prog and async_cb subtree, that
>  	 * subprog will use normal kernel stack to avoid potential nesting.
> @@ -18289,7 +18293,7 @@ static void print_verification_stats(struct bpf_v=
erifier_env *env)
>  		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
>  		for (i =3D 1; i < subprog_cnt; i++)
>  			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, "\n");
> +		verbose(env, " max %d\n", env->max_stack_depth);
>  		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed=
);
>  		for (i =3D 1; i < subprog_cnt; i++)
>  			if (bpf_subprog_is_global(env, i))

Maybe also add a veristat metric for this value?
