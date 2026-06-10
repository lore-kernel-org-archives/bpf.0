Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0453A3822
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084110; cv=pass; b=NjT5UcFUVVhE3JehS91J7kE2py8hl7a9a6dt7MaS/NIz2DQAEg3P8WsCEo42JmmhB6YrUkW5UT5fIxH7ghqT7sleY/WtoxUThWKNs+p7m0nXSW1yK+GGPGu4FLusogRZ+Zxf4wAP5pl+AQeyfPScVXR0hGwl43gBL5mlwTmEt4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084110; c=relaxed/simple;
	bh=f13hlIkd3qAqESAAe+1Ll7lwWedKyP+tjl+1tINB0Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjBjUNz19jp6yZcrOu5LH1bShdME2dcNEUEFkLsxxwiTLZhPbKgkkVTpJEQZoJ28nmxrehPDmOwRvBDLknd6j9jvzyrzOSU9gBVMisWkr8aCpATeSq+Ql7MLAXx3Gv3xWaR1cqfT/PAQvTvBFT/fAblWkfjwYNnGA0A45pBscAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pFBAbAG5; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFBAbAG5"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6603d8697d2so6387177d50.0
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 02:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781084108; cv=none;
        d=google.com; s=arc-20240605;
        b=fxrbsFv6kYtnrWUtk+6EEyW1K5lt+jU/Qi2LeX3tyCUuT3uBpFSXtdHrDs8vR7YqUF
         AaCQvnZyISoXzkhPN5PAVhlHOlMpGPse1Bi2X8n/dWZw5JM0TAV7H6+Gq/8Eva6zxOd1
         iNFigtYmZR/T/xYpZSjS5MqOlpUsHtvC6wSo8EfRsodP8yE192UqKy+Ajy9/WL50UXNs
         4vDlbaj0+xqSg02Qc8AjJlrMtCGmuj9DLm8+C2RTiz7E7Uv6bENbxBR56kViLoT3wU/n
         kDfg598ZyD0bZzpsZFNFhu0QcIKSV+MlINmAcwJnQN6f4z9Z6dOZHZj1+rgNnXvTt+SS
         p6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrsRVHaTOrUv/oFhwSzJi/8W4myIMifEs3+89C8c3Zg=;
        fh=Md2K+2NQ/2XrSbeMXTyPpSBEUTUFrZ9vUSz9TulSdSk=;
        b=CIpl/e9opPmxSMmm6g4i/H/uPKYQ7IMrtTHc2GmEyn+CEp5uuJ8h8YC2YrZF5UGucV
         u59c55tWSlcv6FNg21umAB8EnLonAp7aR0peoJQScH0SBl1UydNKYkBl/7ZwIYBY41aY
         z6gLp0BbaZVqInaM1IYNZP9/X2PrqsbkVZQl+wDBEdHujtmnNvdnRhXFhvR0Zg67nBXm
         JTrsX+OBQVWnTSfb1pXMkBp4bSW+i3emzCfFZVZ04e4llZQT13rBzf4L0IQjg+/AACrL
         tbVjGOAu5mio+E/fn297KXZNvkX5MDA7e1dozQ9kmWTmG/4hyp00d3vZ05WqYLiRLvZ8
         c/MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781084108; x=1781688908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrsRVHaTOrUv/oFhwSzJi/8W4myIMifEs3+89C8c3Zg=;
        b=pFBAbAG5e+gryTMupfIlwf2bbh46zpH3f1KvDGQTecrjmGwcJIt8wKotjOyk9G9J/u
         Al3HZgOpQdMi/99K5rrGhmXBsKntezwoK+T2nDL/qjHolICnolTzNaRC/luQaHo1LNLY
         cQoPJXks1D+8oFtH7J4sOfuPES2PxYulzsEFokdsCbgisBJo9VUOX3miy4l7idpJEzOz
         bis1i1szXpfIJgsSxYtbpESq01PXhwycNTL+ZofBCVe6xDHW8WHKWPAFXvUgL1QPML16
         +ML1qrBJE47/zQUMMK0l+dLibE6/2T2Aj62wFoGgEUTY33ZaJ61tGC8jDyEFxIHSBjW8
         BeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781084108; x=1781688908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QrsRVHaTOrUv/oFhwSzJi/8W4myIMifEs3+89C8c3Zg=;
        b=CAUZlJtOQJaYXowePf22+RynojaPv/wY92dNR55A6DpAJx5kdUkeKgSoHyTF1U8QVC
         x3nIgHyZVkgIFL3Xn+8xQf2J4HMoOPV+V8hl/0Umi+P6fhGmIIPG+RpT3aCPZ/wM4VqM
         HC8/MF2n36YUbDMOQrHqacApQs2AI+BqmL+glMJQNrVBRzSlKyAfBqLbdWPmAKJLEDlK
         oGI1Xp0d8IFiYO/CNv3CH0ZpSwMzL/9HfyF7NHv8qHlQaUTZmBw4It4Zl+Vqb1Za/qvN
         rABHpj7BMh/WBybwaDtWetoYcu/eFp7znXqRSs1ojW19svoCdMTFVZVn4uXDd0P712Pt
         XeHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YyinLDoza4Mhj6RGO6C1iKheCs2SLVxBi5kJgHyRBpdif7oWGZzOynGNPnrcaRIne3no=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyok86TecCJtRo24LvBNlHkgPpJK8otQ8j8f+e2CbFrJAZAcDcu
	rSKoWJh2ssNv6wSLYrBw8hcMSmGwT4+K911ZwL3hT/32J/DupqBMychH6/kpfy52MWmDc4w79pd
	GV/DEbmsk2kh0T0ff6pADJi5e6NQywKM=
