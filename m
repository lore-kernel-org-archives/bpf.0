Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A5364053
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 04:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775969920; cv=none; b=PpuLDL6k2v0ViZxu0jCMFRrvWrEAnDrzRu/QlYjBvoa4+dmz9yYx9Ptyg88dGc1EaDaxsXy9yyqFS6fchLvKHdyo37K4N+dFCrJDEa7h8WN6fBKkQAukvUupU81vqvVH5Q+N7iZAjM73wwX1cTrM/nSKswZH3rrXokIbY8ln8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775969920; c=relaxed/simple;
	bh=ZXjfUoxteI8Ta/c5MZ/5ypKl1VrVIUDOcYQ+dSZqpPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmbRQb/yVXuIaUeVlzr1wXmzDgG/SiL5np0AOdlj6nyePPn0Z2GU4576kaKqXIFFX8H4Ql3AA1TzYXmBq2RjwDurageP3OttqSBzXUVh4J5tkSOxgUlcQpCN/bkSWcnYxIJL/N5B+N6FNjc6OjKRX9dkjlrl+cUzWmrzXIX2IcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E3DF33B02197C; Sat, 11 Apr 2026 21:58:36 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 02/18] bpf: Change from "arg #%d" to "arg#%d" in verifier log
Date: Sat, 11 Apr 2026 21:58:36 -0700
Message-ID: <20260412045836.254807-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412045826.254200-1-yonghong.song@linux.dev>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In verifier, there are 31 verifier logs with "arg#%d" and 5 with "arg #%d=
".
Consolidate all of these to be "arg#%d" as in later patch, a helper funct=
ion
will emit "arg#%d" as the defined format. Some related selftests are
adjusted as well.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c                         | 10 +++++-----
 .../testing/selftests/bpf/progs/dynptr_fail.c | 20 +++++++++----------
 .../selftests/bpf/progs/file_reader_fail.c    |  4 ++--
 .../selftests/bpf/progs/iters_state_safety.c  | 14 ++++++-------
 .../selftests/bpf/progs/iters_testmod_seq.c   |  4 ++--
 .../selftests/bpf/progs/verifier_bits_iter.c  |  4 ++--
 6 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3ba837e4b591..6469e71cd1fa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9074,7 +9074,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, int regno, int insn
=20
 		if (!is_dynptr_reg_valid_init(env, reg)) {
 			verbose(env,
-				"Expected an initialized dynptr as arg #%d\n",
+				"Expected an initialized dynptr as arg#%d\n",
 				regno - 1);
 			return -EINVAL;
 		}
@@ -9082,7 +9082,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, int regno, int insn
 		/* Fold modifiers (in this case, MEM_RDONLY) when checking expected ty=
pe */
 		if (!is_dynptr_type_expected(env, reg, arg_type & ~MEM_RDONLY)) {
 			verbose(env,
-				"Expected a dynptr of type %s as arg #%d\n",
+				"Expected a dynptr of type %s as arg#%d\n",
 				dynptr_type_str(arg_to_dynptr_type(arg_type)), regno - 1);
 			return -EINVAL;
 		}
@@ -9152,7 +9152,7 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, int regno, int insn_id
 	 */
 	btf_id =3D btf_check_iter_arg(meta->btf, meta->func_proto, regno - 1);
 	if (btf_id < 0) {
-		verbose(env, "expected valid iter pointer as arg #%d\n", regno - 1);
+		verbose(env, "expected valid iter pointer as arg#%d\n", regno - 1);
 		return -EINVAL;
 	}
 	t =3D btf_type_by_id(meta->btf, btf_id);
