Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19770401492
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368891; cv=pass; b=E2UVnaqcIBNtG5KMPKY70HURNNkHld9hB7n3I62ACVMdAiJMh+g2rRc1gjo0g0NdzkMZx+/xKkdAL21/ArGWBj2LRc7FdljbIVWbIxU6BPyLGhTG812ZVL8dJpe9U74nGX1iZ7xZzjiZOEHuWHk9TuM1kd03g7tmVIR58/FZ1kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368891; c=relaxed/simple;
	bh=g8N9Jxfh9vj5aW2BbWJ5uDPhpDGPw8QkpqCpsud9jsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxHnc1zmhRh/iUh7A0pPg1iuKpwwPPsQDWTIwAUwBQFSeHf2j+iDhvgGCaYfHNjD8G6aRHz9GXIceOrj6x30dbJMkvLUsz5v0LxT0gfxREuj2WpM9zovLirtC2OJzZJcus1R1LTZ1bQelxUsTbmxuaGoSZ7dt50KxWdxctHcRVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiaHe+gJ; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiaHe+gJ"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-393da8f389bso55674941fa.1
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779368888; cv=none;
        d=google.com; s=arc-20240605;
        b=UJcFUP5D0uTocwHgArwoWm60H81CRWKsa3rxqQlT39ad9WrrI98citbjPD4h5nqXe9
         t58kWu+bNUv1N2InCTf/Vok6F+KGU4EJ5lJg0Ij2GsEH32vL/8QONtiuZwUpgEIg77GT
         b1K2eOBza5YVg/ZY2VvnUa5kEvTb4mWvX6L2ZuoxKiQ6wWNULGWbhfC4yfjyAnV35kOF
         22GJsGHcE+eJyKyB125Op0RDtaCNs5427WW7FTxBMBPOatu62vAnWeMhRP1LrFuSFyGv
         +y0+c4zrxVm93xVcRNeReHtty3oZHZzaGdiib/0e0oF/6DVtI7nFP4GkPZxGxgszLZjw
         r9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ElWo2ALZHjJJQIxSqxixUU8JFaAb9we00gbXuySd10Q=;
        fh=LM/j3GVlCqmCQov3L4Iw2oQEgAwAg7RAd66G+lbApy0=;
        b=CFCiCb/6Cq3JICuCV8hF+ZvPO7/X9tweD0bV2VXyuDzCtDhRQ/88QbSd1JjWyIoYcq
         fpwmieMKzoKjJaq1MxdwWxSrBRIVzAjQGGzk+mznWoQ/b418EfiD5PM/69VOEFEaUQmS
         5NsUD1sVhEN6lSIYEaq2J4zkssktwiNpoqt/rmtDUC3f60FXqzxCmnFNZcEZDMRqYC9f
         raNu0GL+4MEa9JMHnm8GlpWRlA4V/eVZ3luzImZP+TU+WjfpcH66hhEJRP+WeBDlkO4i
         27jDBlhVz5eskSAhdfXMyAaHs1ww/ar6rJyicFGHHrgG2+ei6fV2wAl0IqT0MQyNRek4
         whEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368888; x=1779973688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElWo2ALZHjJJQIxSqxixUU8JFaAb9we00gbXuySd10Q=;
        b=UiaHe+gJ6tu1ZsWczZOp855/kdK+HqXaPgr6gv30PGsaSd6mFF+3k+dUVEW8QmyxPz
         UQQjNtdaonsBtL1y8uv7MDsmuDCGtRZe5aCxRgcwdItVxArqAzfOT0htC7GsbVx2pcWY
         4s9tY3WeLpUMytWvIhfPmd61//S4xF+qw+nCIYCLFjm+mXZuQUB1uiFQxBHCKJ08bduE
         5lw6K6RB5cuDzsxMt/AceCR5kpJnHdc1niIEiyr3xwIfWm/RUtOIPhqX0yE6IfhofUea
         ZfulAOHzGGmAFrBzsVmHLAYLXmFejYaHNy2BAkOAcsLyGIPUr1lfVd8WbBS1IMLLIv0K
         6Wog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368888; x=1779973688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ElWo2ALZHjJJQIxSqxixUU8JFaAb9we00gbXuySd10Q=;
        b=DTvYXKiNoqgXMBkFa9hU/7oLdUo+Mwl7fDCASi7JyLaG6O/UZNZOtzPbtSXPgJg8/p
         4JYLbsMXECLAkqtMKo1rnrTDR9ZeN16a1wYjusXGRmwaCa9NL8+dnzTK1PTi4qwDDY+D
         vgxPN/yM9vDMh996VNP7UXffmSs2phA8F4wlgMilBBqvk+EiRy9YYVkquBTTeabhZsgH
         5DtX6tQP/OqxGWnrl7++dMCO+Hz6aepJnUt5h49heUIcNuCKF3Tay6WqPWVeBR44YD9k
         K980wRGaVm6v0RV6nfZfQFaLT3cLApHHMBL98uAfCsuNNP1msrO2vq4sZ/uhWkakYC1k
         Ootg==
