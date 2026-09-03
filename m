Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4B246BD5
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396049; cv=pass; b=AsyLyWG2YlXMKmO3SQrTzBf4dniX9A3r0fr/OLQ1UmJ3shAPt35ADfeYEDyqCDu5HjHahCk+uQ9xG+bqVmADCqMBp5jkowESX/MfF4xISBEnbDyyAWvt/b3JKtPBpxbLajDCcWeEe0Y3jCWDbaRa04Cs87ZcTPtA06wKwwaFp+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396049; c=relaxed/simple;
	bh=ummikDaVeCHW0JPhyX90qry89JcKzSQE2CkFya5vVbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJor7JWix5FYSw1p8wQ1rfLV5CoR6H6MPaLqGRXejgXNfLvPDoxytLxqkccTXZfQdX8M7lTruPtA3QJ07KSUiL7LqakDcAZUtIxk7tIRhTIIy2qcRBYv/1NY7hXrutoUYBu6rTIEO+O+4lYpvpEkQpygGiCGpLDDGYapficdHOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n25efLp7; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n25efLp7"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so1570017b3a.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 17:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788396048; cv=none;
        d=google.com; s=arc-20260327;
        b=A4gnbUvxWcCrfnLJvzJVgao6Az+X+JNvZUToIqUQdbbJi0E5IQCu8LfSNdcWGotJPj
         t8gzzoHc+Vls/qB+WIMa/yB1QcAz/yquVmUWiVnoHJqGs+Fhp6vhI6eL53ENGVTvOp3w
         jlp1cN0JKe1DjgopbWb46EakzVOgx3LFvHAyMfyXQEjrytQsLbhU/83zHb8Mvcj/GIaF
         QhReXCGPqhYrc0oofUphAImQy09zPsON4ryyI6ZIwhEMa46VLTLzKFs+Lsmz5gMr1U1f
         tIFbVUHPVXf+qsVPCtcKuf8znQDbHYDxMxyMlwkt87Sidoolob+bTcO5kIIT5fvRHAqx
         NIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ll3GLAxigapk8vQrhDFtbMqJYnX3ubAR8duvzc6SrcI=;
        fh=uu5ZXc4Bd5dcBuKjgwzHhQp4NsIIh18ZVWSNngONr3U=;
        b=YQrf8WJO4cftFjhgHKhHNv5ivh0kmt54gYp1YxcvwU81WeROA3a2K2jGYZGqJ2IJA2
         BpDgvUONLQbzQvi/vVN4jCiwFG9v94LFcB2dZIEkhSZV5XvsNsNV3RgwtVpS6kX46aZG
         uCz05HSp+DQHMipsBbsZRJ99BV9hU7cpHU0sfRjjr428dK88EiICgDSazDs15BtGUudq
         CUdUrL1E2kotsPI16WHB+oQcI8tp9/yTAWdPk6EYUk5mcxX3ScH2LTGTHoSsIRXRn8SY
         vRjppjmKr+j+U6+MkizHiVb7iUafqACubMPFBOaQsUd4lVKyksasGIp8JeCAD0VSVRal
         BA7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788396048; x=1789000848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ll3GLAxigapk8vQrhDFtbMqJYnX3ubAR8duvzc6SrcI=;
        b=n25efLp7McjhmpeTM9eoOznGkE3xN616qRCctvLLI9vfZdqDs68OH5cz2/cLw1pkJL
         bMEfgpqd6yHfBsS5/yOVMCWLuQMfP/pgkAekGxV1YkzWfZlnysGHNbQSCbu2F0T7pCZG
         AmUKtm9dBgUvIf7xvwFtFQ0tNKVp3hg7jOalHEQMoMDzRKNok8zImOtOe9ltAlcU5Gcy
         qPax6nzyVRt8TY5Wq0/XeyIgdTHEGCd7IsHWrCPuPo8jmwib5KqUW/gXT/DT+B2usUXg
         IoYgepQqh1BC236bVe1udBzOicguI7DkpnWxsTwyvs82Qyg8UdIODZEtBoeqKC9hcdhK
         tQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788396048; x=1789000848;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ll3GLAxigapk8vQrhDFtbMqJYnX3ubAR8duvzc6SrcI=;
        b=Np5P0ZV8emllQ1xbRJRt6OsO6oiMylTz6cpERegNAqmte9D9lYM7Yo5gb4Q25983da
         sTtVzCf1O0WcsQzYuRcZTI8zZ+nYajSScLmSOzbxkJwjRQ2gfgvFau19/xWLCpCx2UYD
         pLS83O/o4AB5e6khpQTZGlMyhBcAbZ66p/Fy4QoRaDxlN/vuxmUlnXdyt13kvtf4f+ex
         QTmzTuhdOnGw04nwJbM4DCp6Gry1ZHvTx6dor+VsqQ35D99dr7jdb4ynFpxvnBcaFfU2
         cFfdDeaOV2YCmqmnmP6IvZF5LayYaLGVAafmAKmEOG9h44hDy2fiVvVMcJH4XNAaFnEs
         wR2g==
