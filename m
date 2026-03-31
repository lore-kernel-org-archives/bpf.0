Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC51EF39E
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916658; cv=pass; b=mUn5CTztjVzibAioKd/fbQKm6V1UEyE8jl0OK6ANBx8TGKI9Y5mNM/baoKKhd/+I5m3BVV8UQSvim0R5kwFj2j3HBAAzREhNOLG3VGbddvxToIV8No1+K8KldcAW/5Btba7hHpmQ5BGq4chsZHw/UH12YwVyISvKpmVL0lpgvh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916658; c=relaxed/simple;
	bh=UEdDM+1yMLjSbL0Qt8pLlHl/Kp06G4E8R1a/LT8SqOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4TvqSK5kAkPVvbYxfJL15D84zw9TjBEymAPt+aKykmMvLeFK1mvh85IiVeLiYEkyamH7wO+4wVBmHU5MlHiNoZEz5xbtLHkFKb1AC9DNGLEIOn78Gvpec379n9JgqgClzQLcGmxOYkDs8EHWH8tBYDRD7h221CSbNcUeSR9t04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjvFfMIq; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjvFfMIq"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66c1d0f2b2bso1435919a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774916655; cv=none;
        d=google.com; s=arc-20240605;
        b=Wtlk6ZsQUEy1KB3ALmJW7LuwLNKsjoSYoH6q2wvL5sv7fUKFnJsB32fnvbUDUBgolN
         DZDzb84HxdnI1IKwQwNnYFzxAhgaWprnaZZHFf8/Yxv4+WF2Lclq+u0LdHPktdEkcfqp
         ggh/Ca+YRGAvsemE6gasjosSaxZtOJoNI3fg6FIMRBrkj5K6/+kttUUCc5rYJ9lXksjI
         j+wnfJEpyVjaSOWjka1LRKr0yRGMglgco0kxkXOurYP6GpKD1wJ+IAHorJS9LYD9z0mp
         T5RuqfaiPjByR2bsdA4SZYaR7gDW8YbsBpqjcJRXABfrSIejdCY+5Hkax77g7pXfkwXp
         q6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x2NSZvLJb21z7sndYI+VJiSvYYr+VIQqISxq8jT0a18=;
        fh=4rnAE2Q0+NCFSi8raW8+X8GaWiuI6NobZYAyIQVxMXY=;
        b=L1+m9gVVLdknYTyGmvmN5pAD66bbZjBqklTtDq5EdGs8GqFrSFJqfgmLIGEYah3LoP
         6STFwFcwojtXzt7eRk9MGeO9HPDxCx7XMSMsEvO43vb+H8MfcUa/IwBZRCCoPW4u5GCs
         dH65r+BwstjfygBw3UigSjdBza9Ds1pgLMcrkcl1iV23ZcwuYeZkSrEbb2nifmBZjDcr
         2aJCMnZ0y9q+2djMHHubGK+A9A9jM97JfnQ2BVHANzCIWFE4UKK8vKDdV1bnhVJMvQHE
         UaAoqYyyiTPg3pORbqPUWH7N0CWHjvZecGVcm/2bFemClTBI2mcxUaKy/KxVDToS4bXW
         faKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774916655; x=1775521455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2NSZvLJb21z7sndYI+VJiSvYYr+VIQqISxq8jT0a18=;
        b=YjvFfMIqhI2DKlu3h9P19Qmy/ezz1HNWRHKpyf7wCp2VWxr6l0OmIon6pOYdXDXeGL
         EhLE/IHXMFeq4j3RxdRr64yOJc1xuQD7DJx9+19/7PAP2x1JgpoBTI5CTA9btYaymnve
         EJNeXF7fb2UZ9C+WJZQo95fkFNpEem3Ybdk/0+VgSlOYJaQ12uqsxVOghdYcL1IVq/lx
         6U/p9CfKs264btaTpNyZY+0oNITlfgTY8Z7z6pKquUkEVG4aMO/wFvjR7p7sOxvsXNgi
         68h2kkG9Olgrswu7GxG68rMruqACNMmtljP5xoyWSZdcxu+LaXBm3I31M1y1yVu5vNsj
         zsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774916655; x=1775521455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2NSZvLJb21z7sndYI+VJiSvYYr+VIQqISxq8jT0a18=;
        b=TAo4tBvVjrXHfSUjSeEHPk9tNb9LH0z94a0AfCaB4he/THx7kcKQZP+snSK6VHRdij
         kp/1kqNNt/AnOhpHQxsyk8rjT7D64/xfgp1WUlx+KsOq8+nt5G4nyJwQw8ieEA5n5ban
         07hVGKndnxrwbDvIncNtL0R45BXRuYQm0lGwK207FsoOSVwZQe/PI7BqY0iKyOxVMhNt
         A9gUOxuTPCgGjvWE4YDLeSupWBDdulDh6q/fxNMAND3il+8g2WEFykO53Bv0UZSHsDaT
         YdzpK9KU90CQ74TEGp23QPNNjkwBqaHAu5FAMPd/2iFYha8wlHlwTBAPWBah8j6Z+Az4
         OHQA==
