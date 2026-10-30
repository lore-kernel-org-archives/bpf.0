Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793351752;
	b=VYjO9XfRvX9COxj5zAPuECzQjFbmq28HjMN2Flx5PmXZyA8z4ezvJmnBDDoC07/yVpVJ
	 oRL52vdHp8OISKwpRTAOxkKMHWkttvCiCe1JaN7ifTZ5ry3oykZ2A9VJr7CHi293sBDp6
	 OsOKFkWmhea5l8sCrPyDWQYI7XZ8nhS+Gf0btgV7bklGGCGkfmGbkBg2KmXZDBgfKWZ1u
	 FizRscIH6LeuRfdbGnokRsej9xHSvQzXl4HcG3PJfen4VNn95dcockkUJ2y8Fs1H653tH
	 b/muU+iMB/QEVZjBgZEgxdqbAzOHDIRA4YjGY/KCrRgSve1VszIAaqwzRASy4qO0zDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ic0l6s4/vCSv2HTg51cnmOpg7vz5TShRFb99sP2LwP0=;
	b=QTgxAIClT/3tGYEDuB9usw86YS3M1HZ2/yPISgAYWnEn/qbyYHNBAbUVheMlAW+OHmmB
	 y7eOcKWaft+XENlpXCEIGoC8Fz5OGcmG7+YftbTGFKr4Lueexxq3zlxnz26yHpR744Lqj
	 AIiGU60bqkGjdqlBYhXvBFc0m1d4v1E8sWBUnOh4bB7LovRjSqulQfDqUVlMLMafOBR4+
	 7Eg2zQVozI3WWMRr9Qp13LFe9upcJrdu9g3AVNnwxKYhs+qY+46YxTdBZFseR01Z4bPaF
	 jCKRjgRzFafupT9rYAv1MrjMDTHcYtiHCMT1TJDNA8q+dsFlHFDIa6O2rROf4gwDRuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qfLBsasI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E3606A31F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 09:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F5E3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qfLBsasI
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be4d648aacso423319e87.3
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 02:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793351750; cv=none;
        d=google.com; s=arc-20260327;
        b=FJBPtc/Cw5ZHYkARDjzC9WGq50sfCOE6IiPbPPKs2tRr2GV6Iqh6E80oZPN3yz/4Pi
         TVcFFVpLS9tHW6JaXIQI3TbGCtmjs2Qh/s0T8R9Gs2gRwBzdqX8I5VHW1NNwEqbU03ct
         4MokaDLb9QC9SS5nMQYeDggd6UVc1gSammkA6bYPQHOOE8YbV/oHwVpyyaXFoQhj8wnV
         gqEBaYTQzsl9ekXNW8n1U3IxdcZwAYQDZu8OeFyoMOsEaLQ0EfC+1EHMaFd3bIUuVLF9
         mygGX4wFwfKi9mkpwE2XVIBigDesByRNhVee0iXOSQHtuCcG+V1pxryLfX+xCYOKcAqk
         65dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ic0l6s4/vCSv2HTg51cnmOpg7vz5TShRFb99sP2LwP0=;
        fh=uDrRgaOGqr6MPuNbwhCAyitv9+UhhBe5U0hCb2FliKo=;
        b=ENQuZ3yi5LQl/LMpOQ9jzDh3MY1wiCvk+h+hBzULc5J7RoLW4bSN7d6rQhZ2NJmbWn
         5QADuLLuw3NvhOmREWrln3u5mR+TzhmVMY8hjCvhRl++eQyTdmpjIyVsmeUAJGkyW9PL
         obVul7fVCSR4ZHt3Oy1ZliZY+HCDOrRGBBRM2vEr8bvBG0BLLiqTWQLbrvS3cPY4PFkj
         Czu5q5iLWaG71JbbDzVkQX9/9uAKzgddQ9QlKQu8lwaqkEvmjC5VZSw1vnnyIfFGnpe7
         LzKGKI4mc3bSef0adklLixKDtMiDGA90LgO9j7czu0owYi9waIYht8ZMniOEhmEfTlUO
         rf2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793351750; x=1793956550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ic0l6s4/vCSv2HTg51cnmOpg7vz5TShRFb99sP2LwP0=;
        b=qfLBsasIj0ueC2Rm80cM4nkkefayvn27KbmgG9N1xFUzMEPOSqzCiMGte6z7f09SF4
         QmWsSi62JZAp1RCu0wer6f6lUJX1sJ82VugRSHYhS8MY3FDXFsBB/dBcPf5cY78sljLS
         29tbFUMSzh46Yk+v0t8EEiyT++a/3d1cuXI6gpTD/vwdTq6cONvNdeZsBWQTIt4qQPEI
         g0jTMXVQjRwnlAANKJN6lmCYJaFnWZTIOD11otdk2g0iz/rbU7Jly1s8j0J00HNX/cyS
         m4urrgVCOlPkuR9hRQpEhUNOot9aqiTcAYJL2bCL1P+kYfL3FhVAdBp+etp1DtqyniQW
         vZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351750; x=1793956550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ic0l6s4/vCSv2HTg51cnmOpg7vz5TShRFb99sP2LwP0=;
        b=lqZNnTxQAn/KefS22Q8fpijxZdUJHy+6t8VLK2wOx0vGiZfypJrtTiku1OknLuZ1pI
         rftxJZJwkpnTbpK43sC7UKAVPsu88IgiHbv0nLAva2XKp9dlLbiki0k8mgtX8vbuaAgV
         KMH1YCGTITD6us++L1yQY863owaHFJ0JBrwt5AMmv4uRfVpG+qNSqrnrz4dgsLb8nu/L
         srszckJthVPz3SH6JUtoHCHcJoG/EjMSC/TOoYXSlDChPj07T97ewNAk8cb9R9pGWPT5
         sgkzSJiexJejSzsf1iYS++nmpkwTUomCXtgjGQYJ4u7e+yBd/cXMj5ZuNFQA/uEos9hx
         ryZg==
