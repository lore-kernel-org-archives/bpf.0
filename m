Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582216;
	b=BYWffVPE/LsFJKqeq0Z9PD43TTN9YozSYukLT2XjMkOZ4l+eSxcwv219aE/Bhu6HJ6O2
	 IRjMqxdzDjKc5B56YeJkZRVeDayHe5igMBuMEVsWnTFcPJcY6lDOuJFoxtgGDrd6GOw1E
	 P8mpSHoVpvBG83OiUyofi9nneng9olkjtuuDiSekgYjUUaUQbQjiaoRCzm/MPTkNSPgMb
	 wU0fyxHl8/nAjrz0x12+4hUgAo04wZWstO4+auU7cYysQmLfxMJktJskit4C4Xm3tWO8Z
	 Eag6FqX+cyTdQodI1EcdNEhdEnqzASZTZ0dGEhBl8WUqw23EbmSc9VmIz8FZ+R1JSvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=WZpqROJT0TFZ0N9AeyXaUSyo/Ga6Gz526tDibJ18xQ0=;
	b=XUuW5S3Nexgn5yIzsJ28emBjX5vV3k6YBFAHklVUnb8hVG8W7WFdqRAVheSbOtmjRfKx
	 6coAf7PdgM6MmmSDE1a7Pde9SC0V99ruVX3fw1DJL8WyBmoaBoHkIjjdVPQzWIgAo/x2O
	 kkFimi1YS1Qo3T84dp6j2MdHUQQonXtV7WU5aIQnTDL/WTfOtESeWunvD64E1g9cUv5+z
	 Gvfdi8UKbv5AU7XfufAlTYykmBRSNqQaDjsXMc6dKC2aZq8hLIAjXtDhnTZ/0H6NZq5fb
	 iHv7M8Ued1MH2KPm702Gp+r3JCuxQhV7sjqFK2LdZN+axxrR+tvAa1aDXE975/demqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LuIyU/xm";
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33F606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC33F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LuIyU/xm
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2f04b676219so29168635ad.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795582215; x=1796187015; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WZpqROJT0TFZ0N9AeyXaUSyo/Ga6Gz526tDibJ18xQ0=;
        b=LuIyU/xmh3BDPSXKUR92JkBXXf570oqi3Y8UK36zn1m+izg3teFHRAvTAlsB9d4Yrt
         jiyFW/a/MDgD+SiC5LcOCuHZl/d0LZ9ojLoiBiRbLUPiAXPE8V1tn04Z+xZZ9S02OkHv
         q74wRiIEDaVGWFMdQDDSj8tnr6h4jMIfQmwG8BpiH8brOWUXWyLafDX1bdQcLxyv3+Xk
         2qTfSxK48tIV1vEIW0cJO/CVnuRR6zspU4WW7VZfJtZDjxb1iPSXnQfotUjBi4HNNeuy
         HVpkZPW9A3Lq8RWbFGAs1/Whr/lJFzu2iS7gC2zjV4p1SX5A+QZxBfDnIkWGH6l0Zzy+
         7YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795582215; x=1796187015;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZpqROJT0TFZ0N9AeyXaUSyo/Ga6Gz526tDibJ18xQ0=;
        b=h7e7od7Ii3G13l9lfTwU/waU6mmEi0+12MpoAhTtZc9hAHyXPbFXmmnhPdavmhf+hn
         ns10cNNGDhdqADNUNdSi7cc2wO/qEvzZriopqr3hCrntxdG/bw/koBErEiX9B20XkpLd
         Gzw8GNan4l2Je2wiR5c85/sz6KRE3o7DCVnjZik2+G3gazBW3ise3fwYt4K7OjUQyvCm
         GVCsfrrnpXL3AN2SFC1ESbbwzdl/S5oS1z/RyBvNBdSJXmS533LtNHocvEJ/OPyPcyf6
         m6tTW9SKNj2BEYnZa3f0Z2gRMjSfg19ZqAvUwP5WUFoh/YKSoeXgBcTq/PT6hcZflQAY
         x89Q==
