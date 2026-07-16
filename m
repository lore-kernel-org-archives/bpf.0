Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3241DED7
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204189; cv=pass; b=nWJ0JBGmCHqNMOeSKl2JPICoGwHpVGEVleL1DMJmjjmdSx4Z5bdypA78zm7K459qmdCPNDaDbC5pW4gVs2RY3yIhLVhKQa6MTDE0nN9IjJjHVNqprU3fhFVUVcd3cEravwbDB0O8bi7YMZlBf52425KG0QsCI8WvDDqBJSu2Z+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204189; c=relaxed/simple;
	bh=OI5CR551vZ38Fw1JyzAypqs6isFToLHGY9xedqEEwUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+zO2w1T8R6lsGA6BRCFlMG/+jW1GpmLW+2h0zH0RfrGGboIkueKa9o0OMmLEWr/MVduLrtSQF3gwSYxvb70k3YWoQihAcfZ6QqTYfIe2UAyJh3nxX2LU2T3T656rHRvR+Izdb7HagbgW3/YtDPye2/IURS2ekb8iiHi1zWHol0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG73Slvx; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG73Slvx"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b0117dda13so2979536e87.0
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 05:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784204169; cv=none;
        d=google.com; s=arc-20260327;
        b=OCNftEEcJ1etYW47aF0vw4nsF2l8+jDuf3/kNEeeAg9iwn9IDn47okDl4D0tr076ok
         24L/2oxnBncMExWCvr1ZpHeVR0/ZCUGB12fpVZhIPGhkMIffDKjPzOm5uzM5M+BJJCb4
         V8dNKF6iR+HCJKIkf/SZpksQKtPrtlt7JI59NJz7QSHRvz9Sph41GCNVruxqXIqmqrK6
         cxu0xjRBXtVvOvoeBsB5s2JmZdjd22eFCF8YAFpanq5B3LdLi3fC+s6el3EQhKnWfqJJ
         1CVZyfxx8EjftL0506OaLJDZgH+bIGbm/E7mjqy+gKVzDKt3mxkjuqF5vK3+9xutbaLu
         r+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DvPcLTIf8tzenpklFTitrlKKvKQ7nhdgU0jncYQi+RE=;
        fh=ehyZ0z/5V2RU4LpZL0QxgdaiHjS/SEauAR+4ue4FpDA=;
        b=rzcp0Bo9GaUv2NC7AwytkoLyRJ8BGct9z7jTYAcqXo4ew0cPVochn6MvgI41m36dUr
         a3xiaHS96MFUVgxpxMWP+B8E+2iV7SWD0iQZd87g3+lSBnJqJDwEA+OHkYQdogH3AuCy
         fw3wh4MhgOUFA108ILNsJdEEr46MgVYQYgBK2KbOEHwgJrrO4LCINu2QpAqZpQE+7B9p
         ndbUivkYUpYdI19wMJwgImZ88o/hKb/fXC59sRupgLi3k8KY/e9BVczEORFg9scbscKh
         W5XT2tp/y8kJrCrJe6idyh1Y6nSRDELvCs8RFF4LHTLLr43qRED8w30ZhGiZe50sUFju
         JuJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784204169; x=1784808969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DvPcLTIf8tzenpklFTitrlKKvKQ7nhdgU0jncYQi+RE=;
        b=bG73SlvxuAq3lrT+7hYy0v2BN6gwq+ym+ffDHO9SvyAkSck04d5gKymRrXmSMtQoWj
         jXDKhECcQbGLVa5G6gIS98AgiRp+NwSmVsxNNnOX4J+X0oU22ZLujlwgOwYwHbfggyLZ
         w647QeYkgwAlDb9e4FJcuVlf2NDr9vZ/+YCghIwVgoFkLs5PmNOD7rmQepYqZa9w5VB4
         qrAxWb5M28cP0VPnGCa9aJ7Yjr6aYnGUDQHWGRo+9VwMoBrrihlXVGe0v3V59G+/KZps
         8egEGgy8M0U01f/89RRlW8ZD7pPI2A7CE0PyADpb0OsGOanoUl7Cfh9GTz4qBkvKZhNg
         fGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204169; x=1784808969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DvPcLTIf8tzenpklFTitrlKKvKQ7nhdgU0jncYQi+RE=;
        b=VVACFXBoyrxomhCU+xq+iGzD47m9k50JRuKs/ZD8Bm+70UMNvVM+T65v3m+Bbe3SSn
         VGWHXoMWRI9aSQNNZIa1zfZ8TCeVFRC4DyGdSd6tymQe68gz1fqtk9QdUezVO3vMu+Dm
         g/anUWfZtiMbi0kvjUlw3Zm5rKKXS/K+mSe3IMMacidWXOyRzbFxYDG953ugVRhKOX6b
         T11YEDcKY0shaP+bjVoB81eIS6Bqm2ZxY+2KQTxpqAg7l0ORZ/HBQH2qvmorHHgBg9EV
         oPQwuOmeNbMntClCjAiUa5B+4/iBZdCjaubTiXHQOPWL7vmmE4TeaGBKJTKCCXr6WQ5t
         HjoA==
X-Forwarded-Encrypted: i=1; AHgh+RpJNf3SaSeNUBKD09gEBU3gUJAikZUd51o+yJ4LU+Qh5BkDqVfxQ3ksuk8NLbjUhdlorfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMAoBmBQ+I19cRxUOvISXt/PNtab3vJVAltMe7MsbrjDOglHT
	FISvX+G0lG8cqeZJEIzFvnBZWQRfG25szJh2Zq9AiirVQS5/bMj5P1UZgECaboVppQXePoKqp5m
	AN37oFn8yEEsYxGvoK6fIu+N0lQhttj0=
