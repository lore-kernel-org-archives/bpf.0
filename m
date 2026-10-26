Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983763;
	b=F0aFm9rZ+oFSSsJAEA9K/xvs1y+WtgIuFO9wUj8syC5bZAkiy+1gDWjRUagcYce0dhf9
	 YBZlZ0bHUbT+CFVs+j+RXhQpPxiHu6Dg+luhfpaaGNCXm33RaLCbyx/Vs16wkyqKYTLG/
	 /5qt7hIRLMNblZ7dMOa2fNmuj6DbQRKS0ALGZDQu3z/DpqMHtZScoDLkrbUxMa8iu8RDn
	 W2DD2T1G05TNztEmMphUplzBkngkY0Sd/qN3Rv24Pmo4nW5boEmZXAbdq2eREgmEAZYRV
	 50C6QchxN9kLWCQVW0/Fxupy+i6LrkBSg/mE8tQ2hCfUR/RqgLMuFtUkxVQs7BqWL3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XhoBdco3xX/Ci64RmmfGAF4sz9SS+C8qLazyHwuNRtM=;
	b=MOEl3lTqC4aqHMxJ9SBoot7e4VVkldoe+NNGAmdHVNrb449mMhwkKh2NqL3UqoN0eh88
	 humG94YplSoc74SaiWMgs0rdkrCN3d0BcLtbUmEfgcdEoQL56tXTDXsQJhWjULKXJesyP
	 93MNeOMxushR3wUNYtzaaeooLhz7uUJEfi4sbiXgkO8l4p4IE3joLv8lCB4gh/FxPrxU7
	 jsY7PHfZIFGBllfsUdUG4g25G4K3e59DgWTD8khcxr/m/fHwnMG41URP8p9/AcZeW9dg0
	 kovKS4my+2VFjQoc9dgEN3srOXNNbhYq9JfgjBilsyD+n82NGhfv4atR0Tg//JWJQ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bI2gBSyt;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81904606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81904606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bI2gBSyt
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e95bd1c14cso22645905ad.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983763; x=1793588563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhoBdco3xX/Ci64RmmfGAF4sz9SS+C8qLazyHwuNRtM=;
        b=bI2gBSytSLA3wHjr1h+Lz9EmBPA7n90Hn8mpAOLT2US+403OM08wVD6YgGQjbG10Wn
         vpvNMxDLyK44lx1gONKgr3bsd/UYv2JRyfwNyI1LBvC1CuLyvBg77Bp8m1jjlzGixftm
         bz0FZ4RnxNtRu7P52diwr9PHPcNsX4CPqmXpwRvGw4FTXgSolYeVCwth/QDpAgnUkaiv
         boUpnrG5s9qwu0t1SMH2/dtoR7mopP0P0HJNftcrfFf28xeW/llwTh4N0W9ePz/yWq/C
         5pOAEr0TfckvG70D6wdnBqSVsl08hlSdoiloCm7Ji+3y2qyMRw50x9X7/vguKCmaTVEJ
         fP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983763; x=1793588563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XhoBdco3xX/Ci64RmmfGAF4sz9SS+C8qLazyHwuNRtM=;
        b=lZAy4lUnLl088zgKBYu/SIkDoWIaLzYcuRz8P9z+xAsM3LQsUKBCtosUNVLIYdZCfZ
         w0tsH9+/2R9NJ+8vNPO64gq2jhHn5dN3lB1apI9uRChrjjWA4JqAO+U7g5OUJf6IKVif
         NK7/sl3iywtHozcsuzVtYxHdV87YQ0mscqrefD7rr0rgw1x6zQUIYWQ9RcEDP4ZMOCl1
         LOiTnS83exdKAnAAer9aGYW3hwLYzlviLcr6IX8tZRplTiAdlA5wPoPJS2+67E7xaRLx
         Dk9VMCyYr/I3mW0J/il+EsAPUcXi2IhJ3YmR2BPYlo55CVNZ8zaMuSYS2ALNNzcr2pWv
         aVoQ==
