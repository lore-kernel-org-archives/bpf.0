Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33030EF77
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645030; cv=pass; b=gCXP8PBZ4gmL/5jv8jOy2DYGrmgLE1w8NyN9+jCEV7LsqVsvJP7ZzUcOlB0/J+UrtJ2+JR+RR3zszt64NCB9kD7l/PT1GNdhQnRvqjhvndF7fdlzrDYPCD9Yv+R4D9Et7+ZOJBne5xEUqdxvtdvWVQTBebJ4DtPc0W7yMVgl5Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645030; c=relaxed/simple;
	bh=11vqMLmnmVvXfKYQE6V2j6Hqzo90FWfb7+HWBz7xWOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca9w5gtb+8USIpxStY+7ACT2+ofIFUnn4aWWv02s3wG3qYt8J8dXaHiEvfPlDw6w8rBIIP4fHPrLyeUiZ8k/KeFvWvUCCfcElRZfIDYKKKn54wgm8tGnRaklWQD1mZqXbPeH555wNmQVFfZX4SBBoRKsxHfRjDaYrzQtVgqBScA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI+el5UQ; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI+el5UQ"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64edf260b49so3373108d50.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 13:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774645028; cv=none;
        d=google.com; s=arc-20240605;
        b=YiUVmwY985lxpqHnJyvTzXiIEVaWlXVB7Ox+aEZYtriyAqVa/+m784bLaNxA3YvYJA
         U4zkE4d4sWGQW2tcGY6H1gDNehoErGxlsBkWY4zje3hW/ihAHoohYYNortImcJziT3aw
         L0K0urCLxlf3kvwCwms6rz22pMvpXsB0+oBE+cPS8qdu9pd7CzwsjwftV6ehzQjwdidC
         sL+RXIA/wwNDh+8YZG9b1H7+37fjEbHL/iU13K295bM5NZkAcZ2hrJVo3uDu5WpyoMYf
         yERD5UfX9Fv+ieNW3sNAHaFTQ4yP/keBG7j7u0N9QPZ2Jh3DOQGivcVzRQT90Ef9IcRa
         Cplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EwozKa3X/QWLVXPC8OoFgdUEYenwrIPEsb6D5h50MIU=;
        fh=PzF4mx18zzEJc6q5CF9iWR26tlykEsddYUFyx3rCgvY=;
        b=QU5JDALFFQLQj5VeLQw0HpSvY4DDprDiuGBIniehDMKGDyBzbdopeMPdGPDydXi2vV
         nDPk7Ns8xlILyMNBgnTCzk4s2svj+7Eto9cAxFnIuaGv7TXGYib8ZmmlV32OVdu5DxhC
         PGaSoFSWkIG3RN6kqUkSLx8g/cRKRcGB5P34Goc08Io6FEZKfVya1b38NPslGNwFqVXg
         pu2BfCtPs0ls85c9oUeOznRAQitABW3dWMRlfsIrw6qxfpTQoafGNmqMLsm+oB+BvKSr
         G5TC9a3vi+QYBJzYla/e/2zsDo4gWV7YOwnSoJ5l4toWJ0vtdmhqDXKb9H600UUcotOd
         jVnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774645028; x=1775249828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwozKa3X/QWLVXPC8OoFgdUEYenwrIPEsb6D5h50MIU=;
        b=LI+el5UQZiwAUb/SDCjX0re8vNnTZ7GHxA3eCiENKTdO5sTfvhAzLK/fbWUMnDtSoR
         ZRlEULqb7D5aSxdVuMgCqB+cd05Ggru+ejpzkaknNmjcDDvEm2SwCyxxR1GeaTQT0jZR
         T2+Cb4ElJw73qp2IFTS0CoxAC1QZi21mg2XCIDQSoJJ6rClX4WKpIq6fWZPC6DKuy/Xa
         TiTNi0213i4qEA3Vwmp5JRVGOypbN4zB/MjJHGKk7OwwrukqHB8tQFo68nGROyRXadXh
         B3pcR/c3Ijx+Bd0OZdY9JyH0wOudK6dG9XoWoC2U1cMznPNzzxgEpNr54VWK/wCkcbGP
         t7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774645028; x=1775249828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EwozKa3X/QWLVXPC8OoFgdUEYenwrIPEsb6D5h50MIU=;
        b=pCUhqBGOnHYqYVoYK0+s/8oq7ZkMkrH553VqLcqHOK0b4jPDN6BcSskzWqdaSg9oWx
         9IHFfsYwaJ6JkBZlDddXtVwnK1DZZ4314aXJKvDK/Mb4RA4lPLW4qDcPlWqf7zGtAC6d
         nz0n8BWhjiEyJt1Dra5v4J0fdfqwvL9T5VU68jJI6fbnlt57EnMVjb9dEbJIRcd2AEiO
         fPHQroc4qV6Vl4js8S7xE9mQpyvOVc8QNe5CzQXTSCv5k49j9wjANvkN9fHPhUlOEr4z
         qvDEwTJkCFFcq90fxenlvsLNnNh3r/0wxZeMh4qyOum+nRYry2opC0EEMUXwPgj2YEYr
         5Yug==
