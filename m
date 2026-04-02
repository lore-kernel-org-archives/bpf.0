Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2D337BAC
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 03:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098842; cv=pass; b=A446BDSNyy8x8wBj7jGr4HU9Q3fhZ/I5q6+uRcAmsv30Xu/J+Hm6H/SzdiRuvyh/bgxS4m3VPax5ZHOO0BZZOmwhIT7hvd4p+jJa0GYPvKYOyQfwGqT9x3HqaLK4ryqBOWegg3J8dpzALw09Coe7E/CfNKHpwOdLy4wg6VWUXSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098842; c=relaxed/simple;
	bh=CNPMcXH9bQrkBYm0DFBaOpbt5zLb2GTtB3JsKV3XdzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APL0kddsZZ4g9HoRjSat5o2vnZHO8+NNq6+QsbTihRRQ3C9GCT1QUWC9XGg+i+3iaZ0r+HVP/pkeuB50DO+lpqLLQybQ/BS0Fdlg8tXZ7WgQ8bu15ESLGslXviFirEeaQ/JW3+je5xJc5ZBwhXukbr9jyDgMRzzGObcS97DfB2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPKvcBnN; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPKvcBnN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf906b007so236692f8f.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 20:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775098840; cv=none;
        d=google.com; s=arc-20240605;
        b=PqbcAQVdLT22OKRrjNIqX1EASbNMSd3CLTPhvU/+B+jHoB4VJUdR1q8tAU4qF0se02
         S5E2cjsGFeCMLHd09xx4RDa439sWhwo+OFXSEQCVpLoSSTMSS4eRd6UfhiahWFPqjNS2
         hX2qeDwIllfs9f1TdnL3YhUY/h+MAwYQBaN+vVIuqaqDHwnbqSHxJbJ1P0WZ6c32sz3q
         jMXSHiqCZua3JpuuDwDtahmrP9Z6IMsfIm02qKWQ1sW3wB6cW1UOeWZvhL4O338AubAG
         VVPl/1fR0m0kZGY8LKSSmi/3Y7j+kYb4aDYUwiUTXUOK3BSGbj/VNR+MMcV6o4L3RHWp
         3RzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8xXFGC3ovmFxjAoqNo+IKF1giyX6Hr6O+DNGW2oahsQ=;
        fh=UcZqnkcPYPCJuBeofOOObWQTYZ2DVO/Q2yzEycpMUlQ=;
        b=Rl43DF8fZ6QxJC3kgKfK+uW2bv6BwvKz328E9okfc8k1QqwwZINK960nvfp/dvjqvf
         5u/qrfDErYsk0DVFB9PI18zqBxgf5C19tI/ntQ0INqMrBbvSRbhFwIqNmwphdTpejkEx
         1PoS8qtZazwdivdp6scV9b9wUehUELwrk1qwJy8rC8QPKo4ZLVJz9Cumn3WiTmR3Xf8Q
         /SL6LBmY7pc2wd1Ha/71g9HZK+wD8XMkgzMvN0raSSa3s1ZX0cJ5vN1eCK/vK+/MkiZ/
         pQ39pIUSFVaiLYCOgtZ4CnnDGk1uzSCIi9Oor9bH3p5yHUxykGd8i2Zzc7srISYx3Xyv
         asUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775098840; x=1775703640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xXFGC3ovmFxjAoqNo+IKF1giyX6Hr6O+DNGW2oahsQ=;
        b=BPKvcBnN4yXx37ce8ROu/p78gVZ16/iS4QZhZghehX5LuBIgs4iUetbLeQPE0V6dsQ
         zYtMyRDDUsLHhv/NuWfRZoDff3LbJCEBxduTA7ktIl8LlaG99TKdB+2KDvsClJzG4NFo
         p8ZEeYvNXbqRS3Mo4MvgjcTlAOafkOLdehUZJSVJf5I5xfjzZrW0TcihCSQvdwJBFeps
         m0TXRHoI7lTYUbWaV+MCzImypvFOO/9ueDJwiczVAAS5hnHoxiBT8ZbzXDIdKz+wSvmK
         +R3uKGBabQ01NH3llH6r/nk/CpHlaa73Ah92/BIkJGN0kI24GjQAfkqAEtJ3eVTiZRFL
         6rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775098840; x=1775703640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8xXFGC3ovmFxjAoqNo+IKF1giyX6Hr6O+DNGW2oahsQ=;
        b=UJHFZprIsMMBveoO4lxWUXZeWwhQcyQmW7GaGU7I5u9pbZ50wgJkTrqoM3HA2OmteW
         dYMRN4ju0xtZfHeExYKagMGyMN4KoNpJINPG62EA74YE/1t3b3IWO2OkKW6nbt5327Ok
         f+usu/aFV3IFJqO5Z2F/a1iBv4Oz6NcGrJOrcWm+uCPwnTKBEJJEPfq5Q4dC5R59UWWf
         ukCZ0g2Ogr8eRhOrvqg871G4I1HC48e5DdQHbdBqXcBRVzonJqB9U4AU0r+FsT/u6fMw
         mXD/uRBP1cpS6DxWVzdpLTml5adjFHCC8J/5+FPqZ2oCDVK4kPDT2dxLlG5E39PuK3uH
         txwQ==
