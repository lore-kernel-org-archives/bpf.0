Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67423446C3
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768966427; cv=none; b=hSlTagGQJOCA2LL7pyMJIyI9qDvV2Vorn649VPh4m8ZsXFcrJRdSidwIm6nAIxWXJ6fsPUEiZXESVKZAVCHMYZUl+EDYbFaSABvYD/YH3cZQuNcA0KQlI2Kw+3cwTFQcAWjEzCaJos1Y5d4G6vjmGcxKXM2qZ/bEP3ndN9NTkzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768966427; c=relaxed/simple;
	bh=F21MI5GQuWWSiB4d9YkclAooyldWmaxLA/S5E9KjkyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVal4ZjJtWxSyDTday2tnc5MTvg8iiNIOHp6JvrjHdMIXQeHRp/fVDbmRrSerbtQA9/ImC1UjtAV/XxMLrOinxcC9oGAVcMEnxWEorZHLD/9+P3DdXjydJNprdQs+xk962lPoEstRDdC+roUAYvOEsmjwm41IXEzMdwwOY6ELT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: 7oPjcm1FRQiSOR24PNraKw==
X-CSE-MsgGUID: gzgvm7YwT4+nrFGb0/2RHg==
X-IPAS-Result: =?us-ascii?q?A2EPBAB5SHBp/zYImYJaglkCglWCW7ZoBgkBAQEBAQEBA?=
 =?us-ascii?q?QFaBAEBhQcCjQMnNwYOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBAQUBAQEBA?=
 =?us-ascii?q?QEGAwEBAgKBHYYJU0kBEAGGCAYyAUYQUVYZgwKCdLEDgQHdei1UgSYBCxQBg?=
 =?us-ascii?q?TiNUnGEeEKCDYR9hBp2hXcEgzCUFEiBHgNZLAETQhMNCgsHBWphAhkDNRIqF?=
 =?us-ascii?q?W4IERkdgRkKPheBChsHBYEiBoIVhmkPiTOBdgMLGA1IESw3FBtCbgePF0eBP?=
 =?us-ascii?q?GsHgQ57NpALB4d3jw+hEYQmhFEfnGhNhASUFZJSLphYpFmGZoIATTiDIlIZD?=
 =?us-ascii?q?44tFsthaTwCBwsBAQMJhn6KbIF/AQE?=
IronPort-Data: A9a23:lBkWNaD81yoIjRVW/4Tiw5YqxClBgxIJ4kV8jS/XYbTApD9z1TxRn
 GYdWGzTOvzbMGH3eI12b4vn9x4OsJeAm94yTANkpHpgZkwRlceUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuFYTdJ5xYuajhKs/vZ8Es01BjPkGpwUmIWNKgjUGD2yiF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQR4/ZwGyojxE4
 I4lWapc6eseFvakdOw1C3G0GszlVEFM0OevzXOX6KR/w6BaGpdFLjoH4EweZOUlFuhL7W5mq
 vsgKjsINz65vuON54jhFtFKnM0AM5y+VG8fkikIITDxCOZjTZ3HQrvH/84ewTo7wMlFW/TGD
 yYbQWM0NFKZPkYJahFKVPrSn8/x7pX7WzxDqFOErK8+y2jLx0pwy/7wPdGTc9fMR909ckOw/
 zqYrjqnWkBAXDCZ4TWX/Wyp2d7QoX+4Xpg8O7fgsaRQoFLGkwT/DzVMDAHk/qDo4qKkYPpeM
 EwV6yMrpIAy7EftT8K7QhCz5neP+BwEM+e8CMU/+ESBx67V/QuDFzFCUzNKLtUt8s0uLdA36
 rOXt4zuPT5kteS7c0uczZCu92+KHzIcDnBXMEfoUjA5D8/fTJYbrCqnczqOOKuly9H4HTDuz
 iqb9W4jir5VhMVN1b3TEbH7b9CE+8Whou0dv1q/soeZAuVRP9fNi2uAswSz0Bq4BNzFJmRtR
 VBd8yVehchXZX13qMByfAn9NOvwvanaaWy0ba9HA5ksvymr+mCuZ5tR/CA2I0khP8IJciPzZ
 wrYvgZU+ZlSN3K2bKhxeOqMNinrpIC+fenYugf8PoAUMsMvKVbYlMysDGbJt13QfIEXuflXE
 f+mnQyEVh721YwPIOKKetog
