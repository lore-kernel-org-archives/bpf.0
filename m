Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096D37E2E7
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021153; cv=none; b=RuEws5IrmVDdKbduhbC59aL0/xLJeoM39fmVioQj4cfFFMcEI7+JY891GHZPFTW4XGER/CUphPiY3obygao+CEJvbX1J03Zp08Apqe6rrnr0wL8isEK5ZYekmtdGfUQJ94Hop64fKlroMH+qRbgSRa1jOOasgTH2Cl93JB0T7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021153; c=relaxed/simple;
	bh=aNdm2JhbZ2WiyTXpxHfBjGRYE95Qs7+KjgpedcL33mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ub3ik0tSyNT0BJyuCstP38wAZcqM2snDTqSQgc7Xnnjx5ACNcur3B2UGwlJ/QzoEdPjHDscv0bSYwocxk18WT+qkl0jYoltlQoEQa66R6bPPKTVHEVK5h71ik5BIwf5TcsMO8Nhyj0S+dC0UkVeIi+OiafCpJ0QlFZHCGeEbi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vb6Gc/AG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vb6Gc/AG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so64200975e9.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775021150; x=1775625950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHmLJsO+aYO4OQ8UwW+JtSR4CppEo4yH/ZY1lD4kj34=;
        b=Vb6Gc/AGeLdX7sAetGiWj7etDlrg6aRG8albk6oj7y3bRmtUmYmrw2kb6DDh0Utz0n
         zHN3c0KQZ3FCo3HVKau00qNd+2l+rbHyxCcZJIEDe44V5wTflY+8Yc1V6hKw2WAFwES3
         QKemGBwAhRFMfISK/q9uAjxJkvT59KpWzyECfkTdqgbqPhJyeGRNsxCWv0adZzDZor7j
         KghspI97HdTQPtW473itEEbPUPUY0xXe0H9YQizFvXtBBe31IVJfmX5hckxxRdLvGXT3
         GVRcSko2GFXEzal+gIPtgYiuZsw3gu2+uEiOepN1Y74YhJp48fKK6HLM34QxCBD8VfXC
         70Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021150; x=1775625950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHmLJsO+aYO4OQ8UwW+JtSR4CppEo4yH/ZY1lD4kj34=;
        b=fz968dALMiQVV5TsFtCwjOHcB0e5nW9bk66FMcceGz1sOjPzxz95XeHfoLFVVPJe/e
         kSe7gMivvnevLyb9rIzsgbj2r3Lth6FR6xvp7002rPjwfqOMk9ULkxZbOsmsO5UNuY9k
         Gwweva7vDkoJ7q9Bc/R8tsWlVM1f6I+/QrKMtU2OThI0s9RVuxPIC/jHXCh+yw9ze5Xl
         xFtDJFY4m17+MI5MGztn42UI0HIa6JYwIfCluTqF3UcG8jWShzoPerOpELlFN6H4CucI
         ROFTCa6DPOlUHOYsOtJOOHvB2x6lNaeSBGzSqPUWt0NV3bKrgvpTBg3EATSXRBgGw/cf
         SNow==
X-Gm-Message-State: AOJu0YwwUMf6aO8+cx7eDAr6iiZlF5+wxb2/P3HlRrHpe1+TUJJ9WUS9
	TzioKWwKAIwuoZl7tIXJ1n4seeaOanqqrl3UJ9WluK+TOQg2yRLMShZ4TmqmuMZQ/IRYiSBfYOv
	b96nTwv8=
X-Gm-Gg: ATEYQzxgDDQlaxsd4g3lsYvfJUD7vQtkblp7c1BHLnvt9MpS7zZsWcXq2JmX3gwXuej
	hRZW9cQlYyW3M3taxr7+052HEz1E/3kYiaf6HOoctMH0Dc/nep7lGw7PHS5uPv7wWabo9tKrzjh
	MD7tgT02tk+Fc3FZHPw13toU/CqoxkcyhjKkM5cRhAxejq7KNJ3xAEhX71MO+zh7XDV1Wxfb6lZ
	shOCcuYJDZSXOFLGTfQ4W+hyGa2fh9/3nxSnhEx2dxCRjFT0hpPMBMu/Xyc7NTzKeHNu8+/LaQ1
	diSsvglMLoIyY0Qe3N8I/lwnqXDQkB3wGSeCFq5quYEeBwx1QyIZctd9HmOAiSrohkMaHhbP5dk
	OIq14bOT7WvEB1t+7eHcu+D7Z4TeN8sN5z9h3GBg0bEyFi5u/QtxtCBlN6p3h2VLZAQYyeJTegw
	pUVgI3nyf+R19rZxIX4k+c7ev28pkn7809BalWv03wSthpaOgzS3T7kUw0NS0wclgD/l5HnxdU
X-Received: by 2002:a05:600c:8b61:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-488835888b5mr33183185e9.13.1775021150180;
        Tue, 31 Mar 2026 22:25:50 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843b818sm15308214b3a.6.2026.03.31.22.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 22:25:49 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/2] libbpf: clarify raw-address single kprobe attach behavior
Date: Wed,  1 Apr 2026 14:25:09 +0900
Message-ID: <20260401052544.100968-1-hoyeon.lee@suse.com>
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

This patchset clarifies this behavior. The first commit adds kprobe API
comments for the raw-address form and rejects it explicitly for legacy
tracefs/debugfs kprobes. The second commit adds PERF and LINK selftests
for the raw-address form, and checks that LEGACY rejects it.

---
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

Hoyeon Lee (2):
  libbpf: clarify raw-address single kprobe attach behavior
  selftests/bpf: add test for raw-address single kprobe attach

 tools/lib/bpf/libbpf.c                        | 16 ++--
 tools/lib/bpf/libbpf.h                        | 29 ++++++-
 .../selftests/bpf/prog_tests/attach_probe.c   | 82 +++++++++++++++++++
 3 files changed, 119 insertions(+), 8 deletions(-)

-- 
2.52.0
