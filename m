Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792609072;
	b=1mTYu4i/Gbon5A/SQ9fXin28626vEp/MeCSUfgtnYRMEW+zwHNT1Nizb/6TA/56mDS6U
	 MCs8DSVujny21jvfPXuLvEHv1uAFUKEa4uhpZIpuCILtcwIzGcMZmtMKm+qWtZHSRGhLY
	 dr2EbxFg6aUsjJg85UxMLufM4F5zWEex2I1cXUrrwuNasp8ZoCnA+7NyYq2MZO4sLFUgO
	 dNl37dxnWorQADKKCRyE4IBZWj84Hx9sv+XbAZKX9Wy89TDTzdluV5MY6UUPyZvqV0Kfo
	 aQFq5bxtzPeAwSEqKOmWRcySNIz8LPOEVhladn8gOcHXDCTKBc8qzuCSyllRpfe9RiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=SQ1PEtdypxTnohtLknkt/wfldChNdlR9LzYhU4LNZxo=;
	b=Odfr0PiVyN9onln/fGKArNcZPJWWmvUwfB6nQpBInn+4CE9Tc1ObrlOBKuzOXkJo52BA
	 3EP/0cRgT9+yJwPmp7CcOaWStxDWEdv9ag59MhMmLm1uURUQ+d0/c71P3Om3ZiKrF/qjE
	 K0J7EmoJwV2zOHn7+j3Hgk0vmMv6ObHQz8n1cTyuY71/F1UuqQ/08Ir5JxxM4ZpPi6azf
	 bTbW1Zkpfx0I/OflFKA7XDKAaj4i4lAj23y3HUS6DTxOAS1c+svxMc8/zdMi85Tqh9pMR
	 6uTvrayYfdLzIy0N84ALSH/ieoF1KtK1UeP/wAEVpZu8vTb6Xnc+8E7R0KlVW25z2XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GRJOcBba;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54169606A31D
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54169606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GRJOcBba
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso549415a91.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792609072; cv=none;
        d=google.com; s=arc-20260327;
        b=pj+TxEz9TUMHnnHyCz5ryP7fZ9dncdOk8gm2K3lbPI9fNAqBYk82iZQhQsrd84E+L3
         nBUK0yzfc3G9IeWbroc3eEKdBKPt++kCEcDv3FFc/NrTT/KkfkLw6KnKGtMcCPshzags
         v6M7h2SO7HgL5kc1R7mKHdyQ6ZDyZ8i6Ezp5yzaq48yWBrHWuSIdybTlrwA9PUYiPeSf
         uacpvMgDms6yUhf+Z4NhTfMX5citVlWu87VbQpjpj78JCoy7WB04EUmPruB7uLMz0j61
         cFm02VBC/MrOwYwlBqaPoKaSGx0u2GNLTKbu6GIcFe8Qeu0SUcC3AaXQwskR3lqXSqe/
         SZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SQ1PEtdypxTnohtLknkt/wfldChNdlR9LzYhU4LNZxo=;
        fh=U+H70siX3Yw7f5IF1ljcjHRKDtNcFsRfDbBGgIDNOpA=;
        b=qW/O8Ikhuejjb2+Rv9kP+9r92lcvT2NZ0L0xI5FHqve+h7UJONWS4gF37jkWR8PMPU
         Y5shb8xp0zQrldX9rX7J77MMl1w6hvb+Y6rXe0rFJf54mwSWBRALAHVzgsqfulAUmcPU
         8RfVzIz0Yzcd/E8KelEt+JhSOh/v7qRjaRr+amZKyfCuAMy3Il16znDh/2ndYbRgFXw4
         XyhJO1c0im0Y1u+hF4sAx5QIjca5/6Qty3pBaOsXU0fba9k4HWI9lUSCl5dEprTiFPs4
         7eALyWBT3R95sdl/J6G196NNwGu3A9ON827eAYJ/XBgPj1BRWi+IK9jVTD2n+o9CAY9F
         Nmbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792609072; x=1793213872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SQ1PEtdypxTnohtLknkt/wfldChNdlR9LzYhU4LNZxo=;
        b=GRJOcBba8DEJiP4LcvBvI/lWgshwPX1y+sf60QRIqix2s5+eLDRL3csGLAyNFsOvWL
         nB1ccO0SJ+HnQCez2D5o4GpAXs4BOndSs90piRyAha75ce8OZw0PaHnKp4fPErDvBAl4
         NUSDw8och9V4kJEWRTTZreJAcH2/KVrCbRyqle6WFe6oNyGPrf7SevD1WglWcOnHw3la
         tCLnDSfyX+HFzqQMaqZNazHIG0VbLxOaoDNouTxLLZ1dINEeWEvWf0ikAqCD8/Zau7Uf
         r9N8F2GqqpdjB8Y5HVC+LmcXFs3KId5bDmHfVQAmcls7hoZhrF1X8Rv/aewb4JmT7vcY
         HZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609072; x=1793213872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SQ1PEtdypxTnohtLknkt/wfldChNdlR9LzYhU4LNZxo=;
        b=YQdUqDzojKK9qLyHWB6D8G2JXXIMF79wGabaOt7ZSQGV3vAhnVV1fiSzuTLlPRDy48
         SkjHZ0fYEI4YcdgXemDjPASIptlDhGwcagEYS2+niBF/Fee06XLBeUIMYEAOY2dEmBaw
         381UsofQI7HDs+OdxEmjz58xi/AkKupyZvlvbVdR8GAVxALvA6o26KMTojwtacZx8ZVR
         AafWWZ0L5i+wYIeoYqSONJTQZNBNXKoIrW/t1hdK3T1jXtxnv3hBS/abWv1tDoHF11Xj
         KZYX4bR1qBSGZr32lTBJAsplYaMFXjRXQn7KvcWKpVfYlIC+8aW12VLsDaH9tUcVDt9x
         znZg==
