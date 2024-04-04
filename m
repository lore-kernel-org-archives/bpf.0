Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038559B7F
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223588; cv=none; b=i/nwxWbnMRlFfKVvzlcHLne+1Rt/NI68vrzzZtEFPxM6RqOq0GCFOzYiLm1nmM1ygnLMEV/ocrQbQkytjoQGuAO53d9eq2kg3fKRnKpvNVBAAu4sQLf+i6n8uI4C4TDfexTO72sUkWnSqejC2Z0ifJNGgC5pHVujVj4QIQ3LBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223588; c=relaxed/simple;
	bh=/P6Ix2WIIW0aocGjBNfZvzVVENgdfRsN4nro4zPPdjY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=opBiMqvkLaOGllVNSgEIJ+ccx3zjTbwz7/TtXaE8jS3dEuiFSFOZ7zNpmifox8k54qAd/p2Qm3WyuyoOytBGAE4q3Wzr/X2MbYTy9aaYRBwAiO3p8+kJu30bF93JuanKgi3Fqs7d5TSs857JJYFcYGuPcrz6IHd1L9w9WgRvaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=acZUTOqk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wz7G4bBU; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="acZUTOqk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wz7G4bBU"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id EB598180012B;
	Thu,  4 Apr 2024 05:39:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 05:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712223583; x=1712309983; bh=BOrMyviUw2
	Knamz8twS/QtsABg1OPeWEHHhEQPbQAM4=; b=acZUTOqkbrPH02SoEMyABasopQ
	iFuYOD8T/rRbNNkMSkPlM/cGV3F+iO9FwYJY/fO0SxlNz28s7TFAaae/u2MevFOZ
	gbFvSRNHXBCm5eq+TVRrO+69WQpiFz1uXQBjlqEK2KNQwD8OOWr6cxV4GffwTajb
	e5LpgvAEIuzFwZ0xU3PUb/BcAuSuD/pr6sa3qeY6/hxxGEJ6VS+/T4LM8H40U0bb
	6M0aUJpN58+qX6qAXrBeKVpJxeQPaoZUw/tXUW/AzA1SsbtzdeHEs7IWUpjAF80m
	zoSpm+q56lPZnYsB2nPsyAqpQT5zPeOd3YJ1yb6vcRIlIda1WPIoBf3XoFMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712223583; x=1712309983; bh=BOrMyviUw2Knamz8twS/QtsABg1O
	PeWEHHhEQPbQAM4=; b=Wz7G4bBUAWfz+7IjJZirWqMMLvYY9a98JiltThpc7MfJ
	R3z2WxOJ2u+0iwc8c3xnXr1BYnVV6eRaH9SOcVcYUiCRbvajeOHp9C9nMxGj5nSz
	vQzC+wJmPyUBetEiotsTHkp+qDYFvCGsB1NAuakvB282ghc9HZGgyjf2TlHzCil+
	6HZqMqvw3xkW1Jxcx4vzcC9Jc9B8QNSYV1Oc+a2afLbLSnupllGRqcjpE88T5/f/
	0FpwgKgZKLBsoMpWa7jAfzklyhCQvK9a167hzr64PBPDBgFLPImPMZ/vJHB/aE6e
	5jLv1ZBFYYfvtRCg1vw5PG/JHTovmenF3Boil/LK/Q==
X-ME-Sender: <xms:XnUOZhmq1605ZPXcCEoCHW9AH8Zs4dGeoKVvKvhmMSD-cMFuFBuvWA>
    <xme:XnUOZs3-p4w-DAGrxV12RZJHv1BzozGITlYcXW2Yae4J5SmVOEyy2LFsRM66SarKK
    bjeyJpWIT7A3MtMMRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XnUOZnoD0HTJduIRtBKaRXlA6itBa7bKz7WrUNe9h4XmvlkVu9m3ig>
    <xmx:XnUOZhmDDOVgm42_2PT-3n0zOgeB4ibEJ_IzjxmamK40Dn_dbHQoCw>
    <xmx:XnUOZv0LbIkBzKN7vihgjQ0zv1MVyGvsK4UI42F5VrwWf2waXSENTQ>
    <xmx:XnUOZgsF6Yk7AUGeRGDnejHBYnknuiYVvEEgaD7Lk93I84lD3XppjQ>
    <xmx:X3UOZouXkZtR0uFMwaXMHizlK5BiPLjFqMPBblT-y9mcDYtW5GgxqXMD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CBDD2B6008D; Thu,  4 Apr 2024 05:39:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2bab91dc-c7d8-4bf0-bd8d-fc9db52e3e8e@app.fastmail.com>
In-Reply-To: <Zg5dQ6KYqVWA2Iia@lavr>
References: <20240403123303.1452184-1-aspsk@isovalent.com>
 <18d8417d-835c-4279-9f84-abdc56fa19fb@app.fastmail.com>
 <728951fe-ccd5-49d2-1584-fc97e2c2266e@iogearbox.net>
 <1c3d3079-e1f7-4420-b542-c3c451038963@app.fastmail.com>
 <Zg5dQ6KYqVWA2Iia@lavr>
Date: Thu, 04 Apr 2024 11:39:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anton Protopopov" <aspsk@isovalent.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Jiri Olsa" <jolsa@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Stanislav Fomichev" <sdf@google.com>, bpf@vger.kernel.org,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
Subject: Re: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
Content-Type: text/plain

On Thu, Apr 4, 2024, at 09:56, Anton Protopopov wrote:
> On 24/04/04 12:31, Arnd Bergmann wrote:
>> On Wed, Apr 3, 2024, at 23:00, Daniel Borkmann wrote:
>> > On 4/3/24 10:09 PM, Arnd Bergmann wrote:
>> >> On Wed, Apr 3, 2024, at 14:33, Anton Protopopov wrote:
>> >>>
>> >>> Declare this inner union as __attribute__((packed, aligned(2))) such
>> >>> that it always is of size 2 and is aligned to 16 bits.
>> >> 
>> >> I think you probably want 32-bit alignment for the structure,
>> >> to keep the ABI unchanged on all other architectures.
>> >
>> > Fwiw, on x86 nothing should change on this regard, see below pahole dump
>> > before/after. I think similar might be true for other archs as otherwise
>> > we should have seen a kbuild bot complaint on hitting the size assert.
>> 
>> It's not the structure layout that changes, just its alignment.
>> Of course this is unlikely to cause actual bugs, but if there there
>> is no real need to change it, I would leave the alignment the same
>> as before.
>
> I think the struct will now be automatically 4-byte aligned, as it
> has the following layout:
>
>     struct {
>             u8 a;
>             u8 b;
>             u16 c;
>             u16 d;
>             union { u16 e; u16 f; } __aligned__(2);
>             ...
>     };
>
> So if the union is 2-byte aligned, then the struct is automatically
> 4-byte aligned, because its address is 6 bytes less than the address
> of the union. In fact, as Daniel posted above, pahole shows that the
> struct actually has __aligned__(4) attribute in the patched version.
> I can add explicit __aligned__(4) to make this clear.

Ah right. I misread your patch and assumed that you
gave the outer structure 2-byte alignment as well, but
it's only the inner union that needs it, which you did
correctly.

     Arnd
