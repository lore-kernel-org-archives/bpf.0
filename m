Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051771;
	b=y3sLPLPTk4OvvBqbXY5teAiu+x09mVxIzoluVlOCScHxgUd5k8TXJZCZb4kkDsYKfTLD
	 Jm7bk1J/hzodGEOiGU1DcHekJHjFBwGr1HAtwfanDtZwfA4l+Sq1IIIZ79/jwNCFjqEgk
	 TP77uPHDP9GVC1jIydGr5aob9hAWOTEwu0LlSKQDcJHXUdlRuFDm6n3fWP4HGjmx0c53i
	 X7/7r70/OtOkkz6nInGgAS3wJH3fG1pFKAWZybe2g9Mx/0t17nT8KgkpeJDpWI95D/GbC
	 quE+0HMzR69LIUyEisnpl5yYO4u8/egP74DMHA4k1ZuHVd+vIfRYOI1oNFOZk7FngWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/6GCJ8YiC8sHiOkq+0ugDFoD4azS8dVwUiDj8uwg2XM=;
	b=MJRZM/URGd//xSvdCj6S3AoAJxUisBOnznylobnHxn9EfmH2x+1/TcnWm6Ls0DRJ5uCQ
	 UDKcPo0Y4IrDum/pvZu+SQ2cJ2uky2MVVZ3y4qvJdgv0StOCy+ZThw9U8avgQT7Xy14PX
	 IanbvymjY25tMJPEV02ugWw/MUOXU7Xd6K0TjdUzSi0biAiCmBM1Imjrpskn9bOg7e1vn
	 k3ZIkuLAe76BXPV5Rhk/R9QjNmtzKSpL6YmRi/xxw7MAv9vI4RJsQc5OfI/DLDdYgTnFO
	 +3Gfp/RX8BmhCy+7+I8KzhHuKbzJ2E9egEU+NkYQ94k8iboxZaHOOLEGg/mXM56TGpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YlQg4Lrw;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40246606A31C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40246606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YlQg4Lrw
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2eff92780daso9603365ad.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795051771; x=1795656571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/6GCJ8YiC8sHiOkq+0ugDFoD4azS8dVwUiDj8uwg2XM=;
        b=YlQg4LrwGINm8JOm/HH3p1cIUsHZxkdFdNMJFvEjMKrpWhoM7wJaJzAd/7rrUOmMfn
         ed4sZm9cpJeUjc4mfF75f7BqS/CkWIYfUFosO3G99rM3+romSRf9urclL58UCj/4ZKmB
         oN5Hnv0nQRJQHNrsBAxOFZmwQrF2g8HU+gJuArqAJAMdZ5MsmM1cDVtWYChs3yFtRR2U
         mLNv6++K9gAolOIhkHhAX/LbquQhTXV4pAGzXW5HuM2DURQ3NdhfhMmUnA8mJjz7Xqhj
         RNPjvqXQraw4AidFMkKbC4I7PBkMXkoEHxcggtsLYdbsGFWVk96Qc50PNeEw22J4Epxi
         A0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051771; x=1795656571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/6GCJ8YiC8sHiOkq+0ugDFoD4azS8dVwUiDj8uwg2XM=;
        b=eBU6fj6bA+jzT144ZnWUdhIkFI7fA4PTHZ9DT7MZFmYsFGAxW4jfOUMJhPaP4iYsfj
         U7XFIuGSEtoEHm+QL/iNAVhPmnjnWvfhJEvxR6E4SCtfueK2SrB8zjiVL1IQGbAs2Gd2
         leVb5O4jbwozo+EjA5qgTYZiGO7Fcbm2FjMYfUbC0c+eAdhMQh28Q7dujvXArO/DE3vq
         NT8PGqQ4UZu5Bsl5iose7sR+soYWhgSQw+LDSDVPPs/UFwZUxhqT8X9v2m1W337MzrYK
         r9Xv7v/q0kZc4WS257y/pejo48htWKJ3xu8cBs0CcJC6GhyG2jpcHAvf3SFaN0Kc9eWX
         0r7g==