IronPort-HdrOrdr: A9a23:I8q+Yavib6IZuWI9qqZDUMm27skDv9V00zEX/kB9WHVpmwKj5r
 mTdZMgpGTJYVcqKQkdcL+7Scq9qB/nlaKdpLNxAV7AZmbbUQmTXeVfBOLZqlWKcREWtNQy6U
 4KSdkYNDSfNykdse/KpCe9V/ktyMSa66yz7N2uqkuFjjsGV4hQqyl8AgafVmtsRAdHApI9UL
 6R/NBOqTblWVl/VLXYOpDNZYT+m+E=
X-Talos-CUID: 9a23:aAXCum/ETlINXk9ChHmVvxETIsIudyTz9k7RGGiCUzpRbqecakDFrQ==
X-Talos-MUID: 9a23:UR1sFgmLxyB7vLv69C/CdnptJsh25vufF3xR0pMcleaObWsqAReS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,242,1763391600"; 
   d="scan'208";a="106966093"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 21 Jan 2026 12:33:39 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 56985183E392;
	Wed, 21 Jan 2026 12:33:39 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com,
	vmalik@redhat.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v5 1/2] bpf: add bpf_strncasecmp kfunc
Date: Wed, 21 Jan 2026 12:33:27 +0900
Message-ID: <20260121033328.1850010-2-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121033328.1850010-1-ishiyama@hpc.is.uec.ac.jp>
References: <20260121033328.1850010-1-ishiyama@hpc.is.uec.ac.jp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_strncasecmp() function performs same like bpf_strcasecmp() except
limiting the comparison to a specific length.

Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Acked-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/helpers.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a7..6c36f0fb5da7 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
  * __get_kernel_nofault instead of plain dereference to make them safe.
  */
 
-static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
+static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
 {
 	char c1, c2;
 	int i;
@@ -3417,7 +3417,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
 	}
 
 	guard(pagefault)();
-	for (i = 0; i < XATTR_SIZE_MAX; i++) {
+	for (i = 0; i < len && i < XATTR_SIZE_MAX; i++) {
 		__get_kernel_nofault(&c1, s1, char, err_out);
 		__get_kernel_nofault(&c2, s2, char, err_out);
 		if (ignore_case) {
@@ -3431,7 +3431,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
 		s1++;
 		s2++;
 	}
-	return -E2BIG;
+	return i == XATTR_SIZE_MAX ? -E2BIG : 0;
 err_out:
 	return -EFAULT;
 }
@@ -3451,7 +3451,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
  */
 __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
 {
-	return __bpf_strcasecmp(s1__ign, s2__ign, false);
+	return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
 }
 
 /**
@@ -3469,7 +3469,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
  */
 __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
 {
-	return __bpf_strcasecmp(s1__ign, s2__ign, true);
+	return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
+}
+
+/*
+ * bpf_strncasecmp - Compare two length-limited strings, ignoring case
+ * @s1__ign: One string
+ * @s2__ign: Another string
+ * @len: The maximum number of characters to compare
+ *
+ * Return:
+ * * %0       - Strings are equal
+ * * %-1      - @s1__ign is smaller
+ * * %1       - @s2__ign is smaller
+ * * %-EFAULT - Cannot read one of the strings
+ * * %-E2BIG  - One of strings is too large
+ * * %-ERANGE - One of strings is outside of kernel address space
+ */
+__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
+{
+	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
 }
 
 /**
@@ -4521,6 +4540,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp);
 BTF_ID_FLAGS(func, bpf_strcasecmp);
+BTF_ID_FLAGS(func, bpf_strncasecmp);
 BTF_ID_FLAGS(func, bpf_strchr);
 BTF_ID_FLAGS(func, bpf_strchrnul);
 BTF_ID_FLAGS(func, bpf_strnchr);
-- 
2.52.0

