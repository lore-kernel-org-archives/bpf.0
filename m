Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874239;
	b=q8o+zuTDMBzui1o1QLAsO2T2Leib2+bbgvrwVFhmYzJ04Z3xJ0Zdge0fIS+EplLO5wQX
	 6Tvb807xSQ0rSdkyuaP/7/D95EBNB/rFspRLScWWg1KZO7mMWERAtYhHutilyReDmG+h9
	 R0NCwV5zfzCj4QL3W01NA0PtWpXnaH7b+uterHwLIqgvh9hP829tc95fZhayh3jJwfl4U
	 Ccrd0kPogsi42pPry2Hnkzbms/2bqFIk56M9DqLKy7VlUcJzd4eQuZT6AkdGku+gcM1AQ
	 8NMvBbKAXnAFSBWUxps0bR22V3k0+zGyJDc73pNV9N6HU5oR3TTzDEGspFOMeUMyhUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874239;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PYhUmCcAZz8D4rH/ZuLGB4Wi87kHi8TGQCw2xjNzenQ=;
	b=28LGopkbqujdsA19atjCutPoTuBGJdlNtaWf9OGWHu58/Fv+f/El+Xs1Y3GW3ryUPm8b
	 4aVqYefTLDOF1qWK0Tw+UMiIgC6Aq7IlQP9dGsN0MKpxWMyBvHyDej9TZ6hhmUxC/t2TB
	 X6XxONRjCdCnCfoxoJNfVH9Vperx4+47thy70XDcZc1s4om7BHNVcSnN/9OY3Uuc3BGpA
	 yCRJg0iMO57Qo+iit5HxBbc/Z515Qu+4ba0ssqh44bT7ESxztynpWyHgqCXBhRpHxYsKP
	 L8h+q/4FwQAs0dDB5vmBfdRoT6nsujDsEHrqr2eohDue1NOqNS7awVlDlTGGXiu0VRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OR2s2vHe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0343A606A334
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OR2s2vHe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40431F00919;
	Thu,  5 Nov 2026 10:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874238;
	bh=PYhUmCcAZz8D4rH/ZuLGB4Wi87kHi8TGQCw2xjNzenQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OR2s2vHeD3dD8muCdAuzzN7A+BZOD8oCRQ+Qv9FC0ClcDR8K0DALQpwUkSiKm+SDC
	 30ZDS+iViSRJVTpBz3ZJB9OZjQGdmVqvZxwhgbf4JBSn93sQLHGGL4o6qw7r8a1hSb
	 rG7a/Dn8Xpip6zD/MlCZ/Z6HKorb6yXrbb/D0wInMTrfSQfSqYlscXCf46sM5cETfV
	 TUP/H7WyFPSBNRmka9rG1B6JQshp1eyjQJS94MY8zSMEkhekX9uOuroj2cIWmXAcr7
	 g7huGG7qZ8h/gWDfKgotAsG2MX4r9/D+fMfl2IQWE31Zxc1P8Vz62lZw27p5Gbk+mX
	 1cXJ1NIMkfQmA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: [PATCHv3 bpf-next 1/8] bpf: Honor const on generic kfunc memory arguments
Date: Thu,  5 Nov 2026 11:23:35 +0100
Message-ID: <20261105102343.311331-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105102343.311331-1-jolsa@kernel.org>
References: <20261105102343.311331-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark generic kfunc memory arguments as read-only when their BTF pointer
type points to const data. Preserve that access mode when resolving
scalar structs to fixed-size memory.

Derive the memory access flag from the pointer's BTF type, and preserve it
when resolving scalar structs to fixed-size memory. Document that const
memory arguments require read access only.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Documentation/bpf/kfuncs.rst |  4 ++++
 kernel/bpf/verifier.c        | 24 +++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 901c37504217..4f8dd7c1d785 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -137,6 +137,10 @@ argument as its size. By default, without __sz annotation, the size of the type
 of the pointer is used. Without __sz annotation, a kfunc cannot accept a void
 pointer.
 
+The verifier checks such memory for read and write access. When the argument
+is a pointer to const, like ``const void *mem``, the verifier checks it for
+read access only, and read-only memory (e.g. ``.rodata``) can be passed.
+
 2.3.2 __k Annotation
 --------------------
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c93437f8db0..8f885d3acaa9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13237,6 +13237,22 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 	return btf_param_match_suffix(btf, arg, "__szk");
 }
 
+/* A kfunc only reads through 'const T *arg'. The compiler enforces it. */
+static enum bpf_type_flag kfunc_arg_mem_flag(const struct btf *btf,
+					     const struct btf_param *arg)
+{
+	const struct btf_type *t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	u32 id, ref_id;
+
+	btf_type_skip_modifiers(btf, t->type, &ref_id);
+	for (id = t->type; id != ref_id; id = t->type) {
+		t = btf_type_by_id(btf, id);
+		if (btf_kind(t) == BTF_KIND_CONST)
+			return MEM_RDONLY;
+	}
+	return MEM_WRITE;
+}
+
 static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__k");
@@ -13618,7 +13634,8 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 			PTR_ERR(resolve_ret));
 		return -EINVAL;
 	}
-	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
+		    kfunc_arg_mem_flag(meta->btf, &args[arg]) |
 		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
 
 	return 0;
@@ -14170,7 +14187,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
-		arg_type = ARG_PTR_TO_MEM | MEM_WRITE;
+		arg_type = ARG_PTR_TO_MEM | kfunc_arg_mem_flag(meta->btf, &args[arg]);
 	} else if (btf_type_is_struct(ref_t))
 		/* A pointer to a struct without a size argument is classified as ARG_PTR_TO_BTF_ID */
 		arg_type = ARG_PTR_TO_BTF_ID;
@@ -14195,7 +14212,8 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			return -EINVAL;
 		}
 		proto->arg_size[arg] = type_size;
-		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
+		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE |
+			   kfunc_arg_mem_flag(meta->btf, &args[arg]);
 	}
 
 	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
-- 
2.43.0

