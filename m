Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E473C3425
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255321; cv=none; b=ae/pR+RAvg2Km8S1DLoOrCeT75Ka2ZKWuPbDjwSTnir+dfObFgRIBD2KQyhSSJ5IEP9xw4SuOP4Mbn1ayO0ArgfV+IxbP+E3l/leUmDwOVhxM5mlKXeFXcNoo2H/epMhEODvMRDS9EEXv5N/YQWbU9nIKV7F5JWbgUdVvveu1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255321; c=relaxed/simple;
	bh=Ipp2H/k4dhC+OvxL4abQ0ddlv/D8LJd/EQwSg4r9yo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFgsQ9kGIMD5NIIiJsLu5CJl2DnEY0O9SFWnKP/9KdAoY7eGsnZLmURT65EyQeZ32cJLfkW6dfHKbNUMmz7+Mj3uoHE7n1EMEUHXec3vR9Uay9VvlgQ/X8SP+3NvLClE/RoNj/eOEwctYKfKrbrn/69mOTcZLO1GJRBREaMsrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdBgT9ns; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdBgT9ns"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a706146559so708401a91.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255319; x=1792860119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/MIJ1TgjBck3sgThtiZzIAtvcivxjRxzFH1zAg43Pv8=;
        b=rdBgT9nsm4a46Syd5U8WpPJrfemhqba43yuCcxtD6PTErAcWg8p9hyTjAkZy8yq+YX
         FRNdjPM52OOmjpi/SeXQQRlE1Y9vkQR0HFlJZItQrwVECpuCQm7pRcSSsgtSHPChM5xs
         0KxhPpZQipuBot1rglW9potiqcdxCFlGTUka2AE7kgYjYD9Y7XSk4SVa6sILtRZoWhuu
         HN23giNwu9hAKDu+fkgdLFbWONmzRPqqbPg+KsY7FYFUz4IySN1LCw3C0Ysrg0IOcNj8
         SMU77FXrG+6vteZQgZ2mTDs/KjC4MgdMBUmHeRZ7QDiaA0qHxCeKal942AyLKbEuAOKP
         nHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255319; x=1792860119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/MIJ1TgjBck3sgThtiZzIAtvcivxjRxzFH1zAg43Pv8=;
        b=QLLTgsFaD6SqCu49ZlC42651kiTZCC0OHMR/t0zktkO0ekXdOw99odRuEvSIcQYWUg
         wMIuiKgMrbMwj/fLud9OdEEbL7HrcQVPt9nrVpEuQNmExXzusSoCHkKMWogCk5yWR8JU
         d1m2sgKHBuQw0NTnIHAuJag7uYTKt2SiE5T+QXo37Go2g2i4FhTNKOp/yg/Kpuo1ZYnJ
         PX3HGvCw3zrgoxOyX/TL+RN/HOYYlyhLkXnRmCyA448wTXwy7jZ5HpJFTMxwouALDdtY
         FEqZmwb79moo0rH9SPL/tVdUem4A17pQK3qMRlAHHCz0c/291DiaTgErIIhYLZ5JWWim
         YE7w==
X-Gm-Message-State: AFq9FYLZoGnHtXR6Zy79df4MFfpmEpFNihsDcG6VUuM0gp7hgNhqzRpe
	i1zLl8/9LYUOBMiR5//AbnFburuW+V7qX6+LITxe44GJhZipk+tUtDQDtZFj7w==
X-Gm-Gg: AYBFou0ATzN/X+0t2tgwg89QMwBImXrera92AOACkuZRMzqpsjRyhF3TKZwdAGSAkMI
	fVHwuOd8/gvvmkMU7r0+yJ55AjU6ZCXdfzOvAbXHAqzKDnF1Hs/RaqZeJbrrM/W5p23zYAFRS5x
	bCKgU6LMLmib0VUnDfw5nRX1CsiPlq+0WmyxfXAoOJ97QinjGuuh4pVHFT6KuNM6lic3iH7H0lz
	SUm59Eu5PV25cMJqqNqTmo0qSQjJe3zCm2mAJ0hi8TC4lIsP0hYdhmpi0f/YKcqDw7EcBtb1uTU
	iphrKfiCEdpKUQRfJNnYyrK4wfKlK19mek6WIDLXJi+qWAoo+jiWkYTmt1fjI8iqQo2BoEbu3Ov
	iN+Folr2cBal/Hs/4Vmh7nVl7ROWoFyWaclfaBAcKizRhQSIG+8MQ8xF5Qz5BS4pqP49lPQ6vNx
	d9P4go+UtVmOE6jVpJXBA0kz8SNvSn8JFy0ksZu6TDhvnbVGIX8uoBtBVQ7k27IuATbckQT2iDg
	Dgf0BwxQaIUzMk9b5iNWsKeS+E0w2ZNlBPxvZOFVxD+dkkJwS5td0l80TnjBl4aP2m9XC83Q32i
	fXgFcEfKYg5zlxt3ihdgpJnelzxmndGVrHwKs11ejWc=
X-Received: by 2002:a17:90b:1d0a:b0:3a7:8c68:6446 with SMTP id 98e67ed59e1d1-3acef651a94mr2954994a91.63.1792255318889;
        Sat, 17 Oct 2026 09:41:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947dfa00sm13718983a91.17.2026.10.17.09.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 41/43] bpf: Follow the head if an skb is written from a slice
Date: Sat, 17 Oct 2026 16:37:43 +0000
Message-ID: <20261017163745.3341787-42-alexei.starovoitov@gmail.com>
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
index 15354134091a..12a5e530a81b 100644
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

