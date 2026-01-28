Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06E3358D6
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612550; cv=none; b=gWhNR5EuSBCt0ytKM+pYwmAoC+RysXMaB3YFQXOFrpuZHBsm7NNsfMvHsLLCfj6wjwGemcplKIeAj76nE+ndGtGDRBth1jnDSomLeq/o5emPcq2CytD+TA8IGReUQVgBfFt9xLd74eS7tpuwjPezpKZfHL4KP4U52a5vl+3R9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612550; c=relaxed/simple;
	bh=uJ3J8FWaFsHsVCMqFgJehh03QgtLSJV2Q8xJxgwzKUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBOUn0KPir/RiNGGNdhiFTMy24IE39OBPt68WXlni+JbQemcP2CK+V6nuWSOiH/5Klidod02YqvUOXfcshAQSdt4CterzgU2Rdvk9okIQ229PK0zBibJ2sc+3E/y7RmV+yntSw/mWw/kj4St96kW3v6URLoj4q8kcjCDXuFOH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K8wCfwTa; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K8wCfwTa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769612533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KsRsvGl58QXwzZ3EI8wULjyrtB8jnovAYpvg7DJrhs=;
	b=K8wCfwTaZV+7SwVaASBDvcAp6W7OXpak9sznfwGI9X8arhLNGJBAWMvErhIBF2d5J6p+zA
	nw56ZPyqJZo5Vq2ZSFn/5QVu1vGoGbiLup/zHvmCGYVKPoERsHpcTaJFZCtXiGPV7hr0XD
	9FT1jQinsDyfmsh54WZJz2k/YGewomY=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 2/3] bpf, arm64: Add fsession support
Date: Wed, 28 Jan 2026 23:01:11 +0800
Message-ID: <20260128150112.8873-3-leon.hwang@linux.dev>
In-Reply-To: <20260128150112.8873-1-leon.hwang@linux.dev>
References: <20260128150112.8873-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement fsession support in the arm64 BPF JIT trampoline.

Extend the trampoline stack layout to store function metadata and
session cookies, and pass the appropriate metadata to fentry and
fexit programs. This mirrors the existing x86 behavior and enables
call session cookies on arm64.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c | 71 ++++++++++++++++++++++++++++++-----
 include/linux/bpf.h           |  7 +++-
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0c4d44bcfbf4..952e00e078b2 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2510,6 +2510,12 @@ static bool is_struct_ops_tramp(const struct bpf_tramp_links *fentry_links)
 		fentry_links->links[0]->link.type == BPF_LINK_TYPE_STRUCT_OPS;
 }
 
+static void store_func_meta(struct jit_ctx *ctx, u64 func_meta, int func_meta_off)
+{
+	emit_a64_mov_i64(A64_R(10), func_meta, ctx);
+	emit(A64_STR64I(A64_R(10), A64_SP, func_meta_off), ctx);
+}
+
 /* Based on the x86's implementation of arch_prepare_bpf_trampoline().
  *
  * bpf prog and function entry before bpf trampoline hooked:
@@ -2533,7 +2539,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	int regs_off;
 	int retval_off;
 	int bargs_off;
-	int nfuncargs_off;
+	int func_meta_off;
 	int ip_off;
 	int run_ctx_off;
 	int oargs_off;
@@ -2544,6 +2550,9 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	bool save_ret;
 	__le32 **branches = NULL;
 	bool is_struct_ops = is_struct_ops_tramp(fentry);
+	int cookie_off, cookie_cnt, cookie_bargs_off;
+	int fsession_cnt = bpf_fsession_cnt(tlinks);
+	u64 func_meta;
 
 	/* trampoline stack layout:
 	 *                    [ parent ip         ]
@@ -2562,10 +2571,14 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	 *                    [ ...               ]
 	 * SP + bargs_off     [ arg reg 1         ] for bpf
 	 *
-	 * SP + nfuncargs_off [ arg regs count    ]
+	 * SP + func_meta_off [ regs count, etc   ]
 	 *
 	 * SP + ip_off        [ traced function   ] BPF_TRAMP_F_IP_ARG flag
 	 *
+	 *                    [ stack cookie N    ]
+	 *                    [ ...               ]
+	 * SP + cookie_off    [ stack cookie 1    ]
+	 *
 	 * SP + run_ctx_off   [ bpf_tramp_run_ctx ]
 	 *
 	 *                    [ stack arg N       ]
@@ -2582,13 +2595,18 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	/* room for bpf_tramp_run_ctx */
 	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
 
