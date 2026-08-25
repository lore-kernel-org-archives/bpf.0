Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D83C2BA2
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691271; cv=none; b=hUhgqazayVjRq3hQHCwaHbAYU80m7Pg3omu1FNE+gkBekz3UnAPmYf4hRE/QGsi6uLZiVxlv0fNxVylMdm9zx5w8LshMtVHWkkwNTXM2/4+oibELmCKqZKuXbqrZaXHN4DrXozHc6MaqhtxpszF09cjmSnIzoSkS5TCAMgSXstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691271; c=relaxed/simple;
	bh=N1Mwx3/QBrTQNVwR82L3shoLLngmecDAtQKRBKacoJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHAGNnMNppWY2ANMftfqc0lKrgCHu25627yr7VwDeaEvuW9Mn6R0T+hMySidluv1KSGrbhPrxHfzla6MX90vW/p7O7KB+CHbZKU8dz7v5aDp1NVAGbzJjEJXzA9434PjFicE493suAcryw+xVN/pBTC8FZsxNchjlrArZWbZMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8AF6B268293CCB; Tue, 25 Aug 2026 13:54:17 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 01/10] bpf: Record each half of a paired return value in verifier diagnostics
Date: Tue, 25 Aug 2026 13:54:17 -0700
Message-ID: <20260825205417.1320403-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825205412.1320099-1-yonghong.song@linux.dev>
References: <20260825205412.1320099-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A subprogram returning more than 8 bytes comes back in the R0:R2 register
pair, and prepare_func_exit() copies both registers into the caller. The
diagnostic modification scope around that copy names only R0, so the writ=
e
into R2 is never recorded.

Fix it by opening a diagnostic modification scope for each return registe=
r.
This way, both return registers are recorded.

Fixes: 0630ad00d96d ("bpf: Add verifier support for 16-byte returns in R0=
: R2")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e036ae20bf6b..9aa29c367008 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10403,10 +10403,14 @@ static int prepare_func_exit(struct bpf_verifie=
r_env *env, int *insn_idx)
 		 * return to the caller whatever the callee had in the
 		 * return register(s)
 		 */
-		bpf_diag_mod_begin(env, &caller->regs[BPF_REG_0], r0, BPF_DIAG_MOD_WRI=
TE);
-		for (i =3D 0; i < nregs; i++)
-			caller->regs[ret_regs[i]] =3D callee->regs[ret_regs[i]];
-		bpf_diag_mod_end(env);
+		for (i =3D 0; i < nregs; i++) {
+			u32 regno =3D ret_regs[i];
+
+			bpf_diag_mod_begin(env, &caller->regs[regno], &callee->regs[regno],
+					   BPF_DIAG_MOD_WRITE);
+			caller->regs[regno] =3D callee->regs[regno];
+			bpf_diag_mod_end(env);
+		}
 	}
=20
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to call=
site,
--=20
2.53.0-Meta

