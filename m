Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF73D6CB8;
	Fri,  9 Oct 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545071; cv=none; b=UIbSIfc5RBh0I4G51mdIGNy1tYOazUVNtpk53R4MkbAl8HkoUIlOjr9697MxeVkKP2e8HCURI1dBjcS/i0dVOdM8mix15SRk5IaahIk0cyhr7gvkaSI3WoEZvJhW7zENSk9wM9r0Zis13L5L+wuXOZyfBBkPMQ/H/ekH3CoAzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545071; c=relaxed/simple;
	bh=A/Xo3RVxh1ZCUOA3sgeLMFejXsw1UnydJ2Q7BZJnKkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssy3pjsqJjEjkqSwF5hya/x2SrmcbeWn9tUQZg3y0DlZ+xOnOk4NuPUzGWec/ljdhfgstH2aDel+UL+OSIoPMe+EAtKtO31IVdAJFaIbrKNSyFRjia1QtT/AOLUTkY83G+2ZI9xJwF+Go24ddNEARMwi394Et9kiT3AAjbOOL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PYxSCvvX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PYxSCvvX"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6991njpm2028956;
	Fri, 9 Oct 2026 11:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=KC9At
	8JoZK6PjG0DKET4GiPn7pfN2CxANcw1sZLK4cE=; b=PYxSCvvX3/IX9Tkvv5RQN
	9z3TwZZTiFpL0E8AkzRzEN/RbaMFVQ3Pn1IouHE40et/X7DAeMOpl7A+PMIZySH5
	PT1wvSBbTHkT8/iX9WbA5af59UcHdyadRxZBkYyKli6fQ34qL2Jbnzm/cJkgaKEn
	5hdNK40cv28jVyvdF+9yJQnyP3ENkTg35YKf5BX+JdpbGeLhFX9W8VdXY7CS0SO4
	fD/vlpL8ed9fdBqd3zg0G7P0gs5jMcHxEgShQieTogCE5QELLgQ+LNED/hiiQXFs
	SHBH3YnRaXqhJJ6IMHZbACGxttlxOalX7ynkCjRVq6eJw5/nsUYKf8eMwvOo1ntO
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xeh31h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699BLkJ5039969;
	Fri, 9 Oct 2026 11:23:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xfcsnfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:23:49 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 699BNRkc006543;
	Fri, 9 Oct 2026 11:23:49 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-85-231.vpn.oracle.com [10.154.85.231])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h5xfcsn8m-7;
	Fri, 09 Oct 2026 11:23:48 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        jolsa@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, mcgrof@kernel.org, petr.pavlu@suse.com,
        tj@kernel.org, kees@kernel.org, nathan@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 bpf-next 6/7] selftests/bpf: Test BTF sysfs inline representations
Date: Fri,  9 Oct 2026 12:23:23 +0100
Message-ID: <20261009112324.1442319-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261009112324.1442319-1-alan.maguire@oracle.com>
References: <20261009112324.1442319-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610090045
X-Proofpoint-GUID: xkbvtM099dU37sqgNt2DdqDpjEf0A2rZ
X-Proofpoint-ORIG-GUID: xkbvtM099dU37sqgNt2DdqDpjEf0A2rZ
X-Authority-Analysis: v=2.4 cv=LZ2peTfi c=1 sm=1 tr=0 ts=6ac8cec6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=aUn3EfpHYzEyQR4b3IMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX4a9mIQhiZNEY
 V3ebqxaHUvhwfPzWPkrmmYja/P8B6URlGKiCk/aoey6Sg+JQR7e2a68utbhRDGI+D/efrORgkCa
 G+qlJ/2XHAJN5Ug4VEib3I+2BNLtGLYZlaC5nD+tKdyJcgCxsteB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NSBTYWx0ZWRfX1UE3WfbP2uo9
 Z3M4wzYgY7FOlKzqOxBoFrS0kAXLLbftvCAwlf0++sKLC9bts0/ytfhhy32KDE3z+nDFtbNvEMg
 rRb2g7oj8fOFXUt5Gf2i08ecAkJowCK2knESREnHKXPZFRXHYSM/QfkBn67xBy2vR9HiLZTZpDk
 KNQDA+UjxipUlcpTRVdbaAVg5jLNQ0cJf7iqz/SFc1Jpc/sxN4dgZn8uvWp4soSs63g2AnbjE4K
 sKUyzPBS/ItAvt/q4J3QNbukitsE1CwQEDsUti6SHlD4Nrjnpc/xg9xpfS0TKp11dqCkTb4XRri
 mn/5qh5iF12//jj3zNLL8BHJf910Fa548BQiixVDZ8wu3j5A8b+gmfuU2h3EOz9XFBlDEEbnq7k
 EEJUCMDbXJPiXRGhY3A4DgKU5pVx53Dvbgxskpc0B3z37Jnp9ZSfZfMP/0ILrBSD0HvaUUWjihT
 YMM+4HDh2R9tlrHjrFBBCRKjyqiWAZLEiwLvUnCo=

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
 .../selftests/bpf/prog_tests/btf_sysfs.c      | 87 ++++++++++++++++++-
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
index 3923e64c4c1d..3fde8598189f 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
@@ -3,15 +3,21 @@
 
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
 	__u64 btf_size, end;
+	size_t mmap_len = 0;
 	void *raw_data = NULL;
 	int fd = -1;
 	long page_size;
@@ -26,6 +32,7 @@ static void test_btf_mmap_sysfs(const char *path, struct btf *base)
 
 	btf_size = st.st_size;
 	end = (btf_size + page_size - 1) / page_size * page_size;
+	mmap_len = btf_size;
 
 	fd = open(path, O_RDONLY);
 	if (!ASSERT_GE(fd, 0, "open_btf"))
@@ -39,11 +46,13 @@ static void test_btf_mmap_sysfs(const char *path, struct btf *base)
 	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_shared"))
 		goto cleanup;
 
-	raw_data = mmap(NULL, end + 1, PROT_READ, MAP_PRIVATE, fd, 0);
+	mmap_len = end + 1;
+	raw_data = mmap(NULL, mmap_len, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_invalid_size"))
 		goto cleanup;
 
-	raw_data = mmap(NULL, end, PROT_READ, MAP_PRIVATE, fd, 0);
+	mmap_len = end;
+	raw_data = mmap(NULL, mmap_len, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (!ASSERT_OK_PTR(raw_data, "mmap_btf"))
 		goto cleanup;
 
@@ -70,12 +79,84 @@ static void test_btf_mmap_sysfs(const char *path, struct btf *base)
 cleanup:
 	btf__free(btf);
 	if (raw_data && raw_data != MAP_FAILED)
-		munmap(raw_data, btf_size);
+		munmap(raw_data, mmap_len);
 	if (fd >= 0)
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
+			if (err != ENOENT)
+				ASSERT_OK(err, "stat_inline_btf");
+			btf__free(module_btf);
+			continue;
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

