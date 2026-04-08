Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BBD37C929
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642736; cv=none; b=RR2VlXk4qQhmEAwdFUmOnfFlK9IIzDt9yCrJyamzr2bg0VEWOFnYum/Yh3+UC7MtOFslKSEpAd/z+VOgKozZtNvKJQ/L/QjoondWPvO42nTLLgOowIZcCTxDyIoxba2/qJW2xFkuWm2/QpDvgLym/a9J0K4fvcyY35ARm5W1erg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642736; c=relaxed/simple;
	bh=MCLTIXrD+yaBU+Pjpd7fHq1c/W893Gxi+KdyQQAbV8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gj0MlpASQBnMJKLnNS3q5HeMHiUMHQl00fh7nMJ8EqbRY6JCY0ezo+2inKhHOzy0fDUseKpTe0JCJ/meG5s7Jfw4C8f/uLnH0mP3aBjSuwIrmePbBUWhP1eNeWixjXnkMXGey4/SNDPWSh1nROn73+cC0+yXML2U7Fskuz4EKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B+PQQpxs; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B+PQQpxs"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775642715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RSEevyQ9Ax4TiLoB+p7V2brYfKZuqG1ikZ4lpQQb0js=;
	b=B+PQQpxsUD1KaEk0NQS+kxrCC07Ue1/I+Q2I+CWgYve88Swh2LhxoPNgcJPbYcLGPEldIC
	s5VX4B9qYrrO4OxumMgF7PPW7oh7+kyATQMuoVzM5OEuOLeYfsWxxoIfsS9oPmtz8jUDUU
	GrvqTue8lw4M+66xDDaLiNRfWA69OXU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	David Verbeiren <david.verbeiren@tessares.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix out-of-bounds read in bpf_obj_memcpy
Date: Wed,  8 Apr 2026 18:04:54 +0800
Message-ID: <20260408100455.190561-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When copying map value between two maps in BPF program, an out-of-bounds
read can occur in bpf_obj_memcpy(). Consider the following scenario:
    // map1: BPF_MAP_TYPE_CGROUP_STORAGE, value_size = 4
    // map2: BPF_MAP_TYPE_LRU_PERCPU_HASH, value_size = 4
    void *src = bpf_get_local_storage(&map1, 0);  // 4-byte buffer
    bpf_map_update_elem(&map2, &key, src, 0);     // copy src to map2

The verifier validates that source buffer size >= destination map's
value_size through check_helper_mem_access(). Since both maps have
value_size=4, verification passes.

However, at runtime bpf_obj_memcpy() rounds up the copy size to 8 bytes
for long-aligned atomic copy:
    bpf_long_memcpy(dst, src, round_up(size, 8));  // reads 8 bytes

This causes a 4-byte over-read from the source buffer. Fix this by using
round_down() to only copy complete 8-byte chunks with bpf_long_memcpy(),
then copy any remaining bytes with regular memcpy().

This ensures we never read beyond the validated buffer size while still
maintaining atomic operations where possible.

Fixes: d3bec0138bfbe ("bpf: Zero-fill re-used per-cpu map element")
Closes: https://lore.kernel.org/bpf/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/bpf.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 05b34a6355b03..1b789f9f8a095 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -535,10 +535,15 @@ static inline void bpf_obj_memcpy(struct btf_record *rec,
 	int i;
 
 	if (IS_ERR_OR_NULL(rec)) {
-		if (long_memcpy)
-			bpf_long_memcpy(dst, src, round_up(size, 8));
-		else
+		u32 aligned = round_down(size, 8);
+
+		if (long_memcpy && aligned) {
+			bpf_long_memcpy(dst, src, aligned);
+			if (size > aligned)
+				memcpy(dst + aligned, src + aligned, size - aligned);
+		} else {
 			memcpy(dst, src, size);
+		}
 		return;
 	}
 
-- 
2.43.0

