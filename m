Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735548F020;
	Sat,  3 Oct 2026 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056676; cv=none; b=NzMvAbMwkPURB6nfJbqKV7+GDaetyyUTp2HH11eU0s0jjnbwam19g+XsnASg+fBzTcBN55rbtnLUnDBvdsh3dLleS6FWl30I3sLVq8doJcPS4aNIkK5Tr92fsZUzmsdyzvGlxbTux4O1SUJAbDttfcFWDJBKuqdjsnXKq9j3HYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056676; c=relaxed/simple;
	bh=w1BYy5xeBPLeHJMrvuV7ZUZB8JxBcz1dL0OPOd3KyUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdyvgPgqY9nAoAIow+LKjh6OFAJtabfhOwpayAFE8gbxRdGL+N67pqgmDkgjFlePNXeU0AFJD9363I8/pn0IY34eV9fSes9vm3SsAwYtqMxf1plSMvenfba8ODn5hpCAYQyC9q6tSzU3A6D/3KWzc87HjmPNvDRlVqpBDCnb0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cyAfjY/b; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cyAfjY/b"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693JaBFr2717618;
	Sat, 3 Oct 2026 19:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=b/SUe
	6xPQ4bl02RDS1OoRz875Dcx5dc8LTPYC+aiev4=; b=cyAfjY/bt2pxSadTmYzf+
	3liejCLW8qxQNC6Si1s2ul+0h3fklxczChXFdy7GAeWMrEo/crT23W2n93XL9Hz5
	qS9r524hRKlTS86WFzWQZXAmTbG0rxBgARaKxFm+O0a/Fq6lOVl/nKbKGYlANQVk
	R9IPAGcISA7uf8Bxa1PkvsQgkwU/f8JOBuQ7W2RVGV7YZj7n8seiO1FAYSF2mUnd
	gJQV0olWBsAVPf7PwswV2LqcWoml/swiApE8c2tKuW1kgS3YkY3NSgIH1kNmyDGk
	NhVgAdC5sOgGQ/ZLuv5YwHvfNrhg/O4/gHBfZ8ydFacA1kWI9YOITWvaMbJwSgJs
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2rm98ens-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:44:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 693JZ2Q1005073;
	Sat, 3 Oct 2026 19:44:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h2r58yyun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Oct 2026 19:44:09 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 693JdEN5012617;
	Sat, 3 Oct 2026 19:44:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-182.vpn.oracle.com [10.154.83.182])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4h2r58yynt-7;
	Sat, 03 Oct 2026 19:44:08 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com
Cc: jolsa@kernel.org, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, mcgrof@kernel.org,
        petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org, nathan@kernel.org,
        arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 bpf-next 6/7] selftests/bpf: Test BTF sysfs inline representations
Date: Sat,  3 Oct 2026 20:43:22 +0100
Message-ID: <20261003194323.817885-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261003194323.817885-1-alan.maguire@oracle.com>
References: <20261003194323.817885-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610030078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfXx08GPW5z/wkh
 5xb034W63SksF24x9xoERRKiODOhj40+ImjdiaFSuQo0D3Uf86h/eiyOzFSTy4kd6xFeGt2WXRR
 XnCz0+mdb4HOhMiW7wki8TS/AYxf5+uDy54wjEM6RZo4l5+Pl7Bw0jSuSz22V5KFoivHR3C4RG2
 5DocgRqlvZ3Il5oOzyUu+nP8BFoJ7sInwPdlaU/2nIodzS27oyHyG8zkm+z6ZstE+0WSbpd/Pe3
 vvGpckjcGXBREhm/KIDZSA/23suGvBthZcjqdY3MjbZqVEXmJCpbrwuiduXJ3FiKDAI5t/8mBSJ
 Af4XNAPD9ifxpkgvrWclNDktA5Uqoa0a3I2CV8Rew7q6BCKbkQhu4KqL1zanQFfLl2WwufgmHRI
 4W9hi74F/eXZjflgrg6MpfqN7udLYcKtJLolf6sh2I4eih3Q9W6of/R6eZ0ryIfRa+QCimNhq3S
 +p15ACagXbcphunf2DA==
X-Authority-Analysis: v=2.4 cv=QMD91QLL c=1 sm=1 tr=0 ts=6ac15b0a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=iU9myO_C7tS8W89IlCUA:9
X-Proofpoint-ORIG-GUID: ojMfg7F7V_UnbE8bex9wUTuqUflHFzT4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA3OCBTYWx0ZWRfX33R8BSmQN8iv
 wHYmdUH3yCAg3DbzAPVnqU+aLF/WZIzBMH6xmSRuPEBTbu9bqhovw72OSbWwGMWO9zyJ55n5JvF
 iCKxzwfzoWkaepEplC/NMQCiSkZAOl6Ul3qq1Y381gweSOOIB7xS