@@ -9161,7 +9161,7 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, int regno, int insn_id
 	if (is_iter_new_kfunc(meta)) {
 		/* bpf_iter_<type>_new() expects pointer to uninit iter state */
 		if (!is_iter_reg_valid_uninit(env, reg, nr_slots)) {
-			verbose(env, "expected uninitialized iter_%s as arg #%d\n",
+			verbose(env, "expected uninitialized iter_%s as arg#%d\n",
 				iter_type_str(meta->btf, btf_id), regno - 1);
 			return -EINVAL;
 		}
@@ -9185,7 +9185,7 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, int regno, int insn_id
 		case 0:
 			break;
 		case -EINVAL:
-			verbose(env, "expected an initialized iter_%s as arg #%d\n",
+			verbose(env, "expected an initialized iter_%s as arg#%d\n",
 				iter_type_str(meta->btf, btf_id), regno - 1);
 			return err;
 		case -EPROTO:
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
index b62773ce5219..d552117b001e 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -149,7 +149,7 @@ int ringbuf_release_uninit_dynptr(void *ctx)
=20
 /* A dynptr can't be used after it has been invalidated */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #2")
+__failure __msg("Expected an initialized dynptr as arg#2")
 int use_after_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -448,7 +448,7 @@ int invalid_helper2(void *ctx)
=20
 /* A bpf_dynptr is invalidated if it's been written into */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as arg#0")
 int invalid_write1(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -1642,7 +1642,7 @@ int invalid_slice_rdwr_rdonly(struct __sk_buff *skb=
)
=20
 /* bpf_dynptr_adjust can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as arg#0")
 int dynptr_adjust_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr =3D {};
@@ -1655,7 +1655,7 @@ int dynptr_adjust_invalid(void *ctx)
=20
 /* bpf_dynptr_is_null can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as arg#0")
 int dynptr_is_null_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr =3D {};
@@ -1668,7 +1668,7 @@ int dynptr_is_null_invalid(void *ctx)
=20
 /* bpf_dynptr_is_rdonly can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as arg#0")
 int dynptr_is_rdonly_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr =3D {};
@@ -1681,7 +1681,7 @@ int dynptr_is_rdonly_invalid(void *ctx)
=20
 /* bpf_dynptr_size can only be called on initialized dynptrs */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as arg#0")
 int dynptr_size_invalid(void *ctx)
 {
 	struct bpf_dynptr ptr =3D {};
@@ -1694,7 +1694,7 @@ int dynptr_size_invalid(void *ctx)
=20
 /* Only initialized dynptrs can be cloned */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #0")
+__failure __msg("Expected an initialized dynptr as arg#0")
 int clone_invalid1(void *ctx)
 {
 	struct bpf_dynptr ptr1 =3D {};
@@ -1728,7 +1728,7 @@ int clone_invalid2(struct xdp_md *xdp)
=20
 /* Invalidating a dynptr should invalidate its clones */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #2")
+__failure __msg("Expected an initialized dynptr as arg#2")
 int clone_invalidate1(void *ctx)
 {
 	struct bpf_dynptr clone;
@@ -1749,7 +1749,7 @@ int clone_invalidate1(void *ctx)
=20
 /* Invalidating a dynptr should invalidate its parent */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #2")
+__failure __msg("Expected an initialized dynptr as arg#2")
 int clone_invalidate2(void *ctx)
 {
 	struct bpf_dynptr ptr;
@@ -1770,7 +1770,7 @@ int clone_invalidate2(void *ctx)
=20
 /* Invalidating a dynptr should invalidate its siblings */
 SEC("?raw_tp")
-__failure __msg("Expected an initialized dynptr as arg #2")
+__failure __msg("Expected an initialized dynptr as arg#2")
 int clone_invalidate3(void *ctx)
 {
 	struct bpf_dynptr ptr;
diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools=
/testing/selftests/bpf/progs/file_reader_fail.c
index 32fe28ed2439..429831ca9154 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -30,7 +30,7 @@ int on_nanosleep_unreleased_ref(void *ctx)
=20
 SEC("xdp")
 __failure
-__msg("Expected a dynptr of type file as arg #0")
+__msg("Expected a dynptr of type file as arg#0")
 int xdp_wrong_dynptr_type(struct xdp_md *xdp)
 {
 	struct bpf_dynptr dynptr;
@@ -42,7 +42,7 @@ int xdp_wrong_dynptr_type(struct xdp_md *xdp)
=20
 SEC("xdp")
 __failure
-__msg("Expected an initialized dynptr as arg #0")
+__msg("Expected an initialized dynptr as arg#0")
 int xdp_no_dynptr_type(struct xdp_md *xdp)
 {
 	struct bpf_dynptr dynptr;
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/too=
ls/testing/selftests/bpf/progs/iters_state_safety.c
index d273b46dfc7c..88cdd8d46373 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -73,7 +73,7 @@ int create_and_forget_to_destroy_fail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as arg#0")
 int destroy_without_creating_fail(void *ctx)
 {
 	/* init with zeros to stop verifier complaining about uninit stack */
@@ -91,7 +91,7 @@ int destroy_without_creating_fail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as arg#0")
 int compromise_iter_w_direct_write_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -143,7 +143,7 @@ int compromise_iter_w_direct_write_and_skip_destroy_f=
ail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as arg#0")
 int compromise_iter_w_helper_write_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -230,7 +230,7 @@ int valid_stack_reuse(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected uninitialized iter_num as arg #0")
+__failure __msg("expected uninitialized iter_num as arg#0")
 int double_create_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -258,7 +258,7 @@ int double_create_fail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as arg#0")
 int double_destroy_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -284,7 +284,7 @@ int double_destroy_fail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as arg#0")
 int next_without_new_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -305,7 +305,7 @@ int next_without_new_fail(void *ctx)
 }
=20
 SEC("?raw_tp")
-__failure __msg("expected an initialized iter_num as arg #0")
+__failure __msg("expected an initialized iter_num as arg#0")
 int next_after_destroy_fail(void *ctx)
 {
 	struct bpf_iter_num iter;
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c b/tool=
s/testing/selftests/bpf/progs/iters_testmod_seq.c
index 83791348bed5..fd160c14289f 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
@@ -79,7 +79,7 @@ int testmod_seq_truncated(const void *ctx)
=20
 SEC("?raw_tp")
 __failure
-__msg("expected an initialized iter_testmod_seq as arg #1")
+__msg("expected an initialized iter_testmod_seq as arg#1")
 int testmod_seq_getter_before_bad(const void *ctx)
 {
 	struct bpf_iter_testmod_seq it;
@@ -89,7 +89,7 @@ int testmod_seq_getter_before_bad(const void *ctx)
=20
 SEC("?raw_tp")
 __failure
-__msg("expected an initialized iter_testmod_seq as arg #1")
+__msg("expected an initialized iter_testmod_seq as arg#1")
 int testmod_seq_getter_after_bad(const void *ctx)
 {
 	struct bpf_iter_testmod_seq it;
diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/too=
ls/testing/selftests/bpf/progs/verifier_bits_iter.c
index 8bcddadfc4da..86f1e5a8e87f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -32,7 +32,7 @@ int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, st=
ruct cgroup *cgrp)
=20
 SEC("iter/cgroup")
 __description("uninitialized iter in ->next()")
-__failure __msg("expected an initialized iter_bits as arg #0")
+__failure __msg("expected an initialized iter_bits as arg#0")
 int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgr=
p)
 {
 	struct bpf_iter_bits it =3D {};
@@ -43,7 +43,7 @@ int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, s=
truct cgroup *cgrp)
=20
 SEC("iter/cgroup")
 __description("uninitialized iter in ->destroy()")
-__failure __msg("expected an initialized iter_bits as arg #0")
+__failure __msg("expected an initialized iter_bits as arg#0")
 int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *=
cgrp)
 {
 	struct bpf_iter_bits it =3D {};
--=20
2.52.0

