Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED82D77F7
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774145556; cv=pass; b=a8PRoPZnsACX+QBTQywOVj5uuW6KRuR+RWaXd5GTvGk5/A6QAw7TR5+0yaKfibVjjMtTWrnCe1JAJKMyrgA3G91M62zWUk4vHH7cL1S5cZfyCa7VQuu/QNtewV6HqzZ4bphQzUrHkg6tAEAfWbSQZQyBkFAm13xjMBpvvtXg5II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774145556; c=relaxed/simple;
	bh=6fD/q1Qsxzb/jb2kkxpS1VnijIUcf8B0ptymLmzk210=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR1wEcJYM07kHSJ0EOzsNRiP32hwNBwA9Xu11Jpbfx0DGLsvn5OE+TdlAw7ubx53s1CKNSutXUUBmHGJnh8EylmXExomqYJdNqfTc0X34+x8OUblszPBkcEAyhQ2NooK1zT2E0ts/LZvB8eZIoG3r3ECmzAIxmpS+fUgcEkAtw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErhrGH4X; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErhrGH4X"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6674cba2c50so5917049a12.0
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 19:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774145554; cv=none;
        d=google.com; s=arc-20240605;
        b=HsoQTOzzu1K/ubkiH2433az1V1WSSyYGYBexq398cvy3Exz8/gNIHYq1M9ZjNBUJ8G
         E60LpLDVLjOYwDVmsmnIFW4/ESfuDsKfMbsffjNajTdUMC6VryXqRoerAgs1Iipliw2U
         7rHWYyYUgRxVGwtMf8sOfLpfvBskytboAx88y/9dp6eyYAYtiGGuIpA/PYvee0DLOgrB
         wv7vYxrft8PaTjqGEwE3CuP0cA7LYFhHxyO+UkbTz16aDJGOB1ONUR+7nZ6/x9SlFNqr
         0t7aLlWS6bvdmopSZRdFPYfBCswtqc7F431gliZTi2mviwY2E95wcDAT/PamON/8z0Bu
         eYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dG3xkxQxc2r4hrUA4bCorikr9wEg+eMEMtsgK/HEPog=;
        fh=VNdnAYT9PYYKLdNtZPSjsXw7Rk0yfjcC5Ve6x9KbhJ4=;
        b=cM45nP+txaQNW4pdjW15dDE5Ficdnk3Ji5LIH0YsZ3l3MkQ42M0qqA7GePS3XB74YV
         wUG7bSRc3IgIYfxFZK9zjF8qaSDOwuzQfF5full7VpeuwISe3Wd1Pvi3WzohuOIlbOLm
         dhNHIaxWrNSjis0xYZ87cLy5ueg7ijyshg13YhexGPt7/BACCOWjMro8UalVRyPF1oAB
         h+hv5NWlEiILj65lRDLa+S1rR6uXPBoJD+L+sYQxpUi3VKSesoGB9+64G1KGA1nWYrIB
         DWpIpCy907oET9TwfH2Q2a3Xpp3kWyN4/UFrX/WKSXTxcwPAJMZwC79nJd4TFGlXzWLc
         BGww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774145554; x=1774750354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dG3xkxQxc2r4hrUA4bCorikr9wEg+eMEMtsgK/HEPog=;
        b=ErhrGH4XH1FnoWq5mmvdifLLo3D1A/BTfhuk2skh3aXpqAaPsBvH1hgIFpUhIv6YKp
         HFFypYkEc0m4Tz2BTyLB2csQtsbpwzZTjuuI5C9s5nj6UukfhFhq5q6w3+1iA7vnl+L5
         IH0TLdrskZF3jGQMsKDZGIuzqTFuQowMF6q3uVJX0i/khpDLRiuYHI8ABxrV4ppJ2Oh/
         SkxznBiA5XXSyun8Fcr4WNYA1XiW6BwbfL2ZKW5p4g/2ovut3O3cWDIyfh8j38pJXcOP
         lqp2kQCAkYdrrzhxMiShNcrLRqG1Grebpva4TwsuGYC/pjyFHfHMgqO+O0LlmiCWLYCJ
         upLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774145554; x=1774750354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG3xkxQxc2r4hrUA4bCorikr9wEg+eMEMtsgK/HEPog=;
        b=iNE1KIqn8RBFk0BHcbJ/gHIvKDcPivS0qsp6LCKtk26xLDFiC6iifdbOVMhbTmVmp7
         68WB5q+NMr1ksNo01kN76FKCPHoveN6t2YDeUwtc5lA3nVALMa1AgRwTbRKYUCSvvSX6
         ezVk+3c1ZAbxy+ejCh2M4oKtlmnUPrOi7OevLIaamJbg5FGltY5gy1gDUh/4w6J+ZZnH
         T9/uiJOHhDAa6jGokg1MCqP0aoKN0/WKmNMefWDO48btJQgKHugdLPiPQjKhDLoFG/F7
         XyCc4TggjmwzWPQj87WdTFfDC+2lAtV6qjMbZ2X2RzlDcCmTHpMYvwhHX+DMzyXlZA5t
         COtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjok3qH8jdGVPRrupBVyH8+wL0nmw5GhMN8cwdIuBz8cjHauc07sD7ftlOG9YGEpLtdTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAVW5iOXfa4GgcilzOHc/pCOi6wsXjX5/uPBD6doYpU61rxZT
	xANC8x8eCgV+auOwMf6DfS5qNKrTKBqx6tw0dqY1fu9B1H+ju7+xNmeFUGOSZNdT0aD6vP9d8Ju
	9u1ykUp3OllxoFf3mSII7bxm5z6rBHxE=
