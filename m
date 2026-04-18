Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA12BE7AB
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776532625; cv=none; b=NLzouyJmxHFCOcO6NXy2PqioezYSq7ZqCU4MxyN9dcqIRu/gDpIVECUrg5pc7ktfohi7fd3UrF081uJArR43m3GQX+HJ2gS6E7JJxiiY3h14re4kubXxNQxyMoXDGkGHB8JLUmUzM9oHgnhxAUrtJCm7EkL8Y+ljEARYRYJeaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776532625; c=relaxed/simple;
	bh=p9MFfZgnK951TYx7pyfQJD0PNZxLWlqhIB0nEfB6Vdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9/R2nie4Nqm4yxnw/gTFYUGBxPooYcOWmLBbsSCL7O07gYLmfPqa28NC7iuOrAPw+x/vWbYoh28u58URz0lIYTUUILtIXSltvvvCforMGOQRid7Mb/pkutvpmcQi/b091urHJoayeU1VADWR/KOx4MQR9CkXnIh8Ciy0vwMsM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZEcsG7j; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZEcsG7j"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d9e22176a7so958735a34.1
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776532622; x=1777137422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iE29ggsoKuLZxlrbhimxoIwFR9qI0zjmXRCa6tZJ2Y=;
        b=TZEcsG7jZ6HRcYbQ4f8CCJKLQE+YfqOeCOxUv6ozX9NiAp9fLv9AAvZ6WnvmEaf538
         4BTehS+vImUGVXQnpuEi1g2ynsgRke5XYRD8eFcnyw1OLOrFkNwyN8ENzK1tIxemW++m
         IVxqrmFxc7ZCi9wGZrfwuvr2ZaIVSA7fS7xt91em70nRzgQtW2d3Xc91BLEIAaD0bPHH
         d8Bd60AIs15q3eWaZpbp3lSytk0GOF712X6FO+ccmW6Rp7DMDxRIR7ClG7jpFb2fIDsM
         +mTmat4tGF7aICq9opKpMj0cAG5eVlItejslJmlCk7+M4hclS/4MnQGeN+iutYhqap5q
         zZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776532622; x=1777137422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iE29ggsoKuLZxlrbhimxoIwFR9qI0zjmXRCa6tZJ2Y=;
        b=WCBupyRpGKzeNTsyRGNK8mKe7da/OmatxzrSqhhRF7FsPJBwK8jf5qBELZsG3H9P1z
         jXX97bvt0220af68o6uusw0qckGxeCgiu+JdBQue+pM0BYDP+LQ0dJUJU7fcXYE/tYyY
         jkdf8z7GQqyaHlanUSFaYRVTYKgpaN6IGXFLpGcKkWuzPkwx7T4pmm1idfxkRukoFdtZ
         mxhtrqdhpZe8Ukzu+SMKWOdNCBl2QRP0U7+gKoMqSnXvA+nEZbPMszotn+QMWHrQW0BV
         +A6WCyNtPn+n5o9WXuiCnX901QRUejyo2EMDbtq/3RnjvjHieFEDZwIyxvwamZDvjB8X
         k7PA==
X-Gm-Message-State: AOJu0Yx8iqFWUk5/DxB3XBNrqy8uuGhLpJjxAJIhv0CMoS1tBj6iEn1t
	6GZhenSxcmuJmPE+TcdGbOikxU/ya5g9nw+X5En0VHU/NBF9b0FNB2ekRIGaLm5al2I=
X-Gm-Gg: AeBDieuuiURCPATPu8bMlK04rdtmO9PqryYwxevln2baeTuLKmsnii65gJyEufMrLwN
	pcL0qHTOVDgdW/B+97zOBeX/GlrRUBD5XhXWliKnl5k4owgaR3NlDJXXDv8Bw3ypw18jGNEjZ01
	DGcKXBOPQdTIZZuxcWulSwB+7BCZyKW2XKr0KABOGAXt3FvTnjzeRqeOI3kd+i7ebQ441d7EGiq
	zkehnLLv8+blaDNN8UH57dbwrZmPs7aPwSoy3fyciwUtKuWKmMxJQWv1+jqoMwawWZKRhepR7Zv
	43GLf6Mgjgo17lJORFBzITiv2vNpqpMoyjp9Og+MKT3Etj7follQIA6/vJrsbymZAqMKLVCgnJw
	r11eZVXMEKclMYhCmkQcb+b4fwpaKbtkZIw1gL50Etx82F8gNeJtT+yigt6MiPhtxvYYVotE0nB
	Ks4ZwM0l2wJLTLPQcrOgcAxfl5W7kUXmvPn4Wm7Ggvr78fU6ELkcdjlbmMScKGNBQkyyiftl3nZ
	+9UDFeCQSVGP1ofEVhfA3bWBvqaL21An117mFXL4zup
