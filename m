Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038150;
	b=XbmSjsbiD6NOJA7amlgToAvBzeaQ6oN8ax72HckykAhhFmvheNh1iINoBC7V1Tb48pNj
	 2sXsPYU1Sk2hb1XiOyfPHoI7ySNHtZgPnisgIMO9+14/oqgITzABV/dBT2hANPiOsLcHd
	 CqeNRojaZavXNiL0jSgdwcB8OCZFUZS3PpkLTvZQQ1uCmtoOqAVkOp9wnNtH26/EQGkGJ
	 MsKEPZGIOnxx5i0+uwPMIv96/1skYMIr4GvZi3MlFPhAmEX9i6K3y+EvXZ1Y+PkbKUBwn
	 5vqAMdYOxyW+fTjQML8egu/oHW+TxrlzjS7RCl29ZPTHrh89hips7AiBMTlvKTDs93Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=pdzz7LkxowMA5/oolvKxj7aqpaNg52beDkUQ9AFP9q0=;
	b=V8zVRF6oMHmRStQpTfQAqysEjaEft+tT3lTuhT+rs+BP8Dy4tccw8CiekmNmUbw/DQxM
	 Fz7wU2DQ/fF5lu0is0krdlWSZmcaXyJ0X3Q2pSPN87xHXWbLlt9OKFKoc39WGbn+49EQJ
	 tRAcIMeguQUrpLk3arKfoEvIingqcsnST+QM+3i4xm0zwGFxDxQyxlIyepbo/OSu98iPC
	 btwqIWux0j0EU+nq5Gb/64sGlmcnNNsegOWKcgNGrKXwYyGs22egJ4puYhoq2iXhOpSA9
	 6xOnLZO3LU3cnxtLZ/+MOJL/wgnHnCYTqA8HcrXkEnKtuai0iv6TstE0PCNNSZPd4pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ut2V3P3D;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D707606A333
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 21:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D707606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ut2V3P3D
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc758830601so1293291a12.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 13:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795038150; x=1795642950; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pdzz7LkxowMA5/oolvKxj7aqpaNg52beDkUQ9AFP9q0=;
        b=Ut2V3P3DtoZZ2MjzXy2yvrB518myCMYfnziJDcctRMg6j2Sot58SRKxlSTGS4tQ2Th
         CrPQbPVp/U0V+qYsKlvhJN3EkSG3JyYkYhJt9punYckWllRy0qjrXzdhYaATzEBZEvVY
         +sIs3kjbpKgs8QkIFcLeV2r+NA8Shwe8GoBtK/gIzeltSITGDXM8WKqUp8SmSkTb4JQ+
         WX0s7D9tMSW6hOqEUR7266hd8oCY5C0UC1VxGcbEAzRTlYIBDttCT1ewLozwIgjjlgTa
         OefsDvzQYO7MzDmWNKAvyWJVH1aSGMdHtC0G4ebnS0iAXQBMDDJCMqGBU+8Km5ueGJqF
         e7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038150; x=1795642950;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pdzz7LkxowMA5/oolvKxj7aqpaNg52beDkUQ9AFP9q0=;
        b=zNW0CO6WZoMxz48wO0NyETrZqfQjSVpol6wi+tQMRNbvgQgTzFYGuvfIcSB+PJAd8m
         Fb/9TAqTe9DfVwxj60LPWS+3bKwM21dyOg25SKYRjWbm+mcwufb8zyhab8JhjVQFDUbh
         n79Jw6UChcH/dLFhxPplUpnQs/nhA/X86boTtwAjp21wpmKvymKTOOtLBsQYIjvWKtcg
         1Jtn35xFb31Gm1jgFANYRpjdNgrxBZEmwmroMTHvDEIdduFZnLsf1kq8qHsoIWCtY/+C
         NoqP7Fwn3blEn5QO6PFlcJIwMk+2J0qBDLc/2y7aX2P688dhsqwZzX+bIRKKn6M7uOCs
         vLxw==
