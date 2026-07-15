Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5B36E46F;
	Wed, 15 Jul 2026 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078896; cv=none; b=ugM3GKDna9MJwuXweR6Qba5ClIFZ0y7jGzE8/3oDrJRryMA3JdHNXGfdETUI+AiNyW7s2neZ5s+Xdv6RfVcCDv8Q9lpmaRQFtfX1370ZzH+OuCiMquCyILo6ZU0eezMa2bLzHxoTj879mqHX6ruz5YYvtZ6u3JxzGa+p9Fz5MFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078896; c=relaxed/simple;
	bh=xFDgfC5fbYWxsSt8xzyOGPM1T0dvViHf2ZZNJu1E0WU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JOhli6ybW+gmKqsZlcoql5pFBNa1TUobhdR/kUsYCyypL6tdM6L+BOjLa8FguxsRl8wn919z1xmmDLmIwfo7K5Vu14xxr/upihYSGtBt2odsQecZz5S09gTukgCPcEhyjD2+KGGZYimZTmfXSzLhDUTB2VdnMgw7iMi8Tjb4b/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=y0jwozF/; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="y0jwozF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784078890;
	bh=av/Jj7nP/jithWLDMuDNO3ZjfxEywWjWcj/LI31nOlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=y0jwozF/6v4oFLVARiNkze0r2txOuoYP+mKHSQVxvmam+0mTLXUIJecqreaWREonI
	 n2XoTvo6BBIwmKGhnfXG7+nJYNVGr3q4xxiGVcfZe5A95fiUb3qclkBlXFlg2WD2ho
	 MEKB1xU3EVbaE46Gj7iz/WxeDRyc1l6jCpTUsYeg=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 6FB10817; Wed, 15 Jul 2026 09:27:59 +0800
X-QQ-mid: xmsmtpt1784078882tcfa0vgc2
Message-ID: <tencent_9EC04DC824CBF5124305E73564341511C405@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XcZQlx1fGbXP3Dyy92cTJKoXWWPI0l3J5GvZn/Kyo+Eqp28ugj3
	 F4qbaxbPuanh930V+OQKFiHp5eg5BAtMfrcOvgY9IupyOiZCLcF/yQLlw/xSVT+jDdQMTZZwKl22
	 VtiityTDj5PqbkLLOKOt9v1VhEqBH7w1KfVVPcyqgYKWVFCfHfoK1imChBmHomPbBlM6KQRJBneL
	 CksG4EJr6rohSwZQvWhJyIGF8pTGi/4FiJ+gsCtOq30mEhqIU6iEPLSHoKxJU8WDY7wKfZ7LrXHG
	 RJQCIsjttYzuaOAZFQV6bYwtsXrtu4n3+xKzDw2PAzGxEQlfJKBbMEo/N/bD/KoCvd0fDHgY+aGc
	 EMoJ0mhlWrbw4XqlNM7xdcqMG2hDFSRM96bRAvwZmzKLjWIlwZbfORxeqPF6mHgfIgyW4q7DnlvY
	 x7wWZRbcwTpZ4h8okW4jgvkw83BkboZY1upM2291sJSt0JYXP169m9gf9IYNda/HU5LduB1q2NVS
	 SODw4gqdzFsz9ZZSMqqqcz2HwDCA7562JXc51ImiJZY+DDW9DdWMMQHjlbp94P05BFK14OZLhYSx
	 WTabdGdpFgmcNlO4j6ICPnElrS/3TCV3xuzDI46cmtUC3qHLahBmpfO29V2V+7ZflkHUvvrAqWpv
	 LxfI9iPTlwVV+0WU+oOhKCIhlHaduiqTII86slrD80z8QpfmHoMsafMfVcNGo98gOyQ+4IAHq2WP
	 z6/jEfAPXsODkkrkAkYjl32rcnEbf74p9Lk0fcP+T10EWECYaJnIQmywBI9rdpYMGK7LihGhXyGi
	 ksh76gB2zjv3e71Lh4Tl2p67BsKkti2FVzcL9txsdU9zho8Btnki7evL7dgoY/MDvBJxc1FIzs3e
	 il6QFg8KlhR6PHtJt+DjqPXnNccsM6f2BeOnlWKx5vx8vzf69Vk2Vc734WnKgGHkogGHqQbj702Y
	 PpIHjgp+kQO0zhqZyqK6Sfs86CsPkyIzXI/CzcMVP3GFgC19dz3uR7pYFTU86W6HeDmAkdDRoEQe
	 4093FWw44mto2lYQQoG8kylbHg3lMtBsy7j5Faax2cIh7BwwNtm3I5mDttCxyvp7fFmltMqYzbbx
	 osTFu+bMPRScxnEHQ=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	vmalik@redhat.com,
	ast@kernel.org
