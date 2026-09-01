Received: from mta1.migadu.com (out-93.mta1.migadu.com [95.215.58.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2E3D413F
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271451; cv=none; b=VjlwafnGuq5WZkogrhPREH1sDxBcIZRjS/SqCHzibal3JW9qkh8rIG58jC9wVSNxYUiWxuRJYxFCl1PAKAtgCCet8ClNyl8kJHYyZr32FYn0MH8qOsQxnolhLEBU1jIcD7JpHjQ5+aRzQXSoifqRDMhMrRv6B8LfQFIwSYwQrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271451; c=relaxed/simple;
	bh=o5SAqofTUL10q95P74ncak2ViAyJxj6F+FQApmfWBdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blxfVfmYi+V6Rmkg+lg7OaHBVl11T6xls9S7nk71/+RGNW3Bt4HWkbQfxI5x6aEjMVJByA+4uhkkdP6tjAe+Kxi/OdWEd/5m16DNqmIAGTbG32qhuNQcY/lSieHGKMdlGqFJc7fB6KgiPHzBXl5fQC0lvDCgZFQUGOCUOmTv5QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sYXbwn6B; arc=none smtp.client-ip=95.215.58.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sYXbwn6B"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=o5SAqofTUL10q95P74ncak2ViAyJxj6F+FQApmfWBdA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788271447; v=1; x=1788876247;
 b=sYXbwn6BbHiiKI2WcdNOWM1YbKQddE93024oTdwBRbfGvXbGxCYo1r+3qwZYloKqpLC4TC/0
 elmCb6saDY+Pe3YN4JQ71o9gzG/V0YfzaZ5MY6KB/5SAVapK5287Qya9Ic0V2AF6JS4A4ph3mVh
 spX3efxw+2w8Y4ts421CHHt0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7017fe8349925f4c;
	Tue, 01 Sep 2026 14:04:07 +0000
X-Mizu-Trace-ID: 7017fe8349925f4c
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	arighi@nvidia.com
Cc: void@manifault.com,
	changwoo@igalia.com,
	michalblk@google.com,
	liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 1/2] sched_ext: document the rolling-cursor requirement for dsq_vtime
Date: Tue,  1 Sep 2026 22:03:42 +0800
Message-ID: <20260901140343.764080-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901140343.764080-1-cui.tao@linux.dev>
References: <20260901140343.764080-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

scx_bpf_dsq_insert_vtime() orders tasks by time_before64(), which is
only meaningful when the values within a given DSQ stay within a
half-range (2^63) of each other. This is implicit in how a vtime
scheduler works -- the cursor advances monotonically -- but not
spelled out anywhere. Document it so BPF scheduler authors know the
constraint.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 8041c87a3562..9030962f4df1 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8905,6 +8905,11 @@ struct scx_bpf_dsq_insert_vtime_args {
  * wrapping. A numerically larger vtime may indicate an earlier position in the
  * ordering and vice-versa.
  *
+ * vtime is a rolling cursor and should be treated as a virtual timestamp
+ * that advances monotonically. Values used for ordering within a given DSQ
+ * should stay within half the u64 range (2^63) of each other so that
+ * time_before64() ordering remains well-defined.
+ *
  * A DSQ can only be used as a FIFO or priority queue at any given time and this
  * function must not be called on a DSQ which already has one or more FIFO tasks
  * queued and vice-versa. Also, the built-in DSQs (SCX_DSQ_LOCAL and
-- 
2.43.0

