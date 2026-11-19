Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103645;
	b=TG0b1bKc7ll1CAOw1pzoG6Zuq5CPQWYEBcVYSQ4+Ht7DHXu+ppZ+lrp4O7gOYRRgaP43
	 KFO8t1FJId/NURvt3C1RIKFDUJk2D8uWiYG/Jifj+TcsOXbD2/ttewVlkCdL1bGZsGXHM
	 LiQRRYQ2EBLxbzpcW5YjHn60yTYbBIaSpNcwFJ2W2dsZWcW34gcWtzcVjBOZcwUFOUzG/
	 yNw+nOUo4dlcav8xqRUnEttqodUq3MC1SnWgl916UArox43/7h3i6dI6N0flq8h1SQwFG
	 +0Hck64kTwTZXze3Oq4VKuVqB6+4Dmljl0ZR3CdaJQH0d62JkzVe0s2yQX9OsEUCYDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=F0SQUheoB5ELX+Stc1tUHAmTGAXRgJ8Tol+p4ejOW7M=;
	b=SaDI7TYgNtp9pxWozKkjLItYzbixIOpEQ2RMLy0SuK00c7YDf5EXMXz8jODVAxbOzfJ9
	 AA3mPVXyQyQT8XYafhWA7b6Hxikzwedu2tF1Bjh2Uw78M3sdROhJFbGqU9MKILExAFxgM
	 B5tumkFWyaSTc32FW10ztxjidPRfWmfRSNhEW2z+iL517dr6HHF8RrZuCMJ7HLjDWehVA
	 lv1B+/bDjXITcmD0N2fG4skBod/8qAYjO/mFFjmLgV0uVNQUiyBCI159HTyqV5XV7ONUb
	 61rHuUeVMEl8Uq+QirFhYpaB/+Gq3aRyymTAzpthiQARV4TSsKBDMpKSohELq3PJJKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cRZQ75Bi;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE05606A330
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 15:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CE05606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cRZQ75Bi
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso17166625e9.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 07:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795103643; x=1795708443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0SQUheoB5ELX+Stc1tUHAmTGAXRgJ8Tol+p4ejOW7M=;
        b=cRZQ75Big7C+Aui7CofpSZewEx6kLQaua7lk5OJtpc27T/ZZmuhgfteAVLTmpLBX5Q
         /0l3LwBBdObFwvSTLpMQ3ZrvwxU5+x2njRWyQMRx+OBRWHeaDqUUUQk//n8FmLFLmJn1
         a6OAFNsNkWNZ2HLRkcbcuukz8nlOuQ/d89lyoayORJ+RU3PfH3lv7qQoWINRNFSbZ4Tu
         2PEAtCWFSZ2ySoU+tOczXu74T8v17xUn2PYW+SbukBJ/LBG1AxQ0y34TgNx/fvGsJi9B
         Y18ZR3fyCIsiui8vDkeX/IYSP2GuPyuAMZG/6lacWw7qvIWzOVCQSuRIk08S5XocYI0c
         n5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795103643; x=1795708443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0SQUheoB5ELX+Stc1tUHAmTGAXRgJ8Tol+p4ejOW7M=;
        b=Wri/GFMikKzHGHuoJ2cnhttjClEeKo6Ave0v6R1PObrQwIVG2iqmHdc17m5y88kKuL
         n4kUv7z664Jfa7ZELSNLEkEMRALFd6dJh5A4xNgwLSXXLUcMHqaaYfNQoGXkKlZoqaeF
         YGy0Z7ceUXKiXXCihQT3kHLzA4n+o4la10OnllMedp+LZ/XID0igMjh97qTUmv+jo9Db
         uIJf29iN/zY7aI5y5e7aL4qig+UgwP6BJ6q2GERnD2YmtHhBzlw+NHYxuGD/qsnyhkNk
         qKhNCDIuVOgXXx0cErFlRtLRU+7Bv2hvORisGP2OmkHGrDP9NgjSOjETyDIorfpIgLWj
         jkJQ==
X-Gm-Message-State: APuU4Z8cRYjI5LtiS5QYts6CYhw9J6qEybCNaFMc9G7xOlUizpd0UAdE
	rzaRZ4RIM2c5WXAs40X/DtZQ/xJpVSBvJKw7MFJcsJffYuU7vSMqa5kbr0K13ik=
X-Gm-Gg: AYBFou0Bd45znFRI8Y/5SkKHU0DM2XVDc3wCtn9QBpFX6UmJ1w5Eo5n3YavoFnr6fsF
	fUJA5g5RO6v8MCOiH/0qve63jxNCHHirOrits+P01foNYERFbI5G/dDKb96JSbnSrHASA2w7/HI
	oaQFr1mxZSTYJp+17EJ4+6JpJxgfmTGoWU3gv82oqwGRKJB7wxapS51frt8lhVhdvdYmA/cTa5T
	k9srHO1+xD8H4J/NTLfiITRIeth6klQ9jt9XiUP9CZsFL5In8ETe79dCMjU+5Fxw5gRjI/ODOga
	4Rvryg6c5RQJXywrJ+GvzMEA90+9ckgO7bXk7bj8EmOE2dIWe9t94lZVh3JX8xTgFv1bcUx7H2I
	di02PcReVYnONLACQ9kncd5OBSx6SWEYhDtmfYAoW/Qbe3IBHlFhPHqg61On6huYEIcwBn1iReN
	2ejYZ/cP4FEcyGJGtCO0uVl+5Ltv6lOAL7h/bM+xuoJzt7wcBRM9fOj9FabYoI9tNdx5QQoo4NV
	VQUopEkBYIqDAVSxe2hw0rL7kW9mt5EXKKanC2fTfx7D5JF+Sydm6sGz68G0ErsFM/SSSiNnOKe
	Jx1OYRDAdGeWrcnDdXKcysYQ9zmh0ZHZJe9OWqWLiazfroZ4xDlLZ+lKTxP2kho1Z+aq6BhQPf1
	AY+e6DRll/s5qNmBXjvKKUmZi0X5NZEKxCQwwCabf5zu6/uAWhIWXTyT10cOJToL+BA==
