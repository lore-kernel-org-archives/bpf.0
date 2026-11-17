Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794924017;
	b=jqZKXIXkcVzb51lEoQ2bB9Cr4mI1JDbe3BUK7lQGFsCOt1BPyJ0XWwq/sbGFYdbTM3I5
	 e0KTAMtuFW4A8sZDOsVrYyyAC1p1kr3UaxwxZqVUQcl3COSX9eHJXUWVVXiNoBmDcMPOs
	 8FjmAR8fIGA8ZhWsedKJsyq7ZaIv9Agfeyg8qAM1/Y6AeCn1FxavmSib2t78vJOguP9Lv
	 X+fNfAn0E2BhHMLKxxYTWS/NgxKDOXlHTOlh6KAZQrVrF7iDekRcwfeF7UUOLnDWpXuYT
	 25uTrb2Q5zrdqsYP9tB/P7eS0yoYE5sSi4p5fhwlcy/6jOJgl3wcxKIiRwGW/KojhFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=toeVTsCBGnzPd1bYnIUruWVWZ7PF2L9oaPIgH25BZdA=;
	b=eU1+pxIltRsAMuNQau+dV0DZOCaGqtsw11cqsApsCF1TpjM+ico1gzsecqZ6dYLm9Xwj
	 kgWmlB7+UMDn/0wBso948uGZ96BluhDWOJ+o6YUYKLtBf9bu1y+tE1rAfGlEdEBWXkRE0
	 Ccl8UrDW46O5SE9yZhRXk1nboWflY5kI0VIWt9VWNZrRSArCD/qdaVeFqMNMbbMwDT7cL
	 SWvXF/ymuzWKmSLtoTdtzy8USwD8Vr6SyXIAzOlTxkqgWls2OwPzzZY7o9MollNhK6OuX
	 xBmBgm+HYFfp0CoCIcW6w1p5H0ptBLgEXJGeIkKXD9RZbW1Y/8dx/IPMaj8c6ShJUYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=iSf1vEtO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FD606A332
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 14:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 885FD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=iSf1vEtO
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so4070976b3a.0
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 06:00:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794924016; cv=none;
        d=google.com; s=arc-20260327;
        b=ncyr39iTtrPhPfVH5TMqk0lTG6NTtoTabndZ3QPBLQy2dc65/1SMCFBCTs2WcKmlHP
         clnCTvwSos70fIRwetZuxiJSrxJwIL4bBFD0z1wydMNDPRqTWruLfDNP4a5pGrOQNJfm
         2rVeLxZc+jGrYo5IVufuVbEPotO7MC4agg8mtinoeTdIuTEdf8W1F7ncmuqNfeQM4Jr7
         jNOdaaQUkY58WOa+Sdy4PX3a00Ws6sn/s2/f+3tf03sT+gWWxxfpUdiLmrjc3G0Ysedj
         /duDpqqMZRiHHfDpCIjIdv9uGA3vCUxzdhMsKLSiZARDgFgZ8l5p4ET1NGZ5igX7bTQ0
         /cVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=toeVTsCBGnzPd1bYnIUruWVWZ7PF2L9oaPIgH25BZdA=;
        fh=m1Qvyqr7EQaLyzGTkkL3QXW/1OEOu/XN2Fdmq5cbO98=;
        b=fL4y6tMYOrUZVi/P5K0Bl2lRxNW8nqHyG4xT+djwTaluRLgReP5nXnncHZ9ETlDhHh
         6V4UabUUdnW5/Y+bAnBZiihxR9VBngWw6n+CcQDRmxR41jPa0BgUJrzHK9imJNKURe5c
         GTKmT1o0cl49hav2jgPFyND2ufF+NiHDobCRpSFeCvyXBOuK9kMMhp+KhhpvFxGOulPl
         KSABBU12oES/W/Jgcs/6E78/0wemc1SaEgk2RJJ7DE8bZgOA2c2GS2SA5V8TMsxmbeb5
         ujN/sOpRoMGH6w8B4jjiQK01r29bpL0AGwy8zQwhfwMM1FJs7UJigU2ZpOCf/++Q65w0
         WmnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794924016; x=1795528816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=toeVTsCBGnzPd1bYnIUruWVWZ7PF2L9oaPIgH25BZdA=;
        b=iSf1vEtOgCV5zFdc2hdbGG7AaaBHRJ1JECVp3Lr7GLwd25xCPn4j9fOt3SNSDmwc6/
         iK2Gd3WVEvyTOVBsomfzTOOI/Wh0iKOIqDkXZ0gad3wU5JhcRt2MHZFLWGaD3vrheXaq
         brciqxn4fBKW9qdMUDPfDep6TkOr9BKEmpqm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924016; x=1795528816;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=toeVTsCBGnzPd1bYnIUruWVWZ7PF2L9oaPIgH25BZdA=;
        b=SwCHqc+y9ihoBvOeIBn9X84ml3SU7EnS7uGEZiaVamvbEMgy0oYe+vt1WQgvKrbLBN
         dTu+QSRM418qtqS7piXT8ClQLaGpYniSsNVc5PSIGMopGtoxcYxmIw+wpQUwf1wQxFvv
         EKbiIkX8vyQHwEZg4CPTah/RFMxDYVswHH15AvxTDuiSLEDM2tPLhDy0bC5PE5r9aPQh
         mxdlmYFNVDc5Fv/SXMts+WeGPZR4vvG3hKpydhiuQQNbuv/F6O3/pj1yu9FYDEbQp0QE
         Aaf9pWx6ali4F5nDOSAhRbOx8i95YZE8GHNrNDuctZtH5tZp9iEvsImvof1MhBw1idgn
         qKOw==
