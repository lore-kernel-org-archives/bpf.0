Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E035BDB7
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027275; cv=none; b=bW0WgAWzKCF6pu5Hh/gzzh2MYZ7jrgtsBYuefXO5mWO414RjFzXEy7drlYrUnYBSkF50Iow0OcV/SgaNbl3ukE/cUpnoiobWlZM+NdNyBj1K54l429n5XFmQmyWE71C3ciDpHC4oSKKHg/MHrVX4BzAJzCY/hZPaICTR76VcqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027275; c=relaxed/simple;
	bh=ARJth2pjCQlJeXMOXnHHMJU6DiAGOB8W+kVtGKy57EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uu2EMeV69L5qOHSN85YP3YslUcrhL3c1taZxWktSVdlCFTmRNtpDoSUTqzmSYnKlvhv073BVs40lpOujL2JFTVj7T9LCFYvESIfo8fjfUBxcFAcKe8Z8HmSLyAD8bzeAV+mno7wiCjWdA3KNHNFwVITghJXcMmO6oGKkrRWvk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SBcic21k; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SBcic21k"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso67146565e9.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775027271; x=1775632071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NS41J+/f6Vz7WCv2ARKA/Hb3yrSpGQX+eQMfkJUzbbg=;
        b=SBcic21kPID/TR8BrpDO8CElsW915ZQYL6GMSNw+O/uJpgTq/rZFcFd2Xk1E4lD9xh
         N6ViKvag9+XbJqfxZ6bhEeXbZqDVdm/58BPP4BJvBoWHHxSuVQWUoBOhewsbRFqRRcjv
         M38Og1nMHUQgFbajTTxgwAZ//MpTndcm8NdECya4G8a2jQLAMJn2o+n1PMkwT7ib8wF0
         9gujX8VGLjYmv4/k1Qm1gn1eIS9ryZS2oDEIy3J8z/C1cKlYgjoRRiUT/DsWBGOqOLnq
         caiOqwFh62re9suzxpMOGUMz8aT9ee5qyhKIokxSHj6fePGqF5YU0PCTcuhtPtT+wzQ0
         +9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027271; x=1775632071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS41J+/f6Vz7WCv2ARKA/Hb3yrSpGQX+eQMfkJUzbbg=;
        b=ma9sO/I9UJDm6Xhono3ynBCGsG+Nr/WupJBdCqa73J+dPFdSkZsiCPIYlnOKxkfz8g
         Cr2jaEPtcfjAa3ItbsHhzkuGNzYhmVJdZK34O77hhRqGqYcTu7Uz0xRf3Y3Y5guWJfRT
         n5PQ7oY0aJy7gll0x7PKx4t20t3RKXrCqwba/np8qPeSqp5iQLsHQTyv1my8a+AfiCmL
         V1eIW2tIxJS6MUQ36QYT8VXYqm+cHatbcawfFRGs/uew2OolgAjCAkLTZ4O0xgcpiUOs
         NCltKQOh6bUsKWfH+NNPYTyYCYQdPTeJxASW8/0VX1jEGX/HsCyEIjA7DPYvTNuWZkdD
         8pBA==
X-Gm-Message-State: AOJu0YyLqOe1/HO4wvqf7N/FNzav/kXZO7H14tP1VWyCPPNJs3cviYaO
	e9Fn/URsvG7KyIGonOQt7zt0FuuaOyKoC2V6nmeFL+pEujdRt4sxQCuPfKqPTRIIL6nmvAeS1XS
	tD7Yb6Ok=
X-Gm-Gg: ATEYQzzJ57gtD8XEEb7rqe2pffOk0/uv11yj+swVB9vbM8D6UY1T+tvu4f2jc3hUNaM
	o59P6GFLwyc599F35NH5y61vYJdPeUZWiV4z+9gTM91U9UW7aKzcCO61JHrm6rPz57D/GDkNtjB
	ix0h5WTwAB/S6E8ZHJ2EqV8uodZVetwpgAYLd0ID2F9OmG1iJqIWWAa5fBpa7kZAH4RKi3SIH/Q
	/5GbaV1jCI/rpOnJNxZaiMK0gy0JhgAxZEO9iW9HsChKE56U1pswaKJmV3gywhuPcI1Sa+o+vvo
	eAXr3JxiUm71bZJyARVhiSY0LnEPc+JI4Dt8LwCnPxRfJky2sT1LootPosa6CcesKNHQzeur+X7
	IatKMPOYc88iC23t9MF8aUzTeykowtf/jB33wjUg8ZmGZOYYELyZigqvEMBIeaEdc78y2kvqG9q
	sbAseT5Iu+YgzehLWON6PdycSmlwBRmZCKNhrQXiV4ckXHCJzSTGUsG/qP
X-Received: by 2002:a05:600c:630f:b0:487:288:1198 with SMTP id 5b1f17b1804b1-4888359da58mr31459045e9.22.1775027271355;
        Wed, 01 Apr 2026 00:07:51 -0700 (PDT)
Received: from f16.suse.cz ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a887e3sm15355778e0c.18.2026.04.01.00.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:07:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/3] libbpf: clarify raw-address single kprobe attach behavior
Date: Wed,  1 Apr 2026 16:05:01 +0900
Message-ID: <20260401070738.122709-1-hoyeon.lee@suse.com>
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

 tools/lib/bpf/libbpf.c                        | 18 ++--
 tools/lib/bpf/libbpf.h                        | 27 +++++-
 .../selftests/bpf/prog_tests/attach_probe.c   | 82 +++++++++++++++++++
 3 files changed, 118 insertions(+), 9 deletions(-)

-- 
2.52.0
