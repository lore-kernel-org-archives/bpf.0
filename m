Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE02DC79F
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144337; cv=none; b=TtBcyyPwa4mD09P9yNm9sFdwqyC2nj7Dx/pIUqzZEd2X3ADDLhwhI4XEjkdI9oyik1/pw8N5Q5cLcwElIFdIxLhO79f8GvzFnHDPnt4z6kr07HJDrjdVhhsFNo6riI7+B1QTLw0rcEIiYiSxZ/aR6XaynalxEMS9TU0L84voEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144337; c=relaxed/simple;
	bh=nuEuCqtVQzUJQsbtXuvI4UvZUhxIcME75V6G2GfbE0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4BgfKTwm9aWo7+Mp5ZV+SLTb8WL9Lcke7d5uwI1CHe5fcO/n4iV+jUjeFaM1RHAUiR06gxv3twiuAAHuwY7UOm4a+8UL7ZPGPSvET5ABR6Q/h+3yeEWSPzyPliWHjbhgyZitAim9YSLf1K9XCbL4uBjh+AXKZnd36yvfhEyI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bS7dTXA/; arc=none smtp.client-ip=95.215.58.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bS7dTXA/"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nuEuCqtVQzUJQsbtXuvI4UvZUhxIcME75V6G2GfbE0I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787144333; v=1; x=1787749133;
 b=bS7dTXA/6eDSiRLkgho3W//M3KyHHYwaEUJhBbP9BUALA1U8T/b9ewJ7j4/sE+ch8IWbWkW/
 twYsvd85KuKlZQbpBiLh2xVrStn0ZdM6l54G73hIlxQ/mGjBSSgOS0kizKadaLDqFA23QjQHbTn
 dUrD63MA9FiCPrZG/hDGrekY=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.2)
	by smtp.migadu.com with ESMTPS id 814b51ec32df0399;
	Wed, 19 Aug 2026 12:58:53 +0000
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Hiker Cl <clhiker365@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	KaFai Wan <kafai.wan@linux.dev>,
	Daniel Wade <danjwade95@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf: fix REG INVARIANTS VIOLATION on speculative pointer arithmetic
Date: Wed, 19 Aug 2026 20:58:29 +0800
Message-ID: <20260819125840.286434-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take the following unprivileged program as an example:

	r0 = bpf_map_lookup_elem(...)	/* PTR_TO_MAP_VALUE, offset 0 */
	...
	14: r0 += r1			/* r1 is a bounded scalar */
	15: r9 = r0

Loading it triggers a verifier warning from reg_bounds_sanity_check():

	verifier bug: REG INVARIANTS VIOLATION (alu): const subreg tnum out
	of sync with range bounds r64={.base=0x0, .size=0x0}
	r32={.base=0x0, .size=0xffffffff} var_off=(0x0, 0x0)

What happens:

1. Processing insn 14 (r0 += r1) in adjust_ptr_min_max_vals(), the new
   offset is computed into dst_reg's var_off and 32/64-bit ranges.

2. Because pointer registers do not track 32-bit subregister bounds,
   __mark_reg32_unbounded() first sets r32 to the full range; r32 is
   re-derived from the offset at the end of the function by
   reg_bounds_sync().

3. On the unprivileged path, sanitize_ptr_alu() is called and, via
   sanitize_speculative_path() -> push_stack(), snapshots the current
   register state and schedules the next instruction (insn 15) to be
   verified directly as a speculative path.

4. That snapshot is taken between step 2 and the final reg_bounds_sync():
   at this point dst_reg's var_off still holds the (const) original
   offset while r32 has just been blanked to the full range, i.e. the two
   are out of sync. When the speculative path later verifies insn 15
   (r9 = r0), the inconsistent state reaches reg_bounds_sanity_check() and
   trips the warning.

var_off and the 32-bit range must always be consistent. There are two
ways to keep the snapshot consistent:

  1. sync var_off and r32 before the snapshot so they match, or
  2. leave r32 at its original (already consistent) value and blank it
     only after the snapshot.

The whole point of sanitize_ptr_alu() is to insert a harmless masking
sequence that keeps the access in bounds under speculation, so the state
it snapshots should faithfully represent that. Take approach 2: move
__mark_reg32_unbounded() to after sanitize_ptr_alu(), so the speculative
snapshot keeps the pointer's original, consistent r32. The non-speculative
path is unchanged: r32 is still blanked before the offset is applied and
re-derived by reg_bounds_sync().

Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks and sanitization")
Reported-by: Hiker Cl <clhiker365@gmail.com>
Closes: https://lore.kernel.org/bpf/CAGM=xGB1fJ9kT8XTitVo74B0WGqgjkoUHdLwzytwV0AyqeVApw@mail.gmail.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/verifier.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d17f14b35b79..d79038a8da10 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14558,9 +14558,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		return -EINVAL;
 	}
 
-	/* pointer types do not carry 32-bit bounds at the moment. */
-	__mark_reg32_unbounded(dst_reg);
-
 	if (sanitize_needed(opcode)) {
 		ret = sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
 				       &info, false);
@@ -14568,6 +14565,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			return sanitize_err(env, insn, ret);
 	}
 
+	/* Pointer types do not carry 32-bit bounds at the moment. Blank r32
+	 * only after sanitize_ptr_alu() may have snapshotted dst_reg into a
+	 * speculative path: otherwise that snapshot freezes a const offset
+	 * with an unbounded r32, which later trips reg_bounds_sanity_check().
+	 * reg_bounds_sync() below re-derives r32 from the updated offset.
+	 */
+	__mark_reg32_unbounded(dst_reg);
+
 	switch (opcode) {
 	case BPF_ADD:
 		/*
-- 
2.43.0