+	cookie_off = stack_size;
+	/* room for session cookies */
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	stack_size += cookie_cnt * 8;
+
 	ip_off = stack_size;
 	/* room for IP address argument */
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		stack_size += 8;
 
-	nfuncargs_off = stack_size;
-	/* room for args count */
+	func_meta_off = stack_size;
+	/* room for function metadata, such as regs count */
 	stack_size += 8;
 
 	bargs_off = stack_size;
@@ -2646,9 +2664,9 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		emit(A64_STR64I(A64_R(10), A64_SP, ip_off), ctx);
 	}
 
-	/* save arg regs count*/
-	emit(A64_MOVZ(1, A64_R(10), nfuncargs, 0), ctx);
-	emit(A64_STR64I(A64_R(10), A64_SP, nfuncargs_off), ctx);
+	/* save function metadata */
+	func_meta = nfuncargs;
+	store_func_meta(ctx, func_meta, func_meta_off);
 
 	/* save args for bpf */
 	save_args(ctx, bargs_off, oargs_off, m, a, false);
@@ -2666,10 +2684,27 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		emit_call((const u64)__bpf_tramp_enter, ctx);
 	}
 
-	for (i = 0; i < fentry->nr_links; i++)
+	if (fsession_cnt) {
+		/* clear all the session cookies' value */
+		emit(A64_MOVZ(1, A64_R(10), 0, 0), ctx);
+		for (int i = 0; i < cookie_cnt; i++)
+			emit(A64_STR64I(A64_R(10), A64_SP, cookie_off + 8 * i), ctx);
+		/* clear the return value to make sure fentry always gets 0 */
+		emit(A64_STR64I(A64_R(10), A64_SP, retval_off), ctx);
+	}
+
+	cookie_bargs_off = (bargs_off - cookie_off) / 8;
+	for (i = 0; i < fentry->nr_links; i++) {
+		if (bpf_link_prog_session_cookie(fentry->links[i])) {
+			u64 meta = func_meta | (cookie_bargs_off << BPF_TRAMP_COOKIE_INDEX_SHIFT);
+
+			store_func_meta(ctx, meta, func_meta_off);
+			cookie_bargs_off--;
+		}
 		invoke_bpf_prog(ctx, fentry->links[i], bargs_off,
 				retval_off, run_ctx_off,
 				flags & BPF_TRAMP_F_RET_FENTRY_RET);
+	}
 
 	if (fmod_ret->nr_links) {
 		branches = kcalloc(fmod_ret->nr_links, sizeof(__le32 *),
@@ -2701,9 +2736,22 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		*branches[i] = cpu_to_le32(A64_CBNZ(1, A64_R(10), offset));
 	}
 
-	for (i = 0; i < fexit->nr_links; i++)
+	/* set the "is_return" flag for fsession */
+	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
+	if (fsession_cnt)
+		store_func_meta(ctx, func_meta, func_meta_off);
+
+	cookie_bargs_off = (bargs_off - cookie_off) / 8;
+	for (i = 0; i < fexit->nr_links; i++) {
+		if (bpf_link_prog_session_cookie(fexit->links[i])) {
+			u64 meta = func_meta | (cookie_bargs_off << BPF_TRAMP_COOKIE_INDEX_SHIFT);
+
+			store_func_meta(ctx, meta, func_meta_off);
+			cookie_bargs_off--;
+		}
 		invoke_bpf_prog(ctx, fexit->links[i], bargs_off, retval_off,
 				run_ctx_off, false);
+	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = ctx->ro_image + ctx->idx;
@@ -2753,6 +2801,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	return ctx->idx;
 }
 
+bool bpf_jit_supports_fsession(void)
+{
+	return true;
+}
+
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_links *tlinks, void *func_addr)
 {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4427c6e98331..b299d1206bfc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2192,13 +2192,18 @@ static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
 	return cnt;
 }
 
+static inline bool bpf_link_prog_session_cookie(struct bpf_tramp_link *link)
+{
+	return link->link.prog->call_session_cookie;
+}
+
 static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_links *links)
 {
 	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
 	int cnt = 0;
 
 	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
-		if (fentries.links[i]->link.prog->call_session_cookie)
+		if (bpf_link_prog_session_cookie(fentries.links[i]))
 			cnt++;
 	}
 
-- 
2.52.0

