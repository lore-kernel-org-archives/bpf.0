Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202963;
	b=jXJmI54NDZ2cpPuzVq7d+HVEBcLZ/PXdjSZeHPN2WvBOafY5FrsYcMf4XIg0qGAbl2OA
	 lE+svjZGBppRbUu2hOKkqB3MME0ulLEaNfUGxa1Hfr57QOadWm+t+jLRKcwcxqDlQ7Tpr
	 sd9byjIjdL7uX3gci2T2yeY2UNKd1g/yhisgrQHv5vIlCIWm4eVnJ1fGyJ62MajdX+Xzv
	 IErZb65clGZl1w3y+nRP7y+uk4Fq1jmUuwsms7+UiLCpjq6wQBwSirFjrRFVypM/uUyNx
	 spJVCTx8yk5Kgoyx8C+ULsdG9gI6rZaVWQhJe1CCrPUN7s0vIuNzHxkfuFshBZfmh6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=csOhYfXx1cygq0Nzm1hOlq8/R+R8/dV+gmLXMkdCo4A=;
	b=pXkfTQCpv9O9oRX8up28gRdUy+cFcUkT3FxKP6lYTykxXAZwZ0I3FAVxBFAWpWwZ+sCV
	 4cxUEBR72xJ6c7bOlx7PRDauUeLviZhxoWu3hESjVOqMMxwjHrPkpjqVJMUNUUr9Kyo9A
	 oVODL7FFYOm3LU16yG8fswGljwy3yxzB4Cf+l99U4ixv8peNS1pmgWDtkU5mdz5N2u29A
	 6lncHBIr95BllMSYDoOccxAsr+/69PQZ/fsmh26jOHlbVoDjfULSqDijjuRnP663QMZ1E
	 pVRFebXPgkhfG+Q9r9FCYMEzj8x7gdycURZWyQBrKXEphwgdlGgMOwUTyoqwV28AdEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="halrdo3/";
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10FD606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 15:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=halrdo3/
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2e96b8bfb43so3827535ad.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202957; x=1793807757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=csOhYfXx1cygq0Nzm1hOlq8/R+R8/dV+gmLXMkdCo4A=;
        b=halrdo3/n/6UlHBrM3qN3fciZKUoKF3rXjRzZCpuQz0IgnC0ke3WUITCU3zLXQD0k6
         VcWV/SvMk3WSY3GARWVABDTTh8UENPJ87jPojKjvHfN2JnCdDY8AK1XDZU5tYc+bn1/1
         U4xCZMBmxL2ZnTIlnr6S8zOZ24GXcuMR9SVnLr2EdKRUce/KKzZKmsbT78R508Xgmnup
         fQYTiiTGpkYaP7dlEv/BGg5+mD/Yv3/t8b21SEvfXwx3UqaO2bucwt7qA/l2hVDXILxp
         E03WprrGmeSxfCE7bHzrf5XcS4mzY3X5qew1mW2HBmp49Bl90wJ/RH0k3owYEUODLskc
         LpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202957; x=1793807757;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=csOhYfXx1cygq0Nzm1hOlq8/R+R8/dV+gmLXMkdCo4A=;
        b=JG58nuekXQy4Nr0Zbl/JSg/1V+gRhcz5uCqbTiCr0fc+sjMXnAFQ0z4tROnVon1n5P
         uXDz1a9ysKT8ajv66B5s+xuSDIlPgLMfFQyuFy5N1aThYNXEqje+hYMifQspwWngS8hp
         D6srXJB8lD8jmvavb0wYFKxteZb+/3LrRykiy8wF5QqCtG7mn+agaB6fDOoHz5yb9OrM
         RKVcqR1Ur2cWSUfgbyleSQl2cge/15QeSJFUv0VVRYHp+IBwHu1rfD7baT+cw3aiYniC
         5z6t3lDHLwJCzIP1cjicfvty4jHn0U4+q2fK0PgDW3hCrrvWmhnSJfZ7+I4PzFc0VeoF
         +ZtQ==