X-Forwarded-Encrypted: i=1; AKwUvBwCpZME1MQ33Zz28QsQrKMXq6lVluL41V/hcCW7Rtl16+rsvUHYESboHUGeGspXwdOl+70=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXT+Y6QhmH1J9NaTJMZWnVV5amNn0WxvmULvtS0uThHYWJi/cp
	QTKoz2wZVPLRFJeFK0NaRrNEbUhzxwroH4oqQD8mUraMHjph/O8XsasV0c/Ma34BvkMpfDK933s
	p1kiLsy/EVFzhSGMVm0xS2ujlnT5O38I=
X-Gm-Gg: AYBFou2q3R4KM8ex4I3x6Tml9MswVxM0PNWEK3eX+ngg9y4RFUDr3JrYEmQj1bvNHw6
	JrnHKplfcLHlgI8za6ZsR22a2e0W75qaqkSO/OnquTZE8jGxL4O9K/RTMIgD4r4uXw9RyxH7T3Q
	y1wT6MGSzhnHRxAaYuJLiGSityZkQN/Zgfl/ht6Aa2iXAqAl8grQoL+8gQdKO79jEVDmV6Jv5Oq
	azZXF2XmZTpWe51Wc2Us5vLdF2xfJniburHmBmcMOggSO5tJve8PP8qLMjy+DrH4+UEdxaO8tU9
	WIiz7E8dkKzMXyz95mx6R//EstGZkNeZerkMT6/8DpmpIloTFSfOZsxjKn7IR/+TxmYYhQNO4AM
	4zrj1MajfgnFPUV1pxicyWVJJIFX23zOxycRDbQMSzxe6+CytqeUWvIO7nots//jez7aE6maqtR
	hRGfzQnYdiiBN1tZxXps9nPRERogRm2N4cWumiTRJ0QWJorHYl57U=
X-Received: by 2002:a05:6512:15a8:b0:5bf:a352:9c25 with SMTP id
 2adb3069b0e04-5bfd95200c1mr558923e87.5.1793351749887; Fri, 30 Oct 2026
 02:15:49 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com>
 <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com> <20261030084017.16202-1-testwrzwrz@gmail.com>
In-Reply-To: <20261030084017.16202-1-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Oct 2026 17:15:11 +0800
X-Gm-Features: AclHuK_tqEbHK_O2Qvnq3pma3G6-PFR5lcMFBxShPN1h2GTemzUuLTxLrhij11k
Message-ID: <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 4:40=E2=80=AFPM Rongzheng Wang <testwrzwrz@gmail.co=
m> wrote:
>
> Hi Jason,
>
> Thanks for the review. This was a timing race, not intentional: your v3
> reply (the Reviewed-by plus the else-branch nit) arrived at 10:30, while
> v4 was sent at 10:32 and had already been prepared without it. I should
> have checked the thread before sending.
>
> I'll send a v5 as a new thread with the unnecessary else removed, exactly
> as you suggested, and your Reviewed-by carried on patch 1. Patch 2 is
> unchanged.

Thanks.

Since I'm not that familiar with the selftest, I would not comment on
that one. I believe Maciej and Bjorn will give their opinions, so I
highly recommend you to wait for their feedback on the selftest patch
:)

Thanks,
Jason
