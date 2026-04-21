Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898C1EA65
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 00:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732601; cv=pass; b=jHKamPM1u8zB8J/YpzJ1EVDY5xY1mn6cuijntYUIoQ1lnelABVN0RZZBim5/uxA8E0q1sE97Wq1Iv+jun5lMASQ1RelcaZ6W2/GCvGDmtVTEj9/5JoS+yM1F0WI7VUVibMfKXynfATvqr9R7WsO2AtEPRqmB90eRj20rz5+gqD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732601; c=relaxed/simple;
	bh=3wV7bjTRykkBf7rQHZFCkWqym43ADBv1eJ1c8QenCwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8ig0jsFFXZ/wV5HkAkG9rdPR+ndl+LZzcDqs4VJvWAYf1hYa/Y3EJUBQb0Mrz9CH4Vc173vRi9mDm36FGpDUb6eOPMeXbNf5jL85zE+Ozd6ebbwirzc4gU8iVbII2UiUgUKYDU5E4S8ZNKafNczFzTsSOxFGFeIcguTpEHyzIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUxD84An; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUxD84An"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so5458810e87.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 17:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776732594; cv=none;
        d=google.com; s=arc-20240605;
        b=VTXD+JEz8yr5FspRVRsIMRQB7uNt3K+NJiKna2MGtv00tUTggyyWjtUi48a+UnutDu
         sFZlv6GDv/zn9bmlYs0RdFNM7a/gQBKt1boGICkkVOnBbDSTs5km1lvc4MO2bNvYg/iu
         +90IGEGhtMbpyKqrRDTCq/UXc/hvUVj0tdiqjaVwmMD4jZtem35cmnpvJEkiTO2O7tbG
         swTayOLr+UaSAvRizhUjTw5ljCz9WVgMecIdsa8OlbgCUKEKLQhBOGt6vXHHMCPO2QZR
         llNWAsVdP/lCuXWRIV+gLMmJoGD72pLSaQr9zE8YjBIUB30cJ+D4xrrFgSwn1GCOa7kk
         7E7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zlfya1nwLzGKQ/WeElmtSC+CVctrAYUow69cWs1Bt34=;
        fh=/jks1Cqtzy12yPpN32iLfI9zJ0+fcm5HfgruZwHjtRE=;
        b=V6Ea7lYfqFP0BAWSbzoJdnNPils88rPTLNpgW/nXJyXlSOugzq3U7rgpqfvPROIUBa
         efgf7ZTL8BmeVC8iWx4tJZBEQDibZivzgoIxwr2duQxKlkps+zV2x4J4fO8Wb169WyH/
         RTG1T5KcJ1j/Ox3HgCAklWkmNZ6lN/oh3MeX4MzwVjh3I+3XQJPuNuoYSsv2bOJRXTvH
         lL8nUET22b64ULcPqNsSWso/SuegcRUU3VyJMzpwDzNQtCv+F99L33dDvBX1AMlpwTUQ
         N4G2GmOZVWBSSlKoZsDVS3MuHUTarJXXxt7b7yQyGxLiz1txgNRHywNPXiUnEmNkdX6C
         HnKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776732594; x=1777337394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zlfya1nwLzGKQ/WeElmtSC+CVctrAYUow69cWs1Bt34=;
        b=fUxD84AnkhwVu6sE8Tq4Zj1ALe3UfGFzF+56Y61eA6c73ytEsVQ3ybMa9ADqPpCSfb
         yH4r5zWBE0S4MCMl8YOapdbhXiMJ2rXM8p4QwE+0ty1RU4lZe+4TN/FCZEiCFhymxE2M
         Cu1dVhFwoePa4IegLtT8Hh5JtO1JR+tvdzh+lUmCIF/9moNk47WmqBK+nfzKTYFeeJfR
         LEYPiDkHwM+N6k+WUxOQiQm9nr3MlxG1Pd8ai9nSSodbB3aw4BQsMg1h9un5Rz2+j2g1
         2TxNmpKnNGyPID5U1Hy5aW9HuEpVT+TQOgRiq50zutgPL4tdeTnGx8u5MTZbD7a/nO8s
         7yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776732594; x=1777337394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zlfya1nwLzGKQ/WeElmtSC+CVctrAYUow69cWs1Bt34=;
        b=Z/xfAIJNYaO6T+lW627Nts748h50ODO0oEW3r/XooUh7lPQWt2lajY99B7aUj23jdA
         LzTb7vBo+Hg2Qg5oyRBhJxmhtnvt963Trh1qwWIo5cRqcIl50Kn6+FnmBvgx3IWVSRE3
         nxh4cszA4CQP4NvsjHM/uNxh9R0xbN0KLClFbmvRBC4+wlVEoN6Lv/d4IXY7IzI9sohy
         dD7FFdL6AdyQ7MYTRZ92De5OgzQjdfU+NlQ2eYoRT14vWL2Xy0MdWN6bYsCFMp0qeorH
         vyJHZAdZ08MUVR/tqSNZ5zSD1jfpGPKguc28nWDfwixRdzaxXcK1JzBajNX9rYyANdAf
         VM8Q==
