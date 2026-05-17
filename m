Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363BA328267
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030438; cv=none; b=d9z0pAVr2rAyMsNv3QJ8SRIpuFB2iNnNGhvMahG1M13msvSr/5Rfj9d4lapfwyhPAkWXEPCRZ9EUF4JO/dbh5AeN8PHGZgtUp4GdGfXRLOwuk1VXy7+oajHjSrnuyyzYClg06k+syUIiNxHUG+Rv/xM+aH8utpDkckz9tzut3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030438; c=relaxed/simple;
	bh=3Tl4MjWeSk13BJ9vi5QwbHoPzkFHetfY4xAyfTVeemQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKaFd8oqGZwf0tZZYZyDkNQuF0MkSv3UNqpHK7a5+TlHzmc6FxoxufAq9aRdf6f+Qx3cPb2WsYyrj1hPAIe6+HLWhlS63AbbQ7/ItLCSexfUyVlMo5OiAViW+uBT2Lym80obaMJEJcCb+HB25R93JfAQdAdssiN0rycun56Fm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5CEDDCA16E0BE; Sun, 17 May 2026 08:07:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf,x86: Fix exception unwinding with outgoing stack arguments
Date: Sun, 17 May 2026 08:07:02 -0700
Message-ID: <20260517150702.288031-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a main program with exception_boundary has outgoing stack
arguments (e.g. from calling subprogs with >5 args), bpf_throw() fails
to correctly restore callee-saved registers, causing a kernel crash.

The x86 JIT allocates the outgoing stack arg area below the
callee-saved registers via 'sub rsp, outgoing_rsp' in the prologue.
When bpf_throw() unwinds, it captures the main program's sp (which
includes this outgoing area) and passes it to the exception callback.
The callback gets rsp and rbp, followed by pop_callee_regs, but rsp
points into the outgoing arg area rather than the callee-saved
registers, so the pops restore garbage values. Returning to the
kernel with corrupted callee-saved registers causes a crash.

Fix this by adjusting the sp (adding stack_arg_sp_adjust) passed to
the exception callback, so it points to the bottom of the callee-saved
registers instead of the outgoing arg area. When stack_arg_sp_adjust
is 0 (the common case), this is a no-op.

Fixes: 324c3ca6eed6 ("bpf,x86: Implement JIT support for stack arguments"=
)
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 2 ++
 include/linux/bpf.h         | 1 +
 kernel/bpf/fixups.c         | 1 +
 kernel/bpf/helpers.c        | 2 +-
 4 files changed, 5 insertions(+), 1 deletion(-)

NOTE:
   Existing arm64 jit already supports exception unwinding with
   stack arguments. In arch/arm64/net/bpf_jit_comp.c, we have
        if (!prog->aux->exception_cb) {
                ...
        } else {
                /* FP =3D x2 */
                emit(A64_MOV(1, A64_FP, A64_R(2)), ctx);
                /* SP =3D FP - 96 */
                emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
        }
   There is no SP adjustment on arm64 as SP points directly at the bottom=
 of the=20
   main program's callee-saved registers.

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ceefefb4da21..a0c541a441cf 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1789,6 +1789,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 	 * Arg 6 goes into r9 register, not on stack.
 	 */
 	outgoing_rsp =3D out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : =
0;
+	if (bpf_prog->aux->exception_boundary)
+		bpf_prog->aux->stack_arg_sp_adjust =3D outgoing_rsp;
 	emit_sub_rsp(&prog, outgoing_rsp);
=20
 	if (arena_vm_start)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 242f9597d9ab..1b28cacc3075 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1736,6 +1736,7 @@ struct bpf_prog_aux {
 	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 	char name[BPF_OBJ_NAME_LEN];
 	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
+	u16 stack_arg_sp_adjust;
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2cec4e8cd4a0..52535671cb9a 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1265,6 +1265,7 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
 	prog->aux->real_func_cnt =3D env->subprog_cnt;
 	prog->aux->bpf_exception_cb =3D (void *)func[env->exception_callback_su=
bprog]->bpf_func;
 	prog->aux->exception_boundary =3D func[0]->aux->exception_boundary;
+	prog->aux->stack_arg_sp_adjust =3D func[0]->aux->stack_arg_sp_adjust;
 	bpf_prog_jit_attempt_done(prog);
 	return 0;
 out_free:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index baa12b24bb64..07de26e7314c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3301,7 +3301,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	 * which skips compiler generated instrumentation to do the same.
 	 */
 	kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
-	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp, 0, 0);
+	ctx.aux->bpf_exception_cb(cookie, ctx.sp + ctx.aux->stack_arg_sp_adjust=
, ctx.bp, 0, 0);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
=20
--=20
2.53.0-Meta