X-Forwarded-Encrypted: i=1; AL+hErEix+muGdQCkZ5lurhWNiEmvxhTG98t5U3DQZPE0iltkgwUR1JhCxtMHOU3gL5I2sqZLQg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lGMhGBznXQTGLUFNKR5bfm8V4MJQoQ2/Mk84kLwekxxapqTLx
	u1VAskbW4kuSi0JephCysWHGFHlqBlMxiYadCK3y8CGDU14hKwa9wmRt
X-Gm-Gg: AZFdTZff0jvrW3hIW6C0+7MYX6dGyPlREhr2cI1wuhvuYz+1jTYHrYFPywnShB5pYgW
	3C1ph8/0pwVjZIPD71c7zzdmM+hxKCxrao6UDq+nSvo+Bu+Q2F3wilIYN8Qzyzj3kQW4e22ltQT
	5ElqKX/qGpx31pUXpM590uMXGS3uRcbAdKqIEmSkxCPbd8gM+4KvmbwqYMwbv4Vzsvt0VV/zmex
	mO0QVqEIiGSaxf4VoA/F/ban4JFsfXCz1+iisSfFtMVX5Onggwe/Q/GF/mm5KpcTBlj4MXfWsyd
	3c2j6A7FFV+WG8PTDTBG4ywQ+I5VKfqFdBTk8GKQUf9u7PqA4FoImYbTwscrqSy4K2aC2k9vMaC
	26ySIdwMdofY50bAruuBdigDL4HeJcYJRe6tRVihsgFXQx9v8A/4SIhIxblFSlEDlSUk1WMW5Q/
	kxb5mW53CsWuRtViVEmJmJdK/s5xofHlJPPF3D6qgQwsaxUZqB8A4wrql5o3XWqaVtA8VgmzOH7
	tvP8aVevEV8PfBN5SOqgPX3TfNlogspO1KyFLB/R5UEbrc4kBDXGhc/Yp3nXpWUueAdnWU2IlPC
	kRCohtlXWBeUV+4E90z/jGeLRtk7XVFnn77ORBFxvE/XuLk1FAXf3K+T
X-Received: by 2002:a17:90b:4b86:b0:3ab:1b19:78f4 with SMTP id 98e67ed59e1d1-3b3d06a487emr4167024a91.6.1795038149846;
        Wed, 18 Nov 2026 13:42:29 -0800 (PST)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fdf44c61sm63748a91.12.2026.11.18.13.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:42:29 -0800 (PST)
Message-ID: <08d6be6e9e0dcf6570ecd83671e9dbe63a417607.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc
 flavors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, Song Liu
 <song@kernel.org>,  Tejun Heo <tj@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Date: Wed, 18 Nov 2026 14:42:27 -0700
In-Reply-To: <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
	 <df72a9ab1ebcebff573485a808e45cd493665e75.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-11-18 at 14:12 -0700, Eduard Zingerman wrote:
> On Tue, 2026-11-17 at 12:21 -0700, Ihor Solodrai wrote:

...

> > resolve_btfids fails the build if two of bpf_foo and its flavors have
> > compatible prototypes, unless both have foo's exact prototype
> > (aliases), so the fallback finds at most one match.=C2=A0 This ensures =
at
>=20
> Why is an exception for kfuncs with identical prototypes necessary?

Ok, my helpful assistant points out the following use case:

On kernel side:

  __bpf_kfunc bool foo(struct task_struct *p, u64 flags);
  __bpf_kfunc bool foo___v2(struct task_struct *p, u64 flags);


On BPF side:


  extern bool foo(struct task_struct *p, u64 flags) __ksym;
  extern bool foo___v2___compat(struct task_struct *p, u64 flags) __ksym;

  /* Resolves to the kernel's foo(). */
  foo(p, 0);

  /* libbpf strips ___compat; resolves to the kernel's foo___v2().
   * workaround used before this series.
   */
  foo___v2___compat(p, 0);

New mechanics adds an obligation on the kernel side to maintain that
foo and foo___v2___compat are semantically identical, despite being
physically different functions. (Does it?)

Would it be possible to use some kind of annotation, e.g.:
- __alias(foo___v2) (an ELF symbol alias), or
- __kfunc_alias(foo___v2)
  (resolving to some sort of btf_decl_tag for resolve_btfids to act upon).
And avoid allowing functions with compatible prototypes w/o exceptions.

?
