Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6A440648;
	Wed, 19 Aug 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163747; cv=none; b=acG+SxDiuD/jTygn9lvZ9lSIiz2UGei0Eqy/vv7C2tdgqbb4IWfva66qv2qwbDmh4e5rrk1r7anNXSUEVLVIyLk4gNLwlzK8cH1TxzW6t+Grh/HNgEvvMfjfqG1sXaAMlI6QpGavoRmky7sro+WlFyUEpnttgJIp33tt9V7FWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163747; c=relaxed/simple;
	bh=EpS828j9K7vu+GMA5eR7tkJwJajXx+E1+OXOlrMltdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXq9emwIU+pZvUIujDuga8hzVyw9eeDRXmJEew6H47r2FO/Zl52905GSaCFsb83ouux6Lb+YKRmoshCtSUcoRXXvfzMhbSn3eCC83V8xQvwyoIL9SBPKlX2ZNNvkFB33N7VIfhi2SHiPCLVXjHxvIqmbVG35mwHotRnHH+2LS80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=MpczfKbv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSAVEfLX; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="MpczfKbv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSAVEfLX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 0858313000DE;
	Wed, 19 Aug 2026 14:22:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Aug 2026 14:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1787163743; x=
	1787170943; bh=Sd171Njmo7N9wtDrBKRjpfDcqAauw4CAX4wRLBvZeJI=; b=M
	pczfKbvuvYwR/5/OH3QjADkMQz90zU9pK/MNC6i3dVAOb6bMLd2I0LEIn3SGr02I
	a7uM9IYZcoAxi15C/3tSsaNZwyj/55m1MntBnq/UDui2miaGZiBI6KQQjiAFg8Dj
	bOvZ5P0u5YqUjsmrlN0CCUJtJ4KFIIt5XIbj1QM2wJXdFHOsvHuC/GAq/MIAyy28
	EM7oqfxpo06pHk/L0HE8LmspFtQLWe6Fzy4UU1c51YAexppzB68I0hhI2IVxjYH7
	Xr460rhgbgRBZBL0r8l/j0igap84Q6pfg3sTSlMpKw3ROlXTlWY4dC6giKcw/JHv
	1dkrayFXlcBiWi9jwW/xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787163743; x=1787170943; bh=Sd171Njmo7N9wtDrBKRjpfDcqAauw4CAX4w
	RLBvZeJI=; b=bSAVEfLXEmUY+no1vZXDENyl6pBoc+nFVKCclkeu0au2ZFJBure
	iPRe9SHmUq32bXKInB9Iwj6xG64cQ2jLGnsvitjm/VJmbqz2QykzyArsxNb2PSRK
	7WDGLDhBDdvMvhZBQsyaPt14Kt7m98jVCtHFPm+pgLqThcjI9KvlW/mYQ+CMVooM
	9NGz5BJRB0Y+nDmJ2GEz++F95kQ/oZg6/XVkrtmNAmqhfIE2VqrkgSTYlB3eH7EK
	8gHEr0h63eXWRJn8w/kJ1TFwSB5//15ZZEYOEB/MysE/FINz8BaQBe5nIXWaTsQ6
	yYig/7d2MT0VHVoWdpkL4UdQ/eHGEJ+LOag==
X-ME-Sender: <xms:XvSFagyp9s38xSM7-XvSftydsJ8ueGh6BT813_BgNx5AgLJQYo1zlg>
    <xme:XvSFamlYWTksNF4YskWHfwtFDMyiusZDn3C1CgDR9p3k4R2hRWp2IZU8wUyQiTVWP
    FbP-mnyIwnUvpXcqAvikU_widqqH2MWoGClRnZKXzIf6tVZ3o7zkLw>
