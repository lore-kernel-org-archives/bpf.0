Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B713377ED7
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082701; cv=none; b=nJfr0ydvm+LkxSNddPxqNktspckuKhThqZKWaNq7ng2wVgJwp7fV4bTDP5dPx7gyzrsTrBDFupFediAOKWp5tQoFD+XZD4RfOga9pkbN5C+GSsSsgvsIHR74jxRZddSlcdogut/1t1kFjPLZQmxhHL9ikYY6cbtW3L5I5drqnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082701; c=relaxed/simple;
	bh=pJVZuG2e+s0WIu360w39qxF+KIclqrrm5xifxFzGjTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NG6kts8/8jG9DizaCGjeQh9G1yspW278HbzdnydDaAoJsUM7GJlaiU2+5s0GcIObBi+obee/QKsC93IpgIKwgaKuRAm6uI/0mdOGRaEhJWm1JqyzZEpEpiYDLi2ds338bsCfyKOfh95MzC53nZ2W2pY0aI24svbDs45bsRV+Thg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZiuxPHs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZiuxPHs"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so478122a91.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787082700; x=1787687500; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cs56ktEKPoTyy3PP3ZEjw56ofGFK/4bObhJ9uURk2Wg=;
        b=CZiuxPHsSOfOOKWbtQ2ZjpBJMuf+tuAa7Aoj64WgsKcEtcHYGRQKzF61/SAttAo42X
         ag90f2SmTOMZ2ErtCKkkUAj7ezVz7lajO8A9BwmLgH8DlHei7POB+vCh6xNKC84Hzgyu
         iopvglEwqHc8msmVo30Uv5R3WXeyl1VMQ9X6A13yonlWpFHWvtae0S2GNSa7KyAsYBrb
         Xw09CiHTmbFlioukX2heU7u4D98GBHO77IlIzqP8vE0tDJicCOKld+ZH8dRQT8VnynkQ
         f4lcs0EpKijzwd2sIhS07YaeTBzqXdm02nxFkApV68eeOaryFVi9C2IdKaIrBbIMJjPq
         3FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082700; x=1787687500;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cs56ktEKPoTyy3PP3ZEjw56ofGFK/4bObhJ9uURk2Wg=;
        b=EQU6Pro9rYZzNNe3HnwvBtu2pYISzdGKHQoYsKG0LDsWuCxC2CDl2C6AJ75/hgemXs
         g067MzPGNKnfQKvYaTAjtauuI92qQbB9aXW4UVnIWGSOFjFqCeOBd6XwK1oNI/Wpt+5M
         boFBLKkDfpRpkzZmoELfR+cncDxDncoMK9CHnwws472OFF9otvSF8eClsrGf7lAaGk1f
         YjGmkL0qjB0thiapbD9sD7T19XoYln5LBN9ilszlunJT9zH31m5tMrWt5e7NRT4y0jmI
         78J+z/E4Al23v95OyYrV2rj67YWuUwA0GqrZ3Fv0s/X9OUkkvMOIlJtxe2gUDmdV3AxE
         AW+Q==
X-Forwarded-Encrypted: i=1; AHgh+RoC5qRsY9HGOQG8WJgHn0kkPH/lhHdBm9JWUS8lE2tWpfGiYtZ2zFTs6Nzc8lL7WKhJKPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEO1k0jixxwNc3jdiiXShn7TMyLkAOHZIbj8MMJKMB3TgfLIi
	TpfAY/sCoJY0Qxg4WJp4Bo4YF/9sil6D9A9KSbNK+AGezC9+T9RZ3biC
X-Gm-Gg: AR+sD13P9ymUvsp9fc8zm7nfI7eIqddv3jCsmJBjLjVhyUapiy/d7Z+oe1IW5a8hS/k
	2HV5uNz1HB3Sj9yG2/Sag2rYrVT0TiH9rqj4wYWusIuGdDxRN7RSu/0dihJQuY0biLkgmwikQ/T
	oLbZAS48cn74jRVs1aiVFov3xOeRJZ9DgCp2Vx+rlpPi2DPb3bkzK4uB2n5gq/w5d5vPUdHAjBd
	jFVXVm4wfIKJNjdM4Alm8QubrW23INjW8MdJX1J2ruZXZPF6HbLVo2UQjVMKo23v+g9nuU2B/EN
	8k0q/WMH37gA2FID2kUnV9ZQ6nbzjgfCxr9s8bCX5atkWYqZTm+lEQBhaJdyhm81k6N8huTY+7z
	S4HGbBdI5bY/TxJd55NBLFjplYrLg3TFZLfD9lkkBukL9wNhIyqsD0PlSw+3eSXc01gP3p3Bbb4
	1jSVRDdaARwIuCf5MMllT/IV4CAudVp4fFzQ4HZt6W7NHl9E3yPoCC8aQzNEh9E4i5WoaJsw0Wj
	7yzO3javuktJ4cx
X-Received: by 2002:a17:90b:28cc:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-3957b2c9928mr278503a91.9.1787082699851;
        Tue, 18 Aug 2026 12:51:39 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395320229f4sm9159793a91.15.2026.08.18.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:51:39 -0700 (PDT)
Message-ID: <b8ef4589e63fb411f830f426eb4890901e99f30c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 02/10] bpf: Add helpers to describe the
 R0:R2 return register pair
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 18 Aug 2026 12:51:36 -0700
In-Reply-To: <20260817042151.2286855-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
	 <20260817042151.2286855-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 21:21 -0700, Yonghong Song wrote:

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b3c474ba7140..f1f1268d29c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -385,27 +385,70 @@ bool bpf_subprog_is_global(const struct bpf_verifie=
r_env *env, int subprog)

...

> +static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
> +{
> +	const struct btf *btf =3D env->prog->aux->btf;
> +	const struct btf_type *type;
> +	int subprog;
> +	u32 size;
> +
> +	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux))
> +		return 0;
> +
> +	/*
> +	 * Skip the main program: its return value is the program's exit code,
> +	 * read out of R0, so it never uses the register pair. An extension doe=
s
> +	 * have a real prototype for subprog 0, but bpf_check_attach_target()
> +	 * refuses to replace a function returning more than 8 bytes.
> +	 */
> +	for (subprog =3D 1; subprog < env->subprog_cnt; subprog++) {
> +		type =3D subprog_ret_type(env, subprog);
> +		/*
> +		 * This runs before btf_validate_return_type(), so apply the same
> +		 * type filter here.
> +		 */
> +		if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^
I still think that only !type check is necessary here:
- btf_resolve_size can handle any type
- BTF validation should guarantee that return type is not e.g. BTF_KIND_VAR
  that would trigger -EINVAL
- for local subprograms verifier checks if r0/r2 bear compatible types anyw=
ay
- for global subprograms BTF compliance is enforced.

Could you please explain why would you want to keep it here?

> +			continue;
> +		if (verifier_bug_if(IS_ERR(btf_resolve_size(btf, type, &size)), env,
> +				=C2=A0=C2=A0=C2=A0 "cannot size return type of subprog %d", subprog)=
)
> +			return -EFAULT;
> +		if (ret_regs_cnt(size) > 1) {
> +			subprog_info(env, subprog)->ret_reg_pair =3D true;
> +			env->prog->jit_required =3D 1;
> +		}
> +	}
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0const char *bpf_subprog_name(const struct bpf_verifier_env *env, in=
t subprog)
