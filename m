Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D756353A8F
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784144882; cv=pass; b=GK0tf7ndAmz9ToDL/Mk+cpHDZLGeD9FtVV5+2Q4GutAeSOb9oHTEo2FomojoeV16FiKe9fnyIDNnVAEetHJ7oD+Ys00Sis22QlDRPNCJZByxD/T9XfrcNaJVkR4A3kl/7TXZPyaM+xzLNWRflOQO/GrGOZvpJmrOxH+ezovEMyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784144882; c=relaxed/simple;
	bh=dIhi4VtC/oWi5aR4YNNcENq5DTcL/ZqsCcgfo1Mwf7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=secZgd9SBT7UMByLnvWf9A2+7jqOEzJczkEj353uV0G3DaJwRxTMElaVEqoaxqRw/9B3twIAlJ9iWJ+w+LCjskMI527JGvpCIFbIXqTsGc+mywOHhCOR2sBXKOyegcb/NmpDfm9ShNLdrR9R8VdHApzchMnOA/LBWFC5Gq4ekzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej+59QmY; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej+59QmY"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b0148201fbso2011700e87.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 12:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784144878; cv=none;
        d=google.com; s=arc-20260327;
        b=MbYgJ1UhfvQq9CbGevd0XTQ1TR2/p+zSRk4Q0FAIx/SQKBGTblrA89cbfpNn2HGUrt
         OP4kFrVAMEmcX/7hN3AaKiaw2XMu7q66KTb+X0Hgy3bng8UZCiHav1ksLMF/B9Eymk6U
         ZIO433MEmTXff8qx5LwBJh7JP2jc/RriRLPcWNoyK2p2xOXB25f8o5Xs/fo5U/mqyRuB
         Z2OKL5fV+Qmz9KtXZGklftv+TmWMPQVITUVUroci8eLpKo6GFCuhRGiSmBTS9PAajcm8
         D37Ok7PQg/CuyIsK2TI6qC97q4KN/VL8W8IKxUUO5hlS43p16m+B0gY+dFBZJqdnJ5OS
         ZXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dBVUuCUdZQyhhgMg9WgictR2p+yzKuTN2XYSx4iiXhM=;
        fh=UQJZL0u2Lr0bNCH6MKCAyPjWIsTkRiwsd79GDeP8N9Q=;
        b=RKizzRXm+gCjHjZdIMP+Xaf0Cb5NdBCSM8gdx+7kIvxl/gui4aO5KWTDfqt4tRx7Rd
         GIKbqGGDLCTETHL7Xv9CdKecPn0rbvcCEcV30XhULaK6/OYsQxGmc5Jm4x0zmrI46h3i
         L2zTeSdTXR7bZv4Z1+d2UJ5yo/U1iWQEyfiXF5YM13GfiwbbNfp9EC60RAqSTC8Vq9K9
         gIcA+Mz4WmIlTlcFFFA/Uv15Fma7d3/236q/JX37bw1FcbMdPNB04vzaMp124chmi9F5
         J7yXd0kAKvaFSGY5nbLhz/6MIWk/g7N6R/6S9iZwhd4K15IHtRBQtAuU6hIYTa/mU+Jb
         uuZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784144878; x=1784749678; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dBVUuCUdZQyhhgMg9WgictR2p+yzKuTN2XYSx4iiXhM=;
        b=ej+59QmYVugP49g8Z/SHsgiC7rw74vyIAqEfbOBn6RcCsUnWpwVrdB6TwB//WWD3H+
         0L66wnRPAAadp0x89kjBKnSR0PtCOlvTRMNzgO5bxpHaSAf1xX/lFr+5CPqLxCgggoVn
         5BkM4kd75OIZ4j0ernBmROywfDK4sWnOhpBU+TXj7OsYZmoLOh3CuP/fWvvrTE0/uWx8
         LQauP84XdlF3zncXZGXCf9MDIW+VH0jFhwua7MaEF7+14jMVbRftZEdG31FXK2btraU0
         xSkDNZNVkYGCgDXofGrc/U6Y2d1WCNA4zbU+vDnBiFrzw97dhcUttBlv3Rkth4ir9KfK
         w99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784144878; x=1784749678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dBVUuCUdZQyhhgMg9WgictR2p+yzKuTN2XYSx4iiXhM=;
        b=j/66z7DuaaoUIgjUkXO2LGIb9h2t2iQE7nHSyMsthb4Qo/cJyOcxJI50XxciZREebb
         b0Zcf748bd9PJXgTPDNI1QvwBVvMShsuFBf6HSIKX+un7yvNqSzKT8SxbggRKwayq8Rp
         1ky1iayS39VKRu6mwef9phr+Z695Lg+GRwUgNVvxahpAB1K6AAnehCj9NRByH940MKKn
         17pAYqlhv33inxmWGRg4oLC3E3PinS/QvVxPfy9VfwhNcJJp7e8Y371CJURRJeMVURf/
         Qzvmoxvp94nSp9xDaXI/40xj7DPqQVIgXgKPtCiqSi/tIbxKYwupKQ/cKDmdSonaJUVR
         XOpA==
