Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA105344DB5
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189411; cv=none; b=sqete9uA6t4UjcXonsDN/SbFSEJlT6BSho4ASr+CFvv/ja5U3xQtcumiC77Z7TheaEVkfEPCUilInj0CDIf/N+FIC8Pj7ebFgm9aPG0p0wKy0YrlH4z6AgeY4K19001VETLAU4bgzjQ+Ds7izD34TyQSXYzpBR3ZN32IP078Hs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189411; c=relaxed/simple;
	bh=5Y1qqo8Z3RcJN/c781QmT4OAdzgI3T6MlHOj3aMIzKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkcN6Ke0YMFVqqkDafJCy7htLd5wEifmMTxFVDW9Y+PJ/DFZC3nZi4UbDZUeFAv2W1xXjNYE03pWdE5ZCYMBUE2NFmbhap/ERRMzTV90S1P7YvLBgLUofdctC1m1xrgsQb7pqo/UUWPmncpLC/jDft+L+8LNi/jltf2wKNkiaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 85E7692BAA2BB; Thu,  7 May 2026 14:30:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 04/23] bpf: Set sub->arg_cnt earlier in btf_prepare_func_args()
Date: Thu,  7 May 2026 14:30:03 -0700
Message-ID: <20260507213003.1125144-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507212942.1122000-1-yonghong.song@linux.dev>
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the "sub->arg_cnt =3D nargs" assignment to immediately after
nargs is computed from btf_type_vlen(), instead of at the end of
btf_prepare_func_args().

btf_prepare_func_args() can return -EINVAL early in several cases,
e.g. when a static function has some non-int/enum arguments.
Since -EINVAL from btf_prepare_func_args() does not immediately
reject verification, arg_cnt remains zero after the early return.
This causes later stack argument based load/store insns to
incorrectly assume the function has no arguments.

Setting arg_cnt right after nargs ensures it is available regardless
of which path btf_prepare_func_args() takes.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 77af44d8a3ad..a33a5b4122f8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7880,6 +7880,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	}
 	args =3D (const struct btf_param *)(t + 1);
 	nargs =3D btf_type_vlen(t);
+	sub->arg_cnt =3D nargs;
 	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
 		if (!is_global)
 			return -EINVAL;
@@ -8067,7 +8068,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 		return -EINVAL;
 	}
=20
-	sub->arg_cnt =3D nargs;
 	sub->args_cached =3D true;
=20
 	return 0;
--=20
2.53.0-Meta