X-Gm-Message-State: APuU4Z96CF0IV5MFfBhUlHi+Q7iW70H+YqNzRhWL/GDeRYuMqjtpiXTW
	s4hiMLdCPCk+MjynUhuZJ6Vmt7jfNhv5qSwkBjor9TAqRsDjk7S8GjV2a0vhNg==
X-Gm-Gg: AZFdTZcmX73eUtGIyFkJOo8eRD32+TPvbwI6DGOJ1cgAVDDCRvMe1tHuDoooT6y1NyV
	7t9EFbND4C0pB7xNlP90C2lqz3MY+00Y8uwvO7GI3jeEOp5Y195dbHIiYnlVdBtLSiLst0AIVSS
	SeZbvNA1DKw1+Qf0QzLTYN3H2mTPT1RLhp5CSklVGJf9zpfZqd5hbuwOF3GueNtHASj5URTLH/Y
	R6b0DOspD7VPJZVVLciPnvZpuU2y4nokzx/Fi//sLyRITOr26Lu0i2K+c9qbYhiZkRIAXHeowLd
	DOixrAya5NVZohamuikNWOtci4bxIeZsJP3JypWw02T4F1triM72kCACttPEfpZ9apEA14EQs0m
	/RL1Grr0Mo6nzq/sZQBh6rLzxtLd05HtTcu2UlY4gWYrQyUOa3mKtv20nmwO25ie9nsvZiQrGDr
	2ZXDfQZ1Z8Co9+FO1KEXyP3zvjz2zhRRtJ9FqkZj31S6xOgzhBcS8QrAk2NDQycXqF+lWMXrCPw
	l4rRx/eui+hPx56l60lo4SD+RIpvOMgMm+8gvJtI5/hKoeuZMjn1F0UJF8QBjiK+B7uVi1jApzf
	8ACDxorwvDcbeVy34zqnM1p8hymvi30bPJT8ARGxnqHJjWGNIMXH/P+d57G/5tZebhTRcukVPT9
	GmyWR3mA11MgAU1fp9nPgkE4uuk3nOE+iiZhEHcfX8t2PVsfNSzViji+c7ZC5ZfwqXInJSZT6Jw
	==
X-Received: by 2002:a17:902:f652:b0:2ef:dc24:c72a with SMTP id d9443c01a7336-2eff753cb8cmr37984235ad.56.1795051770529;
        Wed, 18 Nov 2026 17:29:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f021b95e3asm2528015ad.1.2026.11.18.17.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:29:30 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/5] bpf: Remove BPF_MAX_TRAMP_LINKS
Date: Thu, 19 Nov 2026 01:29:07 +0000
Message-ID: <20261119012909.3657417-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
References: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A trampoline takes the programs that fit into its image. The number
BPF_MAX_TRAMP_LINKS was picked for each architecture so that this many
fit, but the code for a program has no fixed size. It depends on the kind
of the program, on its cookie, on the stack frame, on call depth
tracking. So the number promises nothing, and it refuses programs that
would fit:

	                                          limit    fit
	x86-64, fentry or fexit                   36       57
	x86-64, fmod_ret, call depth tracking     36       35
	arm64, fmod_ret                           37       35

bpf_trampoline_update() asks the JIT for the size of the image and
returns -E2BIG if it is too large. That is the limit that holds. Remove
the other one.

