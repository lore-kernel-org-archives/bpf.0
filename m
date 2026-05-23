Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC921CC51
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548373; cv=none; b=gmrUV42Ee4BDMGkURhtGiPp7Dd9VC2Uw9ws06lt0MspS1Z/poJ34/MHGbuQ3VLVu/8afAGqUZF/gAjXEOYH1pHuD/3ur/O/H3eaCi+C2B6YxREbL+rVJJubyIpGjwgcclAkftJxzrEk2ZQ9xMZQTiJfMby6RU/9qgF6VkEnN8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548373; c=relaxed/simple;
	bh=8HE0bJnamFwyh5V9mpIxXpqU0R2ZZLE5p2CXa+TFxzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mE3m48XtQUeWU7fEGZ/d3AjBCFZ0UWgL7zpk/zQ56rDSVeX3WxbnsVSzHCqrgSIoS/F97Jsq7Jylr+mmQyTrBjK4VnjpZbTabfiPawc3kWuiIhUdyjxEz1s1CteZKT3NSoUXrm9Od4hKZtMubbPdWvf4t7Zbr6XcboxEH9JKalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHDrKxnE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHDrKxnE"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso9544227a12.2
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779548371; x=1780153171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZp6q6YNwIbVEynY0+l9dzd26/SUvy3r3zvk5lEufXY=;
        b=HHDrKxnEkLsZsilcGpLqcAwB74xK7JPu3k+WaNaIbXhJsnNLe7ZdZx4wsP7XxZ0O/v
         bFYnLuoZaVXpvVJfyqOFqh+Wpqej9E/0N6MBbehKkk1pRvVB3XCTcLfHI5KXWD46RcfR
         ZnfuSM8IHL5wU4xNCF2/cUFVGUAmCRATOZd6skw76/48xhd69wRBnYDiYX3a4i9YG1F1
         XjVC5X5aTxQxqep5bSv6G9NQmEU6QnKicOlXWnL8yBPrtUbZF7/39ZHNWaLmCZa4N449
         F4VB2Ij/42Hr2XmTG4JY3GgqWEiwQxC7OAzS39N5/rLwwoIyCr1jjQKkMHbyEGGS1/QV
         2y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779548371; x=1780153171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZp6q6YNwIbVEynY0+l9dzd26/SUvy3r3zvk5lEufXY=;
        b=FWSTxhUGx7ilZwgtKk9R8VXbbuxRT5mIXZ9vUxsJGwuDOGF7yHulAoopZ54i8KHOR1
         fv36gYYictfIQU9I3CbXh1CIFmyqrcroRnrCyZk0ADh8KdnVEqqtF94i5cClHgkDSthx
         jjxowBJjSyNJ6SYoTsoA7xWObFD9uFsOw1A87cqSBZd3h60+7LhFqezWO0S5eSNZWudE
         z1tbHKc59RXwfG2yF6YWvOmgxZsx8TwtdENMePwSOokhsmOPgHPfskEJ7neQht0JuTgT
         1z0XMzLCexVD8VsXAr74QDszSaJlqWxUqQgMu0s38KGco+SY/1KiLIynjmvzBf+/hs2M
         B4UA==
X-Gm-Message-State: AOJu0YzYCyNq6AetTkbYXNbra5KWbzaF8TMZszgDUe69mYxg9MctfG9i
	V3lTxP8k78KqoUStORK5av3DhVZMqNdpI8g725L3Q/WEEaDD8rbqCFEPtAXXA7et