X-Proofpoint-GUID: ojMfg7F7V_UnbE8bex9wUTuqUflHFzT4

Load vmlinux, vmlinux.inline and all module and module.inline
entries in /sys/fs/btf; this will allow us to sanity-check

- kernel and its inline representations
- in-tree modules and their inline multi-split BTF representations
- out-of-tree modules and the kernel relocation done for
  module and module inline BTF

Since bpf_testmod.ko is built as an out-of-tree module, the
combination of vmlinux, normal in-tree module BTF and out-of-tree
testmod ensures we sanity check relocations for each case.

Also test mmap for vmlinux.inline.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_sysfs.c      | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
index 3923e64c4c1d..069c4483b3a2 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
@@ -3,11 +3,16 @@
 
 #include <test_progs.h>
 #include <bpf/btf.h>
+#include <dirent.h>
+#include <limits.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
 
+#define BTF_SYSFS_DIR		"/sys/kernel/btf"
+#define BTF_INLINE_SUFFIX	".inline"
+
 static void test_btf_mmap_sysfs(const char *path, struct btf *base)
 {
 	struct stat st;
@@ -75,7 +80,78 @@ static void test_btf_mmap_sysfs(const char *path, struct btf *base)
 		close(fd);
 }
 
+static void test_btf_inline_sysfs_all(void)
+{
+	struct btf *vmlinux_btf;
+	struct dirent *dentry;
+	DIR *dir;
+	int err = 0;
+
+	dir = opendir(BTF_SYSFS_DIR);
+	if (!ASSERT_OK_PTR(dir, "open_btf_sysfs"))
+		return;
+
+	vmlinux_btf = btf__parse(BTF_SYSFS_DIR "/vmlinux", NULL);
+	if (!ASSERT_OK_PTR(vmlinux_btf, "parse_vmlinux_btf")) {
+		closedir(dir);
+		return;
+	}
+
+	while ((dentry = readdir(dir)) != NULL) {
+		struct btf *base_btf = NULL, *module_btf = NULL, *inline_btf = NULL;
+		char btf_path[PATH_MAX], inline_path[PATH_MAX];
+		struct stat st;
+
+		/* Skip ".", ".." and "foo.inline" */
+		if (strstr(dentry->d_name, "."))
+			continue;
+
+		if (strcmp(dentry->d_name, "vmlinux") == 0)
+			base_btf = vmlinux_btf;
+
+		if (snprintf(btf_path, sizeof(btf_path), "%s/%s",
+			     BTF_SYSFS_DIR, dentry->d_name) >= sizeof(btf_path) ||
+		    snprintf(inline_path, sizeof(inline_path), "%s/%s%s",
+			     BTF_SYSFS_DIR, dentry->d_name, BTF_INLINE_SUFFIX) >=
+			     sizeof(inline_path)) {
+			ASSERT_FAIL("BTF sysfs path is too long\n");
+			break;
+		}
+
+		if (!base_btf) {
+			module_btf = btf__parse_split(btf_path, vmlinux_btf);
+			err = libbpf_get_error(module_btf);
+			if (err) {
+				/* A module can be unloaded while its sysfs entry is iterated. */
+				if (err == -ENOENT)
+					continue;
+				ASSERT_OK(err, "parse_module_btf");
+				continue;
+			}
+			base_btf = module_btf;
+		}
+		if (stat(inline_path, &st)) {
+			err = errno;
+			if (err == ENOENT)
+				continue;
+			ASSERT_OK(err, "stat_inline_btf");
+		}
+		if (base_btf == vmlinux_btf)
+			test_btf_mmap_sysfs(inline_path, base_btf);
+		inline_btf = btf__parse_split(inline_path, base_btf);
+		err = libbpf_get_error(inline_btf);
+		if (!err)
+			btf__free(inline_btf);
+		ASSERT_OK(err, "parse_inline_btf");
+		btf__free(module_btf);
+	}
+	closedir(dir);
+
+	btf__free(vmlinux_btf);
+}
+
 void test_btf_sysfs(void)
 {
 	test_btf_mmap_sysfs("/sys/kernel/btf/vmlinux", NULL);
+	test_btf_inline_sysfs_all();
 }
-- 
2.43.5

