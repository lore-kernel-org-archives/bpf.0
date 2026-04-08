Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513CE192D8A
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614445; cv=none; b=bjvTx/ewRhc2uedDSWJLczCzQH4P7v6JQfAN+4CgVLA3ahY3QMa1+LSGnx36vCFgmysgr10sT8r/txyp4yAHzg1zHPOhlRryBwjmwvwwTpkXPhFiqBBllXVnBfxzVcR/crI2SxL34T6ly2h0u542uKs64jFv3aFVcwEusKsWuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614445; c=relaxed/simple;
	bh=4fIZyyTzT8mZ0PmHVsfsEzOhp6rN2divLnBYb5IlV3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBQaIiV4wjuVKqFoTY/m4A+9Wv73I0SE6ETHIOqxIW/qZSlogaSjAum8dlu792CxEvmuoYuvEvgVGQsEkBeU/ctm71pxQ2oB1Ws6xUCQCFYq3VusXacIPSsn4bjJ/vwJk48wQ9ro2lThoX+Ins9+a8aOudm0mnrs1YhJoYfm8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvVqULJP; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvVqULJP"
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-68481c9e067so1172408eaf.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 19:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775614443; x=1776219243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+MX4Wgha+fJVUcuVPsjB/rcXKLTKIvJ3+Ck67aQgVbk=;
        b=bvVqULJPrryfQ9oqUN4R2c8qC9LKPjdDBynlF2uO1TEeXSAUKvJztdGQvwU1GbTJzj
         pJKcYlLp11ukJHnC6zwrfVN5CVV0SJnOsOc6JsN/bt0JDX1pb0qigYKbHR/wQ9X5RVqf
         M+P4KVLTyQdGzod/kQP7v5TK6Gr+f1irGbZ7n0PbSu4esRarBBbi4kcMXTvWBVISpMJ1
         CFIgS1ONN50zUC3mLJEnu4lOoahPzfUHt777bC0AOlAUeYwKU8toHQi4FGs7kFHk+qnN
         YjSfZgiZuIFX2A9J+kBg30jGY0Gdc0Qhi2tmBj0CiHmGgLPq55Nn9pH8JYzhvOUY8wT4
         3dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614443; x=1776219243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MX4Wgha+fJVUcuVPsjB/rcXKLTKIvJ3+Ck67aQgVbk=;
        b=hntL277pFfdqgsltVgHprgflBNwGXHgzd6XGo6zD0QT+bEyZF+i0YRz/GpfxJD61kK
         /nczZgOr8ZFsHB+aJ7JjH3qZ2jhPgizlk/cB3Bi87/cK+588QovFjjUFBeqz2s9F0EQZ
         T8J48/Zwv9USJ0+r3oQb3AjB/8zMy/86G/wY90JHSFJxKMpFADNB5D8FtBUkpFilndhb
         LynkGBvQ3KjG1G+iCXfGpqxHoxen8kWkZPYMobAauphFiuR8xDLYzYrZzYYmeiNyhlh9
         qF9F3MOLPIrW3wCYjUx4SfZwENoPnGtTK96ejZoJEjWqQOD4WRcUONXSX7X7oTXeTn2Q
         eRKw==
X-Gm-Message-State: AOJu0YycdhSzr9oNKEETLYN4pRRulUAiT2t2mwaQ+svoLSnofLk/oMM/
	Glvfe8u1lEBfNn0XaSY1rtXabqPXBtalwWk+5EN/6qQdwcUQA5TPe4u+m1Umgu9rbpA=
