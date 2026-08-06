Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553E367B97
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033912; cv=none; b=SaD51M1u7sOHwktjUK4fyYJ9jwi0uCtm7JJwTkoOCWa03IDvHLjF777zwV/jWs5WZQNIbqajKTJeGjxS+IUR3YJ0Qpb23bp5/OXzEY6CiIn8C0j4S+tcmyea6PLJLvnojSgpWXEVGA6Pu071x/n0t1u2kCqu5dyrdJJoJHlI/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033912; c=relaxed/simple;
	bh=/+kGrvea0SsPm8EUSI2XbFVwd7K8vjglmVla0MCRyMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHcqMy14a3+/5Z7KzOHcW39MtXzPaEG5jkySarv7vC2F1XMKy09drSZ2zniShgAXS9yjU5P7lkwnHLPMWyoTqKRESE4wTAq08esSqqbBXCAB3uzAflx9U4ZgL8RwaojzLrqvP7SsXtjt67nxk2i5wgzprM3DXFsV7BeNdkhMlDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lTHt8c9z; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lTHt8c9z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786033908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ANdYDCJ+AU+9OjoC90SkZ1a4rl/7AnsPgyBL948aQ8=;
	b=lTHt8c9zobuOxb57sKnzXJiTRi+C29zzp3jAaK5bFdWPGYY1g6MLZt53EUbA1RyhTKN5o4
	3KNWvIeZqpFsL23IPg+LH9KSirHnk0gChZcRq1tgbvKKGAyNS47YO5ZiGePItuIyqfeFd7
	EIwhCeWNbXILKOAOqlJYjIB8dsIXmjs=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v11 02/10] bpf: Factor out check_map_mem_read helper in verifier
Date: Fri,  7 Aug 2026 00:31:17 +0800
Message-ID: <20260806163125.11172-3-leon.hwang@linux.dev>
In-Reply-To: <20260806163125.11172-1-leon.hwang@linux.dev>
References: <20260806163125.11172-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the next commit, percpu_array map will add map_direct_value_addr
support.

IOW, it will add a map_type check in the iff condition of the
bpf_map_direct_read() code block, which will reduce the code block
readability.

Hence, factor out check_map_mem_read helper to improve the readability,
and the maintainability for the percpu_array map case.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 75 +++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b790ee42d25a..25c4ada94cd9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6155,6 +6155,48 @@ static void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
 	reg_bounds_sync(dst_reg);
 }
 
+static int check_map_mem_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int off,
+			      int bpf_size, int value_regno, bool is_ldsx)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	int size = bpf_size_to_bytes(bpf_size);
+	struct bpf_map *map = reg->map_ptr;
+
+	switch (map->map_type) {
+	case BPF_MAP_TYPE_INSN_ARRAY:
+		if (bpf_size != BPF_DW) {
+			verbose(env, "Invalid read of %d bytes from insn_array\n", size);
+			return -EACCES;
+		}
+		regs[value_regno] = *reg;
+		add_scalar_to_reg(&regs[value_regno], off);
+		regs[value_regno].type = PTR_TO_INSN;
+		return 0;
+	default:
+		break;
+	}
+
+	/* If map is read-only, track its contents as scalars. */
+	if (tnum_is_const(reg->var_off) &&
+	    bpf_map_is_rdonly(map) &&
+	    map->ops->map_direct_value_addr) {
+		int map_off = off + reg->var_off.value;
+		u64 val = 0;
+		int err;
+
+		err = bpf_map_direct_read(map, map_off, size, &val, is_ldsx);
+		if (err)
+			return err;
+
+		regs[value_regno].type = SCALAR_VALUE;
+		__mark_reg_known(&regs[value_regno], val);
+		return 0;
+	}
+
+	mark_reg_unknown(env, regs, value_regno);
+	return 0;
+}
+
 /* check whether memory at (regno + off) is accessible for t = (read | write)
  * if t==write, value_regno is a register which value is stored into memory
  * if t==read, value_regno is a register which will receive the value from memory
@@ -6209,38 +6251,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		if (kptr_field) {
 			err = check_map_kptr_access(env, value_regno, insn_idx, kptr_field);
 		} else if (t == BPF_READ && value_regno >= 0) {
-			struct bpf_map *map = reg->map_ptr;
-
-			/*
-			 * If map is read-only, track its contents as scalars,
-			 * unless it is an insn array (see the special case below)
-			 */
-			if (tnum_is_const(reg->var_off) &&
-			    bpf_map_is_rdonly(map) &&
-			    map->ops->map_direct_value_addr &&
-			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
-				int map_off = off + reg->var_off.value;
-				u64 val = 0;
-
-				err = bpf_map_direct_read(map, map_off, size,
-							  &val, is_ldsx);
-				if (err)
-					return err;
-
-				regs[value_regno].type = SCALAR_VALUE;
-				__mark_reg_known(&regs[value_regno], val);
-			} else if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
-				if (bpf_size != BPF_DW) {
-					verbose(env, "Invalid read of %d bytes from insn_array\n",
-						     size);
-					return -EACCES;
-				}
-				regs[value_regno] = *reg;
-				add_scalar_to_reg(&regs[value_regno], off);
-				regs[value_regno].type = PTR_TO_INSN;
-			} else {
-				mark_reg_unknown(env, regs, value_regno);
-			}
+			err = check_map_mem_read(env, reg, off, bpf_size, value_regno, is_ldsx);
 		}
 	} else if (base_type(reg->type) == PTR_TO_MEM) {
 		bool rdonly_mem = type_is_rdonly_mem(reg->type);
-- 
2.55.0

