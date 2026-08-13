Received: from mta1.migadu.com (out-208.mta1.migadu.com [95.215.58.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F50485CE3
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634636; cv=none; b=B2EFi0DibUMVTg+7sjS90H7J/yvGs91qGkcgy8ygo4FHrxzycfZq3va5GsXtseBz7SA3ixhjV1M/bvpmjDX6XigPYCuXz1zD/1i66UcgDVg1kg9UOCMCynedhh5ffpd2gX2T02h1uxps7GpFiBLz5ytPLqz7OSTNTlxFk8BUjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634636; c=relaxed/simple;
	bh=rl2mM/hgJaTMp2JXut3FiR4Nw5ZzCc31Waf+AGGLHso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMCu7fc7d0CAI9YlhX4OqT2JL6U1pUmL8bgPhW+ivrOc1JiKBI1yW+KBVtDo6XUkUtQIUSIO/fig0rPPBrKvjvZVyS4Hq2aPwg5PvDhwReddp0e6Us/y1p2h0AygEsonL+0RAr0YwwB7+GZ/EVz5t85wVKQekkUxoW4+oBgKSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dFYYfhau; arc=none smtp.client-ip=95.215.58.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dFYYfhau"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rl2mM/hgJaTMp2JXut3FiR4Nw5ZzCc31Waf+AGGLHso=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786634631; v=1; x=1787239431;
 b=dFYYfhau2M5yAoCRHYrZLnu6gAi2cH/maKy2WcQ+eCTTgtrcfVbwtpTCfutM0229WkDtO0E+
 BjbudP7HRV0vgnUlioK9DAqLzBAOlJ8OjwQhJb1Tyn1lKd8ezgxMCOMud2gnVC0pOktZ3/rJGyf
 e4303uwOwwazFMyAKM1coF/M=
X-Envelope-To: bpf@vger.kernel.org
Received: from .linux.dev (117.20.149.103)
	by smtp.migadu.com with ESMTPS id dcce8eb518750f6d;
	Thu, 13 Aug 2026 15:23:51 +0000
X-Migadu-Flow: FLOW_OUT
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
Subject: [PATCH bpf-next v12 02/10] bpf: Factor out check_map_mem_read helper in verifier
Date: Thu, 13 Aug 2026 23:23:15 +0800
Message-ID: <20260813152324.97937-3-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813152324.97937-1-leon.hwang@linux.dev>
References: <20260813152324.97937-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the next commit, percpu_array map will add map_direct_value_addr
support.

IOW, it will add a map_type check in the iff condition of the
bpf_map_direct_read() code block, which will reduce the code block
readability.

Hence, factor out check_map_mem_read helper to improve the readability,
and the maintainability for the percpu_array map case.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 75 +++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cdb79a66b156..4fac230122d9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6078,6 +6078,48 @@ static void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
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
@@ -6132,38 +6174,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
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

