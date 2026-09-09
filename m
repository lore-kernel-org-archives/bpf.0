Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E2280035
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928158; cv=none; b=BGFuU9SHLfJ0cWIIsFlzlQOoGd/H62HM1uTvK9FktEkhAY4DLdVeRd6FEJk0/cUrDbUfIH7VsbVLXQn3G0skFJqDCtnpplWCKXgZ3kOooRJtEYvxyZ8BZhLklb/MUeyod1fA8vg8iHALcs+L0c2AuGYB/IVMsJ7e2Re7+DOUq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928158; c=relaxed/simple;
	bh=f/LNoWpum3moWJ7Bo7rYY7S3fOiGtwpVIRnIKBxrzu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ek1TFwF+uFKd2q9BGAyCQq3tlt7/I9/+DOzd/m7VAXw3ND11KXsp2yErqyLsGptARwFPGkNYGDmxH6/lPziVdjwu/i0vormxLsbwuQxGpe9lGcne0CBIvCAGTGmgY7uvYuys2cuYYMx/HPGhXi1PwSpd8Q+PJUt6x30Yow4+2zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=wZkg4agp; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="wZkg4agp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=ikvwG8HnBmYaRExyQih8WEs5JtdZOSboka
	DMhRzGeW8=; b=wZkg4agpTkU2eM/Giq8IvYXFPpd9fvhRnDyNmJXlP95O57JgFZ
	muFcGw26LtfHXUFSvOcUCMVr0ZFl5dklmLyO8igerf9xnB8kSgaHs1mgzrpr952i
	m7O8RsiKFgxdL49hKcjfoQdKBKXMgEpkgYbN4AhptoHmh0aVK6jVoGI3A=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDn2yKT4KBqHD_5AA--.3076S2;
	Wed, 09 Sep 2026 12:29:07 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH bpf 2/2] selftests/bpf: Test slices escaping a clone call frame
Date: Wed,  9 Sep 2026 12:28:58 +0800
Message-ID: <20260909042858.1734125-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909042858.1734125-1-xyx2021@mail.ustc.edu.cn>
References: <20260829040712.B1B511F000E9@smtp.kernel.org>
 <20260909042858.1734125-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgDn2yKT4KBqHD_5AA--.3076S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWUtrWfAw4xWFy3Kw48WFg_yoW8uF1Dpa
	yFkay5Xr1SqFW7tFW7Xw4fWa1F9rs7Wr4rGrZ0y34UXw18tr9xZr4xKw1UWr9Iqw4rC3y5
	Za9rtFW3uF18W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU8CdgJUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add a success case that uses an escaped clone slice while the shared ring
buffer reservation is still live, and a failure case that releases the
original dynptr before using the escaped slice.

Together these cases verify that subprogram return neither invalidates the
slice too early nor lets it survive the shared reference release.

Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 1cd61d72c166f..0704662cd32f3 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1892,6 +1892,52 @@ int clone_invalidate4(void *ctx)
 	return 0;
 }
 
+static __noinline void clone_slice_in_subprog(struct bpf_dynptr *ptr, int **data)
+{
+	struct bpf_dynptr clone;
+
+	bpf_dynptr_clone(ptr, &clone);
+	*data = bpf_dynptr_data(&clone, 0, sizeof(val));
+}
+
+/* A slice that escapes the clone's call frame remains valid while the
+ * shared ringbuf reservation is live.
+ */
+SEC("?raw_tp")
+__success
+int clone_slice_returned_frame_valid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	int *data = NULL;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+	clone_slice_in_subprog(&ptr, &data);
+	if (data)
+		*data = 123;
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/* Releasing the shared reservation must invalidate a slice that escaped
+ * from a clone's call frame.
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int clone_slice_returned_frame_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	int *data = NULL;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+	clone_slice_in_subprog(&ptr, &data);
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	if (data)
+		*data = 123;
+
+	return 0;
+}
+
 /* Invalidating a dynptr should invalidate any data slices
  * of its parent
  */
-- 
2.43.0