X-Forwarded-Encrypted: i=1; AHgh+RrJ2i/58sNEhWObMIHz5bx2TxVMri2ntlhjfaNNAGP+fbhOg8nql99E2N9DP2wgeD3S2Io=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AJQKRytnjF9M7IRIbDtGB7iOHil8DRHCZwZ+Oa683nCqarss
	jB9cWqBoYqfg6yvdUf4Q2cSECzN4s3D+6dttpj/Nq5AlO/4U5mhc/0CZ7dZ9jYRCxTwNH8aKo2X
	XzRcVPQk3fTLRJA+HV+tc1UoG8tCq9S4=
X-Gm-Gg: AfdE7cmtI84ds7bSR/CLqbkyr9ytEt5+WlYlYgpoed2RDIu6bS4f3heMBVUFim7Kyoo
	cB3we5Nzv64gNIibJuKkUeh93qMZL/uJBpnsTC5l/YfyDdmDfKheER0UBQYgn7TU3B6wtBtVK4y
	ie5L8aAEjDdXja559jQR8d6bpFDPPoJLrwzhV8hWaKLl13O906UyB05/VgvinMS/S3t6F9GS4v1
	SsuvqElykDMQGw8HOmNZD1QTcfVKAuYjgC7N3kmQP7PdYVa3zhCpymlmPQzwceoOLbb6e7H8flL
	83LWU+jVQAOxtXSGrAsJy9U/KbNvSb65pw2Jy10T2B38L7D/TP6xBDf7EYexJX+lccUBpUS0uXV
	DN4IcEhg7bKY=
X-Received: by 2002:ac2:5d2b:0:b0:5ae:ba27:ee63 with SMTP id
 2adb3069b0e04-5b023566499mr2872321e87.7.1784144878158; Wed, 15 Jul 2026
 12:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com> <alfaRiK4Ok3gS2Sm@boxer>
In-Reply-To: <alfaRiK4Ok3gS2Sm@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Jul 2026 21:47:18 +0200
X-Gm-Features: AUfX_mztILQsk3Pzb_mQohCtF_THNHYIOvDqAf69uuijc1d4f5OraDRSpzp751U
Message-ID: <CAL+tcoDtrDfTBo_EBjVvizkw=4CSzJvOjH+so03ppLu=GTKp4Q@mail.gmail.com>
Subject: Re: [PATCH v3 net 0/6] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 9:06=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Tue, Jul 14, 2026 at 04:07:16PM +0200, Maciej Fijalkowski wrote:
>
> Top posting!
>
> I took a look at sashiko reports for this revision. I believe we can
> continue the process and get human interview now (or everyone including m=
e
> are sick of this code). I would say the AI review evil has been
> suppressed.

Thank you, Maciej! I'll finish review all of them in these two days as
quickly as possible.

Thanks,
Jason

>
> The need_wakeup issues which I brought up at 4/6 can be send as a
> follow-up.
>
> > v2: https://lore.kernel.org/netdev/20260710194424.84844-1-maciej.fijalk=
owski@intel.com/
> > v2->v3:
> >
> > * Added a preceding patch that sizes the pool-wide temporary Tx descrip=
tor
> >   array to the larger of the first Tx ring and the device's
> >   xdp_zc_max_segs capability. This guarantees that the shared-UMEM path=
 can
