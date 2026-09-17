Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7295369D71
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608069; cv=none; b=XL1gWAbL1zHp1ktJEsCOV0eXJal1DBAZqvR3dg6ECmEz8zy02uQoiGDeziPcybdHuUurm3PWUwphmNwQE0hbAOEgTH2iXv8s+Xxl6d+IO4JkQg6zPXMfDMBTwmknMmf6lpf+L/wCaXD/kJRz2DTRyWXXqnLQnU0nAxqiIoAhLBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608069; c=relaxed/simple;
	bh=B91F099iXljdtWRavuTWJattth2icd3chgnUyb3TFdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWx9zblqrGwGh5VleeoFDMLPplBmgWXyT4u5+npjcHJRtWQ9c7iTM/LGsOcTTWlvPOPI8uhptnEyYgEM6y9gdcKFTNdKLuage/i6c8aKlW4RrsiISBTidKAQHX0RRvNrz6XGWoR1Vy8TdpkdKUWx9MX+TcijFsGXinaBWph8A2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ss+A6DoL; arc=none smtp.client-ip=91.218.175.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ss+A6DoL"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B91F099iXljdtWRavuTWJattth2icd3chgnUyb3TFdA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789608065; v=1; x=1790212865;
 b=ss+A6DoLIrXORCE55xBCX80IR6f1h0ZwJobU3hdKa7D5ER/llRWn2jhpY03hEZ5a2JlPVIsx
 cuPLJMGNJm7+mCQsff47rz1ce2wIDsCrwsnlPAkAh1JtnQpfJEzIMs7QAhi5/N/+s2hGq6ENRBT
 4FhLaHfpnbzWg8MTUvPZGyaE=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id fbd8d82b7ac9bb3f;
	Thu, 17 Sep 2026 01:20:55 +0000
X-Mizu-Trace-ID: fbd8d82b7ac9bb3f
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v1 0/4] libbpf: Render decl_tags in btf_dump
Date: Wed, 16 Sep 2026 18:20:33 -0700
Message-ID: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BTF supports arbitrary __attribute__ encoding via decl tags and type
tags [1]. However btf_dump facility only outputs the attributes
encoded in BTF as type tags, which was implemented in commit
2019c58318b8 ("libbpf: Check the kflag of type tags in btf_dump").

BTF_KIND_DECL_TAG has been left out of btf_dump entirely, independent
of the kflag value. An attribute a BTF producer encoded is silently
dropped from the C output.

Implement decl_tag support in btf_dump. The btf_dump limits rendered
BTF types to records, record members and typedefs. Other types,
particularly functions, are deliberately skipped. Therefore decl_tag
rendering works only for the same subset of target types.

To be efficient, decl_tag dump support requires a reverse index from
the target type id to the list of tags pointing at it.

With decl_tag dump support, provided a validly constructed BTF, it is
now possible to obtain C-syntax output like the following example:

	struct foo {
		int a __attribute__((bar));
		int b: 3 __attribute__((bar));
	} __attribute__((bar));
	typedef struct { ... } __attribute__((bar)) foo_t __attribute__((baz));

vmlinux.h generated in-tree remains unchanged: every decl tag in
vmlinux BTF is a tag on a FUNC, which is not supported by btf_dump.

[1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/

---

The series consists of the following:

  * patch #1 is a non-functional refactoring, preparing
    btf_dump_resize() for decl_tag index build
  * patch #2 implements the full decl_tag dump support
  * patch #3 adds the selftests to cover the new feature
  * patch #4 is an independent selftests change relevant to kflagged
    decl_tag handling

Ihor Solodrai (4):
  libbpf: Walk types in btf_dump_resize(), not in mark_referenced()
  libbpf: Render decl_tags in btf_dump
  selftests/bpf: Test btf_dump rendering of decl_tags
  selftests/bpf: Show the tag kflag in the raw BTF dump helper

 tools/lib/bpf/btf_dump.c                      | 210 ++++++++---
 tools/testing/selftests/bpf/btf_helpers.c     |  10 +-
 .../selftests/bpf/prog_tests/btf_dump.c       | 343 +++++++++++++++++-
 .../selftests/bpf/prog_tests/btf_write.c      |  60 +++
 4 files changed, 560 insertions(+), 63 deletions(-)


base-commit: 10c4f610b215bf961235141161992f010cf7e451
-- 
2.55.0

