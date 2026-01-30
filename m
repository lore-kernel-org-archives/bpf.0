Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB3D352C3F
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764377; cv=none; b=Akb/b2fVYx1QIhQndDkONOwVclxzj1/oI1luLLAZrAZht8wGdSEMWNNDyYUXvXFQ+pUCll6a5hizcsIrImeWoyENnsF+mcreQrfvIoDSRSrAVGT9riQycMKzusWEd4RVzY4m6WXlDH0uZNlWqW6taJSzo9ei16hGZSuSsr0k5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764377; c=relaxed/simple;
	bh=tVSU1w5x5sqFlUfPefz5QPNvQ7ShmBvFI0HEu15jk9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcA1Wsymdj6+M266FQ/+TUtQClCy4Ls8iaXTGMheWycoC0wATw31epy6wXuS43kxg/Jj7iZiZRGHE9ieASQbMzhiu3RivZK2eaFwCt4FJqK0hpD8mSxoGbLkWBmKlrJClFz31gvFdiIF7mss+suSl4M2F8ww5h+X5Hjrn0Tgy3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHkYlsOJ; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHkYlsOJ"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-649278a69c5so2015276d50.3
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 01:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769764375; x=1770369175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BqsnWikU7Lohq8AD8p2s7XQz/GMEbrveKNhDBDZTgGs=;
        b=hHkYlsOJkVN2yOPWTIzxlQSqBnib6rCkTSb9hSkp7dQ9iaqChv44lPVraJsUrvh439
         WsIHIGSIjVBtrjwHolr4GnjmP9mqOsB3s2mW7rYa/i6u4cBRaYeDMHFk+UabTcL13sbN
         Y1sm4628cS93WkafOwCiZr0s5z7+3JY2XAaSG3gx6Nwm/Fwc4t1i6MmEbyMdtTkuhHvn
         3EOyAeQlxkZsqDAfCMKwpeaiv5zybwtZ+o6OUtl6pQdDK7ntX+frTfv4KaorL+fAFRso
         TW/fla1ecuWSG15jCp/H/af7DdoGuCaOIr+mJZqf7kjWM6uC7II28H++6R/gXfLKeyzo
         zKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769764375; x=1770369175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqsnWikU7Lohq8AD8p2s7XQz/GMEbrveKNhDBDZTgGs=;
        b=YSvsu7D/ICwWiVEc74EZcb5GpfsaqcLiLeZTsE87+952Llpk5F1TzXLLXtZjzBdX7S
         9Qh4Nbjm2YH8LvOvst7byOcpJ8wDvVkhmiSsjT2xtnGJ4WMJR1UjW7CX//PXLqqTe7DJ
         wEgflbQd39m+yWIM5XO+Aerm+xERw9CCNo9UWS7sDldbPqC2MulGJs5HlqJ4wuJ146eo
         nXv7VcBrjvv4yD3ms/iDgUssvtu4cgLegSvRJveid0Lqj8P1Sly1NPvYUrdE7FwrrZT4
         sEjq7XVn6I6BWDvw8Xiw+RJpkMOOXpliR6QLG5QtdEhHiIcbkZmg9h6amBYbcuBkZ96U
         qnng==
X-Forwarded-Encrypted: i=1; AJvYcCW3MwiAlbtS1/slQYi+ZxcKYDkJsn2CtacUv4HebhjZEnuhF53YucJHJUSB3Y4moPKzIHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIHL95caILeVEPqIQ2gx+vtOqTJLVa37hvxQOGdEm1pNYX+xF
	+MQ41WfzL/xUbPswzyFWjKlPAzGG61wKgSW8tkDB03poFSWP5anGrh7j