X-Gm-Message-State: AOJu0YwtkQDjf4+88nfB2aeXsDhzQa7yQYCiMc34bh2MLy36en1t1SGk
	MwSepg6smmsR/3Hr0yPtEuiCVuMucPj+v80/8tAVxDMRPrn+BqBMz77pDTi6vuXPujVjX21GsCT
	4Mzrvs3OeoN+o77zy64pF/KtWLLUUL+mSxcXQ
X-Gm-Gg: ATEYQzwgTRbTLk7WkaDi40MaQlvMI45vVCDoj4g8OrAjVCaZJsLMA2V/rK0eH+nzxx/
	eYeyshO1lN57EsQ9TJU93pE8/NhpZU7UPRRTp+oG5WACEt2JGJcrAlLmU7QCvySQSBQ/7rYZnJC
	YmruXipzjJr2aXDvJndT0u4qjxfSCzk23m3FSlEwIkItljTUYDJ/+uS6C/KpcKPZALDVu8nXNem
	LEMnCOm7AbU1yctBt8+vJvjhCiYvf0346COJvEAU32kG59Fdd57BD+yd57o1I22I0a1xXKPbx8X
	Kr4dSxwtzlTQrSKDqC4NpDRX++OwVFJ0KAiY1vKSRRgcRoqZgcZ+FpQbQ+y6Rk7hCT/ZfNIo8Y7
	QH/iG/44/5agXt3NJzLF6/veJHw==
X-Received: by 2002:a05:6000:2886:b0:43c:fbfa:20a0 with SMTP id
 ffacd0b85a97d-43d150da527mr11472691f8f.25.1775098839459; Wed, 01 Apr 2026
 20:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
 <20260401021635.34636-5-alexei.starovoitov@gmail.com> <3c091ab744676990e90469a89a4f0110d724ce19.camel@gmail.com>
 <CAADnVQJtw5A4GbknXoA-BtobOVMiBc+pC8nUQZ+1zX5wbj3ipg@mail.gmail.com>
 <CAADnVQJhXVri5XC8YScjUs1ShPiSokSCWt5F6LDJ-YDnivzb6g@mail.gmail.com> <657cd945186971fef9b30b856c0ca68e05839de5.camel@gmail.com>
In-Reply-To: <657cd945186971fef9b30b856c0ca68e05839de5.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 20:00:28 -0700
X-Gm-Features: AQROBzDrOtv9KG1IpKoSKdaYJRi05nOpB44oT3pV_9TLu6FWFz55bnhpVOruMIQ
Message-ID: <CAADnVQ+68Us30jo3UONGu+4pUfLK9U7EEOwKj8nigc=t8V5xwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpf: Add compute_const_regs() and
 prune_dead_branches() passes
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 7:49=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2026-04-01 at 19:45 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > > > Q: What is the policy regarding naming exported functions?
> > > >    So far I always used "bpf_..." prefix assuming that this
> > > >    is a requirement, was I wrong?
> > >
> > > It's nice to have but not mandatory.
> > > imo the names are unique enough, so unlikely to clash.
> >
> > This one I still think is ok, but the other patch does:
> >
> > -__printf(2, 3) static void verbose(void *private_data, const char *fmt=
, ...)
> > +__printf(2, 3) void verbose(void *private_data, const char *fmt, ...)
> >
> > and this is definitely too much.
>
> Let's do a bulk rename to bpf_verbose() it is super useful when moving
> some parts of the verifier outside of the verifier.c

no :)
I simply added:
#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
