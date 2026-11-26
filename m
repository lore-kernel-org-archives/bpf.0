Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795722238;
	b=CaDwltsHUI5O7QVHRlLYAXWD5z9v+A9W8woxbBw+2vsfw5enQ0vAg58qylr+jygVJ2qz
	 NXGHmdHIzYM/5zrZxjYdtkn5f2UU4gThWu0dB9wUOg/eCNUMWLgR94cOv+Gkb08PeFpWR
	 4gfFCdb148TAUDmhVQ1d6ZS3cTIdahlzoHSqrRtsU5Drd4ETg4XeBnhLBaKcDkBUwS/ql
	 kc7mmjHoFMWqKqLej8svzOPGKO29dp6B9hkxDom99KNY+hFBBJYihxN6kzJAssejMjvs/
	 NNogUNEQxdx9RF8nNIJyUtVAg9OAt8a+c9+bUMaMJrnmls/RI59xn8AZ12lc6mUFucQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BnkFZTPH4GOUqir1kCk9Cv39W3Zv9BvNJCi3IdBbyjU=;
	b=prFFT03fGKlO9B+aFJNmaBF5d/ehfHi8lYHBgTP3D/l6wrG+mdsf/MYgF3xmbpNDNIU2
	 BOzUaknjC9EwiVQTxZxFkkSuEJpXP0h/WyaZ54UZLmg0olhPPitMdK1WKrUN8JfIIh6FO
	 Slk3l+crmc7RopfmuRNMBxPgVpR8XELccmLQYnaC4GF75MApVSz+aQUuYGynG/9qOwI6y
	 8YjYGz+hsbXpHZkvyO0nhrNICTpltzu0NIgynakBUwRKpshN8DKnY1dGl8V8MUpy1pddf
	 ZGiKLZ1ekNlrS+3G4YxDywY5+BWGTa1+CqkconU7Ouh+g+fY2zYog+yvoikoT2cvBIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0417aK2;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C63606A693
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 19:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C63606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0417aK2
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso70664965e9.3
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 11:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795722236; x=1796327036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BnkFZTPH4GOUqir1kCk9Cv39W3Zv9BvNJCi3IdBbyjU=;
        b=c0417aK2h4DeaBfC8O80Gmv2V1OcMVKosw053rakSHQDG5HN8ItGEGalDt3r8BanEN
         +slBLNCOnKaBr6UByfZpHBEuMHs7aKVXSvo40HPMsb00gFPRyvlJsdgWvW+r4wCJo2No
         tj0zCuKH/36RKdxihfEiL5oLgp3xMSekszdFbdTAfycOfPa5MKaIjscudhQxnS3gl5vd
         NTmqP9jFT407ueJQL02avxySJhlJTOJIVFGBhUN6tVcPhNV5OML0NOltG/QeNqDakqyd
         +q6Bd26C+Anw7cXUpsXaYgGDFgzpY+JvTuj7ZatoeqRGMN7YV3qugqxM1XyPW7JkBdNx
         foMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795722236; x=1796327036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BnkFZTPH4GOUqir1kCk9Cv39W3Zv9BvNJCi3IdBbyjU=;
        b=U7XUPsBT0OH5cGpnaCw5efPIUI2JcmRdvdHK18/wAEDT2j+g7B7R6MyYoCWChPnZzv
         DpjJ3neWRb1We7CP36f9LxV9dJbKaWvigUqtgK3As+8SANDLZSJ6ojxPBCz4c4pW778G
         4fxbl2O94NzCkkRyssVu2PwOcjy14BD8gxHcab+VOV0EKOq92QFULxUo8/R/9I89UO0o
         IUc4VwoRz6n5NEctAz52WFgIM4GebdsBRFOtgRAWaFWE6a2mGLynHiXlFEoguVE5jIy6
         KVm2L14rqDkLJ66pvslcxPpjB2M/4258USxlmHZ1j6S3zLt4cvxvJ38/tyW1+yrmN21F
         W6MA==
X-Gm-Message-State: APuU4Z9hHR2LBKniN8uLypFHJ/Zu8ZKk5Xp7PQ8OyL6kKOnvobg1+N8Y
	csPg5s98D5eI0M/e4fdqnSvhieVwBe3Y/IItxPgufenzdtUD7hNIVAg/F0BavhU=