X-Gm-Gg: Acq92OFBeptjlTlXmFYC+oRgQrooTKRKbeq8c6TdwYH8q6CxQH728YRaKeNLAG1KcY8
	d+6P2I+4fcVImkLNcKa1iMs4FumiOGvTiMNsy+cHB21iPMS8ELO0CLi73AY3c4NL9oX+wk8LZr/
	f4Kz5RDmM5L54PdlXBBCMg6xxasxyVugt0iT2PLwpfhiiw6hAY/tLbTeDcMNuG2uXopI83Dao8D
	MK2mbHUaE+HeT1/aSNTiY+q9ZODrmckfRjNzABNVMjbfoURcJwRhUrQWT1YDxPOUmpd84LUlrHY
	7Q4mRcMp66gjHPvcdOCKd2F70YQcRfyb5U5+0N80t+oCb39y59CeLrZyM3Lz8ylBgv6B4FVDiK4
	UswQTTZfARF3GP+Z5zWBM+eNbfEPlwJ2tNbrafHiuDgUK9gqsDfZIaRcq6NRHTYgZ+JlPA/vMJd
	Z1s6JlJgnAphIAWDrKzT+2GEqVBgddimD724qRYDcTnfce+CiXjjp9YsNyTUqauS/CVj4SqwsWv
	wt5hHJGlsLEgFNxfsNqV8AvUtxs8usxslIMuk/NFIAy77LKOdwsBrkhaQ==
X-Received: by 2002:a05:6402:3217:b0:67b:4aab:1f10 with SMTP id 4fb4d7f45d1cf-6889c432ecdmr4117709a12.5.1779548370534;
        Sat, 23 May 2026 07:59:30 -0700 (PDT)
Received: from ast-mac (92-64-183-131.biz.kpn.net. [92.64.183.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688baf1eb98sm2039910a12.16.2026.05.23.07.59.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 23 May 2026 07:59:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [GIT PULL] BPF fixes for 7.1-rc5
Date: Sat, 23 May 2026 16:59:28 +0200
Message-ID: <20260523145928.46476-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 7dd62566e0d108d29034bcff8503b827f8763320:

  libbpf: fix off-by-one in emit_signature_match jump offset (2026-05-23 07:49:22 -0700)

----------------------------------------------------------------
- Fix bpf_throw() and global subprog combination (Kumar Kartikeya Dwivedi)

- Fix out of bounds access in BPF interpreter (Yazhou Tang)

- Fix potential out of bounds access in inner per-cpu array map
  (Guannan Wang)

- Reject NULL data/sig in bpf_verify_pkcs7_signature (KP Singh)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (2):
      Merge branch 'bpf-fix-call-offset-truncation-and-oob-read-in-bpf_patch_call_args'
      Merge branch 'fix-bpf_throw-global-subprogs-interaction'

Arnd Bergmann (1):
      bpf: make bpf_session_is_return() reference optional

Guannan Wang (1):
      bpf: Use array_map_meta_equal for percpu array inner map replacement

KP Singh (2):
      bpf: Reject NULL data/sig in bpf_verify_pkcs7_signature
      libbpf: fix off-by-one in emit_signature_match jump offset

Kumar Kartikeya Dwivedi (2):
      bpf: Check global subprog exception paths
      selftests/bpf: Cover global subprog exception leaks

Yazhou Tang (3):
      bpf: Fix out-of-bounds read in bpf_patch_call_args()
      bpf: Fix s16 truncation for large bpf-to-bpf call offsets
      selftests/bpf: Add test for large offset bpf-to-bpf call

 include/linux/bpf.h                                |  8 ++-
 include/linux/bpf_verifier.h                       |  2 +
 include/linux/filter.h                             |  3 -
 kernel/bpf/arraymap.c                              |  2 +-
 kernel/bpf/cfg.c                                   | 13 ++++-
 kernel/bpf/core.c                                  | 27 ++++++---
 kernel/bpf/fixups.c                                | 13 +++--
 kernel/bpf/helpers.c                               |  5 ++
 kernel/bpf/syscall.c                               | 26 +++++++++
 kernel/bpf/verifier.c                              | 27 +++++++--
 tools/lib/bpf/gen_loader.c                         |  3 +-
 .../selftests/bpf/prog_tests/kfunc_dynptr_param.c  |  2 +-
 .../bpf/prog_tests/percpu_array_inner_map.c        | 57 +++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  2 +
 .../testing/selftests/bpf/progs/exceptions_fail.c  | 22 ++++++++
 .../selftests/bpf/progs/verifier_call_large_imm.c  | 66 ++++++++++++++++++++++
 16 files changed, 251 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/percpu_array_inner_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_call_large_imm.c
