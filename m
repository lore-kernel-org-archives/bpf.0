Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78C5539783
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175475; cv=none; b=tbp8afcqQuuw3vsFVZ0/9lhYY0rwDnAqD4Gv7XgxCSv9m5pJ3Y+DcsHKrkmEbVwnDXB+HpQrA/Py89kuHSTimPh5o1i+NL2PDHVdRvf2NqChQRfm+brhE7HITjgxoqMH9vOyA4XIBimCzL39cU3WEiZje6n3oupyqa/wKqGNnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175475; c=relaxed/simple;
	bh=u7p7GU/2ksAhxs5SIjjeY+owu8D8zsJ+KBMnbOWdPUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hb4amZMtKf/LvDd4/UXjo0OfdDqn6Nq+Yro+XORCidbdTu8J0mhgwnprlIe/P1gCe2U/mTwxBJYhqf4+n9o9FArxirKPkGVDEaQWf0tf0NwwFSfdhbPEAY45kZuJsaDUlrmR/P/Kw3QxnwB/vpJBQU7zcS+uLAwmK9z0QOt2vX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0979831A0DA97F; Fri, 16 Oct 2026 11:31:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 4/9] bpf: Describe a BPF function to its trampoline as one u64 per slot
Date: Fri, 16 Oct 2026 11:31:00 -0700
Message-ID: <20261016183100.1134528-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016183039.1132126-1-yonghong.song@linux.dev>
References: <20261016183039.1132126-1-yonghong.song@linux.dev>
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
between r9 and the stack. The s390 trampoline, which takes a 16-byte
argument by reference, loads s through its first half as if that were a
pointer, and saves and restores only three of the four registers the
caller passed.

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
index ec136cf377c1..6d87f59e99b8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22006,6 +22006,32 @@ static bool attach_uses_trampoline_retval(enum b=
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
@@ -22279,6 +22305,11 @@ int bpf_check_attach_target(struct bpf_verifier_=
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

