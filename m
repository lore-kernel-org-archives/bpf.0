Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC30449997
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631268; cv=none; b=eJb8XFteHkL6ksbbh+rnnVdkxGpHEj9722lOngxZvRM9Bi5zOJe7W/yB1unpGoDC96GDKSt+Y7iac7OK8NM0lg5KweARBHKPTz/DkhkKLmqQfQVvKOJQadzG6uqdgxPaIwooZS/hfFHMeRKE09+Giwec5ClHbhEfwCykvHfXU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631268; c=relaxed/simple;
	bh=OE3FZInE7kf6xsYmqhsPZwA5G72oTPhBnyce8ICjrhQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rw3M0Dx3nNGlsoyBamgyqLmsC0z+PAJJH0RDTY7CtNs59zcGUqS9+wg2q172zry+0GwBsjeSMHxHQ1Xl46WMUUWt4lILfiwFlDRIXbp0+pYmFSch1NMjTLjO46YRaQCxTtRMSvIlofDCu2TEXn69OS4Hz3g/u+tD8EwJzJiqm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbOiHgkD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbOiHgkD"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso169283b3a.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783631267; x=1784236067; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rPuPvXowPtcow16dMkrbToVxdWAibRyIOhNc322mQvU=;
        b=rbOiHgkDib9+KRKR3bydYKzFsczfshkMMjcRhCVvV5pkiFuhkbgAR4onNcfH38Tqhh
         xMzpdcvjqwL1zU6wrVt/I1UhLh8Y0KC3FpJBC04uoPflNd0tDnwCmLToIS/9n/1NDTUy
         mlQcs8/iajuhAC8T4Hxuunmsuu9Wr9cEwJZ/JeLnH9raDFWWa1ICmNmha2bCTRLecgj7
         5X/8ndIdlabCjL/YkA1+ws5GE5KVjVCYjzbBirC5Vuf4GR966YJm3M0Bk1tWUB1Km60z
         LUO5CcL3vooM02XfIXXdzK4u31mZGrfpMHFWPLQOZc0IT6/sm9D73k1EGF+vzys9YWuM
         5o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783631267; x=1784236067;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPuPvXowPtcow16dMkrbToVxdWAibRyIOhNc322mQvU=;
        b=gdDXBApmRTYaCUIS+QcTEr0n2HV0unuIBxrxgvrZzfBysmYqhozLSFyYJNxCjQSMMe
         Z4mxY4j+G5f827qFWAcybY7u6TpIlB9JU/2+19fL2i48gVipLBdqJ6/9MVPc7LyPCpdu
         zcPROaDwb7vASyF+zN1NjxjBPhqVO1/ruYdDNzR2/ONeWtVwYNEsiTxAgJ1fHqW2Gibv
         wxej95xJGN0uQL9pYNxi5sUwCVZ2gUBl1qFk1nEicloYerlz7RiuNFIS1XHZZvFNMLj9
         58FatbAXNmoKXedF5E1Do369oH4G6ETERCUVFTfeQn8RpekWhwDod38JEPJ61/RFAwx1
         0hGg==
X-Forwarded-Encrypted: i=1; AHgh+RpYgAq3g29w15b8jdvw96QdRgMpViOrGATDXfzmiV6THlZ/zXL62k3GTOIGNt+tCqNuH4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAWgfmzG14GJgbgXjdKnZIHjWMuJ3lkmOoZH/thriCqUEd+5KM
	wp2WWC6U+7Cri3C3Py+WM5a51nnmWDvalqtYGfg34a6MxJQBXFBsBxxgHVWyOw==
X-Gm-Gg: AfdE7cnMXH6Zb1jWI1Ue2EQ7b/kCvBnZrivaYOrf8dtxRSqZYr3mxowgLksPiDvhG/v
	zSW5SjfB3iO4ra630ahw8gPSh3JeFNt+G59ILy4y9AlF44VGEijmvZdQHcAE+sMCo8vwFlC7NiT
	c17aXHPDED4h9osg1uRqED9LTkRbZ2u7w1E+A239oj/oGUFlhKATfjURgl3NgvVP3gg3jVq1Ctu
	LIdm3s+ljKMqkQmFzZCnl8kOjOYDgUlxFRhu+bpvVmO5vYw8aDKWrQ7tHOJuy/a6ltg8UZ2tkBf
	N8dXapn5IjTCCv8CP36WxtjydyFGBAMgyBeCsddHsaI4l8djEH6xKKyX9ja8Bbbj/FEM/d8AnBo
	qalwqGFB46SpYrDtE77ZNw8NTmRvoWyrkCd4Ut/85AUAoF6dXz43GrYpNHSQ3Dg929oqV6vTQpJ
	7+uXY+QweNtKd5SP8fm/4DIY+rV424LQOwtY61oZ6z
