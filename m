Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541B340273
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962598; cv=none; b=mLjyOFnRdIBN2lynjLb0zTy0mL8g4gaWZge2/wofpYL8/ORfnzDKREmgqz2Zq5bfmLzYXutYOdBxZbmREtvBCPq0dGb6b/qq+J+b9GrJ75CpKgQ7dhsUM9lBR3uxHLjrwIRFVU6+YRafWw2zxkmzdnIGMghDG8IWIEkVzWiod1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962598; c=relaxed/simple;
	bh=7WtcQMbdSrB6z1NYpc2TFhkRNc1roGBetSg8T/Ub+Rc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Vvixt6J5yR01XtcrienHEMA9ue1LD3E2Oim6xSlxICrfCAEWCPnXFADFeamuNXrYTuEHbgAC7qqOpOSk09JXzi88YbhFRFkkLPpw/UJzC1pURf1nUwY0k8UkgGFcGzv5EiuZmhNY5a82RQ57O/GY9pYxQcU06XCUnYqjh+LkP5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=MCYDEwRy; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="MCYDEwRy"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2dec803f9f0so4036736eec.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776962596; x=1777567396; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WtcQMbdSrB6z1NYpc2TFhkRNc1roGBetSg8T/Ub+Rc=;
        b=MCYDEwRysu5jusmUIbKH+XDsppU2j47tkO3MNQhWJpYw+vBdxkga85dfhlvPU07y5+
         GP7g8BIGusbZR1N+fiIasrllb9hCZeMLOW87z8OKBuivziKDeZlp85ca54LmmIo1t0dj
         AMnlIpSgIRG2XX60MkQQTN50lg2WGTNX4S1lYaZYpVkbpavtKWtLSFFVkjEnqvnTdGr7
         ZU+OHeCn5eYEdMooKIJyCivmDiQZdprxidM6JZrnTBVrHbp7UsM85gGAHDi3ilcH1IqP
         I8cFh7bik2upgzZg0LBA2C88XYBa2cpm94YPBraUxIeWRpKMPr6KvUBQYFMosz6AAjG/
         NkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962596; x=1777567396;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WtcQMbdSrB6z1NYpc2TFhkRNc1roGBetSg8T/Ub+Rc=;
        b=eb68rUPbAahmwZ9k+yuuK1MTCSvnzWroB6xMaLOyC6IletPYoa8IpCxAF//ns8IuDs
         CM+v6cE983uf3KsfuPnJUsC5fgTDeAJPDq0F96MxTypBA5rpfaYxhX6aRYm4rTAACD0U
         T+VD2XpICWpZZa0xglR5QVAFDKznao4QbzU4/w90MiFfp7x1nxedOHCwPIczjIq3872G
         UjFIFnPAnTY+SUPACzhcZ0oAL+9yHjTQrqN7GA7L6wz7cTywjeJK9FFFy10b+5Mo/e4Y
         IS1Yoyyd0QNdgryJEQSg11arzXSuHMhcrBUwW6vllyOhrue6aPGF3pnqCsw+1TnfViq9
         W3lg==
X-Forwarded-Encrypted: i=1; AFNElJ/kQUPqkg8GS/ffPnJU53quZy3hUf8DaPCjXT+B6fifQ73sLVryOj92jVvtW+iY3w/gwfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJjVaB6UEbhXrvYH6P1wrXNUtZ2kxVqaKpwz+CKHnP8yNM/QP
	/R4JSlVAPFeZ72c7SprO4oz0g2mV5lDUhPeRZuotuNkHqf+DHWrWAQDl/m0et6+29IA=
