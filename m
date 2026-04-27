Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37CDF59
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777257299; cv=pass; b=qf2H9Vh88WRrs7aRadY8hQvx/Z8ztWvF5xWwU3PdcZgICt+y/14Mgv5seHVJAOv0sfB7+3cHTwjt1OVTS25YmgpvqwQDqMhU0OqkqlPU0QIw1lJU9nExkC8bTSwdYUNvH9QfbUDaT7VnTlGUwiXOyG/gFgOlJI6CiEYpF/XJBFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777257299; c=relaxed/simple;
	bh=jrAK3TMruyZj10TUC59kWX0H9558xi8uvoqZiyyhYVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loe7NEAO1PW+M06ZZHcrbb7T0Qa9EEGtH65bcf6QNf3wsouwHSpE/x1oDSLBDsCoqjvh553P6Axz8grBpwL7ozLOwmTbj1zAVLt8ndZdty7Fur35JGkPSx1QCiuguk/77xc3CJo3hneEy7vdu4rEoBb+UfwbwZWNiFjyL0sgkKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjVSDQjM; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjVSDQjM"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e4a04f059so11766837e87.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777257296; cv=none;
        d=google.com; s=arc-20240605;
        b=Fw4j8RQJWmUf8RlRuni3FC9PI+UiudRk0cF3od6X16mpIQqkjdQDOcxzjzAkpuan39
         lDpHjAd2/0Y7xtQEOC1rlYUD8YhrYidjS5IlG6uKq3twfOQsJCZ+n9b3PwOQbTRkGCnd
         MpR0Dhes+hjSquFB6vSU1DGXbTxvcm0s3FvnEzeFof4vMVbJ8XLDwrWFXG4sPL1a4pgn
         grIlKtajWq7woGOyQjL+d5XdPqOM22OZ34RmNtd9+xais8KC0EH1ogYBYvUITOLqYmN5
         EbS+ddC70MMcwBQHj+/c6wy5+O0UYIRf0Eo/XsAjOv8M5CRDhFrqvHHj880iARWasoqV
         rJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2nP9HqvSfp2EJKyiHDo/CtzNpkjzQGYzAWoP8uOpFqY=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=BS/mmOspPFvwEhXQBFQoIC9ma2plzhorDAmEGpoZa+YWfF0e0odGD91JImA4jA8u1o
         jR8HfC8+x1Zl0MIX8Nw9THaYF47pA01vbEZRm+NhY7EYGo2y9JqM3aqLVSJlZNkn8OnO
         wKel1F+dBonpS8y4ennmdN7lQZxGoye/N7wNtt0oR7PdLtf3DOdjMGC+XX0OIaLFgXuF
         KYpDj6SsJGps+dSQr6vkDaH5M9xM8wMX4KXCq308dXteLur9QgJoZwOptiBITuwfJCkN
         2EeBia8YgnvMWkNXY7mAN4fX/ty/HccokApKs5dO8eh6WlNFPDnyQ1PA+e4sAzKZq+/8
         cmCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777257296; x=1777862096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nP9HqvSfp2EJKyiHDo/CtzNpkjzQGYzAWoP8uOpFqY=;
        b=pjVSDQjM4/2U40OpzsDGIOzR2MtGiuj039h1+tr893GbbIcQSNmgMupvzoEhfaVzfK
         eeLeFu96PGP3OMrvtEkZNG8AaOuTnCFFdpQpZIYJkoc9YIypRorP+qH4XjPm/4jP5ve1
         K7nB2DFjOGsIFoDfYdNSDvMCO0N4mrYLfLB/vR1c21vKPVubbCHBqANSOS6lS0c5izmA
         BLcRZyUAuwghig7gBebEBYv+DRRPAkSt+rsJUUxgAiT2c/hcA9u5Gc5GaK/yWQnhI7jR
         VpCgVKC2EdJjRNYvNr5HGTxxbB/M4c1rDvkG5wJGblATr+cIp9JlWauVzr9SQbcapbeg
         vEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777257296; x=1777862096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2nP9HqvSfp2EJKyiHDo/CtzNpkjzQGYzAWoP8uOpFqY=;
        b=iAY6CR0NXLwQtN4t+Me8zRRvA0OsiWSVF7HMpoAd8DHheSY/CqPS3S6HF3k6jZgQvh
         F8JRiCSCrJIHxC038PF5uyEhjbRB5GrUHt3VqiPe6Tr4/FHP2nJsxpRV4gkkh+OopmDT
         eNMicEOm8X3v+qaz2OA+tkEtsdpkdDv5UlmmFCOUZxOWbFtOtJdwwupAbq5ZgYsnhnnC
         ZB61XVHr+d/8xumBIiwj+bbr1BRb58ZSHTFA0juRygZQ1AKvbdP9ivgKjhYPwy8Zskua
         ULMT2OVEcwwrS8NJdJ0D/LdYdcSG24dM9LIzVcOASYk7X9dp8gf8dSo91vxju6g/KUtb
         Zqzw==