X-Gm-Gg: ATEYQzxaFW43c9s6DQLHHRYjdJhL8c7ELZWtEm2zykQQpumwD7v5kN3Quh0Lks4YN4A
	ren9LXrIQIRBLK3WlMizKz158kBPuz0IaJ3/UAusm+YmSUELFl6EkPOJp0RcA3SFmQrrESWtwpX
	ap8SD5xcnLkjI0m8HRM153RwOCx75AQyTWXgeAitBrHE0k7Z3P64lG4KZtSFKo0NqgKbnYiD6Cs
	S/r86a+Qd+c7Yv7mFim0nAXx3U5+UBSl7gaWC8ygso+LX9g0FoEsPnfGZnm1ckGWt2ykFxCol7M
	PnmA3zI=
X-Received: by 2002:a17:907:982:b0:b97:f8d4:2fe7 with SMTP id
 a640c23a62f3a-b980fb05f2dmr787025166b.32.1774145553392; Sat, 21 Mar 2026
 19:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320132356.63194-1-teknoraver@meta.com> <20260320132356.63194-2-teknoraver@meta.com>
 <1d708196-7b89-431f-bb17-177564196894@gmail.com>
In-Reply-To: <1d708196-7b89-431f-bb17-177564196894@gmail.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Sun, 22 Mar 2026 03:11:56 +0100
X-Gm-Features: AaiRm53ww1-ptJbyTPXmgTKJ3HBDK88IzK0UHxVqUtqlnjypi32Zi5Q0XiIBTGw
Message-ID: <CAFnufp0LRVxwh50cLrg=hUe6itshTqrNy53HkvBWk6MQ7uL0KA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] e1000e: add basic XDP support
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 20 mar 2026 alle ore 22:23 Mohsin Bashir
<mohsin.bashr@gmail.com> ha scritto:
>
>
> > + * e1000_xdp_xmit_ring - transmit an XDP frame on the TX ring
> > + * @adapter: board private structure
> > + * @tx_ring: Tx descriptor ring
> > + * @xdpf: XDP frame to transmit
> > + *
> > + * Returns E1000_XDP_TX on success, E1000_XDP_CONSUMED on failure
> > + **/
> > +static int e1000_xdp_xmit_ring(struct e1000_adapter *adapter,
> > +                            struct e1000_ring *tx_ring,
> minor nit: alignment issue
>

Uh funny that checkpatch.pl doesn't notice it.

> > +             if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
> > +                          !(netdev->features & NETIF_F_RXALL))) {
> > +                     page_pool_put_full_page(adapter->page_pool,
> > +                                             buffer_info->page, true);
> > +                     buffer_info->page = NULL;
> > +                     goto next_desc;
> > +             }
> > +
> > +             /* adjust length to remove Ethernet CRC */
> > +             if (!(adapter->flags2 & FLAG2_CRC_STRIPPING)) {
> > +                     if (netdev->features & NETIF_F_RXFCS)
> > +                             total_rx_bytes -= 4;
>
> Looks like, total_rx_bytes can go negative here since it is not updated
> after being initialized to 0. Is this expected?
>

No, that's a bug. I'll count the crc size separately and take care of it.

>
> > -static inline void e1000_rx_hash(struct net_device *netdev, __le32 rss,
> > -                              struct sk_buff *skb)
> > -{
> > -     if (netdev->features & NETIF_F_RXHASH)
> > -             skb_set_hash(skb, le32_to_cpu(rss), PKT_HASH_TYPE_L3);
> > -}
> > -
>
> The function was just moved. Looks like an unrelated change?
>
> > +/**
> > + * e1000_xdp_setup - add/remove an XDP program
> > + * @netdev: network interface device structure
> > + * @bpf: XDP program setup structure
> > + **/
> > +static int e1000_xdp_setup(struct net_device *netdev, struct netdev_bpf *bpf)
> > +{
> > +     struct e1000_adapter *adapter = netdev_priv(netdev);
> > +     struct bpf_prog *prog = bpf->prog, *old_prog;
> > +     bool running = netif_running(netdev);
> > +     bool need_reset;
> > +
> > +     /* XDP is incompatible with jumbo frames */
> > +     if (prog && netdev->mtu > ETH_DATA_LEN) {
> > +             NL_SET_ERR_MSG_MOD(bpf->extack,
> > +                                "XDP is not supported with jumbo frames");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* Validate frame fits in a single page with XDP headroom */
> > +     if (prog && netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN +
> > +         XDP_PACKET_HEADROOM > PAGE_SIZE) {
> > +             NL_SET_ERR_MSG_MOD(bpf->extack,
> > +                                "Frame size too large for XDP");
> > +             return -EINVAL;
> > +     }
> > +
> > +     old_prog = xchg(&adapter->xdp_prog, prog);
> > +     need_reset = (!!prog != !!old_prog);
> > +
> > +     /* Transition between XDP and non-XDP requires ring reconfiguration */
> > +     if (need_reset && running)
> > +             e1000e_close(netdev);
> > +
> > +     if (old_prog)
> > +             bpf_prog_put(old_prog);
> > +
> > +     if (!need_reset)
> > +             return 0;
> > +
> > +     if (running)
> > +             e1000e_open(netdev);
> > +
> > +     return 0;
> > +}
> > +
>
> If I am reading it correctly, this can be problematic (maybe with very
> small likelihood). If e1000e_open() fails here, we will still return
> success. How about the following?
>
> if (running) {
>      int err = e1000e_open(netdev);
>
>      if (err) {
>           /* Remove the XDP program since interface is down */
>           xchg(&adapter->xdp_prog, NULL);
>
>           return err;
>      }
> }
>

Makes sense.

I addressed all the comments and I'll send a v4 soon, thanks!

-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay
