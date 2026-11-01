Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560028;
	b=XRzmMrmspy+H8/8pdejOtTAO0I36G37f27Br3Fil7jEO+yM2euBIGTtGpeHLkChQVicL
	 ZNZV5fvsID+yYsyJCYUEqxCd1GckW/dgJzcFcqkGXmC7w5XruxDjzOzxP5cIZIbUBc6mu
	 SpGVq4cgIguHrq6rwGemgfOb7X3lYo55nzmcr+h50kBJvOBYf4eeun1IR4FuM0MyPVYfo
	 UOSKgBVzu/Tf6990weDf9OVO4BFX8JxVyW6La0S0qKRTSKcEDg3H156UGPX1gXxIiOzom
	 wQPLdl648vmtoN6XX1L4RV1f6zy1uSOoOlA9GTNkveTKJhPBwm8zw0q6mNaAF4W/O/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8FcO29XprUvR1ojlMngd2e7DQlmrOmTXIzVb9ItPAg8=;
	b=1LRsFJfHwBMLvjoQscFtCmikmmnpj9QVhxDqNahqzYoSvbSxVM1xcHu3Hwr/S8elsq8O
	 zLKwC1NovtzgqzEAU+8b5VC3GzGP0kI0Hx6NJWyp1CiuHC5ZfwJPkCOBLJUWJlznjatjz
	 vWUpXFbQmiGjCecnWfXC1oNECJF4yK4kD5Q4M1RpiRDU6tUXkVn9hqWX+gpbNyPdxMiLq
	 DEyxM2x0PfLaZLjfqHPlCGoA14x7K0vXJFlUkke8lzt6b59/Eks5SIE4UJPqbQkTQ5cnF
	 RGDtcTqbvsTxDdIfv5RxyUTVr+d2RXmpo+QpPgduwgBlumYpVaQDTnW4tGtSqrD/Yiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UdU1RxS1;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40825606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40825606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UdU1RxS1
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a06454116eso895002b3a.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560028; x=1794164828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8FcO29XprUvR1ojlMngd2e7DQlmrOmTXIzVb9ItPAg8=;
        b=UdU1RxS1yi33jjlTaBUZgi9Y5wd893vTLMNvA0FW3s/kilfSL9o2yp/7CdfdtDMrJa
         LkntYGtyaBIge8DI19vovfOVuh/GL/nYKneuzRkcWOn+ZZBdsfCxJWr6GulBTVn97CNH
         n7AT8RF9S6rDWb4vwRPoYpnpYAv4GIhZ9LMVIj1/0DO6ZK4QEX8LGMXepiugf81poDSF
         u/k/gc8Dt9cHoScZ7vp81WuLGiFY0aG/wnv5ORhd6rTypTXeBUZkF6KzviCwOAP6zyx2
         RXp7xl5XGCvXmPHE89Dz9OMdw3JDLT0vegtnsnt82YB++4GtEXIiuIpS6YIgp9FOxiEl
         xz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560028; x=1794164828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8FcO29XprUvR1ojlMngd2e7DQlmrOmTXIzVb9ItPAg8=;
        b=GH+uHDCbcGzEqb6McRcIM0z1sJGn/qwkkFuLaBljHc1ZqIBdFKeqAIZSKT0T6ldcEN
         DWnuXFh1FTdfRy9+gWUyoz8YJfkRRU/Xxge+/eG14+geBA03uQ9pI0lqYoHhIloNQDq/
         752u3hTP3+Rhm6o7vrcBb5wCqropIzCqCmagSt+KSRDggYGJt2gUayoQpybOUQnEtp6t
         zzMA4O4mvzFKTBBdD+q/Wfe9sB9o1oqaItPvk04C5ekyM6AUsC1jcuW6cGrppg43qrKI
         FPlm6UGwxAoKRi16kyqNezgw2r+WKvehO90CeVqPVuL0z2hB8DhOVEhrXOibRHY9YkGf
         xHmw==
