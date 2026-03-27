Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F56396D00
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646114; cv=none; b=seQN346j9/BCZ7B2gAmGLEvhIgWEyyKwcpB8+T/DPeT1sJAgI+C1mp8GpLh746SS7YESqMQdTW+2dAOXENVrRYnTNhj4pfzR4Uc8iiHT51nFnWaioVH4EGgPsYQwSGd7qZ6P3T7tZhkpfrSblyeFtWg/ynaNF0fYBajXFLwOk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646114; c=relaxed/simple;
	bh=mnVCstTjvv1W9Qx1IHUkkscI5CyYsV7DRrQErWTiCEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEcFttMdUTRLQGAB+2k0FE6YHwaM3agGvNdokBthpmo1/C6VwHmAP8hLuNHc/DSaDy8wbxr+GrAZhsk6D+d1zbZhwoyOUuFUwYxQoW3fa2OGQVYMQDDHA55wIxJyM8x+ViVGVAZTa1dthYtslKuEuuLnpJ7rQDCzEH1+bQpoXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyfEMNF8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyfEMNF8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso22721855e9.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774646109; x=1775250909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++rSOA9GtoIGhCvkD07UporAOkq1OfqZEDvcXYQEeYg=;
        b=VyfEMNF8yUwwDVWR6+2+JHomPKfMuBNOexWljCHJsUr3UuaxnmxaeCzKH5yVUhaCpM
         +roR/4Zli8KMXokymzSnQo2xmA0xM93MruRMnCihnfKEHf9SsXGGzqGNT9jw3cmW+xAZ
         0Crl9FtjlByCY+7viOTDIowqGlgGoOwF7Rd1ByYSWaSA+i6FEh7+6pG1zyqYuIXGer8u
         qI6F/BBwyisySdYvlZMMCVe61Gt9rr2EIEcGvuLvqM6yUQntjZPnlwjNXnfrHWqA793S
         kVQ6j0obLMgsl0ah0imcBqfUQclQOor5tJXBzonGfc+AEEMQGrs9HPuZFXzY/zofx0AD
         u2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774646109; x=1775250909;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=++rSOA9GtoIGhCvkD07UporAOkq1OfqZEDvcXYQEeYg=;
        b=qaVHIY+XXD1M++OkbW0aNgHj+bH6igwMyN+62WhFqGsNlPNTTyruzIeuZc0/J5eO2x
         R09z0HwxlB0dTcr8/3605DcQjQt9Ri/1dcNEyTpnvz6NrlAp+KyMVyTWfgduhse6VsEo
         1kyf6+rwKkD6TXldaj/Qf8wlPaQ5KFvmsV7rkUv3MzLH6PXJok+F/wNwIJvBnwBiMvuM
         NtEcMznRQeUTCZiDjoDW9+ccMCVSxTE8LZzNbim8u1aKbmLLJUVahNjImfZoAqGrPZJU
         57VDNNePI8A5gDxDlYGROeh8v0HHxOFe+LIFPJswoaIxguoMdgEJkZ+7zr3ENQ2IrDrb
         ITQg==
X-Gm-Message-State: AOJu0Yy4TRbjQI+I1RBWcMGPt1/8ytTI5I7DL8CobS6LxDKjDOO1aKHY
	fNjGWC23VaZzFtD5qSLeA4D5kXmG2mTgt9KTY3zGvZekJqi3f1+MpmeS
X-Gm-Gg: ATEYQzz5hj02EucnjoTUsGPR075Wo2Z84NoZMSnuArcZ+zCb2AjDZ93jnrEAsjYRr4w
	krZWaDt8Qcs+pB7Bdz4La4GK/QEN2iR9VS2tNJWRHtZXB7a0JztyE8FqEIO6RlpkcuAW9QoSPXk
	A3GzStbtKT+rCiO6u97utUIOB1kQWJBniOUx9jS1fbUM3Et8uRusjZkjVOoo9RHYk5MzUj1iSwZ
	/I49Tq7/24H8n60GimGl4sAlzoqCmKyzfCdUaEh5CQSv/x90UE56kCkIS4tMpu9aejUCScUUKKX
	v5tTyhy1O7558tdDQX4oTv+Y/H9sCYYK6Je+fbs7ak43I4lHZVuP4XflRTptYHZX3p2dUZwqP54
	iZdfI11OCqBCTmSJgBU2x4g5MYP43e9WZWnIb+v3T3j2Nr9vYYEddVCWdB2j8nQGpmNCX9RYIyD
	fj1UX1g4ke0fz0CWxAbY645Ojca2KRuEq2WA==
