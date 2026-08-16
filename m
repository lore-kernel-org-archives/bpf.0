Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9F2E413
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786867143; cv=none; b=p3efe9uBbCLnf0P4DpSo1qqaz7zShP54bq6otHX2L9V55+xWBSu0lP5b+E6sYcgfu+uYnQEcD6cq51nWM7CMGjDdew0WtdUket0O6/ExltCntjYPgRK5k/rnot4+OPzFtPWbKIVyUQGZBWg/X0LsmFHkDJ9hIsiOY7xLIYiDJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786867143; c=relaxed/simple;
	bh=W2pHimXLknz1sQAMFCvIeg4Sq+ihrHCOJ4my6apu+Lo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MtGF7FwgxYrakqAbqVjWX9ggS41LHhbdJl8i/C3FODmwGyMLaXLREFZM+0jSAqkTn2UsLSVysQV3QEoPDj7UtfhyJ0gTK4I//L8x2ryjJ9p8x8xmyHhJZ1gQwZpR3OIv5dw/+zLEbvzmQAFfWqmmwpeLcIHEKsWwdpMjBtJaEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjaB/mdG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjaB/mdG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf27856f9cso21901695ad.2
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786867142; x=1787471942; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=krOoWGE2WqVY6m6N8+DLm5p8nBXtPa73HREPEy02ceU=;
        b=ZjaB/mdGrhrHAbJVSGFYfCZl4V0TBagFLPYPsIUA0Q6+unEYuwKhyYwmUvW/rgxmdb
         z/K4KEkQ8SfJa/d37x6kfrfBSPtuxNxIYQ5DAwlEOi5/Fh3OspXFJfLc2VM3EbQuE2EM
         S1wtR/vn+sXCAF+2iCxEx+SEsw5CD6oYqMoDYQGBNWTKSwiUwdvN4jGUW+/+qh4QDmm5
         O0/T0qjz55W1ECX8+IPScNXpraosrS94AKpHuSlslUS7gwRFLnmhlENHDR5BQwyDipcM
         BaHQeMBrFtIA2708/X2v3tNxY0bAJ9JmhiOqWzrklEASa3HefoY4t/bMnAxNGTSmN140
         mYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786867142; x=1787471942;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=krOoWGE2WqVY6m6N8+DLm5p8nBXtPa73HREPEy02ceU=;
        b=Rog4+6nBZoTUVbMndSNAixnqe09V7d6kAqo+M9cgBT0CMdyT413MrEy8pdd1+yGMYK
         hNcWZDHZ7+OUIi9XP5np0hr3L7s5HXO+H5btA43GAICJ1sW2UXEuh6EhzT+GJoZ/+UNr
         6gwyeT9tQ5B37bu5rah/142SVVcgHLwrb1rjRvBxbq/HX+dOvNuG43fGyIEpLNKTnBGS
         WfCkFHE9HGyF0zeLHj8QkU01V7bPXUD3sTJII2e4Vx+QWQdYiJVr+pR1CMbRmo3bpkzw
         1VL8u6cIeGJncryyrQMq7M3DlRS/EXaFYn3DfnXvdEiRT8owIHc3/ji9NLT76y6+rsZA
         k2ag==
X-Forwarded-Encrypted: i=1; AHgh+Rq7bynUZ+7l3BNvJ2YSCx/OdcAPdQzkcLh1dE1hI0ju+iepMUPqC2jn7JHMdzV39stD3Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TAfVWd8uSw02vf7CC/IiJBE65vAgAe0bhsOYzAq71t3IiRtq
	BkXybcMAxVLbKCOSheTDZZSfkq60/DM0ht+rVrFnjcsHs0jEXnbjEzft
