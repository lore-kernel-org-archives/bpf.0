Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501535DCE4
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770379689; cv=none; b=Fi8eca5SsioRsMgAuoaKtaE+pk806dZKdUJ+roo1/gTMdv7pyNmvL2/v+xS3Bucuzhz0i/B8b67IYaNSn53xUqFIU/+BsPp/AvwjfMIpQj2zgSZxMCQVb+TSq8u4Q5uObfKpGpVmejTTKPUCZNkmEbiM9EIwnNh9GSgVLEHQ9mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770379689; c=relaxed/simple;
	bh=Qvb3niPH3rBFmK+lYGZRax+O8A9fWvGqyOC1ehCmcN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+QkWqX9dimOY8kAr40JziayXs14KmJfCqadAdmpMSSNSTvV8pqzLZEn1Kyv8ZgtYCy87c2yBq61ASUXClf8Ndyr44I2fyKRjY8GZeFiwi+ATJPIe6syWsdhmuyuL2ka1Zc+o0TFEW+HuainG98/quFU8PdFJ4jva5aOqU51jM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bv5oOGtV; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bv5oOGtV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770379677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oANQ+phk7g8iVeelCxDqsFwg/mOvwmmphBUQWi4Vr7M=;
	b=bv5oOGtV5TZg0hz49pPOyH+7SIxct7UhGiLRc6Ueu1pX6nZ0/z3oMBXr7swFVl0SsIJOuY
	N8/yYqM9ifsY55Rw7NKXO30W+frUDXiYZ9UsJE8vpfBc4Id4goLFYqjx+/CQEO4cqIPhCe
	jQkpxpFfwj7znchmcxLggCUDGfZ1j8E=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, jiang.biao@linux.dev,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf,
 riscv: add fsession support for trampolines
Date: Fri, 06 Feb 2026 20:07:35 +0800
Message-ID: <5088614.31r3eYUQgx@7950hx>
In-Reply-To:
 <CAJ+HfNizNFc0j_eUNFR3_kO8diQzbjce8oLzBEOK2sWnG=rGhg@mail.gmail.com>
References:
 <20260203055231.1088479-1-dongml2@chinatelecom.cn>
 <20260203055231.1088479-3-dongml2@chinatelecom.cn>
 <CAJ+HfNizNFc0j_eUNFR3_kO8diQzbjce8oLzBEOK2sWnG=rGhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/6 19:22, Bj=C3=B6rn T=C3=B6pel wrote:
> On Tue, 3 Feb 2026 at 06:53, Menglong Dong <menglong8.dong@gmail.com> wro=
te:
>=20
> > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_c=
omp64.c
> > index e4f45e2e7e2f..f10418ff6a9b 100644
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
>=20
> > @@ -1042,10 +1067,14 @@ static int __arch_prepare_bpf_trampoline(struct=
 bpf_tramp_image *im,
> >          *                  [ ...               ]
> >          * FP - args_off    [ arg1              ]
> >          *
> > -        * FP - nregs_off   [ regs count        ]
> > +        * FP - func_meta_off [ regs count, etc ]  always
>=20
> Nit: Please remove the "always" comment. It's not helpful.

Ah, sorry that I send out the V2 before I saw this email. Let
me spin a V3.

Thanks!
Menglong Dong

>=20
>=20




