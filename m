Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80D4369A
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780278173; cv=pass; b=K9ifx5dncZ1qhBRy3RjRF4NhlEHlSZ/D4g3GIAs4YSCwKeJ2ymDrwZ40IGSHvpxcclzJzykD+a53S8TYpSGP73W6cfLqLd5FhF3zWabQKvg+1ZEEy0mKqG81+KhlLqQktSDuGfc/NAvQBwQou9nJ42UjN/TLICFz6s2OCJUO3lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780278173; c=relaxed/simple;
	bh=1SQw3rHHmwJUM/B/fNJMq+S/nMdmh2BRJEnqOmPw2as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDK5/PtR2mYAUC+ps0XUQpE3YcXFDcxXRiHTnM5RDA9zaUq2JBrN9C2YDm6ZHoSAbAUGiM35OBsmHAQOf/pCfZfXH59YckE7abyAPmwqP0vB2io6k8uh1EdIqV+BsMhQlJp0hLQqj3m1IdV0Iur1nvWJpkWJXzxWrhH2fHwnGBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdXvrHXG; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdXvrHXG"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so824092f8f.0
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 18:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780278170; cv=none;
        d=google.com; s=arc-20240605;
        b=H/d1NMFx+hG2wqo84RMax0IWeriEJGXuSbnG8N/aHvJuH9oV09z8i3hsKD8DX4+0mv
         +9vbwAvFTvN4t64dzU13g0nrq8JJchi2kp2cy8qf1u3HypnDD8BjqshUCSpgRhBlnIeA
         F1Mj/wuSRX4EVNaXI9KjOc8XKRqArFBL+i/ISCSZGw23azUUOJqI28Hi3X5yllwScQUf
         LwOnJ7sLA0mV1+RX3DD9olksaZbJDvgnr/AL8BVfRm39RnINeR8Lm21B2/MhKfz34bvf
         suCtX1ykbwQkKYGG3zxq4TjR85290kN5gxoT56Hv7veDWlWLLFjqGoNeMpupftm/4R3v
         rM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fI9AGBHWrCu/vWdIzq4GOSmcoyxsFLE6j/7qelnpJcI=;
        fh=n+CFhUxPc2M2/wbvXX8s5niLFzTAK2LP9rvtwhlHEkQ=;
        b=BfWD4x0PVeavNkvjBRgCqrXSNtETf6BnjiDcojn8xkaZeqClmYgoZ27R6b9Hcwn2mO
         hvNOoRkjOC4qzJ9ixfpTzWqflIO5AZAqVNHiwue1vHLr+berIo1vYoL3EHozM9RlNHTs
         Kv+wx3NaZjUg+q4fikh5TAwodu7Bp1tlZ+XON1/IO//DoW5smXvivsEs0nebWtpul4H8
         2mF2UvZKf465kLPxAT4HTW9RTaRsz/VcSRtouy8G5dXHDfsJAgcsF1GevHNUPccIyvLE
         N9Zzow4CmlI/9mhX+rsTiMxzxK3Fdgx0SWSg16/3XdloBj7PC+iZxRSBrrx23U90n161
         t0Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780278170; x=1780882970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fI9AGBHWrCu/vWdIzq4GOSmcoyxsFLE6j/7qelnpJcI=;
        b=cdXvrHXG/GZjnDDOA9uUrJbSiKS/nq6dRpO7y+NnnE+xYbcu+GyoKlvGQp/dcG4VKb
         Zd6QVc9VzkQ3bPQNqh7KQMckS677FGduTHjVsJ4lca12X2Df0qt9NdlZFB+xaDdE8Rrm
         FKzltMp6wF+Yv+sB1Ghs3SwxLla+dDpSt7Ptldg6Y4/ZIC/GmaTMa2SscMrJYnlnDrjr
         zCnIT7Fb+bT39xYS9cPC5vMItjdkkygbg3hZn4zN7NnO45g4p8t/Fd624xpsjbuudxzU
         1ViwBzfPzUqx7U8xdYPouEsKp9IxepTmpDk2uqyaN/iXMbSMDTsyJtA5lsWkK674Fbmk
         kWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780278170; x=1780882970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fI9AGBHWrCu/vWdIzq4GOSmcoyxsFLE6j/7qelnpJcI=;
        b=T0MxBidiFGWsc1+Rm79GjzyPAnuw1c4YA/eqq9wKnNd3SCnxomp1IUJXpFYkWCA3KD
         PG+Qlskpn33di3SKiAWIycbJ9A6dpcbu7UWqMO8mgYBUsQ9ovm2HUpYu46Xje1o+j/7N
         rShKxk7IXbO3UU/+yl2UDgVj/Fc99vt0MLj12miOUD5kwIX5TniAlR+a0jr/fgvonSfh
         i9RleB8tgVH4CXNael3u3Jz0qnzX+o8QFbXa5ZQVzrHZmRB+RH/ZsP7RSCTWjilL+cUy
         9Q4WO3UXlt6L6ppopuJi4VkpRdG6nYIglFNo3+2bksxMY9qYRph9rgape60GS2DmroCN
         FKMQ==
