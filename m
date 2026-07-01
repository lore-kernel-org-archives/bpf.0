Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CB3914E8
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885048; cv=none; b=Tvn3IqZ0aHPLlXRr0Z0LXTxz6asvaaJ4/Fi+xbg20fnIEAhnUb0utXEeltPABmk1USgfbYP0LH6PhxuHCClg0ZC8P4Pj6ACXyExQnNLWRy2V1ZaN9htEYS9iftApJYa2C5/ogZYPnAI/gqDHpOPeMj0z5FciEcvPiP6+EP6DZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885048; c=relaxed/simple;
	bh=mmSPShkq+yvykn3QSSoYndfepKyvD4UBvw09Q5s8Op8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Jw4X9TCYncJh6pKt1puQ9Af6NME7wMKMWlk3F0oz6hT/21lDHbVVnR6Xs7/17pIp6PshCNrGTpV3V1LFOZJZNPgA+/u7EHnUDFiEMihvA75DlD900IbyQF6Plz3r/N6F36F5x7qIENY5IUq8wo7ynpLDeFKfU70NT/LkkUnGaAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AadCTgFi; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AadCTgFi"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9c7174e98so107619a34.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 22:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782885046; x=1783489846; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmSPShkq+yvykn3QSSoYndfepKyvD4UBvw09Q5s8Op8=;
        b=AadCTgFit7sT/VtgVFpehM+5mgXLJAKMhgCOoUKG/KIu2NymltMY+pJ755FfriEydr
         vnTHdzDzmRuiEgImtBZkytaXNREfCaezA7ebWsR9zRbi7w7bL7YVC5D8yfvbvZ/n70TO
         kKuQfAPHK6bcdIrDf8i6Dxum3Kn7w/fU14/TQ/WmhPzwef40TeihhVAi8nvw5E6EgqJK
         k5Yojg3gheZJctU2KkaGeZLhuM61KMEslVyGRhswr8agm+R8vyrVM7pbUyOKPZcY0OIA
         542mj1EIIfiqG8jHRIYsVWjllMVIONL5FCnodoMZ/LF49repMXsqomkfNCIL8KuEHLrY
         XiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782885046; x=1783489846;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmSPShkq+yvykn3QSSoYndfepKyvD4UBvw09Q5s8Op8=;
        b=UMWwh2kfQSHLKQN6PFmxuQC3+Ix6AkaGXg6MlGuPclRSZKhK0zXmThEMgUCIpYkdFp
         +qid+LKRr0n6NUXq+Ix2iaE2bWnZg+OLzvDZat1jkF4awSoPRbOqKcaivNaekLA7gWqe
         yD9KiILaw9zfebxFdsDXVf19Ubx8OFawuTET2lZwJYbP9hcWjBK3mjbC8kD0ii8Rz1t1
         x+U1NCCFI2RGuyVfhRMLGcuJT4m/XEekm2KhubBTIC5nvhaENkva7AM6N9Ta3oYtt5wi
         oyra8Xh60Z0YTDjbY7gN1854zja/KpSlByuNv3EdhSMUXBjlmrB9IJxIkpNXIkIsgW8v
         HV/w==
X-Forwarded-Encrypted: i=1; AFNElJ/d8GvvBHCmY0IZVmE4PLzy3iqBxKC1KYDxhCANUgdE+LLouRbX3IiAt87hx4jw/tHkeIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqLereJ9wXPCQyCNoSiGOPHLE5Y8HOl1m3c9LHL+5jyRUSkV2R
	wpdopd3f3+nm4CqT2xXapUgSxJe8H9b6zCXLWcasw0p1DpmublT3MzfX
X-Gm-Gg: AfdE7cm3V55mtmvEky/T41+LZAniQ7GW25kIIOOKi3PZGZ7Dr5omcGonGAXO2hGfen/
	EutQmjKb2sLWTGGNoMPTggo25JWrFVFw7RQOAck4pHO9+JbzBxUePhzdxZcSC6Gf397AeWcd1ND
	Bauc/pv1UU+rHoEyG+PhVkyCuDbZ2x19yjg3XFjqASjNc3VYqD/PHOTww3fsNimaPzpdBavkqij
	ouqi+YvoD2Ve83YcbFlssPVggxwJI4SpMDS1zvNORM5euiqypzxg3wfutbOavOTWtW9RniCE557
	KiH9DqrSFOdFKbn5iA33quZvQG9splTUVGNZS4r0kRhbCnAV4i2LyZOwL8R88T4Cv5439CMXxJn
	MzBhrdBC4KQunVNmGchbhbEsXkqHv9BhZu/3UiNatJ67KJeEjve/Xbkx7g/IN5Lstys+W9JIfSR
	ged4yVlyIDsLUYnmKpVfSKAxF8LFlXy4EtshZIoAGSqsbl5r1vXLgumcIvAywIcrXK+fV2fOag5
	kpEsA==
X-Received: by 2002:a05:6808:198e:b0:495:e16d:5d03 with SMTP id 5614622812f47-4960efea9ddmr138876b6e.21.1782885046122;
        Tue, 30 Jun 2026 22:50:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-49606b18bc9sm705829b6e.15.2026.06.30.22.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 22:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 22:50:43 -0700
Message-Id: <DJN001X0S57Y.18CKUS4NDDQT1@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Shuah Khan" <shuah@kernel.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Anton Protopopov"
 <a.s.protopopov@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH bpf 0/6] bpf: Disallow interpreter fallback for
 interpreter-unsupported insns
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260626154330.33619-1-leon.hwang@linux.dev>
 <DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com>
 <18678d0c-f878-4d7b-bf7e-ffca4967dec5@linux.dev>
In-Reply-To: <18678d0c-f878-4d7b-bf7e-ffca4967dec5@linux.dev>

On Tue Jun 30, 2026 at 7:59 PM PDT, Leon Hwang wrote:
> On 1/7/26 07:12, Alexei Starovoitov wrote:
>> On Fri Jun 26, 2026 at 8:43 AM PDT, Leon Hwang wrote:
> [...]
>>=20
>> I don't think we need such fallback in patch [3].
>
> Do you mean we can add the internal BPF_ADDR_PERCPU insn support to the
> interpreter?

No. See why CONFIG_BPF_JIT_ALWAYS_ON was introduced.
The interpreter is a security hole.
It has to be _compiled out_ of the kernel.
Hence all patches that improve fallback to interpreter are misguided.
The interpreter has to be removed completely... sooner or later.