X-Received: by 2002:a05:6830:6acc:b0:7d7:4a7d:fd40 with SMTP id 46e09a7af769-7dc9525302amr4587197a34.22.1776532622434;
        Sat, 18 Apr 2026 10:17:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9751915asm4065008a34.8.2026.04.18.10.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:17:01 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/4] Add support to emit verifier warnings
Date: Sat, 18 Apr 2026 19:16:55 +0200
Message-ID: <20260418171701.610025-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2979; h=from:subject; bh=p9MFfZgnK951TYx7pyfQJD0PNZxLWlqhIB0nEfB6Vdk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPxnqz/G2UO11WmHVseelYntmr6HTurhwnCpRcVn/rYz/23 fKZFRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYiM4/hF7NAmc7HB7nhAo4xXRnLV1 hbsLrP+XDX3l1qx3KV0Durwhj+SpRYTps0ZaKko16WGN+s5FrNjRKGnEtvZF98dIGnky+QCQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently, there are only two ways of communicating information to the user
when a program is verified, success or failure with a verbose verifier log.
Some information is meant to be more discretionary, e.g. warning about use of
kfuncs that are deprecated, and may be removed in future kernel releases.

An example is shown below.

$ ./test_progs -t kfunc_implicit_args/test_kfunc_implicit_arg_legacy_impl -v
...
2: (b7) r3 = 0                        ; R3=0
3: (85) call bpf_kfunc_implicit_arg_legacy_impl#114683
kfunc_implicit_args.c:40 (insn #3) uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
For older kernels, choose the correct kfunc using bpf_ksym_exists().
4: R0=scalar()
4: (95) exit
...

With verbose logging, the deprecation warnings are printed inline in the
verifier log. When no log level is chosen, the warning is printed in a
block, as follows:

libbpf: prog 'test_kfunc_implicit_arg_legacy_impl': -- BEGIN PROG LOAD WARNINGS --
kfunc_implicit_args.c:40 (insn #3) uses deprecated kfunc bpf_kfunc_implicit_arg_legacy_impl(), which will be removed.
Switch to kfunc bpf_kfunc_implicit_arg_legacy() instead.
For older kernels, choose the correct kfunc using bpf_ksym_exists().
-- END PROG LOAD WARNINGS --

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20260408021359.3786905-1-memxor@gmail.com

 * Use log_level BPF_LOG_LEVEL_WARN bit to request warning logs.
 * Add a selftest.
 * Drop KF_DEPRECATED.

v1 -> v2
v1: https://lore.kernel.org/bpf/20260329212534.3270005-1-memxor@gmail.com

 * Use BTF tags and kfunc flags for deprecation warnings.
 * Reuse verifier log to deliver log messages. (Alexei)
 * Make the mechanism declarative without kfunc lists in verifier.c.

Kumar Kartikeya Dwivedi (4):
  bpf: Add support for verifier warning messages
  bpf: Introduce __bpf_kfunc_mark_deprecated annotation
  libbpf: Request verifier warnings for object loads
  selftests/bpf: Test verifier warning logging

 Documentation/bpf/kfuncs.rst                  | 40 ++++----
 include/linux/bpf_verifier.h                  | 12 ++-
 include/linux/btf.h                           |  5 +
 include/linux/compiler_types.h                | 14 ++-
 kernel/bpf/helpers.c                          |  8 ++
 kernel/bpf/log.c                              |  2 +-
 kernel/bpf/verifier.c                         | 62 ++++++++++++-
 tools/lib/bpf/features.c                      | 56 +++++++++++
 tools/lib/bpf/libbpf.c                        | 25 +++--
 tools/lib/bpf/libbpf.h                        |  7 +-
 tools/lib/bpf/libbpf_internal.h               |  2 +
 .../bpf/prog_tests/kfunc_implicit_args.c      | 92 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  1 +
 13 files changed, 291 insertions(+), 35 deletions(-)


base-commit: eb0d6d97c27c29cd7392c8fd74f46edf7dff7ec2
-- 
2.52.0

