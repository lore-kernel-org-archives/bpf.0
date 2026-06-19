Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A133FE36
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893970; cv=none; b=sbvYpX0X5IcqIz2E2h8asgJqNWf/fcT9XA9e9gxUjvTsAjcCy25oFs24kJe9zpw9piFKPRnqoaKsixGVvF9LhRnO7Z0YLj3dMWyzhljUPSkvBFoyQs/hMTzt3Acc8fn0/3bSB+TEajusMPT0UtTTFv04JYKLQRifoq4D7CqG3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893970; c=relaxed/simple;
	bh=MRikFyOt+Z+9KskamX/Piwxe18I7k/0vTqp7ubH2UfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LULynplsQF1eVuyYRXhetyF8lDUhiYzDdtal5NEv+jyFKWcMrYp+oSYOmMpBvaaiCnls/5+sUP3JUAZI3umxmyfmaxYaSVVrXvJRvFVXGL0kE8yZgiEou+kongz4GkUeVT0ODBpk4bt2LLVdKJWua4WY8EvJq0wTZyGmDc2UkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhBEhgFU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhBEhgFU"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so1690114b3a.1
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781893969; x=1782498769; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cEb6cMeL9zrv839ZEgK5GghTYMMas14NtTvMWavtAx0=;
        b=HhBEhgFUovrHZODD5NRhDBt2tq1Fbcev/h9XK2X0dmpDon5q1Pq1LUZvX1v0OSUnI6
         pdMSKZlyRVF8JmTJk9UVrkElGRJKVhsL2hWU/JP3yWAj8/YbAy4m8TxRFW4PnzwDBlhA
         TJK0zohvam1ox79f5Dx3YVRL0On178FuwHpQ5r5+V4rdH5nDLCZ7rGDE12NUjjbq6bsi
         XpreIYyXsyvW+H+X+3twa0GKXEHFBrivRn22HjwuG9Ed3C9eZFKunMJzUItNDkk6hJue
         rnZkTAQ9c8/QR+F9k7n/mfX20LiKX20Flbiz5/2OXsEgE22dmYqZNqBWUFWQrjNrq1z4
         nFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781893969; x=1782498769;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEb6cMeL9zrv839ZEgK5GghTYMMas14NtTvMWavtAx0=;
        b=MMzx3UnovN3t3G8NBipAGI+Al9VuFqKVB/+iry12nWbvuzAZ1BoUMwcS6hEudLTm6b
         CUshtKux3R0buAeUqVL0PWnv2KXoMYzW2QrmcdKEWrsBJ89QeKcS06L7Zd0NyWGEhgJ/
         PPuPJRyFENohuxGFkj9Zpm2uQFQsSUj6n8MVrPM+zOu2Z5LLasj5cd+hmcPuPQrLM+tT
         hOmPlkgovq4Z2g8dY10Ww7dNzVA9FKNHtZy4daK+cu2f/zl0YC0Ei2Fn9GP6Q7SkuA4g
         7MOX8sN2BHHAUn8UUyADsHQHcCh175WgKoxn13QmWTqjV+7oCEgWNM3j0v8Q3sXXoHVa
         m60A==
X-Forwarded-Encrypted: i=1; AFNElJ+0HC/pMfxcshmJ7/J9wFSw+78LfjBymAH82q5vflnQMYPVXNRyVy66wRBYe4IHTsl6lNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YydiRdqhf4hSqMaxHwRXpr9rXU3K9tQ1CC209JO7k/VJAmmo0fw
	+I2qZ/u6g8b7DomiBnxxgLThp1lU8pHnUWfv3fYWT9WqfnhaBPveo6fM