X-Gm-Gg: Acq92OGNwBgJWUZkU0/y4vszYQQ3SeY4ub7XX02P8yTE9EB7X43zZ9d4kz6S6Vz65RX
	CSh+VxLGzByFBJO8w7HDykN+Ys2vnsLjsyntwQJB0CtsYaq1+XbOxogPw5VlebFpxZgHRtrSqqR
	kHTDQHp5qbrUOCJgW69bCfasJc/wAmvfFIWgI9b3JuUh3ubo4J8t7WYNP+2C4EORxln16VJqrhG
	SC2eoy3qmIEjrhawbU9e07r0UdQABgrg/3u90mEkETO3oqfGQwTpdLgOf3dGfJpl0S3fPYVkF2C
	7Xs2fjHaHFt911RzCvZDeOFdW5TGx8kNuIHgvxoLfUFzeB9IgXiakYQvjtGtrw==
X-Received: by 2002:a05:690e:1902:b0:64a:ef61:188c with SMTP id
 956f58d0204a3-6614f7fa83emr6602296d50.47.1781084108264; Wed, 10 Jun 2026
 02:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
 <L0cwr1-KRSKR7-dJdjDmJA@linux.dev> <DJ4XIOT2RVMT.28I5LA2UOZVUI@etsalapatis.com>
 <AgOg1pJHQN-gpKhYUz3SMw@linux.dev> <CABFUUZH9F+tiitstSBy2-M=WC84jg28CVMXU+Lu-va6jm71fDw@mail.gmail.com>
 <b35a2395-0e15-4390-ba7a-b48748e7e3f3@linux.dev>
In-Reply-To: <b35a2395-0e15-4390-ba7a-b48748e7e3f3@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 10 Jun 2026 17:34:56 +0800
X-Gm-Features: AVVi8Cd2Q687Tcu63pcXaDbwOQYOqrUxS-NscSvnl80wWepD5q_IKVSOQ-JfzjM
Message-ID: <CABFUUZFimdrZdq=NWi+N-0sJZWvMwY=f4iF6-3TVMS8=m07Zmw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Menglong Dong <menglong.dong@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org, 
	liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 1:13=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
