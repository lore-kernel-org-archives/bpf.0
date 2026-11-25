Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577634;
	b=qmfd5n846xeYh/H7UsyoD63SSNDHve5puOfOnNpFLxD+VL7AcpBBiUEoUDW0ytS1QDak
	 YH7kQfZNLIr6RSs3H5hKCgyHgjJysOLYcX9gj7/IjL8UOGuK6KAgZOSoYr47PeS0SMQT5
	 NoT3TVlfGD8CIX6Y+ObMPyhzoaY5JViIjaiJ45tYIEJM+PpAi83ebUL/E8jltvPSEXHi8
	 61NPNxh9Ub0Y2tK9BwZHsOUOvCvp/hujuGHgxuVQHQI17lcMhHeHafiNLxbIvmjJs1KoB
	 Ej2Zm89tJ7wqyY3Xj9KdK23Rr6NGSVsO2DaZEWlf8ljGxA2e4jRTGbj0PXYKOir2gnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MlYQ5eA+xilNUbMjt8csVVxh2ih6kjsIGi6IrLfqvQQ=;
	b=Brg9M6ApMc1yuRCvVCCprNYhOvrrRMkvHESyecOx0WGHPFb6SafwHxdsxW57TzQ6kkPJ
	 aaJeoupXcfn5nnlo30T0SQLlO/wm/9vytwG14C+OuWeck5txeVEehxf+rfbxQBBfMCDM8
	 scKCwQEfHJb7tSNeVNlskr8ZVbT444XoqDsYQ8TlGj27G+BuFZt8hGSGxTA2jOzmB15wj
	 dMiuc5opjlOujO1Q5k9f6Z9b0qlPHSeoGIWO3PR/LG74cg3RG/TvC00NgoC1s4Zl6i+70
	 vEGvvskyP1LknWY/TNCCKFkJ+qPs6zlsyYWq/4fG7ST5S1mrJ0W2cfkxy/GkxZWzRjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhuH9TJl;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D13D606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D13D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GhuH9TJl
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso2369463a91.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577634; x=1796182434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlYQ5eA+xilNUbMjt8csVVxh2ih6kjsIGi6IrLfqvQQ=;
        b=GhuH9TJlUwQ6Js54n+tfsY46GPn98ABOQQcNl1csCt/fiXHPCoSWYTQGEG8okR4GvM
         zSh6FKSQHKUdVaSw4wkgnCe9mMyndAYkH/wR7Y1ASvmaTliMEv+EkioExiD7SIu+dvqu
         9G3hklcTEQCnIVZ4vlV1IpB4wDD6ZG9+9YudY3WBzCl1L5SfApTkFjhy/Q9TIGmwZNhz
         7e4KIWVMdjUzJ1yMZytCr0hUpBSK1fm3kQaVkS+osilVh2AfXV2pVHLJ5sLhCCL8Rep1
         JLK+vABAM/EwJcnPgtNjxhMmHGkrsKB6AC0plAYJAGEvlIjS7tOxlRqZH707tmiWaEdK
         TzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577634; x=1796182434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MlYQ5eA+xilNUbMjt8csVVxh2ih6kjsIGi6IrLfqvQQ=;
        b=dML3THTaz7PnoNpMrmVSL5QQFoOlsiceFo2ReMH9T5oE/6Tj7/SdVCriYsJiFm1+fy
         ajoDwV0lnbdq1qHMJo8F669FykYbib6aQz8yKbfxY2T1uzXYjuLn7HQy4dsQde1/W0q8
         vuJlp5E06zEgQjTP5zEhkqckS/x3F+yzyoy+zpjOtqwHaAv/ILeiM+y2LmYMjycMC6DG
         7r1yppsoay+tyJd9eBCxscdtZGIIBATZTOcgV6X7irrFjVph0f0MKgfulw6jXjHuJb+J
         e4nRRXEHhrmhosHLHsBmMhMoSq5Ta4aEk1o7u5Ihmhxj4rCgx1au3w06o5SmcVh0G3M8
         edcQ==
X-Gm-Message-State: APuU4Z9IZvgAcH4woyKYQA9R3ByFM5KmOrXehQyam+5FumOpSdmxdNwo
	N0w/bti2EbclFFRike7vnQ+0rSPF7uxg8kH3D+qPl1MYVruFK/16ATq2NynBqqeQ
X-Gm-Gg: AZFdTZdDtA2VCkAEk05QG7WDI7Crc59gKVexJTq9Xowi3CKeIfCdP91VhftBVNCFsVR
	D8ICMBAx0098IE70EP7D8HNyEBgSnfKeI4zd1WBs56PBSvr/nLtTWKIUBL8QVdLa/4HBwmFGgCV
	IZmcO/DbgIE6DOKlYHWlkOyUbnz3aO/9uxeydeUPMh8ECFQm4KVFMA7QwPzjaAeN65s+x+mNsx3
	ahayy3mFPO2ZbzYsrRKj+c8W2rBy5gynOKH/4FCIkWzgrLiBHZ1zI4gsBI7XAwPtwDtCxd7bQ4d
	a4DLvMTlGz+9YdTtDzwN0LOdFPDDAmU7G4YGbpzw5fp1kK7q3MoQMU+4zcPpsjO4U6WTtExNabD
	RnTt7nK1nDHVBobMNkgUjA+HmY1FL+rNNP0c+bkq4A03Qg+yoKXfnimzeGMpCiTVjEZ9cuDspy3
	dbzcb3CqGrDnBQvlnpOEr9HNYmFesYUHgCcJrvXTLB4TrNPziBr5qEVRCLyPjWn9TKfeIm25+gS
	xgg9JoX1F9RvScwoeTk/iSdF8FHmojbEABOKVhGd2mZrHMwYVdL07cJ6hI7cutCmLW1jUtNc8GY
	dPq6sNWRRoV0Og4zo/uIy6eOXS2yw+gd/N7vH3iDsVDC4W4RJxYPjASC3afgZ7VhtGo8Vsrcljr
	Cua5v1OL7i9koW+MMSmT9V8PrpTf/55OEZPSvh/Do+repyhhmDj9Q4lG8aUUBFwmueRnrJWItgg
	==
X-Received: by 2002:a17:90b:2d8a:b0:3ab:189b:6981 with SMTP id 98e67ed59e1d1-3b41c953639mr14859285a91.48.1795577633749;
        Tue, 24 Nov 2026 19:33:53 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40a878d50sm27767830a91.11.2026.11.24.19.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 43/47] bpf: Keep the MAC header in bpf_skb_change_tail()
Date: Wed, 25 Nov 2026 03:29:34 +0000
Message-ID: <20261125032938.670542-44-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The least length of the skb is the offset of the transport header when
it's set, also when that is below the offset of the network header.
Callers of tc programs count on a skb that is not shorter than mac_len.

Take the bigger one of the two offsets.

Fixes: 5293efe62df8 ("bpf: add bpf_skb_change_tail helper")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8d331802a7db..fb403e18a5d7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4044,7 +4044,7 @@ static u32 __bpf_skb_min_len(const struct sk_buff *skb)
 	if (skb_transport_header_was_set(skb)) {
 		offset = skb_transport_offset(skb);
 		if (offset > 0)
-			min_len = offset;
+			min_len = max_t(u32, min_len, offset);
 	}
 	return min_len;
 }
-- 
2.55.0

