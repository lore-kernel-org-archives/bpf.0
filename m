Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9FA282F3B
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518201; cv=none; b=PLw1hQMKGq83IoU1pqRv4LulbVodMk7D0aDbMRYUaQjmDIRKLBTuAE3o5dOmMJY7eQtSAbEvla0baQrXMtRy2o+ZeHiDlht05nZGLXPLoic4716zULbr+iTtSjsqqObC69fE87hl5UVMMjo/FNnRYjghLjvCBrC1HBwg7oQ66Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518201; c=relaxed/simple;
	bh=vWb8Qeul1vxs7FeBRtpo4kfwdZa1/r7/mLJHjyO7/5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0gfAIFZQFtCwVcwje+q4eQQML3FACawfiPWms2P1KryDGXm1Sb9pfMbQwsgyX03GKmnUyrRz9e9HN+hjz+cyQ0FfLFSB2lC+LVgNbQIvEkz6sfokMcQUNNSR66kNL5FA9ltO8423YbNc6t80VCLTiBqOkf4wgqHtn0u3bl5xk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndP4L5cZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndP4L5cZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D09FC19424;
	Sat, 18 Apr 2026 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776518200;
	bh=vWb8Qeul1vxs7FeBRtpo4kfwdZa1/r7/mLJHjyO7/5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndP4L5cZZOcRUHzerpS5KiLbdp8viHj/iKlR0Ja82nWHp3O6GK9LHoSQVzTN43FsC
	 GQKMYBYbAT0E5RR+RUWt+EEUAVamYYsjl6in3QfWVBCt4McidlHpXgfh9phwSf3LCu
	 o5rBw9/kCYUwXsGt18/UUCxm5CSFNDmETQm04XGwJype+aeRrGht1DaILoq1St913G
	 DazVkD1sJkpZXsVOM/qZ96odIVAHFpA4HlVPxCGq01rwtDDr2fT0GRHI9+U4u7gkuj
	 fwU2gVzGZbrVgUjO6iBs03b1eUSrBNEpSDTFnlT9ELexozOmmJQa6wNU1ulgo7Qrhg
	 bbnimmKBK1Gxg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kernel-team@meta.com,
	Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH bpf-next v13 1/6] bpf: adjust BPF JIT dependency to BPF_SYSCALL
Date: Sat, 18 Apr 2026 06:15:59 -0700
Message-ID: <20260418131614.1501848-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418131614.1501848-1-puranjay@kernel.org>
References: <20260418131614.1501848-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vadim Fedorenko <vadfed@meta.com>

BPF JIT is moving towards optimizing kfuncs and it was long overdue to
switch the dependency. Let's do it now to simplify other patches in the
series.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..b0f49be35675 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -41,7 +41,7 @@ config BPF_SYSCALL
 
 config BPF_JIT
 	bool "Enable BPF Just In Time compiler"
-	depends on BPF
+	depends on BPF_SYSCALL
 	depends on HAVE_CBPF_JIT || HAVE_EBPF_JIT
 	select EXECMEM
 	help
-- 
2.52.0

