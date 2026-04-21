Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971C1DE2D3
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732976; cv=pass; b=qI2nQCFzYw9kxHxwaZbO9feXs6goplKzMgHbdgngV9sSlzAbUSzHn/KYiMrKfYNJoU6FtHmyHcNThfduMyAN2fzqHPjtWVJFNDqNR4uEWjv5epzWJJoFWne872BgkHkOmN3FCrp1JPoOsQHC4n8Gzn3TW4/CK+ctazRC/5l8CuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732976; c=relaxed/simple;
	bh=zw2Xj5D+twWP5EXNsOub/4MG7KCj0nY/wF4125mUPbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBo0tVPfiVTW4X/EgHdbU4zycKTwUBdJf71J2C1EoJA/vRXCD71LpiTAPvPtVs4Scyh8dME54zGObmZiPFlgFlLP8IMhLqt0R1iD6E846PazG/979xUasIszdrDHD91+0rRpOYgQDBz5QOctmYyrBlFBIezA7vGH26H8+jFXD58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXu1sbtq; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXu1sbtq"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a415fd6bceso4053135e87.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 17:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776732973; cv=none;
        d=google.com; s=arc-20240605;
        b=IsystM+zzSMoYWnxcZPWsbssdB2GZ0H1bH4Z3ALcxumIxbMuYImbxlCe+hUKg3Iv4A
         0U+/LPHBqTJ/Y8q3AvUXHDPXrPbnGuQD8A8hCjECGCXlAjkYkXNwgV1wFlas+L8SkmgM
         BFdMbdnocAzhxDlCReYkD6oVH0hiVd+C8hHYx92pl13jD0BiRP0J12hxN/an03jisIgG
         E26oC06KiRnhOYPijYy1pzwHuDfR4NrF2kekduA8NgxmUXW7KU2OuREtKtgI6aRtc3sy
         A2+b4ReYagPmh9nEXZQbhdXGBsKUvcG1qG8aWnaz/08ye+OrmuinTGqDS5xGpMPUjU1s
         9rvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AoAIhqfWg4zYslwqGY/uY8Cm3DteXSovXormgLKYPmk=;
        fh=ytsaIHd25lhCXJd5spO1T8VITFINf5gxJZHR+a8+f4U=;
        b=GdJuwlUXJhVC24/uNNcbcwWE2o24TqioGLPg5Zq1g4sWEewgFXE/C4AZD6DaF/OmkU
         8O9Z1b6L+kyAUS0txci7fjGnWv2MEUNnghWz7CStrmXo01Lb+r02DlnPoR2zIe2eL9Zo
         t/m9XcRgc3yJ7jfG4AMfTfyV7bcUo/bMf/V6NtMScj3l3pZ3p+NYnanWOeMu8PxllNRD
         0alLLkBljtKSB4q+FU2zuKCzIkvvIHY0UajCdMkRIPpkvCWWq5HxF8zkCiR/wDXFuRgQ
         qkznYYBCP5bDKAqkOYSY0I2H+TS0QnW3qXKsRxa4EamVIs2JNCGzjmJdKkoLkvN3PFjk
         Z9yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776732973; x=1777337773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoAIhqfWg4zYslwqGY/uY8Cm3DteXSovXormgLKYPmk=;
        b=hXu1sbtqx3ndnCMM3lTh409bO6WhNzsK2y9s5Ms1hMl7amLI+7MhINruBcwz4ULBMP
         TFMUWS7joufug/MgjOCEYGdNVkoF+ZAHFhMgDAVgrdJMAL38iNtjnjHFWNpPiOs0HEd1
         TOAJCarNOaCZseawJi2eI57vg3OjsFiAfJzHADCqi13EPPsksb3HiqksqSzUc+Pz8epz
         nzlv5bnBQZttUVrG0Lh+3HpX01MEtF7dKRo9D9NyUQEm7VwXaZLWubLH0BabXhyw38Dl
         nB4lHq1SYP4iT0YzXVYPO/hMBeJ+7eJXQqC6pqBV+ezphXgcdHoQhEo7o+5oJJR6uejJ
         kvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776732973; x=1777337773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AoAIhqfWg4zYslwqGY/uY8Cm3DteXSovXormgLKYPmk=;
        b=kLn5t63vaG4BsqtakUzjafC6Y4qHbf9dFRp431aAsmmXefzrfezmIWsnjlABDbDY5H
         NJBVIBtb5bjt8iD/6bEx9lJ8FUeBgymBbV9QIjaDs/jYeYxcmCa7RLeKkWOjnd2WQ7cF
         GQ2qabWeeBmvEPR9naISD3w/qAr1YTxsJ92CumvTmUOfhhr8tyPpeID8RuEBa6/onFRu
         mPflm3jGjrS9KFLt0FreubNIuB62m06TZGNU3akdg7YNGNsVqaHDTnOZw4xgrZYnPhE9
         +cCQl47tyHKSU2rd4T7X6YG32gxAAg6XRS0JI1btC2HL9tFVm5F962zo8M4gSMIcMST6
         oIDw==
