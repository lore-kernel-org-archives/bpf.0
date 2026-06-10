Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3781A6839
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 05:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068726; cv=none; b=HswNGmLbWr/2kMehFyT8kGKzCYDp6JXZn9p2Fs0X4k114VI318BnISVy3J2tRcuesqQ440ukT3UrFz0YakX2RGI8/4qnieYFVjKn0rxwqDq3iFLOLDL1VF8N8MtDzmLhphOEbvHNqn3vnDonxLPwHs9wTbDsCofAJFQ5qxNvnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068726; c=relaxed/simple;
	bh=BHnvX3Jpmk7IMeN90Bt6Cpce+yZmPKAxV0SXYb9GM8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hl40z/SG+zyFuWg7wKiZ1+iNSlO0FZU3qFwXLIUBVZWA9P7T6Z5leL4yqVD1V6x1Q0MVmwVi45ODTXeAgtqulr3lvQfoxYhdSAmUOhfr9O1hPeBE1Z+l+3BIgGGafqls3ODRPPk+f9U7is66bwPTIo0MrlJLwoOqj7Resp1ab8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 633AB14C3ED424; Tue,  9 Jun 2026 22:18:31 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix bpf_iter/task_vma test
Date: Tue,  9 Jun 2026 22:18:31 -0700
Message-ID: <20260610051831.1346659-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For selftest bpf_iter/task_vma, I got a failure like below on my qemu run=
:

test_task_vma_common:FAIL:compare_output unexpected compare_output:
    actual
    '561593546000-561593585000r--p0000000000:241256579534/root/devshare/b=
pf-next/tools/testing/selftests/bpf/test_progs'
    !=3D expected
    '561593546000-561593585000r--p0000000000:245551546830/root/devshare/b=
pf-next/tools/testing/selftests/bpf/test_progs'

Further debuging found out file->f_inode->i_ino value may exceed 32bit,
e.g., i_ino =3D 0x14c2eae35, but the format string is '%u'. This caused
inode mismatch between bpf iter and proc result.

Fix the issue by using format string '%llu' to accommodate 64bit i_ino.

Fixes: e8168840e16c ("selftests/bpf: Add test for bpf_iter_task_vma")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c b/too=
ls/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
index d64ba7ddaed5..d7fb561ed4fb 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vmas.c
@@ -52,7 +52,7 @@ SEC("iter/task_vma") int proc_maps(struct bpf_iter__tas=
k_vma *ctx)
 		bpf_d_path(&file->f_path, d_path_buf, D_PATH_BUF_SIZE);
=20
 		BPF_SEQ_PRINTF(seq, "%08llx ", vma->vm_pgoff << 12);
-		BPF_SEQ_PRINTF(seq, "%02x:%02x %u", MAJOR(dev), MINOR(dev),
+		BPF_SEQ_PRINTF(seq, "%02x:%02x %llu", MAJOR(dev), MINOR(dev),
 			       file->f_inode->i_ino);
 		BPF_SEQ_PRINTF(seq, "\t%s\n", d_path_buf);
 	} else {
--=20
2.52.0

