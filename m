Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560670;
	b=yiU6JkePsxQohaB2XXCDiC7InI7EePmDxte8DFlPYYo4dAaCF06SfFOzLfXqCXcUrVK0
	 Mx9svdwL0Elgc8Bx1kPt3ZoJ7x9QJqLzeYJz1wKSpDoJyiI6sSU6RKb+/oqCQaucIrD2a
	 Ff5Xkr2N47kkuKMPbvbM/QqT8Z7cURVNTX9eToMBux15foUssj6jd6G2Th62aZT2roT6O
	 JOW5xIR6vOCQbsBjFXmr3S5nZ27j3+pgelFSp3e5vyXMS8iNVsCHR6/gaE75duYsXabep
	 YXwAG0lE573zAoyX90gtxfarlCLYdMTSLeQE0HPhWtfoQNNnCZE6VUrIF7xxXnQMYpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8fbqFXfnJmZ5wlNeBVcYahiL5PvY2DhQX6o+WRRQBHU=;
	b=XQuJOzvXGAQnYMBzFDe9+v9oJiA1gFZRUcdxidC6eE9C/IKX5Z8oTpHBfGgYQ2AGsdL7
	 g484sLTYslcta42gc+7POxhnQNXjLIpdEvithT73rRZehjP5NPIqJIMHDe8Y+qttyTTD+
	 pr2w5mE8Z91632pCGf0Ap0tT2GuI73YDb2ICoGrV82ko8klOekElHSaQBMGm2G2BU956+
	 kSY6CwWaEP2zPNpP34QrtHf7muf5mAHcB1cvoqSYh6MPQKI7iZNI0y6nGR8QKtmi9k7Ho
	 U0j62oz9BtFUpuBXfwftNr3BThEW/Y7Lu4vF3cgjSpV6DMaYqAhEG4RPZjBbJMXGTQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GCdFeoTW;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF0606A69E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2BF0606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GCdFeoTW
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso36576375e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795560668; x=1796165468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8fbqFXfnJmZ5wlNeBVcYahiL5PvY2DhQX6o+WRRQBHU=;
        b=GCdFeoTWhhvd2pA4jmshxSJGXNPRUZNH67/i8ObsgUB1JZxDHmGK3mdIOqwQPjyViC
         lz6/JqDiNWB92qK4G43yckMYusH5A0jEpSUcDChtrQ6VSXVxfuz2xPRCklFLkg+eF9Tx
         TDQcXH9ldQ5ozQcKo2tG9Gb7uuEJWtP7rRcsK8lPetm7LWwbVXJmtbqcP5nPLaOTAhUZ
         aST/YzJnKL6jDsMzAqYBcvuNdkte+C4841S8XhQdI5n9zuM+xhTeLFWwEvMwg1Uet0JA
         A9jNjlb7B3B9ZRLtQixaO8caFViJteaXCYBhn4QZB6maKkNhABs4DmYMDYZVjmOGLqz0
         v/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560668; x=1796165468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fbqFXfnJmZ5wlNeBVcYahiL5PvY2DhQX6o+WRRQBHU=;
        b=SpCvW68+Hy3p0BlLQBq+dkre2BbPwIASg/ktpnBgzuAPyaAGUUzebrXZFLM4UPelUs
         k4wkz+ZLRQVb1fZ/wuUx/u6rP6PYXkO7T9q3bcbCrvNoukjJskW4r1Mj2ZR3x7uXTI2o
         BioThWkYN5mbLaqbpFxkS1DBFj5ZDqDIhKgbPMZNZxpZVo28pNQre5X1s7YjgTGGd6PQ
         AVsTBHc6FQSdpaiIr9NkGSfcDjX9CRVDovBS3RE2f4Tx48+3MdVFrJ4mFhiuLbsxW9SI
         ZwKwU81xi5aabvr2W/tOAGOPojmos3EBXri96qKWOfZJT5E//xeb3mfXnmKqyQO30Pwb
         MYlw==
X-Gm-Message-State: APuU4Z+ivx+/O88uEDmaNjzYbCnBdAjWaDzxPALnzFPmCJvdkHNogEor
	a7s3nhdqy7r5n67S2L0IHXcsgBRrWBKDMLvkz0mjvOlMqNojsNQZvCN7Sv0JKSM=
X-Gm-Gg: AZFdTZdOG1t73rT+b5FUiyGVhXZ4mBEtoeDa6LZTo17KRjt/CVdFWeGUD94jM7N0C07
	4vPy1y35tevvSyOY69b218QBDYvDJvyXKM2bITA3D8GT8+YiU+D6vjBIHLAsCi86UkVL7P9e/vt
	0MSnC2g4Zmgu/k8GjuxzbOx8bh16YP/QJHt+nANopoNu1vPARX4eYnonsqxGgJx5D9tGkp8F9jW
	vNgDBL9a5m70GIKjDjrmAi8NFt+cM3bDxJfZ6L3haUJznWbqOOMpO8BwoqtR8V9+F1O8HcbCpL6
	7CdkQPTEnnphkYvXinjtHQvBTSNo5HVgXr9erhrc95jrd/gW4BYa7wp1OiztvYoqeDi0B5BZ6+r
	j8zu5FYKiNaJxWtt2jnMv82T0L1t19hVvmgBTNq7CQQwjrZEOsYJzZEgrbAsv0h+hmc3TXf7Ygg
	+wtt/epzjea/0JI0LNoSu6ptPSi6qySvh8UpzPkzZR9pAYq3fxdJ/EkZTTby32JyEF06nYkLF/m
	NAwXFkbCDkwFl6p98gE+Z15cUeDF93XfLn1RzBBeGo05utpzzXjTZ40bPNMEOc3GHpVWZWS9ALS
	NmmRO8CA5RQnwBB8mcK6mpap/0Cw4oC78UJ6SlHkCHi8hGiQ4LkatxlibmfEE3g5hT+0UDrb466
	k1hFPiPHJSsGqnhaVKGUDIz8MRQqqlcHTAKd337C07yz+JvnEmn27BReyycLVBwNZ/78pqxSbOp
	zgd/Adda7TYPngdS3It0aRrxvsd5p69Lgv
