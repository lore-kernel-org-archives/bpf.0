Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6635F160
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798443; cv=none; b=ncaTjUMduHHkUqFny4jeIofXeRFfdLrzGhZ8OgVBtBNuiJRX49rKZhVj8mwEqxRh5Uy6e5uWc8n8JhhKQCxz1DJoqnpODqG/SWGHSy3pCACQbgbo2pO0JBKZpx5qbmvHzhhKK4DOdOKIe3vXus9QRhonLsnxEjLFqALxyOsVHiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798443; c=relaxed/simple;
	bh=XZD0nlvsMUfnro3BBZbrp0Lh5REKL5pw8q8MrkouDhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1ebDABpqDE/XnAgbPMz/+/BEB/L/eR0eSXaVUTYYO5oBle2xh0Mfq8ZPIgqX4MzSluMETjTWB1AB/JhStYDRRUgBSiLwOolfoF/0iMUuUm+np/AB78jU9ITm2hvBJHf3qq7Zi2j11Uhk4z1mVH8cZse4c9PaOj+YmrgtgNAlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZhMN6VU; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZhMN6VU"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7927261a3acso83210097b3.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 04:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798441; x=1773403241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3R/49ouSDYzhu3nFmbplFfPLaAdWGpJSnr/CaN8H/08=;
        b=kZhMN6VUh8SMNqGEcY/azb64zjXkuvuXFXkslHe9JoydTqofKsMluE4ZfH9TnGfDzi
         cs1UlCU13JVEWRwVjm8X7yVmQboSEkLPSyT3mcpvZmzWrborXTirMvON2zuoWyBuJgod
         1gMtH1pqtiEcJfIS/jNhT9DpiAnjkcwVESJvwBGYWlnrjOmDAumDWLGXWDLuVpvFgGQD
         fnD5XUZbFZRzppKPrYN5Hoid0TZXBmfSB7lYtjyb1nf4KZYodce7Sa8DzivMnFYgon3f
         0lG2dodpAp02twYbnfDqTWFGLsQtt62ZpUbWRWTn85q0dzzxqpAZ/NELavTlKZrunoF8
         P+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798441; x=1773403241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R/49ouSDYzhu3nFmbplFfPLaAdWGpJSnr/CaN8H/08=;
        b=Hcbi6cFfy0MMXThIoLJnLseskUZb6KbGLDjwNBb0bYf1QgXe7YqklMlacEJ3Zu61Nq
         Rx7jmjRn20QFvSNKqmMsbuLm8OYWCNvWJy2lsgUsQ8arnBkxSl4AC428x4xd138HsW6V
         GwlvIgEacXGMGyATEQ5A5oSLRt144vV0XmC3I31FpKW02de1r57Wso6avwaTxnHIRcSu
         MLNNDlHLTrM6IB0p39I9pkkodRLyijjP+WWD87ebIQQn39/qep5WomXot7/WLxP1VwA7
         YPimr/1VSkNzX1z4yAl8OnaGjOCjUHyhDVSFtHFsRfZwrfuH24EDsopwne2NDn31RhI0
         1LZg==
X-Gm-Message-State: AOJu0YyKgwcr1c39T1cTp7/S2KGT7StZAXS0+itF49l9mkfWQERif8LH
	fxuZCRT0RSzj/VdrVxgk5ujGqY4z0yl/L0cRaTd8RCMri35CHDodM0j+wjXN+iMJuF8IEA==
X-Gm-Gg: ATEYQzyTW8WxBF2DeiyKuQg3o+cxi1M4x6S52ToQ9VidLrjDC8Ww/S5gkFtHSgJK9XC
	G/yo4+yqGdzQhs0kOQW9sMfIrWRAp5VKQx7lTdho5nXUvGlLFeHzJTrOOLOAvlGooVL+a6TrSoS
	4Hq1pLwLtSnW73cENHU3GoSrXlxjLp85N3teeXVHM5SN3YlbwxFBceh2g/QXtDBEuMjYyQSP15q
	8D2RkyAK1WkAjDff7Hl1sJDXjqjAMYJEBGPKr2jz51TEZNULh6HVFfrDlSIwG3593D6Y/rYLihV
	itkfz+bv+gDPZPRk1DIIubse/95HPvnNURCCiVmzAXBs/ekayJDSXZ9pwmoTldDAvAuZU8LMvpD
	F8qj/JbJSV35ZfQHH8ZKsqKID2veen1QXqZ1pMW1Gt5KHC3WqjnjYIvmi6i/FJoDdzSTDwzDFkZ
	7nsj8j31l4BjzB8Gan6kobOz+Rhv1asVUJOgaKkcUtNPmwaiXaV+5N3ghTFXEAEQwjKvKHcbx5J
	lZmiPqDExDK+9xUpYu52KgTANUIeHZnvwpR
X-Received: by 2002:a05:690c:6891:b0:798:578c:2af1 with SMTP id 00721157ae682-798dd6da5a7mr17085347b3.29.1772798440681;
        Fri, 06 Mar 2026 04:00:40 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798dec8b55csm5601177b3.5.2026.03.06.04.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:00:40 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2] selftests/bpf: avoid jump seq limit in verif_scale_pyperf600
Date: Fri,  6 Mar 2026 20:00:24 +0800
Message-ID: <20260306120024.1032301-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pyperf600 is a verifier scale test. With newer LLVM, calling __on_event()
twice can push the generated program over the verifier jump sequence
complexity limit (8192), failing with:

  The sequence of 8193 jumps is too complex.

Let pyperf600 provide its own on_event() that calls __on_event() once, and
guard the shared wrapper accordingly. Other pyperf600 variants are
unaffected.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---

v2:
  - Drop runtime -E2BIG skip; instead tweak pyperf600 program source to avoid
    hitting the verifier jump sequence complexity limit.
  - verif_scale_pyperf600 now passes; other pyperf600 variants unchanged.

 tools/testing/selftests/bpf/progs/pyperf.h    | 4 +++-
 tools/testing/selftests/bpf/progs/pyperf600.c | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
index 86484f07e1d1..c02c49c52c77 100644
--- a/tools/testing/selftests/bpf/progs/pyperf.h
+++ b/tools/testing/selftests/bpf/progs/pyperf.h
@@ -343,8 +343,9 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
 	return 0;
 }
 
+#ifndef PYPERF_CUSTOM_ON_EVENT
 SEC("raw_tracepoint/kfree_skb")
-int on_event(struct bpf_raw_tracepoint_args* ctx)
+int on_event(struct bpf_raw_tracepoint_args *ctx)
 {
 	int ret = 0;
 	ret |= __on_event(ctx);
@@ -354,5 +355,6 @@ int on_event(struct bpf_raw_tracepoint_args* ctx)
 	ret |= __on_event(ctx);
 	return ret;
 }
+#endif
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/pyperf600.c b/tools/testing/selftests/bpf/progs/pyperf600.c
index ce1aa5189cc4..31e8a422d804 100644
--- a/tools/testing/selftests/bpf/progs/pyperf600.c
+++ b/tools/testing/selftests/bpf/progs/pyperf600.c
@@ -9,4 +9,11 @@
  * the loop will still execute 600 times.
  */
 #define UNROLL_COUNT 150
+#define PYPERF_CUSTOM_ON_EVENT
 #include "pyperf.h"
+
+SEC("raw_tracepoint/kfree_skb")
+int on_event(struct bpf_raw_tracepoint_args *ctx)
+{
+	return __on_event(ctx);
+}

base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
-- 
2.43.0

