Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841533123D;
	Mon, 20 Jul 2026 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536496; cv=none; b=EtT/4U2Uex1JdE92jrEbkSVHDcWaJ/JeaBMhyZX1m8s1DzljG4CTyH7FYc3cqZct9TqJT44v3475Z5tYdIl31vLOaSd1OSf8rl+p+95UuVJTF9UAz4B3kXygAApkWF4seHexcuNJfQ3NVBNK64VHzPZDB/h6go+ihHv+TK9JB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536496; c=relaxed/simple;
	bh=w3yaWhhnT8rEz6pdV7Y+YUQ3Sa9ObdUxyVBo7y6Jyzs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FKI+J2SVqGUNOOqNb3PLNSDKdHXDo0VpnInnSYzSdVXgD3CUqMgPsgEHC5avDhWl3bWo2zIWmhT2Lm5ejuhvUbihjkuCc/nWlZe7WohzW0Hs/5RwcUwsJRwHDp79QiC7qE4IV2MDsBgQmHv5P913PVk+D96itvALinR3NjMHbl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Zh8R6AN9; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Zh8R6AN9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784536487;
	bh=NvBurieKJfds+HHZw0C1C8IyYSgsl4hSHpZtWpbNDZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zh8R6AN9XEWd0Dvz+44uGt2QRMy++qF6qV8fFlsko7krbLn9V91ormJ6VkfoELssx
	 yNpfiCDH48JcJUuRcc+fxAocTuUJMgrHvfYGhGu+4yIEyDjZH6vopk7Lbo8GB/SZ0a
	 D52f/07g1rNJdKeL/gGYBWSZcjESZMkGr6GeeknY=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 8A42167D; Mon, 20 Jul 2026 16:34:36 +0800
X-QQ-mid: xmsmtpt1784536479tilunwlr3
Message-ID: <tencent_AFC1869057D6C3E59E0AF86BD7A80AA29A06@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Ju0MBj3tyj739ynd5C2/Khap124kywA9wNt2aCtVl+kY/iB1FL7g
	 rTniYpHsBusX5tx4gbmJxK9za44i7jC5GVHLXGoA9Z9B72SUnBKKmJwuPW0MXYzO1UThfOyHJhRw
	 5Rkfhd06guiHhQR8vr7RwXUfpNLsikEuiCpnAjMyqh3AGSFafR32wjdB5B93Xg1b9xjJfDs9EgjN
	 jSyOJTQ5l6w0ZYsY35bNFyaoFFkN6zY7daNRFveGm1ay4ac4d+kY+taNP+PLsgFmUnNK3x/u8+A/
	 bnE2TtjhOOxuMz4Vm6xbZTH+Z0reuyzePWZmDktPE7XCvwvYEiwEKE6o1DWfhPUEc14+wByk4ECH
	 /0sr7i2CtCgcLf/Md6re00i6HVlLG70xJEslZxaWfkeOQeopMFie3UUueB317jqNjSSoSiM/EyA5
	 7ByFwQv2zjU/R2uiY+8nWyjRk6Q/V4aXTMRzUq+nxnbAqVY0eOBcpq3axtlAW1fpogJwDjWCdrz1
	 2QyNospiNitzaXlIsZvNFYO701zq33yUAFFv1lvMaC7MrXnfC8KYXs9AwdkfAHX6aQoxLA/Y9gjN
	 hRiE4a2V+4/HIQ/osLL2k+Ke7CpqclbCTRr4wQCV8livVEeCzs749bowG7xk3NV9ysneiwOptdoi
	 8Zm23VL84Q08LAZ91IuhT9tfCGC0vPSqTlKK/TM9DNf1BijaoW7kAr35Zr6H+OKHCjkdymSuqgoE
	 tTDj/9kv5OxqZRUyuDRiAinuvmc88gQnHsMn08gj6wwabB9u7Zf7hj5PCPBosapcZfcGwePfLDAV
	 J84R8rQ4+Kn+06KsVOYVl1ZqlEVm1Mi1NxBF/shLRHyDbi2G4Rbhpi72wzKKYCMmSOddFugLYuu8
	 e+uDofXjyeHr/3WO5xrDYo3EWLQwbtUAQKjkOrtW51FzvA1rtvuwH0qddZdjHT6jx/l5Le+pERVk
	 psGZopVWMCRBKKuUc0eSTGn5NNU0PP3wsbuRzJ4zZgF1YfwsvWiBaixmhKA9ZvG1Bow9iypbSu/3
	 DiA2bhUfcUqPPKZZVRfVpJi94mp5SLsUehT6+XJXBeojY0NJj2JX03hOlOejQ=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Rong Tao <rtoax@foxmail.com>
To: vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>,
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
Subject: [PATCH bpf-next v4 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
Date: Mon, 20 Jul 2026 16:34:09 +0800
X-OQ-MSGID: <8cae7ac699ec224e69ba92d549958e32ce56da86.1784536164.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784536164.git.rtoax@foxmail.com>
References: <cover.1784536164.git.rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Add string concatenation kfuncs, prototype:

  int bpf_strcat(char *dst, u32 dst__sz, const char *src__ign);
  int bpf_strncat(char *dst, u32 dst__sz, const char *src__ign, u32 len);

This differs from the glibc library functions strcat and strncat, which,
for safety reasons, require the size of the target string's memory space
as a parameter.

The src parameter cannot directly pass a string constant, such as "XYZ",
otherwise it will throw an error "write into map forbidden".

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee..2c09044de311 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4195,6 +4195,74 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
 	return __bpf_strnstr(s1__ign, s2__ign, len, true);
 }
 
+static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
+{
+	int dlen = 0, space, copied;
+
+	while (dst[dlen] != '\0')
+		dlen++;
+
+	if (dlen >= dsz || sz == 0 || dsz == 0)
+		return -EINVAL;
+
+	space = dsz - dlen;
+	if (space < 1)
+		return -E2BIG;
+
+	copied = strncpy_from_kernel_nofault(dst + dlen, src, min(sz, space));
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
@@ -4958,6 +5026,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
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

