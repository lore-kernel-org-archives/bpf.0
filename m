Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A953E2AB9
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560470; cv=none; b=ZBeA6WVo6ZcUxAAXx/TkoLaE1R2OP76CcGdLkNuPYEJADC4bzY0AOnOTe3PRMXgw0zsO3VgJdzrb28EyroRBeEPdTp24RLLb2sCAne2+auED/4o91Armo5e0+kC6Y9vZg9XDQLFPkwkgDqHhd14T1gd4Rvn+s3QvZ1HrOQmALkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560470; c=relaxed/simple;
	bh=y3QFq/DNsYN0yGzEI4vF8UOSjuEGVxSfco6F273YJd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLbg5uxzFYKFCh7/e+Zv1qJtLB5wVQv+9X65c9qU1G+mQsoay4yrjXaeFvhycjqD8R9bU8435RqGrmP8feoL6Cp2Td5cH16/SurjilyLsmqXGB3u6UMGU6+vIYnNp81JdVlBXY+L+LDmGiZpPqMMsPICiuccW4MAe+2Y6/73qxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PtGJkKIm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PtGJkKIm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mQ
	Dp/DqkFdLpQYimekPuf5avzeVl9SCUlxwTnSY4pl4=; b=PtGJkKImvYHUHOKm6X
	2E6dhhFaugBzKNIEHFIPipqq9BNnWF81Q8gUWsUtPacAMroDBA7czHgcF2nscc1q
	jwwIDe19HzqIDCoRkzFRZwD9zLmHgLlVce+VlILmRkuB4OMhEJRfWh+ImTBpzHo7
	B7hZvxkvorlxIaImVaZE9eMvY=
Received: from nec8-i7 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3hgXdAYxqoLE7Ow--.19386S2;
	Mon, 24 Aug 2026 16:33:34 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	andrii.nakryiko@gmail.com,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf v4 0/2] bpf: Fix queue/stack map u32 index overflow
Date: Mon, 24 Aug 2026 16:33:25 +0800
Message-ID: <20260824083327.1708560-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAEf4BzbGe74OuUKiDz7oBrWzQCD54JVhYuCTQEWNHOHmnBEtbQ@mail.gmail.com>
References: <CAEf4BzbGe74OuUKiDz7oBrWzQCD54JVhYuCTQEWNHOHmnBEtbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3hgXdAYxqoLE7Ow--.19386S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWDXw4rXF4rZFykKrW3ZFb_yoW8Zryfpa
	98GF4agrykJrWxJ393Z34UJrZ5Ww4rWryagFn7KFy8A3s8Wry2qr93tF43Xr93CrykZw1Y
	g3Wjgws5G3yjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UG1v-UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAR418mqMAd5aQgAA35

From: Yuan Chen <chenyuan@kylinos.cn>

This series fixes an integer overflow in BPF queue/stack maps.  The u32
head/tail index is multiplied by value_size to address elements[], but
the storage itself is allocated with 64-bit arithmetic.  When
max_entries * value_size reaches or exceeds U32_MAX, the index
multiplication wraps and push/peek/pop operate on the wrong element,
corrupting map data and leaking stale values to user space.
max_entries == U32_MAX would also wrap the u32 capacity counter
qs->size (max_entries + 1) to 0 and permanently break the map.

Patch 1 restores the size bound in queue_stack_map_alloc_check() that
was lost when the check inside bpf_map_charge_init() was removed.  A
single division-based comparison covers both the index multiplication
overflow and the capacity counter wrap.

Patch 2 adds a regression test for both rejection cases.

Many thanks to Andrii Nakryiko for the careful review and the helpful
suggestions: the bound has been simplified to a single
`max_entries >= U32_MAX / value_size` check, and the selftest now
asserts the bpf_map_create() return value directly instead of reading
errno.

v2 -> v3:
  - also reject max_entries == U32_MAX, which would wrap the u32
    capacity counter qs->size (max_entries + 1) to 0
  - fix the Fixes tag: the guard was actually dropped by a37fb7ef24a4,
    which removed the bpf_map_charge_init() call the check had been
    moved into by c85d69135a91

v3 -> v4:
  - simplify the bound to a single `max_entries >= U32_MAX /
    value_size` comparison, which also rejects max_entries == U32_MAX
  - check the bpf_map_create() return value directly instead of errno
    in the selftest

Yuan Chen (2):
  bpf: Fix queue/stack map u32 index overflow
  selftests/bpf: Add regression test for queue/stack map size limit

 kernel/bpf/queue_stack_maps.c                      |  9 ++++++
 .../selftests/bpf/prog_tests/queue_stack_map.c     | 37 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)

