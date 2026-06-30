Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5734367293
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829795; cv=none; b=RYO2vL22+FfAebxNWIxxs/W8XpBx6etcL3ohuCVtLlBLbCJQEAdcFm1G6cji6aRmdTTsvsMsRW6kT3KeU4TYTg0xMACA0MNT2bUIHbQg7+rq2cOQX+KSsLTNnWTBGQcaTaE+z+wFDJn4i6hDSpMHRb54PpXhjBzutE4lKOZzmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829795; c=relaxed/simple;
	bh=XB5/HxhQqdQ8YGB3UdBFx2vnW3DyNGk60DM94fj1OVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGFf0lqY5C50dmRz48OVilXU4ltpVPrPi6lgoG+4/DYWL9PDLbxhdT+uGiB6ItqFLwdrvHEeintHCv060Dm/JiQxA8iZQp/LZZNclcBp2A6Xj/jjJl84bPHgvy9rYb4TsQ6u9GVrBi9+PlXnOCYseM69bbGiID4CRrMWw7mqBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ltr0NDD4; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ltr0NDD4"
Message-ID: <e279c9a7ca6b16e52dc261560513b0eafdd70f87.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782829781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtWf0SqbB9bSY/lhkVPg6AA2VUz0YkcfJVPgbQc4rzI=;
	b=Ltr0NDD46BEL0kYiNym8LlFqxJSzvmjEL3zaCMBHnMdLuKxESASy1+k+R7FMY6XW0Ywg4r
	veWI0jsiiZifcklQ3RtT8v7CfC7FTpSeYkaN52Vt3VG3qORQub4YmScTsnXdjLAmngErFG
	KnyAISyLLFv59egNJE7F+yl4h2Ug410=
Subject: Re: [RFC PATCH bpf 1/6] bpf: Disallow interpreter fallback for user
 BPF_ADDR_SPACE_CAST insn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Andrew Morton <akpm@linux-foundation.org>, Shuah
 Khan <shuah@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Anton
 Protopopov <a.s.protopopov@gmail.com>,  linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Tue, 30 Jun 2026 22:29:21 +0800
In-Reply-To: <20260626154330.33619-2-leon.hwang@linux.dev>
References: <20260626154330.33619-1-leon.hwang@linux.dev>
	 <20260626154330.33619-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2026-06-26 at 23:43 +0800, Leon Hwang wrote:
> The interpreter is unable to handle the user BPF_ADDR_SPACE_CAST insn,
> whose '->off' is 1:
>=20
> static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
> {
> 	ALU64_MOV_X:
> 		switch (OFF) {
> 		case 0:
> 			DST =3D SRC;
> 			break;
> 		case 8:
> 			DST =3D (s8) SRC;
> 			break;
> 		case 16:
> 			DST =3D (s16) SRC;
> 			break;
> 		case 32:
> 			DST =3D (s32) SRC;
> 			break;
> 		}
> 		CONT;
> }
>=20
> On the fallback path from JIT in __bpf_prog_select_runtime(), reject
> the insn to avoid being ignored by interpreter.
>=20
> Fixes: 142fd4d2dcf5 ("bpf: Add x86-64 JIT support for bpf_addr_space_cast=
 instruction.")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
> =C2=A0kernel/bpf/core.c | 29 +++++++++++++++++++++++------
> =C2=A01 file changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0db6e55bad52..e92eb8b7f945 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2608,23 +2608,37 @@ static struct bpf_prog *bpf_prog_jit_compile(stru=
ct bpf_verifier_env *env,
> struc
> =C2=A0	return prog;
> =C2=A0}
> =C2=A0
> +static bool bpf_insn_requires_jit(struct bpf_insn *insn)
> +{
> +	if (insn_is_cast_user(insn))
> +		return true;
> +
> +	return false;
> +}
> +
> =C2=A0/* Fix up helper call offsets on JIT fallback path. */
> -static void bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, str=
uct bpf_prog *fp)
> +static int bpf_fixup_fallback_helpers(struct bpf_verifier_env *env, stru=
ct bpf_prog *fp)
> =C2=A0{
> =C2=A0	struct bpf_insn *insn =3D fp->insnsi;
> =C2=A0	const struct bpf_func_proto *fn;
> =C2=A0	int i;
> =C2=A0
> -	if (!env || !env->ops->get_func_proto)
> -		return;
> +	if (!env)
> +		return 0;
> =C2=A0
> =C2=A0	for (i =3D 0; i < fp->len; i++, insn++) {
> -		if (bpf_helper_call(insn) && bpf_jit_inlines_helper_call(insn->imm)) {
> +		if (env->ops->get_func_proto && bpf_helper_call(insn) &&
> +		=C2=A0=C2=A0=C2=A0 bpf_jit_inlines_helper_call(insn->imm)) {
> =C2=A0			fn =3D env->ops->get_func_proto(insn->imm, env->prog);
> =C2=A0			if (fn && fn->func)
> =C2=A0				insn->imm =3D fn->func - __bpf_call_base;
It might be better to use the BPF_CALL_IMM macro. insn->imm =3D BPF_CALL_IM=
M(fn->func);
> =C2=A0		}
> +
> +		if (bpf_insn_requires_jit(insn))
> +			return -EOPNOTSUPP;
> =C2=A0	}
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env =
*env, struct bpf_prog *fp,
> @@ -2663,8 +2677,11 @@ struct bpf_prog *__bpf_prog_select_runtime(struct =
bpf_verifier_env *env,
> struct
> =C2=A0			return fp;
> =C2=A0		}
> =C2=A0
> -		if (!fp->jited)
> -			bpf_fixup_fallback_helpers(env, fp);
> +		if (!fp->jited) {
> +			*err =3D bpf_fixup_fallback_helpers(env, fp);
> +			if (*err)
> +				return fp;
> +		}
> =C2=A0	} else {
> =C2=A0		*err =3D bpf_prog_offload_compile(fp);
> =C2=A0		if (*err)

--=20
Thanks,
KaFai
