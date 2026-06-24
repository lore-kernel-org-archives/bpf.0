Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563A236453
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293832; cv=none; b=tgvkTKba9PtHTxjO/8MEHyZUjc3tddgJCml0ofJ6XjQCEHBp19jmRaCfCeHhFHF0kIAD6gt2UD42E0AA0ZlyTJ5XvPJfenPuoFSOgANGKI5SwiMPW3LUY337fpVzSgL8/pMBnqT7qOtICqzK+nNlTuPrplY4qhgXbJdZaw83uOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293832; c=relaxed/simple;
	bh=AVpwhvlGl6+api5cZvuDa+UXG2NgwgW2GOQbwcxWIS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0udtkfuYEHaHePtxQ5KsJw1nZnpoOVwmGZnefsBivf7bBqh2VXVtHLYrWAzGzL3gSAPu7smgSO/RPoLQvGJQsR4wV0MsCI/yHEyKqEiWqlVA7vMBNaFu7dB+rx4VekJZmNQQUDVpX+dUEH7M5hK3PNPnElONc+BavuLfxb5Tik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fu4vCe5O; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fu4vCe5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=0oqvKJEc1U5JZhPzCspILlVenHQlQZQXbRoZnIY85xQ=;
	b=fu4vCe5OiUoUhsSEh2p/18pmtbKk1fOB7YjGiW+Zf3t8BpjP2ntiOB9OQLasUt
	GnNgFSolJtYsZy8Nnz9Sz235pBdxwWI2VZoTSBrxf+D20Ys2nTpUH/T25m+WogJG
	MVJirsIzVGjFSeVfFnwxUfYzuWzWReHTzPIDg6LJtSQI4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3lwonpTtqwoMPFQ--.6915S6;
	Wed, 24 Jun 2026 17:36:42 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: ast@kernel.org,
	andrii@kernel.org
Cc: yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	tanglongjun@kylinos.cn,
	lange_tang@163.com
Subject: [PATCH bpf-next v2 4/5] bpf: add bpf_strpbrk kfunc
Date: Wed, 24 Jun 2026 17:36:37 +0800
Message-Id: <20260624093638.117062-5-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260624093638.117062-1-lange_tang@163.com>
References: <20260624093638.117062-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lwonpTtqwoMPFQ--.6915S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw13JF4xJF18Xr18WFy8Krg_yoW5AFW8pw
	42g34Ykr4ktFs3Jwn3Gw1ruF98Zwn5Aw48Kry7Grn5C395W3W8Xw4fGr1Iq3sxJryUCF1j
	qF1YgFZ8u3ZFgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piRnmtUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4grcC2o7pSq8DQAA3Q

From: Longjun Tang <tanglongjun@kylinos.cn>

Add bpf_strpbrk() that returns the index of the first character in a
string matching any character from the accept set, or -ENOENT if no
match is found.

BPF programs parsing kernel strings often need to locate delimiter
characters to split tokens. Common use cases include:
- Parsing comma-separated mount options (e.g., fscrypt,noatime);
- Tokenizing space-separated /proc entries (e.g., /proc/mounts);
- Splitting colon-separated xattr values into individual entries.

The existing strspn/strcspn kfuncs can be used for this but require
two separate calls: strcspn to find the span before a delimiter,
then strspn to skip past it. bpf_strpbrk provides the missing
primitive — find the delimiter position directly in one call.
Together, strspn + strcspn + strpbrk cover the complete set of
C standard library character-set search operations.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 kernel/bpf/helpers.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index aadcc4bfbee6..ead00ec314f5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3971,6 +3971,50 @@ __bpf_kfunc int bpf_strcspn(const char *s__ign, const char *reject__ign)
 	return -EFAULT;
 }
 
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
@@ -4892,6 +4936,7 @@ BTF_ID_FLAGS(func, bpf_strlen);
 BTF_ID_FLAGS(func, bpf_strnlen);
 BTF_ID_FLAGS(func, bpf_strspn);
 BTF_ID_FLAGS(func, bpf_strcspn);
+BTF_ID_FLAGS(func, bpf_strpbrk);
 BTF_ID_FLAGS(func, bpf_memcmp);
 BTF_ID_FLAGS(func, bpf_strstr);
 BTF_ID_FLAGS(func, bpf_strcasestr);
-- 
2.25.1

