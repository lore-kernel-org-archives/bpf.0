Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846526;
	b=hZrLkDKuuyFmJev2siMczTYRa3OASyYsQ0ValGMtJQdhUcTOjiIJO8U/05N58OvAn8TY
	 97CK5+RfBQOh5Fu0fuW/0S2CMtPg3lKUPgP+fo0Z3MvdwQ3zFaf7f/8fMMz0QATCIhETU
	 vMatnmUaKCynFbYCagoXAN9WCS28Cw1E2nKi6Xij9e/I4bTWqXis5kGQ4boTKrtc0/cUn
	 G3oMu9tXsxBDE1giWWTd+M10/aF7Nic3I1PpQNDU4nsGJZxXBkP0GcF/iyK/QEXZnQJ3Z
	 5Cxq4jjwufijJLLT5+hhT02LCnPfc6/vHaW28fim2tbPwamn1jfLnrFR2hzqP9qMXPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m2qUVYEU4erka3R+8Mzo5flrWhCob2ySKiSLvFVhZag=;
	b=LdAwRK7zDYmYIm1Ch+MYAeo1venmSnoSjlJwgi0k06orBdgbl7zDDWvpaQXHfkPbopte
	 g5fWdTO7chdVdY98HB4H8mtwtbPFKuuVKddXYSAEnldSKCk6y/CEGTo7rtcjVyPgVNKXY
	 2djLQxybWtsxr7EQE3NPWfdjggPFx7mb5ousbA83IWKeWVSTqclBdvfZvIKrFiaVflGh1
	 TOi1g+FRf5GFi1xPMj3G1zjdQZQU/2CPc7wSrhI5nA2ZaFftwI1xWFxC4hqTdJ8xXRMcq
	 mtCpDg6j99VWjJZxf+JcTuPNhz+UdA26fXRpIG//fMUAnT/Fkg7dph4Q/Qn72qKozQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Tk8oxXj9;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA11606A337
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 16:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA11606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=Tk8oxXj9
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c247f6687dcso660532766b.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794846523; x=1795451323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m2qUVYEU4erka3R+8Mzo5flrWhCob2ySKiSLvFVhZag=;
        b=Tk8oxXj9BHFLTph+V0GNfvgoPR3BlwfYIK1obg18W2MCzFUc3JxDaqjWB7jk5oUstL
         dDl5+3g3s+RxPQtpL0pPw0DQqqzKoUDAs3rpjYeKIC0ABSlts4k59XTTVVFxGlzzFZwV
         6ZU0T3LluGqKZxAoDf+rmF2DSK3R8SoDSF6p/y17YV7s+OijCfTHeI/6iCZl+Wq2HhWz
         N3Z0j/qfkvZxE7F+q5UzsaLeQep8aG+9294pYvSqSUWAUU3/nOijUuNpGT00mvk7PsXq
         rel+YUirI8TD4rYPdNmgZDGkpSbxvfzzT4qdpVMyRRYhp/iy0rfNX8AsSCkIhuQfKHQ7
         LMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794846523; x=1795451323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m2qUVYEU4erka3R+8Mzo5flrWhCob2ySKiSLvFVhZag=;
        b=0JF0vgHJrrmJtLu5jpRPKDp3idIGwh6CaCsPqts5IrJYnUIzfR5qpGzFlDBEp6Of8u
         3zXnRNvWmZMCop3egIw2usm8UOAdSpBtc7Oo51kyj2j1RHCWrJK+K3OU9PY/uWjMOzEx
         NQpLzjdfTAvHoqT+YyIZ2fCeMhG1wxXy1Z+effOyobi9i6FxNQ6TokytgDCdVzkC3jMU
         FKvkP5XQsNOaSD2SFfvBkGaKvj+BcZ/d8YvGmyD6H8onWHgQNAOOBPqRae44D4KCjF5k
         LqS2k6M9Y/H2zQxnO7v544GXIkHw0FKalScFzsu+6Lx7T6RHNSkrz1/aALw6C2LFjpmg
         c+xg==
