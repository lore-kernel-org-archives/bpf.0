Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A53F9280
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109092; cv=pass; b=Wdhg7w3fhdLFIRIdd1b9UcbzRQWBd8Jsq+R+71YIIPoPEDzVcOa66aeXJAfMMZXqFKiynb9kSO2oKQrQKJadTlkUSNukxDOZSgVZNV+E7LXoP4770i/OZAtXZMieXK9yfnddI0g7GqSw2FJ43bewydzG4uQ490ZE+iUQUsSdX3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109092; c=relaxed/simple;
	bh=Sqv2/zJbUPZhwfmVPP/6XYmsqc5O0ye1F464HbPnnZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5Cqlg/hl+jicL6z0/ufbs7WYbD0YBxS+G2GzSJVUKQnQcEIj2uis8D7eMPyaPttaQ8YlkcX6VPs4PQXNKsyu/vYMkheh/9gZq9yK2YX+DQXOWdRq935COvDNmygyuGy4HTCtkSZzr0jovEW61VRVheY1YhPx3xoQqVwig8jDDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech; spf=pass smtp.mailfrom=monogon.tech; dkim=pass (2048-bit key) header.d=monogon-tech.20251104.gappssmtp.com header.i=@monogon-tech.20251104.gappssmtp.com header.b=S0+syl/4; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monogon.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monogon-tech.20251104.gappssmtp.com header.i=@monogon-tech.20251104.gappssmtp.com header.b="S0+syl/4"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-63133de7abcso604466137.1
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 05:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779109087; cv=none;
        d=google.com; s=arc-20240605;
        b=JD2qaQZnOwjv2GHMe6Dk8l5CTsAj4YuWcIsy0maRO4S2LEYlcj2jrJvWFoJJX0YFTE
         gPfMnuL6DMbDULYQpTKTdQD7ueDa8NFqW1bQFgx+4qvil8IedJ4Xt3al8FPYMLzrGdac
         uTTFQAjUbSlqyv0E2a/1dLC2I2W8NbcyN8sZrXZv/ZeWkTvQ8aUjlwu8a5SYKG7TnT0o
         9twV2HzDaLVGdtSBtPJFjMe4RLb+xNmaVVeForiBhKEXUQlHJEl9P+MqByvHjDnLZ5H5
         KQmAGx/bvmbEyYyujmNsZKm3CJ/bdQ3VDlJHJsakWWxZQRFA17LJZYsI3+x+CBXP7wds
         dIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uXmZ6DA2CSOKR9KLF5LwpbaR1zZis6lRfYv3mLA+dnU=;
        fh=4PeRo3IjTNzSQwUtUaBTSU2qmc7WnvrZs5V5vfqQZBE=;
        b=GZDwru8VLaPZGBULdsR9kbkbGuB9Op034B4WvdvjJ5igURG2EOtUj69HtEnspxiqvC
         K7yvsMAojjuhhhg0e65T8YQtyr5w3QLJweZqSMCHtg9Xh1RBU2vVrgsOXD5zVbBmo55/
         hG/H09ZSH5ub+sJ7neS6RJ5vNI60oxTGPGRFwJcBWaY2HPfrHsSg9XdJdiI/XZNUUMwf
         o8mAdA86u1yHd8PBU+H03osqFPZ23VWv2tFntbRVG+EphB+x/eenMhEVBTBp8Z3lxila
         h46TauK4QrdUdrBRlVgMQagFen975oZDODLXikCYKwCf3VcQQFEcjOELjXR0ploYfsGN
         UUYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monogon-tech.20251104.gappssmtp.com; s=20251104; t=1779109087; x=1779713887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uXmZ6DA2CSOKR9KLF5LwpbaR1zZis6lRfYv3mLA+dnU=;
        b=S0+syl/4RTeNWzpfJakVAxkUEA4U38NXjBEfyHD2q9YPMDTaV32TovJ2F8M20idxHQ
         NxhA928p0mglemYFzS+cpShbZN8Lsyeu5Ate3EJk4XaEkH6aeXnE/HSiaPRFsBcOZKoA
         c29NJwbZlYBPkq0KfjBQc4av1qjHHzwn7kWVYuZxh9pxhq3r8R1vjMXS/wRLXHA9xd1D
         EKQqVuNOKDPaN5JyyYYCxhxlg0kjOE4hBBRxCxTzze797FUTAxH/UVjc1/PSc01S9f3i
         5M32NkaLc5VG4wuJVgnng18nlZYDH4rK3hoOmY74SGJEQzad24kRDTWhmpzZzOxl7mj+
         yFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109087; x=1779713887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXmZ6DA2CSOKR9KLF5LwpbaR1zZis6lRfYv3mLA+dnU=;
        b=nY0sm+MVdDiUW7QH1dIh5qbooiKOcde3kKQAWC7+LqfXrwflqIB6+azNulPaSh7+qB
         /Vssl/auydwCPPFhmq1AoZEet14WIWn0mHnO79EUkDaybb4WC2PaYSPQusJBmqMIHFAQ
         r0oGmpFvtigH3ivc8Itjg8JtzJJ4gPHq41iIDKSE39TTNlb7OiPHdMhPreW661S0gwU6
         xpvFA9KTBlytaVpMvrii2ommYvAAuPTcmJJntcMgCCWnUO/648mTq2cvytw8ykMF7TWL
         /vt6Rqx8Teyybj4TW0z2iLInf7V+qngggA+YLeoFdM++LjsumuHdyvPp5thN1iy8Bwoe
         6p0g==
