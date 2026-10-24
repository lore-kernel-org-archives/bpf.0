Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792834093;
	b=qnSnfr/sdaJtwiNhf6HGFkXD/BdrjM+VIf28ZFQosoIMPWC3VcCzHnsToMexYDV9EjTn
	 ksu1ZqzNS0ymPd8EUZGLfF4BmpMy1Ke0WXESX4OHC/A+Mai687gv8l9N/J7ds8ZPcauSK
	 F0qw/exViALKLmWWQcBaEqhoIQJ6Kvz2Q81zwN+ETC745H2+KJXE6Sz08zWp7f1IKQv5q
	 nkBo8LZFPk6BRGyADQYeqt47AVKYiGRCfA3j7OZcSimUAVgQXw/xo3ZY0jbctI08uWviX
	 DcoLcfdkfT5+sY0tvpYMyCvUgRtPJnydrn6UZkRt8JbwLTuulcAsypR4oHR96O9JvtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792834093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4ZQqce/S1eB1i9MDN2IQNzzVH6+hd+DA5CuuLvX3npA=;
	b=GUPV8U0ZyGBSBRn09MHfAhLm6lbTf9KcPhcBWQ3fmH3wVtTI3HT954E7fUT6P3N7/bR+
	 YPzmc/vPKLZRRVPxrLKFkA4t1IcEN00Bkqc4bCTgNvrtVNrOAmkKr+UyNBjSabxXvTmvW
	 FHQPOBkYAzv5QaG7dfDguz+mERIkY/dxji652gC5PtzVNS1a3uoEijdmDjdaXRlfEq1p9
	 IWyunBU/jonesz8+zal2NNZD/elP0yHqDm6ReOxtbYBI6aqilTfMSIq1FwfCZ351ZEDjc
	 diRP83bZEeZHfiN1d/JjrUnfhBbX7nZk45TKS76vk8zuqX5lp3sY6fZFJ8ypvEJ20hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ih3d3dCX;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1E606A33B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 09:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65D1E606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ih3d3dCX
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2596167eec.0
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792834091; x=1793438891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZQqce/S1eB1i9MDN2IQNzzVH6+hd+DA5CuuLvX3npA=;
        b=Ih3d3dCXpGqvS9/JJ4lYikN4QpmLu1PHRnhCRHuvEi62AWi848YXltabub4vDjBU1E
         JtDL930znVfowUOp6RB9+HmoPkyJM46GRlA10xLfnkFN30ieRG4lfFEbWv54o51rWYUQ
         i29qLpdRhgIc4ur0vsEgdQ6g0kDqJOdBBmDHLGmGr3gyw/OC58By44Oycw+eHlUqygWJ
         r0GX0Ksb0i+jg+8I8I2l7ItArZGa6c58C4V4k46DRSYmNmsHBJCWsyzDXq/pGN3mp1ue
         Zim2O4BFF0OALDRJbFyWjze43upH3X1UJFG5lhdA++z3T+NZaprJSC32s7+slIRjFadc
         mkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792834091; x=1793438891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ZQqce/S1eB1i9MDN2IQNzzVH6+hd+DA5CuuLvX3npA=;
        b=kNingKLltbKwly3iwPUybYuv80zAVmY5AdXO7ECqEEUDOL57TJ1xlIqdNLz7kgWIDW
         pC8TwefX+gY8INwASm9wTQooMeYj2NQf5otm7UX22PBnpIHal1q5fey59kNPOygHThyq
         cfD4fvwc2ku8KmNwJttNTEhq7ZXa3Q0XMnhu094U/+hnHUl40Ugck1vmfMER6svbR/kr
         CKRBvmLjqX51KnwymnnFKBL5hwhCo01LEcZw6jvGWy54TFURY5BeGrErFq/QV4Qumh8B
         luHlbPQVbD6Zl/Y/CR4d7jyG0S8EpRz4AMK8PvgAQsybcaaCFsgDvLJIrnpl4OT4STxT
         5ilg==
X-Gm-Message-State: AFq9FYKQW5xYy+LzpTbFxslToe4aEwD/R+3VD3JJX1isTVof8ClA7L9V
	9loet1p3lulKFE1urkVpaMakL3oir8whzBOozgyCwKelwwPqP4/ukMp3CP58eUfT
X-Gm-Gg: AYBFou050eEjYTLXqWXP0n7LctqXyvYj/M7Ax4WuiKCCOAN23vOQsIdSwN4hsrqgHmG
	Fq48jX40gy1LXr4zuppwaYGnZlO8DGfsFjkpzZUVOXkMieqiIPjtJakT7zcgbX8st3NvNx3WsA5
	90qJ3hBWQA1zpui7FdJ/uo2hWXLuf68M1xf6kIuNrwIYbUtt/CrxbEmhc0vLEwZilvfMFRPIW8h
	vi5ciOl/kYq0n7KoyyyDBY2vHsLBPHV0xv8rU3PxQ13MDNDvriTiMXP/IO4cvPMWucUVY9kf4HR
	73nHsiBhYBvUf4FldjQrMbGzC7fpyCr27aJ7RTahUnXxKbdJhblTz1ZYhG3ffqnS/R0dQkuStq5
	G4hgFF2U7wJtVJoK9I+9YejPSGkQNx39PVSVOE09SZ/IR76pPJqyhw1hmbh/4wx5tgVuwDhb4YD
	PUmTixYKDVZjD/eL+qy5+LRNTadgJDEelddbEHmvsfzMQR2ZfYCnsfr7YpGLnFTAI+besNaIZHa
	lSffv4wIlQodLJDUM0HMzH38WiRsK9H9GODCZVGKeP4dTWglys3asQu7sqhYi+S7+u/hZbgOZqA
	N7d4i+yN5UHSrxLI8ybHpKKm5BgiLGqgzouuBGYSOEFHwHXd/HSQDIyR3eUx6kblGImutpiPaQ=
	=
