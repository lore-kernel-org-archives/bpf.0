Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A95355055
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047052; cv=none; b=uzwxtryMoRP6kLcY+yI5cD2spAVjLSnVxUHuEsMD2oMoaCyaSXHJK+leh0I/2UDqkzLDSLLj4ertPforOh+81eHVQEiQk1FjbaaZpDLwdzkEq2VGrfTMvr7bOy9auG49uG/GD80PjxbEayJEIiFXa4d9vJynUSwCh0zTFmMif68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047052; c=relaxed/simple;
	bh=CuUmjoeeFOw0SjIF4afyhrmOQxbFzw+xGTuWPo96m9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fySGnRH1lEm7aXLVM3sucDMLw3ap75eYGJW33H3UMtkYJOEUexPUmXQmE0qW/GIPv1hM3nWbLOPMXbORIVYMLf1HNnvFcIkIQopqIoJJ7/ZfnhmZL9AIJIEcTJ2PDeIJmS9kjX0SleQ9LP1HOuLb1y2nJy4p23e6qzxPGnjINhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DiLEM1Kv; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DiLEM1Kv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Dt8PrXbHLhMajmZoI0XlMZBmEnw7KzZmZoZRQN70BAI=; b=DiLEM1Kv+ZkxlsXe2zCpcEmGBm
	gltHKta7aNrt9Y8CH5o3mXOkyKc3eSmZa+7+quZKXqavpCUWRunQK7wTTZg3xnKRh8+72VI/xQfaQ
	bf9dwgpzIFDX6T2htPKt03+aOB/uSpT3xtbSeejzXB6oajGswe6qZy4RJmKmDCeWJgQPuS0yg3Hkr
	sAc0FPo152AKYN1p/r/FBYGe5Ju4utTufU8SUgIZToxiLOEPB5eotwdl1Z5YIOq9C9+WGf2IJZGbs
	mZGcu1bRfgGoUsbyn/Pp0Uk3nZhJp8+My42c2QVWYiNNyaGOCmuUEV9H7LhDrVu/A4dQgT1Bm96qH
	KYHv5aSQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ws4QS-000DGm-0L;
	Thu, 06 Aug 2026 22:10:48 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/6] bpf: Reject load-acquire from pointers requiring fault protection
Date: Thu,  6 Aug 2026 22:10:42 +0200
Message-ID: <20260806201047.333389-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28084/Thu Aug  6 08:24:46 2026)

A BPF_LOAD_ACQ is not rewritten to a BPF_PROBE_MEM load by the verifier,
unlike a regular BPF_LDX, so the JIT emits a plain load with no exception
table entry and a fault panics the kernel instead of being handled.

Reject the source pointer types that a BPF_LDX would have had that fault
protection applied to, i.e. the ones bpf_convert_ctx_accesses() turns
into BPF_PROBE_MEM: a bare PTR_TO_BTF_ID, PTR_TO_BTF_ID | PTR_UNTRUSTED,
PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED and PTR_TO_MEM | MEM_RDONLY |
PTR_UNTRUSTED.

This is reachable e.g. by loading ->mm out of a trusted task_struct
yields an untrusted pointer to mm_struct, and it is NULL for a kernel
thread:

  [...]
  SEC("tp_btf/sched_switch")
  int BPF_PROG(demo, bool preempt, struct task_struct *prev,
               struct task_struct *next)
  {
      struct mm_struct *mm = next->mm;  /* untrusted */

      out_ldx = (__u64)mm->pgd;         /* BPF_LDX      */
      out_acq = load_acquire(&mm->pgd); /* BPF_LOAD_ACQ */
      return 0;
  }
  [...]

Both dereference the same pointer, but only the BPF_LDX is protected
(x86-64 JIT, jump targets shown prog-relative):

  [...]
  ; out_ldx = (__u64)mm->pgd;
  17:   movq    $-10485760, %r10
  1e:   movq    %rsi, %r11
  21:   addq    $184, %r11
  28:   subq    %r10, %r11
  2b:   movabsq $140737498841088, %r10
  35:   cmpq    %r10, %r11
  38:   ja      0x3e                 <-- kernel addr?
  3a:   xorl    %edi, %edi           <-- no: dst = 0, skip the load
  3c:   jmp     0x45
  3e:   movq    184(%rsi), %rdi      <-- yes: load + extable entry
  [...]
  ; load_acquire(&mm->pgd)
  53:	movq    %rsi, %rdi
  56:	movq    184(%rdi), %rax       <-- no check, no extable entry
  [...]

Note that BPF_PROBE_MEM is not visible in a bpftool xlated dump, as
bpf_insn_prepare_dump() rewrites it back to BPF_MEM.

A PTR_TRUSTED pointer is deliberately not on the list. Such a load is
not converted either, but it does not need to be, since the pointer is
guaranteed live, so load-acquire from it stays allowed.

The check is gated on BPF_LOAD_ACQ so that atomic RMW and store-release
error messages are unchanged; writes (RMW / store-release) to such
pointers are already rejected elsewhere, so only load-acquire needs this.

Fixes: 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")
Reported-by: STAR Labs SG <info@starlabs.sg>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6233c0081d1..648c5784178e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4923,6 +4923,30 @@ static bool is_arena_reg(struct bpf_verifier_env *env, int regno)
 	return reg->type == PTR_TO_ARENA;
 }
 
+static bool is_load_acq_unsafe(struct bpf_verifier_env *env, int regno,
+			       struct bpf_insn *insn)
+{
+	const struct bpf_reg_state *reg = reg_state(env, regno);
+
+	/*
+	 * A BPF_LOAD_ACQ is not rewritten to a BPF_PROBE_MEM load by the
+	 * verifier, unlike a regular BPF_LDX. The JIT would emit a plain load
+	 * with no exception table entry, so a fault (e.g. NULL deref) crashes
+	 * the kernel instead of being handled.
+	 *
+	 * Reject the source pointer types that a BPF_LDX would have had that
+	 * fault protection applied to, i.e. the ones bpf_convert_ctx_accesses()
+	 * turns into BPF_PROBE_MEM: a bare PTR_TO_BTF_ID and any PTR_UNTRUSTED
+	 * pointer (untrusted btf ids, untrusted MEM_ALLOC, rdonly untrusted
+	 * memory). A PTR_TRUSTED pointer is not among them, is not converted,
+	 * and stays allowed. Same for the other flagged PTR_TO_BTF_ID variants
+	 * (MEM_ALLOC, MEM_RCU, ...), hence the exact match on the base type.
+	 */
+	return insn->imm == BPF_LOAD_ACQ &&
+	       (reg->type == PTR_TO_BTF_ID ||
+		(type_flag(reg->type) & PTR_UNTRUSTED));
+}
+
 /* Return false if @regno contains a pointer whose type isn't supported for
  * atomic instruction @insn.
  */
@@ -4939,7 +4963,8 @@ static bool atomic_ptr_type_ok(struct bpf_verifier_env *env, int regno,
 		return false;
 	if (is_arena_reg(env, regno))
 		return bpf_jit_supports_insn(insn, true);
-
+	if (is_load_acq_unsafe(env, regno, insn))
+		return false;
 	return true;
 }
 
-- 
2.43.0

