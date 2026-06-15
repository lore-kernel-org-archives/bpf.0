Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE13BF680
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509181; cv=none; b=ZyCJOtrGUkJc9QN5MhCflGfLHmNgv2sm+rdeCI1DED2Xssfm8v4UctflE070XQo2UHHau/rEjsallcmO17c65WJRL4nzDzzNP18OvfPwikCFf1DJMJG/a4oH04eDaxWFYGuoJATuyh1N/mZu4Zm9O1pd1JnDfchFTJd6mQ3l0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509181; c=relaxed/simple;
	bh=gLE8CCQ5SH12vR+rRgkoSJvrMBzBUKCuuw23IvWdWz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmI14fgeBZ2tb5Fd15BO+PchaN+yFu48ZFwDsBv0GU3kFoT3Ulh+wANfqsL3hZPya3DYtqUl2M/T2LhqSIa7w9hDXyh5xi8VQxgbyvBAfnnxWmI30YATQpTu9M8DHsV81w6AjRA6AV4kSnqFU3o0Ahy7Z8WVfMYULlEpBb+eaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HylVFj8o; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HylVFj8o"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso16964405ad.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781509177; x=1782113977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbxyv2uuWx2uMg89JQUtXul+SksXRCRyTkytnWrdbbs=;
        b=HylVFj8olbHUfUyxSEIEg9YPMet/+ntPQWFLo9hdVoorB+YhdS9hNFUJIUSHR8Ib2V
         kG9bsprvYkkKY6qwgnqt5u4IuHTRKn70Z/g0Np2yOhdvUef/CQSk5lhBVmqiDMwJdMBM
         JG3WSM54Viep3VFRJSCHEt69AvkI1YBF4TdtPMeHis8arqH6DqAREGPgwYUquiDv4zIk
         Khe3m0LETBwReGBkHaautnRGSndbR1l60gcMMlcf0Xol1oMEVGUqCvCi+0dp4t7q7d9k
         +KCxIeQ7JJWpIguW2j9kw+DcQEM9H1EvncKke5yJc2NaPqO2X8RJ416LHijdISkFg/gz
         wn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781509177; x=1782113977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbxyv2uuWx2uMg89JQUtXul+SksXRCRyTkytnWrdbbs=;
        b=DnoyBHjIX/3w46nT//hjHQZ3Uydxi0yhHSeiQqWjHmVaCB6a7uxYQESW6Zu+cZzDRC
         /PSosLbVM3oEdCwC7mHm2zrk+uIfNAj/G2ZmiD9eAaBmYkWf6/z1rWN35BaetQGP/PAS
         eH65cnHpN+P1cV9iK6BsRF//CGDugoZAMmOqfo7aDLz5VRCb6pebD7KKAojQRqi4ijXV
         6hdVNkl11ZrSrW80Phd5aH/kyOUucJAHwVIS52Hxw0JWQbSLocYM+3iHnNZzWZUBDIfU
         q9p60uC+e7YUsH4NZFSKg/0TwHzaF9oGEOiSbYe10kXbevEwUWqIdoiq8pvBRVQ9KlSD
         7Ydg==
X-Gm-Message-State: AOJu0YxgrhChjWByqGv+iTKa3rrOsAlhv7bDPXRElAxQaYxA2QG+Y8sC
	IHEN1rklWlBE33hBX3BRdsO2YvyDXuCAdl7gQBKRan/4e5JbGNquUnUuJvd8UjeQ84Y=
X-Gm-Gg: Acq92OFoAzWTNIj9BItJAqV08f8W4L6TJvcRA9u5EAq2x5LBVya8YbwVFw/ticJeSEZ
	iO4f56VKAX7FJapWApcRtLNa8RlX5oXNCZ2V26hoAuHT2W8yagATD+F5B+q1IL+h+2svLk670EE
	F7jJluE0G9Iy1NsmWmxQool2xjhdZ+K/2x874FkncvY5z0rdAKt1rpywEZD0qZPeCZrXMVYWJwk
	TOE0A3mCjE+S0ZCpTvABwz5Sr4dnau9xqrWl8lX0X0cgdStntGPHS7mBmYxUCr+2Jd7eaumA4VK
	CNmW8r7jAVtHzP2ZCvfwQEE8ue5DsMp6By+m5wy8gspuGOXlOS2FlL7RjC7LAoL2Xvp8TS+AV+Q
	kZaW3t1ZnfLqd+yb8iED9OMP/PcqNrIloAM6Ray2zRpFaAouxO5bNXMt3JKDyQ0e82f3jXnEbF0
	MFPtwr/aTHAgt6ZTVcxC9A9MvdQvz/2JPDqA/MTliVTKlZMNsbTEZ1H1oX90TFey4=
X-Received: by 2002:a17:903:1a30:b0:2c6:7479:644d with SMTP id d9443c01a7336-2c674796a84mr71837965ad.5.1781509176848;
        Mon, 15 Jun 2026 00:39:36 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::209f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43307a259sm91271345ad.68.2026.06.15.00.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:39:36 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Cover partial copy of non-linear skb test_run output
Date: Mon, 15 Jun 2026 15:38:56 +0800
Message-ID: <20260615073856.152479-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for BPF_PROG_TEST_RUN with a non-linear skb and a short
data_out buffer.

The test verifies that test_run returns -ENOSPC, reports the full packet
length through data_size_out, and copies the packet prefix into data_out.
The test uses a 100-byte data_out buffer with a 64-byte linear head, so the
expected output spans both the skb head and the first fragment.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/skb_load_bytes.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c b/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
index d7f83c0a40a5..134be0ea8ed7 100644
--- a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
+++ b/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
@@ -3,6 +3,39 @@
 #include <network_helpers.h>
 #include "skb_load_bytes.skel.h"
 
+#define NONLINEAR_PKT_LEN 9000
+#define NONLINEAR_HEAD_LEN 64
+#define SHORT_OUT_LEN 100
+
+static void test_nonlinear_data_out_partial(int prog_fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, tattr);
+	__u8 pkt[NONLINEAR_PKT_LEN];
+	__u8 out[SHORT_OUT_LEN];
+	struct __sk_buff skb = {};
+	int err, i;
+
+	for (i = 0; i < sizeof(pkt); i++)
+		pkt[i] = i & 0xff;
+
+	memset(out, 0xa5, sizeof(out));
+
+	skb.data_end = NONLINEAR_HEAD_LEN;
+
+	tattr.data_in = pkt;
+	tattr.data_size_in = sizeof(pkt);
+	tattr.data_out = out;
+	tattr.data_size_out = sizeof(out);
+	tattr.ctx_in = &skb;
+	tattr.ctx_size_in = sizeof(skb);
+
+	err = bpf_prog_test_run_opts(prog_fd, &tattr);
+
+	ASSERT_EQ(err, -ENOSPC, "nonlinear_partial_err");
+	ASSERT_EQ(tattr.data_size_out, sizeof(pkt), "nonlinear_partial_data_size_out");
+	ASSERT_OK(memcmp(out, pkt, sizeof(out)), "nonlinear_partial_data_out");
+}
+
 void test_skb_load_bytes(void)
 {
 	struct skb_load_bytes *skel;
@@ -40,6 +73,8 @@ void test_skb_load_bytes(void)
 	if (!ASSERT_EQ(test_result, 0, "offset 10"))
 		goto out;
 
+	test_nonlinear_data_out_partial(prog_fd);
+
 out:
 	skb_load_bytes__destroy(skel);
 }
-- 
2.43.0

