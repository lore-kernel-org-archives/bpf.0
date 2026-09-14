Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70567442389
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386644; cv=none; b=CM2c8sBF/2KGcXzXRG8M3EdB30g8tuM0C2F0FAdPfaTtDxdZrd9OgIsApxWM1mPOh9p5JgffoVx1th9GiF4z1i7uBPpUTYtIODNnXtV3ytOXuzS+81Gpwse1z//2lJyiISRnTZoEjgbSsvec5FbSgvLnqpgoMInnVtWLyeRXhsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386644; c=relaxed/simple;
	bh=ChNWu4SF6NGhwjGjf6K8AWy5RuCiogwQwkyEnV0Sbbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZHIuXtZrjVgHN6AIJQydqYZKH3iuk0i/rDFvtB3hPS96ljplmxQJSm3apgDUHVi6FyxerJjJxs94aMmtBxciU+M4QhL4EfkBHWsJHa57znDrQ9Jgiyrw0qlUFlmVb4+G5cUu3CMPgfmU0LwII8jkh3C0r70OLfaD14c8aIua5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIK/NQHS; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIK/NQHS"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-495c49f8eccso3489110b6e.3
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789386641; x=1789991441; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MaqTH9IlSFyz/AkXyftEm+wBLkaCkpRXZW0c+BfqTAY=;
        b=tIK/NQHSBAmP7RSxz+6cJVzVArk+IF9OaELzQI5MHOyrC1YPPp8EB0NKAKbho5v2lT
         ZsuSA1d3quKF0WJVlYrEGvchK0I4VIWWQyXqSl5gmAnjut+LBU8ZBtST3H+VYxAJtCDD
         tTi4kskmhoXjwQdQQQI4E9betsCkAoK+eOYT6hd12XulPhyk4qbGNil+1+Tjw/ATB8w8
         4ZCHrVhYmsXGdwrdKl9K+OIobSw2eMxbGEE21zG3a0KI2wRQVehBcvaAs5ZhjV0SWfe8
         W52CHr3skm2TkC54qerVPNQAHWJut70mNmWCQ2jZIrFOaOZKHnt6uQVEa4G8BSZnVfmr
         pQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789386641; x=1789991441;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MaqTH9IlSFyz/AkXyftEm+wBLkaCkpRXZW0c+BfqTAY=;
        b=NMjlWz1dFA2AXwx6vyd/UkKv9Q+iiTiPr4lQYNW/d6s4Zh9eHPaaC/QZNOWDAGvPVu
         TpoX+FfEjoh1YaWACgmvHtjBbnL7/vhXjqbLpolH6IXeQY0N5vkltqWyZFkMH/hijgto
         ZWUI9GOQmh3i5k3lqx4jOnssHLPuHKw15VAE6SY5uBQSDAbGZEQ72SMPDjiEEd16nvuQ
         w0mX82L7kUNb/OrxPbzHV0y6UCLecFxqJi19XsBGfPD9EWQxf3MlD+0gLura/OtAqKK7
         kdRjpnhqowu/hbZYGKucZJin93R/f84V1CYslC/9xlnp9zhUQTgo6b+5vcjYHTgIzCU/
         UkWA==
X-Gm-Message-State: AFuF++lZBgHjwpZNtRdV3RlxLGZhInBQrkHFJfWlRaki0S0OizHu2K0s
	oujgSzO0XvUpseX/HALecLdtGRgfNi/AAckCaWcnepVvaOV72wAReVj5Igk+LSlfBHY=
X-Gm-Gg: AYBFou1+3OipuaomgWoaaSlJIfnggl2agN6Ii549Nb/wn021qv5qPztBKAa7os2C0aP
	eKJ9tcGVxEfR5vjmUsdw9UxCGuF2pqINmh3GA1gsTT8hiUu9BTT6XCxJcHOm/Vl52Co6jjFLN/7
	Yw2UMFmB11sCj9EWqLcDopzshDR4/EmZbd5X9s/wiSOQuNS2hCxGMjuUV2g9SjZOcEqP5WLPZgJ
	A7dA5UcWuAKZtmlfUiN1oI3jT3p9OjvWLKjVE/Pm2NbV5/KBQWDVrdr9HVixI1RlXvuTP03OuGN
	inCqbZbOXuOoaKki5GVhSEEee0Jlv4+E9uNC+h4liJRXY0yPk41gpenTNbat58nNoEJ1KcvOLbl
	mgkHcbO3UmFHU1/AxDxGeXHnDOnwH8hU5JnnIGcLsnN97ezAJ9X2Z9a4H6M95ZG2msCWk7R8urn
	xh9FuZtT1AVl9lBSmblLvLm+2Pwoy/gENvO2D3oesZrQPTb4dnMJDhR/ZkcJyi537uCJVelPtan
	XU=
