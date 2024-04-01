Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025CC40876
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991238; cv=none; b=VS7pDGtEQUm/0X3Qg6EB0L7MuqqJqrQ/ZJanLYzaMkElI0gOBEig508StCrpOsf3f9MqeJ2vf226xojZTBJ5poy25edZjjAam6uSEROvJlY5n1st5LKRwfatxa3e06o+Bcrngyu/9Jya07ET+eTMUEqzOKwFAPPu8ZmHjpi7928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991238; c=relaxed/simple;
	bh=dbfcN9kCn0v8+Pi5E2GU16u0bFxzvCdOsF0Eqn2OPHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dr+S5vr9v2MUaXKoP2RU39XrDVnYqLX3Pn6oIT/I0pK84/QayFb31sUzoCMU3ixRcONOxaEw8cDOlJ236PFChqxkw9CWpeFkQl5atOe8D63Npn4B26RS3QNNOgasoUUchxiEmFuqpTcZ7NM2Ztpp851Cn+KQZ9GAZCwBTUN8Ttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2AkzDUV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2AkzDUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901A9C433F1;
	Mon,  1 Apr 2024 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711991237;
	bh=dbfcN9kCn0v8+Pi5E2GU16u0bFxzvCdOsF0Eqn2OPHA=;
	h=From:To:Cc:Subject:Date:From;
	b=A2AkzDUV0ihgC13HuCMgxLb4Ep4SD5olCcbiXhH9+yLfZbxkIQs7MhFBNFBJzCGdq
	 K1rr404FZ4CFkyubJngbbufVGD2vu+ao00Dpe2mCrgxI0rgkwFFcuik9LopYCa+QPx
	 3r42QoEwHclRP1XrxqhsDSchK03d5syhgelKKr6hrXqhtFPyowRxKOzYRMNoq97jqB
	 DP/M2/9DqXvP4/3Vjx/AJqDYCcnuf57g6c2lXKMOklYterhCe5ocHU7rFcQsXvNQle
	 Zw0eGBy8SzcK2sgGR3o1G1vCuCfxPH1W02oaSu3ZnZPrEsVSjR29A0OpbQqFhqjtOT
	 S2URfj9TyVnoA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpftool: use __typeof__() instead of typeof() in BPF skeleton
Date: Mon,  1 Apr 2024 10:07:13 -0700
Message-ID: <20240401170713.2081368-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When generated BPF skeleton header is included in C++ code base, some
compiler setups will emit warning about using language extensions due to
typeof() usage, resulting in something like:

  error: extension used [-Werror,-Wlanguage-extension-token]
  obj->struct_ops.empty_tcp_ca = (typeof(obj->struct_ops.empty_tcp_ca))
                                  ^

It looks like __typeof__() is a preferred way to do typeof() with better
C++ compatibility behavior, so switch to that. With __typeof__() we get
no such warning.

Fixes: c2a0257c1edf ("bpftool: Cast pointers for shadow types explicitly.")
Fixes: 00389c58ffe9 ("bpftool: Add support for subskeletons")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 786268f1a483..b3979ddc0189 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -386,7 +386,7 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
 			 */
 			needs_typeof = btf_is_array(var) || btf_is_ptr_to_func_proto(btf, var);
 			if (needs_typeof)
-				printf("typeof(");
+				printf("__typeof__(");
 
 			err = btf_dump__emit_type_decl(d, var_type_id, &opts);
 			if (err)
@@ -1131,7 +1131,7 @@ static void gen_st_ops_shadow_init(struct btf *btf, struct bpf_object *obj)
 			continue;
 		codegen("\
 			\n\
-				obj->struct_ops.%1$s = (typeof(obj->struct_ops.%1$s))\n\
+				obj->struct_ops.%1$s = (__typeof__(obj->struct_ops.%1$s))\n\
 					bpf_map__initial_value(obj->maps.%1$s, NULL);\n\
 			\n\
 			", ident);
-- 
2.43.0

