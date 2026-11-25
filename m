Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567766;
	b=nNuxaDoEfMvVWaKTVeUgJvA/EZo+zuv8I0i1vtthtf1RomxFaFft3wNxqgUnkBYGKf4a
	 YKtGql5M86zdgVJHNfYwgrJWEwipB6oJ/2jvRID5YIL3KxUONjl1NQePiA1XxLhd7iaWI
	 EKpAjv57OeLC6HYxxp9b5q8WtJShoFbF0Vw8CnejHxBO3EA78BL9rdMlGBiZuDDZLs1tq
	 CVDYm+U+6aZD0or371i4MQHnFUJCxwo3mpesKPz5ayXo6OjgpkumhO7wnWXAmJ1msG76W
	 qOmKS0O5rQRDrK70KtOZ0tlvMz/uEoSWMcBACMrbEYpsP+JJRuVnHzm1zwl+nVt+M9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=wZek5fBhh1JU0C6sLZIWGoXZ1M434xHxrJ06XU5jfz0=;
	b=JSwewQxSd1f9Qj8ZiZQY3FhAnZDXg3Vek7roN3JTn63JU0F27W8M9eSkmlu5BElvyF4V
	 j988j3VeHQ30zFIIpthXMHtGwEPHfBsb5oREoBgxO+z6sZun1kqIf6Olk2NI84I4RPDMC
	 FS7np1Pj2DusBUgg9mpy2WeIv3p9iUBrHAg518nEPwqxXzS++QZLxUV/VrZ1pNqdRlgGg
	 ngRZLtvFehQGn5Q9uCh/eHZY6h+upFJaEeRaNRhY7WS2WUcvNSfccvuNnOvaOVxmIfxdQ
	 KJaLKCxOr3hgwpuby1u9nkkNMOswCqQxJj8RBJQgmab7Si/z8KHqNERP+9LUa51z7aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tweek.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iGlrTGhz;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69338606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 00:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69338606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iGlrTGhz
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b40b011aa4so6159151a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 16:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567765; x=1796172565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wZek5fBhh1JU0C6sLZIWGoXZ1M434xHxrJ06XU5jfz0=;
        b=iGlrTGhz18zUUA51CVS2Z4Ro5/WzzlBTc+eJLzLQgZMgZNM4NCOE29WlOtR8B8FJVR
         MYXNmN0Ikb+JfRHx5NmzKHfX2NWLASNNOM72kLhE5TMqkxWbte1I7F1OgIIO++TNYgwJ
         DyemdYenLhk7mwrI4GEE6nzM2Vetn3i17qEDlphha094MORdmRMXF52x+tvIa9iLeQzT
         Aev/q6c9lyGK73eh/HZdJLdYRKe6rI1z7rm4XyT3Hh4mUBbIk+wprTRtBz7jKkHb78Z0
         EdgvL6pcEkScv4jZi+orXZL+rqJM6o7QEteMWg/m5sbaGFHVRocKfHm0a94Y7nv5sLXF
         Ak5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567765; x=1796172565;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZek5fBhh1JU0C6sLZIWGoXZ1M434xHxrJ06XU5jfz0=;
        b=G1rNu9Gof8A93UO8UccPrFa6CGLBCdOg5UoCms330UNC0NPk3a32RZT5U1yooF1CLC
         sklk8f3B5jzgIx5rynbTbg1+HbCrtIrkvL1MPF6pC2g5dbiSjcRt6xKGxhxodsfGcCGa
         CBC3u5YC54zZCqoZTkHyCXQyn1ksJikHbbSgKEkZWb8P62kPiqa+JEiP8PVw4V1xvrhd
         0qbeVK7xpaZ7HAP4gSQwHAHKgx16vYFiHgbrpHInClUaIrxOE0GZFZbnpmbmUUNYXHDD
         CSgvJ4QalQyaQ0y9jqOwxyX131cqtYc9y6CSMVFyG7rzpaZWJm/LMc2hR9JIYGAyXDvE
         lv0g==
X-Forwarded-Encrypted: i=1; AL+hErEFjadbeVYcnjtw+nTzo57AOnYesmOG81F3o9RP69PNa0QEJfzPbF/ZnzapdIHZl+Fc9r8=@vger.kernel.org
X-Gm-Message-State: APuU4Z90Br1uaOCd3biyRQQG8C+MM/K06tSTWXBCnm54WufdrVgJyvyY
	U4pPdhQDuV7uze9tpIjPzMLSNitp/VGnxLP/wNRWcsMtiGXhQIdwH0TIAJc73Sz8/JDtPOWWywQ
	Usg==
X-Received: from pjbqb5.prod.google.com ([2002:a17:90b:2805:b0:3b4:a73:5d7c])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f8c:b0:3b4:10c3:c1b6
 with SMTP id 98e67ed59e1d1-3b41c9286acmr15779393a91.25.1795567764334; Tue, 24
 Nov 2026 16:49:24 -0800 (PST)