X-Gm-Gg: AfdE7ck2H4WuivaT6o9oxFMeUYdYejgQEw19fhFsf7ywOlyPfjFE12abKRrhxv40NHH
	LX/rsUYVgtQK4bljIr1LbCV/hz8dQspRON6qYVjrcgXMlBwyHll0Ix3yI2QtEkVVPbZDuh5lg4H
	GXaOL+AZ5ju0VG8f3yKLaj1lbtSI7Ru+CEKHrHS79Nsd0btOEpMjFD9ZpIfaPSf5Mtbe1KOmvJU
	a+xaYR7NRQjOB5QCViFylBADb0I4WlIDbg7NN/NaEm1tlEPx76zbxil1qkF4qIesXP2R+/zxCtf
	o/6zSg+C/MZuh4e9RyknWFNX5e0g8W/blD6BynSBQkf+8mP8rZD8iNpZu8I0/otD9cZfiSAdElu
	JiQ==
X-Received: by 2002:a05:6512:61b:20b0:5b0:1f7c:254d with SMTP id
 2adb3069b0e04-5b0236bffb9mr3464136e87.58.1784204168645; Thu, 16 Jul 2026
 05:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-2-maciej.fijalkowski@intel.com> <CAL+tcoAc7d8MSCqK23_pmL2G8tSS-MpfM53brijPntv5A+BA2Q@mail.gmail.com>
 <ali/sIjljiNm9RmI@boxer> <CAL+tcoBGJDC-Kx=qvxoQtd4BUPCDBv00Gta1SOvejx9nNvVo3w@mail.gmail.com>
 <aljF91Tx804Lcwyx@boxer>
In-Reply-To: <aljF91Tx804Lcwyx@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 14:15:28 +0200
X-Gm-Features: AUfX_my_rcqL11Tq6EEIJwAiGe0ryqzI-IibSTvULZhec0d8Qy7DxzNB3yWQCUk
Message-ID: <CAL+tcoCz+eMqpZoEB7JVHazzeQpMk-Yn917W0EBGtRbFBoq0mw@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/6] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 1:52=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 01:42:28PM +0200, Jason Xing wrote:
> > On Thu, Jul 16, 2026 at 1:25=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Thu, Jul 16, 2026 at 01:22:24PM +0200, Jason Xing wrote:
> > > > On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > This patch is inspired by the check[1] from sashiko. It says when
> > > > > overflow happens, the address of cq to be published is invalid.
> > > > > Actually the severer thing is the whole process of publishing the
> > > > > address of cq in this particular case is not right: it should tru=
ely
> > > > > publish the address and advance the cached_prod in cq as long as =
it
> > > > > reads descriptors from txq.
> > > > >
> > > > > The following is the full analysis.
> > > > > xsk_drop_skb() is called in three places, which all discard a par=
tially
> > > > > built multi-buffer skb:
> > > > > 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_=
FRAGS
> > > > > 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor =
in
> > > > >    the TX ring prevents the partial packet from completing
> > > > > 3) xsk_release(): socket close while xs->skb holds an incomplete =
packet
> > > > >
> > > > > In all three cases, the TX descriptors for the already-processed =
frags
> > > > > have been consumed from the TX ring (xskq_cons_release), and CQ s=
lots
> > > > > have been reserved. However, xsk_drop_skb() calls xsk_consume_skb=
()
> > > > > which cancels the CQ reservations via xsk_cq_cancel_locked(). Sin=
ce
> > > > > the buffer addresses never appear in the completion queue, usersp=
ace
> > > > > permanently loses track of these buffers.
> > > > >
> > > > > Fix this by letting consume_skb() trigger the existing xsk_destru=
ct_skb
> > > > > destructor, which already submits buffer addresses to the CQ via
> > > > > xsk_cq_submit_addr_locked().
> > > > >
> > > > > Note that cancelling the descriptors back to the TX ring (via
> > > > > xskq_cons_cancel_n) is not a appropriate option because an oversi=
zed
> > > > > packet that always exceeds MAX_SKB_FRAGS would be retried indefin=
itely,
> > > > > which is an obviously deadlock bug in the TX path.
> > > > >
> > > > > Also move the desc->addr assignment in xsk_build_skb() above the
> > > > > overflow check so that the current descriptor's address is record=
ed
> > > > > before a potential -EOVERFLOW jump to free_err, consistent with t=
he
> > > > > zerocopy path in xsk_build_skb_zerocopy().
> > > > >
> > > > > [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.=
kernel.org/
> > > > >
> > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on=
 Tx path")
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Maciej, maybe your tag is missing here?
> > >
> > > IIRC this has been taken as-is from your patchset. The next one has b=
een
> > > touched in few ways and I included my co-developed tag there.
> >
> > Yep, I mean maybe you can simply drop your reviewed-by or acked-by tag
> > here if you approve.
>
> I see. I am not sure what are principles for such cases, I could assume
> that if I include this as a sender then it implies my ack on such change.
> Anyways I can just:
>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks.

>
> BTW now I reminded myself I dropped Stan's tags in whole set. I think it
> was of changes on 4/6, otherwise I don't have other excuse.
>
> So Jason if you bump at Stan somewhere in the netdevconf's hallway could
> you ask him to re-ack it if it still works for him?

No problem, but I don't see him appearing in netdev today. But yes, I
would if I saw him.

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> > >
> > > >
> > > > Thanks,
> > > > Jason
