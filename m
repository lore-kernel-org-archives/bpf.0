Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708D30CD92
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184112; cv=none; b=I1ypGHbdacdg1HSudv1TQDzCsN/b3lW2YRzOK9icqhpAAij6GUEMrd41j72MnMVLY1AZLvOcOvHf5Sp/QCFXW6+VvMjdXsdCFdK1luHAowsmcerpEH0w5cWRq2uX3Psha7ms/cxLowxNXbww1XboS2kawkLtqiIKFJoSLJcOJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184112; c=relaxed/simple;
	bh=GVv8LmlIk664CQVQyXc0uRAh8KwFMGrbt4r/9uAefWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpZRe1qavyaXMqWwtkoiUr33iKAEkcBej8i6BVxpmvdci3HCABN+FroAnLXVDHrsnHgup1mWOKpf1fc5Q08kGtURp17VSunS37iwACB2dEQh+92jUIFGTijoSXoyOmYQD1N0346rIUJxc69eTsUsl48zd+0IOcM/xqoaFSqF1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NssbPFmz; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NssbPFmz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ug
	E79Ukhqx2JYOIVJ2Q+iuWMoNcBPRbNXihKS57J9ew=; b=NssbPFmzpAovN3s1Ut
	tZPeRAb00UB/aeXkbm6x608tSr0Ugvx5ziAFFjkhPREo+d2y4L61xYFotwcjJAif
	DRlG1AH0ryzp/BPahi/jikJmWlDm+EXhQq+XFIh/FpwuvKjbGjzXStJPr3eTbxJH
	0HSsPeSjK5DTQglSCCEC8pPfI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3iwOT+DlqkRWbDw--.6101S4;
	Tue, 23 Jun 2026 11:08:07 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH bpf-next 2/5] selftests/bpf: rename local bpf_memcmp to avoid conflict
Date: Tue, 23 Jun 2026 11:07:59 +0800
Message-Id: <20260623030803.44798-3-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623030803.44798-1-lange_tang@163.com>
References: <20260623030803.44798-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3iwOT+DlqkRWbDw--.6101S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3WrWDGFy5Jr1kCFyUXr15XFb_yoW7Cw1fpF
	yxC3429r4xtFy3trn2kws2vayFy34kWr45Gr4jvF97Zan8Zr9Yvr45Kry8trs8trs8G3yU
	AFy5JrWYqr1ktF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR1CJkUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4hdMemo5+Jc7IQAA3l

From: Longjun Tang <tanglongjun@kylinos.cn>

The dynptr_success test defines a local inline bpf_memcmp() which
conflicts with the newly added bpf_memcmp kfunc when vmlinux.h
includes the kfunc declaration. Rename it to local_memcmp.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 .../selftests/bpf/progs/dynptr_success.c      | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index e0d672d93adf..071581ff0833 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -624,7 +624,7 @@ int BPF_PROG(test_dynptr_skb_tp_btf, void *skb, void *location)
 	return 1;
 }
 
-static inline int bpf_memcmp(const char *a, const char *b, u32 size)
+static inline int local_memcmp(const char *a, const char *b, u32 size)
 {
 	int i;
 
@@ -650,12 +650,12 @@ int test_dynptr_copy(void *ctx)
 	err = bpf_dynptr_write(&src, 0, data, sz, 0);
 	err = err ?: bpf_dynptr_copy(&dst, 0, &src, 0, sz);
 	err = err ?: bpf_dynptr_read(buf, sz, &dst, 0, 0);
-	err = err ?: bpf_memcmp(data, buf, sz);
+	err = err ?: local_memcmp(data, buf, sz);
 
 	/* Test that offsets are handled correctly */
 	err = err ?: bpf_dynptr_copy(&dst, 3, &src, 5, sz - 5);
 	err = err ?: bpf_dynptr_read(buf, sz - 5, &dst, 3, 0);
-	err = err ?: bpf_memcmp(data + 5, buf, sz - 5);
+	err = err ?: local_memcmp(data + 5, buf, sz - 5);
 
 	bpf_ringbuf_discard_dynptr(&src, 0);
 	bpf_ringbuf_discard_dynptr(&dst, 0);
@@ -692,7 +692,7 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
 		err = bpf_dynptr_read(&buf, len, &ptr_xdp, i * len, 0);
 		if (err)
 			goto out;
-		if (bpf_memcmp(data, buf, len) != 0)
+		if (local_memcmp(data, buf, len) != 0)
 			goto out;
 	}
 
@@ -713,7 +713,7 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
 		err = bpf_dynptr_read(&buf, len, &ptr_buf, i * len, 0);
 		if (err)
 			goto out;
-		if (bpf_memcmp(data, buf, len) != 0)
+		if (local_memcmp(data, buf, len) != 0)
 			goto out;
 	}
 
@@ -727,7 +727,7 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
 		err = bpf_dynptr_read(&buf, len, &ptr_xdp, 2 + i * len, 0);
 		if (err)
 			goto out;
