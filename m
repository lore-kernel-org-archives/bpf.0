Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F681E520
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721945; cv=none; b=AtdislA7H+WuRZz4KDhyb/Hi7csr1VObiO7g9baqOya7zK+mv9fMhbPrHZmTWFZBhuuAdPtkj4su+MFDkxTvQLtZFewW9W/9b+NluSzKDl8/sn4rMzo1y73dfed7WGSd7uA600P3cjAXJmmyrnZqnvPUpSHY19Utjx/5KUIyuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721945; c=relaxed/simple;
	bh=U87TNY7HbsaFQxTmP7VYiuko/cvo7T0fCU9aD020Ohw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqkBddcSF92o4RqIeZ1m6Zx11kLPFRw5sOTKlVkKWihb508crAEpU4BU5IdMd1idPCAHNNL8H6B+OswGXcuuz59AcWkW/0JFV3etYuphzjSSXfBuRlGpmQ9gbMGeC9leg1hydtu0QawHaoNcxuuKp0h8R0VMf0Sj8bR6/jF6/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZPOhmLP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZPOhmLP"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso9959379a12.2
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721941; x=1710326741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ju4a7sCPtaUL8pViNsV0XlaBnE84TGSWLxs6Jftdvg=;
        b=gZPOhmLPooMahaQYsh9W05pa+/woNYIf1JlPQzcIukb1ikyY7Dz12mp+gF0FLleJyU
         PfnKELpn8Epbgnab1oEcTQsTrkGLisyIz6IbDEkLwRQ9CVWuHKGxbCyxBwrgfT4tnYNv
         ioSOyGAG/z6Zu/hDbLYwqXzZNhFerQLrbvFrrxb3xhr64tCGsWv8uqoN9A/HCgnHvS0J
         LOeqIeSqNqHKT2jGJTEpfcWEA5rCSvlII2W0hd9V1r9eqEmigiI4g40nc5qZtuYlZ62F
         ahB0hdP0WDu9LpOUBQjHt2PeEYmIUpQ3mq68HU+sAuWIoirAq5Sf6JeDdJ0XssxQXFt8
         2o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721941; x=1710326741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ju4a7sCPtaUL8pViNsV0XlaBnE84TGSWLxs6Jftdvg=;
        b=nBQwXcHfUgJitM7wnp6GEklqYopNXh1MfQd/02Npk4Qd8FkLRtCuHiW4wfuXMtrX87
         v/iP9Jd5z4Dk+ZZG9PVJzdKmaQBW6ZsEn6VfaR9XzDMRH2xC1LPqgBePdzXraCGU9Tcy
         TsrN8rOhcr49u7lTb4F8t4juzvvpa/lDPUK3MxhgC9Bud9l6GlwjLl443rPo8tkIs9S9
         b6CUcKT7OTz0C3XBvz77caJq38JNCh8yW/dXElb46mFuC+25RZ5RPZkUVaQFfseVVpBS
         LsUjotJmMtcmadWGgY9uC0nvzQVlQly+p7a0WkDipWfiPXPd3yjZoTewsZQhWvMVF0Bb
         e24g==
X-Gm-Message-State: AOJu0YzYcY1tfYN+33c7tNr7l4rQ54EgbSdYcam0N1lBWIeLiUDY2N39
	Q3ppEz9kCHBl6TkU09wgFH9czVC7ad8cfzZsVIWzMhGXIWiPhTubgTQJqbID
X-Google-Smtp-Source: AGHT+IFkod9VKwFXymDHWbBMRYzEY50NGsXj9swgdr6bDB+FhCXN62757Yx/2uEmlRKGdy9r0hHRxA==
X-Received: by 2002:a17:907:20b9:b0:a43:e550:4067 with SMTP id pw25-20020a17090720b900b00a43e5504067mr8909609ejb.12.1709721940357;
        Wed, 06 Mar 2024 02:45:40 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:39 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 00/15] libbpf: type suffixes and autocreate flag for struct_ops maps
Date: Wed,  6 Mar 2024 12:45:14 +0200
Message-ID: <20240306104529.6453-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tweak struct_ops related APIs to allow the following features:
- specify version suffixes for stuct_ops map types;
- share same BPF program between several map definitions with
  different local BTF types, assuming only maps with same
  kernel BTF type would be selected for load;
- toggle autocreate flag for struct_ops maps;
- automatically toggle autoload for struct_ops programs referenced
  from struct_ops maps, depending on autocreate status of the
  corresponding map;
- use SEC("?.struct_ops") and SEC("?.struct_ops.link")
  to define struct_ops maps with autocreate == false after object open.

This would allow loading programs like below:

    SEC("struct_ops/foo") int BPF_PROG(foo) { ... }
    SEC("struct_ops/bar") int BPF_PROG(bar) { ... }

    struct bpf_testmod_ops___v1 {
        int (*foo)(void);
    };

    struct bpf_testmod_ops___v2 {
        int (*foo)(void);
        int (*bar)(void);
    };

    /* Assume kernel type name to be 'test_ops' */
    SEC(".struct_ops.link")
    struct test_ops___v1 map_v1 = {
        /* Program 'foo' shared by maps with
         * different local BTF type
         */
        .foo = (void *)foo
    };

    SEC(".struct_ops.link")
    struct test_ops___v2 map_v2 = {
        .foo = (void *)foo,
        .bar = (void *)bar
    };

