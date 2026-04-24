Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221230C368
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044349; cv=none; b=sUTEAMaSze1oUUHAwWKqCRSU0iu2y69t0YMWpbLvk2UgkrbGcxbI2YV0EK0tzeHBb9ugfMEsTM8SHorc3KkptPfCisOH7EcIN8CWXwXCan+EqcrqWpPoA5v3qqsNCZA7TxDqmZfN7lgwEURxmy8OIciX0kDhuPTz5GXmKAvgCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044349; c=relaxed/simple;
	bh=TpKo4M0hxb+SvYSvyVv0pz9cZDVDTN6b9aQgAQ0BLX8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=pldj5aqF6X0F6n+kibtN17mdOYcN15gWGEiahDBdt/GM9l8IhMW4hBDyPjRnf78eY8wzbxoxVVkA03ivsmj2IcC/VHmwjvTBdX9mbQf8f+p7E9kRLv+K9SGfjMmJUSED7ai31VWblkTe6kB+++sz9LRON26cW0SbV654EiLYtSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Wqeynxx0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Wqeynxx0"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso5371456b3a.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777044340; x=1777649140; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpKo4M0hxb+SvYSvyVv0pz9cZDVDTN6b9aQgAQ0BLX8=;
        b=Wqeynxx03iyplNSHmRo/qGFNKKrg0ZHJOK4iYp5qH5XfRcflpNpq4fkiy3RvyNlYPm
         Aboa+CBRqVqnh2KYc9H6UXa8JkiFQMNn9HGfVZ0jNIp+PXB8sxs/a8iUSoKOiBM/nn9A
         VLa9bL4267Uwzjfk8Iwa0izCLilwyHEtCw2h8K87+SsW3qG5Pm1QQb3d1/pvcRbwPO2Z
         dYw9pOHsxD1+PuVv9hp6hGdgGXycLWGiJUJy2p/8AQDr4abW8RrjLPDVCTIVPMJeFVzm
         X/tOZsMCTHqEvjVqlohzJ4tguBO5NCkkqQVeczW45ZK61qT+y/VnIilQyM8l5m9c8zyk
         jbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777044340; x=1777649140;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpKo4M0hxb+SvYSvyVv0pz9cZDVDTN6b9aQgAQ0BLX8=;
        b=RuXQ7FL2O/3f5QXmovhmceEPA/1KchdWUNRFMTiZ4A5u9izf3VzlIRmz93KbmXaZ3A
         itjZCV3qet6SIRb9WS+kLnW+wRcUozTFQyGv/SMSsXM8UTKWSOOAKbq8aUfpBNrFRszz
         KhtiXwXzSAENpKQq9KtQLixSni7g6PktVbWNLoXn9bJhIHvNtpSiGURauQkGCS8bom4O
         vJEsux3P0nRfJ58TYh0DoZFSsIBIZvS7wLoT6JxOuMT4Jwxz/0thB715cs82Nf+bedEg
         8RueiYm/+c+ldDh+78cKuQM+3TnTb6qpEz2bhha27ScY94Rl+WKejDJmvvYzV1Tc/qC0
         IdiA==
X-Forwarded-Encrypted: i=1; AFNElJ8jf8EaCrKjAuP3q4Nx/mDdSxlyRKP6y9tiLHFVY+YiU2IbERNnS2OKZdtmfme8pG1E+as=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MTdjyjIKL+sDOTed5/PxJzT7rIIwRzv9boe7qZfGsi+fhTxs
	oOBlLZWFDFXf0sI7hVw/N43grYbbS8Lb7guwzR1G4Yl8/KwqoH7e80g3AdaqA/j59bw=
X-Gm-Gg: AeBDiet4hOeqNGXmJZonyWa18QjpqQqXDr9gVOws8CAQgP/OYoiyW1mUmFeC515yrmj
	7QT3YLD/Wc79yEdUhRThd4pcDlMyR6YB0fyS9FyocU2kERwS6ZaVAHZNbjFcibVAdzS84D6CQkh
	8YQkB6gF3r6bwjad5CMtERDgOTM2Wwc28YwdVX7k8IZT4nYVP6MVry0dnmu7p77a18hgxdIEkyz
	OTfbsZD2W9iFA4pEbPn2SYuC86I7ljN0oxQZSmgboPEjRqCVELsZte1SrW0RsEMhzudGkmroeSn
	/mAsF2ADEhivRtLtlbL9yfq0U8uaw2A/1Yi9gC8CYSoiJF4/FuCa4cOAHgQHchL2EggLKN1Jdgr
	OigMGYVdHfUQcEZ50PZ2NvfsbepEHrFK+TPve0vfgQTRIq/Crlq+yxsl5L18i5Z7X61gvscJ5LW
	osRkItqNSbmNwOVz/DLw==
