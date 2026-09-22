Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com [74.125.229.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C5E48EBE4
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101676; cv=none; b=Y4XCgNV4nl0RvKucGkIEX1JKP/4xRCwpEMhsHRJWa/EV3iODandkeGsXQ34TdsCK6/sZIVXANDBAUXculUMGLYnv9rkqTcvHUKieLw0enMzyVg85gQpWshitMFiwWKl/LtQwAzUesR5hv+owGiStzjCeEVSRQ9A9PxOI2VG6x5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101676; c=relaxed/simple;
	bh=SqJRGWX38G3kJVuI62BgV9zSzqgul/JTk+pKqHYY2Ns=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B5tRK+M+LWamm4hu27JLaEG8LBH32/0T1M/hTTgiYOH26PkuI04lx6EMWdFHBwBd4jfkuQ15h11rVio2Hs6JwiQReNf8ysNtuKo0eip0FeYgxDk2xWVoldKQPcxOFlsDqoXjh8SMBAdXozLgqxL1wl58BhCYoI4jtv/zUKT1Drw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvG359hJ; arc=none smtp.client-ip=74.125.229.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvG359hJ"
Received: by mail-dl2-f39.google.com with SMTP id a92af1059eb24-1438cb9b3a3so127568c88.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101674; x=1790706474; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZaJczzxn/CjFtJ/kHvESPeglDyllsRtefI9OJdfF7NE=;
        b=FvG359hJBfWV6DxpNJm2SMAa7nSqoLkiQ4OkUwuAIafeOcwd3UbYwDUPKp7B374kC1
         0sUtfy2gdM3n6QBySl5pSopCWoHISqL1bJUIQpy6I8XcKZomQ1v8y+UIWgEEl8me4Uak
         6ZjOmks+3Hz6Y8MgYsaB6wcwGAZHVMv9N+/v1jI73y4nx5+4uoL5J/huEb/U37pk54Ar
         OJW2SZd7Gok2+Y2gPZn1OK6vmYE+2CMxVjdweTyujSPtKIxhvRe4S35J/sTAbP0hq/oO
         IcSCRI3GLYvYf1mgBTL+eRUJVv2eUascc0Gg9Xuzbq4h4t05cG1j1esutwgB5egvjIBK
         U8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101674; x=1790706474;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZaJczzxn/CjFtJ/kHvESPeglDyllsRtefI9OJdfF7NE=;
        b=FA3LCGcA/aEPFQYVh2udXbONIY4+Rng2xzOMae4qi/MPr3amLqwOBUM176WPxBCwdr
         7KsjNmTir3uzy+q0L+l9sj5ybYX5k3lV4/SpE/ePs+BMGYzawvnrjxiZipdXjpPozAW7
         3fgiNQHiK5iE8tc8fJOuYJ6pPRqoPtXq4w/icjswHmoTqSkveJQjNOIauYycDYqgv/jf
         hVqIK4F9AGnm45Wa6h/hbFG7ub+TzB1J5cz5X6XImDk2clHPwHFo901UkPmo9qhmIyRB
         ArQxtDsDMPmIjKFemJsnSohNWMo8oICEl8jnDAOgMY81RqBbg9VvMKOItrBlEyiKfo0V
         3JzQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9gXX7oklHps864W+Gl5bYffZaoHn0geXadt7wzIERAmpe8TfERls1fXpQMyMzCj+obPY=@vger.kernel.org
X-Gm-Message-State: AFuF++mPKKtXPZjn+3LwZqEmTDf1X44kLl+5m3Gqtd8iXAFSnEdlCHwK
	SbjgqtK89Pqpq3VhSVTV7wF/p8c5TGekVaT5ZcGfrhbOojAt4qZxDERKUAy5SNnd
X-Gm-Gg: AYBFou0XjbSYBlF9+uNSJiDaZMGMqnFnaIk/QOefog9t4u2FyhD3hzorQdQp3ulxaF2
	qF0QV8h24tHI47JxsKttp6bLE6/Ad36meTgO7CiovJuZ5emNi5SoaTLaDwG73nPLMSkVp2HrFJE
	htxbbAMXlgbFIsglr2hXo1pFC9jb19vcH0y6XWV81j0lxybOy3+bIkUCIALLSB98ew/6TFvpE0z
	4K5jvMAeJ0KUr55EsznVhVw7diGd6oKbx5fOt9Y+qr8gkXQzX+AwW3cgaRahGxB8jHA7Itquzft
	Y3SO60PMZ7Lnv+q5oJkMNJRKPpnhfwq81iB8DGfI0yS04kolQ6DayLGP4+DDIveTvMjGWmMGgZg
	5WWUgU/6AhCb9dmWZl8hZdefJWtNUrARAFR5FtMxgzYs0w6TG/BiGkODSgCYKSoghRKmL8t9eft
	MCH1W+uXI2uW96AeU5PcaBXUIq+zZ+ScLlWO/ChTJUX2W0L6cVyQ+hu4CZJ574RBCiy29CVJ4Fq
	hC5vzb9i2SDHXWlvPpWV+HkRlYE4r9hD/thn37DWLSaLjPjr4OmiUIDfQ==
X-Received: by 2002:a05:701b:2917:b0:137:c0a7:8d01 with SMTP id a92af1059eb24-144f91b1bebmr171588c88.23.1790101673741;
        Tue, 22 Sep 2026 11:27:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f4d5:5623:3480:5143? ([2620:10d:c090:500::7:fbb7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98a288esm207247c88.13.2026.09.22.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:27:53 -0700 (PDT)
Message-ID: <8fd3e980749f4a5ac10ff5d3d1704e42c1bda643.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 04/20] bpf: Prepare for an exception cleanup
 table before the CFG walk
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Tue, 22 Sep 2026 11:27:51 -0700
In-Reply-To: <20260921210053.1717603-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <20260921210053.1717603-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 14:00 -0700, Yonghong Song wrote:
> Some plumbing work is done before bpf_check_cfg(). More specifically,
> insn_aux_data records cleanup_throw_site for every bpf_throw() and
> cleanup_resume_site for every bpf_unwind_resume() -- the two calls a JIT
> lowers its own way rather than as calls -- and cleanup_pad, the landing p=
ad
> a frame resumes at, for every call within the [begin_off, end_off) range =
of
> a cleanup record. Subsequent commits consume all three.
>=20
> Marking the two calls here, rather than recognising them in the JIT, is
> what makes the recognition exact: by the time a JIT runs,
> bpf_fixup_kfunc_call() has rewritten every other kfunc's imm into an offs=
et
> from __bpf_call_base, and a BTF id compared against one of those offsets
> could match an unrelated call.
>=20
> bpf_prepare_cleanup_exceptions() runs before bpf_check_cfg(), because wha=
t
> it produces is what the CFG walk consumes. It refuses a table on an
> offloaded program, on a program whose JIT cannot dispatch landing pads or
> which the JIT was not asked to compile, and on a program that also instal=
ls
> an exception callback -- two different answers to what runs on the way ou=
t.
> bpf_jit_supports_cleanup_pads() is weak here and says no; the arch patche=
s
> provide the real ones.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Just a few nits.

...

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 325a80ffcbe2..fdee9da6b45d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -686,6 +686,8 @@ struct bpf_insn_aux_data {
>  	bool needs_zext; /* alu op needs to clear upper bits */
>  	bool non_sleepable; /* helper/kfunc may be called from non-sleepable co=
ntext */
>  	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
> +	bool cleanup_throw_site; /* call to bpf_throw() */
> +	bool cleanup_resume_site; /* call to bpf_unwind_resume() */

Nit: There are 12 bools here now, followed by a 25 bits hole,
     let's move `orig_idx` before or after flags and convert
     all the flags to bit fields. I think it can reduce the structure
     size from 144 to 136 bytes.
     Also, why not simply `throw_call` and `resume_call`?

>  	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog perc=
pu alloc */
>  	u8 alu_state; /* used in combination with alu_limit */
>  	/* true if STX or LDX instruction is a part of a spill/fill

...

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index 4b3ac93e98c1..67af78baa558 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c
> @@ -18,6 +18,66 @@ static bool insn_is_unwind_resume(const struct bpf_ins=
n *insn)
>  	       insn->imm =3D=3D bpf_unwind_resume_id[0];
>  }
> =20
> +static void cleanup_mark_kfunc_sites(struct bpf_verifier_env *env)

Nit: the 'cleanup_' prefix in function names triggers me a bit,
     as it is usually used when there are some cleanup actions are
     taken by the function. Maybe drop or reword it a bit?

> +{
> +	u32 i;
> +
> +	for (i =3D 0; i < env->prog->len; i++) {
> +		struct bpf_insn *insn =3D &env->prog->insnsi[i];
> +
> +		if (bpf_is_throw_kfunc(insn))
> +			env->insn_aux_data[i].cleanup_throw_site =3D true;
> +		else if (insn_is_unwind_resume(insn))
> +			env->insn_aux_data[i].cleanup_resume_site =3D true;
> +	}
> +}

...
