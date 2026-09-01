Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2100848AE20;
	Tue,  1 Sep 2026 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281970; cv=none; b=frTgKxU4JiqCdjX3AMVaHz6CRAy0AqndPND49VSVPxld7W90ocgXq/6iiwqvl4PvwvOkQdma9KtZoa6UScXmKPLghbnoATyM252hsgCjQlSpXuisHWOgh0bNRMnPqFgCEyERFOGdvtmlUDvDQrLsrnlooP80yCecGUWostXKoBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281970; c=relaxed/simple;
	bh=FXRDIEZwyDVfa+KrvymhtFF1nt5a3eXMIE2uFW/OKhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/pmxOKWu4KdCWpH7F77zolu404hC+A9EUasJZOLELnpcGd8YrondKLCGI6McfVliplYBkW0PhRy49SvqnluDHs1wYICJlTb9FRmFea0tZadoyIArRPoJT3oXzFQTY6f+SYkGQhhjyGz7+0mBCh7oi23CN5WiZ4BZZO5YdeCIzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ASqNDsSf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ASqNDsSf"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681ERRY3396218;
	Tue, 1 Sep 2026 16:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Kp34r
	djgndNLirSiwHMlNqtL6f6ma/pbujza8aPhgFs=; b=ASqNDsSfvLpWXF56UNgDL
	4lVcJH0du6Jin0Gmgi0q2wW4LBQZb8+5o2IJzw3OJgY7rTeDET8g890UNEKFVwa5
	f1VUUcZtH6Bx83y95l1uSGRaM6ymbpR/lXO8O5lU7RUMF/313BNsj/8Wq55iyYxH
	3mQ1V/3z4jGgA/klM0iMlLoa2UPUNlwkjqF7o2Vlq4/cUPI8RvCm4Xd1jB8VSQjC
	TYzo8eO70dXrT4C/1QrF7RSqd1YXanQdEyLjL8sq+TLKmr4WbWvklhLdexTw0uAf
	Yodw3AgK7fQE6r+QgjHPhUBYJehQA+OE8LEBPJ+tLMGaIISrZOJvlxYBQ9Lo9r96
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbpbaw6s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:59:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 681GjZ3c002218;
	Tue, 1 Sep 2026 16:59:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gdymtg9by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Sep 2026 16:59:03 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 681Gw1WP011129;
	Tue, 1 Sep 2026 16:59:02 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-250.vpn.oracle.com [10.154.52.250])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gdymtg8f6-18;
	Tue, 01 Sep 2026 16:59:02 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
        nsc@kernel.org, arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 bpf-next 17/18] selftests/bpf: Test BTF sysfs inline representations
Date: Tue,  1 Sep 2026 17:57:56 +0100
Message-ID: <20260901165757.801449-18-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260901165757.801449-1-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609010148
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX4Nnk+x2uXBxt
 7QEfJN+ak3uB2ipPgOQXhPBqRTWGtEH3qznSCww1B3YmNIs8GPwOaZElgAf18+sp+e288ijNDv3
 qshuyeiBobLMZqhUea57KhBlEhLkN9SW+bClJdloG/TqdmE4LMEJ
X-Proofpoint-ORIG-GUID: v3zQS3QjTr5F_4nYou3BjoJtfrr16sil
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1MCBTYWx0ZWRfX68Ic4e8MGh1C
 9o35W0SdZKCYATwhTPedFFcBlhcm3Zd6iCxqvTekaZL/dbNTLYhPGsrdwtp7fGyb/FmkAAlB0NE
 gLr/ruF1jC0NImOi7Rl/MaCxyUYHLdeH5TJuQBwOXyR5QzoECn1yYuuvVpNSuLDvaeIOao6pRe5
 kwhvB3sUL6fIAbPgjA7tRDryLLIBchTmPnUYh2xXM636SNIkPLu8xjRGfs6OMJwV2qP+uyB5U0b
 KcFAYZdzRHYcxl0kYoVVgZA9V6WkHHq19ehwVoVXJogao7mnnS8f/yvRsrO+25jPei/GYHjlA3W
 J/mO8qgqvrv1kBaPNnV9itcwVWCOoW5UYfrQj0YAFS9fbwtasAjtlJxI/gVkWT3ZdpwuV6uV3PA
 HjtFVeVAqLQcC9BFdf9NnC3r+m9x8bHes0qQbG6EBGN0TRWsf73cbLoj206z0DdNmEc+SpB63Ux
 U7AL8bQhZwjV7wDoJvUw8J1IsMItDHpCXTzUmZnc=
X-Authority-Analysis: v=2.4 cv=DMi/JSNb c=1 sm=1 tr=0 ts=6a970459 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=iU9myO_C7tS8W89IlCUA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-GUID: v3zQS3QjTr5F_4nYou3BjoJtfrr16sil

Load vmlinux, vmlinux.inline and all module and module.inline
entries in /sys/fs/btf; this will allow us to sanity-check

- kernel and its inline representations
- in-tree modules and their inline multi-split BTF representations
- out-of-tree modules and the kernel relocation done for
  module and module inline BTF

Since bpf_testmod.ko is built as an out-of-tree module, the
combination of vmlinux, normal in-tree module BTF and out-of-tree
testmod ensures we sanity check relocations for each case.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/btf_sysfs.c      | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
index 3923e64c4c1d..97eccfd7c134 100644
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
@@ -75,7 +80,76 @@ static void test_btf_mmap_sysfs(const char *path, struct btf *base)
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

