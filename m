Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4E3F075C;
	Fri,  6 Feb 2026 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388075; cv=none; b=mqrL8gDUZ7qLYlqsbvHZZMzcMiuZztfLkzde/CV1wslUDwGqd07sn4+gqsy9/BvpZqsl7l97yL1LIaQEN3kRXKpi17y5ubnW8Zg/zDTA+zF9E+7dSP034hqTq3L/oGUrdoSV+bmW6zqZzYWKGW2AwipITAFiKIkJ2XCcYQJbaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388075; c=relaxed/simple;
	bh=M7FzU8SObdsHg7Fnom8HBW9tbsGcQPSiDWjRfhydF+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGgcHY/ldxjfjdnPueYhs8IIGFNLOc1jbAosHLPOFiY/JgUnlEAiX2gvzSK15j/j7AXM4afYgeHRKc+3r0f49Y6lUBZD47LOoXUzQBEcbJ4VWODjZ2EEydG+IMn6j1WGrw3UXPVYyYgHPTB+GC1S68TC3sCQLuvP18LqWfl6bsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ArIbMtIf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ArIbMtIf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770388072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDTQrVkhNMhRGCiK8BUkruN/7ThIMVtkU5IFQtE1kMM=;
	b=ArIbMtIfzGo7vEj2gGrJ4K/X5CEPzLjOjGP4hNAfUqjrAE6EVKgxCipBYF/gj+qY8GjM6+
	pRRDU+IK7A6cUpiQQ5xtk/IRe2wA3YBLCZMn9a9TGpMKmnvpU4k8jguuhNxx7gyOsmuc0w
	Ik1CzZArMWPVg/9cn9D3GqCiLb5n9UU=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jiang.biao@linux.dev, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v3 2/3] bpf,
 riscv: add fsession support for trampolines
Date: Fri, 06 Feb 2026 22:27:22 +0800
Message-ID: <5059733.GXAFRqVoOG@7950hx>
In-Reply-To:
 <CAJ+HfNj5JZJ-k5bJibSgLPD5xnTzf7kfvma4kJOBKoNTnSLLDg@mail.gmail.com>
References:
 <20260206122002.1494125-3-dongml2@chinatelecom.cn>
 <444267200b59241e9da104eab8af2d7189aa401005887a2cd0128cd6aeda98e2@mail.kernel.org>
 <CAJ+HfNj5JZJ-k5bJibSgLPD5xnTzf7kfvma4kJOBKoNTnSLLDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/2/6 21:42, Bj=C3=B6rn T=C3=B6pel wrote:
> Menglong!
>=20
> On Fri, 6 Feb 2026 at 13:51, <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit=
_comp64.c
> > > --- a/arch/riscv/net/bpf_jit_comp64.c
> > > +++ b/arch/riscv/net/bpf_jit_comp64.c
> >
> > [ ... ]
> >
> > > +static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int =
retval_off,
> > > +                   int run_ctx_off, int func_meta_off, bool save_ret=
, u64 func_meta,
> > > +                   int cookie_off, struct rv_jit_context *ctx)
> > > +{
> > > +     int i, cur_cookie =3D (cookie_off - args_off) / 8;
> > > +
> > > +     for (i =3D 0; i < tl->nr_links; i++) {
> > > +             int err;
> > > +
> > > +             if (bpf_prog_calls_session_cookie(&tl->links[i])) {
> >                                                 ^^^^^^^^^^^^^^
> >
> > Should this be tl->links[i] instead of &tl->links[i]?
> >
> > The function bpf_prog_calls_session_cookie() expects a struct bpf_tramp=
_link
> > pointer, but tl->links is an array of pointers, so tl->links[i] is alre=
ady
> > a struct bpf_tramp_link pointer. The extra & passes a pointer-to-pointe=
r.
> >
> > For comparison, arm64 uses:
> >
> >     if (bpf_prog_calls_session_cookie(fentry->links[i]))
> >
> > And include/linux/bpf.h uses:
> >
> >     if (bpf_prog_calls_session_cookie(fentries.links[i]))
> >
> > Both without the &.
> >
> > > +                     u64 meta =3D func_meta | ((u64)cur_cookie << BP=
=46_TRAMP_COOKIE_INDEX_SHIFT);
> > > +
> > > +                     emit_store_stack_imm64(RV_REG_T1, -func_meta_of=
f, meta, ctx);
> > > +                     cur_cookie--;
> > > +             }
> > > +             err =3D invoke_bpf_prog(tl->links[i], args_off, retval_=
off, run_ctx_off,
> > > +                                   save_ret, ctx);
> >
> > Note that invoke_bpf_prog() correctly uses tl->links[i] without the &.
>=20
> Menglong, the v3 doesn't build. Please refrain from just stressing
> versions out. For v4, make sure you properly build/test. On that note;
> on what hardware/simulator did you perform the tests on?

Ah, sorry that the CONFIG_BPF_JIT is not enabled in my config, which
makes me didn't find this compile error.

I used to test it in qemu. As this is a tiny change, so I didn't run the
test again :/

I'll make sure the build and test pass in the V4.

Thanks!
Menglong Dong

>=20
>=20




