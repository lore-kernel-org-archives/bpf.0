Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266B3D3B3
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099986; cv=none; b=qnbOAIvTVI+hTJNROqlE4k3NxBUTTOX8balmzOd/3o2HeBxHtEqnNzehMiegSRtuYIbogHF4fD+IY8EmHHiDdUDUJkv3/9b2ARp6jL1F6VPNIuiqR5Ri67zDwRxwdhsdJyxA6J30FWVDFgBTEFvFQz2S5hHhZVKg8nptbuzZFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099986; c=relaxed/simple;
	bh=XAUz9a0Ev13ANpCwyiM/41BpLX2Hzwcg0J37u/ESs0c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=fyF4MLfVOw3obln+DQyWeaZmNc1ym46zw7bM99PzWDzWFAUBIKBffPtwGVXEeYRI2er0VONFHVCPyLFk9hoZmicLaIqQb41EtOS/rjpyj25Q9dDw4KoncSGFN2YVms10xrpYP/24vMNLSUeKHAnsk4cEtwbJVuwILHlfxvYQIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIpXO/B7; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIpXO/B7"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43bf5f4ee8dso2267403fac.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780099984; x=1780704784; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZEFV3xqmXJ7mDew0+WqBqGT5npYefXJtsev5wJWkXs=;
        b=FIpXO/B7sN+YxOh1nseNrjbNZyVD9ZtvM8qSp5bNXuMLOFhlNcUdV6gjjfomnZ4hby
         HcutyBXjhQymGxEwS+vM+6Spi3XuWjkkCEXaBJLhCxeZcRqmYehb2wvTD67l7A4+PS8E
         h2gdRdYfmhWimsUdb+2EZCZq7PvCodSigF+xuEIkhKwH81cE7NNszJ89vkHZpCIjx5O0
         ME7W2Fa9MY7QO+IABzi8aNaBRVMT7GY1zyccZCrs3j5ZxH2llpnwgDRToff6yQBXlTwL
         rMTaqQ0WfGCGmZcU7PcnaMAzkMoWQIJJ9VG3sJNCfH4N7owJnRoeqbRjbAfmIXgiwRhD
         N81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780099984; x=1780704784;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZEFV3xqmXJ7mDew0+WqBqGT5npYefXJtsev5wJWkXs=;
        b=nSq3nhLu09g49NdAWMYmyrxCfGL6/8qHtTKVzdkW/R+nkOlav8VltzSO/RnbkXzeVd
         DghZmtSDfnDnUv6FD8jSEdHoKsTvlbD2QPSr0xQPrGfVkO/cvg3jMBLzTOjCMQxQ8iW6
         DqkwZSZzW64XfOB5NaoQ+V8Bq1LIMIczAXmOEKXG1QFJdYLyCo7yPrli1LjdP+YTLdiQ
         uKYs5FoL5twl0+xxtZNPMdMj2lkWRl7rEYpxezzjLBxhGTA2YHecLkykJ66Ec+GEOpW9
         amQYkjPZ2SPD0Ibcwwc1mYsVnCGKXhzLbskkeYSsbY32Izf/rdZr+wEVVjEM3I1YXhT5
         WseA==
X-Gm-Message-State: AOJu0YxN5e3Iw/4T+6SD1T9HAMeD73TqFJoF32ntoUxqID6iIKOXu2mu
	H9yj+GhQGlMajLALe5yH7OYIbhaHNOVtByFFfTp8c7ks5pXrTys/Pf0T
X-Gm-Gg: Acq92OFDSvSBiHPmkP7pm2V5KKH79r2GAe5SgfKWEiorr3tXUdjWSjtjxj1cMM82E0P
	fqq6XUmJhj+d8KmUON4r7FTOxMUiHHxcb4MlbR8U/pHxFBY3AisCTGO/rr+hFCr7WfuZJPdtsXl
	IlyXghTjP7G55nVGol6r2svUnQXvJW+rjsxKgiQaWCf61RnM7LW84lUcPz0FTvMf5j2CUBuIdD2
	cAB69heOawsnYrCpSqRQdWGrATuUF/DKLaJvOtLT4rWOoUVwqDaLWsVKBNSatPm48HMFEduRXda
	nei3g6y9Cya7dM075LdBiiknKuM5SHrcS15hW/dD8iXEhnA7ovR4LtLAOZJbhAFT3j91WVPb8vU
	X7aIdsU+sdMD+N76g8nw6zgvsmvGSQcMvSwN/sL2cEvGTwBSjzXZQWvst8flm9L1Ee+JFEpvyoE
	/9AM7Ot0DTT+3evLiGGFwL63jRwfmvLxRmPSiV5AD7KKEJHNwxmimhmhKcW16M4+BnztLFYa4Y7
	++6qt1iY+PkUOhBVhBhKrIeN+2p
X-Received: by 2002:a05:6820:f03:b0:69d:9153:56ed with SMTP id 006d021491bc7-69e102a87d7mr847884eaf.3.1780099983883;
        Fri, 29 May 2026 17:13:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e067f30fcsm2098238eaf.6.2026.05.29.17.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 17:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 17:13:01 -0700
Message-Id: <DIVKS1X4Q76A.1Z3XA1HE3MI7F@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add tests for arena
 slub-backed allocator
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260529202438.16408-5-alexei.starovoitov@gmail.com>
 <20260529223907.B25251F00893@smtp.kernel.org>
In-Reply-To: <20260529223907.B25251F00893@smtp.kernel.org>

On Fri May 29, 2026 at 3:39 PM PDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The `arena_slab_freeptr_stale_pcs` selftest will reliably fail=
 on architectures with a page size larger than 4K (e.g., ARM64 with 64K pag=
es) due to hardcoded assumptions about SLUB slab page capacities.
> --
>
> commit 307042b1f4f8cca55cad67f2c12869bf67a9f7c2
> Author: Alexei Starovoitov <ast@kernel.org>
>
> selftests/bpf: Add tests for arena slub-backed allocator
>
> This commit adds end-to-end selftests covering the SLAB_BPF_ARENA path.
> It includes smoke tests for basic alloc/free kfuncs and exercises corrupt=
ed
> in-object freepointers to validate get_freepointer() clamping.
>
>> diff --git a/tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_=
pcs.c b/tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_pcs.c
>> new file mode 100644
>> index 0000000000000..4d23d75419d61
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_pcs.c
>
> [ ... ]
>
>> +	victim =3D objs[TARGET_IDX];
>> +
>> +	/*
>> +	 * The 4096-byte bucket has one object per slab and a 4-object sheaf.
>> +	 * Free @victim while the sheaf is full, then turn its encoded NULL
>> +	 * freepointer into any non-NULL decoded value. The arena clamp keeps
>> +	 * non-NULL decoded values in the same slab and object-aligned, so thi=
s
>> +	 * becomes a freelist self-cycle back to @victim.
>> +	 */
>
> [Severity: Medium]
> Is this assumption valid on architectures with page sizes larger than 4K?
>
> On a system with 64KB pages, a 4096-byte bucket would hold multiple objec=
ts
> per slab page instead of just one.

It's fine. It's a stress test for the algorithm. It's gotta work
on at least one arch in CI.
But I'll switch to __PAGE_SIZE to avoid sashiko complains in v2.
