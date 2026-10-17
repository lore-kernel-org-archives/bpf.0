Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC754A1E05
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278673; cv=none; b=BDYn6X0fS1Iq2HbpVcdmiTs2DJjmm0nnrtqys6/xvfqZD4JO5DZCmer9PMyUeqoFhF2Mv+0S9uTpB38lH/mQsTriyHZH4G/XkrwQCZPMvV2cSFFb3K+oTlgZIv7THIojgb5upYuoOKH8gF7mwDbiVlbePIDjYdx/Lkr8Rh/+z7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278673; c=relaxed/simple;
	bh=qzWEo+1kmhCqmiO+TgE5unXX60UtSUAyGSZDlRqX/CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5fdmw575A0SL6JoOXQQ0Gji7XOllCNWu+ULQyT0VlDkFVgJw6wQ6jZu0zXHaFdPAypPCA1zxQWsrfKqNTDMPCH3UlBwfyOFhd/4rJcwfvnAtyLt/rRKANI9NZV6lLY/3zfUwu/M+hYa42oVIcgN776GQ0CjC1E0vTUIDhJq4bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBVS6raV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBVS6raV"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d6e954afbdso3632505ad.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278672; x=1792883472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WnCWhY68j6b1rLGwk5HL0emenMfoMnCXopSNpP2dIxY=;
        b=tBVS6raVTjjeqk1J+3surnLeJmE7RfZ/fwgt7gPDAFu0OQ1Y3qXIsCNgOaCT7uJqTD
         6nlCOIwUDJgSDMbRRmSY+cHLnW/2dULmlf67HDa4ERJRm/paVZM+l2DWj16K9Z+mXpZc
         OtkNi550UWEcPWR33Ebqn5g6bWvS2Uk5bW1q8Jqp+/vtheYHzuWeS8GrhL3gaBzrel+H
         ODMCp2EdAK3cXdroATMUS48mZ6U4BDBQs07SpCU6J8y0CIqLicf61koZotp2sCjsLze/
         fXpzr/W5OEPqo13Ozo572LTO9Bn3x00OWSskgyTlmm6GlabnAXl0lV0J+9FYTu/jZ7b9
         Akmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278672; x=1792883472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WnCWhY68j6b1rLGwk5HL0emenMfoMnCXopSNpP2dIxY=;
        b=zgeIHhvZkzjv9fNr2v3DpSWb0g15b6Mu754hEOBuOnNB9ZyWo8fUugQKsU/8WILuwf
         /fqnR8J8xtA1dw7bLunSWGSOlfVqmUYBrnhgSkxNEz0OM49lR3hsoVmjkjP7zB/VFSFZ
         ASS7/HSo6SEJbVMutyBcMEQBQ8s2TS+jcjRg/hb59GlSPhR57X9kr+V92rpKXGdUjCGL
         EF08bm5J3S7ckoOeUH38g/0Xfi7ZRcwpp9UaIC6X2UlksEgWJe3lgFkAJuX6GHIVUJcn
         Qd1+bP68p5yjA+TG3+VJn9UmQbq7IJOxVa/aFgMawSf6C7nk+NzmqbTHExWI7XlTCqFH
         D36g==
X-Gm-Message-State: AFq9FYIirkx9fwXDYx3OLttliOzhrICUbn4LNdP8Mk+AGfiujSQDBir1
	WRfkMEL5WpF90Z8HN1LqM5MnHcxDsULwDwGDfELcx1S/z5zRzxKi3xsCFjGMHw==
