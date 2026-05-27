Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F81F91E3
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886387; cv=none; b=gjUUuSPDYRDsNsAm2bWzbXMvr/DzSjB5sM082HBP+Ir3R61fckv7xB2gEH/pglToP+vzO4cFWz89/WLkz8pkOUUXYpiJfOt9mYRC5Ip+eeXNtY2m45hOnz49yRO8qsbfzuAJmB5ghS21I0hi9NLhJASdRhvdNKkfD3ebHb6uTsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886387; c=relaxed/simple;
	bh=rNxMIv+2x9nSn++ouG+jyzsrSQAmuIpY4iieHPnGbys=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=om/HUo8QlLDKg0F5+NnTBcv9kr3aBowJ5HUq8XTZHMzq4cTE7ijHJlrUq4cFFzSo+inPYt4PbPamCXq2EYZ3G3bj+XtVsDq0ucKMgN/Tmo6URtnl7h3o4o2+6uiDJQebfu5ANRzn+ifqzIKtvzdaD/O1uFM9LMGsmqv8Qx2kcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JTlcEe7j; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JTlcEe7j"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-67bca868649so9321129a12.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779886383; x=1780491183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EE9RHHHaphgCPFZkYOf5S6KnHl1mfTA47UeIHzlNddw=;
        b=JTlcEe7jbvg152BYdq8tl04L5bPz6f1yP6YGeHHdJHAeHbwrhlAlagn00aUPJjgskQ
         +ayEow3gWcK5elGwPYYkt9hk2VH5BfCop9WgIeWefsVE50IMInd88yPw8arZgwJU7kxY
         rW3H6EAIebZGIm1f9CuYktPaLHGVzpXVSIRxzQNgp9ZSzDawUQmY6n+z+KD+jaQuZ9gZ
         uNuZg3Cyp7UiU2RN55MRFqKq9/s3VAmZUqGkp8KZdw/lVzr8E8LV5m5/s+Q4gDSRb+IB
         vLUhFF+AJKOYA+LbOXq2ozQtBnwhibV59KEA9loH7FdjGBpsT0lyA7W2hllB+3+/uSZH
         mjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886383; x=1780491183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EE9RHHHaphgCPFZkYOf5S6KnHl1mfTA47UeIHzlNddw=;
        b=pYvCyEZQcF5n5mmy1gs/NdPNhxihTj1om1lpuC3XHYf/eTnv/Lx4a85+muBeU462Lt
         MWmkkC5trgD3aUUnEUWljktmNoK4WXBV2Ai6SN/3UZhku5QQkrQcc2jH8R5dgwZTm/3f
         J+ACQ0upXwLMedyKuk6oPIdA4SQNFxyTECwHuOmBee8HxhcH+hVFjNX4aKfh3amr+1ah
         oRi/EzUSz3UofcowDpWoc53GHpTG1lOVQSBa/qqi+cDsGkY5eYXExyQaFuOrusypXrYj
         vB4H7McKFT0iJ8MpIe2zsUdq+EECy3XZRyr6XwB28sl8iC1Ymnid3A/z4UL1YGWKVRl0
         OkSg==
X-Gm-Message-State: AOJu0Yxs4skvZNKNUYQy6MoIw3Or5xp5DBZVvTILTWurWPIQnuBt3fOM
	zyNj/e4RJU1t2IN+u4c9SGXFtRv3us5tFw40xEo8nichTXSDrX6b4+qYDV0MAk7u1+unnEPmRo/
	OnwO39CFKstYgMScuNg==
X-Received: from edgc11.prod.google.com ([2002:a05:6402:a60b:b0:68a:7e93:c802])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:320f:b0:67d:5c3d:8633 with SMTP id 4fb4d7f45d1cf-6889cc6f56fmr12242997a12.26.1779886382634;
 Wed, 27 May 2026 05:53:02 -0700 (PDT)