X-Received: by 2002:a05:600c:4f0d:b0:4bb:5c97:f4b1 with SMTP id 5b1f17b1804b1-4bb8881941bmr368118945e9.24.1795560668275;
        Tue, 24 Nov 2026 14:51:08 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-2ec1-8a00-a10d-4335-1e05-e7ae.310.pool.telefonica.de. [2a02:3100:2ec1:8a00:a10d:4335:1e05:e7ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm393839525e9.9.2026.11.24.14.51.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 14:51:07 -0800 (PST)
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
Subject: [PATCH bpf-next v2 2/4] bpf: Align lpm_trie map values to 8 bytes
Date: Tue, 24 Nov 2026 23:50:53 +0100
Message-ID: <20261124225055.87344-3-tphilipp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124225055.87344-1-tphilipp@gmail.com>
References: <20261124225055.87344-1-tphilipp@gmail.com>
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
for these instructions. All of them raise an alignment fault on a
misaligned address. FEAT_LSE2 relaxes that for LSE atomics that stay
within a 16-byte block, and for LDAR/STLR only if SCTLR_EL1.nAA is
set, which Linux does not do. The fault is not fixed up. This oops is
from a 64-bit atomic add at offset 8 of an IPv4 lpm_trie value, which
crosses a 16-byte boundary (Linux 7.3.5 under QEMU, HVF on an
FEAT_LSE2 host):

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

Round data_size up to a multiple of 8 when computing the value offset
and the node size, like hashtab does for keys. IPv4 nodes grow by 4
bytes, IPv6 nodes (data_size 16) are unchanged. Add a BUILD_BUG_ON()
for the offset of data[], which the alignment of the value relies on.

This patch and the previous one have to be applied together. Without
the previous patch, nodes are at 4 mod 8 on 32-bit architectures and
this patch misaligns the IPv4 value there, which is aligned today by
accident. Without this patch, the previous one misaligns it.

This was found with AI assistance while trying to verify the
correctness of map value accesses with formal methods. The patch was
written with the help of an AI coding assistant (Claude Opus 5.5).

Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementation")
Signed-off-by: Tobias Philipp <tphilipp@gmail.com>
---
 kernel/bpf/lpm_trie.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 4d6f25db9..44ad5c163 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -286,7 +286,7 @@ static void *trie_lookup_elem(struct bpf_map *map, void *_key)
 	if (!found)
 		return NULL;
 
-	return found->data + trie->data_size;
+	return found->data + round_up(trie->data_size, 8);
 }
 
 static struct lpm_trie_node *lpm_trie_node_alloc(struct lpm_trie *trie,
@@ -302,7 +302,7 @@ static struct lpm_trie_node *lpm_trie_node_alloc(struct lpm_trie *trie,
 	node->flags = 0;
 
 	if (value)
-		memcpy(node->data + trie->data_size, value,
+		memcpy(node->data + round_up(trie->data_size, 8), value,
 		       trie->map.value_size);
 
 	return node;
@@ -597,8 +597,14 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 
 	raw_res_spin_lock_init(&trie->lock);
 
-	/* Allocate intermediate and leaf nodes from the same allocator */
-	leaf_size = sizeof(struct lpm_trie_node) + trie->data_size +
+	/* Allocate intermediate and leaf nodes from the same allocator.
+	 * The key bytes are padded to a multiple of 8 bytes, because the
+	 * verifier assumes that map values are 8-byte aligned. Objects from
+	 * bpf_mem_alloc are 8-byte aligned, so data[] must be as well.
+	 */
+	BUILD_BUG_ON(offsetof(struct lpm_trie_node, data) % 8);
+	leaf_size = sizeof(struct lpm_trie_node) +
+		    round_up(trie->data_size, 8) +
 		    trie->map.value_size;
 	err = bpf_mem_alloc_init(&trie->ma, leaf_size, false);
 	if (err)
@@ -766,8 +772,9 @@ static u64 trie_mem_usage(const struct bpf_map *map)
 	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
 	u64 elem_size;
 
-	elem_size = sizeof(struct lpm_trie_node) + trie->data_size +
-			    trie->map.value_size;
+	elem_size = sizeof(struct lpm_trie_node) +
+		    round_up(trie->data_size, 8) +
+		    trie->map.value_size;
 	return elem_size * READ_ONCE(trie->n_entries);
 }
 
-- 
2.54.0 (Apple Git-157)

