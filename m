Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69948405F7
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779859587; cv=none; b=pg1YY0QJErTJlXFOQHxQ/hALYK659ul1T0bC07Td8ID2z93lWtC4Ma+nPdSby8proopsyE3U33C5u1ZBjCe8AZhv1XAik9xsnIIJXWhWipqSpn+EZ60cjY+ODCAu4tRa+ZRJ5n8zn4KQ8av4eRe16+Ne7DtxiRXl/XaSvPZ1yuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779859587; c=relaxed/simple;
	bh=WEhDZ++slbWPB+Yb8K9OtkosQWMf8J3K7K2A4MwVDxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZD1m4PzPM7/cQKz8tPlf6ovGCZZ/xUOaRhAXEd5zb8SpJ1D3aFyEzzBFTeOdr73BfwqPmSmQqJye3L3tIHgHeceJAes7a3S0Jmfax9yBqwn3Qyn/eew8t6FQuPHJQYQf2f119c9Dvz3bVF+kqRmieR6okAMyLnUA3MV/5NkxK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Snpw/GoW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Snpw/GoW"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36af4b7840aso1858940a91.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 22:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779859586; x=1780464386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+izZGAVsti5zvwhRlmRKEL+2HzPRMlNhWQLgHFnK51c=;
        b=Snpw/GoWgaYVLullGg/dGJV6403QMyQyGw3NjNyBWd9/ZxhDTBnJtmfg50WrXO7m+p
         I18ZSCbeQ/J5zmqHT9OQqa8x61ieuXTpWptIj327gEYGG1DyZLbj0yIA+Bik8T95gWdU
         L6dzdqgJ2ycR1OW0ZYeJyv7O+IrWaX+R0hosaMCquCwbt8ehs86/XFDIqSTOvMtRRP4d
         yXBkHZCTB5hNhv0us/7d9azEnmIEN4UGbRq9KXDSHNxAZKnCfP6ZgJbVo7ZW64SNC/nk
         Ko6OsDsB1g1QpRV6q8xBHhtcxO6CeHP44ONkDkLjino/SvXHi4KWTyom1JQAS0/zheH9
         pTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779859586; x=1780464386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+izZGAVsti5zvwhRlmRKEL+2HzPRMlNhWQLgHFnK51c=;
        b=EKSbf0xaylAN2ovrX2yrLdr3wCDBC0rwBXT66OnJFYLPbhaOjCpR2t68XDqxtsbGm3
         JZ/wDjWjh4NzXXuoQhAEbyUKrF7ke5Tzr5gBdaIjQC6XoZeH/s1/gn7+ZOmfE2velPCH
         BnAOKoR5QXHsv46K2nz7TCajVdcKWSMYd51R8/f7XpYz5/i9l59ZaxJwPkymWHOcLOKs
         bmNfN4T6ikceZLvmt3ns7+smDblJGGGgeMKYTVe/lgth+tUOyAkzmfSSShZXGbfFjgsa
         GDn8YYZ5qdOM1mUqp2EhWkMWsNEwfT5GJiQf9FN8cTP8sDldpaAtYum6v/NJsWcc59N4
         tSZg==
X-Forwarded-Encrypted: i=1; AFNElJ97iXrFyQJtCph5fmfFlddGQBui13RamCkSZFC71BLjXZJzECrEqv+1USjN4XRTz5cZbug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0fWDoD/03PwrJdtsrKEVvf0xEl7fELxHichl2E2YcSrdEG1p
	jtQEB8Wr3omXhdwMfXNZoLXVuv2X4x735x5cZTQ26vGUW4xXFJLHta+N
