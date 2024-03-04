Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D4482DA
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592730; cv=none; b=idUwsu59XJ+MtawPYycDIXzPYdTPg3qwQEgONN/XkktO78A8bTkwBTKjPLW1d7ttVC05T+StxpSwYMyYTJJRwkuh6GiQOyqJxNLNbEB/bpNiq7cbJ4Y5uptvYP91s4/2mZ+ZnEcUFZRbDDwNKIehigUgJO7MOh7knawArWD1vgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592730; c=relaxed/simple;
	bh=tGyxFFVubyD0qjnMf66FSRn3FfCIo44OdC7fj9MMl2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZeA+t96P8fR3RNfra7dGqzFXjNZX3Tt9tCcNXP14xWqIcfdzcxGE5IKmZ0SYLwI6od/L4eVUL9mBfPuy/+aHaHvEHvAk5s/Q6OHXN3wb4BzwbuW4yBmvFw1VQSiTptWgxaIuyRrZrbecvEyPsSF280ssgoE4J0v2kydS/ymsXo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caWISg6X; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caWISg6X"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3122b70439so6601066b.3
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592727; x=1710197527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=skJL8NqKMD/LbVbFun+IAodyjd2kb2lQNomsbn2wZF4=;
        b=caWISg6XAJgN3Pp+tZtFGEQdtYxtDH3MAEh2y4Kusc3JO+c2zfOjGb4rbmTH1X6fL9
         rOzWnDYEnBossjbszsBTEflvSZWl8W4zSLotUvT9Y6EUvjinM7D3TNm0/ipN1wAHlRDH
         QhxdpQ0QJniLLDaulas5yo8D4uVmSknwOIRZ9o2c2Onnxaxg/y13rbTAlRkhvBWhTH42
         uHJutFg5J53rHmt0Q6dKL506GIxnxLiLMu9xAnLfXpo9zlH15QuhfCfhVRaJXitMvyeL
         tmWFKjroAG5KLFxQc+LCEunKm0ki7/97jRoc0rY3gF5E1kReF41tu6TZVDSRPaA4KVVT
         MRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592727; x=1710197527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skJL8NqKMD/LbVbFun+IAodyjd2kb2lQNomsbn2wZF4=;
        b=sP2oHuGWv06SXI9ygjeC19PARXNWkdi04IZMis8fpC2rUHAO//k/gGFfJO98qJC7Tb
         47epXR0LtLyxclvy2vZ+IAuI3dIOIHymasgeecghd795WciAuym1UV/ys3YkD2UCJK54
         zVCr+5At4z+6FfmKKmYaahr/lAQQMcVkRqNsjRPFj3TQ4E72XHIbMqqeb5THek71u1Dz
         jNZjqs6iOO63sH4Vnxgf5VshsDqzwZvCBwR3E7+EhaLAbk5FaH/U0RinrsNcmU2H142w
         yn91HxhTpf7vn8Mu4WajufVHRTbqPZb3l+mIAHAx9RpQA5X8lRvk/Nmj/8zRu2N3MeiQ
         I8aw==
X-Gm-Message-State: AOJu0YzoRg6SZ577nsaGzHmEGzCZWOsARXtXo+kMp790C+XX/LcM+ysB
	wz3Z/B3rVxDZ3JzMV6IAE9nNsD9+MpXOmWIxOlVUsIaaKfc5LpVs7QOmlped
X-Google-Smtp-Source: AGHT+IFlN2PIvZyrQfINzU4gyMWjCB+QZaWS9q6upsG8ED1V44xbl0OBECVuSPJYP+v7/uRZ5n7dxw==
X-Received: by 2002:a17:906:2e92:b0:a45:6b65:f6cb with SMTP id o18-20020a1709062e9200b00a456b65f6cbmr2114848eji.26.1709592726251;
        Mon, 04 Mar 2024 14:52:06 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:05 -0800 (PST)
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
Subject: [PATCH bpf-next v3 00/15] libbpf: type suffixes and autocreate flag for struct_ops maps
Date: Tue,  5 Mar 2024 00:51:41 +0200
Message-ID: <20240304225156.24765-1-eddyz87@gmail.com>
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
  libbpf: struct_ops in SEC("?.struct_ops") and SEC("?.struct_ops.link")
  libbpf: rewrite btf datasec names starting from '?'
  selftests/bpf: test case for SEC("?.struct_ops")
  bpf: allow '?' at the beginning of DATASEC names
  selftests/bpf: test cases for '?' in BTF names

 kernel/bpf/btf.c                              |  17 +-
 tools/lib/bpf/features.c                      |  22 ++
 tools/lib/bpf/libbpf.c                        | 214 +++++++++++++-----
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  25 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   4 +
 .../selftests/bpf/prog_tests/bad_struct_ops.c |  67 ++++++
 tools/testing/selftests/bpf/prog_tests/btf.c  |  46 ++++
 .../bpf/prog_tests/struct_ops_autocreate.c    | 157 +++++++++++++
 .../bpf/prog_tests/test_struct_ops_module.c   |  33 ++-
 .../selftests/bpf/progs/bad_struct_ops.c      |  25 ++
 .../selftests/bpf/progs/bad_struct_ops2.c     |  14 ++
 .../bpf/progs/struct_ops_autocreate.c         |  52 +++++
 .../bpf/progs/struct_ops_autocreate2.c        |  32 +++
 .../selftests/bpf/progs/struct_ops_module.c   |  21 +-
 tools/testing/selftests/bpf/test_progs.c      |  57 +++++
 tools/testing/selftests/bpf/test_progs.h      |   3 +
 17 files changed, 717 insertions(+), 74 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops2.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c

-- 
2.43.0

