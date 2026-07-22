Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18140BCA0;
	Wed, 22 Jul 2026 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695341; cv=none; b=DV78De0rETUACXwy2IUzIMn4JOV+OAJjHAHYCpM3WHNJzNAoGlkSbM5cnssiRkLu4AjN+v5h5yJH3YTe6WHa5y/oPfyP/txUZ3Y+BoPXjbNpBOVqLsc9/yUmCTzc36eF74Oqn8D1suo+MAxsMTBkRhsRrWOnYGy4hSkGlRm3fGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695341; c=relaxed/simple;
	bh=UFaliVxrIGy1zF6d7IKDsknOE0oAqstS2nvZ79V8R4w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NqVpW147L7XuoB6nnrCYoqTXwZZRqustUksnMhFe2vjxgIzEcWriburSnKYsK95MfDj2VbXiUmSQTdH3BxUWSrLwW9VvvE55mWMSKC8jT74S3+8IcxcOgR4HXBE24mmms36CfQBd4zJ9oFDcdASAGO1lVbejm39/7lVz/EHMD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=UHi7E03R; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="UHi7E03R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784695333;
	bh=yNfspZFtc0PZYXtKxUDV1KbZtgzEmHkYDEQ6wWzb0QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHi7E03RpcIZO3Nf/2dwp1SxyO/UsL42yHU9pfRbuLZ+GJW+s42T8wTQbqkVJtLFR
	 DKIc25PWUsP+C2qkcP+gk0AYQDV7vRA6SwDGpvAmtVgEakpFkdq4aTh+ZLeLLlKyLr
	 2rMuCa7WeqDv62YmdmvIVlzOUVQWq2N5QFluqb0k=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id A70214ED; Wed, 22 Jul 2026 12:41:48 +0800
X-QQ-mid: xmsmtpt1784695311tb7p5i4zh
Message-ID: <tencent_60882E4BE4F247C5F6D564F41BF1C3004805@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahFvyhj1eRzT/H1QcGcAxqHW4HbcuDmdCis+5KnWVm63Kv7qQHkm
	 Pwp8hsJ6zWjaz9i7Ij9CCGem6CbdnBCBwhaaDzvz9JB9WHqDJoB40rRqPX1JHprlWmb0M7/RfnP4
	 j0SdLylX/0HNw66AW6Gb0FGsI7/dJs9l1z99yM/1TdGTOIkp/dcwI3FiAHVZWMKpN1klO53d0FG5
	 OdZsWaXmedfGmuxgWl0msRSdHoKhF1CDOtMMP2g+B23lTsKwOh5RLB1tLpwx/lkUTug6BnRuTkTt
	 gsl1TTx7VWgvqjDAFdHsOIJPjJD3nlbQRlQDDQI9NBlVJIKKzzF5hflluZz0trSBVAnhjM/aTgMa
	 flJnffZlmbzdJONn4jtIHCARRI7qd1s4Rg6bQ0t9o2GgQKgAz1BKmNxdgUdKZTZ22XCxEXrCxwMC
	 Gnu4ypfWxk2BSlRJQsLrlOWnE84aBdYFzrZbaDKNSLdaX+r/AXJ0/9xyuurLS0Afqex81VlN/L1T
	 OL/5DFLQKF6YUua+f8KahQHJuMsAbyuI46vP4gyOmnF3rxL/y3XIepMjq/LGr/T9jHRELS1HaGki
	 P4dXnQrwoD+pHw8ZDlc/aqAC12C8N8J7+aVV9I/Sdf/WWRZSinfkNPleRj0sj12fqmyc6j+ZDyzo
	 S7qaGzUj+KXUbrJH4o5K/dPGa1zrLnV44+iR7vRsh01ndktG54lB+WHzBs+5OFBmfi37sOIHMJpv
	 UAdrK7q+M+ET30kNxGLUK9QiEbWPUz9cY96E5Z6mrJEg1dO263XAkrM1EsngCDBZsntdNRJll429
	 KQ9vd66HY48ZHwS8NrqxrQu7OUyQ0VAWzut6RcrKBYuygB3IKJDtWUld09LoPcnTTb7h3UxQOkIF
	 Dr7rAyDGhq0urdC+AEYhWIXYe2ZanguDReHr0/v7Xa3+Qdmr9m3g87FrcZSBtiEPSCn2Nz+lXgqO
	 AFXRlL3Gn0oh4uZb5jqRueSKPkShfOX7ZlIuSibz8CzyAHt5GHthhfv+gVyeYiW/L1j5dyKkvzHu
	 YkHJqoYKQ8MTe+RAH/LaVNewnJOrF7rwKbMGpB7zfLxlegjDutaeuQCy80ce90JMMF2hXa2jIAth
	 JkWudMwVepTAEg5MYsX/zN5IhA9w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org