Three things relied on the number:

 - nodes[] in struct bpf_tramp_nodes. It is a pointer now.
   bpf_trampoline_get_progs() allocates the arrays behind the headers.

 - skip[] in the s390 JIT, a label for each program that the second pass
   read. Patch the branch when the label is known, as invoke_bpf_prog()
   does for its other forward branch.

 - Kernels with pages of 16 or 64 KB. An image may fill a page, so only
   the number kept it small there. bpf_session_cookie() has 8 bits for
   the index of a cookie, and the JITs have offsets into the stack frame
   that grows with the cookies. Limit the image to 4 KB on each kernel.
   These kernels now take what a kernel with 4 KB pages takes. That can
   be a few programs less than the number, for example 35 instead of 37
   fmod_ret programs on arm64.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 18 ++++--------------
 include/linux/bpf.h          | 21 +++++++--------------
 kernel/bpf/bpf_struct_ops.c  |  2 +-
 kernel/bpf/trampoline.c      | 25 ++++++++++++-------------
 4 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index ae89037db87c..d6c3c4270a0b 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2551,8 +2551,6 @@ struct bpf_tramp_jit {
 	int r14_off;		/* Offset of saved %r14, has to be at the
 				 * bottom */
 	int do_fexit;		/* do_fexit: label */
-	int skip[BPF_MAX_TRAMP_LINKS];	/* skip: labels after each prog */
-	int nr_progs;
 };
 
 static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
@@ -2580,18 +2578,15 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 			 offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 	struct bpf_prog *p = node->link->prog;
 	void *skip = jit->prg_buf + jit->prg;
-	int idx = tjit->nr_progs++;
+	int nop = jit->prg;
 	int patch;
 
-	if (idx >= ARRAY_SIZE(tjit->skip))
-		return -E2BIG;
-
 	/*
 	 * nop, patched to skip this prog when it is detached
 	 */
 
 	/* brcl 0,skip */
-	EMIT6_PCREL_RILC(0xc0040000, 0, tjit->skip[idx]);
+	EMIT6_PCREL_RILC(0xc0040000, 0, 0);
 
 	/*
 	 * run_ctx.cookie = node->cookie;
@@ -2653,7 +2648,8 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 	EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, bpf_trampoline_exit(p));
 
 	/* skip: */
-	tjit->skip[idx] = jit->prg;
+	if (jit->prg_buf)
+		*(u32 *)&jit->prg_buf[nop + 2] = (jit->prg - nop) >> 1;
 	bpf_tramp_image_add_skip(im, p, skip, jit->prg_buf + jit->prg);
 
 	return 0;
@@ -2717,8 +2713,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	u64 func_meta;
 	int i, j;
 
-	/* The skip labels are taken from the previous pass. */
-	tjit->nr_progs = 0;
 	if (im)
 		im->nr_skips = 0;
 
@@ -3043,10 +3037,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	if (ret < 0)
 		return ret;
 	if (tjit.common.prg > (char *)image_end - (char *)image)
-		/*
-		 * Use the same error code as for exceeding
-		 * BPF_MAX_TRAMP_LINKS.
-		 */
 		return -E2BIG;
 
 	tjit.common.prg = 0;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a5ad08b7937c..25704de9c4b2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -24,6 +24,7 @@
 #include <linux/kallsyms.h>
 #include <linux/capability.h>
 #include <linux/sched/mm.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 #include <linux/stddef.h>
