Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983274;
	b=EdHaQh640ON2Xc/naE5id20RuGzbxeVJn5KwhMNg+gmi1nyk6PHG2XzQjtXapdCqBplM
	 w7SInR9ofra7Zhpw0WSEGGMvg522EL0L5oHfO1sG4BNBAEPKTE2N5Qm7n44vMvfafSWPF
	 kTfg+wQ0FBX35HZBWXabm1uHpvL+jl0AN8XP1bcTRgMJOTwQIHV4/Ni+LUe6mrjGHD+Li
	 F4TzasPKQ5ZF5CP7Dnbw/jXoHpXLcDhSOifwJWcYZTViskjBkYzBt72ZdB9YC4HxhRgfm
	 Ba/IVsXi7sZ899turk5FHjXqgfDOAhMXUXlqxROA9+Xt/2Cetvz+CuiWPyO+KYWNIsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lHM3LuNJit1c0pviquplRl10xW28OnR1CStkGrBCaPk=;
	b=GZ6jiGQp7ct8c7cv5SLWSSsxl5DKqLuh65DOd48+smX/8JIBqYhYs7CT794cH1z8Gs3A
	 rRK326NIurClJxKW8ee3xe4h07LqGpjRMWmBQ95e2OasL480qy7VowXC5rrD1I5hakZTx
	 2YXupIzliDhA2lMIPMAM+6yLgJ49ToihoMT2KkVzfk+bNgIdO5/Ner9/QnG51GDZugi5l
	 Bp7Sg7pNHdsm5gE31A0kEUALzKKvZp66ZDe7ium2P5MAZT4qhgiv1hRpes6oWhoqP+raH
	 kMZdinxHR724HZ+L+zLudc9cWmeEVewiaVp+NjHwIxnAG4wJurLm3w+7XlbU5IGc/zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BY+J+bvt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6FB606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BY+J+bvt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204791F0089F;
	Fri,  6 Nov 2026 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793983273;
	bh=lHM3LuNJit1c0pviquplRl10xW28OnR1CStkGrBCaPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BY+J+bvtgOMckXLelNLPvCSWERj6xgZd7d9Ns02y/swoOVyBMZes22dRA/Fzc5NXL
	 BxI7u6HdVXgaXr055uYTpLu6P2CYhhFYcSO1Wpmice7x/8cefHvMRVg66FSqRAzLRy
	 frfsbLUIbJ8MKa6JRg1brmRDHx16xpbHSqWyFBnLB/HmO9Uu0KUpeyZcza57hGKYKe
	 q3ATUbpFAjm+HLas6YbT0c0Tg+n5WHm7S+qorDHILTRiYNkQtqAqDXnIWYp1O0iEZH
	 loTKjXg8xAFVuh5dRnOOl91RoMKy23GsSRTl0BWhIaIi26VUb0EU7KZXTpHzGPxusS
	 JAgN8Xcx3QhuQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	HyeongJun An <sammiee5311@gmail.com>,
	Christian Simon <simon@swine.de>
Subject: [PATCHv2 bpf-next 2/2] bpf: Disable private stacks for untagged kprobe programs
Date: Fri,  6 Nov 2026 17:40:43 +0100
Message-ID: <20261106164043.546879-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106164043.546879-1-jolsa@kernel.org>
References: <20261106164043.546879-1-jolsa@kernel.org>
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

Uprobe programs can be preempted and re-entered on the same CPU. Since
the private stack is shared per program and CPU, another invocation can
overwrite the preempted invocation's stack.

Programs without a multi or session attach type may be standard kprobes
or uprobes. Disable private stacks for them, and retain private stacks
only for kprobe multi and session programs, which have attach types that
identify them as kprobes.

Update verifier tests that rely on private stacks to use kprobe.multi,
and add coverage that untagged kprobe and uprobe programs do not use
private stacks.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c                         |  9 +++++
 .../bpf/progs/verifier_large_stack.c          |  2 +-
 .../bpf/progs/verifier_private_stack.c        | 38 ++++++++++++++++++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b7329d164771..1b58a1796a2e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5749,6 +5749,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
 	 */
 	switch (prog->type) {
 	case BPF_PROG_TYPE_KPROBE:
+		/*
+		 * Uprobes are preemptible and lack recursion protection. Classic
+		 * kprobe and uprobe progs have no expected attach type, so enable
+		 * private stacks only for kprobe.multi and kprobe.session progs.
+		 */
+		if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI &&
+		    prog->expected_attach_type != BPF_TRACE_KPROBE_SESSION)
+			return NO_PRIV_STACK;
+		fallthrough;
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
diff --git a/tools/testing/selftests/bpf/progs/verifier_large_stack.c b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
index 7e4f5e3463a2..cbabb41d973c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_large_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
@@ -243,7 +243,7 @@ static void priv_stack_frame_2048(void)
 "	::: __clobber_all);
 }
 
-SEC("kprobe")
+SEC("kprobe.multi")
 __description("private stack: two frames of 2048 bytes")
 __load_if_large_stack()
 __arch_x86_64
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index aa15361bcca5..0ce07bf6b566 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -22,7 +22,7 @@ struct {
 	__type(value, struct elem);
 } array SEC(".maps");
 
-SEC("kprobe")
+SEC("kprobe.multi")
 __description("Private stack, single prog")
 __success
 __arch_x86_64
@@ -110,6 +110,40 @@ int no_private_stack_stack_args(void)
 }
 #endif
 
+SEC("kprobe")
+__description("No private stack, untagged kprobe")
+__success
+__arch_x86_64
+__jited("	subq	$0x100, %rsp")
+__arch_arm64
+__jited("	sub	sp, sp, #0x100")
+__naked void no_private_stack_kprobe(void)
+{
+	asm volatile ("			\
+	r1 = 42;			\
+	*(u64 *)(r10 - 256) = r1;	\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+SEC("uprobe")
+__description("No private stack, uprobe")
+__success
+__arch_x86_64
+__jited("	subq	$0x100, %rsp")
+__arch_arm64
+__jited("	sub	sp, sp, #0x100")
+__naked void no_private_stack_uprobe(void)
+{
+	asm volatile ("			\
+	r1 = 42;			\
+	*(u64 *)(r10 - 256) = r1;	\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
 __used
 __naked static void cumulative_stack_depth_subprog(void)
 {
@@ -123,7 +157,7 @@ __naked static void cumulative_stack_depth_subprog(void)
 	: __clobber_all);
 }
 
-SEC("kprobe")
+SEC("kprobe.multi")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
 __log_level(4) __msg("stack depth max 512")
-- 
2.43.0

