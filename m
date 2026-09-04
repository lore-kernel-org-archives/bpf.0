Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7F3B2FE4
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498641; cv=none; b=qEyEOXGkg7XmSfzTBCLdBcOWoexJumiMntk2iOA1HkQq2XMj1oxqHS1dRE+46RtQCOyTVfgQfafdU3KvLsFBwatsLpu+8AoYOR0+1jSIwi1FfaFrV81drg33/AiBFS5kcjoFpd3QtcO72XFKWPFwKOnsqaCwd9I7zn4ST0XTUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498641; c=relaxed/simple;
	bh=sMuJJVLYqXUNowBY5Pndah1lxqEvuMJbxEVzJnu2kdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqkq35XXw3yNdh689Fe8UM1IEbELrvYcgBEIyuZQKyFAhMH+QiR0SnahzVj9ZnBYwItz9S9eJF01Db9XH2WgOazsxWTDojx5ucq1BdIuux6PCkWCikUi48UP/jiEowkkiYJXlGMLOB1u+85WDzqMsfcock5qXL5p/c+UN+Aaj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 62804288131755; Thu,  3 Sep 2026 22:10:28 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 06/12] bpf: Add a JIT helper for the outgoing stack of kfunc calls
Date: Thu,  3 Sep 2026 22:10:28 -0700
Message-ID: <20260904051028.3979694-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904050957.3976119-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add bpf_jit_kfunc_stack_slots() helper which will be used
in x86 and arm64 bpf jit.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/filter.h |  2 ++
 kernel/bpf/core.c      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index e288df4124d3..eddcb9987056 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1239,6 +1239,8 @@ bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
 bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 ali=
gn);
+u16 bpf_jit_kfunc_stack_slots(const struct bpf_prog *prog, u32 nr_regs,
+			      int (*layout)(const struct btf_func_model *fm, u8 *pos, int max=
));
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 5a20d3e1ace9..8fea01377298 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3303,6 +3303,37 @@ bool __weak bpf_jit_supports_kfunc_arg_slot(u32 sl=
ots_used, u32 nslots, u32 alig
 	return false;
 }
=20
+/*
+ * The most outgoing stack eightbytes any kfunc call in @prog needs.
+ * @layout writes a position per eightbyte and returns how many, or an e=
rror.
+ * @nr_regs is how many of those positions are argument registers.
+ */
+u16 bpf_jit_kfunc_stack_slots(const struct bpf_prog *prog, u32 nr_regs,
+			      int (*layout)(const struct btf_func_model *fm, u8 *pos, int max=
))
+{
+	const struct bpf_insn *insn =3D prog->insnsi;
+	u8 pos[MAX_BPF_FUNC_ARGS];
+	int i, k, n, slots =3D 0;
+
+	for (i =3D 0; i < prog->len; i++, insn++) {
+		const struct btf_func_model *fm;
+
+		if (insn->code !=3D (BPF_JMP | BPF_CALL) ||
+		    insn->src_reg !=3D BPF_PSEUDO_KFUNC_CALL)
+			continue;
+		fm =3D bpf_jit_find_kfunc_model(prog, insn);
+		if (!fm)
+			continue;
+		n =3D layout(fm, pos, ARRAY_SIZE(pos));
+		if (n < 0)
+			continue;
+		for (k =3D 0; k < n; k++)
+			if (pos[k] >=3D nr_regs)
+				slots =3D max(slots, pos[k] - (int)nr_regs + 1);
+	}
+	return slots;
+}
+
 bool __weak bpf_jit_supports_stack_args(void)
 {
 	return false;
--=20
2.53.0-Meta

