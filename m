Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF63A0E9A
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730365; cv=pass; b=D7+LITGgrCBEka9ypcI8D45pUuR19tPpo/6csIi/SAYbjFc9SDFrR7/Bklmyg0AQlHdkinL0A/cZR9fqG2QYF6dWOCDvIVxhvEn7wewxK5JSUYfdYRfl0ySLmkvIBVWuDFludBahMAN/CeMqm/QSR5HIJcWYIi/ZWiThKXO/UQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730365; c=relaxed/simple;
	bh=apqxXJEJdLgz0MPrd/4+PeW3rREgQ/peBQ1tEbjfD90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6GE3R+wVtuuByVMk6H+eXdr2M40SFQpW5GtrBJ610ipDcKAEDWZLK9vnr6H+2iUllMzkDAIQtsHimEwQSHhq1Aa6TdEv3aMXOLFB4Yt1D5V1UGEMVvupHTWNKUsW4ARFTafQCIWct4iq9KXAXsxvoQzmw3sjLstZzhxyIRRonw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG6Jn1/C; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG6Jn1/C"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66f727d6849so957962a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 03:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775730363; cv=none;
        d=google.com; s=arc-20240605;
        b=M3yM+S5+F5r6KQESorBAVhlN9tAQkH72U+5PssP6Mc0LdBkHV38ZQlRooUs5cxHMTS
         m5sG/L2V7TP4twKgF4u07WwHlsVlQmWesQP05NaKimNj4cBviPnhfKsqVSlHxfy9Ndxi
         e3u3zECz3pFMsM2JUASRT5FYdO2wN1WohNJ9MjKClvIEb2AkW+eFEAlerXswCXMyLzi9
         3NxJqoTwMjTwtbWsGvJvp/PBLAGOONvhIFDDLVmLoAi5o57voTop9H83inLH8vXCGR/G
         DSh4f3Q6b4B8p68eqobCVecmEUiHLdJHgYRh2jEfI/FUKKl1aJhodWZA4qVP+PvBY48C
         bF5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=apqxXJEJdLgz0MPrd/4+PeW3rREgQ/peBQ1tEbjfD90=;
        fh=zS0NdvB+xqfzlkr/79D2w/kHn4REB9TYbxDCgj5RNV4=;
        b=JWlfZ9FR/4fbWSfnmHpsd7ZMj7nyxXVXNwmQEFgqIOkbE4jH+SjC8K2xf0Ed3GF6lC
         gWPW4qetIW49Mt3FDu/ScQ9+Hbo/RtC3PP2FbsxclPSi8lItiWpjRZxGA+yN+V3yZRR7
         cTB03IUZrBj/hljNnhaGaxz/wUX2vwRqlEMuBOh6HDMeD14j2Vv1IGaGR6kuUnfUAxBG
         fklpPTbb+lzzk2EpRqrmXnRYl0jPYoZg5qJbk0BliDv/DYX3lRli4Ve+KwsMbQMOSor1
         uIQONTc4PfOlyn5n/nxa6pR2aUHNt/jPSkCB2DDQx8TEQzjM09tdTfWKP/LbZqdgUufZ
         2M9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775730363; x=1776335163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apqxXJEJdLgz0MPrd/4+PeW3rREgQ/peBQ1tEbjfD90=;
        b=KG6Jn1/Ck2PGSS2KXF94NmEqwwm9Y1KRRNlIJSPhZkgtVYlcpO1vOvEOXQNiPsO7++
         Tbk5CNE81Jif/PCPYMZzwtunCEaASWbQtq/382fROU+/V8xRM/YwFNLIEFvEfqlcbl0t
         UVQpa0BTElXp86MQQPb4VyY9Py6ylkZcwQ1n5hdS/Re4uwaSSzYMBWa1vo96shoXto0D
         vbdWnCHTOoRA8BQgICATgp/vZt/bbzdfTm1jCnayydt/U5imkDo1TmaIynqa7aWaFZJf
         yd4DJEpsFR8+5EpDXh5qLFF2uwaqwJTFrtP0kkO28gM3/UzW8B/NGuux+Zu7k8F6J8Vw
         nc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775730363; x=1776335163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=apqxXJEJdLgz0MPrd/4+PeW3rREgQ/peBQ1tEbjfD90=;
        b=fogkSORkgWihmMWm9JUPscygqFBiwjjPfWZvJk9L38s1Jqs3dFFrtHWmErmLY2mZEb
         Un5P1mZSX0hVUXoxrVI/oJssfKpZAcxKR6CR7WxrCtqs6WaJfXlgsE+LIzN5Pf4Lb2If
         MyBbQdYSpE2Dlyw9E0EV2AnGm0KsuWOeWe9U8oeFEMbqgXodvySXssWXfx/K/+ouMf3h
         FHwo0x9Y0hv7rxujrro929ak/2VNCD2liIueN1RR98g5kgnfJ4Ben0usIounQBT+MstU
         1OCXoUlTzRQgVTcH/BDINhwHlsEAOMRP/eZrPvkv1MdSH+ZBGCyfTKcuzja48I1Nth7J
         LC6w==