Date: Wed, 27 May 2026 12:52:56 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACjpFmoC/53NQWrDMBCF4asErTvFkkdSklXuEUqR7JEzYEtBT
 kVK8N0rBwIpXaXL9xbffxMzZaZZ7Dc3kanwzCnWgW8b0Z1cHAi4r1uoRplGKwUje38OMCbXQ5l
 Gjl9X8JcAHGGg+Ln+lGFKPQGixW2LzqGxooLnTIGv99jxo+4Tz5eUv+/tItf3kcFXMkWCBBO0D
 XInnXX9YUhpGOm9S5NYO0U92+YlW0EDxuom6K3e+c78sdv/2221tcfglNMkHf6yl2X5AbU9kgK dAQAA
X-Change-Id: 20260522-libbpf-load-vmlinux-btf-in-gen_loader-mode-4474834aa467
X-Mailer: b4 0.14.3
Message-ID: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-0-27daa15487a9@google.com>
Subject: [PATCH v4 0/3] libbpf: support STRUCT_OPS in light skeletons
From: Siddharth Nayyar <sidnayyar@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, gprocida@google.com, 
	maennich@google.com, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

This series enables support for BPF `STRUCT_OPS` maps (such as
`sched_ext_ops` used by sched_ext) when using light skeletons (i.e.
`gen_loader` mode).

Previously, generating light skeletons for objects containing
`STRUCT_OPS` maps would fail or produce incomplete results because
`gen_loader` lacked support for several key features required by
`STRUCT_OPS` maps, specifically:

1. Loading `vmlinux` BTF to resolve kernel-side type information.
2. Correctly plumbing `btf_vmlinux_value_type_id` into map creation
   attributes.
3. Ensuring `btf_key_type_id` is zeroed out to satisfy kernel safety
   checks.
4. Plumbing the userspace BTF FD (`btf_fd`) when
   `btf_vmlinux_value_type_id` is present but `btf_value_type_id` is
   zero (which is always the case for `STRUCT_OPS` maps).

This series addresses these limitations by:

- Loading `vmlinux` BTF in `gen_loader` mode when the BPF object
  contains `struct_ops` maps.
- Explicitly zeroing out `btf_key_type_id` for `STRUCT_OPS` maps to
  satisfy kernel validations.
- Plumbing `btf_vmlinux_value_type_id` during map creation in
  `gen_loader`.
- Fixing `btf_fd` copying logic in `gen_loader` to populate it if either
  `btf_value_type_id` or `btf_vmlinux_value_type_id` is set.

With these changes, it is now possible to generate and use light
skeletons for BPF programs utilizing `STRUCT_OPS`, such as custom
sched_ext schedulers.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
Changes in v4:
- Load btf_vmlinux in gen_loader mode only when BPF object contains
  STRUCT_OPS map.
- Link to v3:
  https://lore.kernel.org/r/20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com

Changes in v3:
- Remove erroneous change contracting map creation attribute size in
  gen_loader.
- Link to v2:
  https://lore.kernel.org/r/20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-0-6750f5859bc6@google.com

Changes in v2:
- Expand the series to 3 patches to fully support STRUCT_OPS in
  gen_loader.
- Add a patch to explicitly zero out btf_key_type_id for STRUCT_OPS
  maps.
- Add a patch to plumb btf_vmlinux_value_type_id and btf_fd in
  gen_loader.
- Link to v1:
  https://lore.kernel.org/r/20260524-libbpf-load-vmlinux-btf-in-gen_loader-mode-v1-1-6f57f191a7ad@google.com

---
Siddharth Nayyar (3):
      libbpf: load vmlinux BTF in gen_loader mode for struct_ops
      libbpf: zero out btf_key_type_id for STRUCT_OPS maps
      libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader

 tools/lib/bpf/gen_loader.c |  3 ++-
 tools/lib/bpf/libbpf.c     | 25 +++++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)
---
base-commit: c6e99c10fd9855082568cbd71bb2cc5dc90eda53
change-id: 20260522-libbpf-load-vmlinux-btf-in-gen_loader-mode-4474834aa467

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>

