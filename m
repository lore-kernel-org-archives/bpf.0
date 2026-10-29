Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309167;
	b=JClkzneypqMwUiBwljj3E5jToZj4e17apBWe9JxUKCfZ56GcrJj2yYg+6ttKIkiV+07C
	 3Hf5QkgaCO6PiaTpMQCFTiWng+KjXXJ/xhxik1p8BtyF4pLGm1aGkmwVJmfxwgoK4gppP
	 rBYKMaNKsH7o6joM7pL4HbfNx66Yr+jB1Myh9FVM8B9cgNWyBP961kKQR5/giWcLmk5x4
	 5gJHugmgW+U7EPhyr5DB6yDcp35Qhv13p7xqVnI6ITP2YIMoWieYkdUSyCjMHX9lMF+tc
	 Rd6PvqTNH/eLNvfZ5+9Pxg+h0kc1KH5fC2tUz106bFvkyDWjJCTYE6dRqI3suftZbcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309167;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3e/pfijPIkLS7++cA0qYFZVdeq4Z+b+3Z+Oggjyljro=;
	b=2KZNwEhTy17etRsh8YfLJDSpFJ5MJ0ZQUeJFXnCus/0DLlYfoym91QtTcw2p09wmVOq7
	 AGCmb047NR+FzkKBiQsM/YGIMVGpxDRnilzhtSINn4fcpPOk8gk4QANlll5lMZKwv8i1F
	 78Pz6Lw/c48Kies7QuLdXtJwRfI7xcTzut4Q20c+ODgkJ1kInz+90P3tWZ6YkKurcJd78
	 ATrcttV8XGlDvdQGBl1NdZlYMRhbdip7jujEjPmxvSJ2h+GEQ4JUPtj3csZR3ibqJdQv8
	 fs/2Tw5CD3veS0yQyt8zj6PHLqUOZHt68jFDeUpWmlMVMcLIFL9DCoti28O5XD0JJ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+sp9O2s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84107606A327
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+sp9O2s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DD11F01816;
	Thu, 29 Oct 2026 21:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309167;
	bh=3e/pfijPIkLS7++cA0qYFZVdeq4Z+b+3Z+Oggjyljro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T+sp9O2syol1EN37beaOYRd6oYbTex4D12UqTPm+tPg0ODD6yLECxF95ptYYNgpEs
	 60cyBwqGY3YPxvdb45v5oSSeOag+wr/JhdaJdhaBmL/GttfWQsh85iIFnnkIVWkvJ+
	 Jd14SJM3JE3iSj58XM5h8CLbnSMOOa0m5uWEAA4xKkjwdbbIKORyJsXR0KXzFPvOy0
	 w7lkCqiLzojFtaHXyTHOQqXyKuNMgTqQmpEQNdYM1BBKsOkvD42IPlvaV9itO2aPIT
	 QwY+CXYDcwgGY4gKXrkzdeS1xC5x2fVTjypcB0kalmNEaHl5For6rQMN91cxzhjUcS
	 QYnP6Hdqo4c1Q==
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
Subject: [PATCH bpf-next 1/8] bpf: Add __srcptr kfunc argument suffix
Date: Thu, 29 Oct 2026 22:25:44 +0100
Message-ID: <20261029212551.56964-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029212551.56964-1-jolsa@kernel.org>
References: <20261029212551.56964-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Generic sized pointer arguments are treated as writable memory. This
prevents kfuncs that only read from a source buffer from accepting
read-only BPF memory, such as const data.

Adding __srcptr to mark pointers the kfunc only reads.

The get_kfunc_arg_type change sets the initial memory access mode
and the resolve_func_arg_type preserves the suffix’s access mode
when it converts a BTF pointer classification into a memory argument.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 24 ++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 20 +++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 73578a4c3b1f..d22b6bb3df2e 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -351,6 +351,30 @@ In this case, a program attached to the ``inode_init_security`` LSM hook
 can pass the hook's own ``xattr_count`` argument through to the kfunc,
 which claims xattr slots by writing through it.
 
+2.3.10 __srcptr Annotation
+--------------------------
+
+This annotation marks a pointer argument as a source buffer that the kfunc
+reads without writing. The verifier requires read access, so the source may
+point to read-only or read/write memory. Pair variable-size buffers with a
+following ``__sz`` or ``__szk`` argument. For a pointer to a scalar or to a
+struct of scalars, the verifier uses the pointee's BTF size; a ``void *``
+requires an explicit size.
+
+For example, the first kfunc takes a variable-size buffer, while the second
+takes a scalar source::
+
+        __bpf_kfunc void bpf_consume_data(const void *src__srcptr,
+                                          u32 src__sz)
+        {
+        ...
+        }
+
+        __bpf_kfunc void bpf_consume_scalar(const u32 *src__srcptr)
+        {
+        ...
+        }
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5601d2056218..75365aeadc09 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13205,6 +13205,20 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
 	return btf_param_match_suffix(btf, arg, "__sz");
 }
 
+static bool is_kfunc_arg_srcptr(const struct btf *btf,
+				const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__srcptr");
+}
+
+static int mem_prot(const struct btf *btf, const struct btf_param *arg)
+{
+	if (is_kfunc_arg_srcptr(btf, arg))
+		return MEM_RDONLY;
+	else
+		return MEM_WRITE;
+}
+
 static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 					const struct btf_param *arg)
 {
@@ -13585,7 +13599,7 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 			PTR_ERR(resolve_ret));
 		return -EINVAL;
 	}
-	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | mem_prot(meta->btf, &args[arg]) |
 		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
 
 	return 0;
@@ -14137,7 +14151,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
-		arg_type = ARG_PTR_TO_MEM | MEM_WRITE;
+		arg_type = ARG_PTR_TO_MEM | mem_prot(meta->btf, &args[arg]);
 	} else if (btf_type_is_struct(ref_t))
 		/* A pointer to a struct without a size argument is classified as ARG_PTR_TO_BTF_ID */
 		arg_type = ARG_PTR_TO_BTF_ID;
@@ -14162,7 +14176,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			return -EINVAL;
 		}
 		proto->arg_size[arg] = type_size;
-		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
+		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | mem_prot(meta->btf, &args[arg]);
 	}
 
 	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
-- 
2.54.0