X-Forwarded-Encrypted: i=1; AFNElJ9TTSCARACoc7vHjlePlFYviKysDiDXdPLAAxp3deROPYzYr/W3OEBGDUnpZ/Z9gki05G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHdKX3m6ITJOace/M/taHeobcjy2DnDJFPj69+By7K6HieUXuU
	LCzIS5TOSxlR0UgQjjUE3BlEaiXlq0LR4GnY30qqCtMBETGAupoGAdZR7eWZmzJg2R+c7WEkyb8
	hkK+4iPcHZs8/iaDpXSn73zTRFrfzVEU=
X-Gm-Gg: AeBDievS/d/wN9HL/rdb8d3tUL0wMDm+jg5xd2jw1oDhCNdt70FS2vZqaYFjl+KK5vQ
	nQbg6H21rVm1vqsXO7HWHSp9IHWRZ2s5PCJgEJzSrTypgcxq2JRW9arphG8c8bX8eY498lNXPHG
	UD14q7nW/+J4o3iiwRAxUB1lUHbq9uh758bbm4zhMvyasiNNuk9YFQAA7FvAXok72JxQ4Iyvv40
	CfoElrH96r8ROqdEuq70557O1ngn7PfRRxHK+XV9UPhDEwTc50yu3M8tTKwZc+BaLqTt0jJb5z3
	V8cHh2KEZo1J+YtFNg==
X-Received: by 2002:a05:6512:6c8:b0:5a4:d44:99f2 with SMTP id
 2adb3069b0e04-5a41717463fmr3847291e87.6.1776732972611; Mon, 20 Apr 2026
 17:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
 <20260418045644.28612-2-kerneljasonxing@gmail.com> <aeZEjZSsVIdpcbFF@devvm17672.vll0.facebook.com>
 <aeZI3ig6w0PhGaVU@devvm17672.vll0.facebook.com> <aeZTxgvr0mdIG-lK@devvm17672.vll0.facebook.com>
In-Reply-To: <aeZTxgvr0mdIG-lK@devvm17672.vll0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 08:55:33 +0800
X-Gm-Features: AQROBzAgjHPMaajXL1_HeA_ksrKRPIE2-9gIROGm-sBSmjqsSk1fMrPQjnwr3bI
Message-ID: <CAL+tcoDzydfky1B0pBoOoE+rVQQyQLTMs1ars7JinKO-JEr5Tg@mail.gmail.com>
Subject: Re: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 12:27=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 04/20, Stanislav Fomichev wrote:
> > On 04/20, Stanislav Fomichev wrote:
> > > On 04/18, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Fix it by explicitly adding kfree_skb() before returning back to it=
s
> > > > caller.
> > > >
> > > > How to reproduce it in virtio_net:
> > > > 1. the current skb is the first one (which means no frag and xs->sk=
b is
> > > >    NULL) and users enable metadata feature.
> > > > 2. xsk_skb_metadata() returns a error code.
> > > > 3. the caller xsk_build_skb() clears skb by using 'skb =3D NULL;'.
> > > > 4. there is no chance to free this skb anymore.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp=
.kernel.org/
> > > > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto sepa=
rate function")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > >
> > > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > Actually, I take that back.. While looking at patch 2 (which always
> > confuses me with that -EOVERFLOW handling), looks like we set
> > skb->destructor in xsk_skb_init_misc? So this kfree will do
> > xsk_cq_submit_addr_locked? Not sure that's what we want? Should we
> > move xsk_skb_init_misc to happen after xsk_skb_metadata?
>
> Ooops, looks like you already addressed these in v2? Let me look into
> that..

Thanks for the detailed check. To be frank, my mind sometimes went
blank while checking those complex paths...

Yep, let's discuss that there instead :)

Thanks,
Jason
