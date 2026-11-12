Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504479;
	b=Xc5UAKbkBTCtrj6OevovyDay31qKZbl7OjDdAWAg983ZpjZ5vJ+/VDz7P/2hpP/OAqaL
	 ZQzL1zwY15EhNVmJqfXg2AKMEOiLQ6epCEr/TLezh0t7tEOGjaYW+CmK+p2m0bddM7clY
	 OltHt0FwPbGPsdZw+duu73sLX7qlnc0AdKGRfguxCPevqitmxoY8EGby3aqV9RkeSMfct
	 sHAiV6cCggEZ49+eUIX3lmXZRvY282QsGcVGhI0EJkb2IjcPma3xoNWLZBSC73g/RmJ1/
	 CmmlOkS1eXuOFFBb8g/21DmSLhNOiAb0S987W/lVdfzZY/h+y5/wE8m6gMTDfU41ieQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504479;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=msn9KDZfrO0QD3fBAuONrovFFP9yIYwzBUbwG0cCJrM=;
	b=Jzm/Q/I+9HAzjrVXjzcmgw2YwwIjs16xQz+9yv1rmshugLti9zwis4iB8Srw1XeemELE
	 gF/fbd1KgSu/nkLb4rEebNFPU3RoluPmANnVubOO4cuEDHoy0IGIAmk6spvcqFb4NrhPh
	 pf3lrpAQoh0AIA75QdMwZSXULM4WhZzUscd6lve2L5BFQA85YqWZo3lPT0rWoxVmvZ9Br
	 srTW3IyPDkePLxaoytgsQ5syX4P1J/7NqBTgJgmCqmn8V9UdibepRShNhcpOYPWNsycZ3
	 GcpaRzbMH9qXSeGIrB8vSPOZdFp7+KKwURe8AmxDQlekK2PEryCrFCULRt9+de2+iVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dhQ9O0UA;
	arc=none smtp.remote-ip=91.218.175.147
Received: from mta0.migadu.com (out-147.mta0.migadu.com [91.218.175.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39A60A263E
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 17:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F39A60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dhQ9O0UA
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TST9E/y57Nvizr+gsVIQqWA7f/dSY+xcgKykPeBhINA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794504477; v=1; x=1795109277;
 b=dhQ9O0UA/LoXKwaZ7sg5/cB7iMo78P8TY2vVOGJRIuobKH2i9ruTJ348pos8X4Pw/3NyYE7S
 PGcbfakAsJDa+zRl7zIGyZkfBPoAfdfrHa4uNwdjASDz5wq6xt8reb2bU8p6m3R2h+pv4MGcT7u
 vs54oxgsVRhHPPhJ/fJDFXtY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3ebabef697ff486c;
	Thu, 12 Nov 2026 17:27:57 +0000
X-Mizu-Trace-ID: 3ebabef697ff486c
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
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/3] bpf, cgroup: Don't read freed effective arrays in BPF_PROG_QUERY
Date: Thu, 12 Nov 2026 09:27:13 -0800
Message-ID: <20261112172721.440275-2-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112172721.440275-1-shakeel.butt@linux.dev>
References: <20261112172721.440275-1-shakeel.butt@linux.dev>
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

BPF_PROG_QUERY gets the cgroup from an fd before it takes cgroup_mutex.
If the cgroup is removed in between and its bpf refcount drops to zero,
cgroup_bpf_release() can run first.  It frees the effective arrays but
leaves the pointers, so a BPF_F_QUERY_EFFECTIVE query then reads freed
memory.

The window is small because the release work also takes cgroup_mutex.

Check under the lock that the bpf refcount isn't zero, and return
-ENOENT if it is, the error the fd lookup gives for a removed cgroup.
The release work only runs after the count hits zero, and it takes the
same lock.

Reproduced in a VM with a debug-only delay between the fd lookup and the
lock: KASAN reports a use-after-free in cgroup_bpf_prog_query().  With
this patch, the query returns -ENOENT.

Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 kernel/bpf/cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 57a785241d42..9258c2669fa8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1446,6 +1446,14 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 	if (effective_query && prog_attach_flags)
 		return -EINVAL;
 
+	/*
+	 * cgroup_bpf_release() frees the effective arrays once the bpf
+	 * refcount is zero.  It takes this lock too, so a nonzero count means
+	 * the arrays are still valid.
+	 */
+	if (percpu_ref_is_zero(&cgrp->bpf.refcnt))
+		return -ENOENT;
+
 	if (type == BPF_STRUCT_OPS) {
 		u32 type_id = attr->query.type_id;
 
-- 
2.53.0-Meta