X-Forwarded-Encrypted: i=1; AL+hErG5KriHJc9p1iUXC75Qm0gRbr3AEU1kYgVzlLqojzQAEM7NnKQFDyI7rlVo7dXwHvchf10=@vger.kernel.org
X-Gm-Message-State: APuU4Z+U3GsffsIwNfH1v8DxUQCwimZSNHGO0HYihbspB+3bGxkcGynd
	VQv38DzjGgK9WWsEbESIX8Y95npxR8smUOrTc2WfVNtLAdEfN3jsCsxA
X-Gm-Gg: AZFdTZewjcFRLqAxRFJwAvH+rWrjTFlUr9Dej83gA0KEH5+a6Z39PukBI7UFLaYBFU1
	XxM082zxl5AOb5obVLBpxwuZHA/HYzUZvLlmVtKHLCtu0oUs4voB0iIaPllaHJWokJrG/kiqgo4
	qG260MzHVnrdqjlxajXYBDWRZteqb89+e7ok6TCmJVGzfCkkvDqvZYt6SNq/WpKRksQpeDTTMON
	C+0gpGRVIsgRCAvbLh5K+sIcl8ryLJHD+zhzr3SNao6dOyQ1DfKRT4apV5GRlO0BQHQUpSxNy3S
	+RTCDmLAWCpiNvJ8RiUCrrcxn/i3U+ZWVVv3kvhIoEtf7/rua4rvamIWgD111H1/LLM8CXMHH9s
	qhnr8cgEIBO/qY2kvdzYcfwm6BTgqHolg5Jy3rvGkkw/90i/+FiB2ZQ96Ki9lP0bx2N9s+GwGff
	0qVvBmxETawQJy4DFob/1/5TneVo4uVhjGMU4Pe9HtFZ4+QKoDAaReU/dog1KHxyRCsMJCaZg0N
	Lz/9bJWFMG5xqwsgLqAyr2yUJNQn1nGGiufsM6C8z4+DEx3AGADcf+CQTtJfZE/dteAqdXUWWAy
	A5lmRVPgEIqA4FHXQ85BjLngfCmjHxkcA9GknmoH+XkHXTCFcRRMfn75M/eawavuB38AyxbKqYH
	NyKCJdFWRiKuUahQzDaf5JZeFoxfhZqWYMKHelupjpwMAdSE5yyoIdDA=
X-Received: by 2002:a17:903:b4f:b0:2f0:22fe:65e5 with SMTP id d9443c01a7336-2f03f1d0f8amr148657735ad.60.1795582214938;
        Tue, 24 Nov 2026 20:50:14 -0800 (PST)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0457fd68dsm70131345ad.39.2026.11.24.20.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 20:50:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 04:50:13 +0000
Message-Id: <DN40RTGK98VJ.2XIDDVK3YL2ZC@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tobias Philipp" <tphilipp@gmail.com>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Felix Fietkau"
 <nbd@nbd.name>, =?utf-8?q?Thibaut_VAR=C3=88NE?= <hacks@slashdirt.org>,
 "Stijn Tintel" <stijn@linux-ipv6.be>, "Daniel Mack" <daniel@zonque.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Align lpm_trie map values to 8
 bytes
In-Reply-To: <20261124225055.87344-3-tphilipp@gmail.com>
References: <20261124225055.87344-1-tphilipp@gmail.com> <20261124225055.87344-3-tphilipp@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 02:50 PM Tobias Philipp <tphilipp@gmail.com> wrote:
> misaligned address. FEAT_LSE2 relaxes that for LSE atomics that stay
> within a 16-byte block, and for LDAR/STLR only if SCTLR_EL1.nAA is
> set, which Linux does not do. The fault is not fixed up. This oops is

