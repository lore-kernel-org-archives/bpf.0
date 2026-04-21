Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921D3DE428
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805676; cv=none; b=e0+/ZDsZNlFp43Z7V/hBfyX0Neocb9J2F03LSf2NYXh+DN9eRvKJY1r0TY4C33E5WKUB7DJ2EJI2gw/f8+p+fxb8uvCKK7zvPxN19Ir9zmGNlgXwQOuzcUPV27+m7YlC28UsKRr5FFJACiOe5KbblS+igff6/yuWntei0gdDv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805676; c=relaxed/simple;
	bh=VnIX0Qpiib1IPSCs+pMXdqR3gGrqGHThfpqHlBe+8Ik=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=OczWdRIqQ6JX/qnD5vYv3TD3shPL5AOk0dFq1wtNkJaeBpIDrXNKeFyE/aB14VixslwWkG69MU41A5RdiAF50kg7bZdwU+ffMs3t2B2oBiXQKxAxRkFtxW7RzlbUjXOx8ejt/Nhkr2XXspdoenzQ/ru8CqQhM9tVxACxxqn4luk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB31vNXv; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB31vNXv"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8eb5ad01402so276899585a.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776805674; x=1777410474; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExwYWJuUErqPXv8hnc7YL9NcutKTxTmKHewAfDD9cLI=;
        b=QB31vNXvI3lLHsiwS3PXLCeK73OHzIU4hIR3siGJS5xpPDqkwI+jdMFIOaYn8JS47B
         KXDKIZ8ZJmr0U55Tk4/K6erOCcLB6HngzCv58WGQCckygeBzzZqlSj58enWiSA9bfh6s
         VNcShnkbn+LOEKL9zvYZRhkw8LZCb9U0irl/hD8pnltSz+u9jJ/Zv5OEr1orRFwVlGzi
         hbgr5LR21Y5cJ9694aWXdGnLXy8D02YFD4DVHPCqCi8pWXOGsD7NajMfFWw1fFf2D1Vq
         GsUutLAItZOcvXSydrhTmen0nEnf2z2Yrnq2wTwyLL3tUlA/oLCP1VwdnhE5ei/9G+ml
         Lg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776805674; x=1777410474;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExwYWJuUErqPXv8hnc7YL9NcutKTxTmKHewAfDD9cLI=;
        b=Q+5iLTr2fu/tZ7nXNqk5wdz3/nBW5OekDhlp7aBX29WkQsa8Sacu3KAUmT1OLhJohg
         HLLoqxKw0R2JaO2KlRaWXjjK5h5Fb8qcIkApDtiyF3drdMqGRhDkA6gExPDRO/AoNASC
         nNpmOy3WOFRE/z/J3Y8tC6O2LXdhd8Nfn/agLgic2HO2ZfdinpyzDa/t1pAAyNIyN+SV
         22L548M8veg09SFRyNcpJamnwDngRDQdfXdiFDZo+Z/PcVRYIw3yxnDe4EErYBkY6kUM
         DgV2s2sYYrl6hClL/DM3Q+5zEkQY+BIWExkmZHSZAszjB7wRi1Ir4MXU9FdAT8ckVxSS
         f43A==
X-Forwarded-Encrypted: i=1; AFNElJ/B1ZNW4mRBXkciSXQE54KxDmVWc9Y4uaTDbjaPBN+jqqtX47x+aYKEraoS9kqT5/LBGyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhakn1qZ9wOCYnbOawJGQPJmh6B9llOiqBT58UqV0RSI+DKxkK
	HLmEGBZc2ZybxZcp4pWUfw+Hb3LXIb3AuVGlGwUkNwRAM9JPZjfy2I2a
X-Gm-Gg: AeBDietI6sASitwKbGrM3eNXgJHylHEoGVneCHSEtkaTDzxnFuMakUJS1Tsnoix45Zx
	frB5z5eM/hGrAwICdoiZWJqYNt9IE+1E3WmRQo1QrEyNI6Ut7s85WCr5QmUAnD6eND5NFwfhVnF
	QhiTsmSgiPR2Ee5392r3lNaS/wq2vnyQrVhjyM05g8KtuAcyHLhxT9dotiRsS6C84F8SM+fGMS2
	aqxT1HHG3Logt/JN4FnkxAz64gZuRZx21gKxEon9J/T11in42RRn9IN5WHDBthovidDyV1J9bxn
	7LhzZtmxtuaXj5FXw/5ER1nbjCuO63YNXRWGdEkxIV/UiNTNp8u/UJGHA4W+beycRDZRSuz644K
	WXh035hejz0UuTG0plYH5c/gzyelDXccuD/PPIRnt9XEPzJxb8IhChoqepTI8rJiDSvB44sBbwa
	LIF4QMdUabil9COfqud6yS2j7u0CoihihrWmg/eBTj3IJXWijy0yDLPS7IkDLO7n6PhsAwKoR92
	J5fAc1w/EEBvHlaMj+EUGJKRO6ZD6wAkizZOw==
X-Received: by 2002:a05:620a:45a6:b0:8d3:ccef:b2d2 with SMTP id af79cd13be357-8e7917a9fd0mr2810323585a.30.1776805674243;
        Tue, 21 Apr 2026 14:07:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ef12122800sm142690285a.18.2026.04.21.14.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 14:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 14:07:52 -0700
Message-Id: <DHZ51LAF3MRD.20EUP6N4BB5P@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <yonghong.song@linux.dev>,
 <eddyz87@gmail.com>, <jose.marchesi@oracle.com>,
 <cupertino.miranda@oracle.com>, <vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next] selftests/bpf: remove string.h includes in bpf
 progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "David Faust" <david.faust@oracle.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260421202233.528128-1-david.faust@oracle.com>
In-Reply-To: <20260421202233.528128-1-david.faust@oracle.com>

On Tue Apr 21, 2026 at 1:22 PM PDT, David Faust wrote:
> Sources for some BPF test programs currently include string.h, which
> is a glibc header and not a toolchain header.  Since there is no BPF
> glibc, this means it is the native system glibc string.h which gets
> included when building the test programs.
>
> In all cases the include is only necessary for the prototypes of
> non-builtin versions of memset, memcpy, etc., and in every case both
> clang and gcc already replace these with the compiler built-in versions
> and expand them inline.
>
> In the case of gcc this replacement happens after initial debuginfo is
> generated, which includes the calls to the glibc routines.  This means a
> BTF record for e.g. 'extern memset' is emitted, resulting in load
> failures like:
>
>   libbpf: BTF loading error: -22
>   ...
>   [26] FUNC memset type_id=3D1 Invalid func linkage

...

> -	memcpy(&val, keys, sizeof(val));
> +	__builtin_memcpy(&val, keys, sizeof(val));

This is not an option. It works for llvm because it inlines it for small si=
zes.
GCC should do the same.
For large sizes llvm will emit libcall to memset
that libbpf will error with "FUNC memset type_id=3D1 Invalid func linkage"
and that's a separate issue to deal with.

pw-bot: cr