X-Received: by 2002:a05:600c:8b03:b0:486:fdca:ea8d with SMTP id 5b1f17b1804b1-48727ef5550mr71614325e9.25.1774646109364;
        Fri, 27 Mar 2026 14:15:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e2a7asm858834f8f.7.2026.03.27.14.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 14:15:08 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Simplify task_local_data
 memory allocation
In-Reply-To: <CAMB2axPBjQtdDog+ktgfgo3q=8NEke=Pq_LxD1ji0cD5ei80AA@mail.gmail.com>
References: <20260326052437.590158-1-ameryhung@gmail.com>
 <20260326052437.590158-3-ameryhung@gmail.com> <877bqxi600.fsf@gmail.com>
 <CAMB2axPBjQtdDog+ktgfgo3q=8NEke=Pq_LxD1ji0cD5ei80AA@mail.gmail.com>
Date: Fri, 27 Mar 2026 21:15:07 +0000
Message-ID: <87tsu1gejo.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amery Hung <ameryhung@gmail.com> writes:

> On Fri, Mar 27, 2026 at 9:36=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> Amery Hung <ameryhung@gmail.com> writes:
>>
>> > Simplify data allocation by always using aligned_alloc() and passing
>> > size_pot, size rounded up to the closest power of two to alignment.
>> >
>> > Currently, aligned_alloc(page_size, size) is only intended to be used
>> > with memory allocators that can fulfill the request without rounding
>> > size up to page_size to conserve memory. This is enabled by defining
>> > TLD_DATA_USE_ALIGNED_ALLOC. The reason to align to page_size is due to
>> > the limitation of UPTR where only a page can be pinned to the kernel.
>> > Otherwise, malloc(size * 2) is used to allocate memory for data.
>> >
>> > However, we don't need to call aligned_alloc(page_size, size) to get
>> > a contiguous memory of size bytes within a page. aligned_alloc(size_po=
t,
>> > ...) will also do the trick. Therefore, just use aligned_alloc(size_po=
t,
>> > ...) universally.
>> >
>> > As for the size argument, create a new option,
>> > TLD_DONT_ROUND_UP_DATA_SIZE, to specify not rounding up the size.
>> > This preserves the current TLD_DATA_USE_ALIGNED_ALLOC behavior, allowi=
ng
>> > memory allocators with low overhead aligned_alloc() to not waste memor=
y.
>> > To enable this, users need to make sure it is not an undefined behavior
>> > for the memory allocator to have size not being an integral multiple of
>> > alignment.
>> Why not simplify this further and just mmap() a page?
>>
>>   data =3D mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
>>               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>
>> That gives you a page-aligned, page-sized buffer with no ambiguity
>> about alignment, page boundary crossings, or aligned_alloc() POSIX
>> compliance. munmap() on cleanup instead of free().
>>
>> The whole power-of-two rounding and TLD_DONT_ROUND_UP_DATA_SIZE
>> option adds complexity that's hard to justify for selftest
>> infrastructure. How does a user decide when to define/undefine
>> TLD_DONT_ROUND_UP? This is a selftest library -- the common case
>> should just work with the simplest possible approach
>
> This library, while residing in selftest, is designed to be used in
> production projects. sched_ext is in the process of adopting it.
> Therefore, simplicity is traded for efficiency.
>
> data here is allocated for every thread that calls tld_get_data(). So
> if we mmap a page for every thread (which could be in 100k order), it
> is going to waste a significant amount of memory.
>
Thanks for providing this context, it makes sense now.
>> >
>> > Compared to the current implementation, !TLD_DATA_USE_ALIGNED_ALLOC
>> > used to always waste size-byte of memory due to malloc(size * 2).
>> > Now the worst case becomes size - 1 and the best case is 0 when the si=
ze
>> > is already a power of two.
>> >