X-Gm-Gg: AeBDieuHRkFNeejcCmd5aLbY9QziRHSeUN1C0U8iIg+MUSglC7FsRHeu507NuOSf5DM
	bRS/mm6jwOz1pfo9EHbqi+g43UL/vyBRKD8a99MYmJ1elDnXvj8BjgJxxQYpAbSrf1A6M07GnGF
	2WZfa0ybiTPRStBbYakayT/pczy0KH4/n/xor/aPsJzHUFImQsh8/3VAAxvu5BFKUOEChPfptnr
	7zZ24fHvrqDYYVjhBifoZAbA2kkNWFuwLYa2tjQZWbFywTBWzpzxJsYGQ3apTkOQJHqstE+N+li
	KEl5DKxfVOQlx23tEQbuwQo1pw4/JncxMnX4bl0MwE6g0/55H4B3cD56yhhBFx7cm/GJWjqMsjf
	EGScxiSVTMo368gI5GV/q6j7XxCfQjguGk0VLrRkiS4F/IutphGLguTnZSr1JJG7NxFBDuBuAHn
	4a3c7oTksb4tv6fMg=
X-Received: by 2002:a05:693c:3011:b0:2df:7882:1cf3 with SMTP id 5a478bee46e88-2e42c15cf81mr12423013eec.2.1776962596213;
        Thu, 23 Apr 2026 09:43:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::d155])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d9b056fsm37033153eec.29.2026.04.23.09.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 09:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 12:43:13 -0400
Message-Id: <DI0OO269VLZY.1M86OGAGEQTRU@etsalapatis.com>
Subject: Re: [PATCH bpf-next v8 6/8] selftests/bpf: Add buddy allocator for
 libarena
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Matt Bobrowski"
 <mattbobrowski@google.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <song@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421165037.4736-1-emil@etsalapatis.com>
 <20260421165037.4736-7-emil@etsalapatis.com> <aenb_fGyhCxiNBPY@google.com>
 <CAP01T75q0_9k2W46_ibNrbYeZwpQO-nO=ysqX1Do+CHd+rE8Hw@mail.gmail.com>
In-Reply-To: <CAP01T75q0_9k2W46_ibNrbYeZwpQO-nO=ysqX1Do+CHd+rE8Hw@mail.gmail.com>

On Thu Apr 23, 2026 at 10:00 AM EDT, Kumar Kartikeya Dwivedi wrote:
> On Thu, 23 Apr 2026 at 10:44, Matt Bobrowski <mattbobrowski@google.com> w=
rote:
>>
>> On Tue, Apr 21, 2026 at 12:50:35PM -0400, Emil Tsalapatis wrote:
>> > Add a byte-oriented buddy allocator for libarena. The buddy
>> > allocator provides an alloc/free interface for small arena allocations
>> > ranging from 16 bytes to 512 KiB. Lower allocations values are rounded
>> > up to 16 bytes. The buddy allocator does not handle larger allocations
>> > that can instead use the existing bpf_arena_{alloc, free}_pages() kfun=
c.
>> >
>> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>>
>> The implementation of this BPF arena backed buddy allocator looks
>> rather solid. I noticed that we have a single global lock being used
>> here to synchronize metadata structure modifications. Have you thought
>> about how this might be a high contention point, particularly when
>> dealing with systems with incredibly high CPU core counts? Did you
>> consider possibly making use of localized per-CPU caches for the most
>> common/small allocation sizes or something like that? This is
>> something that definitely crossed my mind when I was initially
>> thinking about implementing something like this a while back. I
>> understand that this is an initial implementation, so it doesn't
>> necessarily carry all the bells and whistles, but I was curious to
>> know whether this had also crossed your mind and what your thoughts
>> were on it.
>
> Yes, both reentrancy protection and a per-CPU caches are things Emil
> is planning to work on next.
>
>>
>> [...]

Can confirm. This is basically just the first version of the allocator
just so we have some way to manage arena memory without hacks. The first
thing to optimize is adding per-CPU caches to avoid contention. I've
avoided adding them until now for two reasons:

1) We don't really have arena workloads we can test optimizations
against. I am working on porting microbenchmarks from userspace
allocators so we can concretely see the effect of any features we add.
I'm also working on adding data structures to libarena, and since they
may do allocations/frees during regular operations we can use them for
benchmarking.

2) Until recently there's been limits to how complex an arena program could=
 be.
The allocator by itself would exhaust the BPF call stack, so adding more fe=
atures
would cause it to fail verification. With recent kernels this is not an iss=
ue so
we can move forward with more features.
