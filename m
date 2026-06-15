Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F141325C
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544293; cv=none; b=fIkRftDhHL+mJTj8arMtCGJ3eDh2zTMntX+95zHLtPDcLn0E4f3YPxUhfSkx/3Tl4MZC/MSpJqib8I832hi1A06LdLIAUB/fNit9EjcpVVtFuPDuz7H0c+Dj63rBmi5NrsTFeQjWGJ4ZMcVSXBkZ/ZB6a97TB6ktsL/CJf0DPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544293; c=relaxed/simple;
	bh=7fzuMVqZiWlY7VpQG0hhed+OjcFW2gxl41QoEBVBNCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhTEho1UZ549dFjJ6c/AjutatAQFX3uBlq3rckmBSRb1jEwNN4OaXNEpuumeZiKKuPM3qOFnCfKRG9Mxxf/SE8NfktX0Ev8DgJK+3IYF6mXlh9CV2qxyRRpyBl3imUr1I4IQg+vni7MK6W1WrXzme6CCTq9Vatj6jhndxyHW3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7IKi4k9; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7IKi4k9"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304ec41197bso4030926eec.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781544291; x=1782149091; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2UjHCgbSnreFpSQDpV6wz1i08tQ/MpANdratRi2gobU=;
        b=O7IKi4k9qF/QSidUC0pSxtYujFS1At3bSJHve+ydCg5XUOLtfsoWgaqC+tISrsAdqw
         6E1+E7L7NoTNESxr5H7n7CnrgDR6c27mvtcm6kyeewjFKSsskHgwWhE+et7VN+CFjfIk
         waCVw6CV/oymPTm3nrS5Tw0KbIw+uZbNFETQcG2mfSdtvtob/ooDhKvvhb29oCUFXwD6
         vB2WdgxUfKTETuDFE4Xv0j1+L2ll1+FtxRDP5yZ5qZpYeRg9KRevXyA6y2IeExhuWXS8
         1jBAtYnHrj4tR7wmtSohDwHjfQg0xLQYd13K37u7A+R80NA8/PRX08MYwjrb7ozudp4m
         G8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544291; x=1782149091;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UjHCgbSnreFpSQDpV6wz1i08tQ/MpANdratRi2gobU=;
        b=msjZSVmPrHex9RhnzSn7mcJvZdEyjwkmgoyRWhUpKHMrQV2gRJMY+aq7cnyNMZ6mdP
         sdKCXZYJoRIj/JUvga49rzE1nXBnKu3VACByxgC+MmBGAs9HMM3QENmmsswdZa/Uhtno
         ZXlL31Ie7pYBHT1JWmo/KcMx81dOKzWxS8AFelpUKgFzyGuaoYEgQcuh7XjmD1N+s++y
         wuWaFq2RB+DaksTlwXeIo2VWgGlcUSJmmHycqjcN9AzHnMotkh078d3gphtHrV3C3FOE
         RdkxM7wXzZkQF6RQd7fa+bHoQt/oUwaRFjWqJisLjqsvFfkOl5tzIN5Qf1qmd+iLr+zc
         HpVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/38/MGPLjuZcoU2cesfYmT80BHPtMZkHy1jQsl78rOkQw+0yaub60T86qwStcFylM58MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNLChUhaVMuo0SNAnHBilxj4LjQ3Rx1PLzx0CwiiBVqnDflje
	hg1lLVOKNvCIOS+zmhXBiM34rEEbieg7/agnc5dVebftu8iibXygsukS
