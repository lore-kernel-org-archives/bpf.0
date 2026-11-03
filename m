Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736057;
	b=YUfILU0cyO3fb+y8r9BkGJN+yPowe+XivmO3gPkGIrqkNcrTCl6b4c4jKP9iDO2gRqG8
	 w91JUC6UhZyHQjhmOFDEiCYesxje60gVhd9OfKJ2erqwGWBR/iw6WptvBAKMUogGcO9lD
	 ppXPwR9xGOU8YR9kFwCxgQBU91Lq39lwk1MSl/GLotsRySkUix/yTBO6tKa+7aA7QH4Nv
	 oC49b/8oPDfBsRZ44oHqyk+Y6aX/eA7T+8HIXehqLGH9++yDnFUFPMbcOdEnzxXT5KlCa
	 3y3kpukamp8VZN5qPakYkCMl0y6UU3DNUBk5kiyy7iHGOKCVlmRFSTFLYOqZPnIdL4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mlFelYWIRdulUJeu8Py+aDXguvFlkxFE6N66Qy/SxHg=;
	b=uJjkpiFMba364iSTxdYP2/Y/HjKfKv4QW8Z+gXmlPTNgxYaDm4UKtsnlULL1L0/UBWP5
	 CsBsOo1cqlmJSwd/uQeDjl+XqqzxhdPizeq96GMC1l+hrJxIM/eo7J3EjzSJmI2qLv0oV
	 qJVDf/Bw5YHky/MlD2/T0USia3cf+8L1rUkDJFhmPF01vHCdqSmmVMYhU4UMFdoJrHZgv
	 f6NejCq+F32/UDAtn7Nc//4pf+u2mqRWSA85UvkN7TyhkcTZ1xrvVdbkVNW02JcbgK4Sx
	 PmmIUbXsVCqDuHAhlUHt9AmYf9Q/SxslkMxZEEbMFmhwyTCOsXsmqrsF3gbXc7iP5GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=EsO0dbm1;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A480606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 20:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A480606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=EsO0dbm1
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4ced671398so191870266b.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 12:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793736055; x=1794340855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlFelYWIRdulUJeu8Py+aDXguvFlkxFE6N66Qy/SxHg=;
        b=EsO0dbm1bGfsye5KZ5OcUac1g8c2L+thR+EhdMijecI0VJbL7V5fkwDw8RfXnY/n9j
         UeLanVc2T54tOs+nDeuC5VCmfeHa4WWKilz+y+xDCR/CsADLAA7uv5EP0MpGPIvrCqGV
         OyhNt7WVn49m4AXx1OptwoM1YhTlkIUWvzC42rWfQ0pOrO7SNeKZCNMWVwjzKvgdSDfU
         1Y2uK9BZEBgRSwopY2C6/tsWaTJ2pTk+m6wt4d3uTXt3eXDJmqWV8LU+3c2tjzSYTDu6
         FG5hmQ2cYfIUWL9sxyFm85UV9UClkg/b3az+1/DEhRNKd7VOmKfvTcGTEKUpX085TPrT
         TYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736055; x=1794340855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlFelYWIRdulUJeu8Py+aDXguvFlkxFE6N66Qy/SxHg=;
        b=DZ1RluZXSGzBj2bLS32kl1lOSU+2bb+QB8TDEsukbzla8E/0bT1/g0F1R1p1C+CMqo
         Nz2Paqrrcw9zlmrILCTrVUA01QdBL2dsUdqQzE/1VpIbX7sBq5yRHQkFilSW7l8/PFio
         V0YZZOteVFfem474acipsAFrayzz+MebXqIxVA1QIuPmF4pYroamAun1QbSgoyV3QNlS
         j81fxAybTPmyIou9T0Z26r0dhMkoFbUR8CPTlBr0sCCuawsyn/8w8h4V/zRap2psGOFz
         9hPyeJM8PAHOVHep2mlqCect9G9AJ8Q3YAgdwxK/G6OmUe2626NscnzsOmzyiodrnCs7
         ft3Q==
X-Forwarded-Encrypted: i=1; AKwUvBynl6p500Uu/UWp4z1ofZ80pYSqZ35mbqYdLoT6Jps8vC+EWU7FmSsdlptwFiLhvEN5pYk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vEf5wd/2l02ZrUdvFpA7tTJ91XbhhPLIZhEJnpP+PthZu7MXA
	gP6ZQNrwZfdBNmPd/q1gnckDghGUGnFhfCD1qJX9EoF8PsxY7EPlfw8nZDBXhnA0ep4=
X-Gm-Gg: AYBFou3+tM+LgSEYB8VfgCY8d/kZhnXL0d4XEpSq+d3f2C4Q1S0y7JhNbj6kx982onx
	jaMD1NrHA3c+CE+vjFPwPYoOMZBvfpDyKhEYPzPHRYgaj04e9B20QJs/s0RjQb+W1KWjkiwdkbo
	T4clAHUYv/uSw+5IO02YRCwmYcTLVi/i06UTKW7QYR8bflCwmnwlWa9b83HuAcWxynMXbiWPOdG
	E7bBZCOn+EgsuA3Mgx1ayLL9oYxUWEotAMk9YfoEpH98UA582aWw+b9+8gMzf9vCdsN5QGAuBjU
	fcUsFt1LlOv+/If+uFNuXEui9ys9wMuzB2/aDDWjOc/5MltHj+rMO3ivvGlM44U/lF0cdkxThCc
	TlYRa19sZWFfyYA7f+vtp2+T86nbZHu3Q1Ihni/pTg2yjrZb3yOxvwptHjCdxDXukjxyrexzWUU
	3JJu3H67YckDtj/CgVkHN2VKUq0XKxmKeCObHxpFB8rjNOPVqRpzqaoW4TlFuOQwy85iwrF93lX
	1sG9jenHS7H6/7pSRt4YU4e65AJ2AKztgbWRJAGDP7+fJKpeHgm1peL/AQOaFh0/ShnQ8BH9syq
	63vb8cin77Jiqyfo8pX8hbPvD9ic2YPKyDPFl1Qo1Nm5o5P8nkf1/J/Q+ZSTCa+PMwMx
X-Received: by 2002:a17:907:9607:b0:c2e:2d8c:4585 with SMTP id a640c23a62f3a-c4ca7a9b17dmr1299809166b.36.1793736054809;
        Tue, 03 Nov 2026 12:00:54 -0800 (PST)
Received: from D90XRJJJNQ ([2a09:bac6:37af:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec91e2f2sm4499801a12.0.2026.11.03.12.00.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 12:00:52 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 1/2] net: fix mac_len of skbs copied by generic XDP
Date: Tue,  3 Nov 2026 20:00:36 +0000
Message-ID: <20261103200036.65764-3-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103200036.65764-2-tianyi@cloudflare.com>
References: <20261103200036.65764-2-tianyi@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_pp_cow_data() copies the header fields of the old skb with
skb_copy_header(). skb_copy_header() does not copy mac_len.

Generic XDP uses skb_pp_cow_data() for programs with frags support.
After such a program, the skb can have mac_len 0.
cpu_map_generic_redirect() and tc ingress then get the position of the
Ethernet header wrong.

Copy mac_len in skb_pp_cow_data(), as dev_map_generic_redirect() does
after skb_copy().

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..aa0b11204708 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -967,6 +967,7 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 
 	skb_reserve(nskb, headroom);
 	skb_copy_header(nskb, skb);
+	nskb->mac_len = skb->mac_len;
 	skb_mark_for_recycle(nskb);
 
 	err = skb_copy_bits(skb, 0, nskb->data, size);
-- 
2.55.0

