Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558891552FF
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174986; cv=none; b=P3ohMTL+Yj37V2X851Ia90HXRoLA9cz/I/0yJBLFqVpbIUcjWeyEPH7XqL0gwcCN9xkzQUEvzgMsIKYQexoKzvfaij30TLSz69b70tMlagk2KJ1ch0DNQ31aFbbF7eEkhDDOGKe+KacR9l0nsotBJ60DHWhPpRLADtdZbJxD+R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174986; c=relaxed/simple;
	bh=fzfJa/wWbp29yT3wcjdQbH1DTTO16aPhx4sYgQLDMVw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XOME81WCDmVqW+YFUUdcb6lcsn7BZhrtDgXsFYk6orBwGMi1I88GGIdWmm+Tu1Hbp3gZl3LwCyJOCuYb6n2wekUSAvlluVRgJDH72XfRZeohqcmtrH0+fioD1AQv3sXjXNRQgu0xfsAlJqd2cgfVPW+GuuU70Qn88JFXyuA3fPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EIh764uV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p32XVG2h; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EIh764uV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p32XVG2h"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 661DA1C00101;
	Wed,  3 Apr 2024 16:09:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 16:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712174981; x=1712261381; bh=llzu1W0e9Z
	U4gpioqPpALLjIijhSOA3RVcmhAs3Rbes=; b=EIh764uVlQZY+yPNSeYXI9jy4/
	zbHB10jPMjYWxzyC7gjQHXjD2CvNADdSOS1wt6bJMhl09J4dsPwJ3LQEp80Ec40H
	MdGDH2GUbOE+0av6b5Z1oBqES1sS2FdW5wTyqrxabSLdmZvN/glSJe2aHDdnJxzs
	mcyOiSUmgUlrqKOJgU/o2+e6lIZ4Ye9xNA/dCAbLX0ubmkU9HWnCFm0BHYYGcrqA
	prIc2ngX05eJsmKMKzoYhBSlSI5kOMvezIX6121YumgsovgjC5lxIut7tpueFXx/
	Ojt2dSVUZ77r4sS5ZPiKmvJ3w+xP8Gq65+1MxbnB89OMZLZAM3bWNu2V1EJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712174981; x=1712261381; bh=llzu1W0e9ZU4gpioqPpALLjIijhS
	OA3RVcmhAs3Rbes=; b=p32XVG2hR9poNsCnZHlaCEDXjrplBh4NSvumCClRUkM+
	94/1RB8+M16BG/VBQVjQ/nPXCsOrUreTnTkkbpax5TZ866mVB0XNb3Ie75FyYssy
	FKAYQYDyB7pcaAk14wb7hsBkHQDV4Zd/7Y6UNTh2t/yekO8Ky4pHfvsiuSpz6QlU
	i28vFQ/O3e/x+K0PDibzhT53jFms/WNzbDyKyyo7+Iiph6He7NM/zV6QdSBUGUvh
	UoYqHDV6gSweHnA84oVSg/ftkpMWniWhMDeEfmVK7lEE4O3Ue/6IbxgHZxkLJGn2
	30I+jQeOSFQyD1r50rxXF8xOST4OmCFcXUf5LcnyWg==
X-ME-Sender: <xms:hbcNZpAYEpORrSLJg0i5PhaAp8VtY--iRENuXyWVAqYLh6H_Tujr6g>
    <xme:hbcNZnjxe629dR2-S8EXG6E8YTA_5_CYFULlQxHodcx00UY2PiCamThPlVALj4qsT
    bbZRCv--22aos2PhpE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hbcNZkn4t9oAphBgzzBz4eI6tIdE8iODkNJ52Dx6eYqL2v3VmmDruQ>
    <xmx:hbcNZjy5ld_5AZ3GG-YUqdjO4lWXmT-VSNs_mpql3OfE16-UjaDJ9w>
    <xmx:hbcNZuSKv76H1pS_3JYLbkpGsZNwXoOs4w1qBg2Sjt4jTQGUy3oypQ>
    <xmx:hbcNZmaXbZGdL5laWPxOodzEotOzIZOJATn77V0uZ-wPOAlB1ghoaQ>
    <xmx:hbcNZjKebu28e-TyeVb37cwNluKSMjaGz-utetZ_h-C4sqIS8xBk7eK5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6A090B6008F; Wed,  3 Apr 2024 16:09:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18d8417d-835c-4279-9f84-abdc56fa19fb@app.fastmail.com>
In-Reply-To: <20240403123303.1452184-1-aspsk@isovalent.com>
References: <20240403123303.1452184-1-aspsk@isovalent.com>
Date: Wed, 03 Apr 2024 22:09:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Anton Protopopov" <aspsk@isovalent.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Jiri Olsa" <jolsa@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Stanislav Fomichev" <sdf@google.com>, bpf@vger.kernel.org
Cc: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
Subject: Re: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
Content-Type: text/plain

On Wed, Apr 3, 2024, at 14:33, Anton Protopopov wrote:
> The struct bpf_fib_lookup is supposed to be of size 64. A recent commit
> 59b418c7063d ("bpf: Add a check for struct bpf_fib_lookup size") added
> a static assertion to check this property so that future changes to the
> structure will not accidentally break this assumption.
>
> As it immediately turned out, on some 32-bit arm systems, when AEABI=n,
> the total size of the structure was equal to 68, see [1]. This happened
> because the bpf_fib_lookup structure contains a union of two 16-bit
> fields:
>
>     union {
>             __u16 tot_len;
>             __u16 mtu_result;
>     };

This union was introduced three years ago, so fixing it now means
another incompatible ABI change. While you clearly change it back
to what it should have been the entire time, it's not obvious that
this is the correct thing to do after three years.

I do wonder to what degree we still want to care about OABI
at all. As I mentioned, I stopped testing it myself because it
is no longer relevant to most people, and there are probably
a number of other ABI issues.

> which was supposed to compile to a 16-bit-aligned 16-bit field. On the
> aforementioned setups it was instead both aligned and padded to 32-bits.
>
> Declare this inner union as __attribute__((packed, aligned(2))) such
> that it always is of size 2 and is aligned to 16 bits.

I think you probably want 32-bit alignment for the structure,
to keep the ABI unchanged on all other architectures.

     Arnd