X-Forwarded-Encrypted: i=1; AL+hErEEmczFknjAO7uCCxSqhmWyvQotQc2LsYVBTjmBR3kbPZhzmQSNt6YLiXbs1wgrIiE5/b8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qVTyNBvSrY6Ns+XS0Bu+kKR90aoZcIei0lRUP6SnQ4CfIvOIn
	zb8nKXF5RlihvjTLnThNUWMe4hsFw3k/9cvvPZ9NIgT3Eso8BzF1xAJ2vAtmfsEOvvUFGye/mRB
	qKzJA0Xfb0VOQvKTbI3noFUDqjjPh0binbzWJvbff
X-Gm-Gg: AYBFou2AVCs9Gq3dO0kFzjDjnyJnk2WKDnmSY6z2TCcEB5ul2dvGm6xHMLExqwDcu6J
	4fPweTeDLM1mZaHL6NC01CRrUncwaIwhwLRdK8JbeUTase7N6EfQjsOKntTwlMHfHQ7GZdZ2OP9
	YmT0RQg0tEWh9Obe9ViKD1qHH+Cca+UAekBInOrAesbJhYNXH7RobPppPmV4gte6UgHSuJ83/Pb
	n9b38nwdKdu4XJVPrgYiG55wzu22ku3e4P3y0ovF2cTKt2kqR4XPWjdOWIkiLSOCp2iQvERypMO
	I46e70gz8flx5tmgVvkZ3p05cwDQg2xSo63ifeAR/h6q1DZDjjqQdFrf0XVKHcvaK9/CMLLK/Dh
	xNZ2AicGnwwLMLaGX4CJegUUqMXjZcr4nqa77nK5COIdLPc6xjuns+DqByPc/eT1ZRKzNTnOwX/
	GZNeAgUAaFp/s8bBw=
X-Received: by 2002:a05:6a00:1a8f:b0:8b6:12fd:7285 with SMTP id
 d2e1a72fcca58-8beb21cd241mr13169857b3a.2.1794924015427; Tue, 17 Nov 2026
 06:00:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com> <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
 <DMWXH28YQDYH.1SI4Y5WQ7EPSR@gmail.com> <CAM0EoMk10vCoAKZq0P=8A_jed=Z3SudLEUV8uvXO5F=ewNjnGQ@mail.gmail.com>
 <DMX7RM93TMGR.AXFN4YJ55REF@gmail.com> <CAM0EoMkqwoJdzChpCVcw+c_XXsR7hw1_Wy6J-zQbq4JjogqTSA@mail.gmail.com>