Date: Wed, 25 Nov 2026 11:49:09 +1100
In-Reply-To: <20261125004911.3937193-1-tweek@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125004911.3937193-1-tweek@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125004911.3937193-2-tweek@google.com>
Subject: [PATCH bpf 1/3] selftests/bpf: Move verifier failure tests out of test_global_percpu_data
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Leon Hwang <leon.hwang@linux.dev>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Sid Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commit 4c9241bd731a ("selftests/bpf: Add tests to verify global percpu
data") added test_global_percpu_data.c to LSKELS_EXTRA. Later, commit
1ed2294b31fc ("selftests/bpf: Test verifier log for global percpu data")
added two verifier failure tests (verifier_strncmp and
verifier_snprintf), both marked as non-autoload (SEC("?kprobe")).

When bpftool generates light skeletons, non-autoload programs are
skipped during loading, causing the loader program to store subsequent
program FDs into incorrect skeleton struct fields (for example,
dump_percpu_data's FD was stored into verifier_strncmp's descriptor,
leaving dump_percpu_data.prog_fd unpopulated).

Move the two verifier failure tests to a dedicated test file,
test_global_percpu_data_failure.c, and run them via RUN_TESTS in
global_data_init.c. This leaves test_global_percpu_data.c with only
autoloaded programs, allowing its light skeleton to be generated cleanly
and preparing selftests for rejecting non-autoload programs in light
skeletons.

Fixes: 1ed2294b31fc ("selftests/bpf: Test verifier log for global percpu da=
ta")
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 .../bpf/prog_tests/global_data_init.c         |  3 +-
 .../bpf/progs/test_global_percpu_data.c       | 23 --------------
 .../progs/test_global_percpu_data_failure.c   | 30 +++++++++++++++++++
 3 files changed, 32 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_percpu_da=
ta_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/to=
ols/testing/selftests/bpf/prog_tests/global_data_init.c
index 7c539cbcf3a1..dbb7de534f7d 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -3,6 +3,7 @@
 #include "bpf/libbpf_internal.h"
 #include "test_global_percpu_data.skel.h"
 #include "test_global_percpu_data.lskel.h"
+#include "test_global_percpu_data_failure.skel.h"
=20
 void test_global_data_init(void)
 {
@@ -372,7 +373,7 @@ static void test_global_percpu_data_rdonly_direct_write=
(void)
=20
 static void test_global_percpu_data_verifier_log(void)
 {
-	RUN_TESTS(test_global_percpu_data);
+	RUN_TESTS(test_global_percpu_data_failure);
 }
=20
 static void test_global_percpu_data_iter(void)
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/=
tools/testing/selftests/bpf/progs/test_global_percpu_data.c
index 2765cd46e9af..bc748df4a6cc 100644
--- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
@@ -42,29 +42,6 @@ int update_percpu_data(void *ctx)
 	return 0;
 }
=20
-static const char fmt[] SEC(".percpu.fmt") =3D "data %d\n";
-
-SEC("?kprobe")
-__failure __msg("R{{[0-9]+}} points to percpu_array map which cannot be us=
ed as const string")
-int verifier_strncmp(void *ctx)
-{
-	return bpf_strncmp("test", 5, fmt);
-}
-
-SEC("?kprobe")
-__failure __msg("R{{[0-9]+}} points to percpu_array map which cannot be us=
ed as const string")
-int verifier_snprintf(void *ctx)
-{
-	u64 args[] =3D { data };
-	char buf[128];
-	int len;
-
-	len =3D bpf_snprintf(buf, sizeof(buf), fmt, args, sizeof(args));
-	if (len > 0)
-		bpf_printk("snprintf: %s\n", buf);
-	return 0;
-}
-
 volatile const __u32 num_cpus =3D 0;
 volatile const int num_off;
 volatile const int elem_sz;
diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data_fail=
ure.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data_failure.c
new file mode 100644
index 000000000000..3a823acb42d7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data_failure.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int data SEC(".percpu") =3D -1;
+static const char fmt[] SEC(".percpu.fmt") =3D "data %d\n";
+
+SEC("?kprobe")
+__failure __msg("R{{[0-9]+}} points to percpu_array map which cannot be us=
ed as const string")
+int verifier_strncmp(void *ctx)
+{
+	return bpf_strncmp("test", 5, fmt);
+}
+
+SEC("?kprobe")
+__failure __msg("R{{[0-9]+}} points to percpu_array map which cannot be us=
ed as const string")
+int verifier_snprintf(void *ctx)
+{
+	u64 args[] =3D { data };
+	char buf[128];
+	int len;
+
+	len =3D bpf_snprintf(buf, sizeof(buf), fmt, args, sizeof(args));
+	if (len > 0)
+		bpf_printk("snprintf: %s\n", buf);
+	return 0;
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.56.1.831.g720f3f5937-goog