X-Received: by 2002:a05:6a00:22c5:b0:823:998:95b0 with SMTP id d2e1a72fcca58-82f8c92e270mr34905988b3a.35.1777044340106;
        Fri, 24 Apr 2026 08:25:40 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e984f20sm26055386b3a.8.2026.04.24.08.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 11:25:39 -0400
Message-Id: <DI1HN7C4510J.3UCM0Y25BPP7T@etsalapatis.com>
Subject: Re: [PATCH bpf-next v8 6/8] selftests/bpf: Add buddy allocator for
 libarena
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Matt Bobrowski" <mattbobrowski@google.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <song@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421165037.4736-1-emil@etsalapatis.com>
 <20260421165037.4736-7-emil@etsalapatis.com> <aenb_fGyhCxiNBPY@google.com>
 <CAP01T75q0_9k2W46_ibNrbYeZwpQO-nO=ysqX1Do+CHd+rE8Hw@mail.gmail.com>
 <DI0OO269VLZY.1M86OGAGEQTRU@etsalapatis.com> <aeqACzTZKohGZnuo@google.com>
In-Reply-To: <aeqACzTZKohGZnuo@google.com>

On Thu Apr 23, 2026 at 4:24 PM EDT, Matt Bobrowski wrote:
> On Thu, Apr 23, 2026 at 12:43:13PM -0400, Emil Tsalapatis wrote:
>> On Thu Apr 23, 2026 at 10:00 AM EDT, Kumar Kartikeya Dwivedi wrote:
>> > On Thu, 23 Apr 2026 at 10:44, Matt Bobrowski <mattbobrowski@google.com=
> wrote:
>> >>
>> >> On Tue, Apr 21, 2026 at 12:50:35PM -0400, Emil Tsalapatis wrote:
>> >> > Add a byte-oriented buddy allocator for libarena. The buddy
>> >> > allocator provides an alloc/free interface for small arena allocati=
ons
>> >> > ranging from 16 bytes to 512 KiB. Lower allocations values are roun=
ded
>> >> > up to 16 bytes. The buddy allocator does not handle larger allocati=
ons
>> >> > that can instead use the existing bpf_arena_{alloc, free}_pages() k=
func.
>> >> >
>> >> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> >>
>> >> The implementation of this BPF arena backed buddy allocator looks
>> >> rather solid. I noticed that we have a single global lock being used
>> >> here to synchronize metadata structure modifications. Have you though=
t
>> >> about how this might be a high contention point, particularly when
>> >> dealing with systems with incredibly high CPU core counts? Did you
>> >> consider possibly making use of localized per-CPU caches for the most
>> >> common/small allocation sizes or something like that? This is
>> >> something that definitely crossed my mind when I was initially
>> >> thinking about implementing something like this a while back. I
>> >> understand that this is an initial implementation, so it doesn't
>> >> necessarily carry all the bells and whistles, but I was curious to
>> >> know whether this had also crossed your mind and what your thoughts
>> >> were on it.
>> >
>> > Yes, both reentrancy protection and a per-CPU caches are things Emil
>> > is planning to work on next.
>> >
>> >>
>> >> [...]
>>=20
>> Can confirm. This is basically just the first version of the allocator
>> just so we have some way to manage arena memory without hacks. The first
>> thing to optimize is adding per-CPU caches to avoid contention. I've
>> avoided adding them until now for two reasons:
>>=20
>> 1) We don't really have arena workloads we can test optimizations
>> against. I am working on porting microbenchmarks from userspace
>> allocators so we can concretely see the effect of any features we add.
>> I'm also working on adding data structures to libarena, and since they
>> may do allocations/frees during regular operations we can use them for
>> benchmarking.
>
> Both sound like relatively good ideas to me. Notably, this point has
> sparked another thing that I was kinda curious about. Do you envision
> libarena being hosted outside of the Linux kernel source tree at some
> point? TBH, I think it'd be quite nice if it was. I definitely
> envision something like libarena being a submodule within numerous
> other BPF-enabled projects.
>

Exactly, that is the plan. After the change lands we can periodically
sync the changes from the kernel tree to an external repo (e.g.,
Github). I am thinking of reusing libbpf's export process since it works
pretty well, but the details are still open for discussion.

> Also, I kindly request that you CC me on any future revisions and
> changes to libarena.

Gladly! I will be sending another version today (that also incorporates
your feedback on patch 2/8).
