Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F8ED9
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190420; cv=none; b=OJs/vZvocKM/FcDJ4WsbQ0/3f7ZcGKvh1xaHT9kvO9plJNeCiIWBxJOWLiFuWX6e4OqK8slpi5gbOs0qJO5tXKs3vSDt3OBvFcFqwHtCFmtx9EFQ4c6n4na6nZIVVxcgCwbgy1zKXTJGWi22z0JDB5M9YXTQ5Xn3qhYp7HR/4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190420; c=relaxed/simple;
	bh=Bq5GtDX2NfdJoulQ8qKd9NtH5r4prbQ3HbS+d9W/xAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCWpO/idA8+tJLzMpcfePxstok0ia31ZAOO2Se2Z4HWmT7ORxGygfh5iZwOuXfhCHef7/zPhlMyFTLWwoFK2uXb1pzZL30O9qfjy/hDXyKKWjaAsXWpYEEPmulGkwq8Yrbb98MmDhzem3P1bg7zYV/Hcr0FJA/0JsTkHROVpmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9Tdegru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9Tdegru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A4EC433C7;
	Thu,  4 Apr 2024 00:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712190420;
	bh=Bq5GtDX2NfdJoulQ8qKd9NtH5r4prbQ3HbS+d9W/xAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9TdegrugXsvvTs4j6RR8icilFQWHh/YvdewPSll6djYpxQcx9xD24So4202M6PVe
	 3jn/UViyGBIN2kA0le6U1nZwF4qMybQm7Lc8rnnB6em9QdFkV9HHj2JMxYadEHEwWl
	 PjvXvFrD+jMBh0OQdxZcQjyvFLvBqIG22rz69ui9uMWDDLf4EJA38xqHfvhNQJugxC
	 C7UUBa/TU0dpi3znXsiUfEZzFLDfN6oM7zxjptBS34VhcuYftPmBnynUBi0VWLVGDD
	 fb3IkKe/afZemyECgHjKj5f24KgbnhehPUclv0VYdsg5H+gxRGJyolzoE+WVH3+8t7
	 zyLJamZxfJn8w==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 bpf-next 1/2] bpf: make bpf_get_branch_snapshot() architecture-agnostic
Date: Wed,  3 Apr 2024 17:26:39 -0700
Message-ID: <20240404002640.1774210-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404002640.1774210-1-andrii@kernel.org>
References: <20240404002640.1774210-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_snapshot_branch_stack is set up in an architecture-agnostic way, so
there is no reason for BPF subsystem to keep track of which
architectures do support LBR or not. E.g., it looks like ARM64 might soon
get support for BRBE ([0]), which (with proper integration) should be
possible to utilize using this BPF helper.

perf_snapshot_branch_stack static call will point to
__static_call_return0() by default, which just returns zero, which will
lead to -ENOENT, as expected. So no need to guard anything here.

  [0] https://lore.kernel.org/linux-arm-kernel/20240125094119.2542332-1-anshuman.khandual@arm.com/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/bpf_trace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6d0c95638e1b..afb232b1d7c2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1188,9 +1188,6 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_tracing = {
 
 BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
 {
-#ifndef CONFIG_X86
-	return -ENOENT;
-#else
 	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
 	u32 entry_cnt = size / br_entry_size;
 
@@ -1203,7 +1200,6 @@ BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
 		return -ENOENT;
 
 	return entry_cnt * br_entry_size;
-#endif
 }
 
 static const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
-- 
2.43.0

