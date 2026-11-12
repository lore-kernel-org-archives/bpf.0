Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504481;
	b=f9Y8O5nvIV1uI42o3nesYMRY/oz95rS1Rm9+Rt+KGthEcmYlBfdDOOefBVnH8gTlqpHt
	 Zk1wTBTvhYqTmG8tW/rwkfQcO8IYM9NYU150AQjSPmn+MlPuCPBGLSJMBjpDniox6Ty1G
	 PmPScSaAdFSI4clt4DeVcxmOOWYibkarnGSR9HYJN8gbxanaGLAXJJP63rHXomc1uH6ff
	 tD9oQwwTx5L7Gruim5SwgJ5YwDUWDzRnulzzJ6s11K5HMn+178gP6bmyPf0e33SBZwi/y
	 l6ftEcmz5tFD/Ot4ymETNP4TumRyjcG9+nKE8cCJAi3EbyU+JJQl9XQ46MvEa6VF5pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504481;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=43yJTFdUbbDcIjB0kRG24W1fz7+BLtRLb3Qf1pKdb4A=;
	b=kytoxuuDhp4hCobP9mWCGgfIxFADpXrgNKt3OYoclJNlSClHdctx9K7yEoBVI33kbNDT
	 N3IK6Qvkw7TgYtWUjO8GfN2oTn/pjXMgVLAn9hxDTUyZLYdmmlK5ATSKbYu92b6Jzb0jE
	 tJ/VCUDNfRYQ7hbpwDQyzzkx4XpQXN4nH+TGTituFF0LTc9nRw1w+WrwmJ9h7K25/F+31
	 QBQ8Yax/F1vcCydvz0wLAi5BgWMBBYsK2YXhI6KygoS375h+xiktxc9AqZR/FCfOyW3WU
	 3wEAMOa0RhTneO028xeHLkZmQ86PPakBU2hLP1wP/FHVN32tF38AU5o0ME1NV2bsN0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kf1C3qFM;
	arc=none smtp.remote-ip=91.218.175.151
Received: from mta0.migadu.com (out-151.mta0.migadu.com [91.218.175.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C666060A3803
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 17:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C666060A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kf1C3qFM
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X+n8YbAeZE+E340VGHNqEaiJkr3PF3d1sBfjR4hotfI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794504479; v=1; x=1795109279;
 b=kf1C3qFMl1RK9ckPued/jfpIJAwA4tAPmcDIF+j+3VNcXNFSu2ckFixpMYuZCuH7cP1bPPEL
 omRzOXuBepWJnQzCPKuHCGHeU+6zc8AFbNKUoTcVsYB4zuWS0LEancxdz8C8ccYfj7BTfPSkRn1
 jzcKwAdeM6cd3k3A5wtVY7uI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6e1d540fee937292;
	Thu, 12 Nov 2026 17:27:59 +0000
X-Mizu-Trace-ID: 6e1d540fee937292
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
Subject: [PATCH bpf-next 2/3] bpf, cgroup: Don't attach to a removed cgroup
Date: Thu, 12 Nov 2026 09:27:14 -0800
Message-ID: <20261112172721.440275-3-shakeel.butt@linux.dev>
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

Attach gets the cgroup from an fd before it takes cgroup_mutex.  If the
cgroup is removed in between and cgroup_bpf_release() runs first, attach
adds a program that never runs:

- With BPF_PROG_ATTACH the program leaks, since nothing can detach it.
- With a link that uses cgroup storage, the storage stays on the freed
  cgroup's list, and freeing the map later writes to the freed cgroup.
- A cgroup struct_ops link is attached but never called.

The window is small today because the release work also waits for
cgroup_mutex.  The next patch stops that, which makes the race easy to
hit.

Check cgroup_is_dead() under the lock and return -ENOENT, the error the
fd lookup gives for a removed cgroup.  rmdir marks the cgroup dead under
cgroup_mutex before it starts the release, so the check is exact.

Reproduced in a VM with debug-only delays.  With the next patch applied,
a link attach queued behind a slow mkdir lands on the released cgroup,
and freeing the map then hits a KASAN use-after-free in
cgroup_storage_map_free().  BPF_PROG_ATTACH leaks the program.  With
this patch, attach returns -ENOENT.

Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
Fixes: 369d9dcd8fb8 ("bpf: Add infrastructure to support attaching struct_ops to cgroups")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 kernel/bpf/cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9258c2669fa8..334237096759 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -988,6 +988,13 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
 		/* replace_prog implies BPF_F_REPLACE, and vice versa */
 		return -EINVAL;
 
+	/*
+	 * The cgroup may have been removed since the caller looked it up.
+	 * Then its bpf state may be freed, and nothing would detach this.
+	 */
+	if (cgroup_is_dead(cgrp))
+		return -ENOENT;
+
 	atype = bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_id);
 	if (atype < 0)
 		return -EINVAL;
@@ -3170,6 +3177,12 @@ int cgroup_bpf_struct_ops_attach(struct bpf_map *map, const union bpf_attr *attr
 
 	cgroup_lock();
 
+	/* See the cgroup_is_dead() check in __cgroup_bpf_attach() */
+	if (cgroup_is_dead(cgrp)) {
+		err = -ENOENT;
+		goto unlock;
+	}
+
 	if (attr->link_create.cgroup.expected_revision &&
 	    attr->link_create.cgroup.expected_revision != cgrp->bpf.revisions[atype]) {
 		err = -ESTALE;
-- 
2.53.0-Meta