Assuming the following tweaks are done before loading:

    /* to load v1 */
    bpf_map__set_autocreate(skel->maps.map_v1, true);
    bpf_map__set_autocreate(skel->maps.map_v2, false);

    /* to load v2 */
    bpf_map__set_autocreate(skel->maps.map_v1, false);
    bpf_map__set_autocreate(skel->maps.map_v2, true);

Patch #8 ties autocreate and autoload flags for struct_ops maps and
programs.

Changelog:
- v3 [3] -> v4:
  - changes for multiple styling suggestions from Andrii;
  - patch #5: libbpf log capture now happens for LIBBPF_INFO and
    LIBBPF_WARN messages and does not depend on verbosity flags
    (Andrii);
  - patch #6: fixed runtime crash caused by conflict with newly added
    test case struct_ops_multi_pages;
  - patch #7: fixed free of possibly uninitialized pointer (Daniel)
  - patch #8: simpler algorithm to detect which programs to autoload
    (Andrii);
  - patch #9: added assertions for autoload flag after object load
    (Andrii);
  - patch #12: DATASEC name rewrite in libbpf is now done inplace, no
    new strings added to BTF (Andrii);
  - patch #14: allow any printable characters in DATASEC names when
    kernel validates BTF (Andrii)
- v2 [2] -> v3:
  - moved patch #8 logic to be fully done on load
    (requested by Andrii in offlist discussion);
  - in patch #9 added test case for shadow vars and
    autocreate/autoload interaction.
- v1 [1] -> v2:
  - fixed memory leak in patch #1 (Kui-Feng);
  - improved error messages in patch #2 (Martin, Andrii);
  - in bad_struct_ops selftest from patch #6 added .test_2
    map member setup (David);
  - added utility functions to capture libbpf log from selftests (David)
  - in selftests replaced usage of ...__open_and_load by separate
    calls to ..._open() and ..._load() (Andrii);
  - removed serial_... in selftest definitions (Andrii);
  - improved comments in selftest struct_ops_autocreate
    from patch #7 (David);
  - removed autoload toggling logic incompatible with shadow variables
    from bpf_map__set_autocreate(), instead struct_ops programs
    autoload property is computed at struct_ops maps load phase,
    see patch #8 (Kui-Feng, Martin, Andrii);
  - added support for SEC("?.struct_ops") and SEC("?.struct_ops.link")
    (Andrii).

[1] https://lore.kernel.org/bpf/20240227204556.17524-1-eddyz87@gmail.com/
[2] https://lore.kernel.org/bpf/20240302011920.15302-1-eddyz87@gmail.com/
[3] https://lore.kernel.org/bpf/20240304225156.24765-1-eddyz87@gmail.com/

Eduard Zingerman (15):
  libbpf: allow version suffixes (___smth) for struct_ops types
  libbpf: tie struct_ops programs to kernel BTF ids, not to local ids
  libbpf: honor autocreate flag for struct_ops maps
  selftests/bpf: test struct_ops map definition with type suffix
  selftests/bpf: utility functions to capture libbpf log in test_progs
  selftests/bpf: bad_struct_ops test
  selftests/bpf: test autocreate behavior for struct_ops maps
  libbpf: sync progs autoload with maps autocreate for struct_ops maps
  selftests/bpf: verify struct_ops autoload/autocreate sync
  libbpf: replace elf_state->st_ops_* fields with SEC_ST_OPS sec_type
  libbpf: struct_ops in SEC("?.struct_ops") / SEC("?.struct_ops.link")
  libbpf: rewrite btf datasec names starting from '?'
  selftests/bpf: test case for SEC("?.struct_ops")
  bpf: allow all printable characters in BTF DATASEC names
  selftests/bpf: test cases for '?' in BTF names

 kernel/bpf/btf.c                              |  16 +-
 tools/lib/bpf/features.c                      |  22 ++
 tools/lib/bpf/libbpf.c                        | 209 +++++++++++++-----
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  26 +++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   4 +
 .../selftests/bpf/prog_tests/bad_struct_ops.c |  67 ++++++
 tools/testing/selftests/bpf/prog_tests/btf.c  |  29 +++
 .../bpf/prog_tests/struct_ops_autocreate.c    | 159 +++++++++++++
 .../bpf/prog_tests/test_struct_ops_module.c   |  33 ++-
 .../selftests/bpf/progs/bad_struct_ops.c      |  25 +++
 .../selftests/bpf/progs/bad_struct_ops2.c     |  14 ++
 .../bpf/progs/struct_ops_autocreate.c         |  52 +++++
 .../bpf/progs/struct_ops_autocreate2.c        |  32 +++
 .../selftests/bpf/progs/struct_ops_module.c   |  21 +-
 tools/testing/selftests/bpf/test_progs.c      |  59 +++++
 tools/testing/selftests/bpf/test_progs.h      |   3 +
 17 files changed, 704 insertions(+), 69 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops2.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c

-- 
2.43.0

