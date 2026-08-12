Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294D0372B3B
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573176; cv=none; b=Ebpd+1GkZVMVJ9ll9yrCJYupR8LRPUCgHQtKX3Ay9R9haNiSb6JHz2KhiBkNHk89Q8yeyMdWPkIaMqr5AyrSF/GlN8NyTnHqCqckovfvOE8vVCoa7LOt/QGbn+NLpxHJRh0G1otCoCkJWjpy3+kzmJ7ARx9Io/3e8yfKv4YKG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573176; c=relaxed/simple;
	bh=oC3oj89S5rz3VULZPDD6OGI8LYHJH+btcybMuzsJ/nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kv520IysPGr8HYELWb9cxOUN0033v/3+QHrLA/2nbiIVOxXnCx/3z4nwKQuOaIf/50BQi9NNQ+NPO77RmqXw4rgxY9hpM04OYQ/3BXRGuk1ddMt8o2oSWdYNWMjC1TpoFqXPWK8H4w40HKNyCcuJ6s4S1F4TszaWRyovGd1gee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXgaechn; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXgaechn"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so325685e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786573173; x=1787177973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cqNO7pWcTxS2NOlR8WGw0D5OtB349JOCD8RyTarEmd8=;
        b=dXgaechnup6UjEtH78gigjrEja4CBUyrbxPbQJxhFup8HWCvqH9ZkpZozJqidi21le
         uD1MCLlrPGE3+VMHkSdn3dt+Jc+L7xB1OptQS1Za7N2jHQzNBr3LIyIV6vY2QJbL1Nem
         DgtGyg0t3EfeWQoZyrZMJFavR/EdK6rVrfVdy9UlSROWXpw/i0ahwGMUo1JCzBAz8/21
         lhGPDFHfZwj9uEwYS9UY/s9izWhU3bNZsthC0US2QIhLqtise05R3MPvjh0XSub/7M7U
         5J+KjPE2cPD5Yf81iKpbAdjnMxXVJTchSfL++XbJ4B5q4wxAE5vzJLIBK3nwkJCqu9W/
         hoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573173; x=1787177973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cqNO7pWcTxS2NOlR8WGw0D5OtB349JOCD8RyTarEmd8=;
        b=GDFK3glU3Rp7GBmZxldNmUNMLCI4K19xqt+n9vr5O7V+bVzghxHcUeKhhXkFiLnVSw
         BtCo7TZBfk30pKZzDTFVufi4mUJBCVsyG7wk9o3BtlXKVtj8eLeXAnSe62hnN3uqHaDm
         PtcNQtu9Q2pLErsT0qh5IakK/v0MRZrvc9v2yHAhkhg/WqAPW6rUUnMdTWtWqIFBU0mf
         D9vlXoN9Cxs5A7GePR6DM3I2Rki6jYEPpQ0f/Tj9Qq8MJKx8roA7uQHMW5991Xn78xmV
         iHXtDBWiPtZUKFlzmOx9N/JhoiSonXJOXFsxETTKb6hEmfPMBFBonJKrIz1LrBwXh6Vb
         OX6Q==
X-Gm-Message-State: AOJu0YyMQBIqZXR/F6hB1sfQXjlYdbrycIJEAzQAGW9GYRK7OTh4XKyJ
	PjLLqs1jWTsKsGn4d0F4cVTj1O3qIKE7H2KMR51KTLAVM1SMHQ/aPOy6mtPsISOk
X-Gm-Gg: AR+sD117r3DxD8KEnlMjKIaJGav7P9YsSBLhqZRHBqKzgbXaOkSRPD0FsUm/l0Ha1yz
	KJolkg4X6GEJ9oEKtO3UbouKLTf0NlGvrT22Wl0Ymw5xps9sjtoMU+GBz+xX7WVe/xXbgRFgrcT
	nGgJm6zO8yqqSOtV5tXk8SFp9JBaEFJmTDFPCGhyVwkoh4kKEVk9TmoUmmhbN6tvNrdZ8VKOnH2
	gXloDMWpO0uE90xqIaEK781+PuPUw4q5rC2HuHz/e4t1RnGqxA1o/gCZUmwLoPH0GtpoXGjSuLo
	AS4IBPGp8/q27brBUQlpfLSGhC/OCsKgqs+Lhp6zLb/2WQbb6zpqGh1B21etDJyb/EREH3L1iMJ
	YS1jC03nlrngF+WpM5uQTjeX2hu749kBtkqFZal7RMmcjtnkysEvb8IPqMe0i6tG+qZrDlwG7XS
	QVWFihXBuVWDcO7Mj1GcLbYJHh4sRQawCCKr+1JSCUilGYDrcg6ynV0I0cn8akg5d7rB0lYhjY8
	a45koSdOxlsNCk9ni8t1IJPBitXE9aqIoQSvuIKzzCY9ZLO0tURkZzfbgOh4sOzVt4P1pyFwiNL
	Qn0Rt8nhyflh/V2IJV8pgm0mM30=
X-Received: by 2002:a05:600c:3105:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-4998215e3b4mr11427655e9.7.1786573173344;
        Wed, 12 Aug 2026 15:19:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b62894sm16117395e9.13.2026.08.12.15.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:19:32 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v8 5/6] selftests/bpf: Test stack depth stats without BTF subprog names
Date: Thu, 13 Aug 2026 00:19:22 +0200
Message-ID: <20260812221925.3358041-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812221925.3358041-1-memxor@gmail.com>
References: <20260812221925.3358041-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033; i=memxor@gmail.com; h=from:subject; bh=oC3oj89S5rz3VULZPDD6OGI8LYHJH+btcybMuzsJ/nQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavmwy/zbKF/dUm3HX26DumkLVIMy/x+M6hvTe6pyJXVD FkLFX52lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJL8hgZfsqyHNBwPBjnpDV9 0ioBHuu0PcmW92f+ETjVW7iVWeZqNiPDwn+836x1F/2zOvlGjc12amZRSP0jwXUHdvsrmc1oXPO UHQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Test the per-program insns_self, insns_total, and stack depth statistics
emitted when BTF function info does not provide subprogram names. Check that
the subprog 0 main record and static-subprogram records use <unknown>.

Make VERBOSE_ACCEPT request verifier statistics so the raw-insn test can
validate the output without a test-specific log level.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c  |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index a8ae03c57bba..bffb7360434c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1560,7 +1560,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 	opts.expected_attach_type = test->expected_attach_type;
 	if (expected_ret == VERBOSE_ACCEPT)
-		opts.log_level = 2;
+		opts.log_level = 2 | 4;
 	else if (verbose)
 		opts.log_level = verif_log_level | 4; /* force stats */
 	else
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 8cd626e04551..eb6e3baef412 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1091,7 +1091,17 @@
 	/* stack_main=32, stack_A=256, stack_B=64
 	 * and max(main+A, main+A+B) < 512
 	 */
-	.result = ACCEPT,
+	.result = VERBOSE_ACCEPT,
+	.errstr = "stack depth max 352\t"
+		  "subprog 0 (<unknown>) main insns_self \t"
+		  " insns_total \t"
+		  " stack 32\t"
+		  "subprog 1 (<unknown>) static insns_self \t"
+		  " insns_total \t"
+		  " stack 256\t"
+		  "subprog 2 (<unknown>) static insns_self \t"
+		  " insns_total \t"
+		  " stack 64",
 },
 {
 	"calls: stack depth check using three frames. test2",
-- 
2.53.0

