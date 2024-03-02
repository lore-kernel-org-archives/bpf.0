Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171022636
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398249; cv=none; b=DWn+AUFr8EnD12DNlmI0Xd/8ViYlib5DF9EtrwzWUXZEkfL8sYneY9Jxvw/kgusGacyl3uTy/HGsjiZWJORdwNhrt22UJ+LDNKa1ZzHT9O7LpuOpMlt4AeYIiD4FIkPyNm02Pmo8VE7qzZHRydCcPN9RhiSpB9oaBkTcnB19/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398249; c=relaxed/simple;
	bh=SoTVYL5OCPTtytBCC3p5VbgJZZaUvJ7rSwHVWrla+Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqZZKRMZRjNkLD25nuhRJEG1WL5+6Z6XMB/0G2zi1Syuo5HBMbRkEloW/Pdn7gQ3ZF1/7YBe8+LZXvOz+Rz9DginVEU9q/gDLVaHqcE1S+9r2bnvxyygaortnSQbMZjh/60ng6KvLYJ0jx9/+GnVOVWdpyaiFL8TY8cP7CDKdFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 34C0211F1213; Sat,  2 Mar 2024 08:50:33 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 3/4] selftests/bpf: Fix possible ksyms test failure with LTO kernel
Date: Sat,  2 Mar 2024 08:50:33 -0800
Message-ID: <20240302165033.1628421-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302165017.1627295-1-yonghong.song@linux.dev>
References: <20240302165017.1627295-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In my locally build clang LTO kernel (enabling CONFIG_LTO and
CONFIG_LTO_CLANG_THIN), ksyms test failed like:
  test_ksyms:PASS:kallsyms_fopen 0 nsec
  test_ksyms:FAIL:ksym_find symbol 'bpf_link_fops' not found
  #118     ksyms:FAIL

The reason is that 'bpf_link_fops' is renamed to
  bpf_link_fops.llvm.8325593422554671469
Due to cross-file inlining, the static variable 'bpf_link_fops'
in syscall.c is used by a function in another file. To avoid
potential duplicated names, the llvm added suffix '.llvm.<hash>'.

To fix the failure, we can skip this test with LTO kernel
if the symbol 'bpf_link_fops' is not found in kallsyms.

After this patch, with the same LTO kernel:
  #118     ksyms:SKIP

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/ksyms.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testi=
ng/selftests/bpf/prog_tests/ksyms.c
index e081f8bf3f17..cd81f190c5d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
@@ -21,7 +21,11 @@ void test_ksyms(void)
 		return;
 	}
 	if (err =3D=3D -ENOENT) {
-		ASSERT_TRUE(false, "ksym_find for bpf_link_fops");
+		/* bpf_link_fops might be renamed to bpf_link_fops.llvm.<hash> in LTO =
kernel. */
+		if (check_lto_kernel() =3D=3D 1)
+			test__skip();
+		else
+			ASSERT_TRUE(false, "ksym_find for bpf_link_fops");
 		return;
 	}
=20
--=20
2.43.0

