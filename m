Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C130F7FA
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184113; cv=none; b=Vd4HbZvhQCVXJ8jg7HpNEHHiTD8O0vH6xPa9M5xzYOmHhLM/6RvlAbx/raMYXCSad7tHJ23XaPSQQY2DQAWHtDjrB73Gj+ISCIFNXqJTMIX++zh6TewbHJMeHKnDgjFeEGSsR7opC5LQJurtbQCR+aaaauZpBlWZ5HpAi6POM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184113; c=relaxed/simple;
	bh=NWY2mO4URYwaacWjrWTjBAUvmMhHTTceH0UV6C701qA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0/c/sPHE6o72dQb/DQYdRaOPIST7WoPiMLdFPIn5OeL1/HUXAwdDBRSc4AqbXirrgI7jry7vhEf6m/qkBc3NnmWz5T5IqTHWPCCCzt/J8o5cszHDY3wDnLdogoTB48waqNjFYhBeHYtqVVqKK91bQr8S2i+vj77IsspeuNC0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZiyYjY8H; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZiyYjY8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/1
	w9NxCq+CDKbR2d7DBqm05uhy5pGaneoLBnV6inuLE=; b=ZiyYjY8HcCeLxmgPgN
	At4U/mnqEnwCS0cthQP793IntjKN1j4ROd/fKPcMnHQtpQnnQnWxLL+yWO08AVRl
	2ji3ZmuDWOFjcvnZ7+BTCfXSnXpZmM6iyPuP62VLLJ3ia4W4HJLU++d5xfmhr9c2
	pxBhCFVbXUZyisWOeQtPoClwY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3iwOT+DlqkRWbDw--.6101S3;
	Tue, 23 Jun 2026 11:08:06 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH bpf-next 1/5] bpf: add bpf_memcmp kfunc
Date: Tue, 23 Jun 2026 11:07:58 +0800
Message-Id: <20260623030803.44798-2-lange_tang@163.com>
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
X-CM-TRANSID:PigvCgD3iwOT+DlqkRWbDw--.6101S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1DWry8Jw13Gr1Utw17Awb_yoW8KrW5pw
	4UG34Ykr4ktF93J3WfGws5uas5Aw1rJr4jgrWavr95uws8Xa1DAr4UGry8KasxJry7Aryj
	vF1qgrZI93W3WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pROyCPUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-hZMemo5+JYduAAA3G

From: Longjun Tang <tanglongjun@kylinos.cn>

Add bpf_memcmp() for binary memory comparison. Unlike bpf_strcmp,
null bytes do not terminate the comparison. Returns 0, -1, or 1.
Registered in common_btf_ids.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 kernel/bpf/helpers.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5314c9fed3c..872326f0c2b8 100644
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
+	const char *p1 = ptr1__ign, *p2 = ptr2__ign;
+	char c1, c2;
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