X-Forwarded-Encrypted: i=1; AL+hErFk6X4cjmYXWWC7w5weLxqe9GdnOIHI995q7PINTSzS+zTZADfG0kyF5GJKV2Aw3NwHGjM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DTD0+EcAc2M2ajPG1OlNxZu05/j32LmEF/XGqkspkarhHm543
	TFg1QjeVUCFg4dAKzxmFjDa/dasCG81UQ3O/rmZLF0XR5AJ1Ly5fEQEsInZLWAq6s9I=
X-Gm-Gg: AYBFou1StN19dKPuBp4J4imds0Bkbtj9jhMZOW/th3tjfamccCbsndnOMPKSmG1+dtR
	VSI6xv324NrUFBkpaPs22yX1y8WSBaD1lPexPJrRGePB0ixJt05lCwBo17JFRggYtWBOYa2EHlq
	/v0CXFd3CF5WAgVxJrbsI3S7ve328RyFC6+O+fly52QuCp4wKcynAvRgymzZo3noexeb1JxzCih
	5KhpFjKBQHMLDYLabMcuN6I8ZIAMTMVRWCINcivbZGa3vJDJxvDYCP7p1BJc/5JySsv57xkWbuW
	DOKckuIvRgjMw4oay5Wzz5fvcvJqD6mtnFDB7EiUrqZNVdt/gKpaSorucZLS+Yx7URXUFjfjdqM
	pPdzeTN6Oe9riNJp1kAWGUA+JBkSREeUmjw48JVQ+hCCtDkNOIx/iIL7XDK8MYybgcst3Wvu31A
	gCnRcrQMyT/PJYw/c7p7aUUmseUoL5YUB1n31oN3G2Jtpr0pWeYmofZSdgCSPtYFr5c/UcjMLRK
	KSDYicLP8HJ7gk8zGsH/48lnpnNBUN4MsrCnodrMPxmX084NHiYDXI1aOeK1X/Q+e1+zQUdR4JF
	Khug0eONRf2bUHRqQQWbTWIB6Oa8uKFpOp6e2ZaTUs7tUbQV
X-Received: by 2002:a17:906:d542:b0:c29:d31f:7d6a with SMTP id a640c23a62f3a-c509642ad87mr785783066b.35.1794846523503;
        Mon, 16 Nov 2026 08:28:43 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50b13a2ae7sm299639966b.62.2026.11.16.08.28.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 08:28:42 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	yoong.siang.song@intel.com,
	kerneljasonxing@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] xsk: reject TX checksum requests that overflow skb->csum_start
Date: Mon, 16 Nov 2026 16:28:34 +0000
Message-ID: <20261116162834.30087-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
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

xsk_skb_metadata() sets the u16 skb->csum_start to hr + csum_start. With
64K pages, csum_start can be close to U16_MAX, so the sum can overflow.
The checksum offset then becomes negative. With XDP_UMEM_TX_SW_CSUM,
skb_checksum_help() triggers a warning. Without it, the device gets a
CHECKSUM_PARTIAL skb with a negative offset.

Reject this with -EINVAL. Use the limit of skb_partial_csum_set(), which
also rejects U16_MAX, the "not set" value of transport_header. That
helper cannot be used here, as the skb built for an IFF_TX_SKB_NO_LINEAR
device has no linear data.

Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-203545@kernel.org/
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
Sashiko reported this in [1], and earlier in [2][3].

Returning -EINVAL leaves the descriptor in the TX ring, as the current
check does [2]. That is a separate issue and out of scope here.

There is no selftest. The umem chunk size is at most PAGE_SIZE, so only
a 64K-page kernel can hit this.

[1] https://lore.kernel.org/all/sashiko-outbox-203545@kernel.org/
[2] https://lore.kernel.org/all/20260518063407.C3B99C2BCB7@smtp.kernel.org/
[3] https://lore.kernel.org/all/20260531042721.DBD4B1F00893@smtp.kernel.org/

 net/xdp/xsk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f22f9a2cdbbe..ab2e4fa87a4f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1006,7 +1006,8 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 		csum_offset = READ_ONCE(meta->request.csum_offset);
 
 		if (unlikely(csum_start + csum_offset +
-			     sizeof(__sum16) > desc->len))
+			     sizeof(__sum16) > desc->len ||
+			     hr + csum_start >= U16_MAX))
 			return -EINVAL;
 
 		skb->csum_start = hr + csum_start;

base-commit: aa40afa831ebfe45e40a23721711059f2ac584d4
-- 
2.56.0

