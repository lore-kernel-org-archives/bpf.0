Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A033D6DD
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109843; cv=none; b=C9vIqHc59NgN5TtnvTHUl90bg60dEij75m+3fJr51mbMhH83fgWka2ZOQXIHGvaUVRYdj4Tkhr04QrGn+RF4hCcyaPcmM6zl7mcMl6r65ngYHcBM3DD8uk974sqeT8fDp98vWkxSIHUzTLzLQKC6Hym4eLy2gV0PnjtapnzQeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109843; c=relaxed/simple;
	bh=u5ZM4u8pWhiqXRBSeWmXD+kGr1iBRGEg3aTwhu5fHq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbsU4WHzJyYzfuxkfBeBCoRLbTzLLxpYbcdJ4s/2L9O55CG8sHZ5BA7xQRLy5DWY+BNygNZ9vC40iKvjaVUZt4lWKr6vBJ2X73IB1PEMwFkwSnI8QL0jWpoaNFKDABgmkR6f4uMqG+L3uoOInLchu3DLqgVV6HWXEnBC8pwgtEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oie3m5hR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oie3m5hR"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84830c774a0so2055535b3a.1
        for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785109841; x=1785714641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTeag5WVmzDMM/8oku0Xjs5naK4VjdQZVpUYz7PkLNE=;
        b=Oie3m5hRABSdFit91d+EyVFH4C3VExCA22NdbKB5xJU4qmcgs7vsTqL4uFlVcmrMUn
         WPzh/ZN/xHyHSRwOfdgZke75xaw0Gbi3wLZmEOrwZIsDmuDINB6GxpJsm4WBc/xdn1tL
         JIA/a0H2aTgcK1T0BADKgo/RkKPiodxcSD8MF35tUZ+1GYWV6pKyxsk2yQsDZ4bLulMa
         z124E0XwCYWV/SZsCNe2M/O21Qn2+vXWcSdy8wgS3cu6snB1saQ8mznLTAixaV/H+hcJ
         m5fDK80pNbez3svepXewl3FFFsrPwqMVB3fcv3r3+kre7VPGCCqw6eIND0NSuDFrnIEE
         8NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785109841; x=1785714641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTeag5WVmzDMM/8oku0Xjs5naK4VjdQZVpUYz7PkLNE=;
        b=AQehICs5e8DDG2xUJZyMH8WeGlerbIu+gsKy4Uym+RsvUq5cl1mWrolbsXsKp2j/D0
         MimQWY5w7iEJm9o9SeyC4xJ90OMRcHeiv9P1x/HZdGVpxPLWp1tJ46kZYekXQZDSrRHt
         mFQxv/Z/c7E1LMhof/bAfD0N5nLmxrPD4wUn2dHQ6H2VxRNymypWZGQSQoPHxQvxTHML
         puF94ZT/LpZjML02JbCZrMLknAkjn7z9PVjps24cF6b2AWFZNIbDYa9/k4ZwUccDMSVk
         A+TkqujB2+BMc0R0ECZ0VaCbQKqWONgVDB9a5uagF8nmpcvWeRM7aeRObtdJ23q6GjAC
         ubyg==
X-Gm-Message-State: AOJu0Yyv381upEWcwJ8b+4NT8gbap3nEh9P1fs7F0C6VPvdtUHNXpXpc
	TIP1MtZZrNu+0LAOQjpxOAEWc08MPh8aR7zKgTMFijc8evWoiO/Ee92DP6+O5Q+Z
X-Gm-Gg: AR+sD12ugAkU6/u2al1z2okX7bIr1CPJFOKSN9YB9tXnXGJAFsvCk5tZ1fLzhP7oiEn
	8SY60jQh1UGJ+DDskzHAFsu8eAbOBQvRAUTLFtUUeXwb/LFmPbmdJQGheefLvPB/UmUGeaxJqOS
	F9M9ErcatxJJB1QSS89Y5b0kKGdVerJ9/Gx1m2xdSvzNvFZV7PxA6HAuaSYOcSfPl7hderhQB+j
	f/vPL24hV2oIWm1IOtgJxcucSMqVw096yv0EYUgdsurvndkRGPDhHJSvlCUq8yH3eoWJ4S+WvxG
	6e1mV2kJsChgz/2f8I2KEfnIXEKrlMQKPJPDqQ6co1sYCHeYfOo6mZalXPGCQEXDXW0CUNfekBb
	aW+L4xx4utoGrtVTiaZB7HxTGujbBDTSOGlZy6z5KIrKRtA3J/dvYlDstzFkLdEfiJGm5GZYqpv
	e9jZdn/xeX49iNpvP1gyUR4+udnz1vng==
X-Received: by 2002:a05:6a00:12d4:b0:848:5eae:3695 with SMTP id d2e1a72fcca58-84e595f52a8mr4425826b3a.78.1785109841089;
        Sun, 26 Jul 2026 16:50:41 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e534694a7sm2216910b3a.59.2026.07.26.16.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 16:50:40 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	davem@davemloft.net,
	greg@kroah.com
Subject: [PATCH bpf v2 0/2] bpf: Fix refcount_acquire handling for borrowed kptrs
Date: Sun, 26 Jul 2026 16:50:28 -0700
Message-ID: <20260726235030.1152542-1-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two bugs in bpf_refcount_acquire() verifier handling.

Patch 1 fixes return-value tracking. The verifier can treat an
RCU-loaded borrowed map kptr as owning and mark the return value
non-NULL. At runtime, bpf_refcount_acquire() can still return NULL,
allowing an unchecked NULL value to reach bpf_obj_drop() and crash the
kernel.

Patch 2 fixes argument validation. After bpf_rcu_read_unlock(), the
pointer is PTR_UNTRUSTED, but the verifier still allows it to be passed
to bpf_refcount_acquire(). A reproducer with only CAP_BPF acquired a
reference through this stale pointer after the original object was
dropped and its address was reused.

The series adds verifier regression tests for both cases.

Changes since v1:
- Patch 1 is unchanged.
- Added Patch 2 to reject PTR_UNTRUSTED refcounted kptr inputs after
  bpf_rcu_read_unlock().
- Reused the refcount-only selftest fixture introduced by Patch 1.
- Added fail-before/pass-after verifier validation and CAP_BPF-only
  runtime confirmation.

Link: https://lore.kernel.org/r/20260726015330.705259-1-dingning04@gmail.com

Ning Ding (2):
  bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
  bpf: Reject untrusted pointers in refcount_acquire

 kernel/bpf/verifier.c                         |  7 +-
 .../selftests/bpf/progs/refcounted_kptr.c     | 61 +++++++++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 74 +++++++++++++++++++
 3 files changed, 141 insertions(+), 1 deletion(-)

-- 
2.43.0
