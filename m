Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D93033C1
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137006; cv=none; b=UoL+PX7UfrFZHLLjpyVTLIdxETtE/Nrd3zyaPmXd84BEYP9ub6aASDJO2cZa+OxnhDv8g+J3TXcVS3FdYxf7EN+wk5bV/8IU9TWq4N2t2zsJQOm7rCPSgqb2s1nCUw8cwyyui0dxwnRN19GLOxL1ZzDlOXwTlmiLfCFhEt3qSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137006; c=relaxed/simple;
	bh=MqGqMyWtIZIROs//UB9ry7kOeWqArIb6NE7EBt3/nY4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Wlyrm1/JYW+Lfk3Y+FIJ+o61LSY0hLo+QHIsaGmRSwOCGIeADfIirCnt5SiPVtGx2NlBp6HijhWzPawcWR6p3mvw1UNYE6Viw4Rs7VV8vTMkSPpeCF+2wmko3U8vnJ+/ptddfZjctc+CKNlQwPFNYk2ARKELaQ9Ak5qBfckIGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=S674R+w3; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="S674R+w3"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8946f12b1cfso25312606d6.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769136989; x=1769741789; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAJOvsqeVt/BO+ea4ZRDUP6mA4G1S6VR0+hvji6Vcog=;
        b=S674R+w3z75QXedF1Qpp0UA+E6U31FsKJQnEeY7HG1GTm+vDCe4uZSBpTEu3RWo7il
         qYtx+C/8PaiNCh95OSuk9xTihGjRcjTlIaVtcaDfE8HyNZetVu+KXt98T58O8P0S9Dxl
         rf0u2n6dX7gqyIVc1j7htddnmMdHKYM98jXw1PrfoaWcWa2zJDDi4DpoVVnREBGp4RyU
         hRC3ad33slrY4zJYyhvBx1FHezgYCILyjMYjnImNhikIqGLK85kAm/HxbO3TpdRPeLgj
         K8gwfW4XiNMpG9/9kdeEiaGhooDZXwRvIVTJNf6QiXATHZItsObWG+xrXw9K6w2juq/0
         knNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769136989; x=1769741789;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAJOvsqeVt/BO+ea4ZRDUP6mA4G1S6VR0+hvji6Vcog=;
        b=Zvt7UX1cEgFMUougOzXtT/2oBGG23kJTxmusxwkZfvEJd1TSb2kRsQmqJH3fWaOynJ
         olQWr2RDmhFvJ3mmTyz+D7/hCDAKxqkciHVcpQY/1CGZIryYy6aiIZAihu9nYDeh+ZfT
         QcFtzF2HDyTje7TBfAt+ueflR8z1YR47Pxk2r/CyFshRpBs3kxuoOZ6clMeNATY3WLfN
         WPsilPg5wBLmzqLK31FC8gZtx4arjmq1oHq28gDK5QWm420eF330ZrLrCvAByd9M7Shi
         Vp/9OnWLBKgWiZtvuHvhF/p/Cg/G3GkrK4BNLXmHaGvJkAI0S9vRLIi9feSJ8ztzXBkA
         68/A==
X-Forwarded-Encrypted: i=1; AJvYcCXYUeq0EcbrXPpzjGSBoBMpgIUJ2QcIlhd9IXwSo+5C3h9ixBuDUIxr059RFAiIa9Guvd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37CBbe8Nm7KcK6fafGv9UvzYAY9NFjrfTAA7bic9ifrCj2qYJ
	se7sStKd5sKHDgd8bjdBA+j2CgwPj+TnWdMYrJeYIwFRLH/KyCQUo5d2H0N1GkuyCrU=
X-Gm-Gg: AZuq6aI0FA9xumQFc9QhX3Zvsce/b96Is88i6BUkqmMW+o2GNDtmdp2bveuiH8BsXkH
	Ht9ieOx/IjJbdXT08FrT5A7xbN2kuyu6e+S8+zP1JAt70uQuYLJ2SQSLWy007/qejk3nFCJHVcz
	AXG8PDB9XKQ2AP4NMV5zOeMnetJsCGEQjPzbCJr7CKtBZDhEx6egdeZxjnmU+iJDdnRKp8btqME
	ywxURy/ZL+oPIY/6rel9N6I3AhaxjdSk2NenteQfFYV59gq21DRUpxXTQfGWEO+Bvkx+uBwT24m
	edQBxoFM7mrHu7tVEkyUD9ofIpIdGNcfdZ9Eg/iiiKeeRd4oq4Ud5mLEin3wgID6LPlMyovgQOx
	PLjGc+whjsbcfkqQWUyRRth1WUViKuFKH7hKC2o8wu1NBjuLjXt9cB8nZdqDRLeQzlQVCLro1pD
	BuSsYpCEHoVhw=
X-Received: by 2002:a05:6214:301e:b0:882:3759:9158 with SMTP id 6a1803df08f44-8949022b8ddmr23557836d6.61.1769136989234;
        Thu, 22 Jan 2026 18:56:29 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e3854a6csm75303985a.41.2026.01.22.18.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 18:56:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 21:56:27 -0500
Message-Id: <DFVMQ08L200J.2UTQGHB63QPOK@etsalapatis.com>
Subject: Re: [PATCH 06/13] selftests: bpf: Add arena ASAN runtime to
 libarena
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <etsal@meta.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
 <song@kernel.org>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.20.1
References: <20260122160131.2238331-7-etsal@meta.com>
 <fc73fe661a977aa87f21e92e96bfd4e63bcaa54c5356627257a8d485dc515821@mail.kernel.org>
In-Reply-To: <fc73fe661a977aa87f21e92e96bfd4e63bcaa54c5356627257a8d485dc515821@mail.kernel.org>

On Thu Jan 22, 2026 at 11:58 AM EST, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/asan.bpf.c
>> new file mode 100644
>> index 000000000000..7d39ee7b68bd
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
>
> [ ... ]
>
>> +static __always_inline int asan_report(s8a __arg_arena *addr, size_t sz=
,
>> +				       bool write)
>> +{
>> +	/* Only report the first ASAN violation. */
>> +	if (asan_reported && asan_report_once)
>> +		return 0;
>> +
>> +	asan_reported =3D true;
>> +
>> +	asan_violated =3D (u64)addr;
>> +
>> +	if (asan_emit_stack) {
>> +		arena_stderr("Memory violation for address %p (0x%lx) for %s of size =
%ld",
>> +				addr, write ? "write" : "read", sz);
>
> The format string has four format specifiers (%p, %lx, %s, %ld) but only
> three arguments are provided (addr, write?"write":"read", sz). Is there
> a missing argument for the (0x%lx) specifier, or should that part of the
> format string be removed?
>

Ack, there is a missing argument - the scalar representation of the
arena address. Will add.

>> +		bpf_stream_print_stack();
>> +	}
>> +
>> +	return 0;
>> +}
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

