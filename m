Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC323EB108
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883159; cv=none; b=fM7/v68PCE7kzNqKQBLgZeOc1dYu1ak8n7c6717xe7VPV8vVp1UPckQG+Pti3E/X9CqlZc8BOTJ2vyGTafv6DDwOh4OBCKXxynPwaGJRY9jePAbS6CxcO8Wuf3pnVQLqpPRxKvo5QDL/LHMtJt7cKmUKlO/KT01VOLIPRlk8Ur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883159; c=relaxed/simple;
	bh=lpTNZ/5jZGki/n4wGfQyOA231tiB5+Awdnv2PPXkquU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=b41CqyCPnTup45KdN/UnVRDUfbzCr7rrmXfdbdKeZP87Aqqdq+oXq9LEu8464ECrJYXdoKgOxX5Oo5Fg0G98N6Y6DrZ+rjlh4mnN8RFhQX9QnnkoJ7oQgMEBMbEIVJj2PMxltHN20innFDuXqRjeBdp4JhUXcwMzpEnllgK7La8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P30PafF/; arc=none smtp.client-ip=74.125.231.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P30PafF/"
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f4f77e92eeso1289867b6e.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791883155; x=1792487955; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlzQWYQabUcLbPNV/9bl1l174WsOPecqqUyCYJyygP8=;
        b=P30PafF/CH9eHkIqgAmj+M3MiT2GDv1og+8Cze+RjfVvoLkQLx5P0GtACtTvVV0OCw
         Y/yZLfjU3BTtETnQyAa3ERZGMc7Rdq55kQp26HwzW0nVv5GiZuL1wF8m+T5alAoKoysD
         8kz79yuMzWebV78bc0Wt3Q6idFOYQwbZ7zLl6m2Nr0eNliCbTF0Kv9u7jgTehVAPeKDM
         qKHyPoZ0MKKEgYxXsnylo/MiTkJ90XKFvUYyFGTP3wSEO7ZtsQMTtJIIaXtlp/h9uXob
         bvRlrpVcBvj5HdzbiySo0rtHRsB4R97ryIrxMknBysiaTNw3K4PFxeDvD9r0hnPHLAcM
         2QzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791883155; x=1792487955;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nlzQWYQabUcLbPNV/9bl1l174WsOPecqqUyCYJyygP8=;
        b=dDdhzTYy8PUKwIEL29LcuNu4269CJnyZyKdAz7civjb66ERlZYr6jSmaNp/LotSfnv
         Y6SvF2YVNAp1v3PBKNTE+gqviCtN9P9IDwaWaUbm31cxMYwBJ9tg3lAD5LEGEFMWFi/m
         hhDNLRfdPXQpVO+H81jxbprtEbSfhJ4tZCRUuc3M/mUN15Z9BR6XwgSjevrmIwX4gcw/
         r/3Xc8N2sOb2KhvLcPn5KLUCNlUt579Aqrsb9/eRI5Aawyt6BhD4+2SlM21r8clDWgZm
         0+l/ehahTJ6Ta0wubWMr8Edkb+DLWIimxSnxzkWd0nHq1TGPLbD6WLZO7aKstSLhnZNo
         V2AA==
X-Forwarded-Encrypted: i=1; AKwUvBwZS7MwmkmSv7kz+f0JKTgOLHM2pP/4M0rZvCEmY/1CMSSqhf5xDGYoGKNmDz7Zc+eN+IE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPxhceses0hXIRk5StLk0LsemI1SwqRdTvuUWF0Z4nHsyFe7A4
	wFP3f5Un8qi+GnUr7l0Y7RJDd2QqWxyFW5G1hXOqqZcMsSuBp0OLBjVXr6vLThyltQs=
