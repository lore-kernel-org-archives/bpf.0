Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706B3E6382
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173142; cv=none; b=BQ4Q9T9HQt764r3UGwCpI+jNMDe4iC/3/GOOPPbUWgXd/OCyKhYIHhm8r8zr3QGosOSU9CUtKZYtt3zxIp8RY7iO+1M8JmlV+5S8el1HI0cpv9aqtqSKkiGLKp+AIxqRRUBTLEoDGT2PCn+dvkrlS61/m4Bfg8LjcD+DT510e1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173142; c=relaxed/simple;
	bh=37bYhIfLR5jJocQuk1VUy6440mBY2p/F6kd0ng47NGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyBfek2FArwGZYmyE7XRHUgXkdXo27vCIgxLuLptigQH1n6wyhg2OUuao1o+7SmelmdbgUNVGTvAHGa2r0rXw3pYBS/QYGM8Y14i5/8VnZVl0E2RCWmDw8LQ8J0TvjmFU+P0A8uSABmqx/w8jZOCYw7BEG5G2CaDQnbhfNwccGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HSBlM/qe; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HSBlM/qe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776173139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtguGQRGzagy0tyebqTER4P9M/UvCjp0lGNI1HHa9aY=;
	b=HSBlM/qe/6f5aojrpdn/IX4qQMH+MzbZ5u9P2+X5Lf9If+LE5Jh2ULnmgrGx4lixAB6N8Y
	z8uziejucEk8OJFhpKdeeIkbgN8SZo01ALv683qt7gOdCrqfzizPVjqkl8gHwcYrPx3MW5
	yip+gWvvaOntfdwbRKnL5StclaVjTXQ=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	qmo@kernel.org,
	dxu@dxuuu.xyz,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 5/8] bpf: Update per-CPU maps using BPF_F_ALL_CPUS flag
Date: Tue, 14 Apr 2026 21:24:17 +0800
Message-ID: <20260414132421.63409-6-leon.hwang@linux.dev>
In-Reply-To: <20260414132421.63409-1-leon.hwang@linux.dev>
References: <20260414132421.63409-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When updating per-CPU maps via the lightweight skeleton loader, use
a single value slot across all CPUs. This avoids two potential issues
when updating on an M-CPU kernel with N cached slots (N < M), especially
when N is much smaller than M:

1) The update may trigger a page fault when copying data from the last
   slot, as the read may go beyond the allocated buffer.
2) The update may copy unexpected data from slots [N, M-1].

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/syscall.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b73b25c63073..f0f3785ef57d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1785,6 +1785,21 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 		goto err_put;
 	}
 
+	/*
+	 * When updating per-CPU maps via the lightweight skeleton
+	 * loader, use a single value slot across all CPUs. This avoids
+	 * two potential issues when updating on an M-CPU kernel with
+	 * N cached slots (N < M), especially when N is much smaller
+	 * than M:
+	 * 1) The update may trigger a page fault when copying data from
+	 *    the last slot, as the read may go beyond the allocated
+	 *    buffer.
+	 * 2) The update may copy unexpected data from slots [N, M-1].
+	 */
+	if (bpfptr_is_kernel(uattr) && bpf_map_supports_cpu_flags(map->map_type) &&
+	    !(attr->flags & (BPF_F_CPU | BPF_F_ALL_CPUS)))
+		attr->flags |= BPF_F_ALL_CPUS;
+
 	err = bpf_map_check_op_flags(map, attr->flags, ~0);
 	if (err)
 		goto err_put;
-- 
2.53.0

