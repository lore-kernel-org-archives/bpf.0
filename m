Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E73C9899
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652864; cv=none; b=XreoDvksCuIJFg/NHCtAueI/hMPQFfupFCfoBoTOCwoMfIGvfGh6RnDQPQ+eDZe9aMqZ9av34NiqpmZoNYKwxnp0PZxv/L1cVlQgDKmAPxJWJMU/f0m5InVU5W/gS5/RwwuauMh1tO/bQFmtE/PR4hlCowCS0Awb89Il1T6T7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652864; c=relaxed/simple;
	bh=RMLKSBf6td0blMo/wVsTeAPKKkNErN1kqNLPI9HYRUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VwJRDamja261S8/u6fe4OoMX6J5DxiwFaKvdJp22UMtDmwif2wQHNLmPhkvYjG4N0oCFoGPFwBg6FOMuX6j0CaCulPai+MsmwxcziAeAuY1j//a0AuDm0I7mObDvyAXJeyZriEAej+06zq89/KCYw8oPZ5URSbpMB53dzKbNV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scXglLyP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scXglLyP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso11455695ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 02:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780652862; x=1781257662; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RMLKSBf6td0blMo/wVsTeAPKKkNErN1kqNLPI9HYRUg=;
        b=scXglLyPbY6K/tARilugvxthvt4HPQsFqVwUnDa267LNnSRkINOs3Qao1vLepMhU4j
         ViiWg8Elha9BqtGAiadYENzvAURYQt2bFENA7BidFdeuOJJ+jLlWImRaLbTJfEwDTTrX
         aBiijmfENBMzUgEshFkPR+HM5XFr9uM5pnIeYRJS/w6LccMk1lVeV5Vj/DFyTTjFlUnW
         0VgzyxixiKhr+czvlVroUVLZYxx0/+LdEjGSpn2vXRXQrrdGJjG/fgmDABE/MBeWJ3SM
         lonQvsFeVcigB6aFzY3QhxISfGc5Lc1syxTEJhdF5Tw8SNRJYtpvWn7ZLdpoNWCEv5nE
         E6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780652862; x=1781257662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMLKSBf6td0blMo/wVsTeAPKKkNErN1kqNLPI9HYRUg=;
        b=fmkiK+TikSyT1k4nECDvgX6wKVRKZW3e8rSP5ulHeL2yIUi22kVM9prWON9f86gzja
         FEJrpnm6BH9NjY7Cktu/rJbjy34vRO4CyY1ArTRmhWDqKgEIsyS67PiQs9+nwHxQIapC
         KNBoRZ+q9u6DmyDJhauR/0f06bdHUFMLrhH8zUf72pN8vlio5UkupDQtwTuC/M0iA0x4
         GpOch9dBjDrQF0R7M9T0wP9avJLNs326ldX7x1Sr/Rpzf4kzAN71qVuCaViDYttiVjVy
         P49GinU/yJ9QSOL7lIGeJ2BSo3k090IRzALnuKOANI18V/O6fEN03kYxExG6hEWgKlcI
         5b/A==
X-Forwarded-Encrypted: i=1; AFNElJ8UxnKrtDP9OfWwPihvGac0w5wxumj5OgDMBOBncPq36ePNT1w68Lfd7Pyv4QLgr3JBasQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh3TebUv8afe+9Xlfw4qMcsMLH/dmfy8wB540yXaYT3qjOasjv
	c3V3O6OZJEMY0MSOKNwtxuNuh+wc55TOLgCd/BFY7t/0Hh+Y467V0a53
X-Gm-Gg: Acq92OEgYoXfN25e2nr02RnJfpzbBgl+MK9s3Co9r8j2JadXlGM21sNEnuOIn1ndq3X
	4lcFpIERQ7TE2TcxWq+X5dmrfvm6sZtD9DehHDxxhpbtKPYDw0eOJ4STQfaTv923b7aO8GjN5OQ
	HKYUwbqL/2JhPUJUIVaGJ2Ei26tp3t5ja6GvGaMsXNWIoFDkE3WmOAk+R5kDgSRaf7aNlIt4os/
	OamKmnmJOHsm4M7WvWqMEpoLd94eHmeZJ8rD3HzGDiaN0atqEz/y1yGGH5mSRUVVz4Y5FozHPSn
	se8SEoeff3uhNbezuuH4YomZ047MQH0ZdaIVqDOt/mL0UpH1fHjBN5IwdkWyqcKsdj+pvDJh09Y
	6gylhIF49ggWEwDnAGSEue8NDKKrzmuRQUK1yjiBNS/GixnJYmyyqjmvoyyIgQV3OO/1qGFnav6
	7YoqwdsjgL7kUlFq28iReoOfLN6BmxDqcAJJXrcZd7puqG0z+kUWbxnUSg2JEzQw==
X-Received: by 2002:a17:902:e5ca:b0:2c0:b932:867d with SMTP id d9443c01a7336-2c1e893d0b9mr28693575ad.29.1780652862144;
        Fri, 05 Jun 2026 02:47:42 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2e2sm84127505ad.49.2026.06.05.02.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:47:41 -0700 (PDT)
Message-ID: <cb44838a3bd2437366b840d50a09d40f444a8b2c.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Keep dynamic inner array lookups nullable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: dxu@dxuuu.xyz, stable@vger.kernel.org, John Fastabend	
 <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Kumar
 Kartikeya Dwivedi	 <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song	 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 05 Jun 2026 02:47:38 -0700
In-Reply-To: <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>
References: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn>
	 <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-04 at 23:11 +0800, Nuiqi Gui wrote:
> An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
> inner map template. A concrete inner array with a different max_entries
> value can then replace the template.
>=20
> After a successful outer map lookup, the verifier represents the
> resulting map pointer using the inner map template. Const-key lookup
> nullness elision consequently uses the template max_entries even though
> the runtime helper uses the concrete inner map max_entries.
>=20
> Do not elide lookup result nullness for maps marked with BPF_F_INNER_MAP,
> because the template max_entries does not prove that the key is in bounds
> for the concrete runtime map.
>=20
> Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullness"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

Thank you for spotting this issue.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
