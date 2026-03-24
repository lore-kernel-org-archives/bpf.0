Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C413FE34E
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363140; cv=pass; b=P5zGb2KR+k/mHH/8pA7FiFDiJykMpjRbs1gfOtWwjpx3sni2w00pY+/w0gbgAzAd0v9QY/ZvHmf9XQ2X2B0ymwi5xGHilZcOV4AW1y7jouAGdQ5pPWBW/+rDP8Z7RJKDdALauY89NqobXZ/gNMz3AM2D8g/bITe+04NuoIDMmCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363140; c=relaxed/simple;
	bh=FCqCAhvSwfVF4WjHMhBlMzsUIHjNVgm9chKQCssuZsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZgED9oZP04vDSkdNNAGb+CjqzTlhsndggRskYW2Ld+9SyUouToVhpAyHioq8CJoOCbDeIxd1Vep/penTStcs4sv+V9LIemAHvZ2ZYefigXE9yjNCwR2sHi1JOXcFOUANZpREV7+24YJqtx6EObDphAUUO48Bl7ag9CI5Ljxh/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ND3S0gWt; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND3S0gWt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c6fc2910so1075969f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 07:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363137; cv=none;
        d=google.com; s=arc-20240605;
        b=JNeuJxrn7YgvL+SFVnzlBknDE3QSiY1cWxWA5yiir+8txldR/6NcP9WjYg4GIQfcod
         2JF4UHjTAd23onsZKMfQJHNTjvxhx0BRyqAGNCpawbDnO8W56T5kjNBnQvdzK6HxB1Z4
         Dg9rESNXvEPi9WXlrlcyrl3bu5JRbKwDGBDThwc6JA+7bDqz+WefCBAAcJfO+0pD/JPQ
         rr2PXc4svdTdOKAKcGIfG+KppmF7GK5R8IjV1Ql1f7XJxm7MX6o+QmqNqiax4JQWm4Zx
         HzeSDKa/5pHVjvUxM0smTcdg/tbdTTNWWsCqfnvgLbGETCPGprd9+/So4FvKDLx2bt1t
         fvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7FSG5HsGurgnZqW8vLufEw370eOSK0W5u8ffTft8nZY=;
        fh=UcZqnkcPYPCJuBeofOOObWQTYZ2DVO/Q2yzEycpMUlQ=;
        b=P+4A6Drqj5QQdRhuaXGgMJuxbUatEERUudo3RvMEB30DQALrGHCNmE6GnQDSs4gzyh
         ZqNjaPjskPaOJyK9sIEnBw8RqwBsqd7j4o8XfYjqEC9OynxyKcg5uCBBAzUO14ERYpNA
         zmoFEyvXB/9A9uaVBWar16FG+yui1qeODPUB83wd9/unjE5HYPKFK7fO363BDsINiwAc
         RT9bnW58leXsKO8eWYeJkGKy/aFxrfoco3+OXgPo61Pe4hXBhBtdgUhsV+7PxYKKAUUv
         uGs8qHMkYcgBbxh3+wDVKkXfNsGgJZ7+lezUTCcDYWkvfaDilZP91alv4JyPjFwSFPBs
         7ITA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774363137; x=1774967937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FSG5HsGurgnZqW8vLufEw370eOSK0W5u8ffTft8nZY=;
        b=ND3S0gWtbAGYhER1ZY7ioTHjtYzDMq1XynCvPEyHq53lAuRIPswzMc5Y/SYY0MPRmh
         tu2EbBAnr/hv6gdqxXyOe9Im15NwlFcIPXdScAdXAXfi3jN10IwlHcEvio5KDuIsNcMP
         1AAhx/Xtqo5BbQ4acWz9mwPabzhWsL+gVlHyeL0SnBWZLiVDh7XlFQ9ndptGQp1R529V
         VTlKLl7rDIr5a+erWVC0JDe7lAVuHi3CjkjYTnEJqNfWPHlA2ZAZimxdSmJ38l4iLO/6
         aVP8o9aURki9EiOl4dPvoFTwVgeI+nLy26Zv+T/UETZDAdHOsul91OTTZ+k2RkitZ7f/
         6SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363137; x=1774967937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7FSG5HsGurgnZqW8vLufEw370eOSK0W5u8ffTft8nZY=;
        b=fx5Rjer65ITJGGrOw1tnt0HZ4MmcR86TTRKWGQjVJC2Z26SPFaP/iwzAFKso7jNd9Y
         BsbBmS64S/hGto18hsXuTNORR+RBwzUTpC65IA/yZyVBoMTYDJpYuDEChRdRGWo6NXxQ
         yWaXqj3nd0CFcCPMVhXJk0A7gxPHnsTv6ViJtUKQ95jAYKF+Fqzv2pPYZo1Um0I+4QNm
         VWq1Rp95w0QSP4dbX0rNLjGBvqcLByegDbjqwane19VsdBsVceeAi/ZqwtDtFp69P8KR
         hZn3BIQsnpSlyl1UxVvL3Mc0hmyT0mpxZzoTg7RQ/AAWkCHp5KOlq/NlyUvIzhStjPlQ
         5Q/Q==
