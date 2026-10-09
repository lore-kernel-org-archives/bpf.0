Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943245A287
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528151; cv=none; b=bMdzpY+gxQ0o0BcLPoMvSKqOnxJOEwFgDznb0yvslVPrEukQEHSBfWPMhCRa6Hp3KsqLDCOOkb6rq9sn5G7rVEpFyHFYNToKdERpxLG4s8O3Ob7O9MKv7MHYyabWTTK0+/e1eXAhtPnyE6GV0q51ey15DXoKF5boo9eUQUS8rZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528151; c=relaxed/simple;
	bh=neyzfZHPWAXA5P3bVaQx0gNGYxuxPlJXX2R0mtY9/9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSG2DNivadRN+kUI7KWW1VrfstpQ1RDsOhny11xbyvTaRWjsMkWc9etMLxHcx1vSmnWQ8SltOfU7O2mWqRJ+LROqKkfJ35OLmepXeGV+KHkhGRMl8+7YjYrJGNLyDAMYSkb8yWn/qv+wGZzk2pewnIKNQ9vvbIzLZzDGoV7mbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id A673D300E277C1; Thu,  8 Oct 2026 23:42:16 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 2/5] bpf: Keep the BPF calling convention for a trampoline on a BPF function
Date: Thu,  8 Oct 2026 23:42:16 -0700
Message-ID: <20261009064216.1239645-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009064206.1238047-1-yonghong.song@linux.dev>
References: <20261009064206.1238047-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A trampoline on a BPF function, fentry or fexit attached through
attach_prog_fd, takes the function's arguments from where BPF code left
them. A call from one BPF function to another passes them in the BPF
convention, one argument slot after another: only a kfunc call is moved
into the kernel convention. bpf_jit_place_args(), which the arm64
trampoline uses since commit afdbb4cdd3d2 ("bpf, arm64: Place trampoline
arguments by the arm64 calling convention"), places them by the kernel
convention instead. For a BPF function taking a 16-byte aligned argument
at an odd slot, such as

	u64 f(u64 a, struct { __int128 v; } s, u64 b)

the trampoline reads s from x2 and x3 where the caller left it in x1 and
x2, and b from x4, so the program sees the wrong values, and an fexit
trampoline hands the function shifted arguments.

Mark the model of a target program's function as bpf_tgt_prog, and have
bpf_jit_place_args() leave every slot of such a model where the BPF
convention put it. That is where both JITs pass it in a call from one
BPF function to another: slot N where the kernel convention passes its
Nth eightbyte, in a register or a stack slot. The x86-64 trampoline does
not use bpf_jit_place_args() yet; the next patch makes it, and this
keeps it right for a BPF target.

Fixes: afdbb4cdd3d2 ("bpf, arm64: Place trampoline arguments by the arm64=
 calling convention")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/btf.c      |  1 +
 kernel/bpf/core.c     | 12 ++++++++++++
 kernel/bpf/verifier.c |  1 +
 4 files changed, 16 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..6dbc09356e60 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1260,6 +1260,8 @@ struct btf_func_model {
 	u8 ret_size;
 	u8 ret_flags;
 	u8 nr_args;
+	/* a function of a BPF target program, called in the BPF convention */
+	bool bpf_tgt_prog;
 	u8 arg_size[MAX_BPF_FUNC_ARGS];
 	u8 arg_flags[MAX_BPF_FUNC_ARGS];
 };
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0630675377aa..3a05cf2fde8e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8019,6 +8019,7 @@ int btf_distill_func_proto(struct bpf_verifier_log =
*log,
 	u32 i, nargs;
 	int ret;
=20
+	m->bpf_tgt_prog =3D false;
 	if (!func) {
 		/* BTF function prototype doesn't match the verifier types.
 		 * Fall back to MAX_BPF_FUNC_REG_ARGS u64 args.
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 05c89396119a..22dced3f59f3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3342,6 +3342,18 @@ u32 bpf_jit_place_args(const struct bpf_jit_arg_ab=
i *abi,
 	u32 i, k, nslots, slot =3D 0, nregs_used =3D 0, stack_off =3D 0;
 	bool on_stack =3D false;
=20
+	/*
+	 * A BPF function is called by BPF code, which passes slot N where
+	 * the kernel convention passes its Nth eightbyte, whatever the
+	 * arguments: no hole, no split refused and no register backfilled.
+	 */
+	if (fm->bpf_tgt_prog) {
+		for (i =3D 0; i < fm->nr_args; i++)
+			for (k =3D btf_func_model_arg_slots(fm, i); k > 0; k--, slot++)
+				pos_of_slot[slot] =3D slot;
+		return slot;
+	}
+
 	for (i =3D 0; i < fm->nr_args; i++) {
 		bool align16 =3D fm->arg_flags[i] & BTF_FMODEL_ALIGN16_ARG;
 		u32 pos;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 353bde9ae227..50a06c2d3f7f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21620,6 +21620,7 @@ int bpf_check_attach_target(struct bpf_verifier_l=
og *log,
 		ret =3D btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
 		if (ret < 0)
 			return ret;
+		tgt_info->fmodel.bpf_tgt_prog =3D !!tgt_prog;
=20
 		if (tgt_info->fmodel.ret_size > 8 &&
 		    attach_uses_trampoline_retval(prog->expected_attach_type)) {
--=20
2.53.0-Meta

