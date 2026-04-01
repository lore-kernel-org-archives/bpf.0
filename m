Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B21F46AF0A
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060136; cv=none; b=N3NZp4V6NTuqrOcqBTE4ozfflpx1hr/GsmshelzQQgdjnAbaVFAyM4iu8EpOlB+YiCKuDRJ1YjyTfASWE5xd7TafNlXD6vJxinJX6dZOX0vQGTq8q0UnKpx3Q4TlgAatDCx0xnjbpmio4qqQQx1iKIYtcb0uTZYvewas2LO7hL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060136; c=relaxed/simple;
	bh=39Oa2loJA7hp7uvZHKhwdxu0ZLV6qyUTOt1cn55M7w0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qXYAGjpTtU6C1PjowxDxBkSoYR/bUJrqOhVf/qZkYYL61MYjcWhgAsgjlmu10VyIyHeTmCEQB5I3DSlHBsW3CaEupJuhIUvWxwNT3dKJ4n/WgTYgr00mz1gZaDpNepVVoiOtd8muaqhPp/xw5dOwXIe01m+cmQmjBBdd9Ljs6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RnmoBVEM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RnmoBVEM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4888375f735so10254345e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775060133; x=1775664933; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVrOnlJE4y/6fgO3OqR7CiW+cGL6Q90xMJNV21DISQY=;
        b=RnmoBVEMwwZTTltuUDCol53d87HnI8mC56oYXW+kEfwt1UEKdEbz4XP9Wi4V4Gd0hm
         2saboE2rNXBAmTDNWOit2m84j+r4gIp+Vns0uQla5amoH8NUYsbCSMsQu372Fr9kQd2R
         z/X9oKXz/ALNexYZs8xR7U+ap8N0K7sd0DIDO8xoNXeL1Dy8Kr+mMADd0pa2OPiSUkQt
         EpvObWuvWKgHRbfU1AeK3wSOwpe4J+K1qmT+4p5B4+bUhEezFVIxUzl0X1K5gHUpAbgH
         GZ8iCzS0jbYPUXnd7JkppZgL9W7l/8i7C5Xria2TUhrH3Inqxp4pa9slMvUrw+bltJPk
         i+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060133; x=1775664933;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVrOnlJE4y/6fgO3OqR7CiW+cGL6Q90xMJNV21DISQY=;
        b=sHCL4PB895b/Fcu2KH7A7AjouojNjClln7H5t+cw2u5IgPd8aZKv+74yZquT7QoVxW
         TePlPujXOw73xTS2vwQWTkutz1adC12/JQ2RrJpVWnjwDO3uIU5FfVFlSe3QwpTsM8Dv
         cz5EXi3WHWWzlTPwmjUpkopneGe4IrIYJ99DafLnX4vJEn1esvTpUwn7gzbgdQNr90B/
         AuOk3bx9kDvNtbAX7AFg/74SlBNu0YzYGiSBrIoxEuUMXvrisOISvPDrBqInjQDKuzAx
         miycOHfIF3Eg3pk+xExZZh6K+yutx8ml4jzY9oGClCxbJocN7WNyuqs5DPWV1PZvm0L+
         2Jxw==
X-Gm-Message-State: AOJu0YxhJT2AjdyzdIttNCPP6CYEUd8uZ5NGi/VAENkl0NUV2tIQi0Cg
	kog7r85h9yfMnwC71jIrU089qHouvi2J861i2FEtWQ7/yKF6BOGyXcZ1jgEQ19n0W/4=
X-Gm-Gg: ATEYQzydDRYTNoQdJCthny8rZ7huP1KVNI4RmHIOK/WmWy3dQ9CLPu6v8TVW6pxFMLk
	rNdT+wo5pDVWaqGIlmB9vj2cr8DZ7/atYpKyrEoa8ZtvatvRpUcxrJWwUkRQP5uBGV8xSgiACYq
	NZGzRJES1lFpo++RM9ynPFmJte5/TszvqbpIpkLjQYUSVnlrYO63LtsGaNyOtnd6Gr6X967+7YY
	jd7wOhoN7okUsngIr9SAF1FUrpNHHzkpAaYrqO4TIqiPb0aYbl8Kpj7E66WUrAiiJr8/UkvfyhC
	+dhDGgLWH6ERszNWLI0qLkexMjA+5kRm2I5mA5xRm+1tsUkVxVpHLW5WZlRZPWYwZ2VHwdV4h53
	3GNcWqNORtjJlNfFbm3I8UjmAOW8wP9K0/ZRWEYzk6E4nCs3XN/vMJgVUdNLONqDIrSgcruRcpB
	nd1XBQZe6K
X-Received: by 2002:a05:600c:8b08:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-48883572159mr70556245e9.9.1775060132990;
        Wed, 01 Apr 2026 09:15:32 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9ba81b53sm13782e0c.4.2026.04.01.09.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:15:31 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH 00/10] selftests/bpf: Tolerate partial builds across kernel
 configs
Date: Wed, 01 Apr 2026 13:15:07 -0300
Message-Id: <20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAItEzWkC/yWMSw6DMAwFr4K8rtXwXfQqVYUS44CrElCcVkiIu
 ze0y3l6MzsoR2GFW7FD5I+oLCFDeSmAJhtGRhkyQ2WqzjSmROWXT6xJ0a2+n0VpCV5GbKiu2bf
 UdoOFbK+RvWy/8v3xZ327J1M6c+fDWWV00QaazinnMPCWrrPVxBGO4ws6B3YEnQAAAA==
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775060128; l=3207;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=39Oa2loJA7hp7uvZHKhwdxu0ZLV6qyUTOt1cn55M7w0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE5dIUSreOCoDYxhzPTEq3DJLb2+vGdSKNAVzISqlkYZVoHLRq6mwXKx0oQ44AaKNqx2hIvqJzb
 LJUWjO0NHigw=
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
Ricardo B. Marlière (10):
      selftests/bpf: Fall back to distro build directory for test_kmods
      selftests/bpf: Tolerate BPF and skeleton generation failures
      selftests/bpf: Avoid rebuilds when running emit_tests
      selftests/bpf: Make skeleton headers order-only prerequisites of .test.d
      selftests/bpf: Tolerate test file compilation failures
      selftests/bpf: Allow test_progs to link with a partial object set
      selftests/bpf: Tolerate benchmark build failures
      selftests/bpf: Provide weak definitions for cross-test uprobe functions
      selftests/bpf: Skip tests whose objects were not built
      selftests/bpf: Tolerate missing files during install

 tools/testing/selftests/bpf/Makefile               | 107 ++++++++++++++-------
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c  |  11 ++-
 tools/testing/selftests/bpf/test_kmods/Makefile    |   6 +-
 tools/testing/selftests/bpf/test_progs.c           |   7 +-
 4 files changed, 88 insertions(+), 43 deletions(-)
---
base-commit: 0eeb0094ba0321f0927806857b5f01c1577bc245
change-id: 20260401-selftests-bpf_misconfig-4c33ef5c56da

Best regards,
--  
Ricardo B. Marlière <rbm@suse.com>