X-Gm-Message-State: AFq9FYJnEchhKnBUTJXeJ2440W+cVjoKElXX7dINY9sCGsBZgmFn2g9A
	Ak1Zm+/zap8Pp1LvUcWGKhWy6mYnu0aFxBJlAAanFKIOL7EvvH++lTeP5QVUsajldVXag8ZO1Hs
	zSlY3rGUfltcYhDOTfqOpJZ8V33HLTFQ=
X-Gm-Gg: AYBFou3dFbfKWLNr9ajiINUcCjsGijDpdIyjTZEU6Wv2wKpIcJUOOh7kF52Osy+3U1R
	LDoh2ZXu5tw+/qtPU4Cww1KuKgRGzeNcb0Y3Zd07j2REQqT1qxypi8fju+8b0LWJTOfJT5O5Ajm
	wAemfy6nkBqR6egKXU6rlmn0DJmMeHBpAMfr0rkQZIfc576rtb7DxUC8EH9AwENJMBtVGGbyYTF
	3GG9YzPQAST8iWDEaq2/vF7IqExv3t70QVMMhuc2fV6hUVLeiGpZMr56f8k2ZYhr5KeJaQtuBc1
	3WV+TEu4M548btdhwHk9Aoxc0KYLMvUC/VcQ1NhxAXTtfGp7Q+1h+CZwlcq0/TsTeF6hICGlRvL
	vrvrSnQCyd+EpsUjq8eXE5DHKJfrJ3Nk0OH7oStV7+vTryiDlp/mkHdfWQ6prZ8DWEW1ifwBKkd
	RpZcuXRmi0Q74uQoWfsQ==
X-Received: by 2002:a17:90b:3e8a:b0:3ac:80dc:f419 with SMTP id
 98e67ed59e1d1-3ad86ce70c5mr2459965a91.25.1792609071620; Wed, 21 Oct 2026
 11:57:51 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020155848.75711-1-mahe.tardy@gmail.com> <20261020155848.75711-2-mahe.tardy@gmail.com>
 <CAEf4BzapP4Hng7bO8crK4SLg_PMH33oKo8esFo1ur5-QewNfig@mail.gmail.com> <atkG-5eqB8LfVxSa@gmail.com>
In-Reply-To: <atkG-5eqB8LfVxSa@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 21 Oct 2026 11:57:39 -0700
X-Gm-Features: AclHuK-I_9WzDyc9HR2tb49toTqh-ceHwcLBr8TwXe2tIajdsNbAf5oioeQVVC8
Message-ID: <CAEf4BzYA79tg5C+uzo3S5=MRgM_O7VMYtOwW59QMieJoFNOpVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: add bpf_ksock_sendto() kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, willemb@google.com, 
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, yonghong.song@linux.dev, 
	jolsa@kernel.org, kuniyu@google.com, memxor@gmail.com, emil@etsalapatis.com, 
	almagui@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:39=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> =