X-Received: by 2002:a05:6808:244c:b0:4b9:e65b:8c31 with SMTP id 5614622812f47-4c7b48b3bd7mr1603457b6e.31.1789386641298;
        Mon, 14 Sep 2026 04:50:41 -0700 (PDT)
Received: from [127.0.1.1] ([201.162.69.22])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c3314b17d0sm9904432b6e.8.2026.09.14.04.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:50:40 -0700 (PDT)
From: Luis Vieira <luisflavieira@gmail.com>
Date: Mon, 14 Sep 2026 08:50:31 -0300
Subject: [PATCH bpf] libbpf: Fix program log buffer size validation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-libbpf-log-buf-fix-v1-1-f592caffcc71@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIbfp2oC/x2MSwqAMAwFryJZG2j9oV5FXLSa1kCp0qII4t0NL
 ucxbx7IlJgyjMUDiS7OvEcBXRawbCZ6Ql6FoVJVpwZdY2BrD4dh92hPh45vbAbXqrpfjGlXkOO
 RSOY/OoHIML/vBwCA4vppAAAA
X-Change-ID: 20260913-libbpf-log-buf-fix-49f5038caa5d
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Luis Vieira <luisflavieira@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789386635; l=2747;
 i=luisflavieira@gmail.com; s=20260913; h=from:subject:message-id;
 bh=ChNWu4SF6NGhwjGjf6K8AWy5RuCiogwQwkyEnV0Sbbs=;
 b=+BXvKW5XIp+uDGQQdXyt3rRGzNHUx/tWoYxQaix3CUebltrheNoWY5mGbtM9eRw81unJKmOjJ
 ro5a4w4mBlcCM58XPDG+ywgA/kE9F486ggCw81a1k4FN90xIlRpn/Q8
X-Developer-Key: i=luisflavieira@gmail.com; a=ed25519;
 pk=98MeC/NdrC6ah7zYpPnkWiQIoyj62iUP/rNuV3esCW4=

bpf_program__set_log_buf() intends to reject log buffer sizes larger
than UINT_MAX.

However, the function checks the existing prog->log_size instead of
the incoming log_size argument. As a result, an oversized value can
be accepted.

Validate the supplied log_size instead.

Add a regression test that verifies that values larger than UINT_MAX
are rejected with -EINVAL on platforms where size_t can represent
such values.

Fixes: b3ce90795035 ("libbpf: Add per-program log buffer setter and getter")
Signed-off-by: Luis Vieira <luisflavieira@gmail.com>
---
 tools/lib/bpf/libbpf.c                           |  2 +-
 tools/testing/selftests/bpf/prog_tests/log_buf.c | 25 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b749c01742ee..e1fed7735614 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9955,7 +9955,7 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
 {
 	if (log_size && !log_buf)
 		return libbpf_err(-EINVAL);
-	if (prog->log_size > UINT_MAX)
+	if (log_size > UINT_MAX)
 		return libbpf_err(-EINVAL);
 	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
index d6f14a232002..31c842d27fb4 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -3,6 +3,8 @@
 
 #include <test_progs.h>
 #include <bpf/btf.h>
+#include <limits.h>
+#include <stdint.h>
 
 #include "test_log_buf.skel.h"
 #include "bpf_util.h"
@@ -267,6 +269,27 @@ static void bpf_btf_load_log_buf(void)
 	btf__free(btf);
 }
 
+static void prog_log_buf_size_limit(void)
+{
+#if SIZE_MAX > UINT_MAX
+	struct test_log_buf *skel;
+	char log_buf[1];
+	int err;
+
+	skel = test_log_buf__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = bpf_program__set_log_buf(skel->progs.good_prog, log_buf,
+				       (size_t)UINT_MAX + 1);
+	ASSERT_EQ(err, -EINVAL, "set_log_buf_too_big");
+
+	test_log_buf__destroy(skel);
+#else
+	test__skip();
+#endif
+}
+
 void test_log_buf(void)
 {
 	if (test__start_subtest("obj_load_log_buf"))
@@ -275,4 +298,6 @@ void test_log_buf(void)
 		bpf_prog_load_log_buf();
 	if (test__start_subtest("bpf_btf_load_log_buf"))
 		bpf_btf_load_log_buf();
+	if (test__start_subtest("prog_log_buf_size_limit"))
+		prog_log_buf_size_limit();
 }

---
base-commit: ee363e055895364039bf28348ff13c615afad4ba
change-id: 20260913-libbpf-log-buf-fix-49f5038caa5d

Best regards,
--  
Luis Vieira <luisflavieira@gmail.com>