X-Gm-Gg: AeBDieuJRzxHeI2JvlfFBmxOMSbJzYQYp/SjctvmZEwvujfCjtFOXNVxN3FnEUno0Ww
	LUoZNNlDrNaycnrxLpWM4FBEg7JHQEOFri1SBIJrevJYJMwYf0w21yTzxPSvbWqBbE1zQQLsIAI
	iTY6+Fkt+t7khTHf3EER4nejddIDI33Xtjc43tpbX03Q6EYVSoWSe3emMz7ZT8+oh/Ar+3Z8dNL
	8zvHDVNuZk9T8F1xietZOWWE3IVGkKX5l/ce18No8KvAIzBfz69iZbMy15/xcEMvufNkBkArtuy
	JEdbyX2AbM3NLKHiN2aLNvVYhFxuy3Je3K3AGvVGEicqdKGxABS74ICwsfYr5Z1S3sZrf7YTqTF
	IIDeRLL9hX8Vaeq8N1bqSVu/znP4xkffqq8wm2+3dhC4dOScmSJkk2ZV3KQcvaC6ZwFFenxBOj/
	b35UqUuqXy2H1AkMLlRTvYW3hSm1Lbh/qIYWP/1edTSDqV
X-Received: by 2002:a05:6820:4b12:b0:67e:aa1:87fe with SMTP id 006d021491bc7-6821f382404mr9547450eaf.26.1775614442745;
        Tue, 07 Apr 2026 19:14:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-680a882d978sm11142902eaf.10.2026.04.07.19.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 19:14:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/6] Add support to emit verifier warnings
Date: Wed,  8 Apr 2026 04:13:51 +0200
Message-ID: <20260408021359.3786905-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3755; h=from:subject; bh=4fIZyyTzT8mZ0PmHVsfsEzOhp6rN2divLnBYb5IlV3c=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPqzmMu3lEX5BKiW7ds7At8rfepYLv9Y0WP53x5PaWHOBUu 2rJ1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCK+1xn+1/+aJuZdoMpsyK01QaR5Sv 7PpXsZa9/l22s2qXwVPXxzOsP/yAuLW9RFd6qr3brQoM7/ic0kvdm3Y7Xo3OjsS/vnTSpmBwA=
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

The set was tested with and without kernel changes applied, so that we
could conclude that libbpf feature detection works correctly and
backwards compatibility is not violated on older kernels. Still, it
would be helpful if other reviewers could recheck all assumptions and
make sure I didn't miss any corner case.

One case I need more opinions on: log_buf.c passes log_buf with
log_level=0 and expects it to be empty, with newer libbpf that won't be
true on older kernels anymore. I don't think this is something that
needs to be addressed, but explicitly noting it here since I saw that
test fail when testing new libbpf on older kernels. The kernel will now
populate such log_buf will "processed N insns ..." log since on failure
libbpf will retry with log_level=1, so unless applications are relying
on log_buf to be empty for correctness it should be ok.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260329212534.3270005-1-memxor@gmail.com

 * Use BTF tags and kfunc flags for deprecation warnings.
 * Reuse verifier log to deliver log messages. (Alexei)
 * Make the mechanism declarative without kfunc lists in verifier.c.

Kumar Kartikeya Dwivedi (6):
  bpf: Add support for verifier warning messages
  bpf: Extract bpf_get_linfo_file_line
  bpf: Make find_linfo widely available
  bpf: Use KF_DEPRECATED to emit verifier warnings
  bpf: Add __bpf_kfunc_replacement() annotation
  libbpf: Flush verifier warning messages by default

 include/linux/bpf.h                           |  3 +
 include/linux/bpf_verifier.h                  |  1 +
 include/linux/btf.h                           |  6 ++
 include/linux/compiler_types.h                | 14 +++-
 kernel/bpf/core.c                             | 66 ++++++++++++++++---
 kernel/bpf/helpers.c                          | 24 ++++---
 kernel/bpf/log.c                              | 49 +-------------
 kernel/bpf/verifier.c                         | 60 ++++++++++++++++-
 tools/lib/bpf/bpf.c                           |  5 +-
 tools/lib/bpf/features.c                      | 56 ++++++++++++++++
 tools/lib/bpf/libbpf.c                        | 20 ++++--
 tools/lib/bpf/libbpf_internal.h               |  2 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  3 +-
 13 files changed, 233 insertions(+), 76 deletions(-)


base-commit: 5c662b1c1789f51f79ee9c648681abc8410dfa81
-- 
2.52.0