X-Gm-Message-State: AOJu0Yxu0oOjCo32Sq1E50nY9X7RqwH0sPy0gDtlc4wWoa2XLvORHQCk
	9ZCu4DO8Wgq+fQzjD/IirXGtsJeDepYp3ZyU1y1JPIsNk0DVtYnUlJDWwgylOYpXn8INC/gEnfA
	mcKHuPlM4qgeIBdIK3W8Ptt2fXT/jjSs=
X-Gm-Gg: ATEYQzxLuTzXPSbRMM+JpInTipsAxYvyPWXtdgp0xJGwfbWKcjpiwJU3/jMkfyA2zv9
	HUY3TbLhPw2EHG5oK9XPVw8QZwR5CmBOyJcOz8wvtFmWo7a7WNcEZVBAtgwAPeLM5AzZfEHxQhb
	Ut+yRoozDLWTnOZbXFBHU438FFqaSB9/AWffwPsR4X4J3N1HibAmBXILnGXZl7iJ45hsT7Ju5kG
	bpfKusE7Ga01gfvQfc7CuRStG33gmMwDcv8B9WW+7Q8kC3U/AMOn5rJtzqtRXE/tNcWrqDpy96Y
	SnJLWRU=
X-Received: by 2002:a05:690c:38b:b0:794:c283:5fb8 with SMTP id
 00721157ae682-79bd02acf90mr59953307b3.25.1774645028582; Fri, 27 Mar 2026
 13:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326052437.590158-1-ameryhung@gmail.com> <20260326052437.590158-3-ameryhung@gmail.com>
 <877bqxi600.fsf@gmail.com>
In-Reply-To: <877bqxi600.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 27 Mar 2026 13:56:57 -0700
X-Gm-Features: AQROBzCNchU_nyL80AmhOxCXsxh0-B3KfPm2qubeuJqz6hB0fv35N8ZH-z9HL1E
Message-ID: <CAMB2axPBjQtdDog+ktgfgo3q=8NEke=Pq_LxD1ji0cD5ei80AA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Simplify task_local_data
 memory allocation
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 9:36=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > Simplify data allocation by always using aligned_alloc() and passing
> > size_pot, size rounded up to the closest power of two to alignment.
> >
> > Currently, aligned_alloc(page_size, size) is only intended to be used
> > with memory allocators that can fulfill the request without rounding
> > size up to page_size to conserve memory. This is enabled by defining
> > TLD_DATA_USE_ALIGNED_ALLOC. The reason to align to page_size is due to
> > the limitation of UPTR where only a page can be pinned to the kernel.
> > Otherwise, malloc(size * 2) is used to allocate memory for data.
> >
> > However, we don't need to call aligned_alloc(page_size, size) to get
> > a contiguous memory of size bytes within a page. aligned_alloc(size_pot=
,
> > ...) will also do the trick. Therefore, just use aligned_alloc(size_pot=
,
> > ...) universally.
> >
> > As for the size argument, create a new option,
> > TLD_DONT_ROUND_UP_DATA_SIZE, to specify not rounding up the size.
> > This preserves the current TLD_DATA_USE_ALIGNED_ALLOC behavior, allowin=
g
> > memory allocators with low overhead aligned_alloc() to not waste memory=
.
> > To enable this, users need to make sure it is not an undefined behavior
> > for the memory allocator to have size not being an integral multiple of
> > alignment.
> Why not simplify this further and just mmap() a page?
>
>   data =3D mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
>               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>
> That gives you a page-aligned, page-sized buffer with no ambiguity
> about alignment, page boundary crossings, or aligned_alloc() POSIX
> compliance. munmap() on cleanup instead of free().
>
> The whole power-of-two rounding and TLD_DONT_ROUND_UP_DATA_SIZE
> option adds complexity that's hard to justify for selftest
> infrastructure. How does a user decide when to define/undefine
> TLD_DONT_ROUND_UP? This is a selftest library -- the common case
> should just work with the simplest possible approach

This library, while residing in selftest, is designed to be used in
production projects. sched_ext is in the process of adopting it.
Therefore, simplicity is traded for efficiency.

data here is allocated for every thread that calls tld_get_data(). So
if we mmap a page for every thread (which could be in 100k order), it
is going to waste a significant amount of memory.

> >
> > Compared to the current implementation, !TLD_DATA_USE_ALIGNED_ALLOC
> > used to always waste size-byte of memory due to malloc(size * 2).
> > Now the worst case becomes size - 1 and the best case is 0 when the siz=
e
> > is already a power of two.
> >
