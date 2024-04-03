Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AEA139D
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183524; cv=none; b=bH7gIR4yE8DzIKdnJ1woCWJkL2FFXiCM/FCHAT0ncZ7GADUpKzAc0t0JLS+0/C1xMAJQSxLEPFUjgM5lBuyg928+Au4pkWb0r2dzQz26JwqFKNnbPu/P30XtdCTXkSo8A3axnKg5A6kWscEYgkNtzQuP9f30WbbXa6tqC0AoSv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183524; c=relaxed/simple;
	bh=fYne05NcVt1ZjcM3VQ9bQyQoFVp9fgKsPt8hYpx4QQ4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pfYXHL43KBxGhVaBOjSnNxiYNvb5MaXXH6oVatw2VAHlOGsTtUHKMTQJGgdLEoAHppLsy2XFyMTiCkXgp+6Y8l7ttP3zUJatjf0jROxNfLp5cQjaMAm75D49eVfZO2u3JramjOZIL4xu+sMjZnFHo+5VUc5I4SqA7CH/Nz4LM+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NTNLcZEh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pQuErzwA; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NTNLcZEh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pQuErzwA"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3F11A180006D;
	Wed,  3 Apr 2024 18:32:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 18:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712183520; x=1712269920; bh=ZKU8QnPFpk
	fIAfHhZDM9ha1A7ABYqkBBOaVhR2yPGZY=; b=NTNLcZEhZ9JnLzvi9+Lwq9mdAQ
	7nvL3OfJQ9FerzQm1G8Soi14xIqJa6ZyDjkoELuflFRWoDtvceGl7QnZcoTIKG0D
	xjGAjexLCR/+qs9Fu/Tkiidc6xyFUdQvcrX5ljTZKie7s4qB8XoRknkQg971FQGH
	lk3FSL9B7mpnP8H6H9CzMxzIM74D6vEP7S4bRBdHf0IrO7Smtt5Y8Eqji6FS12c1
	jU3FbNchNexP2yTVWF2ovDIrH1JdsbOuKpOIYNTOakIMc8+ax+17bVmf+X4imrkV
	9QmWMx5lpMr3X4tgiXSy4gPyvW/rVytrc8KdrnHU55omNTyzRkV9ZPgKVLEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712183520; x=1712269920; bh=ZKU8QnPFpkfIAfHhZDM9ha1A7ABY
	qkBBOaVhR2yPGZY=; b=pQuErzwAS6eBywKRZBgX1izos6WpQ62pM2gLslV0jqbO
	cc8rz6SKvMX/M1xKJDX9jEthSi3zqkyfxPnsMy9my4buPEICpibGlkRK5QKd6MU9
	1xwjHmXIQ2L/1yX8vZcfuHGZt9jc51x2CMSCkyVYSb5EICrvOLKQHW5wZlIJW1lk
	aimAc1ruzM9bOtFxUBQ6DxMc1vTgrukIeYtpj2S24u/g7ublF7yYJeXjW/UZYyIM
	R665A1SwDHC47Rb/USODz7WtQJmmaeAPlVkWKNyHyZx6+UVN+HT7UpBAXW7dA7xi
	zucy8U0D3MvcE6m1ug7pb0JU2DlAVxRCYojmlhv1Bg==
X-ME-Sender: <xms:4NgNZonINgTmut4pgUoxTOURHzZUHqUHNeQZwF3MMFiAGQ9jkH_XNw>
    <xme:4NgNZn2UwPeQE_UpfRsHnTE3ANE03oVTMnU_-v4WlKjy5KlqyNg_q94uLgsqdAerp
    3vQPLnLAqOG5X7sbOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4NgNZmrfA8Pyh0mpX1fjWtQENldbIOd9sew76u7qNXyAE_kxs-7Jpw>
    <xmx:4NgNZknI-qkT_s-YicWH8wUd-ghZvwF2K0QL4WhIoCsZXAffmITX_A>
    <xmx:4NgNZm2hSN2Ncsky83BH_7YJgpydD-FD2RO-14KFwwkWAtFohUzVaQ>
    <xmx:4NgNZrtFV1C9IbXXMtuTiXMSc7je6f6PtqUtMMUagHTcIljpmoxXNg>
    <xmx:4NgNZvtoflbYBm3s8jmZ5xz08sG3q9c5wX2p8h8hvInEIHAcPO3xO2uV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 03EC5B6008D; Wed,  3 Apr 2024 18:31:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1c3d3079-e1f7-4420-b542-c3c451038963@app.fastmail.com>
In-Reply-To: <728951fe-ccd5-49d2-1584-fc97e2c2266e@iogearbox.net>
References: <20240403123303.1452184-1-aspsk@isovalent.com>
 <18d8417d-835c-4279-9f84-abdc56fa19fb@app.fastmail.com>
 <728951fe-ccd5-49d2-1584-fc97e2c2266e@iogearbox.net>
Date: Thu, 04 Apr 2024 00:31:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Daniel Borkmann" <daniel@iogearbox.net>,
 "Anton Protopopov" <aspsk@isovalent.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Jiri Olsa" <jolsa@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Stanislav Fomichev" <sdf@google.com>, bpf@vger.kernel.org
Cc: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
Subject: Re: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
Content-Type: text/plain

On Wed, Apr 3, 2024, at 23:00, Daniel Borkmann wrote:
> On 4/3/24 10:09 PM, Arnd Bergmann wrote:
>> On Wed, Apr 3, 2024, at 14:33, Anton Protopopov wrote:
>>>
>>> Declare this inner union as __attribute__((packed, aligned(2))) such
>>> that it always is of size 2 and is aligned to 16 bits.
>> 
>> I think you probably want 32-bit alignment for the structure,
>> to keep the ABI unchanged on all other architectures.
>
> Fwiw, on x86 nothing should change on this regard, see below pahole dump
> before/after. I think similar might be true for other archs as otherwise
> we should have seen a kbuild bot complaint on hitting the size assert.

It's not the structure layout that changes, just its alignment.
Of course this is unlikely to cause actual bugs, but if there there
is no real need to change it, I would leave the alignment the same
as before.

        Arnd
