Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A030CD92
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184115; cv=none; b=tHW3ts8ij5GajPv7SISmrE34XQWmdN24BP1Vn8Qxmg92bhDwb02XJ1sVQ+v2naAlhP37BCqFHs68ScFgpcXUTsl8dluztZFKi6yThznUIDkPQgnE3yjTGQNyG2O1keO+NnmXVMNFy51SxNT92ASo0bZsItAx0R5PXQHBLoAiBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184115; c=relaxed/simple;
	bh=ThAhRvh2fOZ8MQ1wSvEjY/No7zqB34z60GyCTcMNLPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YUXOWSU5QNOD61MHMmmbo3ppL8CmNT+nt62a9DfAQUetRkm/oF5dXqCvPNjm0rVbcWLhWqxkux1ykejajWi+BiPxo5uqpp8khaKPIKjEkXeIrGL5iG8NZGCiQjuKZ18jxkie6FCG1zsj5skgfpWciZ8f3wrMFQ1J0N18b2fUv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=N9W1mrx8; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="N9W1mrx8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xh
	Ddt18PoZWB1LcSKe9LVbAT7jljsF+QlDlpGNSu8no=; b=N9W1mrx83oRXR++1Pp
	haezCt4kWYYh1PPrBA21v4VE/yr6QabaJZBUCLiQz3RN8fnI3C61NcXhln+0IQEF
	NXQwlDr6Ah2Yz7KtqRfm1EcSB4aqxgCVUSphnWtEdafm7JCXkXAsUYlLyWernT3/
	/3+Ac9aBLBcMPHgxGTt9dKDoU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3iwOT+DlqkRWbDw--.6101S6;
	Tue, 23 Jun 2026 11:08:09 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH bpf-next 4/5] bpf: add bpf_strpbrk kfunc
Date: Tue, 23 Jun 2026 11:08:01 +0800
Message-Id: <20260623030803.44798-5-lange_tang@163.com>
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
X-CM-TRANSID:PigvCgD3iwOT+DlqkRWbDw--.6101S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw13JF4fXw15Gw48tF48Crg_yoW5Aw48pw
	42g34Ykr1ktrZ3Jw1fJa1v9as5Aw1rAr4jgry7Crn5Cws5Xa18Zr48G3s2gasxJry7CF1j
	vF1jgrZxu3WUWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRjjgxUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4hlNe2o5+Jk7ZQAA3h

From: Longjun Tang <tanglongjun@kylinos.cn>

Add bpf_strpbrk() that returns the index of the first character in a
string matching any character from the accept set, or -ENOENT.
Complements the existing strspn/strcspn kfuncs for string tokenization.
Registered in common_btf_ids.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 kernel/bpf/helpers.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 872326f0c2b8..f24cfdb22635 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3971,6 +3971,67 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
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
+/**
+ * bpf_strpbrk - Find the first occurrence of a set of characters in a string
+ * @s__ign: The string to be searched
+ * @accept__ign: The string containing the characters to search for
+ *
+ * Return:
+ * * >=0      - Index of the first character in @s__ign that matches any
+ *              character in @accept__ign
+ * * %-ENOENT - No character of @accept__ign found in @s__ign
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of the strings is too large
+ * * %-ERANGE - One of the strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strpbrk(const char *s__ign, const char *accept__ign)
+{
+	char cs, ca;
+	int i, j;
+
+	if (!copy_from_kernel_nofault_allowed(s__ign, 1) ||
+	    !copy_from_kernel_nofault_allowed(accept__ign, 1)) {
+		return -ERANGE;
+	}
+
+	guard(pagefault)();
+	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+		__get_kernel_nofault(&cs, s__ign, char, err_out);
+		if (cs == '\0')
+			return -ENOENT;
+		for (j = 0; j < XATTR_SIZE_MAX; j++) {
+			__get_kernel_nofault(&ca, accept__ign + j, char, err_out);
+			if (ca == '\0')
+				break;
+			if (cs == ca)
+				return i;
+		}
+		if (j == XATTR_SIZE_MAX)
+			return -E2BIG;
+		s__ign++;
+	}
+	return -E2BIG;
+err_out:
+	return -EFAULT;
+}
+
 /**
  * bpf_memcmp - Compare two memory regions byte by byte
  * @ptr1__ign: First memory region
@@ -4892,6 +4953,7 @@ BTF_ID_FLAGS(func, bpf_strlen);
 BTF_ID_FLAGS(func, bpf_strnlen);
 BTF_ID_FLAGS(func, bpf_strspn);
 BTF_ID_FLAGS(func, bpf_strcspn);
+BTF_ID_FLAGS(func, bpf_strpbrk);
 BTF_ID_FLAGS(func, bpf_memcmp);
 BTF_ID_FLAGS(func, bpf_strstr);
 BTF_ID_FLAGS(func, bpf_strcasestr);
-- 
2.25.1