X-ME-Received: <xmr:XvSFahEi8Gvu5s9jdHUJJ6DMdp4wvi5iCPRy31buv2B4q0zOrKFnYGs2DtU>
X-ME-Proxy-Cause: dmFkZTEc8eAdlmAO+7Pou/CI2g2vMZ+SBHPEyBpvlaspGE7alyk+914Icm8/RhGoTPP4s3
    JPbd41O5HXrSLFGLpJE+r7+dmvBIQrpY4tORlWpGM6e29MaP7bgfO5k5JZAuQuaCyLvptB
    vGqIl8B1rdV7WGfjTX8AVsba9HV5pnTMHskYqSe5muw3bkHCq16rFGhWxyRtppAa7725RE
    mGYvn4dj1AQ0yc1Ss3kUrcwg/E09Jxc2PShZG8tzFvwOnT4E3IBvcKn9tj4Apor7nsDuhi
    RjEoRTHloezvXPvMcoZCz/1VtBzdJ+4nII2hAxILFAT82+xKQH4TOwAwJ/em47iE3TD9Lq
    cLXlERFA0YoTifw5ySfqW9b4B+p3A230UBY8O0qbKJv4U26C4q0qKhO9hwCN9l6GAnKmPY
    lxFTowMxsM6TAzVVt3s6MNCYSursXbX1oP6jxEp/fWhRlK6NruqcMeIQURcSdpOQICSNXG
    ACBQb2bnqLNmk7/T8zgom5XFmi0/6q7wQJAqeWQnP0JXH0FnHWdXhJJ3UGLqlq2WdVTSR7
    eoBVZ8UDUeAs0QpyKYRRi6H/syUMssCXuMcEn1sUDCHAMefrRFfFR8NzqR4ybzWthYx5g4
    9oqZmJtD/yaOvOVgpmIi229oaZ6zy/y13gK7bh+gmC53di10lEy2YwZtudAg
X-ME-Proxy: <xmx:XvSFaoszFeNl5z-w307eur06VFMGGpwcYmYXSxc3iydE69jQdSogdw>
    <xmx:XvSFakkPBZOEOv91tfL4xIxhgEvN0dupYLJKxoC4bbHqJt6IPB7cbA>
    <xmx:XvSFaowqrYRDntwWsQ7b05HDZe73x53UJrR-b_Se_PmghYuMILvFPQ>
    <xmx:XvSFaqz4CE0xD778dBqvOD6WGPKyPX2VOPwOf6qj3Jlq7GY6rEk4Mw>
    <xmx:X_SFagPirkEpzJkwyVu2NN4TXosURJFJil-8eydlUCC28b_hzTBGImKJ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 14:22:21 -0400 (EDT)
Date: Wed, 19 Aug 2026 19:22:20 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	akpm@linux-foundation.org, nico.pache@linux.dev, baolin.wang@linux.alibaba.com, 
	baohua@kernel.org, dev.jain@arm.com, hughd@google.com, lance.yang@linux.dev, 
	liam@infradead.org, mhocko@suse.com, rppt@kernel.org, ryan.roberts@arm.com, 
	shuah@kernel.org, surenb@google.com, usama.arif@linux.dev, vbabka@kernel.org, 
	ziy@nvidia.com, usama.anjum@arm.com, agordeev@linux.ibm.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, jannh@google.com, 
	willy@infradead.org, pfalcato@suse.de, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 00/57] mm/collapse: rebuild collapse on migration
 primitives
Message-ID: <aoX0FF9ysdc78UFG@thinkstation>
References: <20260816224609.308019-1-kirill@shutemov.name>
 <aoLAly-oL2OAa4n8@lucifer>
 <aoLkMUtmzRVuv2Hx@thinkstation>
 <99138bda-55ba-4c58-9b79-b76e9daecdde@kernel.org>
 <aoRuqbgFAPyZtUli@lucifer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoRuqbgFAPyZtUli@lucifer>

On Tue, Aug 18, 2026 at 03:41:40PM +0100, Lorenzo Stoakes (ARM) wrote:
> > Ah, I missed the context in my other reply. Lorenzo already had some patches at
> > some point to split up mm/memory.c into better chunks that will also better help
> > our subcomponent maintenance model.
> 
> Ah yeah I kinda lost those but indeed doing this is a good idea.

Oh, well, I can give it a try from scratch.

> I should try to dig those out again or look again when I have a chance...
> 
> >
> > I think the challenge is how to handle huge_memory.c, because ideally, we'd not
> > have these stupid callbacks into huge_memory.c once we make PMDs just a
> > first-class citizen.
> 
> Yes and another point and I think it's one that Kiryl also gets at is - can we
> _please_ stop pretending huge folios == THP == what the page cache does == page
> special cases like DAX? :)

Yes.  That is also why I want the split by operation rather than by
THP-ness: a PMD case belongs next to the PTE case for the same operation,
not in a file that collects everything huge.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