X-Received: by 2002:a05:6a00:1826:b0:848:3d18:2700 with SMTP id d2e1a72fcca58-84843233f36mr8433928b3a.71.1783631266711;
        Thu, 09 Jul 2026 14:07:46 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848337d12ccsm4616823b3a.48.2026.07.09.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:07:46 -0700 (PDT)
Message-ID: <825b731a390d0ecb7827c5a421aebd1dd1ee8d84.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/12] bpf: Account R2 of register-pair returns
 in live register analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Thu, 09 Jul 2026 14:07:43 -0700
In-Reply-To: <20260708201005.2158063-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
	 <20260708201005.2158063-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-08 at 13:10 -0700, Yonghong Song wrote:
> A BPF_EXIT of a subprogram returning a value larger than 8 bytes (a
> struct/union or an __int128) reads R2 as well as R0, since the second hal=
f
> of the return value is passed back in R2. compute_insn_live_regs() only
> marked R0 used at exit, so the callee's R2 could be considered dead and
> cleaned from checkpointed states, which would allow unsound state pruning=
.
>=20
> Mark R2 used at a BPF_EXIT when the enclosing subprogram returns via the
> R0:R2 register pair. The call site already treats the caller-saved
> registers R0-R5 as clobbered, so R2 as a result register is covered there=
.
>=20
> For example, for a subprogram returning an __int128, the live-registers
> dump (log level 2) shows both R0 and R2 live before the callee's exit
> (insn 5):
>=20
> =C2=A0 Live regs before insn:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0: .12345.... (85) call pc+2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: ..2....... (bf) r0 =3D r2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2: 0......... (95) exit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3: .......... (b7) r0 =3D 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4: 0......... (b7) r2 =3D 2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5: 0.2....... (95) exit
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
> =C2=A0kernel/bpf/liveness.c | 13 ++++++++++---
> =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 0aadfbae0acc..0977d32fcf01 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -2062,7 +2062,8 @@ struct insn_live_regs {
> =C2=A0/* Compute info->{use,def} fields for the instruction */
> =C2=A0static void compute_insn_live_regs(struct bpf_verifier_env *env,
> =C2=A0				=C2=A0=C2=A0 struct bpf_insn *insn,
> -				=C2=A0=C2=A0 struct insn_live_regs *info)
> +				=C2=A0=C2=A0 struct insn_live_regs *info,
> +				=C2=A0=C2=A0 int subprog)
> =C2=A0{
> =C2=A0	struct bpf_call_summary cs;
> =C2=A0	u8 class =3D BPF_CLASS(insn->code);
> @@ -2175,6 +2176,8 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
> =C2=A0		case BPF_EXIT:
> =C2=A0			def =3D 0;
> =C2=A0			use =3D r0;
> +			if (bpf_ret_reg_pair(env, subprog))
> +				use |=3D BIT(BPF_REG_2);
> =C2=A0			break;
> =C2=A0		case BPF_CALL:
> =C2=A0			def =3D ALL_CALLER_SAVED_REGS;
> @@ -2237,8 +2240,12 @@ int bpf_compute_live_registers(struct bpf_verifier=
_env *env)
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> -	for (i =3D 0; i < insn_cnt; ++i)
> -		compute_insn_live_regs(env, &insns[i], &state[i]);
> +	for (i =3D 0, j =3D 0; i < insn_cnt; ++i) {
> +		/* Advance to the subprog that contains instruction i. */
> +		while (j + 1 < env->subprog_cnt && env->subprog_info[j + 1].start <=3D=
 i)
> +			j++;

This loop is very in-elegant. The outer loop can be changed to iterate
subprograms, with inner loop iterating instructions. Or just use
bpf_find_subprog() when processing EXIT.

> +		compute_insn_live_regs(env, &insns[i], &state[i], j);
> +	}
> =C2=A0
> =C2=A0	/* Forward pass: resolve stack access through FP-derived pointers =
*/
> =C2=A0	err =3D bpf_compute_subprog_arg_access(env);