X-Gm-Gg: AfdE7ckZ/FRqRw0MI1rfI0zt5mFW2hFsbQwiwztq7658UpCH9HJc5yC33Vo8m1d/sIt
	+0C/QGhbg2f4xLpcCf/XkOHJiIE4P7pr/DN8ewP4bb8qd1/In5dDJQYr6eb/xQafmb/R2j8MPMN
	mgwDKQgTS+PupRiDkLSyrcBnyZrhh0XahbYC15RA64IRO0w+Ixet4JIRj43iIybtv5zyoMEvlPR
	CWvwHktoI0FExwPdOrpT20Y9pvA4CkOKO3Bou7cM+S1TUIQiw7igiN4n7bzdKSR+HxLKKoSemKk
	AwbSb816R9nfAVFa0MMt2ZXUwfDXkYGLwry1bRMQTGlOzTL6KuVvlgalwwawPcFghTPTxYvNlx1
	Mw8v+OZLVJsrHwVXsF9Z+yVRXGFn6c8QFJL8VtWcR6wCiC2f2gRTtvRDOkSIAladDwElfLkwkkv
	kxyeWSS4BWajSRKqkVuTNJNQ21m2/lIPSyZ3CcXeQEHw==
X-Received: by 2002:a05:6a00:1816:b0:845:4f08:17eb with SMTP id d2e1a72fcca58-845561b8924mr3755898b3a.46.1781893968619;
        Fri, 19 Jun 2026 11:32:48 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455382b766sm3776281b3a.47.2026.06.19.11.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 11:32:48 -0700 (PDT)
Message-ID: <4eae275e93d8eb165da8485a127a1fd0e7f91510.camel@gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Reset register bounds before narrowing
 retval range in check_mem_access()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tristan Madani <tristmd@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org
Cc: xukuohai@huawei.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org, tristan@talencesecurity.com
Date: Fri, 19 Jun 2026 11:32:45 -0700
In-Reply-To: <20260619110251.2576334-1-tristmd@gmail.com>
References: <20260619110251.2576334-1-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 11:02 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> When the BPF verifier processes a context load of an LSM hook return
> value, it calls __mark_reg_s32_range() to narrow the register to the
> hook's valid range. However, __mark_reg_s32_range() intersects the new
> range with the register's existing bounds using max_t()/min_t() rather
> than replacing them.
>=20
> If the destination register carries stale bounds from a prior instruction
> (e.g. BPF_MOV64_IMM), the intersection can produce a range narrower than
> reality. The verifier then believes it knows the register's exact value,
> while at runtime the actual hook return value is loaded, creating a
> verifier/runtime mismatch that can be used to bypass BPF memory safety
> checks.
>=20
> The else branch already calls mark_reg_unknown() to reset register state
> before any narrowing. Apply the same reset in the is_retval path so
> stale bounds are cleared before __mark_reg_s32_range() intersects.
>=20
> Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v2:
>   - Use [PATCH bpf] subject prefix per Jiri Olsa review
>   - Rebased on bpf/master
>   - No code change from v1
>=20
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281..6de9af4115dd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6196,6 +6196,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
>  			 */
>  			if (info.reg_type =3D=3D SCALAR_VALUE) {
>  				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
> +					mark_reg_unknown(env, regs, value_regno);

This seem to be a real bug, could you please add a selftest
demonstrating the issue and post v3?
Something like this in the tools/testing/selftests/bpf/progs/verifier_lsm.c=
:

/* lsm bpf prog retval load must reset stale register bounds */
SEC("lsm/file_mprotect")
__failure __msg("div by zero")
__naked int retval_load_resets_bounds(void)
{
        asm volatile (
        "r6 =3D 0;"
        "r6 =3D *(u64 *)(r1 + 24);"	/* return value of the LSM_HOOK(...file=
_mprotect...) */
        "if r6 =3D=3D 0 goto +1;"           /* r6 value should not be predi=
ctable here */
        "r6 /=3D 0;"
        "r0 =3D 0;"
        "exit;"
        ::: __clobber_all);
}


>  					err =3D __mark_reg_s32_range(env, regs, value_regno,
>  								   range.minval, range.maxval);
>  					if (err)
