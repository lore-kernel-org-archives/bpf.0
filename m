Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D3397933;
	Fri,  7 Aug 2026 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068402; cv=none; b=L+mW7cDliFX4RH2TF2cTAiD/5owLjUQregsc9Ug+bysdNYiBM+4fybYIEWXcQXXXjaZM0xg+y5N5zb6UMehxkJ9aRNtNDlUPk/3bRftpAUNXj9wvHOiTAfrcDHlm95ZcGfXOOgayKdBYWht7TMivDmafzs2L1DmSBkx1Jaz7sDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068402; c=relaxed/simple;
	bh=GDgL1WKNcz8h5AIrqdaLGUntfCPWdgs++72x5MSDQMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sO+VYjSUMEpZFqpT9ndYmuBAV+LLIvheKEgQc2WwfOwdR3tvkncgVNHxmApMhOH01TaDMImjWjYA87+Zh2gOV3hBK7wnnz/ECRAo/fz1CiagyCif399JDv991Syhtw9anaXhkpVT2bdwdw2Q6j64ppgwkFG1b5LFqbQ8Kp2h+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mb4Qvh4W; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mb4Qvh4W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=s3
	ZWBTmLb35k8ONyB0xUbfBFdape8UHufkUiDcHkBlc=; b=mb4Qvh4W1BCtZnOkeo
	SIZyDSC2tOSf9CnQnx9Vnuy1OZuvvy4qcicbPSqqU1e6kGBxtbN+7y41bs/WnHJ2
	LaH9jpDKWwjKSLv+lb92ziFVHof2IMz94G35lMNqP0g4AsnNowQnO07U82wu1a+n
	Fr1nNzu6SxrnI1MWKnrisgkHY=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXnpiGPXVqyp9rNw--.41530S2;
	Fri, 07 Aug 2026 10:05:59 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf 0/2] bpf: Fix queue/stack map u32 index overflow
Date: Fri,  7 Aug 2026 10:05:46 +0800
Message-ID: <20260807020548.1376979-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXnpiGPXVqyp9rNw--.41530S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWkAr1DtrWUZFWrGFykKrg_yoW8Gw4fpF
	Z8ta1rK3WkJw43CrZayw1xWFyfWws3JF1DKasrt34UCrn8GFyIgrW2gFy5Gr1kAr95Za1F
	93W0grs5W3yUC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UG1v-UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5QdoJmp1PYes3QAA34

From: Yuan Chen <chenyuan@kylinos.cn>

queue/stack maps address their element storage with a u32 head/tail
index multiplied by value_size. The storage itself is allocated using
64-bit arithmetic, so a map with max_entries * value_size exceeding
U32_MAX can be created, and the u32 multiplication then wraps, making
push/peek/pop operate on the wrong element: map data gets corrupted and
stale values can leak to user space through peek.

The bound check that used to prevent this was removed by c85d69135a91
("bpf: move memory size checks to bpf_map_charge_init()"), which
migrated only the bytes-to-pages conversion and dropped the overflow
guard, so oversized queue/stack maps can be created again.

Patch 1 restores the bound at map creation time: a map whose element
storage would exceed U32_MAX bytes is rejected with -E2BIG, keeping the
u32 index multiplication overflow-free.
Patch 2 adds a regression test covering both map types and a
normal-sized control case.

Verification: built and run in QEMU - oversized queue/stack maps are
rejected with -E2BIG, normal-sized maps still work, and the
queue_stack_map selftest passes.

Yuan Chen (2):
  bpf: Fix queue/stack map u32 index overflow
  selftests/bpf: Add regression test for queue/stack map size limit

 kernel/bpf/queue_stack_maps.c                 |  7 ++++
 .../bpf/prog_tests/queue_stack_map.c          | 34 +++++++++++++++++++
 2 files changed, 41 insertions(+)

-- 
2.54.0

