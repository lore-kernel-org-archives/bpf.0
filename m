Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241584;
	b=vngvEH9Oc3dKk/vYCRdyVuNoz3yurKBPMQIGgXOHxxP8nSK6y2JdA3lp9zBqjo6eReLy
	 i+y6J1X5F+8ldtdGlo9LIGM1UF4Rq5qbao7QiGUhsJGdUvyEI5T0JXcR5OJcRjPLfOx0F
	 Oo+OSVjCMcLD0h/yGeAPiHCQHEyoGikkVY4FaQaYsjNQcvito5ojgbBhywi5dvRDYqrKX
	 k1yoaTRIuMeyb2SP+fZ7qkC9GkE+gFwCTVHdt7cRQQ+oEH2FmnCdKBcacnsOAjUl37XDC
	 zUVi6qLdVpqrRedQFkNk4RfbDxXpoxBbXEdeaJJ1FrPyBS1ogqu+n7m19Z3nN82OknQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241584;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JYTMYOha3EaaN25MShhLseRcaS19kSv6xNGMCGJGx0o=;
	b=tEBwjHDf5dzyb2mKsy0zsBvMHRULHYBLND0u8iCfaJ2keu2tMxIZn+FyCcbAMRMIPnaj
	 5lZbcb5X6hpaRxQqO4v0wmWKDOFODjgTX6/6BlhqDVnko9eA03oR/UnxLthRNxLkftE2B
	 7/bcEy55DGdxr5wQZ+EnLJBPpIJ2EQ+nSO+QPaNZ/QTJ3xv68askvzn1PKo1RGhsbjOfc
	 ZRLY/bDL6IPmcWesfTaY3aTjP8gouiUoS/akNtIpzAZ7ie0CHeb3pDRDuMPVc3wxchw6P
	 rpJNRCuNW6cpRtAmwu96yJERteW1zqtpusZVzLor94p/xe0n3oNWz2PjTHGHyPsxz+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJBLQwQU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DD606A336;
	Mon,  9 Nov 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJBLQwQU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DD71F0089F;
	Mon,  9 Nov 2026 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241584;
	bh=JYTMYOha3EaaN25MShhLseRcaS19kSv6xNGMCGJGx0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fJBLQwQUjML5XbsBtFHYpZxpYmuW2AD9G7VNOnMyF8N8ZlXcJryUUUcRYlYy1WyOa
	 VL7WwUOttej9L5Y5TfMsHhx+j06mhKv2HJNe2eZtUnEdQ3ah2OfOjRb6lspcJIEb1l
	 pzqAWXtIzTQWzEXecx0bMP+X7jUjDiQVkSCRFLvVjY7a6ZN1LsqMV0W2PZXgUQ0Etw
	 XkhLaTytjCxlmxNsiegy8werqdYANSFlja4VsxU3w/CX05Esb7adDPyVdvmmOnOCTO
	 qzFvpTHQ9ippUdJDMgzezOhq5ZRzwpHVyQWMFfA2KocZWWtad9z21t58AxDg/EjdwA
	 GO10WqBjQFpUg==
From: Tejun Heo <tj@kernel.org>
To: Zhijian Han <hanzhijian1991@gmail.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH sched_ext/for-7.5] selftests/sched_ext: Fix enable_cmask load failure on older clangs
Date: Mon,  9 Nov 2026 06:26:23 -1000
Message-ID: <20261109162623.674441-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <6af1e5f2.a438010f.130489.ab94@mx.google.com>
References: <6af1e5f2.a438010f.130489.ab94@mx.google.com>
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

enable_cmask casts the u64 arena address of the task's cmask to an __arena
pointer without cast_kern(). Older clangs without
__BPF_FEATURE_ADDR_SPACE_CAST need the explicit cast, so the test fails to
load there. Add it.

Reported-by: Zhijian Han <hanzhijian1991@gmail.com>
Closes: https://lore.kernel.org/all/6af1e5f2.a438010f.130489.ab94@mx.google.com/
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied to sched_ext/for-7.5.

 tools/testing/selftests/sched_ext/enable_cmask.bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sched_ext/enable_cmask.bpf.c b/tools/testing/selftests/sched_ext/enable_cmask.bpf.c
index 0068f3c7ab3c..081be5861424 100644
--- a/tools/testing/selftests/sched_ext/enable_cmask.bpf.c
+++ b/tools/testing/selftests/sched_ext/enable_cmask.bpf.c
@@ -104,6 +104,7 @@ void BPF_STRUCT_OPS(enable_cmask_enable, struct task_struct *p, struct scx_enabl
 	int ret;
 
 	asm volatile("" :: "r"(&arena));
+	cast_kern(m);
 	tctx = lookup_task_ctx(p);
 	if (!tctx)
 		return;
-- 
2.56.0

