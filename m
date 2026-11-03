Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692771;
	b=AYM5dgjZF5pXKnuUdksc3diX1Rd4E7f79b4bV58IxxCmqqYRXHmUkyMq3DhWhTUMf1DH
	 Cme5SlQonnRS64rKUUTaCXyusAaRybmieQbph1u/e5bmJ2QePN2sgjca+BoP4r6ZnssYy
	 kOMupXKDbOIRz3Gd3YoScineDXHq5+4AMzKj/JC8fOjLVUysTkhXAwT5IfNz6LFcbVGvS
	 fO1G4qc/1urifyXFHNhv+HCp8TY1bbTXpgDV9rqmaU7Q2hyPZfoobJOjYdP4PePs0qdCn
	 73P5KwstaLTucNRRDRA1LSXLH35a0bTU9Wk2dhMOPeMQrtJgrMOEa+v1E6CSZKJ5U7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692771;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cUf6B2WQBT+lXoY0m25EQ2J3rZ4cWPkyKm+cBrHh3T8=;
	b=XxvN3vtIS/NuKo83VRJ9V/fk4voL2DXe7dH8hxYJEJkCl8Cc1YoCkf2kGFBl3MYNrJ0h
	 V75y0S1O0rNCrvp+miBOkPMYJaTj2XRKQbqleNQVa2o68yE13/J+mRNPC99U9rsvWbQzz
	 /rDRKHONb9iXn97x/gE/tITNWzI0VJ8wghRp2wCk7rDJNMQFc5D9Wj1PiXFsYCH+frPiH
	 1on5Xgpmu+DuUQNVMmlrxTiKho5E+43qXxytyzZ/tbY85hFVHM4PBqK92LesMXEYErdFT
	 qweMJUsCwrL5pcKtHAj1yB1Ac41sAtFXlbenUQXRERnx2kMSg7ST9ONp9Df2+7xtT4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CPZ/ip1l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DED606A32F
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPZ/ip1l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204E91F0093A;
	Tue,  3 Nov 2026 07:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692770;
	bh=cUf6B2WQBT+lXoY0m25EQ2J3rZ4cWPkyKm+cBrHh3T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CPZ/ip1lhzJFLM+8RWjyEPfV7rdK11FuXBSJ2QXCeuMIyOntG76LCmW3KSZdy4Hvm
	 yUIM7KO/V0F/8dKMy29K4kYfOODoG2lwVggbZ6S9jSU46/UxEIBYX7o0NeyNEqmLc6
	 1GXCBjRuohC69wTw/Q0hPoBaZEK+vKYTgpD9WSRJQTEAps6hUiNx5TqBfWQQJlisSD
	 o7nqJ5H+sfx/8Eaf5xQzDVC28tsS/KBnSZ1poTGcpFev1Hsh1PgTjQBjiePPLURuxX
	 k7DC2Xxz8myb5y/EMHDxbgKt7ao2qkjzote+eFCgw7OGPdRG4dWZc+jTjHuffMNJLi
	 +GJQ8U2xRqMsQ==
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
Subject: [PATCHv2 bpf-next 1/8] bpf: Honor const on generic kfunc memory arguments
Date: Tue,  3 Nov 2026 08:59:08 +0100
Message-ID: <20261103075916.100050-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103075916.100050-1-jolsa@kernel.org>
References: <20261103075916.100050-1-jolsa@kernel.org>
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/verifier.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 935b163f81e4..5bc637a6fb13 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13182,6 +13182,38 @@ static bool is_kfunc_arg_const_mem_size(const struct btf *btf,
 	return btf_param_match_suffix(btf, arg, "__szk");
 }
 
+static bool is_kfunc_arg_const_ptr(const struct btf *btf,
+				   const struct btf_param *arg)
+{
+	const struct btf_type *t;
+
+	t = btf_type_skip_modifiers(btf, arg->type, NULL);
+	if (!btf_type_is_ptr(t))
+		return false;
+
+	t = btf_type_by_id(btf, t->type);
+	while (t) {
+		switch (BTF_INFO_KIND(t->info)) {
+		case BTF_KIND_CONST:
+			return true;
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_TYPE_TAG:
+			t = btf_type_by_id(btf, t->type);
+			break;
+		default:
+			return false;
+		}
+	}
+	return false;
+}
+
+static int kfunc_mem_prot(const struct btf *btf, const struct btf_param *arg)
+{
+	return is_kfunc_arg_const_ptr(btf, arg) ? MEM_RDONLY : MEM_WRITE;
+}
+
 static bool is_kfunc_arg_constant(const struct btf *btf, const struct btf_param *arg)
 {
 	return btf_param_match_suffix(btf, arg, "__k");
@@ -13550,7 +13582,7 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 			PTR_ERR(resolve_ret));
 		return -EINVAL;
 	}
-	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE |
+	*arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | kfunc_mem_prot(meta->btf, &args[arg]) |
 		    (*arg_type & (PTR_MAYBE_NULL | MEM_UNINIT));
 
 	return 0;
@@ -14102,7 +14134,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
-		arg_type = ARG_PTR_TO_MEM | MEM_WRITE;
+		arg_type = ARG_PTR_TO_MEM | kfunc_mem_prot(meta->btf, &args[arg]);
 	} else if (btf_type_is_struct(ref_t))
 		/* A pointer to a struct without a size argument is classified as ARG_PTR_TO_BTF_ID */
 		arg_type = ARG_PTR_TO_BTF_ID;
@@ -14127,7 +14159,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			return -EINVAL;
 		}
 		proto->arg_size[arg] = type_size;
-		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | MEM_WRITE;
+		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE | kfunc_mem_prot(meta->btf, &args[arg]);
 	}
 
 	if (is_kfunc_arg_uninit(meta->btf, &args[arg]))
-- 
2.43.0

