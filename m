Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF13390229
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036980; cv=none; b=T+eQBZKyHO5i8yTYbJE7RlRKHg5Jl8ikKHYiyNoqzBwMBy+7gsrsIolzBKdZl1ZpGARrXER2N3OVY0hUsXKcOHvs7ppunRg2uAPwJHoO78UySGEE119dedvv3wmJElJZ0tGrhhRsu2x1ckOua1vzTEHHGKVpaThcTtsoRP5lrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036980; c=relaxed/simple;
	bh=RVwcRU5kMldK2v+ACSYfR+nKe98tqo9TF0HRnrBVG7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jllm4YlsSHW0jPvFz7ZtrwtK02euXa6KYj44kCgKAB6LrT3H/X4UfYO3hNUgKgTGN1jMMOG31enMvIKZ5sy1+EZ4GEHstaFQcewbdZD7cC1m5bMYhYw7+JMmC/Y3BYReiXunrC3YIsqGRS9+bNSrCXgx9+NBphYkLbL30Je3NgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2CE2431498F240; Wed, 14 Oct 2026 21:02:45 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 12/26] bpf: Keep an epilogue for each subprog an unwind can pass through
Date: Wed, 14 Oct 2026 21:02:45 -0700
Message-ID: <20261015040245.860484-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015040143.854070-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A later patch makes bpf_unwind() walk the BPF frames on the stack. A
frame whose call site has a landing pad continues at the pad. Any other
frame is sent to its epilogue: its saved return address is rewritten to
point there, and the frame returns to its caller from it. The x86 JIT
emits a function's epilogue at its first exit insn, so every subprog the
walk can pass through needs an exit that is still there when it is JITed.
There are two ways it can be missing.

First, dead code removal deletes an exit the verifier never reached. In a
subprog whose path to its exit always goes through a call that unwinds,
that is every exit it has.

Second, a compiler emits no exit for a function that never returns. Built
with panic=3Dunwind, rustc compiles

        #[inline(never)]
        fn fail() -> ! { unsafe { bpf_unwind() }; loop {} }

to

        fail:
                call bpf_unwind
        L0:     goto L0

bpf_exc_patch_unwind_calls() later puts 'r0 =3D 0; exit' after the
bpf_unwind() call, and fail() returns through it, since the walk leaves
the return address of the frame that called bpf_unwind() alone. A
function that calls fail() and then loops the same way, though, has no
exit at all for the walk to send it to.

Add keep_subprog_exits(), which dead code removal calls before removing
anything. For each subprog that can unwind and that the verifier reached,
it marks the last exit as seen, so that the exit is kept. If the subprog
has no exit, it puts one after the subprog's last insn. Only the walk
ever gets there. keep_subprog_exits() runs before the exits after
bpf_unwind() and bpf_unwind_resume() calls are added, so a frame like
fail() gets one too, which is never reached.

The exit is put in by patching the last insn into itself followed by the
exit. The patch leaves most of the last insn's aux data on the exit, so
it is put back on the last insn, its nospec mark and kfunc data
included.

Once the next patch lets a subprog end with a call, that insn may be a
call to a subprog placed after the frame. The exit moves the callee down
by one insn, so adjust the call's offset.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/fixups.c | 60 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 158a0e033dbb..e634d838cf5f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -734,13 +734,67 @@ static void keep_funcs_with_addr_taken(struct bpf_v=
erifier_env *env)
 	}
 }
=20
+/*
+ * The walk sends a frame that a callee unwinds through to its epilogue,=
 which
+ * the x86 JIT emits at the first exit, so keep one. A frame that only u=
nwinds
+ * may have none: put one after its last insn.
+ */
+static int keep_subprog_exits(struct bpf_verifier_env *env)
+{
+	struct bpf_insn patch[2] =3D { {}, BPF_EXIT_INSN() };
+	struct bpf_prog *new_prog;
+	u32 i, j;
+
+	for (i =3D 0; i < env->subprog_cnt; i++) {
+		u32 start, end;
+		bool found =3D false;
+
+		if (!env->subprog_info[i].might_unwind)
+			continue;
+		start =3D env->subprog_info[i].start;
+		if (!env->insn_aux_data[start].seen)
+			continue;
+
+		end =3D env->subprog_info[i + 1].start;
+		for (j =3D end; j-- > start; ) {
+			if (env->prog->insnsi[j].code =3D=3D (BPF_JMP | BPF_EXIT)) {
+				found =3D true;
+				break;
+			}
+		}
+		if (!found) {
+			struct bpf_insn_aux_data aux =3D env->insn_aux_data[end - 1];
+			struct bpf_insn *last;
+
+			patch[0] =3D env->prog->insnsi[end - 1];
+			new_prog =3D bpf_patch_insn_data(env, end - 1, patch, 2);
+			if (!new_prog)
+				return -ENOMEM;
+			env->prog =3D new_prog;
+			env->insn_aux_data[end - 1] =3D aux;
+			memset(&env->insn_aux_data[end], 0, sizeof(aux));
+			last =3D &new_prog->insnsi[end - 1];
+			if (bpf_pseudo_call(last) && last->imm >=3D 0)
+				last->imm++;
+			j =3D end;
+		}
+		env->insn_aux_data[j].seen =3D env->pass_cnt;
+	}
+	return 0;
+}
+
 int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
 {
-	struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;
-	int insn_cnt =3D env->prog->len;
-	int i, err;
+	struct bpf_insn_aux_data *aux_data;
+	int i, insn_cnt, err;
=20
 	keep_funcs_with_addr_taken(env);
+	err =3D keep_subprog_exits(env);
+	if (err)
+		return err;
+
+	aux_data =3D env->insn_aux_data;
+	insn_cnt =3D env->prog->len;
=20
 	for (i =3D 0; i < insn_cnt; i++) {
 		int j;
--=20
2.53.0-Meta

