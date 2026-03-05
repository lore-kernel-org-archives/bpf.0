Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F11B4257
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709006; cv=none; b=F8Jicf9qtl/uO/JBThT/MIZGfOS4r9BXESZ5kXxL3Rcbg28g5u93GTF9sRo2Hj9DWKv10t8taKygvu/Pxvktzh5nLrHH9CGOMWcRBNWki9U+AkK6AJ7IhXx5KmlW2OSUH7hZq4H6JWr7jor3fTJ1Q7QHeaH/vpWHjh1cZPl7yeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709006; c=relaxed/simple;
	bh=sZdDLt+hENxDMx+UCNQb12a/QsepiR6kbFY3U20trWY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GM/kcFLSd0d9T8mU6+wCLM9Gr+k+5A7dfezdc80/Gun3iz0SYj0+RD7pXTHsD28XZEcCu79W2CBUtOiO1LSAUqyRxJYlnfO5sv0I1U6+q7CWbEAZsQ1+svJ9Totx9hW6pJmLWprN+JL+SK4LGIpVMRA49u6H4snUfaOSEF0FGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATZ/JunL; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATZ/JunL"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb3e22435fso712559285a.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 03:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772709004; x=1773313804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sZdDLt+hENxDMx+UCNQb12a/QsepiR6kbFY3U20trWY=;
        b=ATZ/JunLsR/1BU1zctvu2QDrXYnWdSupPGvyM0tusYVfhL3+QQRRK4903Go7zIBiJ6
         Y884Tl+brRIZxTbutAmovO6chr2pNLQJp1hG5UH9BuvKkSOik+Gv8mAimW7ok6+PyGsk
         KwH1CGveqAfffRYeWwqG5WJaJwfw9cU61Vuj81p4OPo/z1tEJPujG/GYIDTakXy7CcMd
         MdODCkio0wB5FAtnVuqzNHLlJeXc3w9Cjk9EqwWojlt16bL9xS8GH4HWbSB2Arzo7dq6
         4sxE0wsJPeO7+kXznOBLdgncHntlzZxtVl/T73jUAyOLQacREtxi5XA1B5wlODwOFu4y
         a8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772709004; x=1773313804;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZdDLt+hENxDMx+UCNQb12a/QsepiR6kbFY3U20trWY=;
        b=Tn/ZGEf3AD2E3p38uodhkxzjBoAZykkLXWyYEsmVzcVQw+BoJ6iZKQYLr1fyAL+fF/
         KlQ4kKZ3dTl49+Ef8OiD7n45V6Nsqo87Z84wb4s54a0D5cph0WHKcu74RqlsYFUjGziF
         cZS2UCZD0ykFowKAs9m5kjgvXscyxgkzUBrLfWrtenR29d+100mo5p4yks+3FqDhvunm
         PkNXDSm5miudq5Vjg8EF0+EXBPmJ10jOKF6VpZEpLOQWAHku17I/eIvxE+cCTGyRmHku
         IziDIG7LOkB56L00sNJQYEKSU3QxuP3nH9GHUaFePAsJ41hR4/Fbkz5n4O35thIKVONA
         aBIA==
X-Forwarded-Encrypted: i=1; AJvYcCVMAICXZ/m/Bmfjv4UbZxI3kYj+a7mo0AWAHmDNY2Y3YeNYnd7iZS5XGzNb/T9NtXCe+Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPNBSyFy26s2D5vsxZYe8AmuehTo6WgktS33iAyZ9ixfdadPT
	Y/AGVCkGZ1OUUPzP3NL4dEkbWLbhgRzIWXDA5wDk9UjKVaAACLRAgAWr
X-Gm-Gg: ATEYQzza/+7DrzvTNHm5lUpbduJYE3xr0ZWkgiOgFwUCBCi4hnQ95nVGRqbVQOWXy3X
	vSKItYDTxTtZ3uW6LtOq3DHtuD3sDFxaBUChECY1oHm0DQbtWfx5FKChwGWbS52WIOdeX1iEh06
	XSENIQVa305DUawIG4ZJhV537jQgysfOIPq04lHhVkzz47V32nFChOn0glbi2HeAMgdxvDjQnKa
	7vcrGUpmoj13aa6w95bzQAdXFBQxT4zZXuReFJVKM7ejlUPyCOlLVN8uXbmHlc6IXtI+Lmfu5Cy
	dSn+Q776VkqwUX4Yq32nipk8VH3Ad9OMOS4oSnlgpL+HCIFnw+3qIpK2tRXEnkrqCkI9bL5TFFd
	CF20p7IneEPMDxjrzdPUkA7SfRYNSUPSBYvd5VXGKq4Svvzs+aRqAW6zT81zICkLGx+EzN//SOt
	Hx8IRmnhKVPpadqcDERrRy7PRihXPlH2NwfTfWMIGq8YpM/0NhTvc=
