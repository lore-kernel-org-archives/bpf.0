Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6EE38BF9C;
	Mon,  1 Jun 2026 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307540; cv=none; b=a5NzWHuCYuVeKmvHTetfVZx/2rBlIySd+aM1olaxiqxPWdpQVzA9+I4EJZODcDcLzuo4uCD038h+SdnorIiH8eBT5MPRR5FqDnESTiDMN8IsUzfR1/kRoyB6O0Z3m7YwceiUsFSzIm26wIVyF4BzNeVa+6CRv0DHvMdq4V+QK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307540; c=relaxed/simple;
	bh=jGUTUjukPThDAm5UmqerKi4rHF2VN8WopSTiAZZ46kI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ExTCQlT8mVkIQ3torgMRg1v/GUrcCy0gTcXaO4xMley4Cdkw+F2GnjbtlpbCgwXJIWa96I6+LYMPXjfa3uK8tqLMl7ctT6thME05xOcS/VaU662PI/YzVRmuRc9+T6GK1FvJ4sRNLxeRAuDAUAOmqg4ECERwRCJyveMyT5d2pKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZI/0jLxF; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZI/0jLxF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=om+loXuyzVMvM/RZ07hWwkahRUjsgZoZ8BdW3xtNh5Q=;
	b=ZI/0jLxFLDmamOw4fYb4hpGxq8soq2oRdTYEDQ+WptgRT4YYN0H6Odni1U+ALIi7v6haVX5j2
	7avXXleTaY1f5ZuqtVywaP24y8jddwU9OrsWEFv2bF9204oHJBCYEavHPIcnWmEwJ4RIbbNb3gy
	iMPX8mWXFzOjkxcgPY+PCV8=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gTTZ13qc9z12LGX;
	Mon,  1 Jun 2026 17:44:09 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (unknown [7.202.195.7])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DC4640569;
	Mon,  1 Jun 2026 17:52:06 +0800 (CST)
Received: from huawei.com (7.227.44.14) by kwepemr200017.china.huawei.com
 (7.202.195.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 17:52:05 +0800
From: Lin Ma <malin89@huawei.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, <cenxianlong@huawei.com>, <chenzhe@huawei.com>
CC: <bpf@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, YiFei Zhu <zhuyifei@google.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] bpf: Tighten cgroup storage cookie checks for prog arrays
Date: Mon, 1 Jun 2026 17:51:58 +0800
Message-ID: <20260601095158.1186318-1-malin89@huawei.com>
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
in cgroup local storage"). That fix addressed the direct mismatch case
in tail-call chains.

However, the previous fix is still incomplete. The current prog-array
compatibility check treats a program with no cgroup storage as
compatible with any stored storage cookie. This allows a storage-less
program to bridge a tail-call chain between an entry program and a
storage-using callee even though runtime cgroup local storage still
follows the caller context.

Require exact per-type storage_cookie equality when checking prog-array
compatibility. This blocks zero-storage bridge programs from joining a
prog-array owned by a storage-using program and closes the residual
A -> B(no storage) -> C(storage) path without relying on partial
BPF_PROG_TEST_RUN special cases.

Cc: stable@vger.kernel.org
Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")
Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
Signed-off-by: Lin Ma <malin89@huawei.com>
---
 kernel/bpf/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8b018ff48875..dccd47c92992 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2459,8 +2459,12 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
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
