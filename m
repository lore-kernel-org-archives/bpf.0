Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E463624C8
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 02:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137187; cv=none; b=AltQQq/wEXh4OmNCpMAMLkV4p9Ith1mi/wvdXNF/P9SpXoSJ6YuYniOkfTU/FIxCrktQ15f/dUSTe7BhVHGm/RxsotS7rNDDxAMI+uKOA8v/GsiYJVXpEf+5ueX+laGD16Nvw8XhlQ+rtULZ2vtsY0331qIqFHrc93IC6/qTDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137187; c=relaxed/simple;
	bh=PIMW/GB8Cp/eJevJJ6KFcdE8cQ1dDAXqZRTb/ssVzt0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=XscidVSbrHcPWld21oRvcgKPbpGunk7TwLPu5KOsflPd6atmySTeEzdh2blzOas3Dka5PhiM3fKaQT3ayiUONZuaX3Mb+2XC7/FxK7aOsVwDpZB9ue3NDnkDzlje4C6KixUM6viwKwRsoqpjdFUHmSwPMdbedxHHHoOm9p5lvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=aTgEv+lp; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="aTgEv+lp"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6af798a83so204030685a.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769137173; x=1769741973; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92KE4s8ChJGbDVX7FzqVEbEMPgtvKgI3ShsoU+Depuw=;
        b=aTgEv+lpPuLzWvWbg4e+wa/K3pwXbpZXaSHXvTP5MKIa5XBnRJcCvObbIArKpl9MOZ
         /3ltcuRZAyK87F8iM44HDXEP05hJWsh+uelDUXwmpdPQX2dIpC8dkVgUwXpsCPEkZUOV
         pUBUV/bmlyU383xkc9b5Z2x44oGvEYPtQHrzpNCwU2QXvpmMzC1nK4LAorQBqr6phm8m
         gZz/7QwoXW98m8NSevQP/O72Uc47B2yvJBZ32EJ59xLAgN/zu3HuATvZNrCI0lcNdjrm
         uXJyz3HC7PVDJwy7Y3V0Sfa1LSK1oUbsCcUSbDCXjxDT7HEeWSCaaZmC/Q1F4LbV6RsI
         Exfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137173; x=1769741973;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=92KE4s8ChJGbDVX7FzqVEbEMPgtvKgI3ShsoU+Depuw=;
        b=LJ1wJPn8ohhAX5Zn+BSExNnEWd7LZD0WXh+S5kpDXHdtjbjSjSkCxHlJpRkWeX7VhA
         8cnbV1krfFwbcfpNcvxNkCS6eH+1fU+wadP58+CGt1PtbNVllVPBqNOjwPnbVmtBFqJS
         /M/qhc3qGo63zQZ2Y73JYNov2wyMJvj5cXjrX6rs50d29lLwJuf5XVdy67D3FId+qtSR
         NGFdddFADbzif+kBy5M+eUrJsYPeGf67EO9ST3ppx/0H6gaYix8Ii16hucUFVChbMwkn
         1aMkp0UENZzE0OQjGjmEY8Nvj99wEY/F7fNPHo5HgnZNKxZnHkeMx/+FnaiQHpgDshBD
         w1PA==
X-Forwarded-Encrypted: i=1; AJvYcCWSwnLmvxVF17qX4VNISXvz84oPwYdEcGytGOWcSC+Z85fy7W1WkrCN7CTmncF8X9c17i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqT2xHzoGxU1mMPu+ETGvDU08XWCegDPHzmrh16IfNcsrA9j4t
	RQADDy6QQ/33p0w1vMXQ6hQJ8v1RK1Hf6G81lw5aPh/4FgwuhbFt9+nsxLEMaASipYI=
X-Gm-Gg: AZuq6aIKZ7/z0KJzrc4NXdv1dyR81GsSH/1b3ktTyHhvE3Iu/bAir6OJKcNkVqxt8gq
	9DmjKlZMWKORMJWbDylnNT3a2PJ0/LvUuWxd1LJt1T+QQ9tpUZexP+kScDKb+auTcRS38peixz/
	uY+IP3cgzdMeBQOVuK1IoKdoDHFFgOvIOdKMcicBckvMfilDl0S+vRCNTm5Uolp2wIpJf1KewiD
	7WrBcCVb3DCkfI3ktzjt6GVFOiKlxZFZuR6BgrwfLUDWQpVLunAG4vVaRz0YKPvqE8nnpM38vAT
	ZMFgx6CsxPvPiFtETpJ3KQE8IdPJp2MTA9z8hwKQ5tiolPqsm4EiYgjdLjkeYH8UKcktGlKmX7G
	iwzc+9ynzjMjgb03nyo/VTqs+90lcvQYj29nrFlsLmN6QB4WoEHdnhFHOQVtv6jFHcRsMmBlBuf
	fcgiB/8xEs5tU=
