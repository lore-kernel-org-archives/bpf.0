Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9D3C5524
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228353; cv=none; b=NeMt0UqnYaOmKsKnnnn35hkB4+T9E7Zr3DIeoEf4cJNGPvKT+rUHlYwuQws5VdpGNz6eRwLtizskJ/NTKAoAhxKiKTZSdXBZfEBldaaAl/SrZ4n3HjmX+pq3Va0RCLSIfQsxxobOQycjM2gTC/6zlySYUKUsi4+EvPaIRtyTWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228353; c=relaxed/simple;
	bh=89ji6KrXytsoyroMrXYgsYDJJAfuNLm0CiKJEhTy/wQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RxMO0l4TNbiD3AhACQgCEPJKf+rUkcH48KCzJVxLK8eBJe5x+dsy3bRtwW1F13VBCi8FkBRsRv8IdgMg9yqpnLDRcIL53Gf+EI+3DJfC7wixnVkNAe9T85n9FS0BSe60/yv04IH506nn4F/m0S7Tar12n+oIgmhGZ+fhQL2n3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B55YuYen; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B55YuYen"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486ff201041so19506715e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775228349; x=1775833149; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H+OgrwFlApvpqkLRR93ZwtakkLIUZgZQlxVrJ4qAo4U=;
        b=B55YuYenvg/+tnPpXdJS9gEtYREoR+eui7WCUdyVKpiFGF2Ib6T7YYsD/C8BVNws5j
         4nrUK8ywH3z504cL5hmSXMSHapRp5YLadxpv5e4XFEwlXuE/ia29D4H7mwuuE1eD7cuX
         l1FBXdthOsMEjvpjUpzy9zmxSmLF9PfsRhfzIQBy680tav0otNGblKJGrpEocJZnleGF
         GkHVCMVu6hw/dMdZg7t3t9ZpJwymIcBbPIF7F0jgsWlNJFEXOl7/q8gWFfcEWo53HDuv
         9iYUPDr4vXhGm3yxUtTvpf3xwc+RIXUMA0T06AHLUpaAlYqSvDqpyO1v9HP6gsRRUN+k
         OyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228349; x=1775833149;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+OgrwFlApvpqkLRR93ZwtakkLIUZgZQlxVrJ4qAo4U=;
        b=XwpgJYrZaBjvfI6q73ktqyocB+TkGwDBBIMR3kwCbkrcm/X1o7XaYB98MkGXdy+ytY
         6AUCfexHGsEOPTE+buxSPfNtyr1VBqCAZ+W2j3uAi+GsYmavxxRFhUFN6pkHA4gdzKb7
         p7yceFIiVm/uEulo0Lp13Q6x7AWowhpa4UPG2tDZ+n2AygnsAdPIq1FwoNcyw1nm5KSe
         oTEMMVGemUwkT1GyAWBQBSDTJ6ydWZQ1kF+PMZ/C2ZdXtsNCWClCVq4YO7+9EPy9lk8K
         N2R9CMypUJCHxy70KCbJouIG0D69XZQPDIhKjlnDZk4RJZtVcJxMcuL32ag5WlexEDP7
         oMLQ==
X-Gm-Message-State: AOJu0YwYMJKSJL6kkU3RttVEerzjQAJhHA26pMMBYo7C0eDEdDVGO3XO
	xmljNLqWOZdj5SuRQrbxTdeerCFD+eF3+unZZ4hEEQ2LiQRSXJshQKlhu70VeRvdHEA=
X-Gm-Gg: ATEYQzz8j+JCtQmljG3fL7vu3mvJ9v0hOiU+ZW8oBmh+WlT1+tmYO3TK3laWo48ILA8
	tvsbxzqQIvZTRmwMJQGN/gMATKfphQqS6tcjfIg86aHDrmWNFaNQcZW4uy7ITxujXInWdR/fQL6
	RThMZbOAalg1C5rI5pQALRpyd/hkPLNphpd7c6TMQ+JaKeA2Ygkz/Lb2DMh9ID7KZfr/4oxLgPy
	rGuOuflT4Pak/VQFHNS4Ly/Bb2mHB5BtlsHi6YOB3bk3MMpvfY96Wp6RmP9vQd1V7A6XvIx2HBI
	53efF6RNjFBrdEoL434EgFejRsgxTZQLot1oHkLBboFPh6cXlb/ekK73vYqZ6iNPE9+U2990bU9
	zF3T8iJ+FOsTgSxsWnvSzM+nm/I6xjdacxIzhLMty9bcQBbM2lalq7jKshMG87r98rJr9HZmwoN
	OT+pXmqH89
