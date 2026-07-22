Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C1389459;
	Wed, 22 Jul 2026 04:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695347; cv=none; b=eXwzerebYn+P7lioziMqNIbXprTIT594kNoAwAhSwzxfVFvzWw3Ailqn12n9YA3KeSStJ5oH+J+gI9wNLNAxpCr6T23ghOYewlZb3fGLEvsCSzgaNCcH0gyOPG7OvbpCDn5BBkoNiM20Ku30SwufI5XLKpsrML8eyxlubaBzwLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695347; c=relaxed/simple;
	bh=wPnO+rdhWhHU4W916hYj3apl30glcr+ygckHKdjpxrI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XJVYYMO72bpGgicM1csf9ou8a3UGm6jjNKkaZVgDsS7yfrSSmEHOMeL4rZutv16dwFQTbVE3YLtDyEFR2uljp4bmD9hYlGZmWEXuRMmcPolt+YNj1smDzCW798LapRQosgAsN/oJ3Kcx6MdewS2tanLLcw82/Ut4Aydtfi0sTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=g8pR5sot; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="g8pR5sot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784695342;
	bh=WlEcT0tWpxZI6RXRhm5LeYSQ7/dWQKcbRqEN/6k1Exc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8pR5sotx+CMA9m3GVCL5+OpE3baBSbAQNRGijBGTshBYdyyUiQ1VMUw/fq3lK0lM
	 Jd63YXFFLYDqLjEwKlrxjZfc+uQgNZWkMJQy1mIZo+jT7DtOTPnZpG7JRgqwdVqkTO
	 Q4krgfarMgMbaKFUWGCpEg2c+b1cDENICFHfS2KM=
Received: from NUC10 ([39.156.73.14])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id A70214ED; Wed, 22 Jul 2026 12:41:48 +0800
X-QQ-mid: xmsmtpt1784695332t2sbrldap
Message-ID: <tencent_586BE1E837629801BE504D16D665994AF506@qq.com>
X-QQ-XMAILINFO: N0Cpyjih+sbnOPeF0KhF35PRFgYVEiyPfCX+jFTK+77vUZLWvrh+MifZQW22OB
	 N3EkBEFtF4oMSAdGS/qs1/zpPEe1LPhsDD20j9lpuIM3LOqdYaCx8VK94d2xkGXhNp/++n27KYUP
	 39toiRXKoHV9rpHiI8WYg7wnfszY3Gk6Bv5kfzR4+ea0wUlI2Tz1RYnvCnFpAKCJP/JQUgTlqe0H
	 8/fphEICGj6QdjkTZDT0/WWIaOXTm+xLHFInWx8OiqEXiw5iIzXChG3TEgBciA+EAS7UuHw/XR5A
	 gNlJJ915fbVcPfDsULuadF/moAPiMdGUwN/4Qmu3r2pDQY6tzrZqAZC3W850Fhw/ChXKLQuIkh6m
	 cfWLAieTX63nrIZY7padjXsFaTxrcGpUCh8ktmhvffponVNf8PGVGPhAR1XZSeBLlerjdp+UP+1g
	 uNW/tLPhvsXTq5iAu7zqYjnTXugKtQRlUcZ8hogXfXSCaaiHB+Pn3miZ7Jg47wEkFA4KTN2vH7jV
	 Zd5PR1GeM3+fB9SGSee835Y1MZC196JcgfrDiOJpn1KseXtM+Khuk2sjIPqBHRmKNBTfqYp/cMIE
	 1kNiMBwWj+vFi//Ezt80zRMvJy0P+/+KQYLng6SIt+v82PPkFepxobVj+9ImlCyjhwvbXKRODQ11
	 bEAK/fjc8ihff+VakWJSyPNnV4/8re/ZHVkgZ9X+xJU7TpKWvvZDUoICTlSP9AUKNuGLalRI3h87
	 S3CLIhBsDs0U33/Wwuyrl1O5GzkixjXLVACRCvhdPyXJfTZ89BBQG+qthUBbRsnGPys1OOgsyoJa
	 p7uBeelfyIHDuAgQjf4t9fnJiEkgMOAAHpEPyojZkh+JfZWJxeaDJKElqCgGo4YbNW7En7b9cv2z
	 UoS3LJNRDiC+P7A/TqqAIVd5VPAMn5SQmh+8v6WLcprw8rpMeDaQqZ8aVTGV1xbHqAXDbSPjcPyQ
	 O5zufOR0CcbXD92ZrTtft3GGIwTgXLRECNNYPJ+AqmCuxHNgeqQb1j2vgBdss0xqke9fitiSjg8k
	 4TLa+5WCXaClUtT+KsbcQHlg9JL3eE/derAAzuV/YpgpXZuCt5C1e5tsZksPfttrax2eUBuIgYIl
	 2voPhzIwreD0uHbnVcwXn0BL6AEqzH2XmVKCV4D+p8YcCWXPw=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Test bpf_strcat,bpf_strncat kfuncs