In-Reply-To: <CAM0EoMkqwoJdzChpCVcw+c_XXsR7hw1_Wy6J-zQbq4JjogqTSA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 17 Nov 2026 09:00:03 -0500
X-Gm-Features: AclHuK9CfZthz6j1EC-BGKHuAHo1niCjgl5St1TdPP-FTsHNCovLTpcJrywdai0
Message-ID: <CAM0EoMnngtO+nt7OWHNKY9DYW05Prow_A32nstsxOkbZF8U6bA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] bpf: drop the stale dst when redirecting
 to an explicit nexthop
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 8:15=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, Nov 16, 2026 at 11:50=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Nov 16, 2026 at 02:06 PM Jamal Hadi Salim <jhs@mojatatu.com> wr=
ote:
> > > encap ip/ip6 or encap xfrm template the tunnel template lives in
> > > dst->lwtstate  that wont work (packet reaches the tunnel or xfrm
> > > device with no encapsulation).
> >
> > ok. agree.
> >
> > > For that reason we cant drop 3 and 4. I see the change in 2/4 (I see
> > > 1/4 not changing either) .  The change is not that small because it
> > > will have to touch multiple core files (although just small mechanica=
l
> > > surgeries). Summary it will still be 4 patches..
> >
> > can we keep the route and fix neigh_update_process_arp_queue() instead =
?
> > The bug is its lookup via dst. Only teql needs that lookup, I think.
>
> Didn't look closely - eql moves skb->dev to a slave the same way, but
> has no neighbour code of its own, so it looks like teql is the main
> player.
> But the drain is not the only reader: skb_tunnel_info() reads
> skb_dst(skb)->lwtstate, so keeping the route leaves dst->dev=3DA on a
> skb bound for B. With the 2/4 I was planniong for v5 no drain change
> is needed at all, since dst_neigh_lookup_skb() returns NULL on the
> replacement metadata dst and the existing n2 =3D=3D NULL path already
> outputs on the parking neighbour.
>
> > A is the device of the route, B is the target of the redirect:
> >
> >   skb is queued by        skb->dev  neigh->dev  lookup via dst gives
> >   ----------------------  --------  ----------  --------------------
> >   ip_finish_output2()     A         A           the same neigh
> >   bpf_redirect_neigh(nh)  B         B           neigh on A, the bug
> >   nft fwd                 B         B           neigh on A, the bug
> >   __teql_resolve()        master    slave       neigh on master
> >
> > The diff skips the lookup when skb->dev is neigh->dev.
> > lwtstate, NBMA tunnels, realm and ICMP errors work as today.
> > The fast path doesn't change. No need for patches 2, 3 and 4.
> > and 1/4 is not a prerequisite.
> >
> > Your teql 3/3 queues the skb with skb->dev =3D=3D slave. With this diff
> > the neigh of the slave adds the header and sends the skb.
> >
> > thoughts?
> >
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index d6e9c7c..04758ca 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1331,9 +1331,11 @@ static void neigh_update_process_arp_queue(struc=
t neighbour *neigh)
> >                  * the packet in the output path.  So what we need to d=
o
> >                  * here is re-lookup the top-level neigh in the path so
> >                  * we can reinject the packet there.
> > +                * When skb->dev is neigh->dev 'neigh' is the top-level=
 one.
> > +                * dst can be a route via another device after a redire=
ct.
> >                  */
> >                 n2 =3D NULL;
> > -               if (dst &&
> > +               if (dst && skb->dev !=3D neigh->dev &&
> >                     READ_ONCE(dst->obsolete) !=3D DST_OBSOLETE_DEAD) {
> >                         n2 =3D dst_neigh_lookup_skb(dst, skb);
> >                         if (n2)
>
> This will fix the cases you showed in the table above i.e nft(6),
> bpf(6) but will break any xfrm and many lwt paths (including
> bpf_lwt/6).

After more coffee: let me correct myself on "will break any xfrm and
many lwt paths" after re-reading your first sentence in the response.
The guard keeps the route, so the encapsulation is still there:
lwtstate survives and skb_tunnel_info() / skb_xfrm_md_info() find
their templates. So i take back what i said there.

What the guard changes is only which neighbour the drain picks where
skb->dev =3D=3D neigh->dev while dst->dev differs. Everything else the
route carries stays on the packet.

On re-evaluation, I agree that 1/4 is not a prerequisite for the
guard: it stands on the bpf_skb_set_xfrm_info() overwrite, which warns
on DEBUG_NET by itself. It is a prerequisite for 2/4's xfrm case,
though: 2/4 hands the route to the interface as dst_orig on a metadata
dst, and an interface with a configured if_id only puts that route
back if 1/4 restores it. Without it the dst is the metadata one, whose
family is AF_UNSPEC, and the packet is dropped as a link failure.

The rest of what I said is the reason 3/4 and 4/4 release the dst
instead of leaving it on the packet. If your answer is that a route
for A is acceptable on a frame leaving B, then they have nothing left
to fix - I'll drop them and the metadata helper they use, keep the
xfrm fix in 1/4, and we can take your guard as its own change.

Boils down to: is a route for A acceptable on a frame leaving B?

cheers,
jamal

>Apologies if i am stating something that might be already
> obvious, but let me illustrate with one example: lwt.
>
> A is the device of the route, B is the target of the redirect, and lwt
> is the lwtstate that route carries (encap type ip/ip6).
>
> skb is queued by nft_fwd_neigh_eval(), skb->dev=3DB, neigh->dev =3D B
> Lookup via dst gives neigh on A  - because the dst is still the
> arrival route and dst->dev is A; ipv4_dst_neigh_lookup() takes the
> device from the dst and the address from the skb  _ only when the
> route has no gw_  (the device is never taken from the skb)
> (Essentially, this is the bug) i.e a non-NULL neigh means the drain
> reinjects on A's neighbour, so the frame leaves B with A's neighbour
> and A's source.
> dst also carries lwtstate (outer endpoints) that B's tunnel needs.  A
> drop takes it down with the route.
> Note on skb_valid_dst(): "true" means only "the slot is a route", not
> "the route carries nothing". A route may carry an lwtstate that this
> test cannot rule out.
>
> So a skb_dst_drop() will result in dropping the packet in the cases i
> described. Example for gre:
> skb_tunnel_info() then finds neither a METADATA_IP_TUNNEL template nor
> a dst->lwtstate(encap type ip/6) and gre tx will then drop the skb
>
> I have a patch for 2/4 i can share if it would help the discussion.


cheers,
jamal