X-Gm-Message-State: AFuF++nviEIZkOQ1/0A9F8lpL8509dlk+Q7kESBvjYHe27zhZmTDV47v
	3fw4KqgETbDVOjs3WJ0cAV0kkM6eXQyEpmlrixwYvysAjl/RgH3MNExqAUEcAKDrI9+Ei/8xtM8
	Yn72xQdoPG8rWoyL55GDDSXoa5QcrFWm/pEAW
X-Gm-Gg: AYBFou3Y9gUryxiy4J0IVuIVzD7nE3HIFn2Z7ZngtNm2OBWsKKIqXBQVufi2bHdJ/yM
	1QCbPOKu6lsGjMBrjyrAGJo8lJmRJcIGjkYxhMXgwF4aX7NEMMS5/1yd71Y2POzOv72YMNkscOV
	7hC8iXf2kue5aJeoiY/dBxeTMYLwfaO1qz83DRMA+YaVjnRicqRFhtLCjpznAh6kYVK1oNfZyKV
	rZUxsbaWFg643/AvYVKvz9SLifoMHI9MdunmrpThcldlGfP0iOUvHyIJXrdU12xoX4g9uA8EJjc
	d3oUFd7BM1Qgg7a0uy2QSYN3uWY/3YtmlXFTKPmvquH/x8aqg76T+7HBqF0PeFmM9bMAGIin9GD
	IoSghXb9MrSIeeaMef/IIuBh1mQ==
X-Received: by 2002:a05:6a00:4c86:b0:847:9015:e68c with SMTP id
 d2e1a72fcca58-85ed3f70278mr13510128b3a.17.1788396047600; Wed, 02 Sep 2026
 17:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902091126.59281-1-markdamirkan@gmail.com>
In-Reply-To: <20260902091126.59281-1-markdamirkan@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Sep 2026 17:40:34 -0700
X-Gm-Features: AcwNN1WhcKJO8-PyXPVycu3bHFJ0XG2h_wkDwdZhBHP-rTVF3QHwBAawos6jWAk
Message-ID: <CAEf4BzbATmY=yzdKsQwAV5hXwZsahxcYVqtT0+7GoG+N2eFTLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Reject oversized unknown BTF type records
To: Mark Amirkan <markdamirkan@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	ihor.solodrai@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 2:11=E2=80=AFAM Mark Amirkan <markdamirkan@gmail.com=
> wrote:
>
> btf_type_size_unknown() returns an int, but calculates the type record
> size using unsigned operands.  With a 24-bit vlen, an unknown kind whose
> vlen is 0xffffff and whose info and element sizes are both 252 has a
> record size of 0xfc00000c.  Converting this value to int produces
> -67108852.
>
> btf_parse_type_sec() returns the negative value, and btf_new() encodes it
> with ERR_PTR().  Since the value is outside the error-pointer range,
> libbpf_ptr() does not recognize it as an error.  On a 64-bit system, a
> 129-byte raw BTF input makes btf__new() return 0xfffffffffc00000c while
> libbpf_get_error() returns zero and errno remains zero.  Calling
> btf__type_cnt() or btf__free() on the result crashes.  The same input
> makes bpftool's "btf dump file" command terminate with SIGSEGV.
>
> Calculate the record size as size_t and reject values above INT_MAX
> before converting it to int.  Add a regression test for the maximum-vlen
> unknown kind.
>
> Fixes: cacd6729c092 ("libbpf: Adjust btf_vlen() to return a __u32")
> Assisted-by: Symbolic
> Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
> ---
> Testing:
> - normal builds of libbpf and bpftool, plus an ASan/UBSan libbpf build;
> - the reproducer through btf__new() and bpftool;
> - the added btf_kind test and the existing encoding/decoding subtests;
> - identical bpftool output before and after the fix for all 60 BTF blobs
>   under /sys/kernel/btf on the test system.
>
> The complete BPF selftest suite was not run locally because clang was not
> available.

that's ok, I hope AI wasn't too stressed about this unfortunate state
of things...

we are not going to harden libbpf against any possible malicious
corruption of BTF contents. If you don't trust the source of data,
don't pass it to libbpf (or do it in a VM or some such).

pw-bot: cr

>
> This fixes code present in Linux v7.2; please consider it for stable.
>

Do you use libbpf in practice? and where do you get its source code from, i=
f so?

>  tools/lib/bpf/btf.c                           | 11 +++++-
>  .../selftests/bpf/prog_tests/btf_kind.c       | 39 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 1 deletion(-)
>

[...]
