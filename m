Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA21339C632
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906040; cv=none; b=eRO9n4NhRyaThrYocg71EOgO1+39WSsgtB8z6nKtzcc2r/Fq3boXYnyfYD9oGy6hGLIlPgoC3PgIO4VMYTXIsbQbERHjm6sswKkFC6CZNmkMve0O1cNO+4SafZ98dHVN46jEcu5HlLjf8Ugcdnd4Itd/YO6fCwpY8hIm+920mXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906040; c=relaxed/simple;
	bh=7p3nTq7oGJJLZEtBHFjP4g2fj9ud/Z4fq7Xd0f8dF48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxpqkZgNgCWbBBCO9at2tF99bboUzurJFM+XQBptIv5C51mNgBnTw349fDf1whtZ1tzS/5hb5jkYYiGTmNTLprLmdCBnl159bXr5+chJLUQz/KsbS1Mv0Yg1VUJL7bj+F2mptFAOyPde7WwezicClqOLRT1Cd37raltuKurNV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W224uC4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W224uC4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698D11F00899
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 08:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780906037;
	bh=7p3nTq7oGJJLZEtBHFjP4g2fj9ud/Z4fq7Xd0f8dF48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W224uC4/IesJ34nuGEK+bZHPRAWeHalBbhvVaG3G77FpiSk+P8FmAM4KSth5/Zw6w
	 L13BquVoXpaByhyynZxt7GPU3AtAhGunIkXPNSFx3YiuS0/1CNLiwwuQj8q0mLPJoH
	 mc5nMCfL/id94JmzJB+LonJwSB2TNbYbx+zME9Z9TRPqfykSaTXwio7ErKUz/VvjvU
	 9wrPsC0Di2YZZQoONx0IKIcxFfo7+ck0eL9OFSazszKoJpmUP7QFdp911LcKlJe99I
	 g4TYxqSMC1Jl0PopCrS7zm8ggyKQ4c4sqCmK3JCgJACt9c1z/xa8OdOFMb9uT0YD1z
	 wV4SQYMmT3UVg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3965adfd75fso35708261fa.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 01:07:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/1PnEYFaclQMXa1yjOO7jggApvT3OOLyO9msPNohQDIzESwcgXWWJ4wKDbe4zma4muYGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+o1FCNZFcJ355DJ48I0tEQgvynb5/olUE6AuV0ltbBCimzpX
	8Hk87E5wlUvpRl4XrX50KaqSyz5DBWqmuK4KMgSQOZdQ2HHJMYsYDkQuHYQ52ttasdtu6/t5WA0
	2I5Yl/3kkNoJ8RBGpQxtQiktokraz5l4=
X-Received: by 2002:a2e:9a16:0:b0:396:a6d3:f04d with SMTP id
 38308e7fff4ca-396d0895474mr40010161fa.14.1780906035688; Mon, 08 Jun 2026
 01:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605010022.968612-1-elder@riscstar.com> <20260605010022.968612-3-elder@riscstar.com>
In-Reply-To: <20260605010022.968612-3-elder@riscstar.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 8 Jun 2026 10:07:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLnzaq+SghqjQhmS-wzJn8BqtpO9eFBet-Nvq1s6ftSPBA@mail.gmail.com>
X-Gm-Features: AVVi8CdcVQZ5J_i_Iaqeix6_8YO_cjEHpzPIFDPmZBuvgJ3k-aHEuVOqwusuDcs
Message-ID: <CAD++jLnzaq+SghqjQhmS-wzJn8BqtpO9eFBet-Nvq1s6ftSPBA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/14] net: phy: qcom: qca808x: Add regulator management
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com, 
	rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, brgl@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, 
	Daniel Thompson <daniel@riscstar.com>, mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com, 
	alexandre.torgue@foss.st.com, ast@kernel.org, boon.khai.ng@altera.com, 
	chenchuangyu@xiaomi.com, chenhuacai@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, hkallweit1@gmail.com, inochiama@gmail.com, 
	john.fastabend@gmail.com, julianbraha@gmail.com, livelycarpet87@gmail.com, 
	mcoquelin.stm32@gmail.com, me@ziyao.cc, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com, 
	rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn, 
	weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex/Daniel,

thanks for your patch!

On Fri, Jun 5, 2026 at 3:00=E2=80=AFAM Alex Elder <elder@riscstar.com> wrot=
e:

> From: Daniel Thompson <daniel@riscstar.com>
>
> QCA8081 appears in embedded board designs paired with GPIO controlled
> regulators for its power rails. Add logic to allow these regulators to
> be turned on during a probe.
>
> In order to avoid the complexity of tracking state for suspend with and
> without WoL we take a tremendously simple "always-on" approach to
> regulator management, essentially relying on BMCR_PDOWN to conserve
> power when the phy device exists.
>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

(...)

> +#ifdef CONFIG_OF

Is this an extremely footprint-sensitive system?

Regulators provide small stubs if unused, I don't know if they
compile to zero bytes but this ifdeffery should normally not be
necessary, just unconditionally get_enable the regulators.

Yours,
Linus Walleij