X-Gm-Message-State: AOJu0Yza3u7h89Z0ezXI50Moc9VpV3tp+tlzlT1dS2O4FwQWB5HcEMEC
	MHWtG43+nJMpZfeoUopWBwKjrBIUvHWmEsM/lFynTRNwQuxGTCoHAfLpmhRdtW5tQznmFOyFGrA
	MCpZQYiQ9oMsWrUDe/cZiCw5ixWvuoQmBrcjzx6OjTA==
X-Gm-Gg: AeBDiet30zEOxGPMolTRUSKpyFNuO5ucMbB8WHK1Urg4Ul+ryOSmmnfzk3e8dUTc1tq
	lI2xzQqGmfHNVQTj0y2hEyuggIymUt+Y/4opuuWkJFtaES+JthluscnoJrdN+qEzwDG+H8mrLGS
	+8JpdIdRbrD5i072LReO9RI5kCTIBMd3PuZFcalb0gxhTOy6xYLw8EKh6YQxOvGxAkGvPhScjR2
	+enOvm/66q+EcR51b0/nySeXNl5DpM9DXijRm8aRnHTSO3NAe0sxjJzN4PdZSUiaAUfpOUbDsgB
	KEmHetbdkKR1dAZ25yQTofJK1wLiKOGwVVCKaa3L0ZcJNXoq+g==
X-Received: by 2002:a05:6512:398c:b0:5a4:7ed:3e4d with SMTP id
 2adb3069b0e04-5a4172de851mr15031706e87.27.1777257296092; Sun, 26 Apr 2026
 19:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422033650.68457-4-kerneljasonxing@gmail.com> <20260425041726.85FB3C2BCB2@smtp.kernel.org>
In-Reply-To: <20260425041726.85FB3C2BCB2@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 27 Apr 2026 10:34:17 +0800
X-Gm-Features: AVHnY4LMvlAB60tQ8YpoH83GiQpze55nBGDO3vdI77clWc0JvGzivZ-CU64ELMo
Message-ID: <CAL+tcoAvYOXfVM-YqN1G_8BQk98xDJ4ppeuGYNt_JeZfECU33A@mail.gmail.com>
Subject: Re: [PATCH net v3 3/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 12:17=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [High] Incorrect completion address reporting to user-space and leaked =
descriptor on `-EOVERFLOW` in multi-buffer packets.
> - [High] Packet stream corruption when dropping oversized multi-buffer pa=
ckets.
> --
>
> commit 38322c7d2a85e9ef029404cbf4ae750b54520d27
> Author: Jason Xing <kerneljasonxing@gmail.com>
> xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
>
> This patch fixes a use-after-free in the xsk_build_skb() error path
> by ensuring that in-progress multi-buffer socket buffers are not
> freed if they are still referenced by the xdp_sock.
>
> Link: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@=
gmail.com/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -969,7 +969,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >       return skb;
> >
> >  free_err:
> > -     if (skb && !skb_shinfo(skb)->nr_frags)
> > +     if (skb && !xs->skb)
> >               kfree_skb(skb);
> >
> >       if (err =3D=3D -EOVERFLOW) {
>
> I noticed a couple of pre-existing regressions in this error path.

Good job. I'll cook a separate patchset to fix this new bug as a
follow-up instead of polluting the current series :)

>
> Do the error handling paths for -EOVERFLOW leak the original descriptor
> address and submit an invalid address to user-space?
>
> When a continuation descriptor exceeds the fragment limit, the code
> jumps to the free_err label before the current descriptor address is
> stored in the xsk_addr array.
>
> However, the error path still increments the descriptor count:
>
>         if (xs->skb) {
>             /* Drop the packet */
>             xsk_inc_num_desc(xs->skb);
>             xsk_drop_skb(xs->skb);
>         }
>
> When xsk_destruct_skb() loops up to the new descriptor count, could it
> read past the initialized entries, find a zero address from the earlier
> kmem_cache_zalloc(), and submit address 0 to the completion queue instead
> of the actual dropped address?

Exactly! It doesn't have any change to run:
        xsk_addr->addrs[xsk_addr->num_descs] =3D desc->addr;

At the stage of destruction, the right address has never been put into
the completion queue, so the application will not be able to reclaim
them.

>
> Does dropping the socket buffer here cause packet stream corruption?
>
> When a multi-buffer packet is dropped due to an -EOVERFLOW error,
> the partial packet is discarded and the socket buffer pointer is cleared.
>
> Because there is no state tracking to discard the remaining descriptors
> of the dropped packet, will the transmission loop process the next
> descriptor (which is just a continuation of the dropped packet) as the
> beginning of a completely new packet?

It's another critical issue but unlikely to occur. It indeed happens
when the num of frags exceeds 17 as default. The remaining body of the
packet will be treated as the start frag of a new packet since the old
skb carrying 17 frags is freed.

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422033650.68=
457-1-kerneljasonxing@gmail.com?part=3D3
