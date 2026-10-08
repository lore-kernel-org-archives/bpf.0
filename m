Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E63E5A31
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445858; cv=none; b=nvzIZDLRK/4MicUo4eFJuJIPH7y++QD6gpkw1aGVRCgX1KYqfQGcWYEdSNNkBeAMSZskv2NrVgK+WoBag+gOsFvwBrjJt1mKP5jZzdfpQAHzu7kjj+bewl5d86T7PND3XzLpMyjEHwu1FJYvwFCE42vtvAMwHz3lkXakqTc5jz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445858; c=relaxed/simple;
	bh=pWoLsJRwBw0Spp/4E08TTN6DykrYOd6Wamb4y8NnLrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwY4PHy1mQv3TOhUuHVDrLgYWouVkRfgxjDmUxG3CTU8Ku7zv6j3C1Ju/8qre1JWedpkxJ9b56XCIcb7TOAHeatKSs8+umYH0vUgI9lGkdrDJfigH25SU6fOjxZvG2t9tBEbwXKi/GyNx24/PxBp2GAkzEniof5nI58wCVk9GZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id F2FB82FDA0C149; Thu,  8 Oct 2026 00:50:55 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v9 11/23] bpf: Dispatch cleanup pads by rewriting return addresses
Date: Thu,  8 Oct 2026 00:50:55 -0700
Message-ID: <20261008075055.3000922-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008074959.2993751-1-yonghong.song@linux.dev>
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bpf_unwind() now walks the BPF frames through arch_bpf_stack_walk_ra()
and rewrites the saved return address of each frame above the one that
called it: to the pad where a record covers the call, else to the
frame's epilogue. The walk stops after the main function. For the
verifier patch's example, main -> A -> B -> C with only A's call to B
covered:

  slot                    points into               rewritten to
  ----------------------  ------------------------  ---------------------
  bpf_unwind()'s return   C, after its unwind call  left alone
  C's return              B, after 'call C'         B's epilogue
  B's return              A, after 'call B'         P, A's pad
  A's return              main, after 'call A'      main's epilogue
  main's return           the kernel                left alone

Each frame then just returns: C through the 'r0 =3D 0; exit' after its
bpf_unwind(), B and main through their epilogues, A through its pad P
and P's resume.

The walk finds the frames in the calling program, not with
bpf_prog_ksym_find(). A running instance holds no reference to its
program, so user space can drop the last one, by closing the program's
fds and links, while the instance still runs: the kallsyms entries go at
once, and only freeing the program waits for the RCU or RCU Tasks Trace
grace period. An unwind in between, say in a sleepable program blocked
in bpf_copy_from_user(), would find none of its frames, so no pad would
run. So bpf_unwind() takes the program's aux as a KF_IMPLICIT_ARGS
argument, which keeps its BTF prototype void(void), and matches each
return address against aux->func[], or the program itself. To get the
implicit argument loaded, adjust_insn_aux_data() moves arg_prog, as it
moves cleanup_pad, to the slot the original instruction kept: the unwind
call stays first in its patch.

Both kfuncs become callable here. bpf_unwind() is notrace and NOKPROBE:
a tracer hooking its return would leave a trampoline in the slot of the
frame that called it, which the walk cannot rewrite.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/fixups.c  |  2 ++
 kernel/bpf/helpers.c | 67 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 1cc025c45ecd..c29e14ffc475 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -247,6 +247,8 @@ static void adjust_insn_aux_data(struct bpf_verifier_=
env *env,
 			data[off + cnt - 1].non_stack_access =3D false;
 			data[i].cleanup_pad =3D data[off + cnt - 1].cleanup_pad;
 			data[off + cnt - 1].cleanup_pad =3D 0;
+			data[i].arg_prog =3D data[off + cnt - 1].arg_prog;
+			data[off + cnt - 1].arg_prog =3D 0;
 		} else if (bpf_is_mem_insn(insn + i)) {
 			data[i].non_stack_access =3D true;
 		}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4eccd6742eba..c9efb789f36b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,8 +29,10 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/kprobes.h>
=20
 #include "../../lib/kstrtox.h"
+#include "exception.h"
=20
 /* If kernel subsystem is allowing eBPF programs to call this function,
  * inside its own verifier_ops->get_func_proto() callback it should retu=
rn
@@ -3424,9 +3426,70 @@ static bool bpf_stack_walker(void *cookie, u64 ip,=
 u64 sp, u64 bp)
 	return false;
 }
=20
-__bpf_kfunc void bpf_unwind(void)
+struct bpf_unwind_ctx {
+	const struct bpf_prog_aux *aux;
+	u32 cnt;
+};
+
+static bool bpf_unwind_ip_in(const struct bpf_prog *prog, u64 ip)
+{
+	u64 start =3D (u64)(long)prog->bpf_func;
+
+	return ip > start && ip <=3D start + prog->jited_len;
+}
+
+/*
+ * The function of the calling program that @ip returns into, looked up =
in the
+ * program itself: its kallsyms entries can go while an instance still r=
uns.
+ * The main function is the outer program, which holds its table and epi=
logue.
+ */
+static struct bpf_prog *bpf_unwind_find_prog(const struct bpf_prog_aux *=
aux, u64 ip)
+{
+	u32 i;
+
+	for (i =3D 1; i < aux->func_cnt; i++)
+		if (bpf_unwind_ip_in(aux->func[i], ip))
+			return aux->func[i];
+	return bpf_unwind_ip_in(aux->prog, ip) ? aux->prog : NULL;
+}
+
+static bool bpf_unwind_rewrite(void *cookie, u64 ip, u64 sp, u64 bp, u64=
 *ra)
+{
+	const struct bpf_cleanup_range *rec;
+	struct bpf_unwind_ctx *ctx =3D cookie;
+	struct bpf_prog *prog;
+
+	prog =3D bpf_unwind_find_prog(ctx->aux, ip);
+	if (!prog)
+		return !ctx->cnt;
+	ctx->cnt++;
+
+	/*
+	 * The frame that called bpf_unwind(): bpf_exc_patch_unwind_calls()
+	 * put 'r0 =3D 0' and a jump to its pad, or an exit, after the call,
+	 * so leave its return address alone and let it go on there. The pad
+	 * then starts with r0 at a known zero.
+	 */
+	if (ctx->cnt =3D=3D 1)
+		return bpf_is_subprog(prog);
+
+	rec =3D bpf_exc_pad_for_ip(prog, ip);
+	*ra =3D rec ? rec->pad : prog->aux->epilogue_ip;
+
+	return bpf_is_subprog(prog);
+}
+
+/*
+ * @aux is the calling program's, supplied by the verifier (KF_IMPLICIT_=
ARGS):
+ * programs call bpf_unwind() with no arguments.
+ */
+__bpf_kfunc notrace void bpf_unwind(struct bpf_prog_aux *aux)
 {
+	struct bpf_unwind_ctx ctx =3D { .aux =3D aux };
+
+	arch_bpf_stack_walk_ra(bpf_unwind_rewrite, &ctx);
 }
+NOKPROBE_SYMBOL(bpf_unwind);
=20
 __bpf_kfunc void bpf_throw(u64 cookie)
 {
@@ -5095,6 +5158,8 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
 | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_unwind, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_unwind_resume)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task)
 #endif
--=20
2.53.0-Meta

