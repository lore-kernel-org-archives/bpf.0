Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD274F391A
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724849; cv=none; b=OTB9gfWgrzYcU1iAjQzO+XGwl80DLs/lhYwipP8S1O9KW4Uno6L+ADHZAcInYKQK8J7l+UIh88TWcTirwWRT6q+JUpoxCzJxnNGOssvz5yuleeFRiXqVbxwmnrn3EXXLHHaniTwbeCL1IRcZ3SeyFBDqixKBhTTcLFBo4qXX9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724849; c=relaxed/simple;
	bh=62yKmzlB48V/zDch+coTOsu7NKNMzjyVyqGeD4YT6bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQedlq6jYuE5NDOt5tbuB/063w1mAT9rbguzpzyRS/8RM8AaUcyoJeZ5n7dXwAMhogspUvyWClF2Xi+LiqRey4P3i8pLxu5WU0kgJ7Nw6I6a/FHDZ/wsVy+zIvlYDvVBiskPTWW0zVM8eWGT8V2LN+9WBDB1sfS3FQfKOF5+Sv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbxY+7Uy; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbxY+7Uy"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so864079a91.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790724847; x=1791329647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OLCTeGtvRgnZW2htU8ZCF1G66Q5YNndHNz4a4qiAYDs=;
        b=MbxY+7UywbjixXwuxgYlzxpYowIkZZUO+vUmzy8Pu9ocGm6RN8It7CyKlRaQFh3Bts
         xhym4/VPl8hxrKMRCgrbiAEJ0T7i5oX/Z2nfU8ay8Qk3JOl2JOLjguS5749gYNmO8yjk
         gZQXRua9hdwFncx08ExwjQ+NqukrTFoNcvjnMMxA+SWR8apXbePOPRr1bqPmW9v7NPgh
         ZMvbI3fWJf+HKz22TyN9q3pEjFmSHQV7MhLOWOrZwYavSupue6ojFhjRGFGKDQXi8msP
         C0JSRPYFRZuhDDBPpB0LpLT5RBCe5DP9xyUkexLLt5Jmc9ehuJuGusVMG3BCfyWljqfl
         8TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724847; x=1791329647;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLCTeGtvRgnZW2htU8ZCF1G66Q5YNndHNz4a4qiAYDs=;
        b=2krQcXKgRuXNIDnuPomSwyoVADsyEm+8Gp5OL90QhOki7XykaArAP0dRwl7wp1owso
         Vwlco84Nyu70cqXO86oIlb+4e1N3PtQUZbS46Iqcs3NxMWadkDDefAXlk2wd2kT2mO1h
         n5+NICp2VWyCKqXTzjlygf41PCp7H4vDIBYmGGk+HmqVWkrECgSi8Xtws4jk4JENGX9F
         DPrlUIcHcQgLcKeZj7oWtL1K6Kjwa7nj3Pqxar1MogDHw0rvMWlXlQuzgkYTsLuizMS8
         EnSfUdKMG5GTUPDNuzbNO0GwIRkXbleKUMspckvhYiy3F/Y/4QmQ35Pb0PJtq6n/IGIk
         qIJw==
X-Forwarded-Encrypted: i=1; AKwUvByJJAvfwhcXQyri7nNODvbKe7h8rRouQJ14Zr/bAZWZiY0C0tWCQsWrpbnYb0wYhggRDCQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMU0Fz3I0iMy9Z5sCGD88J2l29ycK4hGumoCXrw+6uYg0xVqCN
	vUWXvkc2UjOdxWC6DOiubJPu9bdGIza/NvcHqs4rw+1fQfMGpu4u4PAF
X-Gm-Gg: AYBFou1oLGeY7dE4tK2kX53OFw8JGIgj9Hx0EI2J9iJ9Y8fdIU7h9sTYwM3eKCui2vw
	fszGdCdIx4EeAI452iODrkSv09BYvNQtvtL5C0WY4RrQxPr9Sel+LulV+8VmZ9LAWHbrwLL7t84
	XegHH2Y6MQDFy2St/VSNfkjQ22N/3CtHa//wiiF6k1HdqTL75PXexEXSQNEK7+n0KTYH8V/vYCN
	yRq3k6mAbxRkw/rSdjZlBEsOVRhYAqTzQULaJ/JM5GVEpPmchgPM7VqYgVywMRKmhJq+16CoKew
	B82ioMpz8qRyQxUJAWSy6Zct2bNPguXCjkvOXjb15y+cD6s8rITU5k4Ai8JxvNZaHP0R4MftzXm
	qiHPwiZ/tDfanbWWM5QG/L6OD3Nbv1fRdQoRmmAQTB6aBUehe47SYLjoVhgMxZxaWHJ7dRt5vF5
	ggX+Qmq/tXaD0/Mpq7pMWC2hqbQ1TooNoVbs2I79QLIEOZhSY8yaDrTnDT9eFbddCM
X-Received: by 2002:a17:90b:1d4f:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-3a4bfda445cmr691375a91.15.1790724847432;
        Tue, 29 Sep 2026 16:34:07 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca448969sm195564a91.12.2026.09.29.16.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:34:06 -0700 (PDT)
Date: Tue, 29 Sep 2026 16:32:46 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: check tcp-data-split
 against an already attached XDP
Message-ID: <arxKmCbVlpBI0tKA@devvm7509.cco0.facebook.com>
References: <20260928223648.2739371-1-kuba@kernel.org>
 <20260928223648.2739371-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928223648.2739371-4-kuba@kernel.org>

On 09/28, Jakub Kicinski wrote:
> hds.py only ever tested one direction of the rule: with header-data
> split on, installing a single-buffer XDP program must fail. The other
> direction was not covered at all, and that is the one which was broken
> for a program an upper device pushed down - the device was running XDP
> but nothing in the core knew, so enabling tcp-data-split underneath it
> succeeded.
> 
> xdp_set_hds() covers the direct case, xdp_bond_set_hds() the propagated
> one. The latter fails without the preceding fix.
> 
> The bond case is disruptive, it takes the device down to enslave it, and
> skips on devices bonding will not take as an XDP slave.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