X-Gm-Message-State: AFq9FYKQgSFM6sM1G7xu+YRVKTTWprwQnNArpWsF4j4nCIssWO58R5F3
	tG5fnQVyoFbxqyg0EzLVaJfvRJ30/p8U0nTkZqX3p/fGn0VIbI0ypP0zeyaVmQ==
X-Gm-Gg: AYBFou3Ij8X2Szq5vShQYipGjXcvQEa0n61OWzcgrg8011vUFR+B8V8LVQF55lT1+A6
	a9wW3mrKD69wzBMm2ZsuwvoxP9SbCJnX4Zled6hVP6WGsdXITc5GYvW0+dg9D+hpXrNT+wrOq2J
	X900BhgRecW4jsdGX7SjpWOJyPsEx6PBNQevYt3dW8rnliIdELD8NK+oMTvzSrp26IcvqW/OqEr
	84x59i0Q+YpwWJmESIAvUtXV8XOlF0bV0userOWQxKj5Dutmj+q+wzctickER21L+l3HvuucsM+
	8TrQquKEx0nOwuuA5bzU98cSgZQVwuKGkGCMxexBo1psOQxSntplg1MaMQJ8GF4i3SRre4uwCpq
	vuHxTw7IF4aL29ndoDq69uPvmHQHUx3XW6ZIY/3THoNK4ksEY3X4LH5gUXfdcyxJqZ8FOW7IEvA
	N5ekIbArAQHCR6hISg6Kuxn4Mpn2NWAvNvDD/TENua/KgXuQgzS2drSE7lFelFdYmd9ao+gNPU+
	AOAgk9cpfhEPj4pf5Lgur6uhR1WZjvRaui7KXYTcOy4ayu1+OWMa2yhshSCuQifECk0htaXh5kc
	i7+gbDIShuhh5bldyAX5jcwwPpE995Vrb7XAFBFdVvZryrMjSajFLsbXwWFyanvL2R+3aGMvaPz
	lygCBlzY0yeCCI9eGRDvLhDZH
X-Received: by 2002:a17:902:e5c3:b0:2e5:d33a:88da with SMTP id d9443c01a7336-2ea9c68c6fdmr50762645ad.16.1792983762729;
        Sun, 25 Oct 2026 20:02:42 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b12193fsm10447885ad.23.2026.10.25.20.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:02:42 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 30/81] bpf: Add bpf_arena_memcmp() and bpf_arena_memcpy() kfuncs
Date: Mon, 26 Oct 2026 02:58:51 +0000
Message-ID: <20261026025943.404450-31-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

LLVM replaces a comparison or a copy of memory with a call to memcmp(),
memcpy() or memmove(). BPF has none of these functions. Rust progs keep all
their memory in arena. Add two kfuncs that take arena pointers:

  int bpf_arena_memcmp(const void *a__arena, const void *b__arena,
                       u64 size);
  u64 bpf_arena_memcpy(void *dst__arena, const void *src__arena,
                       u64 size);

An arena pointer can point to a page that is not allocated. When the kernel
accesses such a page, the fault handler maps a scratch page there, and the
access continues. Thus a plain memcmp() or memmove() would compare or copy
the scratch page, and the prog would not see the error.

Walk the page tables before the access, and stop at the first page that is
not allocated. Report this page to the BPF_STDERR stream of the prog, the
same as an access of the prog to this page. Then the fault handler is
necessary only for a page that is freed after the walk.

The kfuncs can run in NMI. Thus one call processes 64 Kbyte at most, and
the prog copies more in a loop. The verifier rejects a call if size is
always larger.

  kfunc               return value
  ------------------  ---------------------------------------------------
  bpf_arena_memcmp()  0 or the difference of two bytes, as memcmp() does.
                      -E2BIG if it stopped early and found no difference.
  bpf_arena_memcpy()  The number of bytes that it copied.
                      The areas can overlap.