X-Gm-Gg: AYBFou1r9tDqCiDbFdUp44sKXnZDNOg5ncOVGw4RGQ6T58W7kDXAa4HmYEJixEUk7sM
	R550C+pHK2LGajgv6rBlQIgG4Jh7ndbI01jFkF+MEE+sFNe7wmSNGXbuuCSwnPKXT+mOvVAAUNS
	JE6dC8WV48040jR/6Y5+KSRlqLWGrICrkH+KmCaN5ShDZJryTKWnekzr4dfYzk9ytkSkYw5F533
	MU2IqJ6QNvEuWMnCdhHN1dQuvflbZ84XH8islQl+Srg0Uinlq088wMqHHzoKn3tbfkLbJ2+Apvn
	wn+iJXbh+ammTNXgQrc4Pb41AXlbqMUsHRBsN6xH2LqVCcvtAeqecFwwan+sM3SsUzQVi1r4AQO
	7dnTYncJ3jL7/dcQCeVT60/5NEOE6h5JNJGxfZ1YHVUcCR0/ZBWIa/Sw1U4hdnlqCwIGgIWp5hX
	cHQEIBfsk/D8xbewwV6FNkX8kqCRnMQlGPTDSWJh2d+AzPxUWXS3Rh1l45kzE37UR0h7ViJF1xI
	C37MvSM8+oe/hNjegH0BHH907/rAiBGVvb6NzOBCRUg8urNwzdeIY4QR2CYHziY4bHYSAvD5fWH
	y1JQUCRnka48QtjLQHojGjoGuVeYSnV0yi032I3efOE=
X-Received: by 2002:a17:902:f785:b0:2e9:87e8:71c8 with SMTP id d9443c01a7336-2e9a6834941mr35801195ad.4.1792278671461;
        Sat, 17 Oct 2026 16:11:11 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e876f7fsm24323805ad.50.2026.10.17.16.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:11:10 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 13/16] bpf: Follow the head if an skb is written from a slice
Date: Sat, 17 Oct 2026 23:09:47 +0000
Message-ID: <20261017230950.802052-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The source of bpf_dynptr_write() may be a slice of the skb which is
written to, that is a pointer into its head. bpf_dynptr_copy() does it by
itself for a copy inside of one skb, if the source is linear and the
destination is not.

__bpf_skb_store_bytes() and __bpf_skb_meta_store_bytes() make the skb
writable first. If that reallocates the head, the source points to the old
one, and freed memory is copied into the packet.

The offsets in the head do not change when it is reallocated here. Move
the source along with the head.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Fixes: f38499ff45f5 ("bpf: Unclone skb head on bpf_dynptr_write to skb metadata")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index caa9c3ef0a78..0abedbb04ab7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1715,6 +1715,24 @@ static inline void bpf_pull_mac_rcsum(struct sk_buff *skb)
 		skb_postpull_rcsum(skb, skb_mac_header(skb), skb->mac_len);
 }
 
+/*
+ * The source of a write through a dynptr may be a slice of the same skb.
+ * Making the skb writable can move its head: follow the move.
+ */
+static int bpf_try_make_writable_from(struct sk_buff *skb, u32 write_len,
+				      const void **from)
+{
+	const void *head = skb->head;
+	bool in_head = *from >= head &&
+		       *from < (const void *)skb_end_pointer(skb);
+	int err;
+
+	err = bpf_try_make_writable(skb, write_len);
+	if (!err && in_head)
+		*from = skb->head + (*from - head);
+	return err;
+}
+
 BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
 	   const void *, from, u32, len, u64, flags)
 {
@@ -1724,7 +1742,7 @@ BPF_CALL_5(bpf_skb_store_bytes, struct sk_buff *, skb, u32, offset,
 		return -EINVAL;
 	if (unlikely(offset > INT_MAX))
 		return -EFAULT;
-	if (unlikely(bpf_try_make_writable(skb, offset + len)))
+	if (unlikely(bpf_try_make_writable_from(skb, offset + len, &from)))
 		return -EFAULT;
 
 	ptr = skb->data + offset;
@@ -12427,7 +12445,7 @@ int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 offset,
 {
 	if (unlikely(flags))
 		return -EINVAL;
-	if (unlikely(bpf_try_make_writable(skb, 0)))
+	if (unlikely(bpf_try_make_writable_from(skb, 0, &from)))
 		return -EFAULT;
 
 	memmove(bpf_skb_meta_pointer(skb, offset), from, len);
-- 
2.55.0

