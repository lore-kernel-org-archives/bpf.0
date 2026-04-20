Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B822147F9
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776724887; cv=none; b=QEiXWQJrYoCb0IwgMh4Wf8bN59wr80PP5WhPV+FQWU5eixFBUj6jc8wHca2lfKd64aTPdt5kjswKNHekZCYRw91fEgSkXse5Rvix5QWb6OKePQS1CU/1a5bHI5MUoUWdGrGv1J0gEZUdQ9Q+wEr0pN+7GpUsOg9rU2cGGaKpgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776724887; c=relaxed/simple;
	bh=8JTUYLp4c0/mZiYFwbA9+5xl3HTe7go6PAo4jEdOYtA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zizzr/277um7eWWM1Zf+C+lax+lUAdMwOktkQ0uaHCDhUxOBcadln6paTIQdzile6bTgSqjL4oBw8cf8lA/B8/VGnXbeaFo4ZvIFwAJAkkcoObvnzZEjyKCR952ht/85qJoncOEUM7gvpkhF1TuVlmLf71Q5GxpCz8/+gvlM9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+GXh1W8; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+GXh1W8"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d891442388so5116907eec.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776724885; x=1777329685; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8JTUYLp4c0/mZiYFwbA9+5xl3HTe7go6PAo4jEdOYtA=;
        b=S+GXh1W8ckq8EpDQeUkIYS6QXijRIZkjZeZboHMrxm0j+/zWM/eZrmtiNrgMEhwsmR
         d/9bqXvawqUkDvq19d2WigorUQYvNonvx/c/SNM3cPS4R3VNxKRB35EZj5odByAusagR
         WkQ2+L5iWkwyKYW11sV+sHKQug76cmCqOfaz3dhBUV/S4sCEFXPZNfCLgNtC4OjvNPIG
         xHUBdmYe0zhqvh0qfk4JIGV/1m8U+tfSPcX+LvyT9iZtX8lblb86EWkHHoBRHEG4grNa
         0XAl1TXZi3blslGzBiE/Cj5QfaHn/IuNq9Uyk+E9D5UWluv6iX7dw9POTHP3d21NTI/w
         y9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776724885; x=1777329685;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JTUYLp4c0/mZiYFwbA9+5xl3HTe7go6PAo4jEdOYtA=;
        b=VzLPEDhWwn1acL+BFVjo72cjaOyJ7bA1OnIMzMJk20Ft12TLRtaXiEUJRO5oMmFVjl
         3/WJfh4LiKPUcgpVK/VxkGZ8m3vgrarHefn/eQPzAxMVG+F+gBnlXb+1xUBsHQC6YTYM
         dP4nXXsFIxcAh8VpIh8z6knhiBQlz0V1tOou/JyuYArEIUIccrFBfxBAMdtdBuWND9dH
         Du9sK709i9+QHbyE3bSLPMpgFMdPm8T7SEH2Uh2lD14cc8Vj6HuUqkNXZNCRI0HtDrxY
         myvqo/MLNQZBnwzz1rKV7SKJf2K2vzVrps3OUO8NrWt7a2wuNbLbgado6UNIhUmYODmT
         QHIw==
X-Gm-Message-State: AOJu0Yz3//MglYNLY4a+lfaT/me+aBcn2Nrei9iDLs4wwRWzKCAYEQcc
	L7DoL1fOQrtr/2+gbfAAhGGbQ4V+XquBmOkUznjlnrE7ob0Frm7azWPJ
X-Gm-Gg: AeBDievrGzOPPCoxblEVeGXV7irkY++xsodgLsjfc0JhhjMrhjRDQf/m1N4AqmI170m
	qM0rDYp5UfzkMXRHnbRUo2gN4djJBdp7A//R786vvqRtU0q8KllZzJuNBsFBrOMhDzPfhEhPI0a
	4pgu6TS+KMLMf+h/b/uN1Q3mWBiXAg0jK83ILthOqhUT+zzynMfh55jBe9wKLFPX2ShDGqPK2lc
	WI2YiqXkVIWd3J73RATLta1VHLozTA7Nla8emnunOW7mWLwYqUCSb0x8NGdm33rbEYRucIbnsWa
	aZqq+fZOGiqxuVWnAC/t6HGbCER2+7nyKjhmE36hN7P90t1WvDKEigqoEtobdH4R/RlHJvflYX8
	eFu+CwBd9cIkfKZUx1bEhqMDmG6IpsTrTfYdyJT7UVlPp5vQeMubcERWye7mT2KVa7UaVnXRKMz
	nqe+lxZbNtdei0+KG3esjvA7o2AyTyTwoM2cyM4ivB8VkLlicXwxUlomHoK8+ran3SBXpED7c4b
	kgHqQ+INrRF24VW8VE=
