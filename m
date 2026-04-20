Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093DC19DF62
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776724573; cv=pass; b=dcJj5YBfTjpK830KkT/Sw8E6Cdrc4FZ+wpWh82YDk2WmafNqHG091WBv9O7Ajn531uoJvrx4QfM1ayLKQK8JQXUwEvmU5R1DDT3e1soaV0Z9cos47IjOl4Lnlco+n6HJMuhlYR/c1MsM8Cd1AQVN3coQGjyNVCaHqfqs0DA4Jlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776724573; c=relaxed/simple;
	bh=nsrf+l859U97/oegPjIgl+SnfRRX3XtNvMQvmqqUOPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4afwU3PR8lYicvgYeo/YYcbaQaFgoeanrS8/yHSUqNd4GLvwhaJiNqOA0KDbDyRvBjU32j54pgEffvbGaA8P1G+aSRvhNYyjTyGx1AUU0WxTcIAKpZ1raHnNqfQx5PLAYwrknSC5ucRggVw5XAIap0gPr4CQoYWEzuUufVxyes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/AZL6jW; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/AZL6jW"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9540bb77b1aso2078159241.1
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776724571; cv=none;
        d=google.com; s=arc-20240605;
        b=H9X7GyD3qKv8V+AhFe0AtNn/0jPKnpQekXCM9+3c3IYpWUg9o32eg69aEaQ1wD9/+x
         UIL27ezd8XaZpuAYfjuXhjOLYlUWRuIfx0O87Dsmf2aoBptDLdt9ygf63/TicRst+y6Q
         ec1gWJa76URYJ5Ld6lyFiWu7ehUnJkVomryd5riX9ouFQAixfbdFPaUFJhmM+dxetyYf
         Zhqu/DmAoPbY/QCiczTAeHq7Ie/9U+aZBBGNb+rR8YNyIdT87eOeLyzSACMNzHLI7zR2
         Zof9iH6aSCH/I3724+joQNdgLOxfZgEMlymVSkMkWBDMlhneWWq3rE5oj8amQ2D7e1ge
         4U0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nsrf+l859U97/oegPjIgl+SnfRRX3XtNvMQvmqqUOPc=;
        fh=ypw/5fet4CANHeQUz+kfgabEvSoH35hHHOlcI8B0sBI=;
        b=SIlngy23qAySENaPY9nymVONgB7A/RleszoipmPjCGoR9Y2qQomaTxVJvQkxjgPawW
         i8om7U8T7ynn4QGNQKNLEhLwoG3ePBNxkPzJupEMaKBDTYwJlXwx4rfdB6PlFjxHSTmH
         6QvHBcT+ihT9JDSiKR3MT3OhuVq4Fp1joKEIjaLLB68vHTu1yvUDVwzaZJpxO7SOnavY
         +ezb2biHdqzpSqASjFtT5kyOSqqSMu+WLE8VkOqS0HedWpn9ABxEbNQdL7za73GyKWlr
         JNhy2smhR6ujKFeKnasOpRVQ8E+qLO7Lq0zXENmrbaKbDLgGVZ3NXzULyq+fDeVgnVUH
         GODg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776724571; x=1777329371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsrf+l859U97/oegPjIgl+SnfRRX3XtNvMQvmqqUOPc=;
        b=I/AZL6jW3tfzyMt0HpF7p3x1JcTDRrZOdZ/MbkhjBTMxKtXyHIH277Q8WOpvR3EEuP
         4vq1exO1LPt01XDEHAXdPNwFyXou7oQkkT75aO/SKgYzZpa5XUlCQHh9ZGbQfKQgNSuJ
         7EnX0MQyPzrrrVyYCuCY2PL278Q9zoS0j/61h1BbWSAeyjiUsZigsq6iyqY9FNpqbdby
         GpR4wn65Rj/MsJLf842bL+w6Rh4P2WiC/ZciLMJiG3C1TdwWJSmRplP+pPV/KGDafr+R
         /niWmpgI//+yw6ppDy87qvsndx3pk209rCMyHsHiLCWEfQYZ0jREqtfIqVZzb9hVq6HV
         o3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776724571; x=1777329371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nsrf+l859U97/oegPjIgl+SnfRRX3XtNvMQvmqqUOPc=;
        b=rv1OteAMdLpJMJ3n6QBxc0G47z5ctdlE869M/fys14VZfiGZgBPzm+ekgi8dEhBQMG
         0QD7L0K2Y7gwzaocPmyKZJPAvBh0mlw7IMA/7AnO8GDXKYqvMA17s1H2xm2hkY7FEos+
         kfFJ+RIiQzUBOBXzCN0JEqLMKOC92lF+rMMCHs9R0y4WzViN+KCTxlJh8mcAbdZz25fU
         S7VSOzQ7tzqTOFmyPxFOegQfYkLuzZ2nTELqdzqtyh+66x8cJ9OcSZVQlmoGAC2+QDrW
         QbxIQdrse6Do7Q7zk45bpqzq3dc58O2L5m/Ohm+rfT3p8k1sdFCn4ieVi2PJvAZSTBYB
         +Y/g==
