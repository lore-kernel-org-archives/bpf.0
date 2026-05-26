Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3A3F8EDA
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797590; cv=none; b=oZC5+pd6ng+Sw9V8IW0afXkmF80k9FclKU6tUYedPFR4HymX5NrBIyFCoXcHeXNPXbTjHMGGZpybap6mhB9hpwI4PBNst2+imnzk+5nD8phCJ4NVesj5tNyLu3XUgHjwUDboVsLsctKogNjzxoJBquZ4749shucixrdlR983kqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797590; c=relaxed/simple;
	bh=ZVVFcnO4jbsaN+TytchoKonz59gxXG27d5qwUZORD9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iX0p0afcoh7xUI6VKxPdc9Dj27PEomHssSI70YNIpFUWsaBibirW10YbJAOc4OS49DfHBU85ESIDIfUj2rz9ZjfFBKfs6kWOXuy/0CgyQjEZCFsVAJye30C/y0Zj9zhO9N010AEskb5D9mm3s6JiMwt0ZQIEplChK8b/RynLe2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpS0zePc; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpS0zePc"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45e78dd7baaso8499902f8f.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 05:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779797586; x=1780402386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujXfymO4WwuSo3vEXh8kXT2YRaF1xQw8a4+t2c/ZKm0=;
        b=IpS0zePcXdDM3CV4jY9KrULlDH9Euj/dA0A7foyAAmVDFYM7peDkaKONv9N7zgEPS8
         KSpFj+NHC55A1U2kXghVj6YnM6AKCSbDwjBAVZQf/6HUWuukXdLeIKxxHqyOTc1zfzpb
         nVHZm7DBehM02KzjzjE+astQAm2xMiXqfchbNI2BI+p1/CQV4ihRFgDy0lA1QDvY4oav
         XnsjVG4li0hUuYKnM/ryz8dkH5a31n3Qfr7O6Yw3vtO0dk/CX4C+OAqu8VCZtfEJkfML
         u208fqWbgBEdPif9ePm7Llbeu3c5MaVfE7VqpqTTY6y4CtZ41vty1tNNKRaCXw3pwSQm
         fwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779797586; x=1780402386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujXfymO4WwuSo3vEXh8kXT2YRaF1xQw8a4+t2c/ZKm0=;
        b=Egs2ui/d+sPFeu7vxmDg7VoE42ZlxNlJbd9N58JSYC0Km1nhXL+gUHZWGE54dpcZ/8
         zaSrvsmvrivJXTrujZPzo+hLWQO5CCRwboyABsxsqQOaM9bErKotkkZg8zGgZl6IrC25
         JoYB0aIS4YR5IJwmq+zXvuadXbQzMJyEN0ABDHnPhbhLV1THxoaRTfZwGV1J9swIbB9T
         LqMVKub6m913LS78SRQOHJs9YAJ83qwqnwM44i/3b0+0IPniysxuoTeqQQnJWZHNm0hR
         5pAWH/uxAJ7npi5Jmviv5VC9DC8JGnrbn2rYx4sjhs92IY/UYMALQTB4JisK47x5EQii
         54/w==
X-Gm-Message-State: AOJu0YxBU2BeuHC2xRy1ML/tlzAjblOE4FbRzRKvpjsx6GxfZKfFriRv
	fYxBWXwMuJj29XzBzR9f2uXKbSkv6cX4cgZy++yk+ythW2h1Mmu8FpOg+FrxkD9nI0P0y0nCHX2
	PJKY7dlveU9er3fE4AA==
X-Received: from wruw1.prod.google.com ([2002:a5d:6801:0:b0:43f:e55b:b4f])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:26cf:b0:45e:93ac:769e with SMTP id ffacd0b85a97d-45eb3688c6amr30269495f8f.6.1779797584921;
 Tue, 26 May 2026 05:13:04 -0700 (PDT)
Date: Tue, 26 May 2026 12:12:58 +0000
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-0-6750f5859bc6@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-0-6750f5859bc6@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-3-6750f5859bc6@google.com>
Subject: [PATCH v2 3/3] libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader
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
(`bpf_gen__map_create()`) completely omitted plumbing
`btf_vmlinux_value_type_id` because `attr_size` was calculated only up
to `map_extra` (which resides before `btf_vmlinux_value_type_id` in
`union bpf_attr`).

Furthermore, `gen_loader.c` only copied the loaded `btf_fd` from the
stack to the attributes blob if `btf_value_type_id` was non-zero.
Because `STRUCT_OPS` maps explicitly zero out `btf_value_type_id`, the
loader program skipped copying `btf_fd`, leaving it as `0` (standard
input), which caused the kernel's `btf_get_by_fd(0)` check to fail.

Fix this by:

1. Expanding `attr_size` inside `bpf_gen__map_create()` to include
   `btf_vmlinux_value_type_id` and copying it from the options.
2. Modifying the `btf_fd` copying condition to populate `btf_fd` if
   either `btf_value_type_id` OR `btf_vmlinux_value_type_id` is set.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/lib/bpf/gen_loader.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index cd5c2543f54d..27b0353d1082 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -507,7 +507,7 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 			 __u32 key_size, __u32 value_size, __u32 max_entries,
 			 struct bpf_map_create_opts *map_attr, int map_idx)
 {
-	int attr_size = offsetofend(union bpf_attr, map_extra);
+	int attr_size = offsetofend(union bpf_attr, btf_vmlinux_value_type_id);
 	bool close_inner_map_fd = false;
 	int map_create_attr, idx;
 	union bpf_attr attr;
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

