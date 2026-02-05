Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92219A2A3;
	Thu,  5 Feb 2026 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286390; cv=none; b=HLQyXC7LBqgsKx+gB60e6y5HQBpbpGStsHY3lyIE04AUExSJUbaVFBzsvpAzGi/XJbocSXvdoR5sx+e0HGkOL0kGOF86L49JO141Xnw7QTPC8phM2K0xnv72LcW9oKtSrjxP53LDwDCZdgfE03XdsXPFZVdY/VqUzuQYjlfnl4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286390; c=relaxed/simple;
	bh=I56DRuyNOihYpX7ViXshfCJ6d9dg4ShXnJyAmYep3J4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cTallfvttxZY8NU+G7IxfX4Ps/RRYOZTxCAZ0TfPjBVjscxrcuRwDec7+QbPiZKvhiEQZthMFldOIkZjNefZc6Bx9vjJMVI67UwrSFyEAUEH3ILOKk+w11Hwb1yGQ0CWgDlBO9Zj85vcNTmWryeWfxBFGmsTtW0jg5Ezm11vZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OWCRm2yt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2hVa6OW; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OWCRm2yt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2hVa6OW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 38D36EC0302;
	Thu,  5 Feb 2026 05:13:09 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 05:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770286389;
	 x=1770372789; bh=E5R/spuaQMZA/kDXnvyzE7QpoYs/inr2iPdEuHG6yr0=; b=
	OWCRm2ytSW5Ze3u8BU219YMsJiLfFCKDZZlLtLb14ocU/pNMgCS2GVcVwcx2O45f
	D5WTB2FqWtenbVdBamzJboGVxNXjb3EIIT75xHUqwwpltjajyRlbO7AX59aUzULe
	Q2UbNARGh3enkCORcuSxQgAWCTDZSmDi9PHey1iJAJfycVhblcBtZU+lSGuoB9iF
	f9nmX3APOlQKctFLgSoDXJco6bykXopVzl/guH0MSNmGCTC2PUaVqi368wIBMBnC
	PC+/UOVgx8xK5HuQPQlBcEXxt+bHBsgOaGbYN/jhjBhxCIei18rzroVxdzB9HY8H
	MmjIo7Xzj+F3ER0Z+ee25Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770286389; x=
	1770372789; bh=E5R/spuaQMZA/kDXnvyzE7QpoYs/inr2iPdEuHG6yr0=; b=R
	2hVa6OWgmpcIZw6IPm0H2bdJBbtoRbp9QyyR+Pxr7VcDo/2tvaClz4c4yDig0j6Z
	GVD3aGe2tTkN0gdGqFrXqv0A5o+xkYGvar1RsyFdE3zqiweg0w2gnrOZLWthAxa1
	7GooQZ8+5G8EjczdGm1vysqlXes0QqYJoZNeLTt4y4bQiiTr/tJycdKUm3SVCxlW
	sIK411TUJSAajNfmakkPG56YplFVnt8+aSXqVuN96BOg/xvAbNiuf9G/5BAPTV1L
	0w0mqg5DnaNYLVrZh1TkCwWHDBI2IMS9R0nypqcqCyoMe+2jt2Jt8zgrOrs9P2SH
	nHrO8fIkBVsasQVcLLINA==
X-ME-Sender: <xms:NG2EaYoqIrzQGRe2MVnhcjoeinCkSccmZHfdc68m_Fi5hp4VHZGAFA>
    <xme:NG2EaZfsiovdauY5R0ydtAujm5eGu_VAvD6Mzj7fiFoJFvs0b-qfdYL_-_eD0klvF
    VhOdiYyYvmldEI2fMstDNREpcthpeJUCuXB4v_zj74tPiOP1rq8YCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlvgigvghird
    hsthgrrhhovhhoihhtohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhkphesihhn
    thgvlhdrtghomhdprhgtphhtthhopegrnhguhieskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegsrhhglheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghv
    tghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphhmlhgrug
    gvkhesshhushgvrdgtohhm
