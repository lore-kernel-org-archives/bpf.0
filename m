Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588CC18CC13
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122103; cv=none; b=W2ePNXJqQp95pltEa8gyAefiKkypENlj2nY6UJynyONVPsGab+KZctfvM1LrbGlW1wdgDV8k9SwV65yXs9kPv6xs5O0/Yid5vfpuveiSgSXgF9yLagX6QIrp8L0mhqjf9Z4gwMypbSA9GtCngAk/wdq40BeVmyHdm49y/zLgJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122103; c=relaxed/simple;
	bh=ERimEa1G3IdfKCVSb18kreNgeDbEZqHoSBqszcbkbXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgaUjLc3ggXUH6FTPWX3JRZy332rbMFArMyDIMtF4g6XTK/xn6af1EL+S15Mqiiy8kL7hbXlal/mea7eaiZoXkjDGiC16JZhYkOF0TztM7LVKP4EJk/CNwGrGqwMl36MOnZJzBOjIIzl487xUGSJrYm9ggR5SzlNRGkY9CpHoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIUppR8x; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIUppR8x"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0b25dso2276775ad.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790122102; x=1790726902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RolIiA9xWOqMDMe26HLaPTxvXgDJ3sSrQxbTSLuZkCs=;
        b=AIUppR8xW5R1Qz2Mi/6s6ITXHro6q/nM+HbpzRBySlrg1m+2bq2zI7IhVRwLi9hcZt
         MbjWpcYXEOK3rR7WEBNb33cJ6hMFMTwBeE1L13MiFxC0Zccf/2yvvMBeeJF92uS7wmlo
         T2lp+xKuJCjrYpTcaXKwaVb/69WQ5XQV/zkOcAID9Yn4L6ehOGeGcMNkrbW3zcF8CoG7
         KhDlyJPfTk2nQLdM6gkaIQkc78jHSFW3Q5MaCBcjevflrK0NA3kej+UyoSDC1fc42aD8
         uHWqvmWFvi/t/VavEM4iwvaBvzBbsSZoFS91t7Uvx/O1+tQxtC78G4StaqvvHy6vWBgX
         R/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790122102; x=1790726902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RolIiA9xWOqMDMe26HLaPTxvXgDJ3sSrQxbTSLuZkCs=;
        b=zAbsVo848MV8VBSIo8YXhPLJJW6pztwrxLP3+SR00qG7FNmyMkBWx17BiRrWqrNWM/
         RmWD8qhQtCRBClpaBvm//AOPfnxBudMBwsmz7VT11Yv0XUXJBPCMHWP5/XY5OvQ4DXxG
         79hEk2huaBFNC6+nQT3dT3ahNZac6kTJSN2vgj3HQwgNtTSI2f7HIZqRzgquuWvPP0Nw
         qt1dgFBbYetWspBGqJYutS4p0zRSbeqouPy5iKksslxeXgulAa1oEpV/nPF11xWbsCCW
         V4EmFGaoO3bFVkPI0NUFDHVElmygtFDFJM8AoI2fHVu0dLGnHoklSqLrXoDZN55x9Neb
         OXiQ==
X-Gm-Message-State: AFuF++nU/d6YCboRU+y9XUA2Wix7IKJS+kJWeJa+sZlvR6Uy9r6gqalT
	VqMm8j7dg4fwTdmqLQUjLy6KnyHcB41Ck11+THbZK+YYIfN+Z7ibAUJ0MYF1rgQrzA==
X-Gm-Gg: AYBFou1gbDfjHvNwyrD0Ey9ls5qiVlycyO8pcAm1EzGXXgqbvBSOX7lLvTYC9EHjQTd
	LkUStc+bvMHILpgQvCd9ge4Ert7rx7/4JBgMWp6VHi6x+5nSocm6eAg6eliJQgI5NgVztWryR27
	V5eSSx5NjcjvBJBKRY1CZGd4RdrCivWzpBrAaC0NOQRKzRJu5fOthKAYMu/C9LRiL+9z59syKRR
	FKkW0hJZ7GS7KMOPxq4zUm4FcBAGtwc/JO25cJVZtEBXFlSNsfprR3Go7l+erixSokti9/2fqR8
	Xygw1qYsprWeqYNHNt2GKmlfUMzdEtr+oJrBnln9L9v+ec2TivNMeJTV3NJW+RRo6686Bcry4jC
	EmE/ZREdAxHjBYTDiUWD8NuDI3u8Year0hxNNU+11A3m0P6Ib4c0hv1cnZK40BOWhiAZd27DguY
	uTBpRJLj3JOPCjIbtCJ7h6KlFDRQbIKPl9lGZATRk8btnI4HY/cfG/IoLmtMY9a6zrBgoYLM2Og
	COyObpNyO291VXs4ltrqJ/QUDVmB5KrQu39kg==
X-Received: by 2002:a17:903:8c3:b0:2d0:cc92:f7ae with SMTP id d9443c01a7336-2df69d1aad5mr9368365ad.3.1790122101577;
        Tue, 22 Sep 2026 17:08:21 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:2466:805a:e198:cde8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5c3a3dsm2021425ad.43.2026.09.22.17.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 17:08:21 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH bpf v2 0/2] bpf: fix per-cpu initialization of a BPF_F_CPU created hash element
Date: Wed, 23 Sep 2026 09:07:59 +0900
Message-ID: <20260923000801.1764758-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF_F_CPU update that creates a [lru_]percpu_hash element writes the
named CPU's slot and leaves the others holding the recycled element's
values, so a lookup of the new key returns a deleted key's per-cpu
values.

Patch 1 zero-fills the other CPUs.  Patch 2 adds the selftest: the
existing cpu_flag subtests always prime a key with BPF_F_ALL_CPUS
first, so the create path is not covered today.

v1: https://lore.kernel.org/bpf/20260920093153.439743-1-donggeunyoo.kernel@gmail.com/

Changes in v2:
 - skip the new subtests instead of failing them on a uniprocessor
   machine (Sashiko AI review)
 - cover the BPF_F_CPU entry condition in the block comment above
   pcpu_init_value() (BPF CI AI review, Alexei Starovoitov)

test_progs -t percpu_alloc and fourteen neighboring map tests, x86_64
under QEMU/KVM, 4 vCPUs:

  without patch 1   31/112 PASSED, 1/3 FAILED
  with patch 1      32/115 PASSED, 0/0 FAILED

Donggeun Yoo (2):
  bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash
    element
  selftests/bpf: Test per-cpu initialization of a BPF_F_CPU created
    element

 kernel/bpf/hashtab.c                          | 10 ++-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 80 +++++++++++++++++++
 2 files changed, 86 insertions(+), 4 deletions(-)

-- 
2.53.0

