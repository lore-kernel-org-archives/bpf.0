Received: from out-utut-a192.jellyfish.systems (out-utut-a192.jellyfish.systems [198.177.127.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2199E3BB101
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.177.127.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714841; cv=none; b=I1UyI3BzCQzguM1Wq/tVcqHzVtG7CUCFphKsiMFN4UHTfGp623TR7KneZRfRvHLiq537YKwqwkNPJEkCQrWRS2UAEgB7FqJHyFmeisN+E+uN4wFwln4sCZHZa65428oKle6EQSOEgjRnrw9ISMYUhJFm/r0VxB+UjYeO+Zq7UGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714841; c=relaxed/simple;
	bh=2b23jT/1kjOqH8BRmk7CLrX6Chq+LJMj4GXIy1vRE80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sF2tL277qhJ9OP5OeSnaoYA6/EBYIvXpcSR5WfbX1AUXgFXbbPp88Rjl9adQYC2YLwzVXFTWn/NLd0Yd7ppBbjmwzRBVNjrQyvlLWqOXfv0JJQHl99PJpZx7gZInavTo4ykdvmqW3Ih8o9AQLuELsUg2OTAWcK1ySgT9kOXvsUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=ZKUXOXpy; arc=none smtp.client-ip=198.177.127.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="ZKUXOXpy"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdGqx5cD6z8sXM;
	Sun, 06 Sep 2026 17:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788714515;
	bh=JQbjvBUDVP1ZyLhhvWolMUVo976ILHcfpW32yZGBx+c=;
	h=From:To:Cc:Subject:Date:From;
	b=ZKUXOXpyFTFs9dvSNajVxZZ/i/jSYpjHUwx6l+/ajiXdWRJ052wUEUijoVEMQ4S6X
	 Yr5P0hoE+HwYneieqYrv9x19c8ckjOGEYQiPFMukqkt0W28TjRLgkm8QI4WkGQ9U6Z
	 q+NbvP6sS/Y35L88q+slInBCyfA+vmO5M5FuDz522HbPrtLp6FXnpBucoNJQrQntzC
	 EGeH4gRgSV9raZV8pmd3aGeA1FeR5074amciPBtMp5dIY9nQ6qiiqrAcAQ4JWJwdws
	 0m+pMfcN8FySyPqod+EAqze8VpDtwcsxein5jduCncqN7p7THA3vCP4vCvd77JqQt2
	 V7l6s9iWqwiAw==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpftool: Batch bounded hash map dumps
Date: Mon,  7 Sep 2026 01:08:17 +0800
Message-ID: <20260906170819.1212661-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

This series uses lookup batches for ordinary hash maps whose maximum
key/value storage fits within a 4 MiB budget. It retains the existing
formatting and falls back to individual lookups if the initial batch
operation is unsupported. Other map types keep individual lookups.

Hash batch lookups need room for a complete bucket, so ENOSPC grows the
buffer without advancing the cursor. The memory eligibility check makes
that growth bounded even after output has begun. Non-ENOENT errors do
not expose untrusted counts or trigger a duplicate dump restart.

Related request:
https://github.com/libbpf/bpftool/issues/63

The series is based on bpf-next and does not depend on my recursive
map-dump series or the flags/ring-buffer series sent alongside it.

Validation on x86-64, Linux 7.3.0-rc1 in KVM, LLVM 20:
- Full bpftool build and focused BPF selftests build.
- All 11 bpftool_map_batch subtests passed against a bpftool built with
  only this series: complete unordered plain, JSON and pretty JSON
  contents, batch boundaries, short keys, odd-sized values and BTF.
- strace fault injection checked initial EINVAL/EOPNOTSUPP/ENOTSUPP
  fallback; ENOSPC growth initially and after progress; fatal EFAULT,
  ENOMEM and post-progress EIO/EINVAL; no duplicates and valid JSON.
- A map exceeding the memory eligibility budget used individual lookups.
- On the same static 100,000-entry hash map, BPF syscall counts dropped
  from 200,004 to 395. Five untraced runs had median elapsed times of
  0.774 s before and 0.734 s after; text formatting still dominates.

Fault injection simulates error returns; it is not a real collision
stress test. Only focused selftests were run. Strict checkpatch has no
errors or checks; the new test file is covered by existing MAINTAINERS
patterns.


Integration check: these three independent series also applied and built
together with my previously posted recursive map-dump v2 series. The
combined 64 subtests passed with no skips or failures in the same guest.

Tianyi Chen (2):
  bpftool: Use batch lookups for bounded hash map dumps
  selftests/bpf: Check bpftool batch map dump contents

 tools/bpf/bpftool/map.c                       | 113 ++++++++++-
 .../bpf/prog_tests/bpftool_map_batch.c        | 186 ++++++++++++++++++
 2 files changed, 291 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c

-- 
2.55.0

