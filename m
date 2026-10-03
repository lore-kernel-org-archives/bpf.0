Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973BC46A5FD
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791043421; cv=none; b=O11JhKgRGU4zc0luJC1IjJ3YABNoMCW/d4cglm3OOiNdx7ZU41uttsb1P74RyTid7+rauzzQzc3ZPwr2C2L+9902ymQg0Rcckg5XR1ENJbQiV6il22/7haadDFvogbEJzh5z9zWoKVxUU90cJ3C+DZ7tQYxBa7pDuNvvEz4sUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791043421; c=relaxed/simple;
	bh=58IlFyHZbXY4LtMDtfnJoqJDpyVoHC6P0ZPHOmyUTis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkmoA8UgGuW14hfECQjLo51eoPzRzrnLmCRii2jzdfrtd/iHM0lXCSGNyBFbWDi2Eoun9cPUl8ooh+ssr0PSzapOpuXI3l+N8KQLkNO3ZMCnItSATUglRuDxY7UDVnbATwIdOFlw8HeXvNkzWbmxWG91uceEkxuR0KKnZ9JTHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=IhnPmttV; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="IhnPmttV"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8186F82D90;
	Sat, 03 Oct 2026 18:03:33 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uHKzWHK4yiAW; Sat,  3 Oct 2026 18:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791043412; bh=58IlFyHZbXY4LtMDtfnJoqJDpyVoHC6P0ZPHOmyUTis=;
	h=From:To:Cc:Subject:Date;
	b=IhnPmttVFvByzVR2JyxZGQbzZeS+sH9d2zslDydNJVM5DUnJU7Yo0auTEC1FEobZW
	 ho/qy/NGFzf3c85YBM3kVexYTHMrpq1jH8kgF6Ps0GybK+B96WCr4EkNqK8q9RtF6F
	 daFJx+blWSQL4UNGHwCHOssrOUlgrPswYAPPdUDnp4b4AyaYHC9zpe4hiL2EdozLF3
	 MJQBLO8HtBrJPrn06vIRs9VZl8VrElm0Mb2mXaPupcR3eF1dWFFLxuNl1f6ohzB5w0
	 FeSWng1oZgGJIIRROjvW8NRhmoWmvt7liNUZ62mY2LhtPGuZtB1PavG3cAnfibFHw2
	 QZnyJfI12DyMA==
From: Masoud Aghasi <maghasi@disroot.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH bpf v3 0/3] bpf: Fix incorrect handling of user flags by percpu map updates
Date: Sat,  3 Oct 2026 17:02:10 +0100
Message-ID: <20261003160213.2641506-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For BPF_MAP_TYPE_PERCPU_ARRAY map, bpf_percpu_array_update()
is not considering the possibility of a combination of
(BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect
in some cases.

For BPF_MAP_TYPE_PERCPU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH maps,
htab_map_check_update_flags() and check_flags() are not considering
the possibility of a combination of (BPF_NOEXIST, BPF_EXIST) flags
with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect.

For example, when using (BPF_F_CPU | BPF_EXIST) flag combination
with bpf_map_update_elem() on a BPF_MAP_TYPE_PERCPU_HASH map, the
BPF_EXIST flag does not prevent new insertions as expected.

This series fixes the bug by adding proper flag validations and checks
and adds regression tests.

V3 changes:
- Split the fix into two separate patches for array map and hash maps
- Extend the selftest to cover all percpu map types
- Extend the selftest to cover all applicable flag combinations
- Extend the selftest to cover the unnecessary delete issue of LRU map

V2 changes:
- Fix a BPF_EXIST flag check in __htab_lru_percpu_map_update_elem()
- Add additional test for BPF_MAP_TYPE_LRU_PERCPU_HASH map
- Add check for BPF_EXIST, BPF_NOEXIST combination in percpu array map

Masoud Aghasi (3):
  bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
  bpf: Fix incorrect handling of user flags by percpu hash map updates
  selftests/bpf: add tests for percpu map flags combination

 kernel/bpf/arraymap.c                         |   5 +-
 kernel/bpf/hashtab.c                          |  11 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 159 ++++++++++++++++++
 3 files changed, 169 insertions(+), 6 deletions(-)

-- 
2.47.3