-		if (bpf_memcmp(data, buf, len) != 0)
+		if (local_memcmp(data, buf, len) != 0)
 			goto out;
 	}
 
@@ -750,7 +750,7 @@ int test_dynptr_memset_zero(void *ctx)
 
 	err = bpf_dynptr_from_mem(memset_zero_data, data_sz, 0, &ptr);
 	err = err ?: bpf_dynptr_memset(&ptr, 0, data_sz, 0);
-	err = err ?: bpf_memcmp(zeroes, memset_zero_data, data_sz);
+	err = err ?: local_memcmp(zeroes, memset_zero_data, data_sz);
 
 	return 0;
 }
@@ -770,7 +770,7 @@ int test_dynptr_memset_notzero(void *ctx)
 
 	err = bpf_dynptr_from_mem(memset_notzero_data, data_sz, 0, &ptr);
 	err = err ?: bpf_dynptr_memset(&ptr, 0, data_sz, DYNPTR_MEMSET_VAL);
-	err = err ?: bpf_memcmp(expected, memset_notzero_data, data_sz);
+	err = err ?: local_memcmp(expected, memset_notzero_data, data_sz);
 
 	return 0;
 }
@@ -786,7 +786,7 @@ int test_dynptr_memset_zero_offset(void *ctx)
 
 	err = bpf_dynptr_from_mem(memset_zero_offset_data, data_sz, 0, &ptr);
 	err = err ?: bpf_dynptr_memset(&ptr, 8, 4, 0);
-	err = err ?: bpf_memcmp(expected, memset_zero_offset_data, data_sz);
+	err = err ?: local_memcmp(expected, memset_zero_offset_data, data_sz);
 
 	return 0;
 }
@@ -803,7 +803,7 @@ int test_dynptr_memset_zero_adjusted(void *ctx)
 	err = bpf_dynptr_from_mem(memset_zero_adjusted_data, data_sz, 0, &ptr);
 	err = err ?: bpf_dynptr_adjust(&ptr, 4, 8);
 	err = err ?: bpf_dynptr_memset(&ptr, 0, bpf_dynptr_size(&ptr), 0);
-	err = err ?: bpf_memcmp(expected, memset_zero_adjusted_data, data_sz);
+	err = err ?: local_memcmp(expected, memset_zero_adjusted_data, data_sz);
 
 	return 0;
 }
@@ -898,7 +898,7 @@ int test_dynptr_memset_xdp_chunks(struct xdp_md *xdp)
 		err = bpf_dynptr_read(&buf, chunk_sz, &ptr_xdp, offset, 0);
 		if (err)
 			goto out;
-		err = bpf_memcmp(buf, expected_buf, sizeof(buf));
+		err = local_memcmp(buf, expected_buf, sizeof(buf));
 		if (err)
 			goto out;
 	}
@@ -952,7 +952,7 @@ static __always_inline void test_dynptr_probe(void *ptr, bpf_read_dynptr_fn_t bp
 			break;
 		err = err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0, 0);
 
-		if (err || bpf_memcmp(expected_str, buf, len))
+		if (err || local_memcmp(expected_str, buf, len))
 			err = 1;
 
 		/* Reset buffer and dynptr */
@@ -986,7 +986,7 @@ static __always_inline void test_dynptr_probe_str(void *ptr,
 		err = err ?: bpf_dynptr_read(&buf, len, &ptr_buf, 0, 0);
 		if (!len)
 			continue;
-		if (err || bpf_memcmp(expected_str, buf, len - 1) || buf[len - 1] != '\0')
+		if (err || local_memcmp(expected_str, buf, len - 1) || buf[len - 1] != '\0')
 			err = 1;
 	}
 	bpf_ringbuf_discard_dynptr(&ptr_buf, 0);
@@ -1012,7 +1012,7 @@ static __always_inline void test_dynptr_probe_xdp(struct xdp_md *xdp, void *ptr,
 		if (len > sizeof(buf))
 			continue;
 		err = err ?: bpf_dynptr_read(&buf, len, &ptr_xdp, off, 0);
-		if (err || bpf_memcmp(expected_str, buf, len))
+		if (err || local_memcmp(expected_str, buf, len))
 			err = 1;
 		/* Reset buffer and dynptr */
 		__builtin_memset(buf, 0, sizeof(buf));
@@ -1048,7 +1048,7 @@ static __always_inline void test_dynptr_probe_str_xdp(struct xdp_md *xdp, void *
 
 		if (!len)
 			continue;
-		if (err || bpf_memcmp(expected_str, buf, len - 1) || buf[len - 1] != '\0')
+		if (err || local_memcmp(expected_str, buf, len - 1) || buf[len - 1] != '\0')
 			err = 1;
 
 		__builtin_memset(buf, 0, sizeof(buf));
-- 
2.25.1

