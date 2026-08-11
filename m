Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408E4399ED
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447363; cv=none; b=pQAxQ77AvOs0bUjbMpi/OGg2M0P2ZEgFrf5kpUNiX6aMmvfNdYZwFTA+l8wly8lN+e1KKklDcLOTT7AQuZqwTa8u7hOhPCTsGtWpfhgzdvVGSiAJjGwyByHcF76Tm3jIsspJr5mQYMuQ9TB+XRQcEdjtYeEBrfF2H8kjLiKNrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447363; c=relaxed/simple;
	bh=UUwKbxSHK+IGcf4a2fARGLpo56B9bjwEYlgtraBncQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZuZwU7249B+/QU3IOGePhL7ar4DwHA1hjy4VMHNTxGILWmraaQlOhiHkJRBWy/LldW9xGnnP6aKRwydcuO/xJpF8nRSjraCB00zQJvrtCuAYWRdVq4rHC3m0i1TM7rIoUp7l00mamnbKbIXiQGgaROJ9zKjGkxX72Yi0SzrDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpCm3VC8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpCm3VC8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980dc26022so30722345e9.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786447355; x=1787052155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRhoQjSmC8GBNmfZgN7psXLs1nzRsY572TR6apNX5Ls=;
        b=XpCm3VC8CdjtucalzlnjGpTFZl/eDTMn+XRLxWTIVK52codRX/D9APY1EMjMhxoD03
         rUyLmiBLxXGD13e+xY2F5LOH60wuFFxUJOEvNri6D0/J7tu4QVdZxNMmoYWV987y9T7b
         25+YDf6Lg8LZsUL6RotFNUffvBvLVj2oyK0pFBiByZ728uQnHTwYp0M/esHuN4z9kwgY
         bsNmC19k9/4WqMwH91X9tJUS3jqjcp75SmygqmOkr7Wv8hRcmW3d5MvgjnYSimu0C16N
         3IcE/c5kk6x58adbVFaEBioOtVHVtBpV1STAKR2d/FqnDAsqrX+JPID6ocwpUNQRpsN8
         aCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786447355; x=1787052155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRhoQjSmC8GBNmfZgN7psXLs1nzRsY572TR6apNX5Ls=;
        b=Nj7j4VPmHae3eBNdQtSxilxSvDdI3+8oFyPNyN/pFjoGW6qBvLB4WRqXfu9WF8/jsP
         UBGbajBPFVuWqGVaGWmORqu9TW+uivbpwjL8l68IReYId7Gop90qMRo1UXGLDmHgNy+5
         QhH8+QMICqIOtTdCZ/5bezOC1l2t4TfMfmWxtrSNQVshjQ2Atjmpcf535YGx4kFHAHKA
         gWFy8okqb7gYvVyd4hXVLviajb4hnrCcZYZLXA+iMSdFhOoVmTfQ1uVWUvQOefjz0xDZ
         LN6JbfRSpisMSIkEUncWb3Ghg9/wzNHSfCtgi3hX/1PpgwUV4g9V1fyhhdGOL5lecSiO
         C+bg==
X-Gm-Message-State: AOJu0Yw05+pjeUzYOlRf/UgFV6juKjMAvqMQYA/fnA2gT7AXw/g/BW2V
	PvMYjmfLFq2T95kSLEB+bbMgND6UnsFIctVKvKDW7O0LQTjhIY+Va92T/r4slFaD
X-Gm-Gg: AR+sD13ch0Mm245aJ1XUbWbKuR6bGkiy+WMym+dpcDi9mpK38VVHqUAKjpTs0X+aYlO
	mDX5exL2XEF8po86La2UxKwXoH7Yjsu7LLwdurwhuSuWU/WRA5zRR0qwOplRCkzfMpyqUwyvZGq
	00jw7LIaN0tjugQFufgB2S3spE9tlXMfRq5rf+Vb0Z2wVhZrRmq+NnzoJWdzIgJcxYSrwfB1G74
	XyaLG4bPVSHap9sG0YkZh8E7Y2CTg08sdvU6T2LIwDc1SX043hOgagcyb1RK75zW6rdIHOOXdiE
	mCC8hVg9pOehiQTlBfZlOMK0F6N1uhGsR4/Nni7lYmqvvyxDp8vuPj5KeOjDak5FSqHepBirJ4B
	El6zItnsoRpq3dmdx9CO7RSJeN0+jw57W8fU/KmB0fKCOgiIqXAg5EaqdcqHIHgOPvBb+b55jUB
	0RmTLWMClGXv8iGlQelqqS+MELQI9xYALE4kRDtn1+sr/MR/HXLw8rqzsm9HZwszsX6qmGxBhRE
	Vq1
X-Received: by 2002:a05:600c:34c3:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-49978465fbcmr46941675e9.13.1786447355005;
        Tue, 11 Aug 2026 04:22:35 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c2bcsm47547665e9.3.2026.08.11.04.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:22:34 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 0/5] bpf: Add user memory access kfuncs for mm_struct
Date: Tue, 11 Aug 2026 14:21:49 +0300
Message-ID: <20260811112154.94053-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During exec, argument and environment strings are copied into the new
address space held by struct linux_binprm before that address space is
installed on the task_struct. Existing eBPF user memory helpers only
support reading from the old address space (i.e. current process)
and for this reason programs cannot access these strings from the
bprm_check_security LSM hook.

This series adds two sleepable BPF kfuncs for copying bytes or
NUL-terminated strings from the address space identified by a trusted
struct mm_struct pointer. To support the exec use case, it also marks
linux_binprm->mm as trusted-or-null. This allows BPF LSM programs to
read exec arguments before allowing the exec to continue.

The series also adds selftests covering both kfuncs and the
trusted-or-null annotation.

Anastasios Papagiannis (5):
  mm: Add copy_remote_mm_str()
  bpf: Add user memory access kfuncs for mm_struct
  bpf: Mark linux_binprm->mm as trusted-or-null
  selftests/bpf: Test trusted-or-null linux_binprm->mm
  selftests/bpf: Test mm_struct user memory kfuncs with linux_binprm

 include/linux/mm.h                            |  2 +
 kernel/bpf/helpers.c                          |  2 +
 kernel/bpf/verifier.c                         |  5 ++
 kernel/trace/bpf_trace.c                      | 83 +++++++++++++++++++
 mm/memory.c                                   | 25 +++++-
 mm/nommu.c                                    | 25 +++++-
 .../bpf/prog_tests/copy_from_user_bprm.c      | 52 ++++++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c | 77 +++++++++++++++++
 tools/testing/selftests/bpf/progs/lsm.c       |  5 +-
 .../selftests/bpf/progs/verifier_lsm.c        | 31 +++++++
 10 files changed, 304 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c


base-commit: d114bb98936770c501c958bf2bc5fb6b7c0bad7b
-- 
2.55.0

