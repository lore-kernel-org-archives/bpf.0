Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA27405C3E
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886390; cv=none; b=t3Tbju3pwMarU9Y1mHXm//sSy83vjtEEE0BFQO6Mx26LWGLGrYseiEqTPDpK8iVKhqs5x+JQVGhzI0lRIDQM6O7OIsksjLopKpA2VM4yZstzQK9o2x7t0DcPDNtyuRsT5afkQaDDwMceZnSmHCN8q4JH50q+PwKmc7M2z/fYHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886390; c=relaxed/simple;
	bh=SrP6SKRKlEW+kzm6E5gyWOnirxv86MAAGseQB9sR5b0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mRwUoCCgiMKm16sydVmMJQAFyT0YhwLncsnBVe/fzcdpJtPxN99s0IiSzpidr2Hoa75iyJknKMtmlMTZgswm7zI8Dbc2RJAVNOCsnkgyV7/xa9GXZF8dWCvqz7h74pTUwISPtIPgSDLR2HrWGsrwixCXKx06EMXtDp2n08V0Ofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMligWWh; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMligWWh"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49043386b3fso51034045e9.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779886387; x=1780491187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNY8rXPMnN6yvu32biXhw7JSMAJZadKBrhVosmLObKM=;
        b=eMligWWhWOdbjC9lpqGFwEz+x0Kjgt4eu/d9Mka3PQeG1gTr4z67g2MsehVEeRkUx7
         NEHTApkLfrCouD4EOzaB48khadO7Zi9YlpNn8Ub7rvHtBM2qK/cSfRmU2zFEynykfih6
         aX6J65UvKxVRMemoKDaFiHtK9bA8Y9S+uDEviPDhAl3fhzAWAME6SNg1BlS8zxzMrOsc
         N/+icIHwN+9jz1yghchoOSojiCfXOcmsjBrwL80pCXTN3Eyubv6XITtLELOSgwb9erUU
         hzmfHwt382R/Lw1+i51EJ+Jvt26wE7yQ0Jk4DHBRjiDrPuKmt0fdH3yVl3eyQKuOXQsK
         6kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886387; x=1780491187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNY8rXPMnN6yvu32biXhw7JSMAJZadKBrhVosmLObKM=;
        b=KvkU4F+LPo2alo+KBXB3eYwDzjq0Ra+g9WwtuixvGy8ID/1Q3Y5Z2w5Zlp3FYM2pN0
         u33Ha7WPpibNldp4/fsopMZCAk231HdOEp77QQzmCR40wffyTBHAa/l/kqr+yMqkoYHp
         YGSwWPkODl9MNyUklPyEaooyG/rsNaMWaH1g4x+vNB+oSaQovm3GhdIZsXCWwpPKDFML
         1sWxJvw5HIWY1qLH0c617gzDcQKivRU6p/KDMUgDcHTxDZ2TWrue+hS+VGR+khAxuzDD
         cCRduH8EHBqCk1ZTxaX5Aul1rY/eK0SXsbtbKn81GwcYNQIjZRnvpPWEtmqL1dR13klh
         8ycA==
X-Gm-Message-State: AOJu0YxVBDOIgo0ixd/KZQlExkPMxiNuMoqeB8kE2UfZWk2GUM+KN1oE
	0lZsqZDuSFqFKP6/TYsLJDC/qeyMGO9kALnUZqbcvGpOV7cvvYceoTlzSfdscWtOcamJNuHv3Pi
	YzEhCGlGy70Tni30pVA==
X-Received: from wmbjr17.prod.google.com ([2002:a05:600c:5611:b0:488:9407:fee8])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45c9:b0:490:5cb3:e94a with SMTP id 5b1f17b1804b1-4905cb3eb81mr247328625e9.2.1779886386321;
 Wed, 27 May 2026 05:53:06 -0700 (PDT)
Date: Wed, 27 May 2026 12:52:59 +0000
In-Reply-To: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-3-27daa15487a9@google.com>
Subject: [PATCH v4 3/3] libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader
From: Siddharth Nayyar <sidnayyar@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, gprocida@google.com, 
	maennich@google.com, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

BPF `STRUCT_OPS` maps (such as `sched_ext_ops` maps) require resolving
and plumbing the kernel-side structure value type ID
(`btf_vmlinux_value_type_id`) into the BPF map creation system call
attributes. Additionally, when `btf_vmlinux_value_type_id` is supplied,
the kernel requires a valid userspace BTF file descriptor (`btf_fd`) to
be supplied to verify types.

Previously, the `gen_loader` map creation generator
(`bpf_gen__map_create()`) omitted plumbing `btf_vmlinux_value_type_id`.
Furthermore, `gen_loader.c` only copied the loaded `btf_fd` from the
stack to the attributes blob if `btf_value_type_id` was non-zero.
Because `STRUCT_OPS` maps explicitly zero out `btf_value_type_id`, the
loader program skipped copying `btf_fd`, leaving it as `0` (standard
input), which caused the kernel's `btf_get_by_fd(0)` check to fail.

Fix this by:

1. Copying `btf_vmlinux_value_type_id` from the options inside
   `bpf_gen__map_create()`.
2. Modifying the `btf_fd` copying condition to populate `btf_fd` if
   either `btf_value_type_id` OR `btf_vmlinux_value_type_id` is set.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/lib/bpf/gen_loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index cd5c2543f54d..a9be0c241025 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -525,13 +525,14 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 	attr.max_entries = tgt_endian(max_entries);
 	attr.btf_key_type_id = tgt_endian(map_attr->btf_key_type_id);
 	attr.btf_value_type_id = tgt_endian(map_attr->btf_value_type_id);
+	attr.btf_vmlinux_value_type_id = tgt_endian(map_attr->btf_vmlinux_value_type_id);
 
 	map_create_attr = add_data(gen, &attr, attr_size);
 	pr_debug("gen: map_create: %s idx %d type %d value_type_id %d, attr: off %d size %d\n",
 		 map_name, map_idx, map_type, map_attr->btf_value_type_id,
 		 map_create_attr, attr_size);
 
-	if (map_attr->btf_value_type_id)
+	if (map_attr->btf_value_type_id || map_attr->btf_vmlinux_value_type_id)
 		/* populate union bpf_attr with btf_fd saved in the stack earlier */
 		move_stack2blob(gen, attr_field(map_create_attr, btf_fd), 4,
 				stack_off(btf_fd));

-- 
2.54.0.746.g67dd491aae-goog

