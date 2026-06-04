Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE13BFAD5;
	Thu,  4 Jun 2026 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556610; cv=none; b=Qq56liP6wDOB4v5vGV5gDtvFEZGnUGdqZcojhTLBOoeanpVKQ8sXu0oreuXXkSP94YRBX2nrOVH4WYKE5efWPbPwxPHciXLOXrDgCCxEzH1AbEwe93j1+QRFjOWp62tlFBWmWYS8Zm8TQEX13z1Cvo7oJQrarBI3te4RaYKu/SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556610; c=relaxed/simple;
	bh=sYWnVOFNt27j2PfMKgAyGhP63WJeF4RfxV1Yaro8ILk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yz6HPe3w5al2IDcASY4zm80Hj3d5M/U/n0ATn54pGI1DyDqNWkGd1wHvmuUO0F4riYrP4PDfJnHsYKcbqCRFYuEoMFw0vCtmC9JkXTaJkSf3aRafu3xELNfwFMV/hBIHmXiWhPfGScXtuQao2quv3ewduJfbLOK/8UTv/KeBGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZXOQFSjt; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZXOQFSjt"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CUl0lPjRe9Fv4cZlizX/U8cUnKzR2PLbrEU3Onsdhic=;
	b=ZXOQFSjtQuwdvHuebbpPQdHg8lkZdsyMmksUn0jkGnVc7eMqHo6t9smvvE67alFANb9WonQG7
	c/9MUg/lDs75wIvSJDzA6yahUQkEiwRBIy6gUq3fBcPcY/sDrA1sDMuDlrUj8X1K81cM+CyYHZX
	rX3rVz6Zs/Xx11ESRSXVBK8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gWFh23WZ4z1prL3;
	Thu,  4 Jun 2026 14:55:30 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (unknown [7.202.195.7])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BA454056D;
	Thu,  4 Jun 2026 15:03:23 +0800 (CST)
Received: from huawei.com (7.227.44.14) by kwepemr200017.china.huawei.com
 (7.202.195.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Jun
 2026 15:03:22 +0800
From: Lin Ma <malin89@huawei.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, YiFei Zhu <zhuyifei@google.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Amery Hung <ameryhung@gmail.com>, Lin Ma
	<malin89@huawei.com>, Rongzhen Cui <cuirongzhen@huawei.com>, Jingguo Tan
	<tanjingguo@huawei.com>, <cenxianlong@huawei.com>, <chenzhe@huawei.com>
Subject: [PATCH v4 1/2] bpf: Tighten cgroup storage cookie checks for prog arrays
Date: Thu, 4 Jun 2026 15:03:17 +0800
Message-ID: <20260604070318.2869813-1-malin89@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200017.china.huawei.com (7.202.195.7)

The recent KCTF-reported cgroup local storage issue assigned
CVE-2025-38502 was fixed by commit abad3d0bad72 ("bpf: Fix oob access
in cgroup local storage").

However, the previous fixes are still incomplete. The current prog-array
compatibility check treats a program with no cgroup storage as
compatible with any stored storage cookie. This allows a storage-less
program to bridge a tail-call chain between an entry program and a
storage-using callee even though runtime cgroup local storage still
follows the caller context.

Require exact per-type storage_cookie equality when checking prog-array
compatibility. This blocks zero-storage bridge programs from joining a
prog-array owned by a storage-using program and closes the residual
A -> B(no storage) -> C(storage) path.

This also aligns with Amery Hung's earlier NULL-storage tail-call fix by
requiring storage use to match consistently across prog-array users.

Cc: stable@vger.kernel.org
Fixes: abad3d0bad72 ("bpf: Fix oob access in cgroup local storage")
Tested-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Lin Ma <malin89@huawei.com>
Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
---
v1: https://lore.kernel.org/bpf/20260601095158.1186318-1-malin89@huawei.com/
v1 -> v2:
 - refine the commit message and mention the relation to Amery Hung's
   NULL-storage tail-call fix
 - add patch 2/2 selftests for tail-call cgroup storage prog-array
   checks
v2: https://lore.kernel.org/bpf/31927f33-9db0-4a39-b38a-72b33487979e@linux.dev/T/#t
v2 -> v3:
 - use abad3d0bad72 as the Fixes tag
v3: https://lore.kernel.org/bpf/7b3e1adae5c92153e991ac406b2d334609c36d866b5bf81e4465cf63bde0a79c@mail.kernel.org/T/#t
v3 -> v4:
 - no changes
---
 kernel/bpf/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6aa2a8b24030..f0b61b10f30e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2470,8 +2470,12 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 				break;
 			cookie = aux->cgroup_storage[i] ?
 				 aux->cgroup_storage[i]->cookie : 0;
-			ret = map->owner->storage_cookie[i] == cookie ||
-			      !cookie;
+			/*
+			 * Tail calls keep using the caller cgroup storage
+			 * context, so prog-array members must use the same
+			 * storage cookie.
+			 */
+			ret = map->owner->storage_cookie[i] == cookie;
 		}
 		if (ret &&
 		    map->owner->attach_func_proto != aux->attach_func_proto) {
-- 
2.53.0