X-Received: by 2002:a05:600c:548d:b0:4bb:68b9:f615 with SMTP id 5b1f17b1804b1-4bb7da1c132mr135943865e9.17.1795103642713;
        Thu, 19 Nov 2026 07:54:02 -0800 (PST)
Received: from localhost.localdomain (dynamic-077-011-218-131.77.11.pool.telefonica.de. [77.11.218.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm43496755e9.5.2026.11.19.07.54.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 07:54:01 -0800 (PST)
From: Tobias Philipp <tphilipp@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Mack <daniel@zonque.org>,
	linux-kernel@vger.kernel.org,
	Tobias Philipp <tphilipp@gmail.com>
Subject: [PATCH bpf] bpf: Ensure 8-byte alignment for lpm_trie map values
Date: Thu, 19 Nov 2026 16:53:17 +0100
Message-ID: <20261119155317.11469-1-tphilipp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The BPF verifier validates the alignment of PTR_TO_MAP_VALUE accesses in
check_ptr_alignment() only against the offset relative to the start of
the map value, assuming that the map value base address itself is at
least 8-byte aligned.

While hash maps enforce this invariant by rounding the key size up to 8
bytes (l->key + round_up(key_size, 8)), lpm_trie places the map value
immediately after the key bytes at node->data + trie->data_size without
padding. Because trie->data_size (key_size - 4) can be any value from 1
to 256, the value pointer returned by trie_lookup_elem() is only aligned
to (trie->data_size % 8).

In particular, for an IPv4 LPM trie (key_size = 8, data_size = 4), the
map value base address is always 4-byte aligned (4 mod 8, and either 4
or 12 mod 16). The verifier accepts 8-byte atomic operations
(BPF_ATOMIC | BPF_DW) at 8-byte aligned offsets within the value (e.g.
offset 0 and offset 8), but at runtime on arm64 the JITed 64-bit atomic
(stadd) faults with an unhandled hardware alignment fault (ESR.FSC =
0x21, crossing a 16-byte granule boundary on FEAT_LSE2 CPUs, or on any
4-byte aligned address without FEAT_LSE2) and panics the kernel:

  Unable to handle kernel paging request at virtual address
    0xffff00000159db6c
  Mem abort info:
    ESR = 0x0000000096000021
    EC = 0x25: DABT (current EL), IL = 32 bits
    FSC = 0x21: alignment fault
  Internal error: Oops: 0x96000021 [#1] SMP
  pc : bpf_prog_cc9155b98965fc5e+0x64/0x90
  Call trace:
   bpf_prog_cc9155b98965fc5e+0x64/0x90 (P)
   bpf_dispatcher_xdp_func+0x14/0x28
   bpf_test_run+0x11c/0x360
   bpf_prog_test_run_xdp+0x358/0x548
  Kernel panic - not syncing: Oops: Fatal exception in interrupt

This issue was found while formally specifying eBPF map-value alignment
invariants on Linux 7.3.5.

Fix this by marking struct lpm_trie_node's data[] flexible array as
__aligned(8) and rounding the value offset up to 8 bytes with
round_up(trie->data_size, 8) in trie_alloc(), lpm_trie_node_alloc(),
trie_lookup_elem(), and trie_mem_usage(), matching hashtab. Verified on
Linux 7.3.5 (arm64 under QEMU) with an XDP program executing 64-bit
atomic adds at offsets 0 and 8 of an IPv4 lpm_trie map value.

Fixes: b95a5c4db09b ("bpf: add a longest prefix match trie map implementation")
Assisted-by: LLM
Signed-off-by: Tobias Philipp <tphilipp@gmail.com>
---
A standalone reproducer is available on request.

 kernel/bpf/lpm_trie.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 4ef9c8c9f3a2..9b4e38d16f21 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -27,7 +27,7 @@ struct lpm_trie_node {
 	struct lpm_trie_node __rcu	*child[2];
 	u32				prefixlen;
 	u32				flags;
-	u8				data[];
+	u8				data[] __aligned(8);
 };
 
 struct lpm_trie {
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
@@ -598,7 +598,8 @@ static struct bpf_map *trie_alloc(union bpf_attr *attr)
 	raw_res_spin_lock_init(&trie->lock);
 
 	/* Allocate intermediate and leaf nodes from the same allocator */
-	leaf_size = sizeof(struct lpm_trie_node) + trie->data_size +
+	leaf_size = sizeof(struct lpm_trie_node) +
+		    round_up(trie->data_size, 8) +
 		    trie->map.value_size;
 	err = bpf_mem_alloc_init(&trie->ma, leaf_size, false);
 	if (err)
@@ -766,8 +767,9 @@ static u64 trie_mem_usage(const struct bpf_map *map)
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
2.46.0