Date: Wed, 22 Jul 2026 12:41:28 +0800
X-OQ-MSGID: <a04f1b029dbdc4d3c7af658ee9643ed8ba840462.1784695085.git.rtoax@foxmail.com>
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

Add tests for new kfuncs bpf_strcat() and bpf_strncat().

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 .../testing/selftests/bpf/prog_tests/string_kfuncs.c |  2 ++
 .../selftests/bpf/progs/string_kfuncs_failure2.c     |  3 +++
 .../selftests/bpf/progs/string_kfuncs_success.c      | 12 ++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
index 300032a19445..460567ef622a 100644
--- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
+++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
@@ -24,6 +24,8 @@ static const char * const test_cases[] = {
 	"strcasestr",
 	"strnstr",
 	"strncasestr",
+	"strcat",
+	"strncat",
 };
 
 void run_too_long_tests(void)
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
index 412c53b87b18..2dbd1349689e 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
@@ -5,6 +5,7 @@
 #include <linux/limits.h>
 
 char long_str[XATTR_SIZE_MAX + 1];
+char str[] = "hello";
 
 SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
 SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_strcasecmp(long_str, long_str); }
@@ -23,5 +24,7 @@ SEC("syscall") int test_strstr_too_long(void *ctx) { return bpf_strstr(long_str,
 SEC("syscall") int test_strcasestr_too_long(void *ctx) { return bpf_strcasestr(long_str, "hello"); }
 SEC("syscall") int test_strnstr_too_long(void *ctx) { return bpf_strnstr(long_str, "hello", sizeof(long_str)); }
 SEC("syscall") int test_strncasestr_too_long(void *ctx) { return bpf_strncasestr(long_str, "hello", sizeof(long_str)); }
+SEC("syscall") int test_strcat_too_long(void *ctx) { return bpf_strcat(long_str, sizeof(long_str), str); }
+SEC("syscall") int test_strncat_too_long(void *ctx) { return bpf_strncat(long_str, sizeof(long_str), str, 3); }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
index f65b1226a81a..40583361c655 100644
--- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
+++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
@@ -59,5 +59,17 @@ __test(-ENOENT) int test_strncasestr_notfound1(void *ctx) { return bpf_strncases
 __test(-ENOENT) int test_strncasestr_notfound2(void *ctx) { return bpf_strncasestr(str, "hello", 4); }
 __test(-ENOENT) int test_strncasestr_notfound3(void *ctx) { return bpf_strncasestr("", "a", 0); }
 __test(0) int test_strncasestr_empty(void *ctx) { return bpf_strncasestr(str, "", 1); }
+__test(0) int test_strcat_success(void *ctx)
+{
+	char buf[32] = "hello";
+	bpf_strcat(buf, sizeof(buf), str);
+	return bpf_strcmp(buf, "hellohello world");
+}
+__test(0) int test_strncat_success(void *ctx)
+{
+	char buf[32] = "hello";
+	bpf_strncat(buf, sizeof(buf), str, 3);
+	return bpf_strcmp(buf, "hellohe");
+}
 
 char _license[] SEC("license") = "GPL";
-- 
2.55.0

