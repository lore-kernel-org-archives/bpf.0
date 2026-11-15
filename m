Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794738431;
	b=yLa3Qz1LeUIN7onbyIv4WZ9UiA/aAd3VUym59uzrrM7jhsKXga2FjSkHnl598bjXuXKM
	 oKTs/3G/qeLU2zfKLdHGQaYQqCOatU3DVysBFlf6z0MtuH92kYm5S3tnFAm8be4cKK+V7
	 DVDaOUfaqguUYzvsFptMoFYaWbLXWnIdBqSer+qDVARgEI1FU50/4LR+Xb4c/jPY1X9Qa
	 tXUx6nUA4nTTuJczeK08hXIDbLeWtT6wHPf641+xbgZXxtHjDQGQ2AF0OaLq3rvCoZJjn
	 gHDomDs+u4JwVBrIT6Ib+wek1U4lhtkSdscqghf2NUOUo8KfHwPO8vFG13eFg11wA+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794738431;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=jXLR1O68CJGYUKpN0OKPTdZnEvqOLwbLvW2QJc8w8N0=;
	b=xVk7LMUaqk4n9qHnsG4UT/RC+76dAdbEV4pmaRyo0itzSmt2E6lzOXrGR1c6ChAvbi2O
	 gFApieUW8ZtlH5avJVmlcXVEc8hD8OkFHOzwDnBws5qfVrY3upF5UOdbYSGBARSW4hCoS
	 cY8f8tHLDIaBW/VBmA1GhkvSfLlzpq6IrLi2oturJ6ZwQouAxNfoEtmF3DUhUZ7TWJQI3
	 ubO13NGR+uLXG6gjOOJzr3xh8vpsQrfKMLXzg6s2+UGOUVI8BdQM/cGF42KCNW/06x1UV
	 PPYDQq9E4M3KKz9+ueNnmcJJNbAE3rF6+UXm6o5vjeb3wSGJUkcnJLpG6qDc6RhvIFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=edynFqlv;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80F7606A327;
	Sun, 15 Nov 2026 10:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E80F7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=edynFqlv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=jX
	LR1O68CJGYUKpN0OKPTdZnEvqOLwbLvW2QJc8w8N0=; b=edynFqlvD0sFMMFYM7
	dlb6i9dJl5F6rnoyMiCyBBLIBmUZII/gr7++3T/wE/kOMQ/5HYl5vYvFbqIOcdgj
	7rULaxqEibz9v5Ghk54dwaRW7jD6sqvjTOpupaReW2YKjfH2hFCCoK0GqHRlwRNU
	fiZdLFsfYUj7XXSfNj6xBy2kw=
Received: from nec8-i7 (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3X7S+iPlqHVcuGA--.3517S3;
	Sun, 15 Nov 2026 18:26:11 +0800 (CST)
From: Yuan Chen <chenyuan@kylinos.cn>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 1/2] bpf: Use a 32-bit compare in the array map gen_lookups
Date: Sun, 15 Nov 2026 18:25:58 +0800
Message-ID: <20261115102559.465375-2-chenyuan@kylinos.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261115102559.465375-1-chenyuan@kylinos.cn>
References: <20261115102559.465375-1-chenyuan@kylinos.cn>
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
X-CM-TRANSID:QCgvCgD3X7S+iPlqHVcuGA--.3517S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryfZF15uF1fWFWkAFy8Grg_yoW5ur18pa
	yrXw1Ivr4xXr43J3y8Ja47KasrK3y8J347uas8Kry8Zay7trnxZa43Kw47Kwn8tF15XF1Y
	gF4Yva42vayqkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcsqJUUUUU=
Sender: chenyuan_fl@163.com
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gRsKmr5iMQYUQAA3y

array_map_gen_lookup(), percpu_array_map_gen_lookup() and
array_of_map_gen_lookup() bound the inlined index with
BPF_JMP_IMM(BPF_JGE, idx, max_entries, ...).  The index is a
zero-extended u32, but the immediate of a 64-bit JGE is sign-extended,
so for max_entries >= 0x80000000 the compare is never true.

With bypass_spec_v1, an out-of-range key can therefore produce
an address beyond the end of the array:
array->value + index * elem_size.
Without bypass_spec_v1 the index_mask AND keeps the access in bounds,
but such a key returns a masked element instead of NULL.

Creating such a map needs at least a 16 GiB allocation (max_entries
0x80000000, elem_size 8); the out-of-bounds path also needs a
CAP_PERFMON creator or mitigations=off.

Use BPF_JMP32_IMM() for the three compares, as commit 70504de0bb62
("xsk: Use a 32-bit compare in xsk_map_gen_lookup") did for
xsk_map_gen_lookup().

Fixes: b2157399cc98 ("bpf: prevent out-of-bounds speculation")
Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 kernel/bpf/arraymap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 508706d0c360..e7278e423f8e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -230,10 +230,10 @@ static int array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, value));
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
 	if (!map->bypass_spec_v1) {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 4);
+		*insn++ = BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 4);
 		*insn++ = BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
 	} else {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 3);
+		*insn++ = BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 3);
 	}
 
 	if (is_power_of_2(elem_size)) {
@@ -307,10 +307,10 @@ static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf_insn *ins
 
 	*insn++ = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0);
 	if (!map->bypass_spec_v1) {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 6);
+		*insn++ = BPF_JMP32_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 6);
 		*insn++ = BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->index_mask);
 	} else {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 5);
+		*insn++ = BPF_JMP32_IMM(BPF_JGE, BPF_REG_0, map->max_entries, 5);
 	}
 
 	*insn++ = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
@@ -1499,10 +1499,10 @@ static int array_of_map_gen_lookup(struct bpf_map *map,
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, map_ptr, offsetof(struct bpf_array, value));
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
 	if (!map->bypass_spec_v1) {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 6);
+		*insn++ = BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 6);
 		*insn++ = BPF_ALU32_IMM(BPF_AND, ret, array->index_mask);
 	} else {
-		*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 5);
+		*insn++ = BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 5);
 	}
 	if (is_power_of_2(elem_size))
 		*insn++ = BPF_ALU64_IMM(BPF_LSH, ret, ilog2(elem_size));
-- 
2.54.0

