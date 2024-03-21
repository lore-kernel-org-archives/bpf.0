Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7A130E54
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044311; cv=none; b=XoLdTQ1/fO+0tOcS5MPmrcpXL+p93HAGV0+AtXZNzLypru0oRdVgZwHztEqziUj3GbFd0fg0V+eQFe2RWcCwcbTeKd/UU5EqWPMwWa7QOu6Tv8K/xl2o0Wsi3DjBEqajT94Fc2DrJPZre1HgyKJF1z33IzwtIjH/v0AMoEDCzSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044311; c=relaxed/simple;
	bh=Slk0vbqbMUJ9lk7KbFZE/pYy9Z2VahGf8QVXi+QgtFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4RcgEZJkdT2lGevbOLkgra55z5TOgyyrDQ0JlSwFmYV1H4f0Ci3rN4ihwaa0JwM5IMDIraKbgj2Q4kF6xE0DqctKkUnA10ZhH3kQMmMCuEJ3v2oRlAGjuhVrxrPnpdwS0oUV1hvZ9o4gk0DEk8Lcv5HGpED8ajmSv/dRqfmbpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxFCKVSz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxFCKVSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6169FC433F1;
	Thu, 21 Mar 2024 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711044310;
	bh=Slk0vbqbMUJ9lk7KbFZE/pYy9Z2VahGf8QVXi+QgtFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxFCKVSzrdiEkNNc7Jm+v3SfoRMQ9gTVSJvPuDETDrBvUCqIwlltjfhfCIFJ7TXf2
	 hrD93k56Djjh2RAJBzDO5WvLGGuyj8X0P0MMygaNnWjoABQmxaEgpECu09aPgVYZMm
	 pDuhtfXtn/xBfsjKFNM0EFdC5Fzq0OkVOd6inQb4199yxlu1hxtoNiMISGG5VvGG6u
	 F/zZm6bDcDTQNatP+I4Kw7j6bdab2gd0GyoJ7BsQHV22b9ATZswqv68z9sAhW4dc8K
	 CHnyvCoQo3iCZgvF7DGUDqIWuEsw+mYjy5SAj5LOO+eZ2dVW8Cw5Yqoma05zDRvqS9
	 miq8XOv/eke9Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: peterz@infradead.org,
	song@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/3] bpf: make bpf_get_branch_snapshot() architecture-agnostic
Date: Thu, 21 Mar 2024 11:04:59 -0700
Message-ID: <20240321180501.734779-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321180501.734779-1-andrii@kernel.org>
References: <20240321180501.734779-1-andrii@kernel.org>
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
index 434e3ece6688..6d000332b17b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1182,9 +1182,6 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto_tracing = {
 
 BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
 {
-#ifndef CONFIG_X86
-	return -ENOENT;
-#else
 	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
 	u32 entry_cnt = size / br_entry_size;
 
@@ -1197,7 +1194,6 @@ BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
 		return -ENOENT;
 
 	return entry_cnt * br_entry_size;
-#endif
 }
 
 static const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
-- 
2.43.0