X-Received: by 2002:a05:7300:748f:b0:2cc:600d:2ffa with SMTP id 5a478bee46e88-2e4788392c3mr7835887eec.16.1776724884773;
        Mon, 20 Apr 2026 15:41:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3def:75fe:cbcb:86a8? ([2620:10d:c090:500::3:5edd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfc1dsm15949305eec.22.2026.04.20.15.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 15:41:24 -0700 (PDT)
Message-ID: <b44b4b9333cc099882c919145306381ab01d747c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/verifier: Use intersection checks when
 simulating to detect dead branches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Paul
 Chaignon	 <paul.chaignon@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Mon, 20 Apr 2026 15:41:22 -0700
In-Reply-To: <CAM=Ch079=-6advVJAaEv8U5-N3_nZY39qf_5c7s0krU02oEa7A@mail.gmail.com>
References: <20260415160728.657270-1-harishankar.vishwanathan@gmail.com>
	 <20260415160728.657270-2-harishankar.vishwanathan@gmail.com>
	 <2ec3db2d2960d9c13577d630306f16873ebb53e5.camel@gmail.com>
	 <CAM=Ch05O+m3gAAz=EW=ZPrhnTMrrMJ51ryMkwROnfkBMVVxnaw@mail.gmail.com>
	 <f79d58337ec3628a52d41a09e2c35e598ab656f4.camel@gmail.com>
	 <CAM=Ch07jcncdAA1D-uh66OuVXnROF72k8gunJy2cSMuvJNP+nw@mail.gmail.com>
	 <f622c0166e9c1809184673c1bffda7e43ae495ea.camel@gmail.com>
	 <ea37be7028d20e962816ff10631da383b5910c57.camel@gmail.com>
	 <CAM=Ch04tB7sXD_qmK-5NZ-aQZutJ6bYmciU+hzZZ8yJx-hbwLg@mail.gmail.com>
	 <aa9704461f816bb90e2648d7ed2ed40268d63215.camel@gmail.com>
	 <CAM=Ch079=-6advVJAaEv8U5-N3_nZY39qf_5c7s0krU02oEa7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-04-20 at 18:35 -0400, Harishankar Vishwanathan wrote:
> On Fri, Apr 17, 2026 at 8:45=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Fri, 2026-04-17 at 20:38 -0400, Harishankar Vishwanathan wrote:
> > > On Fri, Apr 17, 2026 at 7:19=E2=80=AFPM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >=20
> > > > On Fri, 2026-04-17 at 14:17 -0700, Eduard Zingerman wrote:
> > > > > On Fri, 2026-04-17 at 01:34 -0400, Harishankar Vishwanathan wrote=
:
> > > > >=20
> > > [...]
> > > >=20
>=20
> > Thank you for sharing the code. Indeed very similar logic.
> > I was under impression that you don't like the witness idea hence
> > proceeded on my own. Would have deferred to you if not for that.
>=20
> I suppose I didn't look at it like "witness generation", but rather an
> "allwise intersection exists". Turns out of course, that both ideas
> are essentially similar. Also figured I should finish verifying and then
> share my implementation.
>=20
> > Tbh, my version looks a bit shorter/simpler.
>=20
> Agree yours is shorter. But I found the individual
> computations in my implementation easier to follow.

find_witness_aux() might be a bit packed, but I like the successive
subdivision into cases more than ranges accumulation into array.

> [...]
>=20
> I can follow up with a v2, which includes ideas from both, probably close=
r
> to your version.

Sure, please follow-up.