X-Forwarded-Encrypted: i=1; AFNElJ9zW6SHUUUeFZCTs2sOa5mUy+OTP0OufDB+kozkm763uuxBOXtIQ1Xw3KAyeRaB35/RKao=@vger.kernel.org
X-Gm-Message-State: AOJu0YykF1CTplUwM9oHvu1NNNLDkbJFm92Dioz0XMTRnvCcfOcXfdkr
	t/PaTXPfq2+gwa7Vc1papDiqNBgBwKbuOeYcXwRHOrcgyYlWYYkps72ZvPiLf0RHKwe2IPuMV9C
	cFTtxrK3wbBemqg46903TYW3wL6x9Ko4=
X-Gm-Gg: Acq92OEg6runi4gjwx6W0uYTRIeEMvwaNPsyb63CIyUWjJwyqwzaSQkO0CEomA9pfW6
	fD+/H2Z/7RGL4lDO84CcK9yN8QRhSMDoWEIUy0pNI70LQD7f9Icvr6BS95ilyhEPUoa0JXuIDpL
	Jgt21xQD641u05iZNbcxx4SC77IGGQy/2QL9VOMfoPKXl9WPSfNRX4tkSQl/Vthu0zrV6hfNEie
	VGAxarKhE4SZd3NcBxExcKHNSyvZQ0dLH/JhBU3r1/SEt/UD/gaXmaYjphPnJ/h+rYcaRoQsXMq
	6pJMiTpgBNKXf/I+o+qb4L/b5IQGHQA4td2Nwwg=
X-Received: by 2002:a05:6512:3767:b0:5a8:750c:2f79 with SMTP id
 2adb3069b0e04-5aa2ba69be0mr766870e87.3.1779368888045; Thu, 21 May 2026
 06:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer> <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
 <ag8ByhbrNNJaESYi@boxer>
In-Reply-To: <ag8ByhbrNNJaESYi@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 May 2026 21:07:30 +0800
X-Gm-Features: AVHnY4L0irZOSzas-U-4vMjoJZWIjS-Nu31vumax-XgZcnfqGCmdnfBoPgQhD9U
Message-ID: <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 9:00=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> > On Thu, May 21, 2026 at 8:24=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > The series is the product of previous review from sashiko[1].
> > > >
> > > > 1) META
> > > > patch 1: address TOCTOU around metadata.
> > > >
> > > > 2) PUBLISH of CQ
> > > > patch 2: make sure xsk_addr->addrs[] can be published to cq when
> > > >          overflow occurs.
> > > > patch 3: keep cleaning up the continuation descs (more than 17) and
> > > >          publish its address when overflow occurs.
> > > > patch 4: like patch 3, but only handles the invalid descs cases.
> > > >
> > > > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljason=
xing@gmail.com/
> > > >
> > > > ---
> > > > V4
> > > > Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljaso=
nxing@gmail.com/
> > > > 1. correct the description of xmit path in patch 3 (sashiko)
> > > > 2. move set logic into xmit path in patch 3 (Stan)
> > > >
> > > > V3
> > > > Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljaso=
nxing@gmail.com/
> > > > 1. avoid breaking previous usage of sendto, and siliently handle
> > > > overflow case (Stan, sashiko)
> > > > 2. add one particular exception process in patch 4 (sashiko)
> > > > 3. adjust the selftest to make sure it passes in either virutal or
> > > > physical machines, which includes add usleep to support physical ma=
chine.
> > > >
> > > > V2
> > > > Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljaso=
nxing@gmail.com/
> > > > 1. adjust selftests (Jakub)
> > > > 2. add READ_ONCE in patch 1 (Stan)
> > >
> > > FWIW I still get test failures (yes with patch 5 applied). PTAL.
> >
> > Thanks for the test. But I've tried with ixgbe driver...
> >
> > I noticed there are some flaky tests which have nothing to do with the
> > series. Can you confirm that it's not caused because of the series?
>
> That explains the different results as i am using i40e/ice which have
> multi-buffer support whereas ixgbe does not even support mbuf at XDP.
> Broken tests are from mbuf cases.

That's weird. I never expected the failed tests to be about multi-buffer.

Are they the same as the output you attached last time? Or something
new? Could you please share it so that I can investigate the root
cause?

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> >
> > >
> > > >
> > > >
> > > > Jason Xing (5):
> > > >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metada=
ta()
> > > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> > > >   xsk: drain continuation descs after overflow in xsk_build_skb()
> > > >   xsk: drain continuation descs on invalid descriptor in
> > > >     __xsk_generic_xmit()
> > > >   selftests/xsk: drain CQ to wait for TX completion
> > > >
> > > >  include/net/xdp_sock.h                        |  1 +
> > > >  net/xdp/xsk.c                                 | 44 +++++++++++++--=
--
> > > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++----=
----
> > > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > > >
> > > > --
> > > > 2.43.7
> > > >
