Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4B377EBF
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785210896; cv=none; b=mC95fWlqMISfqtWHYA3z/ilz4iLQZPYMPhs5+6CWN3xwTSl3SEFpQfRFicNewr1InI7i6RE5s9uH5h1Ikc/jJxFNC9tLcRSeyT12jIkmBNxJl35Vr4La1nIfsTsMMNdtvV+F6yjuz7yUdDBkcyyZSzMmxfdfMcrYyP1nE7EQF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785210896; c=relaxed/simple;
	bh=pH2LMDhGxq0wT49gW3PMZ4hkXxevWoRb/xLLV/HKhxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxTdSatxNVXUjaZOqAlyb7MLkJcwOM8oU9Hfq03Y9GzNwUwVO8ttl/yz5TvqrTNn3KcafX1JTiDPtOvFnYaUszbnWuFsTJeBj7SG+aS4ixqB2F+Wae2N0MGWCxfnbTJlfEURsRddlOyBjCXgUn4/znHgehoy04nEexwZL5Gnr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E6126206A0834E; Mon, 27 Jul 2026 20:54:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v4 2/3] bpf, x86: Fix trampoline stack size for 128-bit arguments
Date: Mon, 27 Jul 2026 20:54:47 -0700
Message-ID: <20260728035447.3008590-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728035437.3007984-1-yonghong.song@linux.dev>
References: <20260728035437.3007984-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

btf_distill_func_proto() accepts a function argument up to 16 bytes, so a
128-bit scalar such as __int128 reaches the x86 trampoline with
arg_size =3D=3D 16. But the current implementation assumes an __int128
argument only needs one register, so the register save area is
under-allocated and save_args() overwrites adjacent stack slots.

Compute the register count from arg_size for all arguments to fix it.

Fixes: a9c5ad31fbdc ("bpf: x86: Support in-register struct arguments in t=
rampoline programs")
Reviewed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b2feec81e231..01e7ce569c1e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3369,11 +3369,8 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im, void *rw_im
 	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
 		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
=20
-	/* extra registers for struct arguments */
-	for (i =3D 0; i < m->nr_args; i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			nr_regs +=3D (m->arg_size[i] + 7) / 8 - 1;
-	}
+	for (i =3D 0; i < m->nr_args; i++)
+		nr_regs +=3D (m->arg_size[i] + 7) / 8 - 1;
=20
 	/* x86-64 supports up to MAX_BPF_FUNC_ARGS arguments. 1-6
 	 * are passed through regs, the remains are through stack.
--=20
2.53.0-Meta