X-Gm-Gg: Acq92OFvP6nz52v6bQyW45syluABBiQl6UBoqFef6eYVOdyIjuJRZW0zSyCrZbAYqmN
	JRsBm0uhkA1SlsmnxWxcerFNJh5ABE6MrGXZxt/+aj3pQNTQLMkmTTG7cugz8VTJhIkMJ6gz3GP
	rQKLPzRiLDigbiVNJoByoH4l9HMbO+d+91bky9sDU1mghCsS6RN1twIqAiBd6oxVTRQoyCmZlYh
	vphAeuRszjZtEuE1z62XUlGwzbjlfZuqIkc8+WBsNwd+u+B+JRoG2OZxiyi1se5QxVhehGLsBtY
	eWVK847zQjsdyGm/ccrKK+kzBtQxg5PrJzdlzQliNv8zfuwBJ+XaZKyz+LICyjkfDXY+LAvrDU4
	p8mPCg+G2wi2CM8j52QiN2eW1aNTuVaNbNrlYQoP+c5nL2yk2/Jkg8TiKPuudjlYUp/RtuHj1+G
	r/NF0wFiHx1Tlk/VuofnmE2SeCjp6pcX5TywwElKDdapeWrfF2NRw97rjTxcFeQcwCT96LF5ZEL
	o0qEO4=
X-Received: by 2002:a05:7301:9e46:b0:304:8870:2ac5 with SMTP id 5a478bee46e88-30ba596a8b0mr94631eec.6.1781544290993;
        Mon, 15 Jun 2026 10:24:50 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:755:4880:8bc0:de02? ([2620:10d:c090:500::3:317a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4fe55sm15315382eec.25.2026.06.15.10.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:24:50 -0700 (PDT)
Message-ID: <4d2b2fd4f4c1cbda0e071be8a0d6254c6b6729d2.camel@gmail.com>
Subject: Re: [PATCH bpf 0/2] bpf: Preserve rdonly_cast dynptr slice lifetime
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Nuoqi Gui
	 <gnq25@mails.tsinghua.edu.cn>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, 	linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 15 Jun 2026 10:24:48 -0700
In-Reply-To: <DJ9IUWKK7EFS.XXLT3ZAGOPC4@gmail.com>
References: 
	<20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn>
	 <DJ9IUWKK7EFS.XXLT3ZAGOPC4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-15 at 11:40 +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon Jun 15, 2026 at 10:57 AM CEST, Nuoqi Gui wrote:
> > bpf_rdonly_cast() is an identity operation at runtime, but the verifier
> > currently assigns the result fresh return-state metadata. When the sour=
ce
> > pointer comes from bpf_dynptr_slice(), that drops the relationship need=
ed
> > to invalidate the alias when the dynptr is released.
> >=20
> > Preserve the dynptr-slice lifetime metadata across bpf_rdonly_cast(), a=
nd
> > add verifier selftests covering cases where a dynptr slice is cast and =
then
> > read after the dynptr is released or after the originating dynptr stack=
 slot is
> > overwritten while a clone still holds the reference. Also cover the val=
id clone
> > case where the cast alias is derived from the clone and remains usable =
after
> > the original dynptr is overwritten.
> >=20
> > This fixes regressions introduced by 66e3a13e7c2c ("bpf: Add
> > bpf_dynptr_slice and bpf_dynptr_slice_rdwr") and a35b9af4ec2c ("bpf: Ad=
d a
> > kfunc for generic type cast").
> >=20
> > Impact is bounded to verifier lifetime tracking for CAP-required BPF
> > programs. The evidence confirms stale read acceptance after dynptr rele=
ase,
> > including a typed field-read shape, but does not demonstrate unprivileg=
ed
> > reachability, cross-context disclosure, controlled reuse, arbitrary ker=
nel
> > read, write-capable aliasing, privilege escalation, crash, or KASAN/UAF
> > signal. No CVE, embargo, or security escalation is claimed.
> >=20
> > Validation:
> > - The new dynptr_fail.c subtests exercise the verifier's dynptr-slice
> >   lifetime invariant across bpf_rdonly_cast(): a cast alias of a
> >   bpf_dynptr_slice() result must be invalidated when the dynptr is rele=
ased or
> >   its stack slot overwritten, while a cast alias derived from a survivi=
ng clone
> >   must stay usable.
>=20
> Won't fix. The semantics of bpf_rdonly_cast() do not require soruce prove=
nance
> tracking, and thus don't need any invalidation. It can take any unknown v=
alue
> and produces safe to read pointer. Please try to reason about whether it'=
s a
> real issue before posting AI's output directly.
>=20
> pw-bot: cr

+1, the memory access through untrusted pointers is handled via
prob-read pseudo-instructions. Nothing to fix here.
