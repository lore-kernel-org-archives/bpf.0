Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001D222599
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914916; cv=none; b=p+T6SgbeE0I3L009/JjWEEt0MWjRoUqd5Tdu25DA3Xjxi0My7bgK9temoZoJc6fXq2T7YXH6fDPf0CxOPUhlmUHRhb54hLHCsk25QfDU8WqEV0BS6PMtxTF1ShKx1tLSMWp/vbqz/oK8OhmMteRX2n26xUmubI/yL4SNKtQ261s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914916; c=relaxed/simple;
	bh=ZF0b5k6QZhASJhGoG2LmpZvetDnSN8wEAPWc9ASZ37o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I4u4SmLgyXsWrjTEmO9gLlBl41AVJ3x78SfpNFgfko8wVTDCR8H63Sd5zac5k9x5reW53GwJ3zfLB0rPlI6HP2G+o2c3CqPYUNobdQdk5UjKRVIa3P4dHyP7XMIluLciJ+8GkEtZFWVVtn9iHfewglBk2ut6d2K/zGX6mJj9fnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO7qZNEx; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO7qZNEx"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65c5361142fso1138631d50.0
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914914; x=1778519714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPjKfclZpuBGr4xr8o/9fBtma70T3K5CPwubsAor7+c=;
        b=lO7qZNExMB1ZmiSztIGEx4pyhabxfqLpdaZB4tmiWkCk3VBUpbeUqmz4j/9tQSUzsP
         196dzppjzbfA+7+DtpVUYj47RkF9xP8lE+0riwvbIpjCw/5cmSCE+hldhZpHLTjZNRLw
         4CuGAUh4OUQ5W7rFlkbbox3dmWzWZXNBH0uZcQvAt1ptaJS0pfGXS3E9HRanzCRtveQU
         EvqEoPtg9XOlc5+ONmv00D4yCQTG3izh9v/Ac3g2++vszPk60bJ2RkEw4zPyr8jPsI19
         wkTSgv0NhwqepDSTxdmQ0t7Lje6oVWMJHLydNKwOPzvRNXOgmwbwC1asl/iNFIlnuafH
         U6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914914; x=1778519714;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPjKfclZpuBGr4xr8o/9fBtma70T3K5CPwubsAor7+c=;
        b=Ti+fdLyh9bJrLVwxiGnpvKSo+l+OblD52JbhaNaHDmIJNWUX8krvKMO/1x1rdgGH+c
         FJIFRhmtqbzSZYwSQUK5JZyAnJsHTtfCiQmzowsCf+fp5MJZucZP97wbRe0CCllw1D//
         Y2fKXbRbs8ctzaITvxIGUwWL9mxzLqkj1r4mUJ5N8dSEaRftEI2eTa512BPCZEDrZQqF
         b1M+bimSGbQPvp2dgEmTXfqxtQcr9mSkV3E//oJLZjyXAbTBIslnGViS6v9BOJyoD1FP
         gUT1cBTitwy72Axq+H/dnMKxPqfq8LLrD1fUXXpt06UVST9PtRX2HB4cQsjh3qnAMDgt
         yPkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SBpXEwjqftPXxP3K12mGGdqo5ddAsF4+OqJDT7XxGDKHUdfYHAF+sDC4g3zw59u10xkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCFdlusB31zSn9l04R9G9iNxs9PNFXwd9Y81fPwSKxB3AH7eK
	Y4ltUr5TiAsYKxb8kQig742tn6BuM06Y4RBlYomrdxIm2wiHlWMUAOyY
X-Gm-Gg: AeBDievJBTQ9rLCt22WQZvCabhggHJe2sZnqYv3PayeJnZ2O1KxkCqEGHDintLst5rM
	6g+3OMgetV4lpQGWEP+yQY/YFLeZXEuhT+uP4qX5S406VjNpiaanx1rHeRfVdeA4eZcQC5VoZuJ
	f4k1azPjzkG3UUjO+tk9oxL4oADH7XlxiOhCYm4zxyV+30PEE9i7gyo2xNUsTWhKSFcilYcUZ0c
	eXbGUC7PlrpBmlpROfcMBCMHkTlRn+k7gH4PF7+e8MW7vXhXbpj+tcG0Bo5P62o2KsUQuDotUbQ
	UNOHQeMujljNR4sTofyOusXQ/0nVXMNPDN6QyJwfp15UF1q5rb8S76pUmShzMo8W94f8z9HhLFv
	Ly1RpdGWl9tXLQisGXs83EzW0K0rfe28Z+w/ME40dbe204W0kGawBpE7L75CcDlyzTkMtRSblwG
	vg8QmUzPI7V3+flRnM21L4mUxt3nTB4qJ/MOg1Q4/G6OHAxkIKCeqtBOmUe0kcav7IMIIXWzbRc
	Xr4q+sp0PHR2ICoAKzlD44S6A==
X-Received: by 2002:a05:690e:bcb:b0:651:bd70:1622 with SMTP id 956f58d0204a3-65c3da0c96cmr10543400d50.10.1777914914418;
        Mon, 04 May 2026 10:15:14 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e86e35csm5782052d50.16.2026.05.04.10.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:15:13 -0700 (PDT)
Date: Mon, 04 May 2026 13:15:12 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3b7e1901d86e3@gmail.com>
In-Reply-To: <20260504101759.3319427-6-nhudson@akamai.com>
References: <20260504101759.3319427-1-nhudson@akamai.com>
 <20260504101759.3319427-6-nhudson@akamai.com>
Subject: Re: [PATCH v6 5/6] bpf: clear decap state on skb_adjust_room shrink
 path
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Nick Hudson wrote:
> On shrink in bpf_skb_adjust_room(), apply decapsulation state updates
> according to BPF_F_ADJ_ROOM_DECAP_* flags.
> 
> For GSO skbs, clear only the tunnel gso_type bits that correspond to the
> requested decap layer:
> - DECAP_L4_UDP: SKB_GSO_UDP_TUNNEL{,_CSUM}
> - DECAP_L4_GRE: SKB_GSO_GRE{,_CSUM}
> - DECAP_IPXIP4: SKB_GSO_IPXIP4
> - DECAP_IPXIP6: SKB_GSO_IPXIP6
> 
> Then clear skb->encapsulation only if no tunnel GSO bits remain, keeping
> encapsulation set for cases such as ESP-in-UDP where tunnel state remains.
> 
> For non-GSO skbs, there are no tunnel GSO bits to consult, so clear
> skb->encapsulation directly when DECAP_L4_* or DECAP_IPXIP_* flags are set.
> 
> This keeps decap state handling consistent between GSO and non-GSO packets.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