X-Forwarded-Encrypted: i=1; AJvYcCVbjImQkYm8pdZ7hkoJp6rrPFIccR2oBgt3fkl3hTmywwZEqqh5C1687hdpilw8d4twKjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUogl/jKbE5xMv363ZOWByded+TcuXOaMYM2jUWL1gExIupRA
	AexpsgoWzbUyBbnloE1nHnL8m8oXSkr++ICNJmS6gIOabzEdJ1GrmSkxn3KR1mEAg2G7MHOiu5u
	7zIcH9ErqP25o/kBib8c+PUmE/C4N2ef/qIGuckk=
X-Gm-Gg: AeBDieseLLOE3mui0C385dW4QRz7uNoxvLu+8VJVsbp4D+Igs2TxMD//lLM+4jzxMK2
	ctmXS64lPRCkNJfyS0Py0EzaTwwXQMPjgAFMI8lDSDXMZazqOHktJFAeZIszh1wdldMfpW0qaon
	r9AY9favGXXxX68E0ihcGLi8CfjRomWK2wLhNoWjE/EAe2kdoZs3XKHGTYT8Ldg0UTptaT2DDWl
	DIKOZZGRljdWxu6GPEahhpgvta+VkYtGsgYoEYkktN1D2W7CiTTsI4gAKYPsKCdYOPyjCGrcslA
	BWQQOqp8cnzjrNCxwsczl+g=
X-Received: by 2002:a05:6402:21d3:b0:66e:45dc:52bb with SMTP id
 4fb4d7f45d1cf-67004d93df3mr1248945a12.23.1775730362544; Thu, 09 Apr 2026
 03:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-9-emil@etsalapatis.com>
 <CAADnVQKnHXg0YnuLvzfXjszMaqugpMNWD5=ipffWS4GVNg6rFQ@mail.gmail.com>
 <DHO7PDYZAY17.1I9BCM8TQWIJP@etsalapatis.com> <CAADnVQLdhjd_owgNxxyP_ozk2R6NX_UR-ZgnpF=2PFnUJYNp9g@mail.gmail.com>
In-Reply-To: <CAADnVQLdhjd_owgNxxyP_ozk2R6NX_UR-ZgnpF=2PFnUJYNp9g@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 9 Apr 2026 11:25:50 +0100
X-Gm-Features: AQROBzDZhy71M8j3R7BWLAKPDT0ukWJoKiHCLyjacv7RFZk1qquGiDJbQcR-E_8
Message-ID: <CANk7y0gqT0CdTp5-_+YgbYjmoS4pwKcXutpGD-_XJMX2ZLCpeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 8/9] selftests/bpf: Add buddy allocator for libarena
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 3:34=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Apr 8, 2026 at 5:53=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
> >
> > > BUDDY_CHUNK_ITEMS is used like NULL ?
> > > The header is u32 + u32. Is it really worth saving 8 bytes?
> > > Use two proper pointers?
> > > How many headers are there?
> > >
> >
> > This is to make memory corruption harder and keep ASAN effective.
> > The headers are actually embedded only in free blocks, so they're
> > not taking any extra space. However, turning them into pointers means
> > that for 16 byte blocks they occupy the very beginning of the block.
> >
> > When the previous block has an off-by-one it immediately corrupts the
> > allocator freelist. Worse, if the header is at the beginning of the
> > block then we can't catch the corruption with ASAN: The header must
> > stay unpoisoned since we have to read/write it while the block is free.
> >
> > Since these are arena pointers maybe we can store them by turning them
> > back into address 0 scalars to both be able to do regular pointers and
> > pack them into 8 bytes?
>
> that probably will be even less readable.
> Ok. let's keep them idx for now.
>
> btw, please trim your replies.
> gmail sucks in viewing/replying to long emails.
>
> >
> > By the way, we're calling bpf_arena_alloc_pages without the lock becaus=
e
> > allocations of the order of ~1MiB fail when we take the lock (which is
> > fine imo, it makes sense that the nonsleeping path isn't able to satisf=
y
> > large allocations).
>
> That's weird.
>
> Puranjay,
> that shouldn't be happening. What's causing this 1m issue?

Emil,

On the system where it fails to allocate 1MB in a non-sleepable
context, how much total RAM does that system have?

We have had problems like this when system memory is low, there is
high Zone Lock Contention, see:
https://lore.kernel.org/all/CANk7y0jsWjt4VMbCza7TOLLXSVtGA=3DMDNVj3roTrwG=
=3DZMhcG3w@mail.gmail.com/

If you have more than 4G of memory and it is still failing then I will
spend more time debugging the exact reason and see what we can do
about it.

Thanks,
Puranjay