X-ME-Proxy: <xmx:NG2Eae5bKWrpoGMMQrV4byKV2b-1w6i4tPsiArIW2wt6wbqW0s1b9g>
    <xmx:NG2EaeaXCeU38qXHbOaB2k9vcvghR0BanTPojOGTODlBgM-eMu6Puw>
    <xmx:NG2EabdbgDicy2WUTEBXsbZSgUsbujCzYRuUec9IAXGYmTkUIyIAYw>
    <xmx:NG2Ead7Ca61qzpzgDdBS8ta6xOouawzE8SI1mnKEdvTczwGntqIMjQ>
    <xmx:NW2EaXufNYIbZDCmzGMllLjRC-cx49st1wmjxPGsiOcbWMObpluqp2ky>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6BC43700065; Thu,  5 Feb 2026 05:13:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKtysVZkJHK3
Date: Thu, 05 Feb 2026 11:12:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Petr Mladek" <pmladek@suse.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "kernel test robot" <lkp@intel.com>,
 "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Message-Id: <4637e47c-61b0-43bf-996e-6291f2b49f31@app.fastmail.com>
In-Reply-To: <aYRapf5K8wFGEO8v@pathway.suse.cz>
References: <20260204132643.1302967-1-arnd@kernel.org>
 <aYRapf5K8wFGEO8v@pathway.suse.cz>
Subject: Re: [PATCH] vsnprintf: drop __printf() attributes on binary printing functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 5, 2026, at 09:53, Petr Mladek wrote:
> On Wed 2026-02-04 14:26:23, Arnd Bergmann wrote:
>> Fixes: 6b2c1e30ad68 ("seq_file: Mark binary printing functions with __printf() attribute")
>> Fixes: 7bf819aa992f ("vsnprintf: Mark binary printing functions with __printf() attribute")
>
> From the commit message, it is not obvious why reverting these commits
> won't bring back the warnings in the modified functions.
>
> My understanding is that the warnings won't get back thanks to
> the commit bd67c1c3c353b6560 ("vsnprintf: Silence false positive
> GCC warning for va_format()") as explained by the original cover
> letter, see
> https://lore.kernel.org/all/20250321144822.324050-1-andriy.shevchenko@linux.intel.com/#t
>
> It would be worth to mentionin this in the commit message.

Unfortunately, I have not been able to reproduce the original
warnings at all. The va_format() warning and the patch to
silence that look entirely unrelated here, that was just the
compiler incorrectly identifying a function that does not even
take a format argument.

I'm sure some other intermediate change managed to shut up
the warnings, but I don't know which one. My best guess would
be that 938df695e98d ("vsprintf: associate the format state with
the format pointer") made gcc no longer warn about bstr_printf(),
but that predates Andy's patch and I can't easily revert it for
testing. Checking out a kernel before those patches does have
the warning on va_format() but not on the other ones.

>> Link: https://lore.kernel.org/all/CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4VReqAJ=68PaaKYmg@mail.gmail.com/
>> Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lkp@intel.com/
>> Reported-by: kernel test robot <lkp@intel.com>
>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Acked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> For reference, three additional patches are required before we can drop
>> the Makefile.warn line that currently hides these warnings:
>> 
>> https://lore.kernel.org/lkml/20260203162546.2254900-1-arnd@kernel.org/
>> https://lore.kernel.org/lkml/20260203163440.2674340-1-arnd@kernel.org/
>> https://lore.kernel.org/lkml/20260203164545.3174910-1-arnd@kernel.org/
>> 
>> Tested using randconfig builds on arm/arm64/x86
>> ---
>>  include/linux/seq_file.h | 1 -
>>  include/linux/string.h   | 4 ++--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> Otherwise, the change looks good to me. Feel free to use,
> ideally with the updated commit message:
>
> Acked-by: Petr Mladek <pmladek@suse.com>
>
> I wonder who should take this patch. Should it go via
> printk/bpf/tracing or another tree?
> Does anyone has any preference, please?

I think your tree makes most sense here, but I have no strong
preference.

       Arnd
