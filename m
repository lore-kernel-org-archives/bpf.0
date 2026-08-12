Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490A3EC80E
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533131; cv=none; b=em8nGu0KaAIHkwLMhOnCSQrWP28k8FLmNPjAEHf+Sea9GnoEA5xykRVTvq8pRYz9yJYEwarywxyHYi9x7mYgVREmgJlqkhedlGrlPapgn1zCQeL0K6/oHnJtFm2aNcc6k4UBzg/hdVfYz09vTIjeDH5m6eyBad5fu2WdF/mrGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533131; c=relaxed/simple;
	bh=OGxckeJmWrizXAHqZWRfuMMkJcH1fqycD1u6bjgSYRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eyRJkY/XO8u78PT2LnTjib5Z/hNp4le7JGWib+HHvUgpBWrPEzQOdprh99T8z5G0pSfoouPp/W8K6TUKI4v9R6xQGY+41RjW+f4z2GSus20oo9XrSxxFemtFpHU1o9jAS2yWcvKQYpS7wf3S9ZdLTFY/whb6l2mH17ol56bE7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzgD/hKB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzgD/hKB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49800c6a846so8184595e9.3
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533127; x=1787137927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLpqRHzThXr7YoPCHJa6pbt4R/oii9J/OGrNuRU8D5k=;
        b=RzgD/hKBvaQHmUpFWk9m4S9hMEd0JE1OHzw6WvyZ+GEV3LWCEeo7+hgG9TohAe+50X
         bBp3cOF/2SV8RjQqsVkjvOdoMjK9fQFyQZn2zzKTx6DG4R9P977ipiv+nKKcMbtnWuvT
         /5IqbjbPMRq0GFDD9IE31lNsdGN/M2gwRUCKub4v9+A9QW4vOLCtJkegrks4/MfF4wfy
         ZuXEjPhb6AoDOTNxpDdNrxyfckUhklR1GjdOk4MT+1AEoEalG54p6MAkrfs6fNMR27uL
         YyJ8+R0xS/WSBpkBqWwuIBKmR1NfR/ty37glSIRduaz7wmSwQybMBAQUPJwbf0GEPXRn
         DH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533127; x=1787137927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLpqRHzThXr7YoPCHJa6pbt4R/oii9J/OGrNuRU8D5k=;
        b=mTXv+1I3Ywu7fHiDIqY1bXENb8jegNRV+CBI3kSbObgwso0W25RWj9En95eqaJTNr+
         9cqydtsmab62EzMIq22/bAOTl9ZoPFSQZ7UIyrnFRL/blO7vzU5CLqmFTMqMFi6dEwig
         wF+71sn7CzlJcioQeFTm+hqqZCAKhoDIQ65Y5Suvwv6Fp9O8EMfnP2SJjplTR6SrIDx3
         xCm65tTQuKNGgxQYvKf0f9/UGkWKdRQmBjLuOxHQqLWQupkoOxZbDC4Wp3V0cEA3h057
         b15t/fAFlVQmEx93ag21KFVvpzt0pAOA5cAOrvUZptpstI7vnTSPIIJvxkUamPBzGDxG
         0SlA==
X-Gm-Message-State: AOJu0YydfFLlZ4O0QvYV9+JzWbfQo4gzEzYmbbKb9mUAoB0GL4SYlpcN
	l0t5ylEPWCjmEbvniCNwKhsfWCoT4WGSkJPntByHqcC1kw6p1Z2yrjSCxUb6r0Fw
X-Gm-Gg: AR+sD10Jr4MfgkhoQZPR0x0kVkgq6hhfdhgI93MA6Padf+1t6ldl9DyygAqJ5lU4guw
	vxYw71X4AF0k6vMfF5xOW/QU9M3V60QtxEgb4kwHTBarS3PsAOnwpM/dKcKg1n8j26DP27F0aIg
	fKPhNAGF5pAvgF5dOoDcG2XzbBDgdqY1cMZKdI1pFG3LpZ88JlIDUZYxvgQX+wz21u8RhFI8Dxj
	FoVo8laAjJvAPx8O92IF3m1yU7ojvld615TLlYm0vXnNSS/tFqtLZ3ENWdhd6brPuIuA6i57eUY
	tCDEQUddI4iP/jllF4OnoXJvqmue3/5p02rMrE9IuhD98y5yQuFA5B27YffBwe7cVUoAdSJrdof
	7J7tG0GKjM5GFRAYHRwxP8suVjLraMmF0rQFpO7FAOQbYVHD4XoU5N/wuagYVcN25GtbzBx1wOh
	nlpd9d5r0nAr3H63p1q6U0Qh0HonzQQjun16NoYf+I9xF52aaIG7oE4FzgrxvvQlZGNt5DdBS9p
	jng
X-Received: by 2002:a05:600c:4fc5:b0:499:76c5:5855 with SMTP id 5b1f17b1804b1-4997c15fc13mr42107915e9.16.1786533127011;
        Wed, 12 Aug 2026 04:12:07 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5e:1100:7303:647d:7cc4:8552])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c9417bcsm54830855e9.4.2026.08.12.04.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:12:06 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
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
Subject: [PATCH bpf-next 0/3] bpf: Add user memory access kfuncs for linux_binprm
Date: Wed, 12 Aug 2026 14:11:37 +0300
Message-ID: <20260812111140.7762-1-tasos.papagiannnis@gmail.com>
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
NUL-terminated strings from the address space held by struct linux_binprm.
This allows BPF LSM programs to inspect exec arguments before allowing
the exec to continue.

The series also adds selftests covering both kfuncs.

Anastasios Papagiannis (3):
  mm: Add copy_remote_mm_str()
  bpf: Add user memory access kfuncs for linux_binprm
  selftests/bpf: Test linux_binprm user memory kfuncs

 fs/bpf_fs_kfuncs.c                            | 112 ++++++++++++++++++
 include/linux/mm.h                            |   2 +
 mm/memory.c                                   |  25 +++-
 mm/nommu.c                                    |  25 +++-
 .../bpf/prog_tests/copy_from_user_bprm.c      |  52 ++++++++
 .../selftests/bpf/progs/copy_from_user_bprm.c |  74 ++++++++++++
 6 files changed, 288 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/copy_from_user_bprm.c
 create mode 100644 tools/testing/selftests/bpf/progs/copy_from_user_bprm.c


base-commit: 07cb86aa50816b070b99c89bf948762ef035a1f2
-- 
2.55.0