X-Gm-Message-State: AOJu0Yzu/42NOTVzXyuNvnomz4HiipxJRSVrNsTrMRTRUERkSJ9rSF5U
	QnKQe3Fmnf/7VPsdpBC0il4ieE+uzc2RBHUeZa0P70zYZg3QD63AueCDX2uHrIgEBC+r9CiL7o2
	neueePJify9rZG49EQs4dC304kpSH25s=
X-Gm-Gg: AeBDievj+E4mcl0R/Sl5zlnrwuOAmxFksGUHudImRzdT9EpcdrR7kIyCD8FM0MAEycO
	hkT2SESLNhCQi2tRbrX7sftpAjN2uVjCwSuw83jUPM6GdG6Axmit35mE2stnbmRCN+KN3cUSN62
	0vL5iEVLBdpoDfR0zxLurP6bsDl15KJRiSn1f9spG2BBtAw2dD8b2/oE91Qse2hEKIhK2TRDCcZ
	s4cJLWgCs53+Z/tuUo5gwRsNODnj4FsJL4LDfz1otcxIPX3PfTDRHFGlzVhjsGXTuoP5PueTc5l
	TQGT64vabrKnaCMr4/wWV5CFL2BgOgcgkfMNdDTQQZ3B3Rf5rdI=
X-Received: by 2002:a67:e7c1:0:b0:5ff:b8d8:b40b with SMTP id
 ada2fe7eead31-616f4e77343mr7933004137.11.1776724570822; Mon, 20 Apr 2026
 15:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
 <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
 <CAM=Ch07jcncdAA1D-uh66OuVXnROF72k8gunJy2cSMuvJNP+nw@mail.gmail.com>
 <f622c0166e9c1809184673c1bffda7e43ae495ea.camel@gmail.com>
 <ea37be7028d20e962816ff10631da383b5910c57.camel@gmail.com>
 <CAM=Ch04tB7sXD_qmK-5NZ-aQZutJ6bYmciU+hzZZ8yJx-hbwLg@mail.gmail.com> <aa9704461f816bb90e2648d7ed2ed40268d63215.camel@gmail.com>
In-Reply-To: <aa9704461f816bb90e2648d7ed2ed40268d63215.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Mon, 20 Apr 2026 18:35:53 -0400
X-Gm-Features: AQROBzDvgg_3CP5MFQrKWb6sOKxG80Ok0Knojoq-yUcNjaJ4SYM-roiUoid3HNU
Message-ID: <CAM=Ch079=-6advVJAaEv8U5-N3_nZY39qf_5c7s0krU02oEa7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Srinivas Narayana <srinivas.narayana@rutgers.edu>, 
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 8:45=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-04-17 at 20:38 -0400, Harishankar Vishwanathan wrote:
> > On Fri, Apr 17, 2026 at 7:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Fri, 2026-04-17 at 14:17 -0700, Eduard Zingerman wrote:
> > > > On Fri, 2026-04-17 at 01:34 -0400, Harishankar Vishwanathan wrote:
> > > >
> > [...]
> > >

> Thank you for sharing the code. Indeed very similar logic.
> I was under impression that you don't like the witness idea hence
> proceeded on my own. Would have deferred to you if not for that.

I suppose I didn't look at it like "witness generation", but rather an
"allwise intersection exists". Turns out of course, that both ideas
are essentially similar. Also figured I should finish verifying and then
share my implementation.

> Tbh, my version looks a bit shorter/simpler.

Agree yours is shorter. But I found the individual
computations in my implementation easier to follow.

[...]

I can follow up with a v2, which includes ideas from both, probably closer
to your version.
