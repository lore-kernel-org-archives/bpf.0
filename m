Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44C344D97
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099198; cv=none; b=jfRlMmVuewubtKLZ+E6HFSdXtA0hlpZzS9+ZRZThNblCJXo20UzW+tgBh8xhrDmVLMJra/YyVx3v3IOKPbCBIy457eVpAXTY48V63vncEYLqBjfVZ4R+BwAKsZR+KrrURAEvsorIpxVfBlCKtM55k/sZ8lXn37PtqhDFTum6YjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099198; c=relaxed/simple;
	bh=VJHKI+Xj3IbcXn6XRt0r/yWZHvaz5xm4JkRlDy2hZUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvSsLuBjdYk9a/3vGLaqqu64ytfy10GZSCJB4sCVWywgRdmP4Sn7iqxfV+QOEAZtIVTyn9DyRR6Y5FQXFo+hZYb42i8z4NsQa6GKVFugwuCqHn0jwEs4aBUJZquN0u5RVrgB/Pu8AwFx/+ATY/i+swrItkKzQW9kLO+E29laaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2B139196A190F; Thu, 22 Jan 2026 08:26:16 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Amery Hung <ameryhung@gmail.com>
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Fix task_local_data failure with 64K page
Date: Thu, 22 Jan 2026 08:26:16 -0800
Message-ID: <20260122162616.3578898-1-yonghong.song@linux.dev>
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
fields 'cnt' and 'size' would overflow. For example,
for 4K page, 'cnt' will be 4096/64 =3D 64. But for 64K page,
'cnt' will be 65536/64 =3D 1024 and 'cnt' is not enough for 1024.
For field 'size', it is okay for value 4K, but it is not enough
for 64K as maximum 'size' value is '64K - 1'.

To accommodate 64K page, '_Atomic __u8 cnt' becomes '_Atomic __u16 cnt'
and '__u16 size' becomes '__u32 size'. A few other places are adjusted
accordingly.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/task_local_data.h    | 6 +++---
 .../testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
 tools/testing/selftests/bpf/progs/task_local_data.bpf.h     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/t=
ools/testing/selftests/bpf/prog_tests/task_local_data.h
index 2de38776a2d4..4c38f9a7bc90 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -94,8 +94,8 @@ struct tld_metadata {
 };
=20
 struct tld_meta_u {
-	_Atomic __u8 cnt;
-	__u16 size;
+	_Atomic __u16 cnt;
+	__u32 size;
 	struct tld_metadata metadata[];
 };
=20
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
index 9fd6306b455c..cc4d49222d9d 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
@@ -4,7 +4,7 @@
 #include <test_progs.h>
=20
 #define TLD_FREE_DATA_ON_THREAD_EXIT
-#define TLD_DYN_DATA_SIZE 4096
+#define TLD_DYN_DATA_SIZE getpagesize()
 #include "task_local_data.h"
=20
 struct test_tld_struct {
diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/to=
ols/testing/selftests/bpf/progs/task_local_data.bpf.h
index 432fff2af844..e13f239b46b0 100644
--- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
+++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
@@ -80,8 +80,8 @@ struct tld_metadata {
 };
=20
 struct tld_meta_u {
-	__u8 cnt;
-	__u16 size;
+	__u16 cnt;
+	__u32 size;
 	struct tld_metadata metadata[TLD_MAX_DATA_CNT];
 };
=20
--=20
2.47.3

