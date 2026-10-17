Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7013A2E25
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255119; cv=none; b=S07vFsrtpGeMusb2UrVxTH52fc/PtZT8mhcLLpkBiC4r4PWiH7e1EbW58KVGL4oUGxTDUpUOUsvi/ByHySW1eBDP+XnxLDVXjWaARnXlpfYoBm84pcbueGBzliPl+1Op8/J8bkWY060d0g/acBO1H+TLqqfDwo4YDVUA4AVVMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255119; c=relaxed/simple;
	bh=MhZZSwa8SUFF9RbLl1HB5SXihSOkB1tK5fRj6ewxZcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgkkV0Peq0+5FFR/ICgwMTBQcNHMaNmdumeVuoEODOzw7ve4HnHF9V2BcLsOquZxwF+RLs+MGF1Xp+n3mRsah99KSmRlJdUXlFIILFBSaNCyy7f8C3hq9elhUSf3cBHhSWk2yToynkJMi1/uXgEgJHwigXbRoxL9wtqd1ysZyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZoQe9iJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZoQe9iJ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso565531a91.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255117; x=1792859917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dA/oPcITmVDB7BAGA8Uc9iJrEF2Bve9fvmNOnIIdL6w=;
        b=sZoQe9iJyG//uXxw4tTkN8ZabkRWNUjuAGZW6DQtr54qbHONsTjA50ehnXjI/4JlB1
         UMIAbPfeIxbOIFvn8oc3G4fUNRXt+aBVDgcVuVe2QQRpuLZZUbQ5mQFr30GjUQsZQx3b
         JXZAx/YidFML9ONNZV+f08+kIvrUwpOEhqJejVHTbk0xZwtw+F4ldS0P85EENCGMOXO4
         RJEpgfUvIyaSCD1CLrIiVQUBmowQ3wwKCrrjsmZexe8HaJA8chJGcUdl6JrM5bxP0jWi
         i/hUnAYjt+zrqS+y0S1iIMbdjeBnrddu56m2r3+P6GnD5oStGFKHsF9spfi7dfjcuBpr
         KRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255117; x=1792859917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dA/oPcITmVDB7BAGA8Uc9iJrEF2Bve9fvmNOnIIdL6w=;
        b=rEJMCYOWgdvJIrZIPzMp9xxB8tomj+qITRdx+0SWOBmgpN7wToqOsv+e1nayz3Kxtz
         mEQjW9KNG+LiWb5pjx0MPWWKgQsoV/UXOCUeZ2oEiudXEc+jbYuG/h7mDHPi0B/1kAqP
         9e6NVU40680Xd+1wIbJan3XzUZbGRYxg9NdvAO9PIwsPxhU55Fsw+o0B1QLHlw6LNnpi
         3kzHUXUMqFiXZeW/rQdH7pIz7mGMcnVKPy7Czh+KzQl7uYla+3VI/gmV4bEXMQhUTHYU
         FQ1ZC2bdYHNaf2JWbLHYTRWoZCMXxMhqypZmVFwus2UHd8Yth25tQkukxi9btuZ9o+5q
         xgrg==
X-Gm-Message-State: AFq9FYKSW1a27GZ46w6PJX2grbh3+XhJqeG/2UhnFRdWriExpxE6Zmrv
	eE+4sp27JgoXKvPdf9+/oliMu5W6K6/j2X1Hq6VlG5Vtwc+B4dCnrJ0N8x8RZg==
X-Gm-Gg: AYBFou05+cO3bu2l5c2JYn1nX7y1dm331zoXK4DSryBSHKxIr6kgFH4QRBNneqERuPx
	myJaolVUPYpS2DEEw9IlSHGhaSNxUXy3KUPMgCfN+l1SikygQnOz5EJJISNeOYWBBarWLkFq2ci
	Ysh3Ts0gPjeeC2C2D1ywwdX63lcN2IXrzASdm1YmvmZcjWUOOrq0ysL0QdLlb+QPTxjzOvgffX1
	lamBDKZ/6b6wxpFIuhRBFWHq6kcfkvIEXkS4AL7oLI6gsFA51qUF9OcdtAPTDx3NdJbuwqtATaJ
	jAPVEOSNrxlAQk/SfKlN/qx2nOOf7Rk9EkV/YHPIPUciX9MitUEh0qUOBV19i1rG1cVwGVBd1DZ
	JFum8xSPw9IagTa7ez2GwdWLXLtwtsFWvh9nqY3QL0Vyl54H85ox6AdE+Jb2yCIYY3/Bo86kBvZ
	cFYx3nJixQltgHcZ1s2EnNhGCmEiX0oP8a+8LsxzNZq/u2Y3Q8ws/QJYdaQQ1uSoE5PdAbopcI+
	cbcgCGRGaLwCFsTi6V4xzF/XZAC1EhnQ/iDBVx4W5gz2L5Tg3FAwO+2fikI2vqEvTXU5FJdjfIP
	QaQYeBU4GzBR967Til84PPTPuJ8YoTZVfCi1ORGuj0c=
X-Received: by 2002:a17:90b:2787:b0:3ab:752f:5f9c with SMTP id 98e67ed59e1d1-3acef13e5famr2427788a91.31.1792255117332;
        Sat, 17 Oct 2026 09:38:37 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm13320326a91.11.2026.10.17.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:36 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 08/43] bpf: don't let bpf_skb_adjust_room() use up the MSS
Date: Sat, 17 Oct 2026 16:37:10 +0000
Message-ID: <20261017163745.3341787-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

When bpf_skb_adjust_room() grows a TCP GSO packet without
BPF_F_ADJ_ROOM_FIXED_GSO, gso_size is lowered by the number of bytes
added. Nothing looks at how large it is.

gso_size is the size of the segments the peer has sent if the packet
comes out of GRO, and what the sender has written into the virtio header
if it comes from a tun device or a packet socket. If it equals len_diff
the result is 0, and a packet of up to 64 KB is no GSO packet any more. If
it is smaller, the 16 bit value wraps around.

One less than len_diff gives GSO_BY_FRAGS. skb_segment() then takes the
length of each segment from the frag_list. A packet with more than 64 KB
of payload gets that far, and one from a tun device has no frag_list:

  BUG: KASAN: null-ptr-deref in skb_segment+0xcf1/0x1a90
  BUG: kernel NULL pointer dereference, address: 0000000000000070
   tcp_gso_segment+0x1be/0x9f0
   inet_gso_segment+0x288/0x740
   inet_gso_segment+0x288/0x740
   skb_mac_gso_segment+0x179/0x2e0

What is left must not be less than TCP_MIN_GSO_SIZE either. The stack
relies on that for the number of segments to fit into gso_segs, see
commit c27c449d455a ("virtio-net: Ensure that TCP packets don't overflow
gso_segs").

Refuse to grow a packet that would end up with less, with the error that
other packets which cannot be adjusted get.

Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index ba536be2915f..dc630fc9f3eb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3612,6 +3612,14 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			return -ENOTSUPP;
 	}
 
+	/*
+	 * The MSS is lowered by len_diff. Leave the least that the stack lets a
+	 * TCP GSO packet have, or gso_segs can overflow.
+	 */
+	if (skb_is_gso(skb) && !(flags & BPF_F_ADJ_ROOM_FIXED_GSO) &&
+	    skb_shinfo(skb)->gso_size < len_diff + TCP_MIN_GSO_SIZE)
+		return -ENOTSUPP;
+
 	ret = skb_cow_head(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
-- 
2.55.0