X-Gm-Gg: AYBFou2fKhBpvLzbSJh67crC4RXvQEnGMRw5K9ailHa/BO2kjKv2VPwR9iwg9HsWQUO
	GY0IqPXalI2eJguY1PG3kC+a1fD3wt3sTTJtIfkbZZ2hJ1vl+goc0V8CvPZzsLwUDISI1x+8RYx
	joQnRpLF4VU8nX5ZX+s5Sg3ko1a8j8xgZiQGJnycdl0HEw2T/icb/NY4mi0BlcRZyMHBrcYNJWp
	vfPh109yIrU3iDiTqPY5pgTXRcW9zXPNCr+b3KsOcQJLf1Kkr3pYyF73BVVMu8pWC/QswXOS+g2
	IcFO5GDk3FMDJ6MWqnxXPuNrAhIq+Sg2UQ3BPXerXhYmd8/QXGBCck2EIMp/yq+KTKOWafebPe+
	xyIYhP5ZhPrVcOZWjE5hA9Rqb0/C00dlBD4OW3ap+GJdddW5gTcHOsVbwWW56A2QQHzmOmKNxc5
	mDg1YYacRB6LaOFVzI+SMbMjuBrz1RVXZmBht2jesfG+ZKmOqzcHa8RRS65zjfh91mqp5opjpl+
	tVauQgfnh0PoJ7E27nAedsVNT5DLPWsoQIIHprMsmSRRVksh7ceLb1HpBXpYd7AyNQVv96GrJ3e
	NCjg
X-Received: by 2002:a05:6808:1992:b0:4d6:9335:d534 with SMTP id 5614622812f47-50c5bd17840mr10719614b6e.65.1791883154987;
        Tue, 13 Oct 2026 02:19:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1c120ae6sm13672218b6e.17.2026.10.13.02.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 11:19:12 +0200
Message-Id: <DM3LKBZS8VU0.1HNORI7HA6FFS@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/13] bpf: Recognize __nullable on pointer
 members of kernel structs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261013082012.1107446-1-memxor@gmail.com>
 <20261013082012.1107446-5-memxor@gmail.com>
 <sashiko-outbox-169283@kernel.org>
In-Reply-To: <sashiko-outbox-169283@kernel.org>

On Tue Oct 13, 2026 at 10:52 AM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: MEM_PERCPU pointers are stripped of PTR_MAYBE_NULL flag cau=
sing Oops
> --
>
> commit 2e4273929b840decae1764fc52e2d82686a2b6c3
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Recognize __nullable on pointer members of kernel structs
>
> This patch updates btf_struct_walk() to report the __nullable BTF type ta=
g
> on pointer members as PTR_MAYBE_NULL. The verifier is also modified to ke=
ep
> the PTR_MAYBE_NULL flag on trusted and RCU pointers only, under the
> assumption that untrusted results are probed anyway.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2f190abe34489..a9c47441fba91 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> @@ -6721,6 +6721,13 @@ static int check_ptr_to_btf_access(struct bpf_ver=
ifier_env *env,
>>  		clear_trusted_flags(&flag);
>>  	}
>>
>> +	/*
>> +	 * A __nullable member only matters where NULL would otherwise be
>> +	 * assumed away, on trusted and RCU pointers; the rest are probed.
>> +	 */
>> +	if (!(flag & (PTR_TRUSTED | MEM_RCU)))
>> +		flag &=3D ~PTR_MAYBE_NULL;
>> +
>
> [Severity: High]
> Does this unintentionally strip the NULL-checking requirement from
> MEM_PERCPU pointers?
>
> Struct members annotated with __percpu __nullable will receive the
> MEM_PERCPU | PTR_MAYBE_NULL flags from btf_struct_walk(), but lack
> PTR_TRUSTED or MEM_RCU.
>
> Because the pointer loses PTR_MAYBE_NULL here, does the BPF verifier no
> longer force the BPF program to verify it against NULL before passing it =
to
> helpers like bpf_per_cpu_ptr() or bpf_this_cpu_ptr()?
>
> Since these helpers do not check for NULL internally, calling them with N=
ULL
> simply returns the base address of the CPU's per-CPU memory area. A
> subsequent NULL check by the BPF program would then pass, which might all=
ow
> it to dereference the base of the per-CPU area and corrupt memory.
>

Will just drop the stripping logic, I don't think it makes too much sense a=
nd
code is simpler without it.

>>  	if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
>>  		ret =3D mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id=
, flag);
>>  		if (ret < 0)