Not quite. With nAA == 0 LDAR/STLR have the same 16-byte rule.
nAA == 1 removes that rule for them.

> Round data_size up to a multiple of 8 when computing the value offset
> and the node size, like hashtab does for keys. IPv4 nodes grow by 4
> bytes, IPv6 nodes (data_size 16) are unchanged. Add a BUILD_BUG_ON()
> for the offset of data[], which the alignment of the value relies on.

4 bytes can move all nodes of a map to the next kmalloc bucket.
There is no need to grow. prefixlen is at most 2048 and flags has one bit.
Make both u16. Bytes that bpf_mem_alloc asks from kmalloc on 64-bit:

  data_size  value_size  today  this patch        u16
  ---------  ----------  -----  ----------------  ---
  4          28          64     68, kmalloc-96    60
  4          60          96     100, kmalloc-128  92
  16         16          64     64                64
  20         12          64     68, kmalloc-96    60

BUILD_BUG_ON() and four copies of round_up() go away.
So does the new comment. It's not in kernel multi-line style.
32-bit still needs patch 1.
This is in place of patch 2.

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 4d6f25d..72084ac 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -25,8 +25,8 @@ struct lpm_trie_node;
 
 struct lpm_trie_node {
 	struct lpm_trie_node __rcu	*child[2];
-	u32				prefixlen;
-	u32				flags;
+	u16				prefixlen;
+	u16				flags;
 	u8				data[];
 };
 
@@ -40,6 +40,12 @@ struct lpm_trie {
 	rqspinlock_t			lock;
 };
 
+/* The verifier assumes that map values are 8-byte aligned */
+static size_t trie_value_off(const struct lpm_trie *trie)
+{
+	return round_up(offsetof(struct lpm_trie_node, data) + trie->data_size, 8);
+}
+
 /* This trie implements a longest prefix match algorithm that can be used to
  * match IP addresses to a stored set of ranges.
  *
@@ -286,7 +292,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 	if (!found)
 		return NULL;
 
-	return found->data + trie->data_size;
+	return (void *)found + trie_value_off(trie);
 }
 
 static struct lpm_trie_node *lpm_trie_node_alloc(struct lpm_trie *trie,
@@ -302,7 +308,7 @@ static struct lpm_trie_node *lpm_trie_node_alloc(struct lpm_trie *trie,
 	node->flags = 0;
 
 	if (value)
-		memcpy(node->data + trie->data_size, value,
+		memcpy((void *)node + trie_value_off(trie), value,
 		       trie->map.value_size);
 
 	return node;
@@ -557,6 +563,8 @@ out:
 #define LPM_DATA_SIZE_MAX	256
 #define LPM_DATA_SIZE_MIN	1
 
+static_assert(LPM_DATA_SIZE_MAX * 8 <= U16_MAX);
+
 #define LPM_VAL_SIZE_MAX	(KMALLOC_MAX_SIZE - LPM_DATA_SIZE_MAX - \
 				 sizeof(struct lpm_trie_node))
 #define LPM_VAL_SIZE_MIN	1
@@ -598,8 +606,7 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 	raw_res_spin_lock_init(&trie->lock);
 
 	/* Allocate intermediate and leaf nodes from the same allocator */
-	leaf_size = sizeof(struct lpm_trie_node) + trie->data_size +
-		    trie->map.value_size;
+	leaf_size = trie_value_off(trie) + trie->map.value_size;
 	err = bpf_mem_alloc_init(&trie->ma, leaf_size, false);
 	if (err)
 		goto free_out;
@@ -766,8 +773,7 @@ static u64 trie_mem_usage(const struct bpf_map *map)
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	u64 elem_size;
 
-	elem_size = sizeof(struct lpm_trie_node) + trie->data_size +
-			    trie->map.value_size;
+	elem_size = trie_value_off(trie) + trie->map.value_size;
 	return elem_size * READ_ONCE(trie->n_entries);
 }
 

pw-bot: cr
