Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF53A2544
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098427; cv=none; b=Do06y3ZP6nrmDYCA1fGAYLFCtJQv8XNjgybwe9YFIkI8dStElj122M/mpNVO9TXxyIcxlX0lt0AklYCqh2nPCxgpiP7uLL6IofNdWTaLT7GaDsCQLGD4B6KpbW8yrBqM95+sVoSKL93Rqz4TWVESd8YjFgGkLT5WjVHH3iA11XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098427; c=relaxed/simple;
	bh=04EaI3wnapseLGI1EgkD+ho/mCHXa6i76cALIpnghw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjjmJyDRcRa3PGVa0EndWb4CSbZ3bD8eVxgx+MZamIyP8H4wEWLFxfJUq/j75+n/Gh/mZ4TOcDXa3EP9Kfa62tbqq0xkfWv2BSTFJjYBDzNl9prn8Ibbyw3AV1rEQXTnAj0S15ib6FCI3oB+MF7aosFGf2wRpayrAyzMfvd5uZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXDGqlkd; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXDGqlkd"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38de693676dso270562a91.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 20:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098425; x=1789703225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GEkFYr05iv4wzoNqAOaHvW9rB7dGU907GRgrdkeAZ8g=;
        b=aXDGqlkdimF+NfJWBlbqj7IyRI7JF0t6ruiesMeCIYBtFEye6XBFUW475iziezTXp6
         +cNZ5bFPAFsGdDFHR2DwbLmr4nIEYIHKC8JAOflPFw4rk7e6p92i6dHzIpbXcu58Ulv3
         Oeq564tBJZfFRm68wqnWiSGzVsZtlJb+yyzzaqHp0sNLh0OcGTUhRp4ilo5dEi6HKNMq
         uZ3Vv5gOVPBaaqEoVBvjjwSV3u9GSygVUu0JIhgzued99nuCTeUs/IlWyK+Y9Tk330Q/
         j9mZc/PNVBWL8YG9Jesf+s1XWK7/f+fhJeFVq1UJTud8QT3UFlzB08wk7WK/7cMRRV9W
         oFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098425; x=1789703225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GEkFYr05iv4wzoNqAOaHvW9rB7dGU907GRgrdkeAZ8g=;
        b=XuP91//pGX4vJCpMfVzaGaKNCCuhANA2GADZi9taVMbwL29iW23yzaVDb6IlR4hIIJ
         HbVCqTc77V0qojA8FdD2WT4glcBbHZTSMYMLZtWOp0h799kGbyFncDapKsBWfSzsW9Ox
         gbsiN0Ob5sAqIxVYvYD5K0cL0sWfXwuvwMJcUCIKQSLk13PO7W6kjJldnXMiWgUYvOOg
         8iA8oGOl+VFzsmQnGesuT9dCHQtohfZL8tgEzTYbvEh88992Dv94n+pxmL6GstuVP0Gq
         zQ5dWfY7vbp6GfsOhzxso7le8rSJneEGuWObIDgzXUV015BbOQt+xfd89lDY3oZt0OvV
         Yimg==
X-Forwarded-Encrypted: i=1; AKwUvBz1Mrh2/Y4afZiWQv7O0AYgYlwunvkFC/P8PrknO198SwZFXx2oMwWTH5199S6pEEdzX2U=@vger.kernel.org
X-Gm-Message-State: AFuF++lf6M5OyldhOu6UzACFonT7At3luUmzwcYnmFkl8zOw9gwhU5G/
	syWd7Sq9ONnX2N5Xn8B1UWilEVXtPqJePqrwMNcdAtLDAowq/sXfjD5mgPpjE+TMZrXvLg==
X-Gm-Gg: AYBFou2SZ9Xwk1kswZh6+Bvi367GKQMZMvq4IeWY64BiH/dyygv1K6Y6/cRuTKusEw1
	8gbfLn0KJEN/ao6dOtxsWbEYWiXD/2uZaTn4tMVXrVFO3DMb5sBnb8II9oQBA0i26PX0V1qa6pz
	k3THfdZikhbXB0D0RMj0egkPYAT0BF1Ie14Eeun2McdenioTVrVAx5G6Ne837eoNWOdFjj8QdSK
	tnNUxICfBbox059wpmSxEwNr6BA174FWXQvRQ2kk8Z8F9/2P1danXEw2UK9t4KTQzVHlycuesy+
	2WgA8k08z+RfEKdn7CQlQZl6Fp0NtaWCO30LYP8cAIOuU79x7s/fDHK3RzoLWVOoJGPimQ49RHU
	Ritj0tbWamBhgJQytqNyhnzu49fAw+FXdKgJotqdIpykEUOpJmmYcWoYSiJOBM1CNcSnYwHth4f
	ldzRCOuG/c9sOTrkFvEN3fwHMygVapnVSX+pK9cxRlrxznzuOcdrmFMOk3xffPYEym
X-Received: by 2002:a17:90b:3809:b0:39b:92bb:9ef0 with SMTP id 98e67ed59e1d1-39d9c3ae96bmr3482968a91.20.1789098425168;
        Thu, 10 Sep 2026 20:47:05 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9959ac65sm2119710a91.16.2026.09.10.20.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:47:04 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 0/2] bpftool: Support symbolic map creation flags
Date: Fri, 11 Sep 2026 11:46:56 +0800
Message-ID: <20260911034658.219396-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comma-separated BPF_F_* names to map create flags, with matching
documentation, completion and selftests.

Changes in v5:
- State explicitly that the old numeric parser accepted empty input as
  zero and could truncate or wrap out-of-range values. Rejecting those
  inputs is an intentional compatibility change already present in v4.
- Explain why BPF_F_PATH_FD is excluded from map creation flags.
- Point the manual to feature list_builtins map_create_flags for the
  accepted symbolic names and rewrap the feature documentation.

The parser and tests are unchanged from v4.

v4: https://lore.kernel.org/r/20260911025044.190540-1-diannaaav@gmail.com
Review: https://lore.kernel.org/r/523c73e7f76e0634a3e061e76ca4c39eb21cb006fc78875ddaf6a35e38bfd500@mail.kernel.org

Validation:
- Rebuilt bpftool, its manual pages and the focused selftest runner.
- All 29 bpftool_map_flags subtests passed. The three revised series
  were tested together: 52 subtests passed with no skips or failures in
  an x86-64 KVM guest running Linux 7.3.0-rc2 from bpf/master, with
  LLVM 20-built BPF test objects.
- Bash syntax, bpftool synchronization checks and diff checks passed.
- The generated patches apply cleanly to current bpf-next.

This was a focused run. Unrelated selftests requiring unavailable kernel
features were excluded from the build with PERMISSIVE=1.

Tianyi Chen (2):
  bpftool: Accept symbolic map creation flags
  selftests/bpf: Cover symbolic bpftool map creation flags

 .../bpftool/Documentation/bpftool-feature.rst |  16 +--
 .../bpf/bpftool/Documentation/bpftool-map.rst |  15 ++-
 tools/bpf/bpftool/bash-completion/bpftool     |  22 +++-
 tools/bpf/bpftool/feature.c                   |   7 +-
 tools/bpf/bpftool/main.h                      |   1 +
 tools/bpf/bpftool/map.c                       |  86 ++++++++++++++-
 .../bpf/prog_tests/bpftool_map_flags.c        | 100 ++++++++++++++++++
 7 files changed, 231 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c


base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
-- 
2.55.0

