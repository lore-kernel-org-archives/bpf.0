Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4742DA3F;
	Tue, 14 Jul 2026 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021813; cv=none; b=JiEAUHwyedBL8FeNIHODo5j2HY6IYoA1CehFF0QmeLx5BxbIUAlILVmUq7do71V675+jLhU3IVH/n/ltkL2PFuVhDtBSJCJ0N9NbIS2nJLCWf0qvQc+cGpf33of47M3VBj27tMkC281Rgaw8Xlextiuv8yGNeOFzs8efjjq8IGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021813; c=relaxed/simple;
	bh=bq5Ev1d3EBqrwQXfRduYJjsAESHG3IQ+JVFIgyjbjc0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AlXe4PiH9KIs1G88CVe9h2vXprJTB03s2o2ui73sM1ayzeg2+QjLdFh2Q3pb7s6iYLVf9Od0YaaR3bYlz5ZzUnWKa3IdZ0udccORBCsgUAo4I2X44n7ZMPArx7VI/9KryIswTBAGx7MyBqNdqdkARoyOWyVkuVxfFuKj8LT2SkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=W9AhSr0C; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="W9AhSr0C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784021808;
	bh=2clA7NHNIRssaPCPFoT8fT06Yko5nCEvY5/wYMYGDLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9AhSr0CmwE09rkBur846SRbjIta4ZePxkj6wRrP+UPP2SDZUCxNOcGhx8qlJs+di
	 lVvzU8qkWU7yVJT6psJj45MiaTINNUIzySsMY0okjoUwpQmE0CszBABJK4fqKHXOyG
	 7XtOZlnBAo/JmifOjlQcz8Pwd4E7UviiFo3Az7M4=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 924940A8; Tue, 14 Jul 2026 17:36:36 +0800
X-QQ-mid: xmsmtpt1784021799tv8nbhilm
Message-ID: <tencent_59689407B1C3204B08362BEEF244A5FE5505@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JunUXiH0PmcIwC/Tu05T+xZbLfYaRKW/mocuJ3rpDIfry+KDNzqz
	 LXgQMUv2H7ol+hxUF828Oq9iTZRofs433h3my5jIqU9Vwu3KwAscGYqBAhkja9nbmyGKqQ63Ym2c
	 B7+Nf80aUV2OZcLmGsyxkFg8K7kFGKMV6jzInvQnHLTspwUpq79BRsy6GgxGscJbFtuobuJii/2G
	 +RGKgvzy0zKbLIgm9Xj6iSboPYMR4o9qqwkgg0IGwQhST1nClNDsyVcMBDIlIrtFd4GaBXUdxbH4
	 DZs4gumlGY6dVAbIkrtEGDDIDUv4fJ7N3tzz00/41o6fl1FA0yADQBX6F6/roANhSSEfTY2p44YB
	 vENqDfF/tDGck+uusany6AEoCDQukh+J2hZJVSqE5Kf1cVpgtXt2sw4KaNcJJWTe1NvQ3a8YQ3NC
	 llOEHK9Toe3lnVYedK40edPjyltQXk0ksurucFZbLvknA3wpVe4QmqnF1DcGRVXKSEh9bil4N6N+
	 cpjWTwyRAb2NKgrf5flS5iDDYwbaNAkI041NaZzc/WXe01ly/gcHGPUZW8+zzv8UyyLGBiQ22wqR
	 KpiCn5TJCrFr/V1y9L4+UBsBOjxOLLu21OfCs1aJ2ZpuVdddSxz2ck6ysVum57cAD8l9n/qCJ9uR
	 GY05Be/nTCNV6T/u/AyOtIyCVMF/uwglDHl2FhK+jVqaOW4j5eajxtf6l3PQrAkQc5kmk6YCriEG
	 +VM9dRJRDHO/sVtcqyYtAc/jrIeYgVWMsWuWKQWnIcH3Gz26Gk87fPf34KVjYzumbVutXLvkmSQi
	 6B9VgF5OlFkJpl3y2P5LcqLi/isgvUSnbPUleR9pLIXKP33eZg9dEJ3/dX2B9FjnWh//xxVBjrIC
	 UUvey8a/iexQ1SVgYJBJNtJNTXjBZhXHT25p/X/z2S97czUZDphSslCddIpQYOLPxqDN90nXyfx2
	 7t4EYggTfpG2cALVrFQzV4mZJEbt8YV0vGh7ve/mWV2C/1TT7HnnFxzvp0C7/8nDZaBR2LI0luX/
	 ETG56M7rJ8mFGOfsYXSRDQflp0hrC8Lp5fglZXQr/Lx3l65Xsd
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	vmalik@redhat.com,
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
Subject: [PATCH bpf-next 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
Date: Tue, 14 Jul 2026 17:35:59 +0800
X-OQ-MSGID: <ce957075cdb393d86e49b38aa977696ba9be67bf.1784021302.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784021302.git.rongtao@cestc.cn>
References: <cover.1784021302.git.rongtao@cestc.cn>
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
 kernel/bpf/helpers.c | 91 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee..e99b64313682 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4195,6 +4195,95 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
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
+	dlen = bpf_strnlen(dst, XATTR_SIZE_MAX);
+	if (dlen < 0)
+		return dlen;
+	slen = bpf_strnlen(src, XATTR_SIZE_MAX);
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
+	for (copied = 0; copied < space - 1 && copied < sz; copied++) {
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
+	return copied;
+err_out:
+	return -EFAULT;
+}
+
+/**
+ * bpf_strcat - Append non-null bytes from a source string, and null-terminate
+ *              the result
+ * @dst__ign: Destination string.
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
+__bpf_kfunc int bpf_strcat(char *dst__ign, u32 dst__sz, const char *src__ign)
+{
+	return __bpf_strncat(dst__ign, dst__sz, src__ign, XATTR_SIZE_MAX);
+}
+
+/**
+ * bpf_strncat - Append non-null bytes from a source string, and null-terminate
+ *               the result
+ * @dst__ign: Destination string.
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
+__bpf_kfunc int bpf_strncat(char *dst__ign, u32 dst__sz, const char *src__ign,
+			    u32 len)
+{
+	return __bpf_strncat(dst__ign, dst__sz, src__ign, len);
+}
+
 #ifdef CONFIG_KEYS
 /**
  * bpf_lookup_user_key - lookup a key by its serial
@@ -4958,6 +5047,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
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

