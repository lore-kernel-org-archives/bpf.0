Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69528D8D0
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651381; cv=none; b=RnqyIqPY+Z8rmoQl0P+AbS87A8i+iDOBbCT1USX/knSbf/glcFC0cqjJKZOoOw1dDHXLTpB0/2C3UVoWRzHl14IVwjlNvL5lrrQnh0S4ufI5373lIMXg3XtqbsZJzgfi5tgoCULeFKVoSWE67tKFTzhr66Gcrj9i8sn7WybDVpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651381; c=relaxed/simple;
	bh=WBc7u2ChcMltHjTzmPjiWB5A2t4DJpx07JcVD3gf500=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7OHF14/3WqavBnivrfcaPdPykiAhE64SljdF5rpms1E+FTiZ1fU1Xt521rdocpV/drcs8IzHfBZahClUvUba9utbHN7Obiu1lpITqlMwtum2Vqf4DS3DIPBt65A3hQht/dIgQyvKLeti+diI7q6ufnkpjY46QYyz7k0GsU0FzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C242723E03556D; Thu, 13 Aug 2026 13:02:51 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 08/11] bpf: Reject register-pair returns when the subprog BTF is unreliable
Date: Thu, 13 Aug 2026 13:02:50 -0700
Message-ID: <20260813200250.1996395-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813200210.1991507-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

btf_check_subprog_call() can decide, at a call site, that this BTF is not
to be trusted and mark the subprogram unreliable, which happens when
compiler optimizations remove arguments from a static function or when a
mismatched type is passed to a global one. Verification carries on, but
the prototype the return convention was read from is one the verifier has
already declared not to describe the compiled code.

Rather than keep tracking R2 on the strength of a discarded signature,
reject a return value larger than 8 bytes as soon as the prototype it was
derived from becomes unreliable. Add subprog_ret_pair_unreliable() and
test it in check_func_call() on the path to a static subprogram, which is
where the flag can be observed while the call still proceeds. For a stati=
c
callee this only triggers on a genuine argument mismatch, since the
previous patch stopped btf_validate_return_type() from marking a local
function unreliable for returning an aggregate.

No check is needed anywhere else:
 - a global subprogram is already rejected by the existing "Caller passes
   invalid args into func#N" path, because btf_check_subprog_call()
   returns an error both when it marks the BTF unreliable and on every
   later call;
 - the main program does not use the convention at all: its return value
   is the program's exit code, read out of R0, so nothing looks at R2
   there;

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b23be0fa95af..0ffb3bed1649 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -441,6 +441,23 @@ static void bpf_compute_subprog_ret_regs(struct bpf_=
verifier_env *env)
 	}
 }
=20
+/*
+ * A >8 byte BPF return changes the calling convention to R0:R2, and the
+ * verifier derives that convention from the subprogram's BTF prototype
+ * alone. Once that prototype is marked unreliable it is known not to
+ * describe the compiled code, so the convention read from it cannot be
+ * trusted either: reject the call rather than keep tracking R2 on the
+ * strength of a signature the verifier has already discarded.
+ */
+static bool subprog_ret_pair_unreliable(struct bpf_verifier_env *env, in=
t subprog)
+{
+	struct bpf_prog_aux *aux =3D env->prog->aux;
+
+	return bpf_ret_reg_pair(env, subprog) &&
+	       aux->func_info_aux &&
+	       aux->func_info_aux[subprog].unreliable;
+}
+
 static const char *subprog_name(const struct bpf_verifier_env *env, int =
subprog)
 {
 	struct bpf_func_info *info;
@@ -9527,6 +9544,12 @@ static int check_func_call(struct bpf_verifier_env=
 *env, struct bpf_insn *insn,
 		return 0;
 	}
=20
+	if (subprog_ret_pair_unreliable(env, subprog)) {
+		verbose(env, "Func#%d ('%s') returns >8 bytes, which requires reliable=
 BTF\n",
+			subprog, subprog_name(env, subprog));
+		return -EINVAL;
+	}
+
 	/*
 	 * Track caller's total stack arg count (incoming + max outgoing).
 	 * This is needed so the JIT knows how much stack arg space to allocate=
.
--=20
2.53.0-Meta

