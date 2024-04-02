Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA215B964
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084748; cv=none; b=n+Skrsm6SNIfvdGuaKms7OUlWrXIzgK6ybMFPsa/rsgyuvq3cadKYWc+ewt0CnWVbMDOlIc2dYZrP9CKzBAXLH8apg6073CCkNhlbFOgDhvtKtdDjxRJzkLEXHcDe1rU+HZ/b7X6tjinGqgk5j8mDXBs0hVsWDGOC/L2INQ0svY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084748; c=relaxed/simple;
	bh=Bq5GtDX2NfdJoulQ8qKd9NtH5r4prbQ3HbS+d9W/xAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gezvn31z9WQDxkNaPDDwTEYXL/A5KMLyzSm1/trCwh5po1DpMocdPWDMrgrNcjOGlCW+VyLsjEtFpMiAxTDIcnT8uwbAxIC+r/ISAYNqUrj+YkVdfKXugIXTiiRtVNWAz7z3wI1pysDHJGx29fnS8g0WG9MXHTkz5eUvgeTX5/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6fFwC/y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6fFwC/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01885C433C7;
	Tue,  2 Apr 2024 19:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712084748;
	bh=Bq5GtDX2NfdJoulQ8qKd9NtH5r4prbQ3HbS+d9W/xAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6fFwC/yUwFufX02f7xkP9EukQA0EYfE9staZwbhT4IgzQ4kgj8kVTQOaN3N+tGb8
	 BF4ESz6MJIBYumE+wW+hHIyx66CS9dtoLHmWfMY/v/icSupeA8Kbm82GGIaKSmLolC
	 pDDl9ko08Qw8gSphgUb6rZ6tPl/SwYtRIvBpv8LDqZOMPFRXrGQhTmxiPmZ7lumZ6c
	 OS75OjCIi677RyJNDZ1hedNHqLhkfCPLKpV5f71AGkWMJkwV97oB98AwWXX78KvNV0
	 f1RJJTE8Ytz6Xk+wRPK+iLYDKBj2tF1Cfh7wjqVOO4pvRDhAe1P8HyE+slcR1b9qoJ
	 38BOLj/RUnKgQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 1/2] bpf: make bpf_get_branch_snapshot() architecture-agnostic
Date: Tue,  2 Apr 2024 12:05:41 -0700
Message-ID: <20240402190542.757858-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402190542.757858-1-andrii@kernel.org>
References: <20240402190542.757858-1-andrii@kernel.org>
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