X-Received: by 2002:a05:600c:3e83:b0:485:2fc5:3a5 with SMTP id 5b1f17b1804b1-488997bd938mr55388085e9.26.1775228348640;
        Fri, 03 Apr 2026 07:59:08 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bc9bc41sm6877313e0c.11.2026.04.03.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:59:07 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH v2 00/10] selftests/bpf: Tolerate partial builds across
 kernel configs
Date: Fri, 03 Apr 2026 11:58:53 -0300
Message-Id: <20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK7Vz2kC/4WOWw6CMBREt0L67dVSHiZ+uQ9DTCm3UCMt6S0EQ
 9i7LS7AzzOZOZmNEXqDxG7ZxjwuhoyzEcQpY2qQtkcwXWQmuKh5yXMgfOuAFAjaST9HQ8pZbXo
 oVVGgrlRVd5LF9eRRm/UwP5of09y+UIWkS41WEkLrpVVDiqIOLK7hMkoK6FNjMBSc/xznljyZ/
 v9YcuBQSCyF4lJfa32nmfCs3Miafd+/mh4j1vEAAAA=
X-Change-ID: 20260401-selftests-bpf_misconfig-4c33ef5c56da
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775228344; l=3685;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=89ji6KrXytsoyroMrXYgsYDJJAfuNLm0CiKJEhTy/wQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOX84k2QeUwuO8dcrNzMtD1XuDwQUFz8m1vv5l9tXa8jO8hI0wgfABLN8BJzTmBx68QP3xhU36b
 527bSAbwGbg0=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Currently the BPF selftests can only be built by using the minimum kernel
configuration defined in tools/testing/selftests/bpf/config*. This poses a
problem in distribution kernels that may have some of the flags disabled or
set as module. For example, we have been running the tests regularly in
openSUSE Tumbleweed [1] [2] but to work around this fact we created a
special package [3] that build the tests against an auxiliary vmlinux with
the BPF Kconfig. We keep a list of known issues that may happen due to,
amongst other things, configuration mismatches [4] [5].

The maintenance of this package is far from ideal, especially for
enterprise kernels. The goal of this series is to enable the common usecase
of running the following in any system:

```sh
make -C tools/testing/selftests install \
        SKIP_TARGETS= \
        TARGETS=bpf \
        O=/lib/modules/$(uname -r)/build
```

As an example, the following script targeting a minimal config can be used
for testing:

```sh
make defconfig
scripts/config --file .config \
               --enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
               --enable DEBUG_INFO_BTF \
               --enable BPF_SYSCALL \
               --enable BPF_JIT
make olddefconfig
make -j$(nproc)
make -j$(nproc) -C tools/testing/selftests SKIP_TARGETS= TARGETS=bpf install
```

This produces a test_progs binary with 579 subtests, against the total of
708. Many of them will still fail or be skipped at runtime due to lack of
symbols, but at least there will be a clear way of building the tests.

[1]: https://openqa.opensuse.org/tests/5811715
[2]: https://openqa.opensuse.org/tests/5811730
[3]: https://src.opensuse.org/rmarliere/kselftests
[4]: https://github.com/openSUSE/kernel-qe/blob/main/kselftests_known_issues.yaml
[5]: https://openqa.opensuse.org/tests/5811730/logfile?filename=run_kselftests-config_mismatches.txt

Assisted-by: {codex,claude}
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Changes in v2:
- Skip test_kmods build/clean when KDIR directory does not exist
- Use `Module.symvers` instead of `.config` for in-tree detection
- Fix skeleton order-only prereqs commit message
- Guard BTFIDS step when .test.o is absent
- Add `__weak stack_mprotect()` stubs in `bpf_cookie.c` and `iters.c`
- Link to v1: https://patch.msgid.link/20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com

---
Ricardo B. Marlière (10):
      selftests/bpf: Fall back to distro build directory for test_kmods
      selftests/bpf: Tolerate BPF and skeleton generation failures
      selftests/bpf: Avoid rebuilds when running emit_tests
      selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
      selftests/bpf: Tolerate test file compilation failures
      selftests/bpf: Allow test_progs to link with a partial object set
      selftests/bpf: Tolerate benchmark build failures
      selftests/bpf: Provide weak definitions for cross-test functions
      selftests/bpf: Skip tests whose objects were not built
      selftests/bpf: Tolerate missing files during install

 tools/testing/selftests/bpf/Makefile               | 111 ++++++++++++++-------
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  20 +++-
 tools/testing/selftests/bpf/prog_tests/iters.c     |  10 +-
 tools/testing/selftests/bpf/test_kmods/Makefile    |   8 +-
 tools/testing/selftests/bpf/test_progs.c           |   7 +-
 5 files changed, 110 insertions(+), 46 deletions(-)
---
base-commit: 6f6c794d0ff05dab1fa4677f39043de8a6a80da3
change-id: 20260401-selftests-bpf_misconfig-4c33ef5c56da

Best regards,
--  
Ricardo B. Marlière <rbm@suse.com>