X-Received: by 2002:a05:620a:4445:b0:8bb:a037:fd94 with SMTP id af79cd13be357-8c6e2dc0f12mr212556985a.38.1769137172825;
        Thu, 22 Jan 2026 18:59:32 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89491939567sm8527306d6.48.2026.01.22.18.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 18:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 21:59:30 -0500
Message-Id: <DFVMSCH5VD8Z.1WQ9I01GBNCQW@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <etsal@meta.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
 <song@kernel.org>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH 10/13] selftest: bpf: Add libarena stack allocator
X-Mailer: aerc 0.20.1
References: <20260122160131.2238331-11-etsal@meta.com>
 <3079ef68368b1d573cd997363987554e24d444405c0d9765f073df1827d6eb32@mail.kernel.org>
In-Reply-To: <3079ef68368b1d573cd997363987554e24d444405c0d9765f073df1827d6eb32@mail.kernel.org>

On Thu Jan 22, 2026 at 12:12 PM EST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/src/stack.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/stack.bpf.c
>> new file mode 100644
>> index 000000000000..37f8ce43e0f8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/stack.bpf.c
>
> [ ... ]
>
>> +static int stk_fill_new_elems(struct stk *stack)
>> +{
>> +	stk_seg_t *data_seg, *stk_seg;
>> +	bool need_stk_seg;
>> +	__u64 nr_pages;
>> +	size_t nelems;
>> +	int ret, i;
>> +	u64 mem;
>> +
>> +	nr_pages =3D stack->nr_pages_per_alloc;
>> +	nelems =3D (nr_pages * __PAGE_SIZE) / stack->data_size;
>> +	if (nelems > STK_SEG_MAX) {
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * If we have more than two empty segments available,
>> +	 * try to repurpose one of them into an allocation.
>> +	 */
>> +	ret =3D stk_seg_to_data(stack, nelems);
>> +	if (!ret)
>> +		return 0;
>> +
>> +	need_stk_seg =3D !stack->capacity;
>                        ^^^^^^^^^^^^^^^^
>
> Can the data_seg memory be leaked when capacity is non-zero but less than
> nelems? The check here only allocates a new stack segment when capacity
> is exactly zero. If, for example, capacity is 5 but nelems is 16, the
> loop below will fail partway through stk_push() with -ENOSPC after
> pushing only 5 elements. The remaining chunks from data_seg would never
> be tracked.
>
> Consider this scenario:
>   1. Stack has one segment with capacity=3D5 (few free slots)
>   2. stk_seg_to_data() fails since only one segment exists
>   3. need_stk_seg =3D false since capacity > 0
>   4. stk_get_arena_memory() allocates only data_seg (no stk_seg)
>   5. Loop tries to push nelems (say 16) chunks
>   6. After 5 pushes, stk_push() returns -ENOSPC
>   7. Remaining 11 chunks from data_seg are lost
>
> Should this be checking capacity < nelems instead of !capacity?
>

Ack, the AI's explanation holds. The bug was introduced during
refactoring - will fix.

>> +
>> +	/* Get memory for a new data segment, and possibly a stack segment if =
necessary. */
>> +	ret =3D stk_get_arena_memory(stack, nr_pages, &data_seg, need_stk_seg =
? &stk_seg : NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (need_stk_seg)
>> +		stk_extend(stack, stk_seg);
>> +
>> +	mem =3D (u64)data_seg;
>> +	for (i =3D zero; i < nelems && can_loop; i++) {
>> +		ret =3D stk_push(stack, (void __arena *)mem);
>> +		if (ret)
>> +			return ret;
>> +		mem +=3D stack->data_size;
>> +	}
>> +
>> +	return 0;
>> +}
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/212569=
73563