X-Gm-Message-State: AOJu0YxvERju5gqEttaYx6XEIj36lbqkj17ssprPIeqk12G2tJxM1v9P
	ca0FXZJbnr080RHHicYjjQYAz8BC843MkmkqH228+faWdsySSSXb9TP05frbitROQq03qMgoB+Q
	3tPzFYmI8wfpo6924HcnsD/csDbyNw10=
X-Gm-Gg: ATEYQzxc66FLHxQzYtLTUIiNeqU2hUgAN4tn2TQqYmpk7LI9++qf+DakwDfEiFovh3t
	YfXsrxocO4frcJIM+3Sl7t1C5oUNVPKEpn7VFXg6m2wnp006ub8vi1TS1PIySPk9bHMWeLtRRWy
	HtDW33A8VCZh499qYTlOZKWJfWp0zuLlKW0MenuC4m2E7/YyQa/X+BfGygr4h8OxmjIDn2MPSqA
	8b1xlIKOi7zIUoSYm1++pdasfB7pTA4VtANXYwZ6JWSbFHC95GtgnjZd2gmCSovOodFspdTxkrJ
	AU5MH1vqRpI+bVyJHi3aD9+/ajOYXWY1UjRkl8e4MpDQID/yI/t2Lyi3sP2/IjYr+Wd/Ss1aK1z
	I+20Fp6aDrDrDQT0tF2W7egdp8Q==
X-Received: by 2002:a05:6000:2906:b0:43b:4881:cee with SMTP id
 ffacd0b85a97d-43b6424310amr26146904f8f.1.1774363137098; Tue, 24 Mar 2026
 07:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323022410.75444-1-alexei.starovoitov@gmail.com>
 <ada028bf2621bd489a09aa41cdd449cb160fbad6.camel@gmail.com> <c2782a066788a9dd0542391c4308d23854d2938f.camel@gmail.com>
In-Reply-To: <c2782a066788a9dd0542391c4308d23854d2938f.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 07:38:44 -0700
X-Gm-Features: AQROBzDe_LrL7uYeZhCdq79c0KXNT5WJ0Mwy06jehqxiQXuJlFBxgfjH7Xgng1Q
Message-ID: <CAADnVQLSYzRbs-+axmNhKu5APTbyzCwTb99gJz=tZvp2ZDVHNQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Support 32-bit scalar spills in stacksafe()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 12:54=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2026-03-23 at 12:36 -0700, Eduard Zingerman wrote:
> > On Sun, 2026-03-22 at 19:24 -0700, Alexei Starovoitov wrote:
> >
> > [...]
> >
> > > @@ -20020,12 +20020,12 @@ static bool is_stack_all_misc(struct bpf_ve=
rifier_env *env,
> > >  }
> > >
> > >  static struct bpf_reg_state *scalar_reg_for_stack(struct bpf_verifie=
r_env *env,
> > > -                                             struct bpf_stack_state =
*stack)
> > > +                                             struct bpf_stack_state =
*stack, int im)
> > >  {
> > > -   if (is_spilled_scalar_reg64(stack))
> > > +   if (is_spilled_scalar_after(stack, im))
> > >             return &stack->spilled_ptr;
> > >
> > > -   if (is_stack_all_misc(env, stack))
> > > +   if (is_stack_misc_after(env, stack, im))
> > >             return &unbound_reg;
> >
> > unbound_reg has 64-bit bounds set to corresponding 64-bit min/max value=
s.
> > For a 32-bit spill, suppose that old state has a SPILL and MISC in the =
slot,
> > while new state has all MISC. This would lead to a
> > regsafe(old_reg_with_32bit_bounds, &unbound_reg),
> > which should return false. This is safe but conservative,
> > maybe add a notion of unbound_reg32 to cover this case?
> > Idk if this would have final veristat impact.
>
> On the other hand, this would matter only if register is marked as
> precise the old state, and to make a difference it will have to be
> both precise and unbounded. Probably an unlikely situation.

Yes. I had the same thoughts, but it's worth an experiment.

> Still curious about 8- and 16-bit cases.

Yeah. I was wondering as well. Didn't have a chance to explore this further=
.
It can be a follow up. I think I will apply as-is, since
the gains are big.
