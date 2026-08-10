Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8763AFCE9
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354143; cv=none; b=KNdqkMuyeNViSVxK3UGEqcrJdHyBUILbHs17qhwC4m/I1YWGu+Df3EIx5R7M3OgRMNZZTBxXklNNWracHoxxVDVpLb7eGG4KN369igCStZ6nC4zFPG50CXHum9y7AriQCb8AbV2CxL961+MY2Eh40rPvWKyXmp/NR62dUnJk3Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354143; c=relaxed/simple;
	bh=KPES4JrTwCFojpQ7Sw3oa6vz1gBO0tvJlSXwxwjJg6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cps5/xCIKQ3y+uebPQ1QL0o944/wNNqCcdVA1CzujywSgEGyIpA/FOyq4ApOAGMMXzVL2wV680bDAtq6q/CzheP4nt76zGf9ir80hBAmtRwAU63swN3EK/XBN+7Oa7mMKWpWLp5jmAb8OwtNoZNkOR3bpCxM9HsK0pLuF22hv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=grs0wG8F; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="grs0wG8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=MY
	s/7id7igLxSOWWOXK0AS7rpr2TvsQUirqFSj7RuOU=; b=grs0wG8F2EaJatq6y1
	lM8Bcg1XncCkVkFQWvKbKgA9E2dm6pvjpykwYBG0yBVE/EDhRdxF+uDEeWBDsEO4
	wpSC4V87hbXmfz/hAi99axEOKYC4aPRxe4VtR0EVuKjZwY9cqzNOGgJ0awwSEzV4
	L//l+3Jt7g/Db/X6nHyxBpThA=
Received: from nec8-i7 (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXP0C3mXlqOjt9Lg--.4593S2;
	Mon, 10 Aug 2026 17:28:25 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf v2 0/2] bpf: Fix queue/stack map u32 index overflow
Date: Mon, 10 Aug 2026 17:28:12 +0800
Message-ID: <20260810092814.2698521-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDXP0C3mXlqOjt9Lg--.4593S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1xKr1fZw4UJw1DurWfXwb_yoWfuFb_u3
	4jkFW5twsrGF1YgFW2kF1rZ3y0k3y5Awn5ZFykXrW2q348Xr48uFs5Cr90gFW7Jw42kr98
	trn8Gw10gr1q9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU10zutUUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAhmNS2p5mblasgAA3G

From: Yuan Chen <chenyuan@kylinos.cn>

The queue/stack map addresses elements[] with the product of a u32
head/tail index and value_size, but the storage itself is allocated in
64-bit arithmetic. When max_entries * value_size exceeds U32_MAX, the
product wraps and push/peek/pop operate on the wrong element. Patch 1
restores the dropped bound check; patch 2 adds a regression test.

Changes in v2:
  - Also reject max_entries == U32_MAX: the u32 capacity counter
    qs->size (max_entries + 1) would wrap to 0 and permanently break
    the map, as pointed out in review.
  - Fix the multi-line comment style in the selftest, as pointed out in
    review.

Yuan Chen (2):
  bpf: Fix queue/stack map u32 index overflow
  selftests/bpf: Add regression test for queue/stack map size limit

 kernel/bpf/queue_stack_maps.c                 | 10 +++++
 .../bpf/prog_tests/queue_stack_map.c          | 45 +++++++++++++++++++
 2 files changed, 55 insertions(+)

-- 
2.54.0

