Received: from out-zbxj-a76.jellyfish.systems (out-zbxj-a76.jellyfish.systems [198.54.127.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE12868B4
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744085; cv=none; b=M1s/H+JdYQtX7KkgV51I/OzYldUT/45ySWgCn/s0cel26ROK0+vmUo/xYtWCBJw5mETKvAkIYZVnkiS6SdGb8G7ZB1yYLq3MEl9PG9rQx9Wqp+sLiKs+6F2wnStRgoXZwY1YjAAoksro/CZWLYx8HBvln9v0bUVfoXtCUr1h1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744085; c=relaxed/simple;
	bh=n6I3T9HODFXl8aM/iAv7esgrqP4JSMXFIy9ZJ2xwbxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbEkSIYLye1e5RIT9q9GfIly+wMNUwFEamy3aJDIrp/Qwxw4v/m5lv9L88SyN9tLPrG2Q1Q0Ppzs4e+uUHSuS3OI2U2Np7qRE5Od++CUZ7F7p3xAo69JW/qxQlzdxd7aER5FqHJLw9I7DhT2qCH6XxKKiGQWf2sogC6Z+P94MN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=YsdHeULe; arc=none smtp.client-ip=198.54.127.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="YsdHeULe"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdTmY5yKSz6tll;
	Mon, 07 Sep 2026 01:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788744079;
	bh=/pIG29M/yiUassiOGeJJ5zE9hVMB8+17QKVeUPfZeUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsdHeULe3q6CmPK2wJUXDSAySynCJ7eM5zBlSFNGx/ovsU41K3CBuGE2NMUXV/qf2
	 gkPKMXw+geB9Z2m9qlZJ4gY0/F/4jEssQTK+bqz596BjimeTlDWW6MpAd0hQeNpjkI
	 rfPYWOdMyEzE5VG34QDpCAXt+67cn6EX8kvSKptQR1bdjfs4ewv7/7tAcnoT050NIM
	 mfdRngJ8N7V4IKrWvNz0hkMl7vuiU+BKmykVk6xQ2GGSxsV9WEdpa+2mmw+pDKdZzv
	 7YcG4ZpWK1Fhoq6xEUfcVmjRGsePzNz8e6HCrsJ7EDuCJz0BwwqGIuxAHRfMLgPQHZ
	 i/Jdv5LhL+R2Q==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpftool: Batch bounded hash map dumps
Date: Mon,  7 Sep 2026 09:21:13 +0800
Message-ID: <178874362960.1415955.9584865244247659247.batch-v2-0@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906170819.1212661-1-hi@tychen.cc>
References: <20260906170819.1212661-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Use lookup batches for ordinary hash maps whose maximum key/value
storage fits within 4 MiB. Patch 1 implements batch traversal; patch 2
checks complete output contents around its batch boundary and for short
keys, odd-sized values and BTF formatting.

Changes in v2:
- Send fatal batch diagnostics to stderr. JSON elements arrays retain
  only map-entry objects, including after a partially completed dump.
- Use the BPF multiline comment style in the implementation and test.

Validation:
- All 11 batch dump subtests passed in the integration run below.
- Reproduced the v1 generic error object inside the elements array.
- Injected initial EFAULT/ENOMEM and post-progress EIO/EINVAL with
  strace for -j and -p, both with and without -r. All 16 cases returned
  failure, emitted the diagnostic on stderr, and kept a complete JSON
  document containing only the expected zero or 256 distinct entries.
- Initial EINVAL/EOPNOTSUPP/ENOTSUPP fallback and ENOSPC growth before
  and after progress still returned all 1,025 entries without duplicates.

The injected syscall errors are not a real hash collision stress test.
The batching algorithm and eligibility bound are unchanged from v1.

v1: https://lore.kernel.org/r/20260906170819.1212661-1-hi@tychen.cc
Request: https://github.com/libbpf/bpftool/issues/63

Integration validation: the flags, ring-buffer and batch v2 series plus
recursive dump v3 built together with LLVM 20. All 69 focused BPF subtests
passed in an x86-64 KVM guest running Linux 7.3.0-rc1, with no skips or
failures. The bpftool-map man page also built successfully. This is a
focused run, not the full BPF selftest suite.


Tianyi Chen (2):
  bpftool: Use batch lookups for bounded hash map dumps
  selftests/bpf: Check bpftool batch map dump contents

 tools/bpf/bpftool/map.c                       | 116 ++++++++++-
 .../bpf/prog_tests/bpftool_map_batch.c        | 187 ++++++++++++++++++
 2 files changed, 295 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c

-- 
2.55.0