@@ -1343,26 +1344,18 @@ static inline u32 btf_func_model_arg_slots(const struct btf_func_model *m, u32 a
  */
 #define BPF_TRAMP_F_INDIRECT		BIT(8)
 
-/* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
- * bytes on x86. The trampoline image has to fit in PAGE_SIZE.
+/*
+ * The image of a trampoline is not larger, also where pages are. That limits
+ * the number of programs: the index of a session cookie fits in its 8 bits,
+ * and the offsets into the stack frame fit in the instructions of each JIT.
  */
-enum {
-#if defined(__s390x__) || defined(__powerpc64__)
-	BPF_MAX_TRAMP_LINKS = 27,
-#elif defined(__x86_64__)
-	BPF_MAX_TRAMP_LINKS = 36,
-#elif defined(__aarch64__)
-	BPF_MAX_TRAMP_LINKS = 37,
-#else
-	BPF_MAX_TRAMP_LINKS = 38,
-#endif
-};
+#define BPF_TRAMP_IMAGE_MAX_SIZE	SZ_4K
 
 #define BPF_TRAMP_COOKIE_INDEX_SHIFT	8
 #define BPF_TRAMP_IS_RETURN_SHIFT	63
 
 struct bpf_tramp_nodes {
-	struct bpf_tramp_node *nodes[BPF_MAX_TRAMP_LINKS];
+	struct bpf_tramp_node **nodes;
 	int nr_nodes;
 };
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 7c5cd6086e27..deee5d2e89b2 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -646,7 +646,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_nodes *tnodes,
 	void *image = *_image;
 	int size;
 
-	tnodes[BPF_TRAMP_FENTRY].nodes[0] = node;
+	tnodes[BPF_TRAMP_FENTRY].nodes = &node;
 	tnodes[BPF_TRAMP_FENTRY].nr_nodes = 1;
 
 	if (model->ret_size > 0)
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 21d460866dfe..4dd4040e784f 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -506,14 +506,18 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
 	int kind;
 
 	*total = 0;
-	tnodes = kzalloc_objs(*tnodes, BPF_TRAMP_MAX);
+	for (kind = 0; kind < BPF_TRAMP_MAX; kind++)
+		*total += tr->progs_cnt[kind];
+
+	/* The arrays of nodes are behind the BPF_TRAMP_MAX headers */
+	tnodes = kzalloc(BPF_TRAMP_MAX * sizeof(*tnodes) + *total * sizeof(*nodes), GFP_KERNEL);
 	if (!tnodes)
 		return ERR_PTR(-ENOMEM);
+	nodes = (void *)&tnodes[BPF_TRAMP_MAX];
 
 	for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
 		tnodes[kind].nr_nodes = tr->progs_cnt[kind];
-		*total += tr->progs_cnt[kind];
-		nodes = tnodes[kind].nodes;
+		tnodes[kind].nodes = nodes;
 
 		hlist_for_each_entry(node, &tr->progs_hlist[kind], tramp_hlist) {
 			*ip_arg |= node->link->prog->call_get_func_ip;
@@ -768,7 +772,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		goto out;
 	}
 
-	if (size > PAGE_SIZE) {
+	if (size > BPF_TRAMP_IMAGE_MAX_SIZE) {
 		err = -E2BIG;
 		goto out;
 	}
@@ -889,22 +893,17 @@ static struct bpf_tramp_node *fsession_exit(struct bpf_tramp_node *node)
 }
 
 static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
-				   struct bpf_tramp_node *node,
-				   int cnt)
+				   struct bpf_tramp_node *node)
 {
 	enum bpf_tramp_prog_type kind;
 	struct bpf_tramp_node *node_existing, *fexit;
 	struct hlist_head *prog_list;
 
 	kind = bpf_attach_type_to_tramp(node->link->prog);
-	if (kind == BPF_TRAMP_FSESSION) {
+	if (kind == BPF_TRAMP_FSESSION)
 		prog_list = &tr->progs_hlist[BPF_TRAMP_FENTRY];
-		cnt++;
-	} else {
+	else
 		prog_list = &tr->progs_hlist[kind];
-	}
-	if (cnt >= BPF_MAX_TRAMP_LINKS)
-		return -E2BIG;
 	if (!hlist_unhashed(&node->tramp_hlist))
 		/* prog already linked */
 		return -EBUSY;
@@ -1031,7 +1030,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 		tr->extension_prog = node->link->prog;
 		return 0;
 	}
-	err = bpf_trampoline_add_prog(tr, node, cnt);
+	err = bpf_trampoline_add_prog(tr, node);
 	if (err)
 		return err;
 	err = bpf_trampoline_update(tr, true /* lock_direct_mutex */, ops, data);
-- 
2.55.0

