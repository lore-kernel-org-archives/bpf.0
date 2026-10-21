Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612702;
	b=Lg2jTywMP1vm+M+EaDL4f7B5pOnNKtL7cHPDLAhj47ysNyTsY1DbRoQTSKPaBC+m2xKC
	 Bt6hsrO/WxAIaP+pRyT28S2zOZ1Rp5wLe5PROkgz8yPIvVnZGgqXHIbW6wXc9TwZXVI0K
	 YRY59L+l6u1S9HjBljoGysrjj+EgwJ20By/smJf0UmUO5K5mzzpplyORe52atZUfqHSTW
	 pwCxYAgf9dB/xPIpA7iiuLyaQobHJI4tmptH5DIi17QBoXksaozOLpqJKkU4kUDX9EE5Y
	 IwR74Ne8KQQVg18EjzcI7QQ8TJjYYCjh8dAMXLPNx5IrIplRINUDoINpdqmY5i4AXIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612702;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pF5l050qT/qvl0GvCxGIiAGvWNtowoG+RzEclp/R9Dk=;
	b=he/Kv0MAcnUAIjKywNbR2cftZW56D0Ifa+pjPYsWnlbRWeUVWjR7bGtLeffMMh44/ze5
	 aveqTPxbzVcuNNF1s8KCgX2x9PYHgoeZ5zsfesKXc1yVSBhFG06pFii7TGr96Fb1onboo
	 HYeZ9qvfolfu+c/ZTTyvBnzTUIOkcoSRO1ZdnqOx+QyJtuXk3wVdnojIYFxHlZvImXtoD
	 39sQhoAJpRNq8GL/e0GFUJkA3UaG/Bz8RXxpIqO50b30R9O2Oe2DiNPgmix5//J2h8P9f
	 6SZxYhQkhsVnJm8Ovx8vW9A1WH3ssSU3iLPoAjubE+PZ66jVQOxEw4MCKwFAuMKI7Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdQLUuTe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53AF606A319;
	Wed, 21 Oct 2026 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdQLUuTe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3BB1F000C1;
	Wed, 21 Oct 2026 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792612701;
	bh=pF5l050qT/qvl0GvCxGIiAGvWNtowoG+RzEclp/R9Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XdQLUuTewF4k8NfDtfZnVjrCcWWNNTSRvZUzNe9JJUpWZusfLOgbRtGQdp8bCFhZB
	 lFy9m/6IvJJUZjVXFmtiB2GddcVcUsEpWBrJzFXuTZ3QfcJ2dueLFN+VMt4Mnf4R8d
	 DhTph084b8r5OZeiBC3plGVw0mjlZ1RJP2Nir/r/8pHt0geTDNdox+Cj/+qveEkp+R
	 WIU1iCR+BeRi71dMRNPZtRkMKOjUQf8OijbtavQj/wm7jaP2iZgFo0Z+OoW2T7gJuC
	 5AGbG/3rV0eao5zeSHtKjjGI3WfTB6IgVoKjhZr84eQecxXajsoyVk8/+oHLSOXCiV
	 rHTqSnN3R+o0g==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [RFC bpf-next 1/9] bpf: Add __srcptr kfunc argument suffix
Date: Wed, 21 Oct 2026 21:57:50 +0200
Message-ID: <20261021195759.119421-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021195759.119421-1-jolsa@kernel.org>
References: <20261021195759.119421-1-jolsa@kernel.org>
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

Generic sized pointer arguments are treated as writable memory. This
prevents kfuncs that only read from a source buffer from accepting
read-only BPF memory, such as const data.

Adding __srcptr to mark pointers the kfunc only reads.

Assisted-by: Codex:GPT-5
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 Documentation/bpf/kfuncs.rst | 23 +++++++++++++++++++++++
 kernel/bpf/verifier.c        | 18 ++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 73578a4c3b1f..6466b76fd721 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -351,6 +351,29 @@ In this case, a program attached to the ``inode_init_security`` LSM hook
 can pass the hook's own ``xattr_count`` argument through to the kfunc,
 which claims xattr slots by writing through it.
 
+2.3.10 __srcptr Annotation
+-------------------------
+
+This annotation marks a pointer argument as a source buffer that the kfunc
+reads without writing. The verifier requires read access, so the source may
+point to read-only or read/write memory. Pair variable-size buffers with a
+following ``__sz`` or ``__szk`` argument. For a scalar pointer, the verifier
+uses the pointee's BTF size; a ``void *`` requires an explicit size.
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
index 5601d2056218..7dd7b172a297 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13205,6 +13205,12 @@ static bool is_kfunc_arg_mem_size(const struct btf *btf,
 	return btf_param_match_suffix(btf, arg, "__sz");
 }
 
+static bool is_kfunc_arg_srcptr(const struct btf *btf,
+				const struct btf_param *arg)
+{
+	return btf_param_match_suffix(btf, arg, "__srcptr");
+}
+
 static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 					const struct btf_param *arg)
 {
@@ -13966,6 +13972,14 @@ u32 btf_func_arg_align(const struct btf *btf, const struct btf_type *t)
 	return __btf_func_arg_align(btf, t, 0);
 }
 
+static int mem_prot(const struct btf *btf, const struct btf_param *arg)
+{
+	if (is_kfunc_arg_srcptr(btf, arg))
+		return MEM_RDONLY;
+	else
+		return MEM_WRITE;
+}
+
 static int
 get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		   const struct btf_param *args, int arg, int nargs, u32 slot,
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