X-Gm-Gg: Acq92OEFx+iSB1DBXrP8ySDNmxVWc989T2qKXK4AhI8EvPZjG8Y45YuGsWVgh0qE68k
	h6UuSWaWLI8yPOweCoOa8PluKE+gH7V9RtMaC6yi86MKvsKZRsYhyZwbqlAWq/1HtYctUvQLQ/s
	wafY1L2WZUFslkAKjgMD6j1HfkUE+zn7Cthv4Ob/qNcl5UBhcNJPF7z3y1tYsgkoMF10dpXCXPj
	5mRckE4+M62CeDAE+v9ZZF7gszkGF1CUaCBANYFydo77mKAMAVAwfZLZDfK37tCi46fmXbtkkw+
	oAdhxWbpnw6eocE3C0k3hCvdaUBrTdQ2kqUP8a32CnklB7OCQYbJnXAAA8kMthpcT6NJf3LwU3X
	OsOflrROJaN2OsBtsvlH7zRjvM3ZbyUzYb1/EO5AoVtqWSVijys/2bF1Ri2RBIJzRgumwKyfdCR
	E+XjtBhnsC3ksVWsPsXKr9EZy/FKkgUTQo9RPcc0EhaxfE+UM=
X-Received: by 2002:a17:903:1b43:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2beb035b8edmr246804415ad.9.1779859585668;
        Tue, 26 May 2026 22:26:25 -0700 (PDT)
Received: from localhost.localdomain ([220.83.29.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58e4fcfsm144891465ad.71.2026.05.26.22.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:26:24 -0700 (PDT)
From: Taegu Ha <hataegu0826@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Taegu Ha <hataegu0826@gmail.com>
Subject: [PATCH bpf 0/1] bpf: reject overlarge global subprog argument sizes
Date: Wed, 27 May 2026 14:25:38 +0900
Message-ID: <20260527052539.3388700-1-hataegu0826@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a verifier argument-size overflow in global BPF subprogram
calls.

For global subprogram generic pointer arguments, the verifier derives the
pointee size from program BTF and stores it as u32. That value is later
passed to check_mem_reg(), which feeds a signed int access-size path. For
stack pointers, the value is negated to mark the call-site validation path
where STACK_POISON is allowed.

That conversion is unsafe for BTF-resolved sizes above INT_MAX. A type
such as int[0x3fffffff] resolves to 0xfffffffc bytes. On the vulnerable
stack path, (int)0xfffffffc becomes -4, and the negation validates only a
four-byte stack object. The callee is still verified with the original
large memory size, so the caller/callee memory contract is inconsistent.

I confirmed the issue with a non-executing raw-BTF verifier reproducer. On
a vulnerable kernel, the verifier accepted a program with:

  - caller object: a four-byte stack slot
  - BTF callee argument: int[0x3fffffff]
  - resolved BTF size: 0xfffffffc
  - accepted callee access: *(u32 *)(r1 + 4)

The relevant vulnerable verifier log contained:

  R1=mem_or_null(id=1,sz=0xfffffffc)
  r0 = *(u32 *)(r1 +4)

The program was only loaded to prove verifier acceptance. It was not
attached or executed.

The fix rejects sizes that cannot be represented by the signed verifier
access-size API before any conversion, and adds a verifier regression test
that expects:

  R1 memory size 4294967292 is too large

Security and reachability:

This is reachable from BPF-loadable contexts that can supply program BTF
and BPF-to-BPF global subprogram calls: direct CAP_BPF or CAP_SYS_ADMIN
callers, explicit BPF token delegation, or privileged BPF loader services
that accept user-controlled BPF objects. The delegated-loader case is
relevant to bpfman/bpfd-style deployments where an API/RBAC boundary can
ask a privileged daemon to perform the BTF and program load. The issue is
not reachable by ordinary unprivileged users on systems where unprivileged
BPF is disabled.

Validation performed:

  - vulnerable QEMU guest: raw-BTF reproducer accepted
  - patched QEMU guest: raw-BTF reproducer rejected the oversized size
  - git diff --check
  - scripts/checkpatch.pl --strict
  - git apply --check on a clean tree
  - clean worktree object build:
    kernel/bpf/verifier.o kernel/bpf/btf.o
  - git send-email --dry-run

Full BPF selftests were not run in this environment because clang is not
installed.

Taegu Ha (1):
  bpf: reject overlarge global subprog argument sizes

 kernel/bpf/verifier.c                           |  7 ++++++-
 .../bpf/progs/verifier_global_subprogs.c        | 17 +++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.43.0
