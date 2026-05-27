Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C767C283FF5
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886387; cv=none; b=seKj6RTS0AtnC6Y+/CU0X7GCoRoAbmDFvgD9Zf6vilpMQc3lz/PgvBlfp3JOhovEEQ8NvKvgAmH07ZB2dWwWwgwMH9pxwlPCEcUe+L2h/luVGcZtGqSwoU16UhAoj0cQKLnYlsq7y/f3Kd4EYJ7e4MCAvi8NlMmdhA4/Wt1LxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886387; c=relaxed/simple;
	bh=rKh7yFwfbu/igasiSX3RCH2Oso9JbKo1Z4xZmpDBbM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CQp6KrKRoL/pyNOTJXkHUtWgMP5TZJeNSMY0XkZVAuERaH75W0Ziqq+KX/XM6iZnOWsja+MJxcKILznQ3O36QWkwR4cjEVpXA/GAKKD+Qe/tImpRwbiF5ZkWjLTr4d/8apdn6D4/QXbAPeyV8+0n8CC99NirVobBlVffbEvXSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5CAe03h; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5CAe03h"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bdbe7ad665aso714059266b.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779886384; x=1780491184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwM7tLigXa4SmZ+iBmv8/N7XkWuoA8HVKgKI0pJrdIE=;
        b=S5CAe03hG2Szfk5Jqs1lIdtY5a8gjiEG2ZQ20UCEfvmSeFArWVHlyGNBp4VWdl6c1A
         05ujmZKAi1FKk0SlQMtBOgmLLiHAcsJ1L5zsVMDz5ya6MWiSdikZXPnwi931muGqgFdU
         QdQaUMHK/dKTKTdZuJz7oybzm+MGOjtu+iDyc2U7lBAkTmWxP+I32+YeE4WZQWyt92Ik
         ZGwZWfl40kIA/uFAzI6YOdC+lRBoZ+h7VtYodv7NKWRMliZCigisH7BftuDCeXPNR5Rv
         Q9iLfqp2gRBA432QbsW2S4CeQRbLtz6Km5Cqd7SxKgy7EyMa0oobZJhpgp0zqcagfx3j
         PQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886384; x=1780491184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwM7tLigXa4SmZ+iBmv8/N7XkWuoA8HVKgKI0pJrdIE=;
        b=ckUCI0Wd5O5WDpoUrU3HnUFV0tZ9w2MjSuV32hvv57PqK/DJzHT4KXeXUyZMc3AeO7
         B70VEK+q8kcR4I53wL+vIfBVpMoyiv/8f4ASg3/smE6tlDmiUKK8Cw4H91Md9Q2LHmJ5
         sCJAMCsoaiXhNDKtt9+IOXOPv5V4A9l5ZO2ChNqGiJgrsT9v+ovG/PKKeeT4lc2giU+B
         QwSsq9CpnOJeCNFEY+x9AiLJsmNlHvAcnX/gbTaUs2QCcScnLu2PthZvVKPxtSqfXV1I
         HD23H/ps80l2bYgcpn8q4v7uCR146gJlrzjw4GeIyr44mqMZ2oISd6lqLymWHwtvc2CG
         0YPQ==
X-Gm-Message-State: AOJu0Yw9ywSPqufEy+mFZSSQSlFSylB2RaWdUYJJLt/Fv8prO+/LRjug
	pmmRYobfyIkxZPPTOpPVLWnCO6nSEYf9a1Lk5YMz027Z020wWLA/fsDWV4G1n8Xg+MArKv1YAsL
	e1O8bkR0pepR176MbUw==
X-Received: from ejcag17.prod.google.com ([2002:a17:906:9a91:b0:bcb:8fd3:7db5])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9813:b0:bd4:9a55:18e2 with SMTP id a640c23a62f3a-bdd267c685cmr1405394266b.45.1779886383718;
 Wed, 27 May 2026 05:53:03 -0700 (PDT)
Date: Wed, 27 May 2026 12:52:57 +0000
In-Reply-To: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-1-27daa15487a9@google.com>
Subject: [PATCH v4 1/3] libbpf: load vmlinux BTF in gen_loader mode for struct_ops
From: Siddharth Nayyar <sidnayyar@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, gprocida@google.com, 
	maennich@google.com, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

During light skeleton generation (`bpftool gen skeleton -L`), libbpf
runs in gen_loader mode. Previously, `bpf_object__load_vmlinux_btf()`
completely bypassed loading the kernel vmlinux BTF (`obj->btf_vmlinux`)
if `gen_loader` was active.

However, BPF `struct_ops` maps (such as `sched_ext_ops` maps) require
resolving the kernel-side struct type IDs and member sizes at
compile/skeleton generation time. Without loading `btf_vmlinux`, libbpf
cannot query the kernel BTF types, causing light skeleton generation for
`struct_ops` to fail or omit crucial type information.

Fix this by modifying the check to load `btf_vmlinux` even in
`gen_loader` mode if the BPF object contains `struct_ops` maps.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/lib/bpf/libbpf.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3a80a018fc7d..b159faae7f9c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3544,15 +3544,20 @@ static bool prog_needs_vmlinux_btf(struct bpf_program *prog)
 	return false;
 }
 
-static bool map_needs_vmlinux_btf(struct bpf_map *map)
+static bool obj_maps_need_vmlinux_btf(const struct bpf_object *obj)
 {
-	return bpf_map__is_struct_ops(map);
+	struct bpf_map *map;
+
+	bpf_object__for_each_map(map, obj) {
+		if (bpf_map__is_struct_ops(map))
+			return true;
+	}
+	return false;
 }
 
 static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 {
 	struct bpf_program *prog;
-	struct bpf_map *map;
 	int i;
 
 	/* CO-RE relocations need kernel BTF, only when btf_custom_path
@@ -3577,12 +3582,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 			return true;
 	}
 
-	bpf_object__for_each_map(map, obj) {
-		if (map_needs_vmlinux_btf(map))
-			return true;
-	}
-
-	return false;
+	return obj_maps_need_vmlinux_btf(obj);
 }
 
 static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
@@ -3590,7 +3590,11 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
 	int err;
 
 	/* btf_vmlinux could be loaded earlier */
-	if (obj->btf_vmlinux || obj->gen_loader)
+	if (obj->btf_vmlinux)
+		return 0;
+
+	/* only struct_ops maps need btf_vmlinux in gen_loader */
+	if (obj->gen_loader && !obj_maps_need_vmlinux_btf(obj))
 		return 0;
 
 	if (!force && !obj_needs_vmlinux_btf(obj))

-- 
2.54.0.746.g67dd491aae-goog