wrote:
>
> On Wed, Oct 21, 2026 at 10:56:23AM -0700, Andrii Nakryiko wrote:
> > On Tue, Oct 20, 2026 at 8:59=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.co=
m> wrote:
> > >
> > > The motivation is to plumb more of the socket API into ksock, thus
> > > supporting sendto() in addition to send() which makes a lot of sense =
in
> > > the context of UDP sockets which are the only type currently supporte=
d.
> > > This is useful when ksock is used to reply to specific addresses or s=
end
> > > to multiple addresses.
> > >
> > > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > > ---
> > >  net/core/bpf_ksock.c | 96 +++++++++++++++++++++++++++++++-----------=
--
> > >  1 file changed, 69 insertions(+), 27 deletions(-)
> > >
>
> [...]
>
> > >
> > > -       return ret;
> > > +/**
> > > + * bpf_ksock_sendto() - Send data through a BPF kernel socket to a r=
emote address.
> > > + * @ks:                The BPF kernel socket context. Must be an acq=
uired reference.
> > > + * @data:      Pointer to the data to send.
> > > + * @data__sz:  Size of the data to send.
> > > + * @addr__nullable: Pointer to an IPv4 or IPv6 socket address, or NU=
LL to use
> > > + *                the connected destination.
> > > + * @addr__sz:  Size of the address union, ignored when the address i=
s NULL.
> > > + *
> > > + * Sends data to the specified address, or to the connected destinat=
ion when
> > > + * the address is NULL, best-effort and nonblocking. This may sleep
> > > + * (kernel_sendmsg), so it can only be called from sleepable BPF pro=
grams.
> > > + *
> > > + * Return: Number of bytes sent on success, negative errno on error.
> > > + */
> > > +__bpf_kfunc int bpf_ksock_sendto(struct bpf_ksock *ks, const void *d=
ata, u32 data__sz,
> >
> > This would limit API to fixed-sized data only. Have you considered
> > passing dynptr as a source of data, so you can send a wider variety of
> > data? I don't have a strong opinion whether we should add a separate
> > API or convert this one into dynptr, but I do think that having
> > ability to work with variable-sized data is super useful and should be
> > added early on.
>
> Oh wow this is really cool that you send this now. I was working this
> afternoon on trying to see if a ksock sendmsg() would make sense, but
> with these static buffer limitations as arguments, it actually didn't.
> I'm not familiar with dynptr so I didn't think about it, but after a
> quick check it looks like it would be a good match with the ksock API!
>
> As I understand, since bpf_ksock_send() is already part of 7.3, it's
> best to not touch it, and having a simple send() available with a
> fixed-size data might make sense.

agreed

>
> But since bpf_ksock_sendto() was just merged, we could make it evolve to
> use dynptr perhaps? How much time do we have for something which was
> merged yesterday to be part of a release? Is it going to be send with
> the 7.4 pull soon?
>

I'd send a follow up in the next few days, it can go in as a fix for
kfunc in rc1 or something, unless others have differing opinions on
this

> >
> > > +                                const union bpf_ksock_addr *addr__nu=
llable,
> > > +                                u32 addr__sz)
> > > +{
> > > +       return ksock_sendto(ks, data, data__sz, addr__nullable, addr_=
_sz);
> > >  }
> > >
> > >  __bpf_kfunc_end_defs();
> > > @@ -255,6 +296,7 @@ BTF_KFUNCS_START(ksock_kfunc_btf_ids)
> > >  BTF_ID_FLAGS(func, bpf_ksock_release, KF_RELEASE)
> > >  BTF_ID_FLAGS(func, bpf_ksock_acquire, KF_ACQUIRE | KF_RCU | KF_RET_N=
ULL)
> > >  BTF_ID_FLAGS(func, bpf_ksock_send, KF_SLEEPABLE)
> > > +BTF_ID_FLAGS(func, bpf_ksock_sendto, KF_SLEEPABLE)
> > >  BTF_KFUNCS_END(ksock_kfunc_btf_ids)
> > >
> > >  #ifdef CONFIG_BPF_LSM
> > > --
> > > 2.43.0
> > >
