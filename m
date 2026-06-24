Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111A3A3E8B
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293829; cv=none; b=Od/Gbv5rhKappc5fzdlmJVaHf5Q3C87AXRM3+pr9cVRWjYysNJkXi0UCZNpAIlBB22ZcEK3BBZEl6S+nA+aoC4oxyi14MZ9Nw3NkGHZdpRCxDbT/dLP3wmRW6x6pBbnDVhG55AQZlym0JZF/CpCkLNnPSORDjeGrLgNOnDBXvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293829; c=relaxed/simple;
	bh=6OxTWhOm+yt0DzJLqo8chP5ZQ7zuWsFfW/3PtTSuqeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEdRxwVj+GTxfKgs4hm0A6I3/lRHfxI5LfgVKYe9i8LI/KphQHGrMU1ZVAU3dlQjTvXnnoFUqRA/OltD2JEZ3wpiguQnKab7z5udDKpY2TwvqtguE16YDqyOMmKArFlWdNq6k5sbozPH7nG7fvRdqyELsq7PqUEEuX6wsol/Ic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=elM6puFm; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="elM6puFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=y2
	kUsQ39pWzEBzSdD+RRk5WJvJqKF++NyoyWiTgBO18=; b=elM6puFmQRJj2bdBXo
	pDF8aMT7/g1NwAJIcKigDhe+Jk8t+NjwB80drdyZh4HyFCq2shP4qxdKS7JogjNJ
	1wD+QrFsbpIsLRd6QMcm6p9RTfG2piiv3W2Z4V27KLYkf6I8mRj5bTDLh6j6B4yz
	VCeAEhMaAfpZNJZQfVKE4NYjg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3lwonpTtqwoMPFQ--.6915S3;
	Wed, 24 Jun 2026 17:36:40 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH bpf-next v2 1/5] bpf: add bpf_memcmp kfunc
Date: Wed, 24 Jun 2026 17:36:34 +0800
Message-Id: <20260624093638.117062-2-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260624093638.117062-1-lange_tang@163.com>
References: <20260624093638.117062-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lwonpTtqwoMPFQ--.6915S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrW8tF4UGFyxGr47Jry5Arb_yoW5Ar1xpw
	4UGw1Ykr4ktF93J3WfGan5ua95Jwn5ur4jgrZIyr95urs8Xa4DZr48Kry8KasxJryUAryj
	vF4qgrZI93W3WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRY0P3UUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-QjcC2o7pSj-QAAA3B

From: Longjun Tang <tanglongjun@kylinos.cn>

Add bpf_memcmp() for binary memory comparison. Unlike bpf_strcmp,
null bytes do not terminate the comparison, making it suitable for
comparing fixed-size binary data.

BPF programs frequently need to compare raw binary buffers such as:
- MAC addresses (6 bytes) in XDP/TC for L2 filtering and forwarding;
- UUIDs (16 bytes) and hash digests in security policies;

Currently there is no safe way to do this:
- bpf_strncmp (helper) stops at null bytes, corrupting binary data;
- __builtin_memcmp may be used in some cases but is not verifier-safe
  for arbitrary kernel memory;
- hand-rolled loops are fragile and slow, as evidenced by the
  local_memcmp() workaround in selftests/bpf/progs/dynptr_success.c.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 kernel/bpf/helpers.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5314c9fed3c..aadcc4bfbee6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3971,6 +3971,48 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
 	return -EFAULT;
 }
 
+/**
+ * bpf_memcmp - Compare two memory regions byte by byte
+ * @ptr1__ign: First memory region
+ * @ptr2__ign: Second memory region
+ * @size: Number of bytes to compare
+ *
+ * Compares the first @size bytes of the memory areas @ptr1__ign and
+ * @ptr2__ign. Unlike bpf_strcmp, null bytes do not terminate the comparison.
+ *
+ * Return:
+ * * %0       - The memory regions are equal
+ * * %-1      - @ptr1__ign is less than @ptr2__ign
+ * * %1       - @ptr1__ign is greater than @ptr2__ign
+ * * %-EFAULT - Cannot read one of the memory regions
+ * * %-E2BIG  - @size exceeds the maximum allowed size
+ * * %-ERANGE - One of the memory regions is outside of kernel address space
+ */
+__bpf_kfunc int bpf_memcmp(const void *ptr1__ign, const void *ptr2__ign,
+			   size_t size)
+{
+	const unsigned char *p1 = ptr1__ign, *p2 = ptr2__ign;
+	unsigned char c1, c2;
+	size_t i;
+
+	if (size > XATTR_SIZE_MAX)
+		return -E2BIG;
+	if (!copy_from_kernel_nofault_allowed(p1, size) ||
+	    !copy_from_kernel_nofault_allowed(p2, size))
+		return -ERANGE;
+
+	guard(pagefault)();
+	for (i = 0; i < size; i++) {
+		__get_kernel_nofault(&c1, p1 + i, char, err_out);
+		__get_kernel_nofault(&c2, p2 + i, char, err_out);
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
+	}
+	return 0;
+err_out:
+	return -EFAULT;
+}
+
 static int __bpf_strnstr(const char *s1, const char *s2, size_t len,
 			 bool ignore_case)
 {
@@ -4850,6 +4892,7 @@ BTF_ID_FLAGS(func, bpf_strlen);
 BTF_ID_FLAGS(func, bpf_strnlen);
 BTF_ID_FLAGS(func, bpf_strspn);
 BTF_ID_FLAGS(func, bpf_strcspn);
+BTF_ID_FLAGS(func, bpf_memcmp);
 BTF_ID_FLAGS(func, bpf_strstr);
 BTF_ID_FLAGS(func, bpf_strcasestr);
 BTF_ID_FLAGS(func, bpf_strnstr);
-- 
2.25.1