X-Gm-Gg: AR+sD135jBet/YqwFAE/JxZGugA4xduuu888Q+MKWvI7v20Jw3sAkTW59Bf3FP8J7v3
	XRpdZqkJl1KUNcRLK5jKHkTkH2HLF8Fot75HE84uZi/pqDSg/Q47NmVvLjzjZ0yXcVRD/U8hCJa
	O71GkPqi88IXXATB7fcmVPtn9JEZC8/RHy4ROZRKBiyis8EosAB0xotJWZ3kse2WOKZknJx8nOM
	ROrw8BTT1Prti2+zfFN4Bv9WR2PLIfKXFZIVBR+j/cRZmw9NtEUiRbOmhFaJYZb3oS3jT6Cn4tv
	E/LVeH7AAF3ri+qBT3Xs2M5+hezojw8v9ZXr/wPnIzbIrU2HD61dbKoT8shoJ/BFTvb3LZ2+usZ
	Gyn5UktY8eCtEZs2Vsd5fKfcq4L4cgvN2RK/pO9gmTDVjwr3r5rBN/Wo87mKRl8/nyTCeYSQ3rQ
	eKor/cwE1KW1tYz+M+7txwMbato7+5cwoU5dpPS4v3n6XQMiZ/Qb04TLXGXU4MvHmHoYijYNE3D
	Bm1JpRrJf5aU7By
X-Received: by 2002:a17:90a:d646:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3933b7d33b4mr18502798a91.8.1786867141714;
        Sun, 16 Aug 2026 00:59:01 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b699e47sm3935374a91.4.2026.08.16.00.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:59:01 -0700 (PDT)
Message-ID: <f9c45e499331c84c0a5b4b924fb8a0594ec64fa1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 10/14] bpf: Correct Program Structure
 diagnostic context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sun, 16 Aug 2026 00:58:58 -0700
In-Reply-To: <20260816015746.2632990-11-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-11-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3de9e4f617b6..d2f08c6612c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2995,15 +2995,13 @@ static int add_kfuncs(struct bpf_verifier_env *en=
v)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static int check_subprogs(struct bpf_verifier_env *env)
> +static void find_subprog_properties(struct bpf_verifier_env *env)
> =C2=A0{
> -	int i, subprog_start, subprog_end, off, cur_subprog =3D 0;
> +	int i, subprog_end, cur_subprog =3D 0;
> =C2=A0	struct bpf_subprog_info *subprog =3D env->subprog_info;
> =C2=A0	struct bpf_insn *insn =3D env->prog->insnsi;
> =C2=A0	int insn_cnt =3D env->prog->len;
> =C2=A0
> -	/* now check that all jumps are within the same subprog */
> -	subprog_start =3D subprog[cur_subprog].start;
> =C2=A0	subprog_end =3D subprog[cur_subprog + 1].start;
> =C2=A0	for (i =3D 0; i < insn_cnt; i++) {
> =C2=A0		u8 code =3D insn[i].code;
> @@ -3017,6 +3015,27 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
> =C2=A0		if (BPF_CLASS(code) =3D=3D BPF_LD &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 (BPF_MODE(code) =3D=3D BPF_ABS || BPF_MODE(cod=
e) =3D=3D BPF_IND))
> =C2=A0			subprog[cur_subprog].has_ld_abs =3D true;
> +		if (i =3D=3D subprog_end - 1) {
> +			cur_subprog++;
> +			if (cur_subprog < env->subprog_cnt)
> +				subprog_end =3D subprog[cur_subprog + 1].start;
> +		}

Nit: in situations like this doing two nested loops reads much better:
     for each subprog:
       for insn from star to end:
         ...

> +	}
> +}

...

> @@ -3126,8 +3146,9 @@ static int sort_subprogs_topo(struct bpf_verifier_e=
nv *env)
> =C2=A0					bpf_diag_program_structure(
> =C2=A0						env, idx, "recursive subprogram call",
> =C2=A0						"Rewrite the recursion as an explicit bounded loop, or split =
the logic so subprogram calls do not form a cycle.",
> -						"This bpf2bpf call would make the subprogram call graph recursive.=
 "
> -						"The verifier requires a finite, acyclic call graph so it can boun=
d stack depth and analysis.");
> +						"The call from %s() to %s() would make the subprogram call graph r=
ecursive. "
> +						"The verifier requires a finite, acyclic call graph so it can boun=
d stack depth and analysis.",
> +						bpf_subprog_name(env, cur), bpf_subprog_name(env, callee));

Nit: I'd drop this hunk, I think that initial suggestion from the bot
     was bogus. What would be really helpful is to draw the whole
     cycle, but we don't have such info here.

> =C2=A0					ret =3D -EINVAL;
> =C2=A0					goto out;
> =C2=A0				}
