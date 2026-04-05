Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B430EF7C
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775408073; cv=none; b=uWrdJS5PZkxIm01MS2U2kmzNC1BzdCoFqIdcnJtrVk4NhjpUKG5/4SzFYwD5gXlJOKIyeQVD5t7rWwxzb88iaq5zwCTMg/W4VYi5HuYGPIfgZl0F61szjpPKNamLtR0KGepHG3elMMFb9w1Y0vCIPpdjB0cT2L0vlwwULx6sSlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775408073; c=relaxed/simple;
	bh=SZpYN9VfwFcU/B3Us23crAQvPnqb5pbZI+aDvscknZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=No47vXxMBo55cJ3CAkYhu4puMLjC7Zb0RLrEeM27kLFV6PFvBQeYmw8ondbIBsiuTVP8bTIbcMsNSBKckQZbXgC/8GyPyH7qrF60YqsUpWHxmHkeim45ToISnOQUzqKjeTvgoZiPm7h0qHf/k1uQQozpu/Pdz2C0StfPVslrMQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 32CF0361CF254; Sun,  5 Apr 2026 09:54:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 04/11] bpf: Refactor process_iter_arg() to have proper argument index
Date: Sun,  5 Apr 2026 09:54:18 -0700
Message-ID: <20260405165418.834714-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405165300.826241-1-yonghong.song@linux.dev>
References: <20260405165300.826241-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the next patch for kfunc stack arguments, a faked register is
used to do proper verification checking. For process_iter_arg(),
the regno is passed in and the iterator assumes 'regno - 1' as
the argument index. This is wrong as regno is fake. So refactor
process_iter_arg() by adding actual argument index which is used
inside the function.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ebf164036849..fd13309d9006 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9259,14 +9259,14 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_ca=
ll_arg_meta *meta, int arg_idx,
 }
=20
 static int process_iter_arg(struct bpf_verifier_env *env, int regno, int=
 insn_idx,
-			    struct bpf_kfunc_call_arg_meta *meta)
+			    int argno, struct bpf_kfunc_call_arg_meta *meta)
 {
 	struct bpf_reg_state *reg =3D reg_state(env, regno);
 	const struct btf_type *t;
 	int spi, err, i, nr_slots, btf_id;
=20
 	if (reg->type !=3D PTR_TO_STACK) {
-		verbose(env, "arg#%d expected pointer to an iterator on stack\n", regn=
o - 1);
+		verbose(env, "arg#%d expected pointer to an iterator on stack\n", argn=
o);
 		return -EINVAL;
 	}
=20
@@ -9276,9 +9276,9 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, int regno, int insn_id
 	 * to any kfunc, if arg has "__iter" suffix, we need to be a bit more
 	 * conservative here.
 	 */
-	btf_id =3D btf_check_iter_arg(meta->btf, meta->func_proto, regno - 1);
+	btf_id =3D btf_check_iter_arg(meta->btf, meta->func_proto, argno);
 	if (btf_id < 0) {
-		verbose(env, "expected valid iter pointer as arg #%d\n", regno - 1);
+		verbose(env, "expected valid iter pointer as arg #%d\n", argno);
 		return -EINVAL;
 	}
 	t =3D btf_type_by_id(meta->btf, btf_id);
@@ -9288,7 +9288,7 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, int regno, int insn_id
 		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
 			verbose(env, "expected uninitialized iter_%s as arg #%d\n",
-				iter_type_str(meta->btf, btf_id), regno - 1);
+				iter_type_str(meta->btf, btf_id), argno);
 			return -EINVAL;
 		}
=20
@@ -9312,7 +9312,7 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, int regno, int insn_id
 			break;
 		case -EINVAL:
 			verbose(env, "expected an initialized iter_%s as arg #%d\n",
-				iter_type_str(meta->btf, btf_id), regno - 1);
+				iter_type_str(meta->btf, btf_id), argno);
 			return err;
 		case -EPROTO:
 			verbose(env, "expected an RCU CS when using %s\n", meta->func_name);
@@ -14063,7 +14063,7 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			}
-			ret =3D process_iter_arg(env, regno, insn_idx, meta);
+			ret =3D process_iter_arg(env, regno, insn_idx, i, meta);
 			if (ret < 0)
 				return ret;
 			break;
--=20
2.52.0