The cost of a call on x86-64 (Zen 5) with hot caches:

  copy of 1 to 64 bytes in one page             12.0 nsec
  compare of 1 to 64 bytes in one page          up to 12.3 nsec
  the two walks of the page tables, included    5.2 to 5.5 nsec
  the same copy with inline loads and stores    less than 2 nsec
  64 Kbyte                                      0.58 to 2.0 usec

Inline code is faster up to 1024 bytes. Thus it is better to keep small
copies inline.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 10 ++++
 include/linux/bpf.h          |  2 +
 kernel/bpf/arena.c           | 91 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 14 ++++++
 4 files changed, 117 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 73578a4c3b1f..47d3bed73b83 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -965,3 +965,13 @@ the verifier. bpf_cgroup_ancestor() can be used as follows:
 BPF provides a set of kfuncs that can be used to query, allocate, mutate, and
 destroy struct cpumask * objects. Please refer to :ref:`cpumasks-header-label`
 for more details.
+
+4.4 Arena kfuncs
+----------------
+
+Compilers turn copies and comparisons of memory into calls to memcpy(),
+memmove() and memcmp(). Programs that keep all of their memory in arena,
+like the ones written in Rust, call the following kfuncs instead:
+
+.. kernel-doc:: kernel/bpf/arena.c
+   :identifiers: bpf_arena_memcmp bpf_arena_memcpy
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4ca06a217055..d62dc3f7f148 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -698,6 +698,8 @@ int bpf_arena_stack_init(struct bpf_arena *arena);
 void __percpu *bpf_arena_stack_percpu(struct bpf_arena *arena);
 u64 bpf_arena_stack_get(struct bpf_prog_aux *aux, u64 busy);
 void bpf_arena_stack_put(struct bpf_prog_aux *aux, u32 base);
+/* bpf_arena_memcmp() and bpf_arena_memcpy() work on that many bytes per call at most */
+#define BPF_ARENA_MEM_MAX	SZ_64K
 u64 bpf_arena_map_kern_vm_start(struct bpf_map *map);
 struct bpf_map *bpf_prog_arena(struct bpf_prog *prog);
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 8b99b3b6fa02..c6c13dfa1102 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -47,6 +47,8 @@
 #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
 
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable);
+static void __bpf_prog_report_arena_violation(struct bpf_prog *prog, bool write,
+					      unsigned long addr, unsigned long fault_ip);
 
 struct bpf_arena {
 	struct bpf_map map;
@@ -1296,12 +1298,101 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map, void *ptr__ign, u32 page_c
 
 	return arena_reserve_pages(arena, (long)ptr__ign, page_cnt);
 }