Cc: rtoax@foxmail.com,
	rongtao@cestc.cn,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v5 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
Date: Wed, 22 Jul 2026 12:41:27 +0800
X-OQ-MSGID: <b80dcfdf496c885abc06f89b0c5a91977f16d91b.1784695085.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784695085.git.rtoax@foxmail.com>
References: <cover.1784695085.git.rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add string concatenation kfuncs, prototype:

  int bpf_strcat(char *dst, u32 dst__sz, const char *src);
  int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32 len);

This differs from the glibc library functions strcat and strncat, which,
for safety reasons, require the size of the target string's memory space
as a parameter.

The src parameter cannot directly pass a string constant, such as "XYZ",
otherwise it will throw an error "write into map forbidden".

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee..85afff60365c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4195,6 +4195,79 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
 	return __bpf_strnstr(s1__ign, s2__ign, len, true);
 }
 
+static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
+{
+	int dlen = 0, slen, space, copied;
+
+	if (sz == 0 || dsz == 0)
+		return -EINVAL;
+
+	while (dlen < dsz && dst[dlen] != '\0')
+		dlen++;
+
+	if (dlen >= dsz)
+		return -E2BIG;
+
+	space = dsz - dlen;
+
+	slen = bpf_strnlen(src, sz);
+	if (space <= slen)
+		return -E2BIG;
+
+	copied = strncpy_from_kernel_nofault(dst + dlen, src, sz);
+	if (copied < 0)
+		return copied;
+	else if (copied == 0 || copied == 1)
+		return dlen;
+
+	/* The copied character count includes '\0'. */
+	return dlen + copied - 1;
+}
+
+/**
+ * bpf_strcat - Append non-null bytes from a source string, and null-terminate
+ *              the result
+ * @dst: Destination string.
+ * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
+ * @src: Source string.
+ *
+ * Return:
+ * * >=0      - Length of the concatenated string.
+ *
+ * * %-EINVAL - String @dst__ign is invalid.
+ * * %-EFAULT - Cannot read or write one of the strings.
+ * * %-E2BIG  - String @src__ign is too large or the remaining space in
+ *              @dst__ign is too small.
+ * * %-ERANGE - One of the strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src)
+{
+	return __bpf_strncat(dst, dst__sz, src, dst__sz);
+}
+
+/**
+ * bpf_strncat - Append non-null bytes from a source string, and null-terminate
+ *               the result
+ * @dst: Destination string.
+ * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
+ * @src: Source string.
+ * @len: the maximum number of characters to concatenate, the null terminator
+ *       \0 of the target string @dst will also be included.
+ *
+ * Return:
+ * * >=0      - Length of the concatenated string.
+ *
+ * * %-EINVAL - String @dst__ign is invalid.
+ * * %-EFAULT - Cannot read or write one of the strings.
+ * * %-E2BIG  - String @src__ign is too large or the remaining space in
+ *              @dst__ign is too small.
+ * * %-ERANGE - One of the strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32 len)
+{
+	return __bpf_strncat(dst, dst__sz, src, len);
+}
+
 #ifdef CONFIG_KEYS
 /**
  * bpf_lookup_user_key - lookup a key by its serial
@@ -4958,6 +5031,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
 BTF_ID_FLAGS(func, bpf_strcasestr);
 BTF_ID_FLAGS(func, bpf_strnstr);
 BTF_ID_FLAGS(func, bpf_strncasestr);
+BTF_ID_FLAGS(func, bpf_strcat);
+BTF_ID_FLAGS(func, bpf_strncat);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-- 
2.55.0

