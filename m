Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD340963C
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540484; cv=none; b=B4qzD0YiP30FKoe/HgK0zHaywo/S3qQXXyEfXG5UzXgqOsqH1lz8X17lmnxyaaB5ZEPi/vdn9M8eIgC+vBfDWD/3YQy346ewM17TTOgZXtdjaT+BQzCPK9bXpqCpK6YBaBHIyAhgoi3qUB09K+PyDLs0/9ubwWNBXQzXmpDT/2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540484; c=relaxed/simple;
	bh=FZ3Rm1L2sxFv+p5nMCgNwjOMBM337Pur5jeEP0gLWcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTs23fjqOfGeCCrUY+jnvkFzW+t79DdoHuObzKEm18shX3N+8L8tkLXM3LmND8r+J1O6JERIMobCXY70nQk91FKwttzd1ZdWT8rrJwh0YZqPOqkNsMOEe+ws8k6pF4Qmuk8cXcbqo5n5SqIp3X5aqS/X69WPMjjC9E0sfaFuDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E123yuzL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E123yuzL"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4922244f7c7so19106305e9.0
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540481; x=1782145281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MSZ3+T5ElWkBkfWdGNPZH9803LrhdIJP6pu/OmHvhc=;
        b=E123yuzL2xDSwMe7ytDtZ0KyBWBmnR27c1ShbIgDbesUxilYGFfH0HhPmfFYWW95Mv
         qDHl6hzX0CQ9Eu+AlONEVJA4IoMaRdka6SECy2DGlduUwI9fdX0KZqx1ESTOmF8X5jl9
         /aNn9L/yjm9pdNBHVxGn25xsKCfNvCX8lOB+NO00+BgNJqxtf2L6kus6Axdkc8m26Eof
         0A3Fej2+55GLwPs02QGw6maYFa/fOuDwMGEVwbIhik75n1HU7tanZNzfR7cEDWkz1EeR
         nYT2LapFa+s6VWxcLLVVTCC2Z1AeFrjIYsPKjkh2Psoy5AH6bnvQQbUARK4ccoVHjpj/
         PoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540481; x=1782145281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/MSZ3+T5ElWkBkfWdGNPZH9803LrhdIJP6pu/OmHvhc=;
        b=pUMGCaX2BhKnY8wVWU6ZmkKnv3n2DPa5HA2BgVKPRM3jb7BRbfobc/56nUUXL1no5T
         ABYpi4cUSiP5ktOxbHKZWrwRupIWbwOCKQaTPeFo1S0cwKmwMQfIadbxASNjIvuYj+Fp
         2KJ1PcjRZzID5QE05zxPP8Duxx+41VjtVcNOU2tnzy4gzv3toLGIpBM5H98xLMq5/TAi
         PhGHVlR8GFaN16aTqa6KpWS0TSss2WXPCW/l1aIntccbiHyDWGbtuX49SgEBnolBfgIZ
         NcRH1Q3RvEtnY3zNl42EJfVQ9dREc+fE4/KSfgNU4sUxuD6YHQ9Zo7ZxiHHHHHtKSBsL
         jQsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RoLlUCs7uBGgHXTn6N296uIb45s5cwevmVyEgIbiSfCg2kTBTb0q6m96omq3xAIYmFjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRh/zG51rIzYSeVAxB83kzarSbq+gkgyJ45J65uUFcxeQ2Qrm/
	5TlRCqbkqJuMHJgjjPUnL8w6t6ieV0YSOcX5YW2arD7K3IV6qb7vTS6lms7GUI4j
X-Gm-Gg: Acq92OG7LxxUtCtHYQhW/t3HUMVbHW4T+PLByzAIi9dXeOLSdZpZyeSvT5y08ShH3of
	Re6l5u6K5URrrhhMEOrXI/pPD9FM7wG2jv+JLfvImRpTuZ/3PgTALM1amyoiBzTe8sNOfuJpfgd
	xfzEERVg1YvD7PtO50jvtZksuAQkeNEU/gHR2wa3nuaQl6KBXVL2omUZmRkB4dGSGzIgydrXDWj
	EFREcB2oLGGHhOKEPrnPmknuUPu9Stg9abtzHEO01s//YLA+FOMpyxmNjPUcjeLg0NRRvb16Riz
	Wu0WGvlh6TSTLcKLxaoFl4FJToER9h+3Bz389H0BHYJIDdPckBOTE4z7+7pSjLsDlgw9Hnb09X7
	xyMP1TWlGeDJPd92WXfAyq9+DvXgcN64+mHeXGN6XMpoZo0g7nQN4tF9g+nZTvWceUm7OerKlVl
	ukPSXsT05QoGD+/LQfH3C7Gb6CR06yMCc+haZPH6ms9FFTBrTuzfV6a7/OPtLq8x/gq0OpmMdcg
	A==