> >   inspect one maximum-sized valid packet even when the socket that crea=
tes
> >   the pool has a smaller Tx ring. Consequently, this patch now records =
the
> >   actual allocated size in pool->tx_descs_nentries rather than the firs=
t
> >   socket's Tx ring size.
> >
> > * Fixed a possible infinite retry loop when a shared-UMEM socket contai=
ns
> >   an incomplete multi-buffer packet. Pass the original descriptor budge=
t
> >   to xskq_cons_read_desc_batch() instead of the number of descriptors
> >   currently available, so the parser can distinguish producer exhaustio=
n
> >   from actual budget exhaustion.
> >
> > * Moved the completion-ring space check to the common batched Tx path, =
so
> >   it is performed exactly once for both singular and shared-SG pools. K=
eep
> >   the legacy shared non-SG fallback outside this handling, as it reserv=
es
> >   completion entries one descriptor at a time.
> >
> > * Reworked xsk_tx_peek_release_desc_batch() to use a common singular/sh=
ared
> >   batched flow. Resolve an empty Tx socket list before checking CQ spac=
e,
> >   select the shared-SG walker through an explicit shared-pool condition=
,
> >   and commit the resulting batch through one common path.
> >
> > * Simplified xsk_tx_commit_batch() by moving the cached CQ producer
> >   snapshot into the helper instead of passing it from each caller.
> >
> > v1: https://lore.kernel.org/netdev/20260623133240.1048434-1-maciej.fija=
lkowski@intel.com/
> > v1->v2:
> >
> > * Reduced the series from seven to five patches by squashing the three
> >   generic Tx drain and reclaim changes into a single patch. The resulti=
ng
> >   patch handles overflow, invalid descriptors in the middle of a packet=
,
> >   and reclaim of the offending descriptor as one coherent change. This
> >   so it will be less likely to have things reported by Sashiko that are
> >   fixed in later commits;
> >
> > * Reworked the zero-copy implementation substantially:
> >   * removed the bind-transition mechanism, including tx_share_pending,
> >     xp_prepare_xsk_tx_share(), xp_finish_xsk_tx_share(),
> >     synchronize_net(), and the transient bind() -EAGAIN behavior;
> >   * added packet-framed parsing for shared-UMEM SG pools, allowing
> >     per-socket drain state to be resumed by both singular and shared Tx
> >     paths;
> >   * retained the legacy one-descriptor fallback for shared non-SG pools=
;
> >   * preserved the existing per-socket fairness quota while allowing the
> >     shared walker to consume multiple complete packets and continue
> >     filling the requested batch across fairness rounds;
> >   * made the fairness quota large enough to process one maximum-sized
> >     valid multi-buffer packet;
> >   * extended the parser result with consumed-descriptor and
> >     budget-limited accounting needed by the shared walker;
> >   * recorded the size of the pool's temporary Tx descriptor array and
> >     capped batch processing at that size;
> >   * kept reclaim-only descriptors ordered after preceding driver-visibl=
e
> >     descriptors and protected the delayed-reclaim state with
> >     READ_ONCE()/WRITE_ONCE().
> >
> > * Rewrote the zero-copy patch description to cover oversized packets,
> >   continuation draining across calls, shared-UMEM SG handling, and CQ
> >   publication ordering.
> >
> > * Corrected the too-many-frags selftest description to state that the
> >   invalid packet contains max_frags + 1 fragments and terminates at an
> >   explicit packet boundary.
> >
> >
> > Hi,
> >
> > This series fixes several AF_XDP multi-buffer Tx paths where descriptor=
s
> > consumed from the Tx ring are not consistently returned to userspace
> > through the completion ring when the packet is later dropped as invalid=
.
> >
> > The affected cases are invalid or oversized multi-buffer Tx packets in
> > both the generic and zero-copy paths. In these cases, the kernel can
> > consume one or more Tx descriptors while building or validating a
> > multi-buffer packet, then drop the packet before it reaches the device.
> > Userspace still owns the UMEM buffers only after the corresponding
> > addresses are returned through the CQ. Missing completions therefore
> > make userspace lose track of those buffers.
> >
> > The generic path fixes cover following related cases:
> > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> >   continuation descriptors left in the Tx ring after xsk_build_skb()
> >   reports overflow;
> > * invalid descriptors encountered in the middle of a multi-buffer
> >   packet, including the offending invalid descriptor itself.
> >
> > The zero-copy path is handled separately. The batched Tx parser now
> > distinguishes descriptors that can be passed to the driver from
> > descriptors that are consumed only because they belong to an invalid
> > multi-buffer packet. Reclaim-only descriptors are written to the CQ
> > address area and published in completion order, after any earlier
> > driver-visible Tx descriptors.
> >
> > The last two patches update xskxceiver so the tests account invalid
> > multi-buffer Tx packets as descriptors that must be reclaimed, while
> > still not expecting those invalid packets on the Rx side.
> >
> > This is a follow-up to Jason's changes [0] which were addressing generi=
c
> > xmit only and this set allows me to pass full xskxceiver test suite run
> > against ice driver.
> >
> > Thanks,
> > Maciej
> >
> > [0]: https://lore.kernel.org/netdev/20260520004244.55663-1-kerneljasonx=
ing@gmail.com/
> >
> >
> > Jason Xing (2):
> >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> >   xsk: drain continuation descs after overflow in xsk_build_skb()
> >
> > Maciej Fijalkowski (4):
> >   xsk: provide sufficient space in pool->tx_descs
> >   xsk: reclaim invalid multi-buffer Tx descs in ZC path
> >   selftests/xsk: fix too-many-frags multi-buffer Tx test
> >   selftests/xsk: account invalid multi-buffer Tx descriptors
> >
> >  include/net/xdp_sock.h                        |   1 +
> >  include/net/xsk_buff_pool.h                   |   9 +-
> >  net/xdp/xsk.c                                 | 254 ++++++++++++++++--
> >  net/xdp/xsk_buff_pool.c                       |  13 +-
> >  net/xdp/xsk_queue.h                           |  76 ++++--
> >  .../selftests/bpf/prog_tests/test_xsk.c       |  48 ++--
> >  6 files changed, 329 insertions(+), 72 deletions(-)
> >
> > --
> > 2.43.0
> >
