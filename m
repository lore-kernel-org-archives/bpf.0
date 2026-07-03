Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7207C233938
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086947; cv=none; b=R45V5bPMLvxrUgYaaLZbuNJJFxOPX6dUyKh5Qw49Rg+MqSu+7TtTabyAXMhZc1CzNlrIL8mlCfJI2lntLHnDY+57IrzkcuK3aGj7CLYsZB6u7nYX2+K2+hg8JQ3GW+czMCDTOWVfvIuYfEVxpJXbCSJAQp6y3w5qkMfTkVq1Cs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086947; c=relaxed/simple;
	bh=AjsMUITbNJjqRVHQqNB92+lmJXXYytvIAIOnhNsE7W8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1OjndxaQc2NLDeP6tOJXocve14TWJ8Vpucu1I51Bpxx0fWKJZfN7hoLB0O7Yw0H8TrUFEgoTOG/66ytAiXO8AeFja0/hD94eEwTPpXwNnKx/ho5KS7V6TCYLoc6yWNrqVhYMZAuWzTy4tv6bejdBqtzQmK6KhxabQUwb8y+AO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IuhhUH0l; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IuhhUH0l"
Message-ID: <ba5679e744e0209ca10788c2c385c6727eddb8a5.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783086932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGR/5b9knkt8wlYmzKxEBT1l27F2pxe1Z4zuAB48w5Y=;
	b=IuhhUH0lF6CJ+EWcBsRB+fjjNppcBN/lYhkYpu5yrjN4YrSpudzchIvveiQS9BXCJ+5B3J
	DbK/TFsN8iHyuOhlTZBUGBZVmL1E/C2JSMK/fqV5j42HhpJbRmjCzfy5HdvpOIutYW/mgv
	9plZ/RL42InppynMvq31oEo9+irjT08=
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, Leon Hwang
	 <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
	 <bjorn@kernel.org>
Date: Fri, 03 Jul 2026 21:55:06 +0800
In-Reply-To: <20260702143656.28845-2-yangtiezhu@loongson.cn>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
	 <20260702143656.28845-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Thu, 2026-07-02 at 22:36 +0800, Tiezhu Yang wrote:
> Introduce a 'jit_required' bitfield flag at the end of the
> flags group in struct bpf_prog. This bit tracks whether a
> program strictly requires the JIT compiler.
>=20
> Set this flag to 1 when a kfunc call is added at the end of
> bpf_add_kfunc_call().
>=20
> In __bpf_prog_select_runtime(), check with fp->jit_required
> rather than bpf_prog_has_kfunc_call() to unify the logic.
>=20
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> =C2=A0include/linux/bpf.h=C2=A0=C2=A0 | 3 ++-
> =C2=A0kernel/bpf/core.c=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +--
> =C2=A0kernel/bpf/verifier.c | 2 ++
> =C2=A03 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ba09795e0bfd..4e2b059d71f3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1880,7 +1880,8 @@ struct bpf_prog {
> =C2=A0				call_get_func_ip:1, /* Do we call get_func_ip() */
> =C2=A0				call_session_cookie:1, /* Do we call bpf_session_cookie() */
> =C2=A0				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
> -				sleepable:1;	/* BPF program is sleepable */
> +				sleepable:1,	/* BPF program is sleepable */
> +				jit_required:1;	/* program strictly requires JIT compiler
> */

In v6 you're using 'u8 jit_required', I thought it would be 'u8 jit_require=
d:1', so we use one byte
and left 3 byte hole for future use.

This version left 2 bytes hole, same as v5, but it can easily be misleading=
 because of the u16 type,
since we used 17 bits. I prefer v5, it has better readability.

> =C2=A0	enum bpf_prog_type	type;		/* Type of BPF program */
> =C2=A0	enum bpf_attach_type	expected_attach_type; /* For some prog types =
*/
> =C2=A0	u32			len;		/* Number of filter blocks */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..5fcd19ccb41a 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2619,8 +2619,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env,
> struct
> =C2=A0	if (fp->bpf_func)
> =C2=A0		goto finalize;
> =C2=A0
> -	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	=C2=A0=C2=A0=C2=A0 bpf_prog_has_kfunc_call(fp))
> +	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || fp->jit_required)
> =C2=A0		jit_needed =3D true;
> =C2=A0
> =C2=A0	if (!bpf_prog_select_interpreter(fp))
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 25aea4271cd0..f496b45b9da4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2765,6 +2765,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env=
, u32 func_id, u16
> offset)
> =C2=A0	desc->func_model =3D func_model;
> =C2=A0	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 kfunc_desc_cmp_by_id_off, NULL);
> +
> +	env->prog->jit_required =3D 1;

That's ok, and I think Sashiko is right about this patch.

> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

--=20
Thanks,
KaFai