+
+/*
+ * The number of bytes at @ptr, @size at most, that are in pages of arena
+ * that are allocated. @ptr is what JIT made of __arena argument.
+ */
+static u64 arena_span(struct bpf_arena *arena, const void *ptr, u64 size)
+{
+	unsigned long start = (unsigned long)ptr, end;
+	struct page *page;
+
+	size = min(size, SZ_4G - (start - bpf_arena_get_kern_vm_start(arena)));
+	for (end = start; end < start + size; end = (end | ~PAGE_MASK) + 1) {
+		page = vmalloc_to_page((void *)end);
+		if (!page || page == arena->scratch_page)
+			break;
+	}
+	return min(size, end - start);
+}
+
+/*
+ * @size bytes at @a and at @b were asked for. Returns what there is,
+ * BPF_ARENA_MEM_MAX at most, and reports the page that is missing.
+ */
+static u64 arena_span2(struct bpf_prog_aux *aux, const void *a, const void *b, u64 size,
+		       bool write)
+{
+	const void *bad;
+	u64 span;
+
+	size = min_t(u64, size, BPF_ARENA_MEM_MAX);
+	span = min(arena_span(aux->arena, a, size), arena_span(aux->arena, b, size));
+	if (span < size) {
+		bad = arena_span(aux->arena, a, size) == span ? a : b;
+		__bpf_prog_report_arena_violation(aux->prog, write && bad == a,
+						  (unsigned long)bad + span -
+						  bpf_arena_get_kern_vm_start(aux->arena), 0);
+	}
+	return span;
+}
+
+/**
+ * bpf_arena_memcmp() - Compare two areas of arena
+ * @a__arena: One area
+ * @b__arena: Another area
+ * @size: The number of bytes to compare, BPF_ARENA_MEM_MAX at most
+ * @aux: Implicit argument, set by the verifier
+ *
+ * The comparison stops at the first page of either area that is not
+ * allocated. It's reported to the stream of the program as an access to
+ * that page.
+ *
+ * Return: 0 when the areas are equal. The difference between the first two
+ * bytes that differ, like memcmp() does, when they are not. -E2BIG when
+ * the areas are equal as far as they were compared and that is less than
+ * @size.
+ */
+__bpf_kfunc int bpf_arena_memcmp(const void *a__arena, const void *b__arena, u64 size,
+				 struct bpf_prog_aux *aux)
+{
+	u64 span = arena_span2(aux, a__arena, b__arena, size, false);
+	int ret = memcmp(a__arena, b__arena, span);
+
+	return ret || span == size ? ret : -E2BIG;
+}
+
+/**
+ * bpf_arena_memcpy() - Copy one area of arena to another
+ * @dst__arena: Where to copy to
+ * @src__arena: Where to copy from
+ * @size: The number of bytes to copy, BPF_ARENA_MEM_MAX at most
+ * @aux: Implicit argument, set by the verifier
+ *
+ * The areas may overlap. The copy stops at the first page of either area
+ * that is not allocated. It's reported to the stream of the program as
+ * an access to that page.
+ *
+ * Return: The number of bytes copied. The program copies more than
+ * BPF_ARENA_MEM_MAX in a loop.
+ */
+__bpf_kfunc u64 bpf_arena_memcpy(void *dst__arena, const void *src__arena, u64 size,
+				 struct bpf_prog_aux *aux)
+{
+	u64 span = arena_span2(aux, dst__arena, src__arena, size, true);
+
+	memmove(dst__arena, src__arena, span);
+	return span;
+}
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(arena_kfuncs)
 BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
 BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2 | KF_SPINLOCK_SAFE)
+BTF_ID_FLAGS(func, bpf_arena_memcmp, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_arena_memcpy, KF_IMPLICIT_ARGS)
 BTF_KFUNCS_END(arena_kfuncs)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 92b563a9b158..fb80bc4d2d01 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13719,6 +13719,8 @@ enum special_kfunc_type {
 	KF_bpf_call_rcu_tasks_trace,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
+	KF_bpf_arena_memcmp,
+	KF_bpf_arena_memcpy,
 	KF_bpf_session_is_return,
 };
 
@@ -13812,9 +13814,13 @@ BTF_ID(func, bpf_call_rcu_tasks_trace)
 #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
+BTF_ID(func, bpf_arena_memcmp)
+BTF_ID(func, bpf_arena_memcpy)
 #else
 BTF_ID_UNUSED
 BTF_ID_UNUSED
+BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID(func, bpf_session_is_return)
@@ -15551,6 +15557,14 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err < 0)
 		return err;
 
+	if ((meta.func_id == special_kfunc_list[KF_bpf_arena_memcmp] ||
+	     meta.func_id == special_kfunc_list[KF_bpf_arena_memcpy]) &&
+	    reg_umin(&regs[BPF_REG_3]) > BPF_ARENA_MEM_MAX) {
+		verbose(env, "R3 is more than %u bytes that %s() takes per call\n",
+			BPF_ARENA_MEM_MAX, func_name);
+		return -EINVAL;
+	}
+
 	err = mark_raw_stack(env, &meta, insn_idx);
 	if (err)
 		return err;
-- 
2.55.0