X-Received: by 2002:a05:620a:171e:b0:8c7:3ff0:d472 with SMTP id af79cd13be357-8cd6343c010mr193688885a.15.1772709004361;
        Thu, 05 Mar 2026 03:10:04 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf65921bsm1828070285a.1.2026.03.05.03.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:10:03 -0800 (PST)
Message-ID: <ff92fa059a5f5427fec24be6758afa033ee43af2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Ihor Solodrai
	 <ihor.solodrai@linux.dev>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, Kernel Team <kernel-team@meta.com>
Date: Thu, 05 Mar 2026 03:10:00 -0800
In-Reply-To: <umlxk5jo72ii4efzcethwcwtr7e4scq5iicb57huuhb3qtvcuc@xhl3c6acyzga>
References: <aac2GMpnpoAKD4jX@mail.gmail.com>
	 <d9c98aac-6c4c-483e-9e9a-0659dc03f9e7@linux.dev>
	 <umlxk5jo72ii4efzcethwcwtr7e4scq5iicb57huuhb3qtvcuc@xhl3c6acyzga>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-05 at 14:54 +0800, Shung-Hsi Yu wrote:
> On Wed, Mar 04, 2026 at 04:48:43PM -0800, Ihor Solodrai wrote:
> > On 3/3/26 11:27 AM, Paul Chaignon wrote:
> > > In commit 5dbb19b16ac49 ("bpf: Add third round of bounds deduction"),=
 I
> > > added a new round of bounds deduction because two rounds were not eno=
ugh
> > > to converge to a fixed point. This commit slightly refactor the bound=
s
> > > deduction logic such that two rounds are enough.
> > >=20
> > > In [1], Eduard noticed that after we improved the refinement logic, a
> > > third call to the bounds deduction (__reg_deduce_bounds) was needed t=
o
> > > converge to a fixed point. More specifically, we needed this third ca=
ll
> > > to improve the s64 range using the s32 range. We added the third call
> > > and postponed a more detailed analysis of the refinement logic.
> > >=20
> > > I've been looking into this more recently. To help, I wrote a high le=
vel
> > > sequence of all the refinements carried out in reg_bounds_sync. u64 -=
>
> > > s32 means we used the u64 ranges to improve the s32 ranges.
> > >=20
> > > =C2=A0=C2=A0=C2=A0 /* __update_reg_bounds: */
> > > =C2=A0=C2=A0=C2=A0 tnum -> {s32, u32, s64, u64}
> > > =C2=A0=C2=A0=C2=A0 /* __reg_deduce_bounds: */
> > > =C2=A0=C2=A0=C2=A0 for (3 times) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* __reg32_deduce_bounds: =
*/
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 -> {u32, s32}
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s64 -> {u32, s32}
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 -> s32
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s64 -> s32
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 -> s32
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s32 -> u32
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* __reg64_deduce_bounds: =
*/
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 -> s64
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s64 -> u64
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {u64, s64} -> {u64, s64}
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* __reg_deduce_mixed_boun=
ds: */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 -> u64
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 -> s64
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {s32, s64} -> {s64, u64, t=
num}
> > > =C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0 /* __reg_bound_offset: */
> > > =C2=A0=C2=A0=C2=A0 {u64, u32} -> tnum
> > > =C2=A0=C2=A0=C2=A0 /* __update_reg_bounds: */
> > > =C2=A0=C2=A0=C2=A0 tnum -> {s32, u32, s64, u64}
> [...]
> > Hi Paul,
> >=20
> > (trying to do my part with the code reviews and learn in the process)
>=20
> +1, still
>=20
> > Side note: you might be interested to know that Eduard is working on
> > consolidating signed and unsigned domains [1].
>=20
> \o/
>=20
> When I last look into this[1] there's was the "Interval Analysis and
> Machine Arithmetic: Why Signedness Ignorance Is Bliss" paper[2] that
> looks rather promising. And lately there was also "Program Analysis
> Combining Generalized Bit-Level and Word-Level Abstractions"[3] (haven't
> read) that seems more specific to BPF verifier.

Thank you for the links, I've only seen [1].
I was about to send [a], feeling really smug about cbmc tests.
But then a much simpler solution [b] occurred when figuring out why
64-bit test can't be written.

I'll probably continue playing with cnums at leisure pace.

[a] https://github.com/eddyz87/bpf/tree/cnum-sync-bounds
[b] https://github.com/eddyz87/bpf/tree/32-bit-range-overflow
