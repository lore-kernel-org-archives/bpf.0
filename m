Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93251A9B46;
	Tue,  2 Jun 2026 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411644; cv=none; b=OJzXhRCXMzqyHtI6MXYTZQDEuhRdxVNVFtIrmepTplz2k/DHrMQ1Kigf3M/yJkHq8HRepKXaZ9tb3sEp9/A95iTv7VEp3iklO3Vitep3SS0/mkhnKZUyhqnoj78UEg3+xIjrvJDmB9Z/6kfFSuGHRqiOExSrp+nkw0gSfhIIQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411644; c=relaxed/simple;
	bh=qEH/cix4wnk9Qp9XXRIOZqqkN1RAuGqUImujvq3mcRQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ao4kpTeWwLBL819AIopIY90jr5ncYW33B2UVCxYlQLZ7Nzxtrjbm7OThzGQBuoZf22qhitR14V1GCCFV6Y7iHV+QiqCsIHzDmL5+t6n7lrDiR/kfJ8bLUuHF8ktleyoBcn6rMQGiKhNDW6ihwM37bU/TyjVf48+durcgc7R1abE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ob04tNXZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ob04tNXZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29FED176C;
	Tue,  2 Jun 2026 07:47:17 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8338A3F632;
	Tue,  2 Jun 2026 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411642; bh=qEH/cix4wnk9Qp9XXRIOZqqkN1RAuGqUImujvq3mcRQ=;
	h=From:Subject:Date:To:Cc:From;
	b=ob04tNXZ9js21k7b4Sv5y9Hzg/f9+gXdqM40Rcgslk2yLTpKXNR8kXZ2o/qbSB6rW
	 mT+B9Dy+aDzm/8lKhO2nJKlMQX3q02WriJqRQ4DsC6oRc0mxrbUVo1VLH0T9frAbbq
	 eIsNILTrXrN2ickVQLrQnG6w2SvNooADELFaizO4=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH bpf-next v2 0/8] tools build: bpf: Append EXTRA_CFLAGS and
 HOST_EXTRACFLAGS
Date: Tue, 02 Jun 2026 15:47:09 +0100
Message-Id: <20260602-tools_build_fix_zero_init_bpf_only-v2-0-c76e5250ea1c@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO3sHmoC/5WNQQqDMBBFryKzbooZWwtd9R4iQZNMHdBEklS04
 t0bvEGXj/f5b4doA9sIz2KHYBeO7F0GvBSgh869rWCTGbDEuqywEsn7Mar+w6NRxKv62uAVO06
 qn0l5N27ijlgh1Uj9gyAfzcHm5RlpIK+Es2uCNpuBY/JhO+uLPP0/oUWKUhipqTNIN23kqwvTV
 fsJ2uM4fvG/g4vcAAAA
X-Change-ID: 20260323-tools_build_fix_zero_init_bpf_only-52232f62fb7f
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Lorenz Bauer <lmb@isovalent.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 Leo Yan <leo.yan@arm.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411637; l=2117;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=qEH/cix4wnk9Qp9XXRIOZqqkN1RAuGqUImujvq3mcRQ=;
 b=7udvvT+S0LaoJXsdjHr1h8LmLWmu4ifqSq5q9LcRnGzCvLCkbHk0iJPp5SlIlQipvdTMaBCR0
 Tqkpx5uTr1/ACUFqmqFzG2t5hLghK7/4xGRv6Myav+kodRw+3XjN2TH
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append EXTRA_CFLAGS and HOST_EXTRACFLAGS to the BPF build.

This mitigates an issue introduced in GCC 15, where a {0} initializer
does not guarantee zeroing the entire union [1].

The common changes under tools to support EXTRA_CFLAGS and
HOST_EXTRACFLAGS are sent separately [2].  As suggested, BPF patches
would be picked up via the bpf tree, so this series only includes BPF
related changes.

Verification on bpf-ci (with tools changes [2]:

  https://github.com/kernel-patches/bpf/actions/runs/26815163486

[1] https://gcc.gnu.org/gcc-15/changes.html
[2] https://lore.kernel.org/all/20260602-tools_build_fix_zero_init-v7-0-631baf679fe7@arm.com/

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Used strscpy() instead in patch 06 (Ihor).
- Added prefix "bpf-next" in subject (Alexei).
- Added patch 01 to pass host cflags to bootstrap libbpf.
- Added patch 08 to avoid static LLVM linking for cross build.
- Link to v1: https://lore.kernel.org/r/20260323-tools_build_fix_zero_init_bpf_only-v1-0-d1cfad2f4cd1@arm.com

---
Leo Yan (8):
      bpftool: Pass host flags to bootstrap libbpf
      bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS
      bpftool: Append extra host flags
      libbpf: Initialize CFLAGS before including Makefile.include
      tools/bpf: build: Append extra cflags
      selftests/bpf: Initialize operation name before use
      selftests/bpf: Use common CFLAGS for urandom_read
      selftests/bpf: Avoid static LLVM linking for cross builds

 tools/bpf/Makefile                                    |  1 +
 tools/bpf/bpftool/Makefile                            | 15 ++++++++++++---
 tools/lib/bpf/Makefile                                | 17 +++++++++--------
 tools/testing/selftests/bpf/Makefile                  | 19 +++++++++++++------
 tools/testing/selftests/bpf/prog_tests/verifier_log.c |  1 +
 5 files changed, 36 insertions(+), 17 deletions(-)
---
base-commit: b93c55b4932dd7e32dca8cf34a3443cc87a02906
change-id: 20260323-tools_build_fix_zero_init_bpf_only-52232f62fb7f

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