X-Gm-Gg: AZuq6aLsQ5HkHnNR+y6ySRUsirsTeZArqoT4fGGCrx3f1Ort29+ZKyaRF3i+D2aYvJL
	RCBafGrtB5tI0zWYQNmxZxuvO3B11kp2BxJOWIaDUwvM/maAOQ0Ub+VV3YTLJQW1OJFebB1TriM
	DK4iZG0lUJDzGZ4cgLgRiRVbdgi8RCQ5hfEHX5nvR/jQ6XJMmZloRAen480hyX7BWIAnlZ3BCbr
	y3OK/Nr7933jh7nBe1Qrz7Or61AVKM6sJXB6vpqLdX3+D1ONaTBtXFoIa1UAwTuLySHuAxZXgBg
	YuA2IALJTNY0CRlRRuzW+S74Eo3pHSphCgA86mE+Tq592hVwoYTJMycEq/cHZ7L5eeRh2CyS8Wh
	KRzNzHYytv1mVkMUpNbY+WqygV4sxPnlHFsZ3fe2ytsdh84/VYkuSl84RRQr4HrsTm8fDGbeTOE
	WXj2kYgmyKxDeacI3m0yfakz0PSgI/PO+EtLs8Xf9/a8B+GslZsIrmgeysAW9KvYOz2AO5xSsC+
	6kyZb1Be7qa+Ffa3BOT3SCiyiFJPlJ4li5/LaetDXXfJZc=
X-Received: by 2002:a05:690e:1688:b0:644:6ad4:fdfd with SMTP id 956f58d0204a3-649a84ee166mr1735838d50.71.1769764374801;
        Fri, 30 Jan 2026 01:12:54 -0800 (PST)
Received: from u2404-VMware-Virtual-Platform.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64996063f90sm3436470d50.2.2026.01.30.01.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 01:12:54 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: andrii@kernel.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] selftests/bpf: skip deny_namespace when bpf LSM is not enabled
Date: Fri, 30 Jan 2026 17:12:45 +0800
Message-ID: <20260130091245.3824029-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

deny_namespace/userns_create_bpf relies on BPF LSM being active in the LSM
chain. When /sys/kernel/security/lsm does not contain "bpf" (e.g. virtme-ng
default), this test can't validate the expected EPERM behavior. Reporting
FAIL in that case is misleading noise for CI.

Detect missing bpf in the active LSM list and skip the test with a short
hint to boot with lsm=...,bpf.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/deny_namespace.c | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/deny_namespace.c b/tools/testing/selftests/bpf/prog_tests/deny_namespace.c
index 1bc6241b755b..5fb31912dd98 100644
--- a/tools/testing/selftests/bpf/prog_tests/deny_namespace.c
+++ b/tools/testing/selftests/bpf/prog_tests/deny_namespace.c
@@ -5,6 +5,7 @@
 #include <sched.h>
 #include "cap_helpers.h"
 #include <stdio.h>
+#include <string.h>
 
 static int wait_for_pid(pid_t pid)
 {
@@ -46,6 +47,36 @@ static int create_user_ns(void)
 	return wait_for_pid(pid);
 }
 
+static bool bpf_lsm_enabled(void)
+{
+	FILE *f;
+	char buf[512];
+	bool enabled = false;
+
+	f = fopen("/sys/kernel/security/lsm", "r");
+	if (!f)
+		return false;
+
+	if (!fgets(buf, sizeof(buf), f)) {
+		fclose(f);
+		return false;
+	}
+	fclose(f);
+
+	buf[strcspn(buf, "\n")] = '\0';
+
+	for (char *saveptr = NULL, *tok = strtok_r(buf, ",", &saveptr);
+		tok;
+		tok = strtok_r(NULL, ",", &saveptr)) {
+		if (!strcmp(tok, "bpf")) {
+			enabled = true;
+			break;
+		}
+	}
+
+	return enabled;
+}
+
 static void test_userns_create_bpf(void)
 {
 	__u32 cap_mask = 1ULL << CAP_SYS_ADMIN;
@@ -88,6 +119,13 @@ void test_deny_namespace(void)
 	if (!ASSERT_OK_PTR(skel, "skel load"))
 		goto close_prog;
 
+	if (!bpf_lsm_enabled()) {
+		printf("%s:SKIP:bpf LSM not enabled (boot with lsm=...,bpf)\n",
+		       __func__);
+		test__skip();
+		goto close_prog;
+	}
+
 	err = test_deny_namespace__attach(skel);
 	if (!ASSERT_OK(err, "attach"))
 		goto close_prog;
-- 
2.43.0

