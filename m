Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05251A726
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911418; cv=none; b=jajrXZlhJ0gp3RYrMc3Gy8+0n4AfFI5GzcnFB5Nckfw4m7ggcVcBr86A6OODWfk5zmNKHqi5gKKH4bLlsuwz6KDim1RvSWHr0e9v6DUlrxQABnvBj22VR+S01CGl2ZAmDio0gUDGdtk7UEu2T1qrcfw1jq+N8MPvMEp1mlMQHRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911418; c=relaxed/simple;
	bh=h7ERa8eL2BVS1UdlB9QN/9geT2DLH5HjJNz6PMxFD4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJQ8MSt/EZcsm5syl1+7J5cmjNBk15KERtmzpFdTJA+8skqOQsr0bXg/gHzIljryPuIIK3XzobAxCQI9ofoSfpEdQwxmduP97JYq/l9ML6m4/GDe4ZXJJHnHHs3Yo+bBKys8J+aC9fGUWheZRlArSiLbfp/Dwr8ZYbDiI/9N9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 73C5530FB5C4B4; Tue, 13 Oct 2026 10:09:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 04/11] bpf: Describe a BPF function to its trampoline as one u64 per slot
Date: Tue, 13 Oct 2026 10:09:48 -0700
Message-ID: <20261013170948.2132429-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013170910.2126673-1-yonghong.song@linux.dev>
References: <20261013170910.2126673-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A trampoline on a BPF function, fentry, fexit or fsession attached
through attach_prog_fd, takes the function's arguments from where BPF
code left them. A call from one BPF function to another passes slot N
where the kernel convention passes its Nth u64 argument, in a register
or a stack slot, whatever the types of the arguments: the x86-64, arm64
and riscv JITs all place a stack argument that way. The model of the
function, distilled from its BTF, still carries those types, so each
arch places the arguments by its own rules for them. For a 16-byte
argument at an odd slot, such as s in

	u64 f(u64 a, struct { __int128 v; } s, u64 b)

the arm64 trampoline reads s from x2 and x3, where the caller left it in
x1 and x2, and b from x4. And an x86-64 trampoline puts a 16-byte
argument at slot 6 wholly on the stack, while x86-64 BPF code splits it
between r9 and the stack.

Rewrite the model of a target program's function in
bpf_check_attach_target() as one u64 argument per argument slot.
Every convention places N u64 arguments in slot order, so all of the
above take them from where BPF code put them, and no arch has to know
that the function is a BPF one.

The model no longer gives the size and flags of each argument, so an
arch that sign-extends a narrow signed argument, or clears the unused
bytes of a narrow stack argument, for the program does not do that for a
BPF function any more: the program gets the eightbyte BPF code passed,
as it does on x86-64, and fexit hands it back unchanged.

Fixes: afdbb4cdd3d2 ("bpf, arm64: Place trampoline arguments by the arm64=
 calling convention")
Fixes: 4dd676ca5b7a ("bpf: Support by-value struct arguments up to 16 byt=
es")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f190abe3448..c7af14a3f0e8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22002,6 +22002,32 @@ static bool attach_uses_trampoline_retval(enum b=
pf_attach_type type)
 	}
 }
=20
+/*
+ * BPF code passes argument slot N where the kernel convention passes it=
s Nth
+ * u64 argument, so describe a BPF function to its trampoline as one u64=
 per
+ * slot, and every arch places its arguments right.
+ */
+static int flatten_bpf_func_model(struct bpf_verifier_log *log, const ch=
ar *tname,
+				  struct btf_func_model *m)
+{
+	u32 i, nslots =3D 0;
+
+	for (i =3D 0; i < m->nr_args; i++)
+		nslots +=3D btf_func_model_arg_slots(m, i);
+	if (nslots > MAX_BPF_FUNC_ARGS) {
+		bpf_log(log, "The function %s has %u argument slots. Too many.\n",
+			tname, nslots);
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < nslots; i++) {
+		m->arg_size[i] =3D sizeof(u64);
+		m->arg_flags[i] =3D 0;
+	}
+	m->nr_args =3D nslots;
+	return 0;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -22275,6 +22301,11 @@ int bpf_check_attach_target(struct bpf_verifier_=
log *log,
 		ret =3D btf_distill_func_proto(log, btf, t, tname, &tgt_info->fmodel);
 		if (ret < 0)
 			return ret;
+		if (tgt_prog) {
+			ret =3D flatten_bpf_func_model(log, tname, &tgt_info->fmodel);
+			if (ret < 0)
+				return ret;
+		}
=20
 		if (tgt_info->fmodel.ret_size > 8 &&
 		    attach_uses_trampoline_retval(prog->expected_attach_type)) {
--=20
2.53.0-Meta

