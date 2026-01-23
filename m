Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392CA34F476
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147501; cv=none; b=C5pVBT1d+L4CWPHifVSrONWpaYe0pHvD3JpR/h65+7g1q/s7kgRdBuMZh2uLNYJOClEzQVfJR9K2urf4UkzCWyhYKyoMGaZYTGP1VJytVfwhuq1ru0bcWiHmwVBkKONVGoMd9U0wkg1z8xpfGlx0MeJwp0tvlvm60q8szA3O+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147501; c=relaxed/simple;
	bh=2Iwg3dvvNS5YrfokKTArdg63njkcnR3E5QcdBdOzszQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNinBMuOHARHKg+FRlKI7I808LZMLLo8MHRXZj/kSQoqAjMJyBtHan/vD9DHpzgmvPsVhMN9uBDDpGILNGrItIHk3s5dZrmnKbJUndhNeEYAs9ZNsbSUtJluGkm6nF6iBTEwMIjD1Oc9FsI0EwpCmbYDb5y2eP/dAlMbSSsbGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EE69819739C17; Thu, 22 Jan 2026 21:51:22 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Amery Hung <ameryhung@gmail.com>
Subject: [PATCH bpf-next v4 1/2] selftests/bpf: Fix task_local_data failure with 64K page
Date: Thu, 22 Jan 2026 21:51:22 -0800
Message-ID: <20260123055122.494352-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On arm64 systems with 64K pages, the selftest task_local_data has the fol=
lowing
failures:
  ...
  test_task_local_data_basic:PASS:tld_create_key 0 nsec
  test_task_local_data_basic:FAIL:tld_create_key unexpected tld_create_ke=
y: actual 0 !=3D expected -28
  ...
  test_task_local_data_basic_thread:PASS:run task_main 0 nsec
  test_task_local_data_basic_thread:FAIL:task_main retval unexpected erro=
r: 2 (errno 0)
  test_task_local_data_basic_thread:FAIL:tld_get_data value0 unexpected t=
ld_get_data value0: actual 0 !=3D expected 6268
  ...
  #447/1   task_local_data/task_local_data_basic:FAIL
  ...
  #447/2   task_local_data/task_local_data_race:FAIL
  #447     task_local_data:FAIL

When TLD_DYN_DATA_SIZE is 64K page size, for
  struct tld_meta_u {
       _Atomic __u8 cnt;
       __u16 size;
        struct tld_metadata metadata[];
  };
field 'cnt' would overflow. For example, for 4K page, 'cnt' will
be 4096/64 =3D 64. But for 64K page, 'cnt' will be 65536/64 =3D 1024
and 'cnt' is not enough for 1024. To accommodate 64K page,
'_Atomic __u8 cnt' becomes '_Atomic __u16 cnt'. A few other places
are adjusted accordingly.

In test_task_local_data.c, the value for TLD_DYN_DATA_SIZE is changed
from 4096 to (getpagesize() - 8) since the maximum buffer size for
TLD_DYN_DATA_SIZE is (getpagesize() - 8).

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/task_local_data.h      | 4 ++--
 tools/testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
 tools/testing/selftests/bpf/progs/task_local_data.bpf.h       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

Changelog:
 v1 -> v4:
   - v1: https://lore.kernel.org/bpf/20260120210930.2544950-1-yonghong.so=
ng@linux.dev/
   - Restore '__u16 size' with adjusted TLD_DYN_DATA_SIZE (smaller than g=
etpagesize())

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
index 2de38776a2d4..0f86b9275cf9 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -94,7 +94,7 @@ struct tld_metadata {
 };
=20
 struct tld_meta_u {
-	_Atomic __u8 cnt;
+	_Atomic __u16 cnt;
 	__u16 size;
 	struct tld_metadata metadata[];
 };
@@ -217,7 +217,7 @@ static int __tld_init_data_p(int map_fd)
 static tld_key_t __tld_create_key(const char *name, size_t size, bool dy=
n_data)
 {
 	int err, i, sz, off =3D 0;
-	__u8 cnt;
+	__u16 cnt;
=20
 	if (!TLD_READ_ONCE(tld_meta_p)) {
 		err =3D __tld_init_meta_p();
diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.=
c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
index 9fd6306b455c..9556ad3d986f 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -4,7 +4,7 @@
 #include <test_progs.h>
=20
 #define TLD_FREE_DATA_ON_THREAD_EXIT
-#define TLD_DYN_DATA_SIZE 4096
+#define TLD_DYN_DATA_SIZE (getpagesize() - 8)
 #include "task_local_data.h"
=20
 struct test_tld_struct {
diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/to=
ols/testing/selftests/bpf/progs/task_local_data.bpf.h
index 432fff2af844..fed53d63a7e5 100644
--- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
+++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
@@ -80,7 +80,7 @@ struct tld_metadata {
 };
=20
 struct tld_meta_u {
-	__u8 cnt;
+	__u16 cnt;
 	__u16 size;
 	struct tld_metadata metadata[TLD_MAX_DATA_CNT];
 };
--=20
2.47.3