>
> On 6/10/26 9:58 AM, sun jian wrote:
> > On Wed, Jun 10, 2026 at 9:21=E2=80=AFAM Menglong Dong <menglong.dong@li=
nux.dev> wrote:
> >> On 2026/6/10 08:06 Emil Tsalapatis <emil@etsalapatis.com> write:
> >>> On Tue Jun 9, 2026 at 7:06 AM EDT, Menglong Dong wrote:
> >>>> On 2026/6/9 18:02 Sun Jian <sun.jian.kdev@gmail.com> write:
> [...]
> >>>> Hi, Jian.
> >>>>
> >>>> This sounds like a good idea in this case. When I have a look at bpf=
_clone_redirect(),
> >>>> I found that it use skb_clone() too, which means it has the same pro=
blem. The
> >>>> data can be modified by other xdp prog in the destination NIC if we =
use
> >>>> bpf_clone_redirect().
> >>>>
> >>>> So maybe this is the default logic, and I'm not sure if this patch c=
an break the
> >>>> existing users :/
> >>> I think for use cases where we are using bpf_clone_redirect() to use
> >>> one clone for inspection this would add an unnecessary copy. Maybe
> >>> adding *_copy() variants instead of changing the *_clone() would be
> >>> better? That way we wouldn't be changing the behavior for existing
> >>> consumers and the naming would be consistent with the skb_* methods.
> >> Agree. It's not a good idea to change the logic of the existing API. O=
r
> >> maybe we can add a BPF_F_CLONE flag for the existing API.
> >>
> >>> But more importantly, is there an actual use case for the kind of API
> >>> that the modified selftest requires? Nobody until now has considered
> >>> the existing behavior to be a problem.
> >> Agree too. Obviously, this is not a bug. For the use case in the commi=
t
> >> log, it's something that can be fixed by the user themself. If we need
> >> modify the MAC, we'd better attach a BPF program for all the egress
> >> device in the devmap.
> >>
> [...]
> >>>>
> > Thanks for all the comments.
> >
> > I agree this should not be treated as a generic skb_clone() issue, and =
I
> > understand the concern about changing existing clone/shared-data semant=
ics.
> >
> > The case I was trying to address is narrower: generic XDP devmap
> > broadcast/multi redirect with per-devmap-entry egress programs. The use=
 case is
> > not newly introduced by this patch. The existing xdp_veth_egress test a=
lready
> > attaches xdp_devmap_prog to all egress devmap entries, and that program=
 rewrites
> > eth->h_source based on ctx->egress_ifindex. My change only strengthens =
the test
> > from checking that the observed MAC is not equal to a single magic MAC =
to
> > checking that each destination observes the MAC selected for its own eg=
ress
> > ifindex.
> >
> > So attaching an egress program to all devmap entries is already what th=
is test
> > does. The SKB_MODE failure happens because the cloned skbs can still sh=
are the
> > packet data, and a later per-egress rewrite can be observed by another
> > destination.
> >
> > That said, I see the concern that this may need a clearer semantic boun=
dary
> > between clone and copy behavior. I will also check the last_dst path po=
inted out
> > by Sashiko before deciding whether this should be handled as a bug fix,=
 or
> > whether it needs a separate explicit copy/isolated redirect semantic in=
stead.
>
>
> I agree there's a real concern here. For context, native XDP already
> makes a full copy
> of the frame for every broadcast destination:
>
>    dev_map_enqueue_multi -> dev_map_enqueue_clone -> xdpf_clone
>
> so on the native path each destination gets its own independent buffer.
>
> The generic path is the odd one out, because skb_clone() shares the
> underlying data.
> I think this rationale should be spelled out in the commit message.
>
> Regarding performance: generic XDP is already a slow path =E2=80=94 the i=
ngress
> side already
> linearizes / expands the skb (pskb_expand_head() in
> netif_receive_generic_xdp())
> so the extra copy here is not a concern.
>
>
> However, there is one problem with the patch as it stands.
>
> The last destination is transmitted using the original skb directly,
> without unsharing it.
> So with two destinations where the first one has no egress XDP program
> and the second (i.e. the last one) does,
> the egress modification on the second destination will corrupt the
> packet sent to the first.
>
> This could be addressed by doing the skb_unshare() inside
> dev_map_generic_redirect() instead ?
>
> For the non-broadcast (existing) path the skb is not cloned, so
> skb_unshare() simply returns it unchanged.
>
>
>
Hi Jiayuan,

Thanks for the detailed explanation.

I checked the last_dst case and was able to reproduce it locally. In that c=
ase,
earlier destinations without devmap egress programs can still observe the p=
acket
data rewritten by the final destination's egress program.

I also tried your suggestion of handling this in dev_map_generic_redirect()=
,
right before running the devmap egress program. That fixes both the origina=
l
case and the last_dst case.

One detail I changed in the implementation is to use skb_copy() + consume_s=
kb()
instead of skb_unshare(), so that allocation failure does not consume the s=
kb
and the existing caller error paths keep their ownership semantics.

With that version, the following tests pass:

./test_progs -t xdp_veth_egress
./test_progs -t xdp_veth
./test_progs -t xdp

I'll send v2 shortly.

Thanks,
sun jian
