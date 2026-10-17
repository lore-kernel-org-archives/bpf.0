Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917438F233
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205534; cv=none; b=T1Sh6Pxj9g9wWQPJtjX+sZN5lSQX+Qe+9xXw/thbrtguflhmifr6f0OKVoHVNxfMSJhNss0OSpjWbOV2wGkdiIzvIpRU+aXrzLt3/YNozMJzelgOScUhCe6Z2UzZ3mkZnwSQc6yOVuAhWjgfQPb1zLMLZzaxVTC/bvGb6FVqXMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205534; c=relaxed/simple;
	bh=xZtgVABkzMhhMhCvCRYAgqbiF6d9WEk2necr5WloWYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AENyJlSxQATp5kNF5LQlcnuKwetN30ez0fNh5kU+R6QwFxotfyjIppIgpYy1rRxlXgZrGfvrMfh/vCUJ0UdOUxlYeH3HzpPNSZWFoEBwRFyVVxCboqUQqVA6QEdULf2vLGXGyW8SvI5AeTKO1mcm/254I906vWsVqs14zrmeO9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EC27031B3AFE5F; Fri, 16 Oct 2026 19:52:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 07/25] bpf: Refuse a callback that can unwind
Date: Fri, 16 Oct 2026 19:52:06 -0700
Message-ID: <20261017025206.1920523-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A callback is not called by the program but by kernel code, a helper or
a kfunc such as bpf_loop(), which the callback returns to and which then
returns to the program:

  main -> A -> bpf_loop() -> cb -> C          C calls bpf_unwind()

Once a later patch makes bpf_unwind() dispatch pads, it rewrites the
return address of each of the program's frames and stops at the first
frame that is not one, here bpf_loop(): kernel code with its own frame
and state, which the walk cannot send cb past. So cb returns into
bpf_loop(), which goes on looping and then returns to A after its call,
while the verifier follows the unwind from cb straight into A.

Refuse a callback subprog marked might_unwind. The check does not depend
on a cleanup table: without one, bpf_unwind() still sends every frame it
walks through its epilogue and still stops at bpf_loop(), so the
mismatch is the same.

The check does not tell the kinds of callback apart, so an async one, a
timer callback for example, is refused as well, although nothing of the
program sits above it for the walk to skip. And as
mark_callx_might_unwind() marks a subprog with a callx conservatively, a
callback with a callx is refused even when nothing it calls unwinds.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/exception.c | 9 +++++++++
 kernel/bpf/exception.h | 1 +
 kernel/bpf/verifier.c  | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index 80d1edc19441..316ae9e4d7c7 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -141,6 +141,15 @@ int bpf_exc_check_info(struct bpf_verifier_env *env,=
 const union bpf_attr *attr,
 BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
 BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
=20
+int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog)
+{
+	if (!env->subprog_info[subprog].might_unwind)
+		return 0;
+
+	verbose(env, "subprog %d may unwind and is used as a callback\n", subpr=
og);
+	return -EINVAL;
+}
+
 static int reject_throw(struct bpf_verifier_env *env)
 {
 	u32 i;
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index 30918714a6e8..49d4685c297a 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -17,5 +17,6 @@ int bpf_exc_check_prog(struct bpf_verifier_env *env);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
+int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog);
=20
 #endif /* __BPF_EXCEPTION_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fce2baa6272d..fcf0d0fe0f2f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11191,6 +11191,10 @@ static int push_callback_call(struct bpf_verifie=
r_env *env, struct bpf_insn *ins
 	 * callbacks
 	 */
 	env->subprog_info[subprog].is_cb =3D true;
+	err =3D bpf_exc_check_callback(env, subprog);
+	if (err)
+		return err;
+
 	if (bpf_pseudo_kfunc_call(insn) &&
 	    !is_callback_calling_kfunc(insn->imm)) {
 		verifier_bug(env, "kfunc %s#%d not marked as callback-calling",
--=20
2.53.0-Meta

