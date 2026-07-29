Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4D34F247
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292204; cv=none; b=OFqeSeWpuEygpRYOOUGLGTH/XqtpCBs9fyMpU9/BBu5ElUEaIyqJS5cC37sM0g/mu2pKh/DXv9PLhvJVwxgCvBVtMnRLoBk6+mQYz9bI6OcjmS8yAWV1suPclZOMmCTPzyrgc2L1fYJ/A0LozIw0KIrdYR2hHpCa/W6Wq770kP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292204; c=relaxed/simple;
	bh=3VHzGeZjtIJCEtVb9WiBB97knFJ5CcNPzm17Q6K9PBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAns1wxnx6ZK4coK2TcbAOOnBmhrYiZ0CIGaNhiYTDiq57nrXClqBNV2hlJEEiW8GI7ggH6OEx0VGgb5cmvVTEZ8F9tcQIK2MRjN/UTw7kX7Pp7sAbjD6qpZ68dqMRZE0jFACQiN7aIX9ph/gHCj/cpb43v48s35R0CMTzcR7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kDuLrq1/; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kDuLrq1/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785292200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nchw7onord1GCgEKYCgGIeh5Cqld0c9s8n5b9czUAM8=;
	b=kDuLrq1/s3gnhFaAvkiqsvuPYWHO3Ec/tCnthhr4kuFTyyOd3G8nhE56pkTNzLe5SUK1PV
	KUDFcQTiNX2IpSfEDRLWjL9yMdJoCLZGlLqwl3rKL05VgRBimp6ifsH9hD504E9ai/kQ5N
	ElxceMGlOPYSsuk2bBL1IaH4u9+ieGU=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH v4 2/4] LoongArch: bpf: Advertise JIT support for kptr xchg inline
Date: Wed, 29 Jul 2026 10:28:35 +0800
Message-Id: <20260729022837.355549-3-chenguang.zhao@linux.dev>
In-Reply-To: <20260729022837.355549-1-chenguang.zhao@linux.dev>
References: <20260729022837.355549-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

The BPF verifier can lower bpf_kptr_xchg() to BPF_XCHG when the JIT
advertises ptr xchg support. With ordered amswap_db.* emission from the
previous patch, declare that LoongArch bpf JIT supports this inlining.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 arch/loongarch/net/bpf_jit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 5417a5624327..686d333146ce 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2396,6 +2396,11 @@ bool bpf_jit_supports_fsession(void)
 	return true;
 }
 
+bool bpf_jit_supports_ptr_xchg(void)
+{
+	return true;
+}
+
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
-- 
2.25.1

