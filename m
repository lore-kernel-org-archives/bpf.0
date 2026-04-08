Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D437BE7D
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775692380; cv=pass; b=g+ydiP4qnZPBXaacqF3sk+OFXzbSbLGbQalWxFTgOAtTDl8aL9AbsknyX1h6cX2mu2KvWJKEwie2fp71azB/1gcTJsKTHjoLCxly/Eqkt8TIZUl78GaPaVbFtvaINIm4x5kw6XbVsLwJHs15jC4XPrzFrNj3rYhBdfZqiMUrEE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775692380; c=relaxed/simple;
	bh=SJDkEMPwfGPXgzEx/lQ3RYJvGP+zSBYTYDmzQE9d42E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5njqNJ6yuVmQ/A9rbL/G5DI5uZhNGyy/mzpSMt75bZpQHAlmZyLULF+k7hBwHKM2PAUZzMJHf4fSa32uMFY/69vsk99hkvkcjMvWs3Pko4qX621j5quC0b7FIRZLNuJJIZrg2mqNuNzddOdyMptCXXz5uTZmViLM9EPCutrY3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyEb9ng3; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyEb9ng3"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59dcdf60427so248559e87.3
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 16:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775692377; cv=none;
        d=google.com; s=arc-20240605;
        b=QgGWO+vHZSP/W3NwUi3ivy2ugX/nKWsh0m15EFJtKG3oe1WOj57FkJilfCC2n4nSUj
         POKeh6C+m0CjVxAmycKHdVrx80RuLbF/s4KOcgkRkTENOoebbDeM7FUfx/N41vcP/S8+
         IUrYmOaOQ/DzvD4/5K43aKvBNPFPdx4CCcgFotFDVIlvtSpd4yjjKZvsjRypSb5QCJHY
         q4Zcsk2CdAWcWLgCiWHauap1xOQyjuScT13zjrmO0YxcffyXmfuHoIP8tVxUy9nxCurh
         IlvcH44BLXtHUO098cDErtQz0X+IK45qC7XW8PYLuolABcO4ZQ9lFxvLwrXLpXODkbMP
         pvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SJDkEMPwfGPXgzEx/lQ3RYJvGP+zSBYTYDmzQE9d42E=;
        fh=+nbFidLC+U3P6ci1NqTNHegfvJIhq6w8gLh8YFOUcxg=;
        b=V24iyLSY4QEXBTQF3fX2eIfrDTIUCPU4MrCfAehBlmyyrtGDJqDYYAub/Ti+PpFMJo
         6PFbnEJ/eVwYpQb84nX52QvVX4tFot+xYDERvVRGqr5SuTN/rubpci9RAXurXMTIAmYO
         /EZvTJMtvDrFQeYwDdjX6tRor6iHBjoa0rthN5OApeLak0OyidVpnSP8naBGY071a1J/
         CSfE7vF8nN3Srs3gWa0AEA0DagL3GjuZTUm/wzIhHzEMauF5DTcKW1mUaUqra2UBlw6V
         l5cKpwjT3oCAJPF9fbFCBdX3FX5qlLTQD59WTFz0uUjaCrH9z3Gvp/LA8OoCOnQe4F6X
         RIzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775692377; x=1776297177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJDkEMPwfGPXgzEx/lQ3RYJvGP+zSBYTYDmzQE9d42E=;
        b=YyEb9ng3hiHb881w1ZY0vQzo9EZsm1A7L/eB+zBIUZNIcsteQqFLQ/w3ou4s4c36eY
         hL2J4oFc19fzji7l+ai9TxfwK1Gj/XUcQsQbJqn9C2xDkuWOuOrOZDJ5D56KmnoBHuTy
         b+l2+QTeeRuhpTuC3lHLtu62bxFjrNEcJJLUOe3mwOwBEp+pAa1NeulCpc2liSN3GaV3
         yndso01cICa65gfdgdGrLVA5fONvDGSFjMYLHcO4zDGXTu4OqLtZfVQ+HuG/Q6l+I9zo
         G3+VjTDBVI1PUwBiP10kLSuZ5NS2MYjmoAAA40LjBFOYFU8Crk7BxTd2osXbw32Lwh6m
         zqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775692377; x=1776297177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJDkEMPwfGPXgzEx/lQ3RYJvGP+zSBYTYDmzQE9d42E=;
        b=Uxy94DmmixcRDC8nCWBBm3Fsiw7LaufA/hdG24IKwpMlgay66Qf4omzv7+ujqG0SAa
         FoKIYghJox+zyPEl+jbiTaZP3DTR62AJzfMfU2yRP0UTI7ORIi+71rWrSHOIubjjQ51A
         Lg5fDqK3K3q3yLAGYbpR5PTRfLzepWpCdXVI5At60/7GoKC5VKc0P+xSbo7qJ7CTpK4e
         4OioJySTu7c4RZWoBjLI7E2ZGZf5j6Wa3qqioSHUFH1r0pu1L4SZp7Hi1WqiJ8coSJkw
         mge+OylsT4VLELtdUwJnCm4sOFnytkYV8lM3V7OICiFfWc94wATahGSOhluAW0s+hqEc
         mKhA==