X-Gm-Gg: AZFdTZdCZte4+RohzB2smZsd9g5tpSeCXzsLld+Vl2yqRhLnhyQmFMQ6t2Zq1uZa3GG
	sV1HDtafXtR5nZdS2e1QGa7RQ0pmEdM+a3N46cr9r400FzQSbd6tp6d8jF3yiOzOVqRPsSIhmsi
	RZtX3tJdTXwoYif43yt8fX5Pjsg8DA7X692sm2p9MKVDTlHkTrdIehRL5gM2RQ1VIrRiVnBgryw
	iMqGdeSxh69NSdN8zns5o0CLRgFUxBrKSasLmouKxK57abvpwvLRhE1XDELvRSwobNceRv/to4d
	cDDmVjOlnG/Izq4HCnuRi+/Alo+UAREPBGAE65aRPgv8qj1mE1fSyRgddxIXlVfJyCuiClCblBe
	SJRD/4Fzb3ioYDwtTaS+bXcS6UroijTAc0GF8eF7HUgybYmA0NClm1VTaL/kh/jzgPr7IlxkxRM
	K+HJf04OClM/0fSibEq/JjdsC3Ro4Pp9R+2MFL2Fr7sUXyhQKY/Y4DaHudEl5H5YuegY3rv94O2
	LQMi1dDAPT5P43Yntzw3wmPclh9zzGQRYT8t+6Z3F8RyZ9wWinzpoV/dcCvkj8xdUVXfwbgAYrH
	nxPYHgb0abnFqvhRnPviOH/osPK+83M3AvQ7nK7FuHJ2yVy52jt5icnoC6BeKc4q/jsrznOlLB7
	cLQI8WJa0KDIfa0UwRtFz1AwSC/sOkUYS0nXqsQ9Mk10bWB3cWpzoJt6a4WHkjipRD7dryBuliW
	lLLZDd39zjQPbSjEY0cwHbd4O6xuZbgcTQ
X-Received: by 2002:a05:600c:a088:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4bb8880b7bamr398332865e9.18.1795722236197;
        Thu, 26 Nov 2026 11:43:56 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-2317-a900-4811-d431-309f-6626.310.pool.telefonica.de. [2a02:3100:2317:a900:4811:d431:309f:6626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm43663924f8f.3.2026.11.26.11.43.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 11:43:55 -0800 (PST)
From: Tobias Philipp <tphilipp@gmail.com>
To: bpf@vger.kernel.org
Cc: Tobias Philipp <tphilipp@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	=?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks@slashdirt.org>,
	Stijn Tintel <stijn@linux-ipv6.be>,
	Daniel Mack <daniel@zonque.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/4] bpf: Align lpm_trie map values to 8 bytes
Date: Thu, 26 Nov 2026 20:43:45 +0100
Message-ID: <20261126194347.42466-3-tphilipp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126194347.42466-1-tphilipp@gmail.com>
References: <20261126194347.42466-1-tphilipp@gmail.com>
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

The verifier checks the alignment of PTR_TO_MAP_VALUE accesses only
against the offset within the value and assumes that the value itself
starts on an 8-byte boundary. It accepts BPF_DW atomics and 64-bit
load-acquire/store-release at 8-byte aligned offsets of a value.

lpm_trie stores the value directly behind the key bytes, at
node->data + trie->data_size, where data_size is key_size - 4 and can
be anything from 1 to 256. Nodes come from bpf_mem_alloc, which returns
8-byte aligned objects (on 32-bit architectures since the previous
patch), and data[] is at offset 24 (64-bit) or 16 (32-bit) in the node.
So the value is 8-byte aligned only if data_size is a multiple of 8.
For an IPv4 trie (key_size 8, data_size 4) it is 4 mod 8.

On arm64 the JIT emits LSE atomics or LDXR/STXR loops, LDAR and STLR
for these instructions. They raise an alignment fault on a misaligned
address; on CPUs with FEAT_LSE2, LSE atomics, LDAR and STLR only do so
when the access crosses a 16-byte boundary. The fault is not fixed up.
This oops is from a 64-bit atomic add at offset 8 of an IPv4 lpm_trie
value, which crosses a 16-byte boundary (Linux 7.3.5 under QEMU, HVF on
an FEAT_LSE2 host):

  Mem abort info:
    ESR = 0x0000000096000021
    FSC = 0x21: alignment fault
  Internal error: Oops: 0x96000021 [#1] SMP
  pc : bpf_prog_cc9155b98965fc5e+0x64/0x90
  Call trace:
   bpf_prog_cc9155b98965fc5e+0x64/0x90 (P)
   bpf_dispatcher_xdp_func+0x14/0x28
   bpf_test_run+0x11c/0x360
   bpf_prog_test_run_xdp+0x358/0x548

On x86-64 a locked 8-byte access at 4 mod 8 is a split lock when it
crosses a cache line, which is fatal in kernel mode on CPUs with split
lock detection ("Split lock detected").

Place the value at the next 8-byte boundary after the key bytes. So
that nodes don't grow, shrink prefixlen and flags to u16: prefixlen is
at most 2048 and flags has one bit. data[] moves to offset 20 (64-bit)
or 12 (32-bit). Bytes that bpf_mem_alloc asks from kmalloc on 64-bit:

  data_size  value_size  before  after
  ---------  ----------  ------  -----
  4          28          64      60
  4          60          96      92
  16         16          64      64
  20         12          64      60

This patch and the previous one have to be applied together. Without
the previous patch, nodes are at 4 mod 8 on 32-bit architectures and
this patch misaligns the IPv4 value there, which is aligned today by
accident. Without this patch, the previous one misaligns it.

This was found with AI assistance while trying to verify the
correctness of map value accesses with formal methods. The code follows
Alexei's suggestion; the commit message was written with the help of an
AI coding assistant (Claude Opus 5.5).

Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementation")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tobias Philipp <tphilipp@gmail.com>
---
 kernel/bpf/lpm_trie.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 4d6f25db9..72084ac79 100644
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
@@ -557,6 +563,8 @@ static long trie_delete_elem(struct bpf_map *map, void *_key)
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
 
-- 
2.54.0 (Apple Git-157)

