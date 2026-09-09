Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6738B7DC
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935153; cv=none; b=JnNLla++XVASvjr0/tGTyEAnGS6cQDxjwaJmGZwgv3enbZP610l9OqTG18OBlo1zV78RGgGCmfzwjGjpDmJIggtPq7mr2q933K1Ox6GqO+HurW7OKWTB12lAyFmYxR9OcJ5IOurw9DQT/+Wf1rm+JGQtheeEoaHnsYesm2bdJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935153; c=relaxed/simple;
	bh=QNHYt/BaaQeZeeg+r9rDJjUqD6CK9a4uHGNPfqHsWaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIISUfV3IZDNNba27QfQ2Vv0ulFnPATgI7s+UAJ8jBd9VFn7oAwqqbrGhNfrZLLhwah9wlWOPtgu45a/wWNh7SO7nsiLxP9pcClPLrXtU8r/T4MzvVIZZTa3MCmEeycOu7KDHLSNAyoccfuGWTFxoMUxCIzG5yS3J0ZgyoRZZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CE20D2994759D0; Tue,  8 Sep 2026 23:25:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 04/12] bpf: Support __int128 as a by-value function argument
Date: Tue,  8 Sep 2026 23:25:43 -0700
Message-ID: <20260909062543.4004523-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909062522.4001896-1-yonghong.song@linux.dev>
References: <20260909062522.4001896-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A 128-bit integer follows the same calling convention as a 16-byte
by-value struct: LLVM emits it as a 16-byte BTF_KIND_INT and passes it in
two consecutive argument registers. So a __int128 gets its two slots.

The test added at the start of the series, which recorded the wrong
register map as an R4 !read_ok rejection, now passes and is flipped to
__success.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c                                        | 9 +++------
 tools/testing/selftests/bpf/progs/verifier_int128_arg.c | 7 +------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4502b888b668..baa370f3f331 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8252,11 +8252,7 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 			bpf_log(log, "arg#%d has pointer tag, but is not a pointer type\n", i=
);
 			return -EINVAL;
 		}
-		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
-			sub->args[slots_used++].arg_type =3D ARG_ANYTHING;
-			continue;
-		}
-		if (btf_type_is_struct(t)) {
+		if (btf_type_is_int(t) || btf_is_any_enum(t) || btf_type_is_struct(t))=
 {
 			u32 nslots;
=20
 			if (!t->size || t->size > 2 * BPF_REG_SIZE) {
@@ -8268,7 +8264,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 					i, btf_type_str(t), tname, t->size, 2 * BPF_REG_SIZE);
 				return -EINVAL;
 			}
-			if (!btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
+			if (btf_type_is_struct(t) &&
+			    !btf_struct_is_composed_of(env, btf, t, BTF_MEMBER_SCALAR)) {
 				if (!is_global)
 					return -EINVAL;
 				bpf_log(log, "Arg#%d type %s in %s() is not composed of scalars\n",
diff --git a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c b/to=
ols/testing/selftests/bpf/progs/verifier_int128_arg.c
index 419851f2d8d0..044fc4a80055 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int128_arg.c
@@ -15,12 +15,7 @@ __noinline __u64 take_i128_global(int a, u128 v, int c=
)
 }
=20
 SEC("tc")
-/*
- * The verifier counts one argument register for the __int128 and marks =
only
- * R1 through R3 at the entry of take_i128_global(), while the compiler =
passed
- * a in R1, v in R2:R3 and c in R4.
- */
-__failure __msg("R4 !read_ok")
+__success __retval(0)
 int aggregate_arg_int128_c_test(struct __sk_buff *skb)
 {
 	__u64 a =3D skb->len ^ MIX_A;
--=20
2.53.0-Meta

