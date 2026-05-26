Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BB3FF8AE
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804945; cv=none; b=s7FuFKMDDg8TA4dCHRAVguNZrsTK0BQRuayXmFpjJz2Tc94vf/g2aVzAWV8h0/IgcmoX2QVBT7qcYnnkEK49AP6t7wzuzb/fvOoAWxPFxt4dR8K/8LEZ3KOv2wlrn9HfiQ+kPozuPFj6MKY8NmE2eSy2Fpbi+t4z2Djvwjsijjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804945; c=relaxed/simple;
	bh=SrP6SKRKlEW+kzm6E5gyWOnirxv86MAAGseQB9sR5b0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nR0ylYJ5pCEu210VaPPPnfZnom64Tvxp4cIjomy7MKEkI2SupgHBIPOvsvgyItS9btGZyH/bq4d6xwMXr1UdvHINofQgDooXd2WkSYWx97kJK1r+ipPZ+Peg9jzXQzUDICj6iFr29flIy11XUMU+yrdrwpZ3vd1Yw9b1Ljen//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BITSzV+1; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BITSzV+1"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-6889b2a4afcso288766a12.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779804940; x=1780409740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNY8rXPMnN6yvu32biXhw7JSMAJZadKBrhVosmLObKM=;
        b=BITSzV+1ZjbzjpZu5/Otr6JwbJNMpT0G1TOVnPZSqujH440tjqjjO9ultIeOevD751
         K2DJY4JMX7lZWyj7vxDlxUXBtEz3+kJjRZjTCQQfCv2ro/SgBG332zX5i4ODQCVDTUUr
         BfFeLE6MXNHeCVJIhYLMxbtwe6PWWnZ8TwGFKo82uYI6pFbZcsPxhluHzmaf4rCGP7Ak
         MRpJv0yMfaf6IlBmDGc3z77gXewZxgeXNk+J84seASBP/+yEEU5GMevZgXtU9GZ3aP+T
         3G5Wl3ws/EEie/p/sAocmDo/8RqLpQVR9jNvvEZuK+e38yO6FG1E/JeQ8WLDyfVCcGS7
         EEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804940; x=1780409740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BNY8rXPMnN6yvu32biXhw7JSMAJZadKBrhVosmLObKM=;
        b=bgqv5VtTHn/qmVYbybNgFSRUyvxpTbf9p1Uwp4r8V0RUS4SZW5S/2W0yVs8ejd4bgC
         Hj+vhk0sO+UAOsQ64xXdD4lRhjrp9ow6F7E7DZuzAXH9XQnJJhdBO8Dj8ESvCCaylzIQ
         5uilekrxOoeCNV6O9La2xGswGz4883RoMIpxtgA5YzsXv8yzf29x9YfX0jciBSqDUpwH
         uCxHZzy1miU9jekGJExPcg5dmavoCdKXYW1OO4uGhETUh+cuoFx216FpnuEg00db4IiT
         GctMiBV/AxYSPQczh9f4maXPhRpX+K6PkP7ITzBtYt9ziu+dh1OdR9FC4jY6b94I84a4
         V36A==
X-Gm-Message-State: AOJu0Yzf5+ODZ9YbCfk1PT5UUHqwZm/Me6raDJIG1os0wnyZc+HCg/I5
	JD4rYWPf3uRIZC3eUCAlwt5GSi+HJDBFHCeBKuPcTkAT4H3Q3Ph/5CfuGyxPxnC81tISRW9HgWa
	8HyeHTDBs+TJ2rHLGdw==
X-Received: from edvt5.prod.google.com ([2002:a05:6402:205:b0:672:b7c7:1edd])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:458e:b0:683:e55a:d165 with SMTP id 4fb4d7f45d1cf-6889c422dc0mr10289653a12.2.1779804940058;
 Tue, 26 May 2026 07:15:40 -0700 (PDT)
Date: Tue, 26 May 2026 14:15:36 +0000
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-3-5b4fa2a5e1a4@google.com>
Subject: [PATCH v3 3/3] libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader
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

