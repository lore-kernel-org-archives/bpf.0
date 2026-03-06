Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC23495507;
	Fri,  6 Mar 2026 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835226; cv=none; b=HAsVgfrz0Qnd9CwmGnthnMzP6Y7/mxxAvnGVrOje4HvBBK0yYlm90ktN/HQb/D8YXTLag78uleM56Pa3jX3DUEaJPnw+bolP8LDB/cwZtnWmlt/mGxA+XwZIx9H7xiyV5ghVrBsI0Z1fWxgm7Tf7KZ7LPQ3vXA4IklI8lkryfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835226; c=relaxed/simple;
	bh=CAxEUFGkDw2vOY2BOgBahxA+NyU6Q1AB5+DtigJteQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jocp1ZsZWdUY2DFLcdBnEOGrsqoxh2tIaH2h5ZmaJPGXE2pluN+EK+gIpv5cjEF0rrtyHhuagTGiAl1O1wfkWgKx6WLkfY7vEe9yt/AoEEJ196a/B6TrelflSgZDNpd+GrVkKmDPQJEqrooH+OMvdIHTBqXewFqBQ88nR9ifeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6127175D;
	Fri,  6 Mar 2026 14:13:37 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69CCA3F7BD;
	Fri,  6 Mar 2026 14:13:41 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	richardcochran@gmail.com,
	a.s.protopopov@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 3/3] bpf: arm64: fix BTI exception when execute gotox instruction
Date: Fri,  6 Mar 2026 22:13:30 +0000
Message-Id: <20260306221330.630971-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306221330.630971-1-yeoreum.yun@arm.com>
References: <20260306221330.630971-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems where FEAT_BTI is enabled, running the verifier_gotox testcase
triggers a BTI exception:

  [  257.920598] Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
  [  257.920740] Modules linked in:
  [  257.920860] CPU: 4 UID: 0 PID: 239 Comm: test_progs Not tainted 7.0.0-rc2+ #602 PREEMPT(full)
  [  257.921061] Hardware name:  , BIOS
  [  257.921160] pstate: 161402c09 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=j-)
  [  257.921337] pc : bpf_prog_0a2b4e44c75a3cb4_jump_table_ok+0x40/0x60
  [  257.921491] lr : bpf_test_run+0x1e8/0x460
  [  257.921639] sp : ffff80008435b7f0
  [  257.921736] x29: ffff80008435b800 x28: ffff80008435b858 x27: ffff80008435b870
  [  257.921991] x26: ffff80008435b7f0 x25: f8ff000803478000 x24: 0000000000000001
  [  257.922243] x23: f0ff8000839bd000 x22: f4ff000801f7f200 x21: ffff80008435b9a4
  [  257.922498] x20: ffff80008435b9a0 x19: 0000000000000000 x18: 0000000000000000
  [  257.922743] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
  [  257.922992] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
  [  257.923232] x11: 000000000000dd86 x10: 0000000000000000 x9 : ffff8000814f06f0
  [  257.923480] x8 : ffff800083d9d888 x7 : ffff800083d9d8c8 x6 : 0000000000000000
  [  257.923731] x5 : 0000000000000000 x4 : ffff80008435b9a0 x3 : 0000000000000000
  [  257.923976] x2 : 0000000000000000 x1 : f0ff8000839bd060 x0 : f4ff000801f7f200
  [  257.924226] Call trace:
  [  257.924307]  bpf_prog_0a2b4e44c75a3cb4_jump_table_ok+0x40/0x60 (P)
  [  257.924481]  bpf_test_run+0x1e8/0x460
  [  257.924644]  bpf_prog_test_run_skb+0x424/0x708
  [  257.924820]  bpf_prog_test_run+0xf4/0x218
  [  257.924978]  __sys_bpf+0x3c4/0x498
  [  257.925124]  __arm64_sys_bpf+0x30/0x58
  [  257.925312]  invoke_syscall+0x68/0xe8
  [  257.925490]  el0_svc_common+0x94/0xf8
  [  257.925668]  do_el0_svc+0x28/0x48
  [  257.925840]  el0_svc+0x40/0x100
  [  257.925998]  el0t_64_sync_handler+0x84/0x140
  [  257.926172]  el0t_64_sync+0x1bc/0x1c0
  [  257.926359] Code: f28bea07 910020e7 f94000e7 d61f00e0 (d2800027)
  [  257.926489] ---[ end trace 0000000000000000 ]---
  [  257.926612] Kernel panic - not syncing: Oops - BTI: Fatal exception in interrupt
  [  257.926755] SMP: stopping secondary CPUs
  [  257.927208] Kernel Offset: disabled
  [  257.927300] CPU features: 0x0000000,00040f05,dffb65e1,976ff727
  [  257.927437] Memory Limit: none
  [  257.927540] ---[ end Kernel panic - not syncing: Oops - BTI: Fatal exception in interrupt ]---

