Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84E3B3C19;
	Tue,  2 Jun 2026 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385753; cv=none; b=SzvFS8ZwwO0ASdDvZ/QlRp8q8jax6wgyjh4irLgyoGBfittRqGU3UAuc3hWJikToCd0qCBIkif0fWH90xf1J+WEibRd5OLLg/GFFK+YPFB6hctIYhFLMZQnU4h2yxcNwxLpRZ8sywoxn0OE0hYMgtdXsByIWQl1eNVz8xlLq44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385753; c=relaxed/simple;
	bh=MoWPqv5MvyNJ5K/PbF8SKZvggtmx17L3oZ05xdXWScM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KCAKNZe4W/Ks+9DJxD/xyWRNYtmgdJir5+sPnZt+OcWCB0Gm9BVvUP+BEG4BmTeyoQIkT3NgcPXV6rcgvcQH+U4/X4Odg925GcdBL1RWdXVUeQuVLfZ/jRN4Q9bBAl8yuTi/YpNF1osD+7/eJNHUgWQ7z/ZYq8rBKBPT1M2fKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OIhoTUl9; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OIhoTUl9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UEU8iCd7dQXJ/S7eftZ1QwjBouNQBhK6RZWqRz0cE+M=;
	b=OIhoTUl9BwO9vQ8CYJGsBLYxYaGuB+k9Z5oJt2H8ogidNBSwoyUD1uHQLkVspgkHVYjcwJ+4E
	iHa31Z8X3tZ87RQA4CMBwSLf/h5q+Pe6UUGMyTJV52KFV+yukfXHHjr3UPeZgZvJyNZvGyllLMu
	+f9KHS96Y0EkE9hewu/9lkU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gV2VK2Rz8zmV7c;
	Tue,  2 Jun 2026 15:27:53 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (unknown [7.202.195.7])
	by mail.maildlp.com (Postfix) with ESMTPS id D2C084055B;
	Tue,  2 Jun 2026 15:35:43 +0800 (CST)
Received: from huawei.com (7.227.44.14) by kwepemr200017.china.huawei.com
 (7.202.195.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 2 Jun
 2026 15:35:42 +0800
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
Subject: [PATCH v2 1/2] bpf: Tighten cgroup storage cookie checks for prog arrays
Date: Tue, 2 Jun 2026 15:35:38 +0800
Message-ID: <20260602073539.1567846-1-malin89@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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
Fixes: 7d9c3427894f ("bpf: Make cgroup storages shared between programs on the same cgroup")
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
