Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505C3E5587
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732238; cv=none; b=S9jPwTzy3rpeCbDKvcP37NzL4p8vZyun535cOChl2M3nIYwFDDgBt9kzv5czFTLFa1EhgxtnuRpQZE83FQfdzbGc9PsVeQhHIDQi4xm6bHQrEcG17LY0K+FZtTcSByQX7h3UKyXQ8K/JoOXMmx2hdd88iDZ72kqDIm+YZJItLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732238; c=relaxed/simple;
	bh=imh2qD5hhDedALFNVvNAAQiwtrSAuG3whWoUdfeuEdo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bZdBva5BdGHt202tCgjPrzlFSQ1WhUGpCBHg9OKpc75QxEPskGGVJB4Vv825PfPxXZIEkEkSrQCA/ujswk+DwwUPPO8SOv3TK3chcyH4IlTJls7jxHAHcChR6GcD2UDuZoIkA5nwFZeEURWt39oZJJrx7BLYm3d6GugtAvVNl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=dt3sUetG; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="dt3sUetG"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a0b376fedso22038546d6.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 09:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772732236; x=1773337036; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfapJ3SnHU85CioeOiLhVkgPzSM3mTPgrzaQjJBIiIU=;
        b=dt3sUetGy9rtxC0hzUFDDKsNPNmw/RyOBl4lhtEwA8UcthfTjGOWQkAS4et36EENV6
         Bsh/3LRgJMH76uEa+ZT5pnYQ3ooO3zx9FJ44bGdBBq2aMpl6DxCDwLnsWLtsnXJcH722
         qu0DCabF8ehbVZ0nkLTU3A2mi6GXMmx5hUQpNHyUpojlkU6xHr0rk7UguiW32Q1zUtP0
         tzatRXm6cjI4fTIh0pYcDPRX7Uu48r8voMNfQpUAImg1qBRM/lbkykYRi+Wo3jtmPzkZ
         GMiQhWv+KMRkfQvhERGqGPvY1p62fCte/24rMch5zdpN3KBh1Ejh4jh18ewc1/a7PC0r
         mgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772732236; x=1773337036;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfapJ3SnHU85CioeOiLhVkgPzSM3mTPgrzaQjJBIiIU=;
        b=M+q/RI94lpc6LY+Ae+a9wN7NOyz78EqdY1UErT8vd52jv9i/dfg7HrvL8T/SlOO8di
         d3/HCS4vuVGCq893Qipt37DzzmGKMSqGXxUYJgxZj29McAtMaEP+f2QtOMvDalXPqFXx
         GiYLXkytdLUbnijjzvXdp2M8GduMRgT2e4vz9knb+rAinLN0SWC7R4nCvnuTCnHKvszK
         /9hlZaiYmndC0ufFbhqBhqxVgFpkfXXHpzgSnE8MK5Kvn0G/tuOovggimASfc4i47rJR
         I1nx7sWX0XL8WsnHIjH4VDgwPMHbAGa2VbpTtZ24ZNlQfPHB9jx34GWyUsiRyDL9Fo4g
         qh/A==
X-Forwarded-Encrypted: i=1; AJvYcCWlZ9shJGKe72IUd0KLZRNQuPHhpJQk6mENMZ3ihTb7uFAZuPuZxMkoTghzVQiDI/Vu/z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZIl8oabluWivLrn3mn0SwAdZkj1rUKkYjeUxaVAIxLgYoTGX
	1hXLVI1u8WAtYplcjuAQvHq7qcU3sf+3P1KCPAiThztyNWzjR4fHW04yPkOMlcHU0KI=
X-Gm-Gg: ATEYQzxtBGSq3opNFzvDA3zRQCes1LM4rrmr49hg3DYzAW4P1fUEAGx5A7vaj8wiyL5
	Y6LBNNFNA+vXHDtAeuFHAvF0swh93gQM94gmJxVZT6jxIFvjJ8voUi7sqyup8cp/Bp0Yi2EeFEh
	6bkUoE8dC9MBx4Ig8Iftlx63wNPBiHWV67R/zf3ksthVVLLup7+nFmtluyg4Zx9s+8u/tvZDSSh
	2wmQhjbD7+kVd6AN+0vn6K3zg59sLPIcfuA/jgbfXu93fhe8G0IANt8AAOF4yPKJ6TkYSbDGnfR
	V1i+fcU4UPQbIe1TOWOumIdVtTqJB/x0KYQP07v+0qW1An5+Mn3CgfhghfNojUgem8y+sNYbQw1
	0dATwGU5I7p8GSv1n8P+Y5H26s1JOTNaI7dtiILHQJEMSdr68POeSOzk+XeMWV5jjrNIYer8/Lv
	Iqizyqt6zaFg/LPf8RevI9mu3ZmhQnYjuN/g==
X-Received: by 2002:a05:6214:1bc5:b0:899:f829:e8b9 with SMTP id 6a1803df08f44-89a2df64263mr10499746d6.23.1772732236199;
        Thu, 05 Mar 2026 09:37:16 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a02f359f2sm85438446d6.24.2026.03.05.09.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 09:37:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 12:37:14 -0500
Message-Id: <DGV14PR4H5M6.J2LAY1RFHHJ1@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <martin.lau@kernel.org>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Add deep call stack selftests
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260303043106.406099-1-emil@etsalapatis.com>
 <20260303043106.406099-3-emil@etsalapatis.com>
 <f7a9492407aafa4482addaa6a8879cc9441eecbd.camel@gmail.com>
In-Reply-To: <f7a9492407aafa4482addaa6a8879cc9441eecbd.camel@gmail.com>

On Tue Mar 3, 2026 at 8:15 PM EST, Eduard Zingerman wrote:
> On Mon, 2026-03-02 at 23:31 -0500, Emil Tsalapatis wrote:
>> Add tests that demonstrate the verifier support for deep call stacks
>> while still enforcing maximum stack size limits.
>>=20
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
>> +/* Check we actually honor stack limits (33 * 16 =3D 528 > 512 =3D MAX_=
STACK_DEPTH). */
>
> Nit: I was wondering why stack usage per func is 16, as each one only
>      consumes one slot. Turns out round_up_stack_depth() rounds things
>      up to 16. Could you please either add a comment here, or just add
>      a second long in each function?
>

Ack, I will clarify why this is the case in a comment.

>> +SEC("syscall")
>> +__failure __msg("combined stack size of 34 calls")
>> +int global_func_deep_stack_fail(struct __sk_buff *skb)
>> +{
>> +	return f32(123);
>> +}