X-Received: by 2002:a05:693c:69c3:b0:351:29c8:643 with SMTP id 5a478bee46e88-369e8486ee8mr2014862eec.18.1792834091341;
        Sat, 24 Oct 2026 02:28:11 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:e1f8:b9bb:b037:3cab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8daf444sm5236604eec.18.2026.10.24.02.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:28:10 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Ayushman Rout <ayushmanrout27@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Rosenberg <drosen@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf 1/3] bpf: Fix bpf_xdp_copy_buf() when the buffer overlaps the packet
Date: Sat, 24 Oct 2026 14:56:56 +0530
Message-ID: <20261024092659.76422-2-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261024092659.76422-1-ayushmanrout27@gmail.com>
References: <20261024092659.76422-1-ayushmanrout27@gmail.com>
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

bpf_xdp_copy_buf() moves data between a caller buffer and an xdp_buff
one segment at a time (the linear part, then each frag) with memcpy().
bpf_xdp_load_bytes(), bpf_xdp_store_bytes() and bpf_dynptr_slice() with
a buffer all use it.

The buffer does not have to be outside the packet. A program can pass a
slice of the same packet, for example one from bpf_dynptr_slice_rdwr().
Then a piece that is copied early can overwrite bytes that a later piece
still has to read. memcpy() is also not valid for overlapping memory.

Example: a 100 byte linear part, a 4096 byte frag0, a buffer at
frag0 + 10 and a 64 byte load from offset 90. The first piece copies
linear[90..100) to frag0[10..20), which destroys data that the second
piece needs from frag0[0..54). A store fails in the same way.

Commit ab08863c58b1 ("bpf: Use memmove() to store bytes in an
xdp_buff") fixed the case where the range is inside one segment. A
range that crosses from the linear part into a frag still goes through
here and is not covered.

Use memmove() for every piece. For a load, copy the piece that is in the
same segment as the buffer first. For a store, copy it last. This
assumes that the frags do not overlap each other.

The selftests added later in this series fail without this patch.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Ayushman Rout <ayushmanrout27@gmail.com>
Assisted-by: LLM
---
 net/core/filter.c | 59 ++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 09c60a58c82a..716efafe7e0a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4210,47 +4210,58 @@ static const struct bpf_func_proto bpf_xdp_adjust_head_proto = {
 void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
 		      void *buf, unsigned long len, bool flush)
 {
-	unsigned long ptr_len, ptr_off = 0;
+	unsigned long ptr_len, ptr_off, o, l;
 	skb_frag_t *next_frag, *end_frag;
 	struct skb_shared_info *sinfo;
+	u8 *ptr_buf, *b, *orig = buf;
 	void *src, *dst;
-	u8 *ptr_buf;
+	int pass;
 
 	if (likely(xdp->data_end - xdp->data >= off + len)) {
 		src = flush ? buf : xdp->data + off;
 		dst = flush ? xdp->data + off : buf;
-		memcpy(dst, src, len);
+		memmove(dst, src, len);
 		return;
 	}
 
 	sinfo = xdp_get_shared_info_from_buff(xdp);
 	end_frag = &sinfo->frags[sinfo->nr_frags];
-	next_frag = &sinfo->frags[0];
 
-	ptr_len = xdp->data_end - xdp->data;
-	ptr_buf = xdp->data;
+	for (pass = 0; pass < 2; pass++) {
+		o = off;
+		l = len;
+		b = buf;
+		ptr_off = 0;
+		ptr_len = xdp->data_end - xdp->data;
+		ptr_buf = xdp->data;
+		next_frag = &sinfo->frags[0];
+
+		while (true) {
+			if (o < ptr_off + ptr_len) {
+				unsigned long copy_off = o - ptr_off;
+				unsigned long copy_len = min(l, ptr_len - copy_off);
+				bool self = orig >= ptr_buf && orig < ptr_buf + ptr_len;
+				bool turn = pass == flush;
+
+				if (self == turn) {
+					src = flush ? b : ptr_buf + copy_off;
+					dst = flush ? ptr_buf + copy_off : b;
+					memmove(dst, src, copy_len);
+				}
 
-	while (true) {
-		if (off < ptr_off + ptr_len) {
-			unsigned long copy_off = off - ptr_off;
-			unsigned long copy_len = min(len, ptr_len - copy_off);
+				o += copy_len;
+				l -= copy_len;
+				b += copy_len;
+			}
 
-			src = flush ? buf : ptr_buf + copy_off;
-			dst = flush ? ptr_buf + copy_off : buf;
-			memcpy(dst, src, copy_len);
+			if (!l || next_frag == end_frag)
+				break;
 
-			off += copy_len;
-			len -= copy_len;
-			buf += copy_len;
+			ptr_off += ptr_len;
+			ptr_buf = skb_frag_address(next_frag);
+			ptr_len = skb_frag_size(next_frag);
+			next_frag++;
 		}
-
-		if (!len || next_frag == end_frag)
-			break;
-
-		ptr_off += ptr_len;
-		ptr_buf = skb_frag_address(next_frag);
-		ptr_len = skb_frag_size(next_frag);
-		next_frag++;
 	}
 }
 
-- 
2.54.0