X-Received: by 2002:a05:600c:34c9:b0:492:1e50:978d with SMTP id 5b1f17b1804b1-492200838bemr156449195e9.16.1781540481123;
        Mon, 15 Jun 2026 09:21:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:4b00:f03c:ba00:3081:348a:50c4:2d80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922f9cd140sm4320745e9.0.2026.06.15.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 09:21:20 -0700 (PDT)
From: Jamie Hill-Daniel <clubby789@gmail.com>
X-Google-Original-From: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Date: Mon, 15 Jun 2026 17:20:23 +0100
Subject: [PATCH v2 3/3] selftest: seccomp: Adjust tests for using both
 STRICT and FILTER
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-seccomp-combined-v2-3-41687a943ae0@hill-daniel.co.uk>
References: <20260615-seccomp-combined-v2-0-41687a943ae0@hill-daniel.co.uk>
In-Reply-To: <20260615-seccomp-combined-v2-0-41687a943ae0@hill-daniel.co.uk>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, will@willsroot.io, 
 Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781540478; l=2807;
 i=jamie@hill-daniel.co.uk; s=20260302; h=from:subject:message-id;
 bh=FZ3Rm1L2sxFv+p5nMCgNwjOMBM337Pur5jeEP0gLWcc=;
 b=EcYhAPEc1SwuibuBgBnMloDSxMdw/B05YFqXBNOL9JWEPbPCWyuZ1IgPoIda3LXNSV2SPbjMV
 OaoJehnJCw3C/bdBg112UXgZ+Y+RuJ3LiHvPDnOMC4X5PFTfNAi33bC
X-Developer-Key: i=jamie@hill-daniel.co.uk; a=ed25519;
 pk=ovqCXSlFUjrT82WuRtIuXB13U5n1yfxM6o0M5O5J2tA=

Update tests to reflect that applying STRICT after FILTER is now possible.

Signed-off-by: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 68 ++++++++++++---------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..f3b5e19b53a1 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -516,7 +516,7 @@ TEST(filter_chain_limits)
 	}
 }
 
-TEST(mode_filter_cannot_move_to_strict)
+TEST(mode_strict_upgrade)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
@@ -534,8 +534,34 @@ TEST(mode_filter_cannot_move_to_strict)
 	ASSERT_EQ(0, ret);
 
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, NULL, 0, 0);
-	EXPECT_EQ(-1, ret);
-	EXPECT_EQ(EINVAL, errno);
+	ASSERT_EQ(0, ret);
+	syscall(__NR_exit, 0);
+}
+
+TEST_SIGNAL(mode_strict_upgrade_violation, SIGKILL)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, NULL, 0, 0);
+	ASSERT_EQ(0, ret);
+
+	syscall(__NR_getpid);
+	EXPECT_FALSE(true) {
+		TH_LOG("Unreachable!");
+	}
 }
 
 
@@ -2370,42 +2396,6 @@ TEST(seccomp_syscall)
 	}
 }
 
-TEST(seccomp_syscall_mode_lock)
-{
-	struct sock_filter filter[] = {
-		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
-	};
-	struct sock_fprog prog = {
-		.len = (unsigned short)ARRAY_SIZE(filter),
-		.filter = filter,
-	};
-	long ret;
-
-	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, NULL, 0, 0);
-	ASSERT_EQ(0, ret) {
-		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
-	}
-
-	ret = seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog);
-	ASSERT_NE(ENOSYS, errno) {
-		TH_LOG("Kernel does not support seccomp syscall!");
-	}
-	EXPECT_EQ(0, ret) {
-		TH_LOG("Could not install filter!");
-	}
-
-	/* Make sure neither entry point will switch to strict. */
-	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, 0, 0, 0);
-	EXPECT_EQ(EINVAL, errno) {
-		TH_LOG("Switched to mode strict!");
-	}
-
-	ret = seccomp(SECCOMP_SET_MODE_STRICT, 0, NULL);
-	EXPECT_EQ(EINVAL, errno) {
-		TH_LOG("Switched to mode strict!");
-	}
-}
-
 /*
  * Test detection of known and unknown filter flags. Userspace needs to be able
  * to check if a filter flag is supported by the current kernel and a good way

-- 
2.54.0

