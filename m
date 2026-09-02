Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD952EEE79
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317315; cv=none; b=c2xDyUPQqep4ZG/Ygf/o66Y5ekUi7o6rW/4G/FGDllAR2UoPnu+brTdAZ4e4aXgJYglBK/aRXMvGx/y26/0LKkvUYztCGK/a4qAG19FoeMBiHxjRCkNCvQt+ezBEqRfNrBKbYdsXbafQFqom6gWhFpa8fi5k45jVVqc8EM0+674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317315; c=relaxed/simple;
	bh=ST5983ll6U7hafoaFlMxWw1U9/w1gNB73r53z1PudWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYdjQ5Iz9FvU0QvQnVCb1QokhqnjLcOaWZq9L2OfiMDOFHUp7hOgSSoag8a8AQhaj9D8AzKhXK4XHkTbx9dQSGKYjAp7dPugcJ7dqHnqOR92NrAvz4BtLVBEBM0sXjxLaWmD0pVH89s3xvC8nXCKGSsGmfCvS2XdfLahlS2xjA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OIFRM3D8; arc=none smtp.client-ip=95.215.58.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OIFRM3D8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ST5983ll6U7hafoaFlMxWw1U9/w1gNB73r53z1PudWg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788317311; v=1; x=1788922111;
 b=OIFRM3D8EhO/vfUMUf9rwBgvuCNOvvDmhpXupqiCpV5kOA64JkJp29FjV43fNNNdgQ+714Kh
 KZ+erxCTVYNcqPinIpIkEsVgtdCmbKHTYK4fe2h8JeKq0ZkITI/Pf8mjPO7/vXFsDAOXaqX9P3w
 PnT+wRldc2Ijfhe56Wz9/dzQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4da923a900d17674;
	Wed, 02 Sep 2026 02:48:31 +0000
X-Mizu-Trace-ID: 4da923a900d17674
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	michalblk@google.com,
	liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v3 1/2] sched_ext: document the rolling-cursor requirement for dsq_vtime
Date: Wed,  2 Sep 2026 10:48:11 +0800
Message-ID: <20260902024812.794879-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902024812.794879-1-cui.tao@linux.dev>
References: <20260902024812.794879-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

scx_bpf_dsq_insert_vtime() orders tasks by time_before64(), which is
only meaningful when the values within a given DSQ stay less than 2^63
apart. This is implicit in how a vtime scheduler works but not spelled
out anywhere. Document it so BPF scheduler authors know the
constraint.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 8041c87a3562..81a506a4c8ab 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8903,7 +8903,9 @@ struct scx_bpf_dsq_insert_vtime_args {
  *
  * @args->vtime ordering is according to time_before64() which considers
  * wrapping. A numerically larger vtime may indicate an earlier position in the
- * ordering and vice-versa.
+ * ordering and vice-versa. vtime is a rolling cursor and values used for
+ * ordering within a given DSQ should stay less than 2^63 apart for
+ * time_before64() ordering to remain well-defined.
  *
  * A DSQ can only be used as a FIFO or priority queue at any given time and this
  * function must not be called on a DSQ which already has one or more FIFO tasks
-- 
2.43.0