X-Gm-Message-State: AOJu0YyoHQdxHT/RXjgnwkMw2w1lg9ULp7awCH7Fxyt1cVj77mnnRK4u
	eHYQX9U+QBsL6rEh0ju5FqoDorRUkwZBoqxi9fVCfHbWuHAweQUnMW/FfPvBmoKtvCng1jP0AgN
	LJreVg9PjYE/3MxHyGZTIqYCSkNdwgx/oJg==
X-Gm-Gg: Acq92OEK+bpzbqns556bVdh9Hs7DMbG4cAW2Shq94ZsRz6IaM/OHgPV0b6mmWycAmIE
	2Vf9CzOCqK6TI99N0Gc49TxZF+L4P0o9PXe+rtyMLenML+aU8mYPdx9v4fu3nM2XjMYbXBcPn83
	YSNK6wzUaA++xD0bq9Feuf5wgNmaqFio2BJoeIYGJC70CdWqjp4cRcGhS+lEDWHfnME8U85GwJW
	NFyxqEZVYWBNBFtR1WBdSzJZ3w92hlRaCz7SEaZa6LvCDlH/5LBWUiGtUi5oMMZ/U6EPoZrBzSH
	tEbKWRem7ZII9wdmbgkZrSRTF2Yd03DSg8ofxnA9cSRXMMRVk6grdcR7GSFH2Tpmxrrd2ADgirg
	bY8nG
X-Received: by 2002:a05:6000:5c3:b0:45e:fa4c:47c8 with SMTP id
 ffacd0b85a97d-45efa4c4bbbmr13291146f8f.27.1780278169823; Sun, 31 May 2026
 18:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523160025.16363-2-paul@paul-moore.com> <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
 <CAADnVQ+WTfgO636GqgxzJ6r=jENpG704kmNAsy-X8=WyjMOV+g@mail.gmail.com>
 <19e55c1c1f0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com> <CAADnVQ+JDtc_GdxCv6tWAT03k85PTc0+zdcpCQ6NU-T8yJcu0A@mail.gmail.com>
In-Reply-To: <CAADnVQ+JDtc_GdxCv6tWAT03k85PTc0+zdcpCQ6NU-T8yJcu0A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 May 2026 18:42:38 -0700
X-Gm-Features: AVHnY4KyQFn04X4dWlQGyHLkT-INPicXgTz14ihkeRdjdGaPQttUsvgaZ_6DhR0
Message-ID: <CAADnVQKwxeunxW3iedoaquGAEvO+2jO5fpgbvxMGW_UvWzpdJw@mail.gmail.com>
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
To: Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 10:19=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, May 23, 2026 at 6:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On May 23, 2026 11:25:55 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Sat, May 23, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > >> On Sat, May 23, 2026 at 12:00=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > >>>
> > >>> If security_bpf_prog_load() fails there is no need to call into
> > >>> security_bpf_prog_free() as the LSM will handle the cleanup of any =
partial
> > >>> LSM state before returning to the caller with an error.  Thankfully=
 this
> > >>> isn't an issue with any of the existing code as the LSMs which curr=
ently
> > >>> provide BPF hook callback implementations don't allocate any intern=
al
> > >>> state, but this is something we want to fix for potential future us=
ers.
> > >>>
> > >>> Cc: bpf@vger.kernel.org
> > >>> Cc: linux-security-module@vger.kernel.org
> > >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> > >>> ---
> > >>> kernel/bpf/syscall.c | 4 +---
> > >>> 1 file changed, 1 insertion(+), 3 deletions(-)
> > >>
> > >> Alexei, I'm assuming you would prefer to take this via the BPF tree?
> > >
> > > Paul, I see that you're intentionally trying to piss me off.
> > > It's not going to work :)
> >
> > I promise you that is not the case. I was looking at the sashiko result=
s of
> > the latest Hornet patch and it identified this potential issue in the e=
rror
> > handling code that is an issue independent of Hornet. I posted the quic=
k
> > little patch above to fix the issue, and since the diffstat is solely i=
n
> > kernel/bpf/syscall.c I figured you would want to merge it via the BPF t=
ree;
> > if that is not the case let me know.
>
> It's in a queue. You can monitor it here:
> https://patchwork.kernel.org/project/netdevbpf/list/?series=3D&submitter=
=3D&state=3D&q=3D&archive=3D&delegate=3D121173
>
> But please be advised that when submitters ignore issues
> found by bots and maintainers agree with bot findings
> we mark patches as changes requested.

Applied.
