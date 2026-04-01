Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C662A275AEB
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053885; cv=none; b=ZEyGJPp+2t4K6FFos3y6/R2k/d0laHB53LRjKmBIsNkBEIJ3z9zVllp7sFQP2EE4NmozIZIZILhnYsiVPOOJ0dMSeXz2dqYN2vcnwI+FDnhQwSVL49X+RuDbRAXoqc+LZS5KjL5XrC2rWzUSW2WxEE0taWzSyn/LSkHaEKMVEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053885; c=relaxed/simple;
	bh=lH9eKSW2yYhKqeRTFuyuIorjmr3ody7md9WA8FOkB9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZIZPMU8JWMUADTG3XLVYEoygDNhGhwO6i1LK3I7gkBp62Mj9CHjzSuB2O9YuYKkE6Htvi3xKsqRMzy5YQ/21U4xmkSIuMTNr7J8JR8FQU3R8JlGry4ViqHIuuogOclKVwZvVEO8YCpItb+s8Pp3Hv2UDMOyZG4Hf+gj5bHfqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W5xuqMKR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W5xuqMKR"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66bb6eb28acso7358047a12.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775053882; x=1775658682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D9Y5HSn8qHxvvJdhLmXjNMhQ+Dpvj4nqUmRgXhpDfws=;
        b=W5xuqMKRZi6AEM1f2fspPvPf7QhKMVYzgDvdRDdd2chZ1SN7QKcOpsEHi+mLYUujVU
         sfvMcJuppr3BPYdIB+DqJ/f+xeyoEDabM61duEWflUu0Mfw3S4MV6Sz5luWPuAMEjHsJ
         VzDKMtV6J2ZFOw2cI690hVuD4BJN4iavS+iPmNefWgo5JCnqopR3aLtIZYFZNAr+FUtX
         Mbp1yp6r56DRn+31aEjtB4hKJFkumll/KwfX2WCI3m+p7sf37Z1lvR+jaAIWkCYHhKaY
         WKpQPLxPt51/2+B/31z3d3kRFBXy2gJvk39lJhdCVnJYg9uydvvvYrFvVtiHM8M7KKXb
         f14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053882; x=1775658682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9Y5HSn8qHxvvJdhLmXjNMhQ+Dpvj4nqUmRgXhpDfws=;
        b=Hph5sBFzE37bHB6ZQ+eFXGoQNqHvzNX6a3zlN2bizwAsiZBn/H9M1jSxZ1aHA4enQK
         N6AOC3RNrF9SKC89dsjtreXsY21aMYchzESpVbk7tFutFfLADZfdDAySW9Y4afxHJatx
         BrKlkvM84b4LM4Pn7aDAhI9NJ9ty3EbhCrUhOWEc0t2uSFHnOD5mu/yvgnR49PbpCXvW
         ZHAPkZshnhyTOFNg5hKC96ZEocXvWIdJhvJKg48TdvoyE9dJ28U4+K0ME+E3WBUdSVGV
         RL9yf69mu1slBezadFyM00/KMfEd9msQtpYuABGvcapTOB9lff66A5/UVxYKygIxZb0A
         u5Jg==
X-Gm-Message-State: AOJu0YxZvS5yGrMqNCMwBSNcPRltJSMzx4FzYyybbPgDlX8Nz0m6E+iX
	sG4CKjFW8WkV4dooa0ic9z5P0pbceUWgBYTq4pR4lgKVbD95aU3MxRsqhiWMYsiQa+QvQAlD8Z9
	piHcE0Qo=
X-Gm-Gg: ATEYQzzCan0iGegxeHv4PfMuifgifYgfXCV7djAY2jyzXmdad51W6xgeJzBmb2BXPJG
	Rva2S5bNR5eV7tA2ekUCVoVZWoRX5wSiI1FaXc25L4HsyJVbZ9EdCJSTP/l4vATHxMnHSaUc/HJ
	cEmhlZIpnGZMUGCkKr5RdjdEhMBwvJxo/I7z0HnJbNT9ePqjSf7iVzTHhPw5xXI1ESkQu1oovm9
	h2hLXaTVYHyqeW5QjBYOcmCiIaaXVOP2JbtwAZbwraU79ikycJZ1VA8CWHTqiK3Al01FzSn981l
	tpplKigoHOYqmBZKIjl+ZrXRUDzIYPYXtBPoOJKGAPMXMSsbGFbkjGPqtf7gKEJYLWtoBZgE1K1
	opecP2CawUBW4YjACRXchFocrNdo2CrAcBqzlYXtxFsVG73xAaQts4eGPxRIVObvLuE4HZBG/an
	fNWgSwjZcgeSyu1YRcGrtXWC4KLa8H82Ta0exM0qUo8QE+noPeeauYuQcVvwY3oQ==
X-Received: by 2002:a17:907:d386:b0:b99:7697:76e5 with SMTP id a640c23a62f3a-b9c133b2eb2mr277582066b.0.1775053881478;
        Wed, 01 Apr 2026 07:31:21 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427658e4sm199047295ad.48.2026.04.01.07.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:31:20 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 0/3] libbpf: clarify raw-address single kprobe attach behavior
Date: Wed,  1 Apr 2026 23:29:28 +0900
Message-ID: <20260401143116.185049-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today libbpf documents single-kprobe attach through func_name, with an
optional offset. For the PMU-based path, func_name = NULL with an
absolute address in offset already works as well, but that is not
described in the API.

This patchset clarifies this behavior. First commit fixes kprobe
and uprobe attach error handling to use direct error codes. Next adds
kprobe API comments for the raw-address form and rejects it explicitly
for legacy tracefs/debugfs kprobes. Last adds PERF and LINK selftests
for the raw-address form, and checks that LEGACY rejects it.

---
Changes in v7:
- Change selftest line wrapping and assertions

Changes in v6:
- Split the kprobe/uprobe direct error-code fix into a separate patch

Changes in v5:
- Add kprobe API docs, use -EOPNOTSUPP, and switch selftests to LIBBPF_OPTS

Changes in v4:
- Inline raw-address error formatting and remove the probe_target buffer

Changes in v3:
- Drop bpf_kprobe_opts.addr and reuse offset when func_name is NULL
- Make legacy tracefs/debugfs kprobes reject the raw-address form
- Update selftests to cover PERF/LINK raw-address attach and LEGACY reject

Changes in v2:
- Fix line wrapping and indentation

Hoyeon Lee (3):
  libbpf: use direct error codes for kprobe/uprobe attach
  libbpf: clarify raw-address single kprobe attach behavior
  selftests/bpf: add test for raw-address single kprobe attach

 tools/lib/bpf/libbpf.c                        | 18 +++--
 tools/lib/bpf/libbpf.h                        | 27 ++++++-
 .../selftests/bpf/prog_tests/attach_probe.c   | 80 +++++++++++++++++++
 3 files changed, 116 insertions(+), 9 deletions(-)

-- 
2.52.0