X-Forwarded-Encrypted: i=1; AFNElJ+NQ4DoFY4ExA1fKzpwxjWDO9C9Mw36COsP9NBg/kgKaCfTKmQuW9ob1R70az953HMrOQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywll+v8M3Zs/WlnXa2c5Aica9Tbm26ZU1RQyzRQK/Kgmn2furSn
	0nOkYrX4OIHNVvtukJ4gpeZ6kLUegzAx3DNd8Y7lW+dR4o5srjpVKLVeYzpM6T/0FboIOmsn9OP
	kWcI81so65TbAcSsk3rmd50mSBxswBKa0FK5pIesUBw==
X-Gm-Gg: Acq92OHQeJ8/HuGlz5mYL5HI1w3CGheLZaFt22JHu9k1l7juCQ5y0sJeC5Ty2UOqbJz
	IJouICpzalhGKubrbAB/wBH6rGTdQoHdaqYbbpIshZ5wqMMbWY0dJ7WrM9f2YCD8JfMhEQ+1Hlm
	VXP6It3/ZVFU0RJBCMNdFwHOJxd/sJrZJZSa7PTcCrP0izGY8tKwOvT9hQ/hAz/rg8S7l7SEyOw
	e1y54lcnCVjTQnHkrseBfLnVyiFF8EqkbfTcHQ0C/hn2ZmM2GxeKzCI/9MySgCzyio+hr6BuLOg
	AoOIcvYqu5hbZLqkZdNa0VO+RAyAQ5CClg4l
X-Received: by 2002:a05:6102:6047:b0:631:4cd8:b6aa with SMTP id
 ada2fe7eead31-63a3d93b6edmr6378714137.13.1779109087067; Mon, 18 May 2026
 05:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512152658.2818805-1-lorenz@monogon.tech> <9c49ecf7-1d35-4b03-8a71-9d724562594d@intel.com>
In-Reply-To: <9c49ecf7-1d35-4b03-8a71-9d724562594d@intel.com>
From: Lorenz Brun <lorenz@monogon.tech>
Date: Mon, 18 May 2026 14:57:55 +0200
X-Gm-Features: AVHnY4KmAFH7SWcYKpSxBgfiVCiUuxFv1ES63sSXsCXW1j6V3gBDDffnv_CRq5o
Message-ID: <CAJMi0nQN+XB14Z81=W2reEGnax526-MB=Armx+f_miWMWUmRFw@mail.gmail.com>
Subject: Re: [PATCH] xsk: switch xdp_build_skb_from_zc() to napi_alloc_skb()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, stable@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 May 2026 at 17:21, Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Lorenz Brun <lorenz@monogon.tech>
> Date: Tue, 12 May 2026 17:26:56 +0200
>
> > xdp_build_skb_from_zc() allocated xdp->frame_sz bytes from the per-cpu
> > system_page_pool and built the skb head with napi_build_skb(). The
> > latter places skb_shared_info at the tail of the buffer, but the
> > helper sized the allocation as if the whole frame_sz were usable for
> > data. Whenever the packet plus reserved headroom approached frame_sz,
> > the head memcpy overran shinfo with packet content, corrupting
> > ->flags (SKBFL_ZEROCOPY_ENABLE) and ->nr_frags, which then drove
> > skb_copy_ubufs() off the end of frags[] on the RX path:
> >
> >   UBSAN: array-index-out-of-bounds in include/linux/skbuff.h:2541
> >   index 113 is out of range for type 'skb_frag_t [17]'
> >    skb_copy_ubufs+0x7da/0x960
> >    ip_local_deliver_finish+0xcd/0x110
> >    ice_napi_poll+0xe4/0x2a0 [ice]
> >
> > The overrun bytes come from the packet, so an on-wire sender can
> > corrupt kernel memory remotely whenever the XDP program returns
> > XDP_PASS.
> >
> > Rather than patch the sizing math, switch to the pattern used by other
> > in-tree AF_XDP zero-copy drivers like mlx5 and i40e which use
> > napi_alloc_skb() sized to the actual packet plus skb_put_data().
> > This sizes the head exactly for the data being copied, drops the
> > system_page_pool local_lock from this path, and removes the
> > structural mismatch between frame_sz and the skb head buffer. Frags
> > are allocated with alloc_page() per frag, matching the other drivers.
>
> I used napi_build_skb() + system page_pool to enable PP recycling
> improving XSk XDP_PASS performance a lot.
> Are you sure there's no other way to approach this?
>
> napi_alloc_skb() used in other drivers works, but it's sorta old
> approach which is way slower.
>
> System page_pools always allocate a full page, why can it create an skb
> prone to overruns?
>
> >
> > Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lorenz Brun <lorenz@monogon.tech>
> Thanks,
> Olek

Hi Olek

I looked at the code again. While your approach is indeed faster, it
is only faster for traffic bypassing AF_XDP, which is generally not
that relevant for performance.

More critically, it currently corrupts kernel memory and panics the
kernel very quickly when running with frame-size set to 2048, 1500
MTU, and passing received packets. To be honest, I'm not familiar
enough with the XSK subsystem to know exactly what specific sizing
assumption was violated here. By comparison, the approach taken by the
other drivers is a lot more obviously correct and works perfectly.

If you want to preserve the current approach, I'm perfectly happy with
that. However, I don't feel comfortable sending patches for it, as I
don't understand exactly what the expectations of the various data
blocks are.

AFAIK, reproduction should be fairly easy. You just need to run a TCP
connection to the receiving node (which gets passed to the kernel)
while receiving some UDP packets via AF_XDP at the same time. As
mentioned, it also needs frame-size 2048 to reproduce quickly.

I checked if I could get you an easy reproducer, but xdp-tools is
quite limited. If you want to keep your approach and can't reproduce
the panic yourself, let me know and I can see if I can synthesize a
minimal reproducer.

Regards,
Lorenz