X-Gm-Message-State: AFq9FYJmHAktJciW7dmksIxSBxzYmbS3w4pkypismcRZzMgCwvqXrG7G
	AT5Ra4hPELyjHHiy/RVEDdAf8zrnllBPzWdbvlXn/F0UuFoZ7bSQPnm6eYAXNA==
X-Gm-Gg: AYBFou1ThEr3++SijFdtUgCyv1CHw6BXzEov9E31KW+qh9YZDLK0yzsrL4I8eK3aQ9L
	Qc6qWYLkmjd1KIO61RNTqaZlaaOFV/EcR7TKAE8ZFCPC47O1MmV7wQINNWoOb9PcAwK5wSJDbnf
	ApcgaERVh7bmfm5/obIPWLdSQZx6WLDlepcqShcwImweioIeTxEqmdrI3IFEdHj+soasvJJ2V98
	XOLIZRzciZJ6U1bLBWAe/YoKjj3xDuwYYJszH4fwFGxbYLFqL1aOn8J0ByXnvs7/7BW5bn1tan8
	zJjuDExT2DFs6SV+zAzBc/X2qwUc5xq/d8qOSH0Usiq0EmzbtYPoSu6I7nQsOs6RgASQgLa2GkM
	HKl/9tk12zJdlwA+wpbyl9pcQOXjIS8snDigNeDo8K+227WaDGf14cNGv/FTDqNh0i50bvRDPDQ
	JuMHGbKzQibYQ/VPD7Mo+ZIwObAhrGoAtL0IO9N8EMFk6zzJ76afXxaYEyKotLu7AFRGKiyJcAV
	v8uMvS8I+fRmY3Ktn3FomM12JB99hu7HO22ncg3OBKOi4ZZIP4q49/2yS7kbUU6Yt9/n+I3d1DW
	sn/qGF1rWykTCA9PrYxnRekvv+wNJFOjDdtJQ97KKuHSDrakOiSkurpWRjWvo8lAMxqoJHHzBGH
	9cf1f4bIX44mmUWdyyopszF9UySacBTSclr3PKC5zoM1QDAsyPgpb83Y2KphoqeF6XJKKt3oSBM
	o=
X-Received: by 2002:a05:6372:a747:b0:3de:67b8:26b8 with SMTP id adf61e73a8af0-3e928daab3dmr6054901637.48.1793560027515;
        Sun, 01 Nov 2026 11:07:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096e9f87sm2214689a12.16.2026.11.01.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:07:07 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 15/27] bpf: Don't let bpf_skb_adjust_room() raise gso_size to GSO_BY_FRAGS
Date: Sun,  1 Nov 2026 19:05:23 +0000
Message-ID: <20261101190535.1454146-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

When bpf_skb_adjust_room() shrinks a TCP GSO skb, it adds the number of
removed bytes to gso_size. gso_size has 16 bits, and nothing checks the
sum. Thus gso_size can wrap to 0 or to a small size, or it can be
GSO_BY_FRAGS. GSO_BY_FRAGS is not a size. It tells skb_segment() to read
the length of each segment from the frag_list. If the TCP GSO skb has no
frag_list, skb_segment() dereferences a NULL pointer.

Return -ENOTSUPP and do not change the skb if the sum is GSO_BY_FRAGS or
larger. With BPF_F_ADJ_ROOM_FIXED_GSO the helper does not change gso_size,
so it shrinks the skb as before.

Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 303c0c44dc2c..c0fc9ff04bd5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3762,6 +3762,14 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			return -ENOTSUPP;
 	}
 
+	/*
+	 * The MSS is raised by len_diff. It has 16 bits, and GSO_BY_FRAGS is
+	 * not a size.
+	 */
+	if (skb_is_gso(skb) && !(flags & BPF_F_ADJ_ROOM_FIXED_GSO) &&
+	    skb_shinfo(skb)->gso_size + len_diff >= GSO_BY_FRAGS)
+		return -ENOTSUPP;
+
 	ret = skb_unclone(skb, GFP_ATOMIC);
 	if (unlikely(ret < 0))
 		return ret;
-- 
2.55.0

