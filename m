Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82A47ACF1
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035092; cv=none; b=ubBh+mBJtunxy4YAYOUlGhg4ck3TySpGfK2OBrZ/9h//rQ+7IQaKCHg8fT7PcTK6POaBMs11i3RuiN4sgvq+bB2ocP8LnkMjmWgxIVKGsplKqlewls0F6Fj7zjsA6Z9fYnDqMoFJ9dS/nRoz8CGkNaAvCF5VhYKnglvFxU9NQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035092; c=relaxed/simple;
	bh=nHpGrsMek52xxUuKohWLLoCdxGrJ2O6koz/ft8SgdI8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ioKN9KRFWHoEAyCjlfdDZKjNDL+zUIJZ0ObJQKm/44nonJbDwLUlXfAdWXzfBUhKILLO4ekRDk3IZ7s8nV85oCvwA+6DCcZQzhhrIWorXcSeeR5uwJH0NKe6BqZQ0+4kqjf/rvF5v+GdfI4WTSARaRqiAhcY4H8eWvAoFL8mlp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXaGGJCR; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXaGGJCR"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso3131952a91.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 16:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790035090; x=1790639890; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7L/FFmUVZPZcLnM8JlJgKFiShg/Qk8dhz+8IAZCgvT0=;
        b=YXaGGJCRI//cisbBgme2H0XehRoCGAYomuPiyBBrXeIMXZTHgMgw1b7mRcbszxqO0X
         yNfOMeyDzxlK1jv9y7AUvl5/J19DSYQGaVrsvfZT8Hj0j3o+BhPYooiVXEaThCaYLKl/
         JL2862L0zxN8Ryto8gFsni/THSIvgR3k1FiHJXmjkw2hSkLL0J8H6VjRcwxKq7iRdM3L
         lD2Jgsg6iJipfSSCet9DdTQI7wZJi8+yZYRKWzk4nvr91wWf5Sk6YgcypCzMAgGv2+ac
         YoH6qwQ8Y1y7lkwlrp65manpBBFIGUnF4fSJFrDyyrhd7UUZAAz3DENWSJjmG+f5Zy5/
         mgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790035090; x=1790639890;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7L/FFmUVZPZcLnM8JlJgKFiShg/Qk8dhz+8IAZCgvT0=;
        b=zB3o2ICXmJRaeid62DB3j3dsUAfPp+sLjcrIdT+wVkX9qt04qCgVWqdv3/TtifLFfn
         HKvcEJW3Xy01ZhjQxzH9AsP2NEz5EjS8uuBcH/LWu7zHp7QFvJQkhFtnPsKVtyjPErVI
         k9jCacSzvJvgVHkQIBacpD8D/5+adsmQT22hlfbJrVk5Z2LWivJr+U78WOetVzNRGBMy
         Qj4nIdTc9EO9UurMNSduD8Nd7ADzfgD63GaXn3QXm1Z9+PT1bA9IvNZm2vuYksQsU+oj
         lxilJUHbhcqaykWct/0YvHtNjWW/fQZMvEz2HrbhBHHJsTmKTQClAmOlhGbcZeKg+lyG
         6n1w==
X-Forwarded-Encrypted: i=1; AKwUvByjaQ81RX5ZoyN05IVLc8KK8zE22oLgX4kG7PbPZnDmlWWlzA9+kNRKRtT22Jfmel73oVw=@vger.kernel.org
X-Gm-Message-State: AFuF++mcKMvKwfTU7Ek5PRIVuxXW0EOK8K5jqOqgDBhl1iAzoHSp7ZBb
	C+MHVLCvPB56nHKI6cVVQm3dXiyUkITflHGCROEHEcT9AR2TnWSX4NeC
X-Gm-Gg: AYBFou1DovW5zu74IzWEbnyEEsByc53vbM7u+bETeRIkedGGwuQZGc3SY2sx9dsCl2w
	YurUfUUMw8NCqcRp7l59qpqnimIir2J044YgWcAb1qLNXiXoy4FHKSpwo9SMeAGiaTxFagKEsdN
	rujE+ygNDQ7yvhIPn3LHzm3xv4T+xRcGlrpXkgd/UBOVPgIRKNDLc75w5i8wMjjECBHAgFhbDYB
	Ukml67KTEEjQgTpFZsO9WBYW6u2MWDTEQzF1gPLU3kxuwX46n4wfEp/ye47AKa5C2OUWBhV0A6j
	C7Qy7n8D7XJL4rucQZSLiTDvIi81zYrO2X1ofgLdOCjR80sZbLmMQzzXucWGtWNrfbRYTL+TH8L
	d5ekRr7aZLZn9AQqfW0JtjDeriVkt5NqZE3e3UoZ6o3uDX8N3bsYbgbBmIVLEt4aPquoqLKmLfu
	erlAYs/LAy6ukLdNQuU9FFXHmHJsRtHgPEs5yY5ijmAG+Skmh2FK+72buWdRgil/LN5JV9kV32o
	YXe6ow/Mzq4dGSKXF+Hd4BNVWVBfZda4FHEUQj7lfDNAWlRjPp7XZUSlA==
X-Received: by 2002:a17:90a:e707:b0:398:bee5:61d6 with SMTP id 98e67ed59e1d1-3a06ae433b2mr625694a91.24.1790035089677;
        Mon, 21 Sep 2026 16:58:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9de9:26b9:a969:69d7? ([2620:10d:c090:500::5:f95e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e612ccd46sm480562eec.18.2026.09.21.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 16:58:09 -0700 (PDT)
Message-ID: <cfed0048af0a603a4e71894e8a36c5ae2cf6bb66.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 06/20] bpf: Explore the landing pads no call
 site reaches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Mon, 21 Sep 2026 16:58:07 -0700
In-Reply-To: <20260921210104.1718697-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <20260921210104.1718697-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 14:01 -0700, Yonghong Song wrote:
> A cleanup record need not cover a call an exception can unwind out of: a
> frontend is free to emit a region around a helper or an ordinary kfunc,
> both nounwind here. Nothing marks a call site then, and that record's
> landing pad is reached by nothing at all -- leaving bpf_check_cfg() to
> refuse the program over code its own frontend had no way not to emit:
>=20
>    0: call bpf_preempt_disable
>    1: call bpf_preempt_enable      record =3D { begin =3D 1, end =3D 2, p=
ad =3D 4 }
>    2: r0 =3D 0
>    3: exit
>    4: r1 =3D pads_ran ll             landing pad
>    6: r2 =3D *(u64 *)(r1 + 0)
>    7: r2 |=3D RAN_NOUNWIND_REC
>    8: *(u64 *)(r1 + 0) =3D r2
>    9: call bpf_unwind_resume
>   10: exit
>=20
> The range [1,2) holds one call, and it is a kfunc, so an exception cannot
> come out of it. cleanup_mark_call_sites() marks nothing, nothing pushes a=
n
> edge to 4, and 4 through 10 are reachable from nothing: "unreachable insn
> 4". The pad is dead, which is correct -- no exception can ever arrive at =
it
> -- but the program is fine and has to load.
>=20
> Walk every pad the table names that the edges did not reach, the way the
> walk is already re-seeded at an exception callback. From there the pad is
> code like any other: do_check() never enters it, because no call site
> dispatches to it, so the dead code sweep removes it along with everything
> else that was not reached.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Yonghong, have you observed such dead code being generated by rustc?
It is a bit surprising, tbh.
