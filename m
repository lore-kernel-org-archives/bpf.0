Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265B3E8C6A
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797584; cv=none; b=kgSdtesZyaEo8W5QJcT7NgxNkB8VxaBqyqnJNFEo9WwW7YWyJlnDcXOz/dEqIrHzfQSxeQh7c4kV1Msx0jRKIAXIheWJux25x1tjcdPEKcrM9QDm5aY42nF1+KJimuTx9efCT2R3MH6/DKMGoZ6SxTMz4Z5eCQmTQDqKOfE7PwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797584; c=relaxed/simple;
	bh=pOAcjYzz/U4h24Eskb6+XHs/xOejt1MVBD2qiXMKAPY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=svb+p4/QyKet4z2k5MmytIyTekQomu6jkbpKdXoupu8FFkXMAcCG0Z/ZO1oj89eKK2kSagFwBQayn6C6JgRBBLHgDjTCTL2pgtuzyakzsX3PtBTMtk7XfJweKtFmkpPLW3K8uKZzZ7sqDcvL3LGn+Rb9smkr2Ys5wc3D9UH9nMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpTgbt6l; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpTgbt6l"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bd9a6aae530so687243066b.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779797580; x=1780402380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UIl3E/KIplY8UrahHH32aBs14FSe0oCJM9lCiFtGNHw=;
        b=GpTgbt6lGiKiJVHEThOwhAv/ViJ9pKyeGdmAVl6PicFK2N0Kz5sWPwlA8wD7DYB8S4
         gJMW04rh+pIFhDDEoNb/j00UrqOeM7rOC+o1+g6oB/OZYLKgfUDQtCzKU6uaWqlfuZZy
         J1tMaITzd9RPBG3+QfYp1rsL+JinHCy2Lun/GNp5U48qBcePadckl1zVvpAska9s7IV7
         avPMSm8lq5yX0Q5aZHViOKlQoPlAgMBdn8NIDh3iRvQPxXcB6bFFZ6x1KXCm1ZB7amaT
         g9+UuE/f7ek5EApfWcw9uhUntg3tpMXmeNpluqMisJfpZkPbw5HOh40ejEIhSkETsOVN
         xJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779797580; x=1780402380;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIl3E/KIplY8UrahHH32aBs14FSe0oCJM9lCiFtGNHw=;
        b=IfYe51Wp8jFGsMbm/11c5kbWYE4/1HlJCj9RIq6+o/XiAEWFbZybdCI0dSRfNXDsik
         caRoM1hQu0SSKIMWxt2XZdk00hYram1rXMU8dDZ81BexAqYyETRzpLJcH7ip9HaopX0w
         xUjtyEBsyHXK5V0K8Laij9pGXqm8ghkHLxgJIyJLS69uAWqgMyjoAVeR/rUaLbgacXBt
         DEveXGsI/PelKwOmv8LgzsxaUI0yhxEuf35hiPjTsBELZudc9qsaOE2XTJjjrAT0iwEW
         IHdivO2yp7MJJlcqiu5pcC9jPcanQW8Xwr4OEEdmnRnnCqH4H8wm/3Vqjw32E8/LAcOp
         4TkQ==
X-Gm-Message-State: AOJu0YxYdkudAdQ693rX96wVPexJKSKbV2IF44/8NlAwK1IQHBK/8lZQ
	fFLYLAeGc75xn9c8n9xAcngZvSiaXyhr8rT27jZYo5MNOfQz7LJk2D7T5fo1rrJNraN2+AQwMMG
	H0+gx0HUMofi2XpCB6Q==
X-Received: from ejdbw10.prod.google.com ([2002:a17:907:fd8a:b0:bb8:69be:b9f0])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c003:b0:bd5:7a3:a593 with SMTP id a640c23a62f3a-bdd2b0d6a45mr1184970266b.46.1779797580315;
 Tue, 26 May 2026 05:13:00 -0700 (PDT)
Date: Tue, 26 May 2026 12:12:55 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEeOFWoC/5XNQQ6CMBCF4auQrh1Da6HqynsYYgqdlkmgJQUbD
 OHuAokHcPm/xfsWNmIkHNk9W1jERCMFv4U4ZaxptXcIZLZmIhdlXggBHdX1YKEL2kDqO/LvGer
 JAnlw6F/7jhH6YBCkVPJ6kVrLUrHtcIhoaT6wZ7V1S+MU4uewE9/XHyP/YRIHDqUtlOU3rpU2D xeC6/DchJ5V67p+AUlreI/lAAAA
X-Change-Id: 20260522-libbpf-load-vmlinux-btf-in-gen_loader-mode-4474834aa467
X-Mailer: b4 0.14.3
Message-ID: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-0-6750f5859bc6@google.com>
Subject: [PATCH v2 0/3] libbpf: support STRUCT_OPS in light skeletons
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
- Expanding the map creation attribute size in `gen_loader` to include
  `btf_vmlinux_value_type_id` and plumbing it.
- Fixing `btf_fd` copying logic in `gen_loader` to populate it if either
  `btf_value_type_id` or `btf_vmlinux_value_type_id` is set.

With these changes, it is now possible to generate and use light
skeletons for BPF programs utilizing `STRUCT_OPS`, such as custom
sched_ext schedulers.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
Changes in v2:
- Expand the series to 3 patches to fully support STRUCT_OPS in gen_loader.
- Add a patch to explicitly zero out btf_key_type_id for STRUCT_OPS maps.
- Add a patch to plumb btf_vmlinux_value_type_id and btf_fd in gen_loader.
- Link to v1: https://lore.kernel.org/r/20260524-libbpf-load-vmlinux-btf-in-gen_loader-mode-v1-1-6f57f191a7ad@google.com

---
Siddharth Nayyar (3):
      libbpf: load vmlinux BTF in gen_loader mode for struct_ops
      libbpf: zero out btf_key_type_id for STRUCT_OPS maps
      libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader

 tools/lib/bpf/gen_loader.c | 5 +++--
 tools/lib/bpf/libbpf.c     | 6 +++++-
 2 files changed, 8 insertions(+), 3 deletions(-)
---
base-commit: c6e99c10fd9855082568cbd71bb2cc5dc90eda53
change-id: 20260522-libbpf-load-vmlinux-btf-in-gen_loader-mode-4474834aa467

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>

