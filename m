Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84723D281
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780188506; cv=none; b=H5W0PWjXTT99WXaPzD7r3JGhRfpxtcQ5bddJTfEjHpEifRnQxONOH1x9mR9OQtW/35XkrmNjooeb5NrlxAIl7KxQTg4KPQTd0yGVmpu+W8noPnc4qY9PyKzyoNJXR2Eo4sxGfeRw3I2kt0+WK8ZpcHrhOetaJGOUrj3uL/NK+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780188506; c=relaxed/simple;
	bh=JE+XeIKTsotTh/xcFii2dHnI072msL/Mkm3HQLAo1nM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qf1LC3/9cjtjqA/Hw/N5RSapkJF2RkQl3p2vSsn2o/f2SsQ04hGI25aVFKbLFX8MsjayJ1/CS/P13qQUIsvz20LvejHeCzpC28IL95df0kyjzfDH6YV+RBf3k7fznsWGfk+JgnNiXcUbqf0ygw7IMlSEUwLcTxkNY5a/wcqKCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkWmnJwp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkWmnJwp"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c1e112dfso1905885ad.0
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 17:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780188503; x=1780793303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m9llWaUyY0QX+uCte5zZE9wTjpV+Ud2qZ4TJwZ1Uj1c=;
        b=XkWmnJwpXTNOLwm9uo6m+wyaANURz/Xi6Za9LQqmxzDCuuXpsDp20nNbmMld6I5Jre
         6jI7WjcRQVbnAJV3CGUsUIICYq2RIh+ciMM2M+F5Fu48eGS4ZiHZP44lB1lizBAydBBO
         Jj9H3Wdz2/i33KNtFrSmRGa/kWL6EVVu0FHhQ76NII+9O3hzLxfEiASERtGbUDjKRzSe
         hWjTur64W/gKyJyCpbXknLHtI9t82UyLY7pl/m+U/tnzeNcGdOoM6iHfGQ/1UZdsKNnN
         /JVwisH9wSUwq4yYe8nA6meCvhyFBngBw2N9D978bb840hDIHstzoJI2+cGG0PamoqgP
         Fx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780188503; x=1780793303;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9llWaUyY0QX+uCte5zZE9wTjpV+Ud2qZ4TJwZ1Uj1c=;
        b=m09e3rmChqEbvDoI675mzr4FnIpQ5MTcQHeG8MP2B1p9dlsvKdeYsuSgLr280+N3k/
         NNCbMR8QgDQAhPZDr3MCmKsKmrZ5LnNV7s+7c9cUO/aZlXj0QYZyv35ZcQySJzV+dhxN
         JomUQNk4Dtssqk40mFtt8+nq5KFanIMwYGKluO2fBodZsDY3QgzbWxHEuYEOUqD+YcTX
         BeaCErbAbJJc53Qod0vyYfmfTsC0+7NI/DWrb/U/kVybfmMZ2i/5TbcYeRABOpuZUb0m
         ZPxlOJvWQf60c/gmmyxl8PfO38nptfypngVMrFeCxpGgVHCabL9WMXbuxnjQyVCLzjMh
         CTbg==
X-Forwarded-Encrypted: i=1; AFNElJ9FQRLoQMV6Gf6sEfreKgeA10Zc+M4QNhMJlO4Jz886iBQEXjiZqPZMFRyM+nyGj8qD80E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3LCzyJFpd+NtGM0sVztXF2OPaHTmUzXbkm6SERuM5KNxpxAE
	YDy5Zg5USgu2WS2iRUWfdVoJIrFjMtxKgGJXa9Bwu02IPzjHZPMZqJN9D5pDstFU6WkpRlMfnB0
	geY3v+yzDn+aswBG7Z1/LNMMupg==
X-Received: from plav20.prod.google.com ([2002:a17:902:f0d4:b0:2bf:1a98:5111])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c40d:b0:2bf:1778:88c4 with SMTP id d9443c01a7336-2bf368287bemr64886895ad.21.1780188502634;
 Sat, 30 May 2026 17:48:22 -0700 (PDT)
Date: Sun, 31 May 2026 08:47:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531004748.3567875-1-yuyanghuang@google.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Align syscall writeback behavior with
 user-declared size
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series addresses an out-of-bounds write regression in BPF_PROG_QUERY.
Based on upstream feedback, we simplified the fix by checking the size only
in the front-gate bpf_prog_query() function and returning -EFAULT.

Changes since v1:
- Simplify the kernel fix to checking the size only in bpf_prog_query().
- Revert all other subsystem query plumbing changes.
- Update BPF selftest to target BPF_CGROUP_INET_INGRESS cgroup query, and
  add verification for attr size boundaries.

Yuyang Huang (2):
  bpf: reject BPF_PROG_QUERY with short uattr size
  selftests/bpf: add verification for BPF_PROG_QUERY attr size
    boundaries

 kernel/bpf/syscall.c                          |  6 +-
 .../selftests/bpf/prog_tests/bpf_attr_size.c  | 65 +++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c

-- 
2.54.0.823.g6e5bcc1fc9-goog

