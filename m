Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E43DA5D6
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038927; cv=none; b=CtN/MUhHnGJyLoWb4kkLR6uZSbF2vMOimop9WZ3m2krZKPmNqhzAmMu0JgcSPj8U0C2c2XnBIpAl09ssxDk3IZLPnYQ1UhBuVG+ZcXIoZKGwsjq4HZSHhRz7amIp4EK9mehNQsMjChXy7TjVLiPHSpiVSspwwBH26SEgWwj9OHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038927; c=relaxed/simple;
	bh=wgagBRLyH8qIXtovF5EORtrU1tolXN7HaHIjxp4hZQs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XHjPvekDSDe4XIPCVoUMreSVE8dvoLGKYWrP2SBVPWAdv+6mFq2x5p/ouaToguDuvhIoUrFN4jddPB/EThA+EAVLzyLbLaAIf54pvaxx0sM/w1dKvX4FxdQCINh3DsMiEen3FL178BXJfy3UhlCpqehwWCC7teXIHO8WlcfTsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtZEhiRy; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtZEhiRy"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40ede943bf0so5059301fac.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777038915; x=1777643715; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQvhd5LemKsDut8MhDcz3CF4XZzc0FmAPAe5hBLKUsA=;
        b=HtZEhiRyiCTXLPoJBaYOLq0gzp37SzJNBkBiGbL0SAophDvy/Bl0d2RFNhtvC88h3d
         8ayEIlKwEyv2KCDUmr1RUVWdxQh5hLn2LJmPFoUXBtBRk1zWIDnuhou8CZjfPWtkm8wY
         xKqJIuieyX0H3fTnSzxSEIan83L4L7RPqpWP8DL3O3goh+MKZ96BBjBIhVRHqeSV4eyv
         xP2J2Rtk3/fAn/Uv/4J8gd+ffwslluSfCZ413o1Cs3baJcuyLwhXqm4Sk5wDMkfDks89
         iu6rq9BWX5ItgXSGS63e+0OazMcqA4EUMzyG4zOw6lIhtcWh3vkjjsyeAl2Qwhgl7VdN
         hBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038915; x=1777643715;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GQvhd5LemKsDut8MhDcz3CF4XZzc0FmAPAe5hBLKUsA=;
        b=m6I66VH90UFKW66cut3J86F36A4a1Lh+7d7qXYltE3imN2UjOLX2jjRiRMlRHKWLdv
         C05C3CofMOXJKQi5giQeYph+ibm5RMXiKeYf2l7QxDD7lbkP8Se/ER04uVpkaEKcTK8X
         rDWw2hzOQ4R/fu9T2tkM61RKAjoxY1KYLPs/Drb9t+f/1Kc9oiqAeDwzoFrym5tdmvE8
         3G0x434qpVZtESnvxF8WxoNlwlfrvluteytB/5P6YpoKbUZ+gikD4KSn1SHD0yUNQc+d
         ggRd+22192rCa2S/MqwzaQyiIOmBpZWcgSw2ocU59x70LO8/kzaXXvCvHyQBDBiMzIw3
         DxYA==
X-Gm-Message-State: AOJu0YwoMaWa2IUlfrP/wJ2EMNaufXHgAgIXHvfRMWX4qhzjzfX/GJrf
	Vy8Kvo1LW1TF0JCd2MUUPK1wF/u1kMuLVFBr+Ls7YgtIpJ2u7BQAPmZh
X-Gm-Gg: AeBDiet4a+hbzhybIOHbXNybxhPyl/SikVdGWgYO0/NA1mQQb+Jh/nTqrwD2cDa7z+A
	cvFg7if6tJDx8RP19QpLQ1lL388neA7BLFF094hjN+M0x2YcFaLKSM6XF2X53GQzCND8GNO12Ua
	CAWa21yOsDFQQN6h5rHo+ET0I9BN5WASX127rJTyh/3U+tbb31DDaDIgosU3ff8NUnvCpB6Ofs3
	hJ4NS8OfHnZhHywc5NTycFkg+Dxl4cqR5c69onqNgdBG02eBvmsA3hJLiasSUJdfpTUC8s5iZ65
	o1dd6AeuAJ+0mxvjGJPWm/Xvym9mU283KuFjJKgEuEQVzgQLsKSbVicJdGqtlIEgEYDRGSgwfXE
	yo91fmRalywvfIkZWTU5FOc/EolxAEJyO6zk5mysUMXvZrp7MruOWwckl2x5M7vTSzOeomy9BNN
	Ei6zJb2ZGbzIEdw/r5aB16GdJC0y0P4sHR82ij4MVbWOHHHsKp3W8IGR5EtPf2Laco8ynguMl0C
	WuyivEDWDUyAYBcRJG+/f0cVl4R
X-Received: by 2002:a05:6870:ac27:b0:42f:d9f8:ab33 with SMTP id 586e51a60fabf-42fd9f8e971mr5827984fac.28.1777038914827;
        Fri, 24 Apr 2026 06:55:14 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b934a2e8esm21854589fac.10.2026.04.24.06.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 06:55:09 -0700
Message-Id: <DI1FPX3685EI.3QPD29NY965FO@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@kernel.org>, <mykyta.yatsenko5@gmail.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 0/9] Refactor verifier object relationship
 tracking
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260421221016.2967924-1-ameryhung@gmail.com>
 <DI0Z4SJ0TXOA.2N0IY94AF254F@gmail.com>
 <CAMB2axMg=Y5q=9CEFs=8rHLQJipT-5rYkg3wp2BhWgDwVvOUQw@mail.gmail.com>
In-Reply-To: <CAMB2axMg=Y5q=9CEFs=8rHLQJipT-5rYkg3wp2BhWgDwVvOUQw@mail.gmail.com>

On Thu Apr 23, 2026 at 10:44 PM PDT, Amery Hung wrote:
> On Thu, Apr 23, 2026 at 5:55=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue Apr 21, 2026 at 3:10 PM PDT, Amery Hung wrote:
>> >
>> > (3) Referenced dynptr with referenced parent:
>> >
>> >                      file (1,1,0)
>> >                            ^ ^
>> >      bpf_dynptr_from_file  | +-------------------------------+
>> >                            |       bpf_dynptr_clone(A, C)    |
>> >              dynptr A (2,3,1)                  dynptr C (4,3,1)
>> >                          ^                                 ^
>> >                          |                                 |
>> >                          dynptr A and C have the same lifetime
>>
>> If I understand the proposal correctly above should be:
>>
>>                      file (1,0,0)
>>                            ^
>>      bpf_dynptr_from_file  +-------------------------------+
>>
>> ref_obj_id will be inited bpf_dynptr_clone() as 3 into A and C.
>> but original file->ref_obj_id will be zero.
>>
>> ?
>
> This is the existing behavior. bpf_get_task_exe_file() is tagged with
> (KF_ACQUIRE | KF_RET_NULL). Therefore, file will have id and
> ref_obj_id both initialized to the same value. Here is the
> corresponding verifier code:
>
> if (is_kfunc_acquire(&meta)) {
>         int id =3D acquire_reference(env, insn_idx);
>
>         if (id < 0)
>                 return id;
>         if (is_kfunc_ret_null(&meta))
>                 regs[BPF_REG_0].id =3D id;
>         regs[BPF_REG_0].ref_obj_id =3D id;

ok, but the arrow should still point to first '1', since that's
what parent_id inherits?
