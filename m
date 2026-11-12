Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508699;
	b=e68j6mUPtoka/jSJbikp9oLQynDk9cnK+zoou6WFCMqNjbvSyK8wnjiiB3cgHOmp8Zyn
	 wBoOtP+0hPBNkwyyT005lLuj2FAPDB/Ju0AQQRgBPFFFD0hOmamf7eHvwdsFCAUV3SnQ/
	 3C33hrk9jaMRnRgl8HuD3r2NZfg/nvnw8EjzCtNnpGvT7i7Nmhh8AxkRb1QHvSPLMZlN2
	 GU53Sgv5whOzH013Ci5c2/0gU5gl5F5pnQCbRasLc3rei7OafnNZpiOdEQ19aK0Kj81wZ
	 j0BGhtrUB1I2c8HVFCeLcme1DFJsyVGQZc391nPvTYJkvQyz0LnoI1zRbP1fItNA36w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508699;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QY5is9RtLyMLeUC3YRVX8Vk8F2XbXaQV9wHoojb4eko=;
	b=l1mZAaF02NxdzVmqzLOw3jJqZwstFrkbC5+Yy9ucnTTG4qHggY569NcafpcFXWAjedGF
	 zdCrTLJjtNhB/Rzf99SP/AvJjWMO/vvLE+Ip38zJri0p1k/r9rCiCfAFosn2+Dp6Px6Pj
	 cHNJJ+vn33j72642o+44xLTxuMGov6PBWi10luej17CCclW8a72ef7SKA/j1bWnsqY7vt
	 qaLk5RfdHcM+8AGpf5wzfFlwZutdn8+wKmW/6E9VXIU0P9umf+p5mBHsHSaQGKPj6DBz7
	 jGbLvF9u5iS/CKAi+WbuueJS629a0Tnl6bksfEJ0WHFk3gO4k0FkQK8WluM6RmG13YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nfMdGc36;
	arc=none smtp.remote-ip=95.215.58.125
Received: from mta1.migadu.com (out-125.mta1.migadu.com [95.215.58.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43523606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 18:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43523606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nfMdGc36
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sK8MCNxvFgMKq/D0bjVj2QtnGQtRotR84ghf/Rgf2uo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794508696; v=1; x=1795113496;
 b=nfMdGc36XTWFxNt4irRREV+Gfyxp1YjUASb8exVEPZGrUGTdID5QNeFWniUQW4nyn42FLtmv
 gVdjD7ft63oBkeGQFaXRD1Q7nUMnPKUdFF54RYhm+3TKWiDWRabsicunAfysmS9/DIidqEDsoj+
 CajguF6POsDnQg25aXm5IuVI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bd651488b6e2ad80;
	Thu, 12 Nov 2026 18:38:15 +0000
X-Mizu-Trace-ID: bd651488b6e2ad80
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sashiko <sashiko-bot@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf, cgroup: Don't lose errors in effective BPF_LSM_CGROUP queries
Date: Thu, 12 Nov 2026 10:38:03 -0800
Message-ID: <20261112183804.1171535-1-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An effective BPF_LSM_CGROUP query walks one attach type per LSM hook.
__cgroup_bpf_query() sets ret to -ENOSPC before the loop when prog_cnt
is too small, but the effective branch then overwrites ret with each
type's copy result:

- If the buffer runs out exactly at the end of a type, the last copy
  returns 0 and the query returns 0 instead of -ENOSPC.
- If one type's copy faults and a later one succeeds, the query returns
  0 instead of -EFAULT.

Return -EFAULT right away when a copy faults, as the non-effective
branch does, and leave ret alone otherwise.  The copy helper then no
longer needs to return -ENOSPC.  That also removes a false -ENOSPC it
gave when a dummy entry followed the last copied program.

Reproduced in a VM with two BPF_LSM_CGROUP programs on different hooks.
An effective query with prog_cnt=1 returned 0, and so did one whose
first id slot was not writable.  With this patch they fail with -ENOSPC
and -EFAULT.  Queries of other attach types already did.

Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/bpf/sashiko-outbox-211618@kernel.org/
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
This is independent of the "bpf, cgroup: Don't wait for cgroup_mutex to
read or free cgroup bpf state" series [1], which changes nearby lines.
The two apply cleanly in either order.

[1] https://lore.kernel.org/bpf/20261112172721.440275-1-shakeel.butt@linux.dev/

 kernel/bpf/cgroup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 57a785241d42..2bffa9f659cd 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -424,7 +424,7 @@ static int bpf_cgroup_array_copy_to_user(struct bpf_prog_array *array,
 			return -EFAULT;
 		i++;
 	}
-	return item->prog ? -ENOSPC : 0;
+	return 0;
 }
 
 static int bpf_cgroup_array_delete_safe_at(struct bpf_prog_array *array,
@@ -1505,7 +1505,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
 							      lockdep_is_held(&cgroup_mutex));
 			cnt = min_t(int, bpf_cgroup_array_length(effective, atype), total_cnt);
-			ret = bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype);
+			if (bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype))
+				return -EFAULT;
 		} else {
 			struct hlist_head *progs;
 			struct bpf_prog_list *pl;

base-commit: 2e14a351662dc5a3b7421d210049c59edd0425d2
-- 
2.53.0-Meta

