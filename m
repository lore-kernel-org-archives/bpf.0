Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277F3FE67A
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804938; cv=none; b=GNbDwTxifQeSgNTj8eANdd1/0HpNQNNSp8K/AshsZCz07ihWByL9KuLR/3+wFlBcUw00TRIf+pBiokNgut7uZQKLbOCSmqFmz2bCder7vNf1zsGEa3g4ihuB7BYabwTqYWMfx9IDwP4EEQrLm3umZoEUGYdwyMDEzt5fQeIuZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804938; c=relaxed/simple;
	bh=EdQq3aQ9KLzrDuftlkOM+TyHQLT0aDiS6zspb266sQU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WEnqCl0HcBeYQef7d/H4SQ5VrY7Rzp6Yhe8QEpqRDLdElhZeve18BVJuOWMsm7B3Utj+rzwxTA7xVjQK9tSuoRvcwjN1i6tYrNXz9lUiYaUSaYEVJduD5x+xSxg901EEswXg87jVSbInHNZkdAuZCW8fTvn3iofiQ1sUpgxP0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtaEhSiT; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtaEhSiT"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d7730e9e3so6455852f8f.2
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779804935; x=1780409735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wzpgf/wuecL2JBBMYkdRk+Xbi/3WeFb52lS50xAT3C0=;
        b=JtaEhSiTW2eLZtmb5uJDnGV+oJV6ww+pkMOEuvAmrijsArF+on5cJ9IYjUG/IpiHOx
         aTvI/hKjTw5qfUBmbB87EOKQY+rRb+rVNCotoq62Pj/wRIvFa31Lut1BPhKDFXdwCPyk
         pi3UNqDd82db6cAzGrjl8OHWvWMdIt8mksaB711F+R/dO4QJa0Qxl9WagCd8QXs7lMAV
         CeyTgztIkF8VWglfEn1tuyhd/NDydb9tuuhI7k4Z6D9kO9ANeczzOBYnIlTc7brGqOtJ
         7BJywBF9XLojtTdGfEMqAl1FINTW+k/jS7i9q8UG9bPgV8HF/7Gw9dJE3XnYtg7uuDgy
         19ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804935; x=1780409735;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzpgf/wuecL2JBBMYkdRk+Xbi/3WeFb52lS50xAT3C0=;
        b=lx5f+2t3MTeUVuQwmq7YyAuU4mDOwBxCkqG1xvsboxYb2yDT282A4p8lweFmPSXqV8
         ZGdSiKhbyjox2k+y6lXfYAa20UaDJwQS1sd/zRYYhUXLn8fw3o8cyevVAAxMfbNxNksA
         naqaKaxiXbNl8O/bsM7hp9+fONh4/cvrye27ULFgTpylMex8Gq6cThPS+bgTJYw29bue
         DbEeH9dzoRJJ8m455WWlLzCrzMkG1IhjtjvRZZwePZlKvqpZ2SKtPEF0NmkltLdPvfnJ
         dvlrb6RgHDRWrcpPe/wSyrZaB2U+/2WJ/zbg0iA4rjSxSmqgT9PRcTb7xAXV8gODuy6R
         776A==
X-Gm-Message-State: AOJu0YyWZ2ddk4nScoxGcHap+dhi9LZKIQXckYk6RWmRKZuvYsg74W1q
	GnDfg0RN49T3+msTFmn2uxdDfOkDET1Kbp1n9X0DO2qqsH2YL2hMHWeBwmZWZdz+E1JVOlc42Ml
	XRZIB09y251Z3fumobA==
X-Received: from wmxb15-n1.prod.google.com ([2002:a05:600d:844f:10b0:490:507b:f39f])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3d96:b0:490:5429:1513 with SMTP id 5b1f17b1804b1-49054291bbamr250856825e9.6.1779804935406;
 Tue, 26 May 2026 07:15:35 -0700 (PDT)
Date: Tue, 26 May 2026 14:15:33 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAWrFWoC/5WNSw6CMBQAr2K69hla+0FX3sMYU+AVXgItKdhoC
 HcXSEx06XJmMTOxASPhwM67iUVMNFDwCxz3O1Y21tcIVC3MRCZ0poSAloqid9AGW0HqWvKPJxS
 jA/JQo7+vHiN0oUKQ0sj8KK2V2rAl2Ed09Nxm19vCDQ1jiK/tnfhqPxv5zyZx4KCdMo6fuDW2u tQh1C0eytCx9ZPEd1v/1RaQgTYqcypXp6LUP+15nt9wNRbpQQEAAA==
X-Change-Id: 20260522-libbpf-load-vmlinux-btf-in-gen_loader-mode-4474834aa467
X-Mailer: b4 0.14.3
Message-ID: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-0-5b4fa2a5e1a4@google.com>
Subject: [PATCH v3 0/3] libbpf: support STRUCT_OPS in light skeletons
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
Changes in v3:
- Remove erroneous change contracting map creation attribute size in gen_loader.
- Link to v2: https://lore.kernel.org/r/20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v2-0-6750f5859bc6@google.com

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

 tools/lib/bpf/gen_loader.c | 3 ++-
 tools/lib/bpf/libbpf.c     | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)
---
base-commit: c6e99c10fd9855082568cbd71bb2cc5dc90eda53
change-id: 20260522-libbpf-load-vmlinux-btf-in-gen_loader-mode-4474834aa467

Best regards,
-- 
Siddharth Nayyar <sidnayyar@google.com>