X-Forwarded-Encrypted: i=1; AJvYcCWSSlxsAB/d3XP7e81Zl4jcqDLP5gqUvs/FtDl71xiOzAG/XlGSGkt3OyPTLlk4apnUi7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHGvI/LCho5C6sSjeV5Klkaebp0Bb1awucQVO8arkUxpkbTOG8
	AurmqQEENYg9QmGt7UsE8nHn3l3inT8BNq0DkWs7RhCS8BZA2mBGLocTV1RUss0mH/o0b+XV0Vv
	kelNzsLRK8xVHwJNFs/YZwFDYYQTDERB0m2iwqGuhEA==
X-Gm-Gg: ATEYQzyP3oksc6SAthe03n+o0YLBRUjGTkdPyXOeYyfwr4JPKmJiPcTjDnpya0TeuUC
	BB9FO/tE6+8J1/EyJxPUlWAl770db46E+e5kwyUCDDICTwL6WnK9qZ1gZ4AtNYnJhhGdns/7CaQ
	Nm3/EhQvbhxJwHOU5Lin6RW0oJESyZo+ROBWcyn9Q3CvFGvE6j5jMSeqkrH3rmcKXm7EC8m1g6P
	bz3JzZEUFHPXxeug7oW1/oHzpHFvtnurz9wZyYaloIOaqM+Is9i1uImOZeX9ooM+ZDMku1tX8Ys
	bzqI
X-Received: by 2002:a05:6402:6c3:b0:66b:3cb7:f638 with SMTP id
 4fb4d7f45d1cf-66b3cb7fbf3mr5656481a12.10.1774916655304; Mon, 30 Mar 2026
 17:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323182823.5813-1-teknoraver@meta.com> <20260323182823.5813-2-teknoraver@meta.com>
 <acp5jaFFI57ilC3y@boxer>
In-Reply-To: <acp5jaFFI57ilC3y@boxer>
From: Matteo Croce <technoboy85@gmail.com>
Date: Tue, 31 Mar 2026 02:23:38 +0200
X-Gm-Features: AQROBzCByBvhb9AnuqDoT1x2BkYJrGyhggrmURO-zajvyC8YBUAFOoejzi-xIwA
Message-ID: <CAFnufp0w1qsLAANh5g2KuHYHTQ_-jAB21u2nhOja=4TBMB2gdg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] e1000e: add basic XDP support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 30 mar 2026 alle ore 15:24 Maciej Fijalkowski
<maciej.fijalkowski@intel.com> ha scritto:
>
> On Mon, Mar 23, 2026 at 07:28:22PM +0100, Matteo Croce wrote:
> > Add XDP support to the e1000e driver covering the actions defined by
> > NETDEV_XDP_ACT_BASIC: XDP_DROP, XDP_PASS, XDP_TX and XDP_ABORTED.
> >
> > Infrastructure:
> > - e1000_xdp_setup() / e1000_xdp() for program attach/detach with
> >   MTU validation and close/open cycle
> > - ndo_bpf support in net_device_ops
> > - xdp_rxq_info registration in setup/free_rx_resources
> >
> > Receive path:
> > - e1000_alloc_rx_buffers_xdp() for page-based Rx buffer allocation
> >   with XDP_PACKET_HEADROOM
> > - e1000_clean_rx_irq_xdp() as the XDP receive handler
>
> Hi Matteo,
>
> Since you started to look onto this driver, I think we should have a
> single routine for cleaning buffers on rx. So I would ask for getting rid
> of adapter->clean_rx (or at least convince reviewers it is not possible
> for some reason) and then implement XDP support with approach as XDP being
> a first class citizen.
>

We already have e1000_clean_rx_irq, e1000_clean_jumbo_rx_irq and
e1000_clean_rx_irq_ps.
Do you mean unifying them all or just merging e1000_clean_rx_irq and
e1000_clean_rx_irq_xdp?

> Furthermore I believe all new implementations of XDP require to include
> multi-buffer support.
>

Note taken

> Last but not least, this lives in intel directory so I assume
> primitives/helpers from libie/libeth should be used for this work.
>

Only for the new XDP code or also for the existing one?
If covering also the existing code that will go into a separate
prerequisite patch.

Regards,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay
