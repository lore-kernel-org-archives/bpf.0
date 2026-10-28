Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148301;
	b=DcDy8lpiTbkAVLozjIodcHwoluDsM4+yqK5soSYW+Z7CIrDddUaLiBaSNXLhHqqeGXAG
	 AAkxLfUnQDoHqV46cG3OmxfJVolFUvgtP+0Sl6gWptCaVz+fLvZOh5EpnAkabDUcLPPLi
	 0ZUzvu1OtarX5WidSwqpNDZtieHBsZB+muudvAQqZMnxBA5PUZ7M67aIYSyXkSGCp8DAn
	 op1F0ZNcwj/zbFrz15WO3WMickNWIdzolT/jFK3qS720zWVkCKt8U+S/PY/f9GgyZq3xV
	 2CRR+G69N0lF/Nw7xCLPs4IW0XFuEyspCKlGCmW0X+18BiUzp0rlkE0XWtL7PD6enXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=NsJKLOG1vxU/JR3pnwN5F5YNQk7Rd3m6aih4ob9MfCI=;
	b=gcVdnVXj/RZbxRRJrtrdyUhG2kkPLdWFK0wjGaCyTiTp1yzSxNe57L5SBZ5Mk3TQ4DyF
	 IjMsynY3tWC9dsV1D4kx8p+KeI3TVn2WPVlyS7bKFpo3YsGuKX+Fl1+w3L19e15/rEPXB
	 L2E0uqPDbkju08X4Y78lTfFWxKvCcbgBlgZuSHEJGb0D9u22rElJlwIgzo2a5uCLBBPrU
	 M29cduAgd7nQoJFhZMNR2vNTH+kB1EHuI4QMh+NlWhVC4F95V/7gPJoUJ7Z5tNwpLhD4Z
	 sq7ImIUQqKc2uuy2W8eBAR8WUovOH4NZcECRaaQnI2cVadMhYVY749e0pu4+qRHdIpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D12vlfxx;
	arc=none smtp.remote-ip=74.125.225.139
Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181D606A31F
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E181D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D12vlfxx
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4a5f76661b5so1561425e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148299; x=1793753099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsJKLOG1vxU/JR3pnwN5F5YNQk7Rd3m6aih4ob9MfCI=;
        b=D12vlfxxeoFYqIemgtDKz0bi5yhn+HYG5dtV01npBK9FeWNU8XdZSxKl8F2W8ZZrnu
         sFpgX/K0p/htkmdu5ZbBxPlZRS6LyYBuTwDeyx1DMjQNGBGV5SpzQfH2AzGo2/CImKGl
         RF0c+qrW1hh/L3XmWRhnit+2r8hrjSj59q6xkH9Id478eS+AZoR1JCJpg8S3r4TkcX2N
         uzFH3TbHE0YaHOY4BVbhlgp46KhLfPvemL2th+GS32qdsr5a4b/Gnt32JoUlx77A367K
         H0n5/NblyKCrRzeNZJccMaW6/NxeDKaK1vvmQCay30jLurxdQwmm/+LR7prDrmpj8VN7
         JhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148299; x=1793753099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsJKLOG1vxU/JR3pnwN5F5YNQk7Rd3m6aih4ob9MfCI=;
        b=EvGP6kTVf2q3qdmBpC8cTefmrARlkEuQsuEps6pILeG9BSysKzNnej9zTt7BGQcWIi
         2iHJQ8ShGnE74kwpY5n82bHozWDKKA9PpptF+NPiwl8uXLDsyasqKow+DE3PD5JZ+441
         IM3DyRzX24OReEnVWfdsIbXwLxED1Sl1LhDYbejKQjbsttVVHe5bBvQJ0pSZ+tKyOXZG
         r8LiQvwXxh1KxlBUwzR2pjp4uCtzxv0Xus6COq7QMS5nOhPAknJEjA5KFYJN+eiVbCmX
         g8XITKJG2EPoI0oLAbI4BVneWteZw2n8AdXihWJDvyJ4zGAFPqgjjVNKpMBoC3A5JmCB
         LZVQ==
X-Gm-Message-State: AFq9FYLJ95qaZpRB6BN93SI0OtfmGF1YNmPuXckNKXk3b6uc/MmsMh6Z
	mgL7OiQqR50JWKLsTUaoEQgrvy4J0F+zivdig7gR368uqx8yjijppGS/dLIeSz/3
X-Gm-Gg: AYBFou2qYIDjoS9RXw4jBPKx8X+urUM9VejGLs88fBwUF6Xlh0A/ikIFMArDvx+PAHu
	O3Qxga6xfK8nm2XgB9qX6OyU90E0+RpG1IiO7/tDjeW8BVI6P7P2Xz9mNLlzMDoQLXQC+A+eBxA
	55Hq9iJ1WMpOJfstVE3TWykrCaorl+7dbrHDfMuZ23AKrfjwC5RKnw/5Y2NP6pHzOeouEtZ8IqL
	ajYITVqab2EHDHw7bwyX1kSFGmDmfgrQ/UqcFgu0mb1Gydf942M+d6S0DjI4VklL29X34Y+drDT
	5D2BS0DpeSx/pp7ovx+K/gTB6gDpw25JzIivtT6ymVfXs7P2CsQEbvX/BHdcVC9yQucR/Hm4zsQ
	4bThwxXI/kDdakdCfdE5mx7oyHHE3TcCcVDS9l9vGnWOUP+dda6x1TlcfWJxOja8pM0WIIzgQBc
	3lBnW21oeaG/K9jmXQmTCUfGC2XW15jrk0ELwkUh7qMjfyw0Uw7xrLLn421YZLMoSxK1m6AyKy5
	m59hh+9FjOTCvDpkGcmt+7MlBZK0mdxNtnQceIgIFQuf0HRxg7qIavzD3BmDaCNJUyh6IS/n1YO
	X524UGQcnAhMM5xpwHwkKHlJgThfl00ZOhOV8rNj76M1cofx4sbQ5spLiFw0shl6mswBnj1fPjC
	3Vqn/J653sTLult0AmiYnO1teTMTIE/ZNtsz+VytW96D8qUQNclDwoo/5NnhvywYgEIY4
X-Received: by 2002:a05:600c:1c17:b0:4a3:59c9:a756 with SMTP id 5b1f17b1804b1-4a965dd3247mr13372445e9.6.1793148299265;
        Tue, 27 Oct 2026 17:44:59 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97c9f1403sm7746185e9.9.2026.10.27.17.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:44:58 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 06/11] bpf: Let the callback of bpf_for_each_map_elem unwind
Date: Wed, 28 Oct 2026 01:44:43 +0100
Message-ID: <1b3fb00521b2eda1ffa902ee6e413d30b677bdb0.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7141; i=memxor@gmail.com; h=from:subject:message-id; bh=nrsBepaI1OZDlUuYyypJgvo/enmCcLRdM8faYY9c3lA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh4/NpOa+jBV9LWRwrSp09zzzjjdu8SdbNkiyTlq2du MDA11apo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABMRn8DIMGm9hck/949cL9RU hetOL/l1KMN6556br2+/S7mcUm+o5M/IsKm8pujr9ATBczPv5Oxc+mEl+5PPV6aHFT523VMx6Yp zBCMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The iterators of the array, the hash and the rhash maps get a pad. The
array holds nothing. The hash and the rhash run the callback in an RCU
section, which the pad drops the way the exit on a nonzero return does.

The verifier calls the op directly when it knows the map, and the pad of
the op leaves to the pad after that call. bpf_for_each_map_elem(), for a
map the verifier didn't know, calls the op the way it would call a
callback, with bpf_call_cb() and a pad of its own, so that the op can
leave to it, with the r0 of the callback either way. Without pads the
helper calls the op the plain way, with the type of the op: the fallback of
bpf_call_cb() has the type of a callback, which the op is not, and the
kCFI check of such a kernel would say so. With that the verifier lets the
callback of bpf_for_each_map_elem() unwind.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/arraymap.c | 11 ++++++++---
 kernel/bpf/bpf_iter.c | 22 +++++++++++++++++++++-
 kernel/bpf/hashtab.c  | 26 ++++++++++++++++++--------
 kernel/bpf/verifier.c |  1 +
 4 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 133f189bf6d2..4c81c7c76145 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2016,2017 Facebook
  */
 #include <linux/bpf.h>
+#include <linux/bpf_unwind.h>
 #include <linux/btf.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -800,7 +801,7 @@ static const struct bpf_iter_seq_info iter_seq_info = {
 	.seq_priv_size		= sizeof(struct bpf_iter_seq_array_map_info),
 };
 
-static long bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback_fn,
+static noinline long bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 				    void *callback_ctx, u64 flags)
 {
 	u32 i, key, num_elems = 0;
@@ -823,14 +824,18 @@ static long bpf_for_each_array_elem(struct bpf_map *map, bpf_callback_t callback
 			val = array_map_elem_ptr(array, i);
 		num_elems++;
 		key = i;
-		ret = callback_fn((u64)(long)map, (u64)(long)&key,
-				  (u64)(long)val, (u64)(long)callback_ctx, 0);
+		bpf_call_cb(callback_fn, map, &key, val, callback_ctx, 0, ret, unwound);
 		/* return value: 0 - continue, 1 - stop and return */
 		if (ret)
 			break;
 	}
 
 	return num_elems;
+
+unwound:
+	/* The callback left with unwind_exit: nothing to drop here */
+	bpf_unwind_leave();
+	return ret;
 }
 
 static u64 array_map_mem_usage(const struct bpf_map *map)
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index efd23c973115..4a1bf5a1b8d9 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -734,10 +734,30 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 	return ret == 0 ? 0 : -EAGAIN;
 }
 
-BPF_CALL_4(bpf_for_each_map_elem, struct bpf_map *, map, void *, callback_fn,
+/*
+ * The op has a pad for the callback and leaves like a callback does when it is
+ * taken, so it is called like one, with the kCFI check for its own type. The
+ * verifier calls the op directly when it knows the map.
+ */
+BPF_CB_PAD_TYPE(__bpf_for_each_op, typeof(*((struct bpf_map_ops *)0)->map_for_each_callback));
+
+BPF_CALL_x(4, noinline, bpf_for_each_map_elem, struct bpf_map *, map, void *, callback_fn,
 	   void *, callback_ctx, u64, flags)
 {
+#if BPF_HAS_CB_PADS
+	u64 ret;
+
+	__bpf_call_cb(__bpf_for_each_op, map->ops->map_for_each_callback, map, callback_fn,
+		      callback_ctx, flags, 0, ret, unwound);
+	return ret;
+
+unwound:
+	bpf_unwind_leave();
+	return ret;
+#else
+	/* The plain call, with the type of the op: the fallback of bpf_call_cb() has a callback's */
 	return map->ops->map_for_each_callback(map, callback_fn, callback_ctx, flags);
+#endif
 }
 
 const struct bpf_func_proto bpf_for_each_map_elem_proto = {
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bf78e09f4d51..3e995dacfaa0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2016 Facebook
  */
 #include <linux/bpf.h>
+#include <linux/bpf_unwind.h>
 #include <linux/btf.h>
 #include <linux/jhash.h>
 #include <linux/filter.h>
@@ -2498,7 +2499,7 @@ static const struct bpf_iter_seq_info iter_seq_info = {
 	.seq_priv_size		= sizeof(struct bpf_iter_seq_hash_map_info),
 };
 
-static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
+static noinline long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 				   void *callback_ctx, u64 flags)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
@@ -2537,8 +2538,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 				val = htab_elem_value(elem, map->key_size);
 			}
 			num_elems++;
-			ret = callback_fn((u64)(long)map, (u64)(long)key,
-					  (u64)(long)val, (u64)(long)callback_ctx, 0);
+			bpf_call_cb(callback_fn, map, key, val, callback_ctx, 0, ret, unwound);
 			/* return value: 0 - continue, 1 - stop and return */
 			if (ret) {
 				rcu_read_unlock();
@@ -2549,6 +2549,12 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 	}
 out:
 	return num_elems;
+
+unwound:
+	/* The callback left with unwind_exit, inside the RCU section of the bucket */
+	rcu_read_unlock();
+	bpf_unwind_leave();
+	return ret;
 }
 
 static u64 htab_map_mem_usage(const struct bpf_map *map)
@@ -3409,7 +3415,7 @@ static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_f
 	seq_putc(m, '\n');
 }
 
-static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
+static noinline long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 				void *callback_ctx, u64 flags)
 {
 	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
@@ -3433,10 +3439,8 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 		if (IS_ERR(elem))
 			break;
 		num_elems++;
-		ret = callback_fn((u64)(long)map,
-				  (u64)(long)elem->data,
-				  (u64)(long)rhtab_elem_value(elem, map->key_size),
-				  (u64)(long)callback_ctx, 0);
+		bpf_call_cb(callback_fn, map, elem->data, rhtab_elem_value(elem, map->key_size),
+			    callback_ctx, 0, ret, unwound);
 		if (ret)
 			break;
 
@@ -3445,6 +3449,12 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
 	rcu_read_unlock();
 
 	return num_elems;
+
+unwound:
+	/* The callback left with unwind_exit, under RCU */
+	rcu_read_unlock();
+	bpf_unwind_leave();
+	return ret;
 }
 
 static u64 rhtab_map_mem_usage(const struct bpf_map *map)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4b4d8479fa87..b2b72b3b32ac 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11407,6 +11407,7 @@ static bool helper_has_cb_pad(enum bpf_func_id func_id)
 {
 	switch (func_id) {
 	case BPF_FUNC_loop:
+	case BPF_FUNC_for_each_map_elem:
 		return true;
 	default:
 		return false;
-- 
2.53.0

