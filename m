Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207386;
	b=AYVNk9Rht3/tBHydP/iRWlUEfL4FTkNJM56rkhX9ROGsN5TTCT7TIggmou7vebOMNsJ0
	 PTKBk08WtO8a8MAPFbnICWQwDB8DTqzQwmVBjCfiqjWs9jlZ7tTDo/9Ztr+5Uf9l1Fam6
	 55QPmiybGlJbSbXqWkE+y+8abm+ziCKj3Z0snpphdsb9Jj3ytNAF9nQdm/CJsHV2Fw4nG
	 za11vivrVBjZQG91QbbauhWHhwVzUYks+oPkv2yGFZ8JUb2554BWSn8Ed5o2FJTNIW8BE
	 RPKJiEyEy+ZP9TjCAWhNGXkGFP6trOcOW4RPB8r1OQmCTXszPr3GgLi9ukm9wpdR9YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207386;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=gYU6H2/wBp0m3RHfRk6KSsrkcHEKkYUH+D3d0ccp7Sc=;
	b=NLNXcGoVvxf+SQC/DSdcc0Zvo8t8cIKPckrGen8F8FMvjxpOVS6COJ4vEMrMjyaXLN9c
	 0/B31kKvPbyvOdulgfnCg9UhKroJZLwiSDCXbrP0hicEQ3bRqMOHZ14G7Nzn/xGrLXk8L
	 VdN6JdC5yskgcDayQZAAlmTCbGc/PNAtMGTXVHUSUOrGQPKQY8UqnBn+hSJO5z+bn7w/7
	 sE7/8JlFjSTwDR0wog15RtPHXIK+G4IPqv2fOwvbIJoCPftXp9hUrTuyYYWQIOYPLI7Qu
	 L5BHi8vKluky4h3B5Y1nsn2EyiVGYJbqNWGj6iAgNARPdA8vfnWbI6xbSsNVzcbjvhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45484606A70A
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45484606A70A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9496473b511so155202085a.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207385; x=1795812185;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYU6H2/wBp0m3RHfRk6KSsrkcHEKkYUH+D3d0ccp7Sc=;
        b=Sryf/SM8ERx3biUEHcWUqBEmq/k+AqJFdynkHNqSKze9TsYvBvuYwC0mEtMl2Agnlu
         H0PYah7n2VN+E7YOJtl+A7L8IchlMvxqzIHJc4p8u/XJa4pFbXpYHKVGiLeCYfAJSKsi
         qxSlhCSrPS/JzOWj6MML6InnF3/AbKXk4I8PJgAQXmKoMlLZBL/Qjr/vs+gdPGT/K4/3
         djfgF2SuuataENcBtFbj84Ikclv6XN9w3MmeYihKeJG01q226C2Zses0vmC+sqcL9EXe
         f30qWk0o/aNL7L/l6QWZ24XT3e7cET8xhPjVkhmGcjBMhP8beB6KoGB8dN3b5L3niHG1
         DM4Q==
X-Forwarded-Encrypted: i=1; AL+hErHT8h1Q+r65DvcQ1yaRgreV/ni+piWbaJdfbCKcr5SVRzQbBeRMBfH5Jruuo2graLZFZbg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HZsdIWUTbj8W1qsgJBkak7611losDs7Dz1z5P1ag3OxMiTyTQ
	1g3Iictw+CNoZme8ALarqzHk0PAiBZgLQWLEDMu3pQkEcU9dGvebPkCR
X-Gm-Gg: AYBFou1PnJq5KFSE1b+umHdiVJjemDJnhSlMTqqhv1uvhrGYuRKPw0Gtdn1gFmB7ifA
	eDYJh/rW40uPXm4pUVquITophNdzLH+Or/guPxOgBOtZ5W6mT45y/3LwSQlytaGIQHNBih2M7ni
	kXVc+ADsdHywVhs2t15opoGorhDrZ7b3ZXMPZZmPdv94BNANr1Zs7kF4fCRJteVMgxKXzDZwWQC
	lS74me2MzFmO1UFDuWq/4aOPC2U2TMiYgLtZsDzcaERofJWEAk75NSag2T0FVzsFO4+ZP88PNYz
	7HZCcgWMaoKzD0kJPLRbYY7ZPp/GY1D280NkMF2keOt3MnRw7ovRf2FtcDEsArshgxXukf8dTUS
	xsE3Eli9w0ATXhI3VqNypP4xPTWBFATNkjLwRfr5aijSCDzjisZICtfmPYl9p8pei6b39eVaDib
	vnlIZVepcGOfATRvbF42tVcpbxyrXujlLJtYtfToxwcA1WLNA087JLFs8pePbySVkhh4iqkdydN
	AQ3L3pPAAqCOyKcb/7Ha4V2iaJoJtez+UXe26PkTuEbkVvemo1AkJ2ct/C+1+Toufxz67BV6Fxq
	voYUgscNJeJ7bHp/dcE5UDOmW4qOkJ660db1nSUPzzX3k2hxiJ+aM5IrRXtD2fNqLg0A0Kg7Hx2
	RHE8JlDKJFJcSO4jwPZfb3NQX76CcXzBbQY80z0k7e4nUM0038ffh
X-Received: by 2002:a05:620a:4142:b0:945:d6e9:9a8c with SMTP id af79cd13be357-949baa0735emr674761885a.33.1795207385322;
        Fri, 20 Nov 2026 12:43:05 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb418241sm271210285a.38.2026.11.20.12.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:43:04 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>,
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>,
 Bing-Jhong Billy Jheng <billy@starlabs.sg>, David Vernet <void@manifault.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>,
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH bpf v2 8/8] libbpf: ringbuf: Prevent missed wakeups
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711471.18576.6533152874363127425@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYKewRUpOboOmPcxdX25731tF0w63V0Ha=_f4D_F-ie3w@mail.gmail.com>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-8-33fde039ddf3@kernel.org> <CAEf4BzYKewRUpOboOmPcxdX25731tF0w63V0Ha=_f4D_F-ie3w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> so we do this one time retry

The retry is needed for correctness. The producer can commit after the
first BUSY read but observe the old consumer position and skip wakeup.
The consumer must reread the header after fencing before returning.

> [...]

> Wouldn't it be cleaner and easier to
> mentally follow to have `goto done`

Done for the bound exit in v3. Callback errors now publish, fence, and
return directly; cnt = err is gone.
