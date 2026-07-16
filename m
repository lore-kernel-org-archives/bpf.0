Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7763B95F6;
	Thu, 16 Jul 2026 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194537; cv=none; b=Z7QsxVGvNsDaJMVdbDm6pls/Wat919Uhl9FbmH8VusMYgzGWZqKhZtKX6fBLquLknQ4eECD9O06GYLP5p07nIed4nrDxEdcnwZKBdy+6qgSw1nXwYdF3vOE8Nqt2KADeWgF5WR8IzQpVOIl4mrmQceru+uommO2VrEy60XDc0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194537; c=relaxed/simple;
	bh=qt3tOxq2zxBlLumwMe4IzVi788q6SvtEm+cQq0NrdrM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mRY+NxHzBdWLvhQxWC/aKkGKFbxDeWfmb7rTVp8XMNQsq/x5M/FhmRfzBIlf25FxyQ0vu0leOE2Byh/GbUT6337uqxc2ucbG7NlaGI/LmCA+3maUO5//6rNeutdhFmLaprdeF0cYZx8nMU2MDsKtq22CHeSKw25Ilw7RFPye108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=KnjrAnyY; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="KnjrAnyY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784194528;
	bh=rZXujHAfrdgGqHnZhlLTY9tn3cqTgW3MdGJ4YeUux50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KnjrAnyYEGe0dKTMu1cQLDSKym22uSug5eNmvJtdef6TZBsmdT3Ys+6eDe9YWjami
	 IPzcMUPQ5xr85cEljxr1I38qaInWuX2AfbwsxakuYCFSqNZnEhuS3BzUykzCwgB4kk
	 OtmTjhQFTcHddWTR9YUYyoxmMNdOv0KB/dmF4S80=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 8CFB3470; Thu, 16 Jul 2026 17:35:15 +0800
X-QQ-mid: xmsmtpt1784194519ts1iyaxhx
Message-ID: <tencent_7B0E22F21BB4086D66815C86AA5CBC5E8E0A@qq.com>
X-QQ-XMAILINFO: M8hb1/7TPQazUCdv1bEd/mXq3Ik8IdiobhHSLukMtln3khDo+LPXdyDvkayio3
	 ec6z6HWw+Vjx4LsWBsLPX9Wdc+xzU97XgLHAuAH2oNg6pb1Xh329uSDCG6IbYPIUD8pBBhpSlyXw
	 CzK7v/FjcXcu6oT6tjyj3GEyMxGg3rqxtwAefDOX3vuj9Y+PL7uC9zkvCbAOX0/9mZFTctufChv/
	 ohUa1LXK/bf7ewkqpj0KccqcCjk8sK62yoshd1sgyDhTtTKy0hcyjTEsB2TTs8os8PjI6/2AXRAI
	 244CM5rsLU49/If4/m26FyrAtwDHWhXVuxWu4wDzX/ZGSr0Kt/iLU5DGMTo7M5bfUo4F+d3Bd5/0
	 Um9YC2fM3eoG3rYwms/SMC0Pi0p8dGtNC20mNjz2W9x1CCXdcZiX0OjCsj6h42MRGij7BmrrgZnR
	 f8Jxxmiu5w05T5GEsx9s0Ulj6Dnka+uEdAVuPMGJoz1H4FYdiDGKJqvpcIJJkhakH8i548S41gen
	 5BsDidD6tlttjYLAHW91S4i7YYOuVRu/GM0A4TPlw0SLMu1xK8vYdKVUfwSjPNB8w8+P7iRtSXQw
	 Lb/ZcAPrvqC3aukSDkx6E9M0dQX1uSZx4P241ZYqKreSvOyGp3KYC1gvzJzWZF6LHUO4RVge3H+e
	 iHkweORx+5FMUmdUYGW+WfQC84U4NZwRlw6Hiur8AMlz7TQKyDmMt+wb9bXj8Kt06YaCW4IJF4KI
	 pBGTM4akvmcK/UyXe/BxLxq10zQK4LF7ZprSLY2RC5dwo0uG1gfZXEpmdsQ3AYU2DrDwcknqrLDu
	 sMjBbitQkfHSBeBdBR1KgaGuZkjiwfTgP1Dn/UnyKxj2DPATTG4GR8gnIRqPtKtTOxoH7jQAu6fy
	 g6wevKcYvTgbwXn/OjcAk/BqZPZ5Yhkgt0yhlVKYthCQi9aTJILR/FaxzdxKUdsvyLc8+89ekMDu
	 tEbA7Z0N8xKS9UsYoYoBP6ls0l62qvOF4ENV/eCsMZME+DaKyd4aJr4FFZJqCb3OJhVkhBAmzAaX
	 KBQf4ZK1sw2UKZ8etzgI8stHJqc/2VwMXugJM/qp2HRbAXyS2NSY6N3QQS9uhpOkFYKOOsvLSUhz
	 oTSrwU6Ja2LX4a+WOs8aSjLVtvZ//dbDr5nu5p3y8ElM3+dp37KFMvCsHu5w==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
Subject: [PATCH bpf-next v3 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
Date: Thu, 16 Jul 2026 17:34:50 +0800
X-OQ-MSGID: <8b6f00943e0d7e38f1f4ee1af007417771e00d39.1784194024.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784194024.git.rtoax@foxmail.com>
References: <cover.1784194024.git.rtoax@foxmail.com>
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

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c18f1e16edee..e4708a4f3470 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4195,6 +4195,97 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
 	return __bpf_strnstr(s1__ign, s2__ign, len, true);
 }
 
+static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
+{
+	int dlen, slen, space, copied;
+	char cs;
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
+
+	copied = strncpy_from_kernel_nofault(dst + dlen, src,
+				      min(space, sz + 1));
+	if (copied < 0)
+		return copied;
+	else if (copied == 0 || copied == 1)
+		return dlen;
+
+	/* The copied character count includes '\0'. */
+	copied--;
+
+	if (copied < sz) {
+		__get_kernel_nofault(&cs, src + copied, char, err_out);
+		if (cs != '\0' && sz > copied)
+			return -E2BIG;
+	}
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
@@ -4958,6 +5049,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
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

