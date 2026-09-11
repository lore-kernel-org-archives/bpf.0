Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595E3E8C64
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095085; cv=none; b=O0e4sXqo7pSxQdtnqsW93N9zYgyuU+aTfJISsjr+osNw+e26oH+NcgLMdyBRtNVwO8Kd7IMlD+atNsfoLQC3CKvmiGke+frt3MV0sf5BSqRKcTRNwL9nh+dzi3U7Zvbfi0u53yBZT5PK6cyHxbkdeaF1UDi+vbSmAfU13+5QAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095085; c=relaxed/simple;
	bh=adp6P5OKfFT52cQ8XgVdWqZTKachPJLzRJa8x5oxkOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=amlamU80JVB9wuWHwe5JmDSIhrDvHD/4+LjZsrrMOkVmxi7zx1cPuKDzD1QxmMYYLIvfZFFGn1jBDYOuiAXH+VElROtoBx3Yl1LFMIWG9txSZSsJNxB+dxwVUJpQ5+BJehwfHHUNMmwFdNxqrVkHcAspbAmh1TQSySGnd558yD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoQzkQVU; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoQzkQVU"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so127572a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095083; x=1789699883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5L3nL/xGteo+UbYMf2jCvbni7Un0S0sGdcig8idii94=;
        b=aoQzkQVUOuOfPDo6QKp3Ip1iNWr5Gsu9ELREMO4oREzf+ZifhHumQW7PW0unwq3u76
         k/P8Nb/xX9bYB0AGNNfLwZxK8aBW/Ciy4gS0diXJICHO7kQIhhyfFob3GhGF+cq0u5NL
         ksIynpZFu8N7B/w337jfXyPy7Rqc0tKOLAdMdWBJ+yiCAf4YoE2qWAZggz4O1PHA8dBP
         UYfIqeGfTNG+NiYb4P5gom9Kd6NVpoWSMrKLN82S0vxpvM6LZZSVf1N0/q8dViIOFWer
         x0TImq0bNHIUzMXWxYuMlUwcjsjC+rTKfn5w5IWGerx977guaf3cWNoHQZbjCBDdxgvb
         dcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095083; x=1789699883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5L3nL/xGteo+UbYMf2jCvbni7Un0S0sGdcig8idii94=;
        b=Y4/TOsCtT/GIl4ufRh1VMD3w1knoK6MfmwfpiI3Mt4EXF4RGbEjF9YFcXQ1lCRRcEI
         scR9eosGAG6hwD0TLUPfYodmpbG0Yv96Y68+r9JkIVI0VRGqYQDaX9jtVzOsADDDnB5I
         vUbRTgle/NQ9sgW+/0ehIgZP3wGk/dRoelnlrRgHrSkn7ERjDwh1h/ZffoZ/gmSBfnpz
         UwjnIIvnikwzJmI7IXv1YI0vRlSD4bql/NmHbWS5Y0RoQlj/O5oCqrUm3lqa8B70oKlb
         UqMZSPzmW+kvoJYYqTloIsuWdk8mlCSGmfr+CVNiBGFZKCxkREhYgnIx0PyuX8SKm1+7
         ECJw==
X-Forwarded-Encrypted: i=1; AKwUvBy8hUIPEW3S2f2+/ev4ioQojRLwVnjVj7o+ornGP8f32+qaC7hBWKHFem3eo+XgPNFcOI0=@vger.kernel.org
X-Gm-Message-State: AFuF++mzU/63K5pRK7LPJdCQ0oSh85Ro0GQiXfR/U7mEjAHdFu2YudbY
	zCltBlmNrrRzb8YvULSmLi3vHV/2epNgWXxO4TEpm6c49qSgzQQjsW4feJr4ZAtzoh+LKA==
X-Gm-Gg: AYBFou3DTX53BcuIY/YjaFsUWmoC9F75amlgkQGZ8VKoK3dt5Jsqo9oadiB980k5ulP
	xe7y1+aO2gSgS5SE+sdXxmrD25ffGAKF5EWtGUrKBYjE9YKD1rOBqn2DRXqVt2MtRRSXYm7Lcxs
	fw5KFANaTJhIuoiJz94sog7R8B8vkitxeJyl1s/4bkFMeWDfH4O9+rgft6SLpU+L8G9aXkJr2xu
	QE2LBBmhzaJ7MY7WxYEKxqx/CIbn1EaZB0lUC15QaLvj4TS2ayYTrjlGMxlXeYkYIdKhbxsk1E9
	A9toobOVRWoTcYizirOi6bPUMRoq2bXaaVCOq66a+M+l0rDG7k25cbgAHz4LhUWfXiDs+YWSEwN
	CvPhvrUG0Oti5Avnl+HRHUvOTv/QHqQ18EGs6NDD28Of0yk0MExCFdUXC09gL/zgaik3CQY5dMq
	6BdUrFZ5c5H6ARxmg2L1cJp3Azyw48oGyo+RpprvM4oPie1kTcYw7Izrd6d28twvw9
X-Received: by 2002:a17:90a:d64c:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39d9c1bf52bmr2850957a91.15.1789095082546;
        Thu, 10 Sep 2026 19:51:22 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95092c06sm2396002a91.4.2026.09.10.19.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:51:22 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpftool: Consume ring buffer maps with event_pipe
Date: Fri, 11 Sep 2026 10:51:12 +0800
Message-ID: <20260911025114.190899-1-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend map event_pipe to BPF ring buffer maps using libbpf's ring buffer
manager. Print complete records in plain or JSON format, reject CPU/index
selectors for ring buffers, and document the shared consumer position.

Changes in v3:
- Remove redundant wording from the manual while retaining the warning
  about consuming records and sharing the consumer position.
- Explain callback stopping and signal handling in the commit message.
- Rebase onto current bpf-next and use Assisted-by: LLM.

The implementation and v2 tests, including pretty output, pinned paths,
empty streams and the perf-event-array regression case, are unchanged.

v2: https://lore.kernel.org/r/178874362960.1415955.14971768495630842802.ringbuf-v2-0@tychen.cc
Request: https://github.com/libbpf/bpftool/issues/54

The previous version's CI PR expired after repeated "Patch is empty"
reports. The revised series applies cleanly to the current tree and is
sent as a new thread using git format-patch and git send-email.

Validation:
- Built bpftool and its manual pages, and built the focused selftest
  runner with LLVM 20.
- All 17 bpftool_ringbuf subtests passed with no skips or failures
  in an x86-64 KVM guest running Linux 7.3.0-rc2 from current bpf/master.
- The four bpftool series were tested together: all 69 subtests passed.
  The cpumask suite (36 subtests) and test_maps also passed with no skips.
- Bash syntax and the existing bpftool synchronization checks passed.

This was a focused run; unrelated selftests requiring unavailable kernel
features were excluded from the build with PERMISSIVE=1.

Tianyi Chen (2):
  bpftool: Read ring buffer maps with event_pipe
  selftests/bpf: Cover bpftool ring buffer event_pipe

 .../bpf/bpftool/Documentation/bpftool-map.rst |  14 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   4 +-
 tools/bpf/bpftool/map_perf_ring.c             |  87 +++-
 .../bpf/prog_tests/bpftool_ringbuf.c          | 425 ++++++++++++++++++
 .../selftests/bpf/progs/bpftool_ringbuf.c     |  47 ++
 5 files changed, 553 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_ringbuf.c


base-commit: af0b84a9215d951d16f26b7ee34353b970cf5d4e
-- 
2.55.0

