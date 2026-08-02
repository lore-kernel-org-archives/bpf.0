Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0292331ED3
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704532; cv=none; b=gkU+TZ/WhW0aqBwh0xwwp83bHZ5jPreiuthILPLIH17DTuImE+btj8h9JOIBYFlKkmmxQ8Qe2Tuo8e4mFW8W6lUlL2WFaRycvOVpHvC98s21jYFxyZJ7/mx0KHyd4qk1p7BekEajgrKmkFRPi4LoMj8YVIXRSNUUgf9i2PHK+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704532; c=relaxed/simple;
	bh=V1ii1wKgn2OqW6d2LLPyM6cXA3BUBIGhXP0boNaX3Gk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DOCsX6BDrhWdFI8SNqz7C5uwlKKk1XZpqX0w6dTJtzt5l9/Xwr1B74T5JNEIX6m4jB4YsgguOgn4w3qbqfFC9/6wC3Wux+Euui4+8pmXLP+trQpe+IvIrodv2x8VVK0gQy4s+qnIf+xHje2Bnm9MIgsZUq1G1sBwr4gUrki1dZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPgNjX4Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPgNjX4Z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caea3f742bso27591505ad.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 14:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785704529; x=1786309329; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m87Rd7sxV3kUpL/XW/U/fVnqUDc0x1+SxmtMwsKkioM=;
        b=YPgNjX4Zq6ATA9NbP89S5wo3Xdibds4w0MmbIhaKIX34gg39SGyKd3QMHLuAMfCqWg
         Uegl8isk1IWxZAbZoWmcVRhB29T9Q4ghLevIN+PqqBGeetyKRK99cipfMKcq4dN+iRnA
         ix9QDCLZ5T1axMPbmtKAe0Z6l8G5cEASj1DaJq8wkHwQ/0liC6dmOC8Za6whwH8fa9Vk
         CS0/vEAD9hVIV016WKvASOh0OlvnSZ51p1TnTiQpnfYAsWX56pVYrFlvv53D6Lhxapsi
         apYm700vcFsAWpIupy1gpky3qZS/3k9BnioDBKhjnV4yg0n1U+VJWOMbhcgIlLpukNti
         rvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785704529; x=1786309329;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m87Rd7sxV3kUpL/XW/U/fVnqUDc0x1+SxmtMwsKkioM=;
        b=MX2toT6WUFE0Uwdae/ahhF98wMIAMk8+1A/uFp5wp2kQVy4M6fY0IR8B57QTbo+fvk
         MGA54zSeOLuuxgt610dzN8p8AvHp0+JaEGVU624oi5jjvYUv6NjIEf1nmJs+lSOQ3376
         vOcNGq5lAnbEaQFTwtNQLZu5zGDvBdd1ldlcFV9V6MVu/MbGlPjL+Do4beBop366urhH
         F+YA7g2hlpMgi4GckO+JKixtAM6/+fpwxUB3Lpjs0GdvuojKk5IGmQLHz+Z3Oa1GxaZ3
         aqqjXodzAN15PjvIgdCqoHk+PlFhxjgZAL/ZjTQOAJHM26aYNpJenD9QIajHrlhTNyzK
         0g7g==
X-Forwarded-Encrypted: i=1; AHgh+RrBoeUsetbslf0neLWd2/oQGQOy7Wp9TfRpDspDG43wh4hWioB9uXLrWibtAtkBdHA2xvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60gbpxohhwJ5tyEmf2m9/zd563rVeqI88OzUhvG5sper42411
	TEqnj2WkCebM8bLcrN2Ln98XGLLaUYth4nHFRFV1ofK8IWB5Q1JHIYCM
X-Gm-Gg: AR+sD13UJ0IIei15QFthOxd1RHGQqxGTeOqNSdfpjy/jucNhMH9/BZYxh16mRuE4rjO
	tUEUL9brzP5ws47Umko9Fl0rqhZ1uxeSi3k/41qYgTUpMA6Q6q+TT6TbTKom15c2XhJNF0DV4ge
	NohqcFraVbJE4pzJbNo/rUhZcsHyG2RTckp3EG7voVuW5kVLZVlRukUiBxMUDUtLiiMVgfR2U4j
	QKYV/019NZV/DrxYWIu4+DSNBoDhz40AdksErpUtsFiWG+NGeULrJanxD2GccWFZtIXiTc4yArJ
	obOK2xcX918Gh/8l0svwRRz2S+D6n7aPYkH6y1LjmVtnegJ5EED8bwehuYUc/GSvHmVWiXksY7Q
	DzPNNaGnR2zi0aRxIRZygRbbktDn+UWncXbwVM/kLIp2trKihqXOD2yWze71R059AzeEitVdJet
	64me9Zp13ntjEpuWHyd1IcflqUkE071xZdhroZcZ6qxq+fKpN5J8FRfNBW8e4SE6igATR/QnEhh
	uuzNGn+h5YZHZwI
X-Received: by 2002:a17:902:d98e:b0:2cb:3f5b:6663 with SMTP id d9443c01a7336-2d0522023cemr78409435ad.11.1785704529103;
        Sun, 02 Aug 2026 14:02:09 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19ba5sm29094855ad.17.2026.08.02.14.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:02:08 -0700 (PDT)
Message-ID: <ae774dbff74cb78cff1fe27915a9bd8fc4bd990f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Show more useful info in stack
 depth stats
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil Tsalapatis
 <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sun, 02 Aug 2026 14:02:05 -0700
In-Reply-To: <20260801230400.850271-2-memxor@gmail.com>
References: <20260801230400.850271-1-memxor@gmail.com>
	 <20260801230400.850271-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-02 at 01:03 +0200, Kumar Kartikeya Dwivedi wrote:
> Currently, the output of stack depth statistics is two crude, with a
> list of captured stack depths ordered by the subprog numbers. The actual
> subprog numbers are determined by libbpf, hence it is hard to associate
> the stack depth statistic back to the subprog by name.
>=20
> Change the format to:
> stack depth <subprog>=3D<depth> ... max=3D<depth>
>=20
> In case the subprog name is not specified, use subprog[N] as the string.
>=20
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> =C2=A0kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++----
> =C2=A0.../bpf/progs/verifier_basic_stack.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0.../bpf/progs/verifier_bpf_fastcall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 19 +++++++++++--------
> =C2=A0.../bpf/progs/verifier_private_stack.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++---
> =C2=A0.../selftests/bpf/progs/verifier_var_off.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 ++--
> =C2=A05 files changed, 33 insertions(+), 19 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8d0635ee48c7..51ac0a9ae339 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18703,10 +18703,18 @@ static void print_verification_stats(struct bpf=
_verifier_env *env)
> =C2=A0	if (env->log.level & BPF_LOG_STATS) {
> =C2=A0		verbose(env, "verification time %lld usec\n",
> =C2=A0			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> +		verbose(env, "stack depth");
> +		for (i =3D 0; i < subprog_cnt; i++) {
> +			const char *name =3D env->subprog_info[i].name;
> +
> +			if (name && name[0])
> +				verbose(env, " %s=3D%d", name,
> +					env->subprog_info[i].stack_depth);
> +			else
> +				verbose(env, " subprog[%d]=3D%d", i,
> +					env->subprog_info[i].stack_depth);

That would be not very convenient to parse by veristat,
but I'd print every subprogram on it's own line.

> +		}
> +		verbose(env, " max=3D%d\n", env->max_stack_depth);

I think check_max_stack_depth_subprog() needs a similar update,
at the moment it reports a not very helpful error like this:

  combined stack size of 34 calls is 528. Too large

Printing the offending spine would be helpful.

...