Cc: rtoax@foxmail.com,
	Rong Tao <rongtao@cestc.cn>,
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
Subject: [PATCH bpf-next v2 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
Date: Wed, 15 Jul 2026 09:27:26 +0800
X-OQ-MSGID: <12505d09c8c487bfd36b17fa1fa0c971db8688a3.1784078494.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784078494.git.rtoax@foxmail.com>
References: <cover.1784078494.git.rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add string concatenation kfuncs, prototype:

  int bpf_strcat(char *dst__ign, u32 dst__sz, const char *src__ign);
  int bpf_strncat(char *dst__ign, u32 dst__sz, const char *src__ign, u32 len);

This differs from the glibc library functions strcat and strncat, which,
for safety reasons, require the size of the target string's memory space
as a parameter.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 92 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee..401f94efd687 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4195,6 +4195,96 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
 	return __bpf_strnstr(s1__ign, s2__ign, len, true);
 }
 
+static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
+{
+	int dlen, slen, space, copied;
+	char cs = '?';
+
+	if (!copy_from_kernel_nofault_allowed(dst, 1) ||
+	    !copy_from_kernel_nofault_allowed(src, 1)) {
+		return -ERANGE;
+	}
+
+	dlen = bpf_strnlen(dst, dsz);
+	if (dlen < 0)
+		return dlen;
+	slen = bpf_strnlen(src, sz);
+	if (slen < 0)
+		return slen;
+
+	if (dlen >= dsz || sz == 0 || dsz == 0)
+		return -EINVAL;
+
+	space = dsz - dlen;
+	if (space <= 1 || space < min(slen, sz) + 1)
+		return -E2BIG;
+
+	guard(pagefault)();
+	for (copied = 0; copied < space - 1 && copied < slen; copied++) {
+		__get_kernel_nofault(&cs, src, char, err_out);
+		if (cs == '\0')
+			break;
+
+		__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
+
+		src++;
+	}
+	cs = '\0';
+	__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
+
+	__get_kernel_nofault(&cs, src, char, err_out);
+	if (cs != '\0' && sz > copied)
+		return -E2BIG;
+
+	return dlen + copied;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strcat - Append non-null bytes from a source string, and null-terminate
+ *              the result
+ * @dst: Destination string.
+ * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
+ * @src__ign: Source string.
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
+__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src__ign)
+{
+	return __bpf_strncat(dst, dst__sz, src__ign, XATTR_SIZE_MAX);
+}
+
+/**
+ * bpf_strncat - Append non-null bytes from a source string, and null-terminate
+ *               the result
+ * @dst: Destination string.
+ * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
+ * @src__ign: Source string.
+ * @len: the maximum number of characters to concatenate
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
+__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src__ign,
+			    u32 len)
+{
+	return __bpf_strncat(dst, dst__sz, src__ign, len);
+}
+
 #ifdef CONFIG_KEYS
 /**
  * bpf_lookup_user_key - lookup a key by its serial
@@ -4958,6 +5048,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
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