X-Forwarded-Encrypted: i=1; AKwUvByQ7Q02u7J1isE30TygI8pyybEktfZpIcWIksoD70aYTWpIHpqSWhgIN+y4RM8FB51koEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIq3gbCgczwqg7HQwDgMvWT/tzw5B/IJby54j4QRBFjlzx2Y0Po
	VsL5FIarUwqKYQqBrdKRMb9ICg3iCd+4zRNAqQgXaBKyfUkiAUutii9R
X-Gm-Gg: AYBFou0amVvWkdUFF0G1od4BcKPMxjupEMKtciYy5BJU1gYLFhqHAZU86XRKwCvrmNv
	mnRYVbxSk+KJsbn22zGstO1GdnDMkRp/DyATONMH/85Re3xk9EnxYKyctStSfOD/PFDAX0wsB9f
	Zvx1rWHL1rmtId0ILNTt9RVVouCHzr0ql9U+KW8OZxsG/QYmfVtBzyXu10MzTnOqg8pt8PIJp/6
	rhHHWpyv9wfDv8KFgZ47w9z3wQS9y1Hb/RszX1eNmIYQaK6uVAnLulZoWjqz/gzRu4fDhKP2SnJ
	eA1ctJFtRaVltf+Cow7wOzSEey+tua1i+ayb7qMWi5lXuXPvbRH8tp70IkcAF3OTAU23nMWcBo3
	7WG8tBKtG+XBdVHNYIFGMoA+ZkNC27jipZUFqB7Yw0eTJA8W8hxLLkMgEfaXcxy687hoTmU1xvX
	hTy4RF3yM0+qBDA0gBaBoG+9hfqFV+dtyhnkGY383TaaYTuXTWv7FI4o9LNkCRFC84JGL+wQhY6
	ZVKzS8oOsCDDm8S5MD/MM8WGhOjGE4i0Ub3lyTZkF9+DpG+kPQlztaNyX7mM30dMwX9m8KmexpZ
	kY/gbiFL7opRf07Fj1i8/aHwlHOnxM5d2LkZsu+sUeSzUnmkJ3gKDnOAqU/YSM+cay5WBQvDvw=
	=
X-Received: by 2002:a17:903:b06:b0:2e9:4175:307a with SMTP id d9443c01a7336-2eb003b2d19mr26567435ad.22.1793202956855;
        Wed, 28 Oct 2026 08:55:56 -0700 (PDT)
Received: from 192.168.1.7 ([2409:8a1e:2330:4ef0:1490:f0fa:6df7:f234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b77e2csm23700275ad.19.2026.10.28.08.55.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 08:55:55 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Wed, 28 Oct 2026 23:55:44 +0800
Message-Id: <20261028155544.12908-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <auH2yISa8xouAx/3@boxer>
References: <20261028025026.11401-1-testwrzwrz@gmail.com> <20261028025026.11401-3-testwrzwrz@gmail.com> <auH2yISa8xouAx/3@boxer>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maciej,

Thanks for the review and for the Reviewed-by on 1/2.

> nit: breaking RCT - I know it's test but Stan payed attention to keeping
> the order...

Fixed in v4. The declaration block now follows the width order used in this
file:

	struct xsk_tx_metadata *meta;
	struct xdp_desc *tx_desc;
	struct udphdr *udph;
	struct ethhdr *eth;
	struct iphdr *iph;
	u16 first_len;
	u16 pkt_len;
	u8 pkt[256];
	u32 offset;
	void *data;
	__u32 idx;
	u32 addr;
	int ret;
	u32 i;

> would it be worth exercising this up to MAX_SKB_FRAGS ?
> then instead of having this flat layout you would loop over the desc
> count.

Good point. I changed it to loop over the descriptor count and exercise 1,
2, and MAX_SKB_FRAGS + 1 (18) frames. The extra frame is the linear head;
the remaining MAX_SKB_FRAGS frames are skb frags, matching the copy-mode
limit documented in af_xdp.rst. The last descriptor takes the remaining
length so the fragments cannot overrun pkt_len. The updated selftest passes.

I'll send v4 as a new thread.

Thanks,
Rongzheng
