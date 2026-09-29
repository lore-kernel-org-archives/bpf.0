Received: from mta0.migadu.com (out-52.mta0.migadu.com [91.218.175.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C323D4F7CDA
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725586; cv=none; b=s6a3H0fnHMuxLQSqTxuJk5P5+RUscrHbF52KwvQx6a1d1ehulrFDYYkLGQm3nRnyyrRrb5jLif2sAd+kMMdM7D7QhkYZ7wq+HMi8joBKZRx6vbVOYn7z67BLDgikTeJQQaCWnVZCveunjB0JyCxd23wmMzn5qWGdilzo3Ev9HL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725586; c=relaxed/simple;
	bh=SjZ6yUO9LElwKmNgWKK2MK6ZwGoN3GoOlYzvfsrO2mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDQV+VvSxl1Vythr5of/9SSzqujtNmkNBSiIlTT9xKkdcfqShGP5TZk51in5PjzIKwZhn4/iaCFMJuYsji3nYxS+gMQdec9CHWOhWzHD/d4GOvUG2/vQNaNvTd44VvP/vijBrw+idUVXycFZPEiojObY1X5De7UzvDfNIOo1IuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XU6jaxZo; arc=none smtp.client-ip=91.218.175.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XU6jaxZo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SjZ6yUO9LElwKmNgWKK2MK6ZwGoN3GoOlYzvfsrO2mA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790725579; v=1; x=1791330379;
 b=XU6jaxZoaJVgFz+myKLtf6aRzt67xTbUmm2ADIPgRk8kdAsN8yXBfWeXptIiiqlWPhfCUjhA
 sel0iQmQ0ktuC29OAKRWMSCZvtbpeiR5KnAPwA1OuaavpNX9FArXkXxwHYRTBgIoU07CSB1/bqg
 2MiLV2iW+NO7jefR2dJee3Aw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id be52869c0f966f1f;
	Tue, 29 Sep 2026 23:46:19 +0000
X-Mizu-Trace-ID: be52869c0f966f1f
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v2 0/5] libbpf: Render decl_tags in btf_dump
Date: Tue, 29 Sep 2026 16:46:03 -0700
Message-ID: <20260929234608.48503-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.50.1
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


This closes a generic gap in btf_dump, which silently dropped every
decl tag it was given. The in-tree consumer is:

    bpftool btf dump ... format c

A BPF object now keeps its member tags, such as the "contains:" tags.

[1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/

---

v1->v2:
  * index all decl tags in btf_dump (Andrii)
  * roll the decl tag count back on resize errors  (Alexei, sashiko)
  * new patch #3 with the ASSERT_TEXT_EQ() text-comparison helper (Eduard)
  * fold the incremental subtest into test_btf_dump_incremental (Eduard)
  * cut test_btf_attrs down to bare API calls plus VALIDATE_RAW_BTF,
    with no BTF_*_ENC macros (sashiko, Eduard)

v1: https://lore.kernel.org/bpf/20260917012037.1396254-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (5):
  libbpf: Walk types in btf_dump_resize(), not in mark_referenced()
  libbpf: Render decl_tags in btf_dump
  selftests/bpf: Add ASSERT_TEXT_EQ()
  selftests/bpf: Test btf_dump rendering of decl_tags
  selftests/bpf: Show the tag kflag in the raw BTF dump helper

 tools/lib/bpf/btf_dump.c                      | 214 +++++++++----
 tools/testing/selftests/bpf/btf_helpers.c     |  10 +-
 .../bpf/prog_tests/bpftool_btf_dump.c         |   6 +-
 .../selftests/bpf/prog_tests/btf_dump.c       | 285 +++++++++++++++++-
 .../selftests/bpf/prog_tests/btf_write.c      |  34 +++
 tools/testing/selftests/bpf/test_progs.h      |   3 +
 6 files changed, 475 insertions(+), 77 deletions(-)


base-commit: cc6010e6e5cbe1f743d3011991041f227d976a5e
-- 
2.50.1