X-Forwarded-Encrypted: i=1; AJvYcCUTpSF0eaK+GE4l2UPmonjDBl0yWMNh3BQtz1nabykKjYGKSdYzI9GAHgT9McHyQih2EJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLNXqNODIJMtKbNd2C5nI7s+Ktw1gIabyH2H/OkhpXNT9Oys06
	A6pRUxbzGs5dlcRH7nRJPon3pe8jQiJi6Y2O/hmhOBlHPf9+XGBPU3U1M17SfXcfYj3uLXQ+S7t
	ir5pPxftfeKqecWgGl48wJXeiRAXx8Us=
X-Gm-Gg: AeBDieu+qjQK7gOkTbrHxhiySBn+nRiONyK5uFmLdbkkpyfPpawKmn5sBpCc3PLBrXA
	VkNOynK1Ich+2CPkLdCG2PUL6cO/CgQ8Rn3vycG58mqMDNvNQ08JLneJtdt99rj3yAjeNdex70E
	AcWGo5tPakccfHBIhSPGLKEAw90qcOOR9QDrDg0HP7fT7Kx2xluJMY5UXjPHSoCP1/6ccVeU++d
	IVGvRVe5tphG+AxFyR0KZfDgtrH3JnxleAccSTK8CO8Rn0/H3zB7LFzTUb733KJubZDaLEMxNXE
	+rgeqUA=
X-Received: by 2002:a05:6512:3da2:b0:5a2:961a:f7c6 with SMTP id
 2adb3069b0e04-5a33758bb66mr7055339e87.39.1775692376378; Wed, 08 Apr 2026
 16:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com> <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
 <willemdebruijn.kernel.27ec47b22b23c@gmail.com> <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
 <willemdebruijn.kernel.1b49845d3acc7@gmail.com> <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
 <willemdebruijn.kernel.257654f9a3f23@gmail.com> <20264818422.Ya8u.martin.lau@linux.dev>
In-Reply-To: <20264818422.Ya8u.martin.lau@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 9 Apr 2026 07:52:19 +0800
X-Gm-Features: AQROBzBBag-aH8HRoy4mgE7UVgABT65YEnZ-i8qy9YgEHaGArFJoFmroKaqGPJQ
Message-ID: <CAL+tcoCSSBQYqj1+er2qMk_rCRJJ6qvKn9AQ4zcVj5hQjSCd0g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, willemb@google.com, martin.lau@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 2:13=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On Wed, Apr 08, 2026 at 11:15:09AM -0400, Willem de Bruijn wrote:
> > > Avoiding adding a new one makes the whole work extremely hard. I'm
> > > wondering since we have hwtstamp in shared info, why not add a
> > > software one for timestamping use? Then, we would support more
> > > different protocols in more different stages in a finer grain, which
> > > is a big coarse picture in my mind.
> >
> > I don't understand the need to store more data in the skb for BPF.

My take is that it's not for BPF only. BPF is an approach that achieves
network observability safely. The ultimate goal is to serve the
network area.

>
> Adding a field specific to bpf timestamping is not scalable.
> There will always be other bpf use cases that need to store
> something in a skb.
>
> There have been discussions about storing metadata for a skb which should
> solve the general bpf use cases.
>
> https://msgid.link/20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflar=
e.com/
> https://msgid.link/20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-10=
47878ed1b0@cloudflare.com/

I've been tracing this feature continuously since Jakub gave a talk in
netdev 0x19. We've discussed a bit there with the overall plan. Yes, in
theory, it works. But if we put it into practice, I totally have no idea.

In terms of the latest patchset, it doesn't meet my requirement:
1. in the stages below TCP stack, we're unable to read the timestamp
recorded in the orig skb.
2. it only serves the low rate flow, which is definitely not what I
expect. Please see the original verification from the cover letter:

"Rounding up to ~500 nsec per packet:

- at 100k pps, that's 5% of the 10 usec per-packet budget, but
- at 1 Mpps, that's already 50% of the budget, which is not acceptable.

While definitely not suitable for high-pps flows, the naive skb local
storage implementation is arguably acceptable at low rates, for example
when you need to attach metadata only to the first packet of a TCP/QUIC
connection or sample packets at very low rates for tracing."

As I replied to Willem, the look-up process is also very
time-consuming. It can be a temporary tool but not a always-on plan in
production.

Thanks,
Jason