X-Forwarded-Encrypted: i=1; AFNElJ888VFRetweftAW+QYbICgBTgAI3f79HW4qq+AmV37HsSn6b9ZcZpbigHRMpsFSE+uZhG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVB5N6QYnnB2LBHky1tMveSGwv1iMhSWzQ/P/65oZzT4JRV3If
	i4kW4pMryKlBnioP1UYLN9jyzgSOUR9j+9e/mSMV38XEtRk2Z2+gCeiyoI04X6cONstas7pptgh
	QA9MNAm14zNthXQE1p7nFp139Nkz14OQ=
X-Gm-Gg: AeBDiet/3xytmu+cK95kzK+y91RI1NfQScKGv9xvTDtJ0/6n72p10W+ypLD5oK43oHl
	kRrwcbeNPYuOnwkOHV552sfs9P+m1FaPP6ntkpoTDYVAf3F8noOZv+sXNqJ23KrHK25jppE2Ajq
	e3fsocKXzcQUs9RWlm6Xf9nClppXSHXzU4MirLjpUqCUNOhaQwEG2IRA5MKNnNn0nzMbXijU12A
	sEiTsHYod8jYRe70fFAYBzy/so4v9b3t8GW/znj6jK5RPNuaU+/2p/iw569WkH14+fdt8poPiFv
	oXiN2fscGT3q64yodQ==
X-Received: by 2002:a05:6512:4027:b0:5a4:a85:ba43 with SMTP id
 2adb3069b0e04-5a4172e2876mr5441345e87.33.1776732593473; Mon, 20 Apr 2026
 17:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
 <20260420082805.14844-9-kerneljasonxing@gmail.com> <aeaCzchKwsp_LWyA@devvm17672.vll0.facebook.com>
In-Reply-To: <aeaCzchKwsp_LWyA@devvm17672.vll0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 08:49:15 +0800
X-Gm-Features: AQROBzCuVASaKOc8-y8eMYtdYQzDVkUDr4SxyAct9pri91egUgkuZpdE8YO5hhI
Message-ID: <CAL+tcoCxQ8cU+wr7eJsMH+FPMcp+vQ4J4BdSdsVqyTRqN8q9LQ@mail.gmail.com>
Subject: Re: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:49=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 04/20, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > uintptr_t cast:
> >
> >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1U=
L);
> >
> > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset is
> > lost entirely. The completion queue then returns a truncated address to
> > userspace, making buffer recycling impossible.
> >
> > Fix this by handling the 32-bit case directly in
> > xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an xsk_addr=
s
> > struct (the same path already used for multi-descriptor SKBs) to store
> > the full u64 address.
>
> Is it easier to make XSK `depends on 64BIT` to avoid dealing with that? D=
oes

Of course, it would be super easy. Actually the initial version looks
like this. One line of coder is simply enough.

> anybody seriously run af_xdp on 32 bit systems?

But my worry as you guess is if there exists a 32 bit system? I doubt
it. That's why I put some effort into adding the compatibility code to
cover the case. Good news is that it doesn't add any side effects of
the 64 bit system since they are protected under IS_ENABLED condition.

Thanks,
Jason
