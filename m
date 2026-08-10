Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0538F3E51E2
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370428; cv=none; b=Qpc3SgTRH0GyavuawgaxMehruM0jftjOFA+wqMZdEn92uIY45Qu70Wpl3HMVBjEC6HgvQmUccm12v+IYR49lHmMun26ZgE3FO8yKKk+RMtjBkwsG39RFWbmIDJhEGwiOM6svSiCxKBJ6kjhj/Kfvg2x99pdrqX09ekydeGxb5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370428; c=relaxed/simple;
	bh=b0pLJqbMWYNH0d+qmXl7e3R8DMAG3yfn8rlM2pB4jw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lB76RcKVqi4BR1oFNBbznt94O0BGIKfm0xcPP1vZ+Sri6940jTn/jxpkjEZt7kqY+FRo5GNloLc1mlawI5SmawRdWgs3g8IMu4Ygp3SdNPLVu2lDjdkKB1B29iwiNoIPkeSq9dCXxzBPiW7zENeU9+Fn3fCz8GQXAcun4nK0MXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ef0/MZcY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ef0/MZcY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c9
	Qn9hsMMVNOK9qgbVkDEbBNsYtxf4LaHf+QVll2BKk=; b=ef0/MZcYgzhlmptCZ8
	DPYO768VVAqiQUVqKuXdnl/+rUms+nIGAmVOQamYwJosOFG8pptkgbYMjxoh4JBH
	AOMIurV8fwlXEAoyevWWiR7AYbcY48MwzWGnRayXGMVw7HxmfcS0+09UTgAaxNn5
	caPRCUiwkkQTpX28FdLIxx/n8=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3X7VQ2XlqRT48Og--.14699S2;
	Mon, 10 Aug 2026 21:59:45 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf v3 0/2] bpf: Fix queue/stack map u32 index overflow
Date: Mon, 10 Aug 2026 21:59:32 +0800
Message-ID: <20260810135934.2887684-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7VQ2XlqRT48Og--.14699S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy5XFy5uFyUZw1xtF1kZrb_yoW8JFW7pF
	W5tanag34kJr47ZayfAa17WF95GF4rXF1qgF1ft34rA3s8GryxGrWIgF4aq34rArn3Ja15
	t3Wagr4kK3yUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJnYwUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5RGDQWp52VHzigAA3U

From: Yuan Chen <chenyuan@kylinos.cn>

The queue/stack map addresses elements[] with the product of a u32
head/tail index and value_size, but the storage itself is allocated in
64-bit arithmetic. When max_entries * value_size exceeds U32_MAX, the
product wraps and push/peek/pop operate on the wrong element. Patch 1
restores the dropped bound check; patch 2 adds a regression test.

Changes in v3:
  - Fix the Fixes tag: the bound check was removed by a37fb7ef24a4
    (which dropped the bpf_map_charge_init() call), not by
    c85d69135a91 (which moved the check into bpf_map_charge_init()),
    as pointed out in review. Add Cc: stable@vger.kernel.org since the
    bug affects v5.11+.
  - Define U32_MAX locally in the selftest, as pointed out in review.

Changes in v2:
  - Also reject max_entries == U32_MAX: the u32 capacity counter
    qs->size (max_entries + 1) would wrap to 0 and permanently break
    the map, as pointed out in review.
  - Fix the multi-line comment style in the selftest, as pointed out in
    review.

Yuan Chen (2):
  bpf: Fix queue/stack map u32 index overflow
  selftests/bpf: Add regression test for queue/stack map size limit

 kernel/bpf/queue_stack_maps.c                 | 10 ++++
 .../bpf/prog_tests/queue_stack_map.c          | 49 +++++++++++++++++++
 2 files changed, 59 insertions(+)

-- 
2.54.0