This occurs because the target of the gotox instruction
(BPF_JMP | BPF_JA | BPF_X) does not begin with a BTI instruction.

To fix this, emit a BTI J instruction at the beginning of
the gotox destination block.

after this patch verifier_gotox passes without exception:

  # ./test_progs -a verifier_gotox
  ...
  #540/1   verifier_gotox/jump_table_ok:OK
  #540/2   verifier_gotox/jump_table_reserved_field_src_reg:OK
  #540/3   verifier_gotox/jump_table_reserved_field_non_zero_off:OK
  #540/4   verifier_gotox/jump_table_reserved_field_non_zero_imm:OK
  #540/5   verifier_gotox/jump_table_no_jump_table:OK
  #540/6   verifier_gotox/jump_table_incorrect_dst_reg_type:OK
  #540/7   verifier_gotox/jump_table_invalid_read_size_u32:OK
  #540/8   verifier_gotox/jump_table_invalid_read_size_u16:OK
  #540/9   verifier_gotox/jump_table_invalid_read_size_u8:OK
  #540/10  verifier_gotox/jump_table_misaligned_access:OK
  #540/11  verifier_gotox/jump_table_invalid_mem_acceess_pos:OK
  #540/12  verifier_gotox/jump_table_invalid_mem_acceess_neg:OK
  #540/13  verifier_gotox/jump_table_add_sub_ok:OK
  #540/14  verifier_gotox/jump_table_no_writes:OK
  #540/15  verifier_gotox/jump_table_use_reg_r0:OK
  #540/16  verifier_gotox/jump_table_use_reg_r1:OK
  #540/17  verifier_gotox/jump_table_use_reg_r2:OK
  #540/18  verifier_gotox/jump_table_use_reg_r3:OK
  #540/19  verifier_gotox/jump_table_use_reg_r4:OK
  #540/20  verifier_gotox/jump_table_use_reg_r5:OK
  #540/21  verifier_gotox/jump_table_use_reg_r6:OK
  #540/22  verifier_gotox/jump_table_use_reg_r7:OK
  #540/23  verifier_gotox/jump_table_use_reg_r8:OK
  #540/24  verifier_gotox/jump_table_use_reg_r9:OK
  #540/25  verifier_gotox/jump_table_outside_subprog:OK
  #540/26  verifier_gotox/jump_table_contains_non_unique_values:OK
  #540     verifier_gotox:OK

Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/net/bpf_jit_comp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index adf84962d579..e54e45b35015 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1223,6 +1223,21 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	int off_adj;
 	int ret;
 	bool sign_extend;
+	struct bpf_prog_aux *aux = ctx->prog->aux;
+
+	/*
+	 * In some cases, insn_aux_data is not passed,
+	 * and it does not need to be. For example, the embedded
+	 * program in ptp_classifier_init().
+	 * Therefore, we need to check whether insn_aux_data is present.
+	 */
+	if (aux->insn_aux_data) {
+		/*
+		 * emit BTI J for (BPF_JMP | BPF_X)'s destination.
+		 */
+		if (aux->insn_aux_data[i].gotox_point)
+			emit_bti(A64_BTI_J, ctx);
+	}
 
 	switch (code) {
 	/* dst = src */
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

