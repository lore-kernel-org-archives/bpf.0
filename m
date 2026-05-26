Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D5379C3E
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810137; cv=none; b=uElIXtCUJmAhG87fGS3TCu3D/Jk1BxVD1TccKQ53tlBA453v0b90qP5BCZ3NBTy25GvF0x8HaOzOQ4EEFq7ZS2tTkBmMhfFidsRVol2UbSl7oLxgKvOR9kEb6lmmbnQ4/O5yby/0raI5+sKK0H+xNXItK7cHsOiH+oF38qw5UAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810137; c=relaxed/simple;
	bh=IhTA4SRq4kxztkMEQE6gGj3QktcRDsLFW6PL05IOesQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqpe6IrqRtDGR+rcIMOhn3GfMQFStmRmHoAF+6vZZRb4MqQMNxc4Qo6Pfcf2qXBX4+UcYiybUDezDx/+lWzNJKYod6W+fiYglIvArhxpau6LLI2TkSIyoJ2kgggiJQT4IZ/cyz4OQXtpWxcdv+isOFudMGq3NnYyIJTOSMH9JgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSTZqg20; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSTZqg20"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so44246785e9.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779810132; x=1780414932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uveo2Hi703wEVJgO91J6eDaVgmAFc18fPRGQe9B+SZ0=;
        b=pSTZqg20NWlXphprNQzkCeQw/PNVKbqR7fSjDB0Dnqdf83w6k0hikrdDE1CsAtj6R0
         RmJz1Pl5sKrbjq1Ypuxu4GCzUr1ZBGRgxYw3ZRjqvE8GxuWmtp0WA/WYKFLURj7FAQ4b
         wJrCZm/dG6EfNri14ATkft16KL9HTdWBsY0hmWyAsOgcdu2IjMzYcuahp9NmcTWoI9yc
         A1c0EE8mdBNRnUlV1Jol3YTpTrPysK0v52JIA3QAzpNvU4I+JGfSMNigffhoBkN1N640
         ps2oPe8Gh5U6PkQjqkFiVLkBtrKq3f+c3Oabt33gvN24JWZ7TIF1L+GvEkbQKIQsfyKL
         V8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779810132; x=1780414932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uveo2Hi703wEVJgO91J6eDaVgmAFc18fPRGQe9B+SZ0=;
        b=I7LYaZAeuaR4SOw/dd1NUEqcBf3mzdzz5gopZ89xuypSNHgb/Qozgei9oxTTgPkPgi
         GBfb33YLQaryqmJMSYZtM6ztdr7P3CYtzbvQ/kRUfFwC6vqyp5lBetxraxp1Ke9utWVZ
         UGa0gNANpFN4S1DD7y9bOhsx5+KwPwEmG8Y1YOA98BIrJUC0eUp0uYx0z94/ZgFX7/9L
         6wDguTMzhAY1dfr2rsS5NopS6bIFZM5hLsanNcz75PXukKx+IKWROCrv1zbNLm/USzoZ
         CvmtkyJHWAyNmr7iitogTSfX4eLOHn13mTiIldYg2hG7tzk4YoFChKfHHk81TPR0c0Sj
         3g7w==
X-Forwarded-Encrypted: i=1; AFNElJ/RC5MqRpEqHTYpcb44aJIikkrOuulHWugcrdOb4N+CYiaQk/otghVL1KZeY3sAyiIBL48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyREB8vAV+Ao6vIfCQM83KWoXSZfaJiMfiaV7VgbiH7j+xT8baY
	zMKxMffbi9swE+1dkiQAi7YBH5gr9aw+LIOME+AXNepZv4ARoSv7FlDE
X-Gm-Gg: Acq92OEIyILb9K39nR0E2kQ4qbna48vrOeYexRspHB0jrRWMK2DqUxZ5EJFM6ekLjkN
	9Ad2b2UQBVZMXBEL54Om2WxIUjTka3ynmWJhPvQyJRZWC78dCXNngbvPsOru9UkMLW6gcDqtRbP
	M9CJuje0sRItxsas0qrf8awFZQiPz5qee6jf62qMQYyaPgRPVyxUrOcexO1hG8P3BFiOmwTueHE
	TpTaxI9q1yn4315A3PqFDeHYF/KAg2pgnwCpcxhZRTpmwwGA5k0Vm8ee2AsmBADusQJQ3GzEyoU
	dPfA761snVFCfperkTStD0CZbwCUncu0sRNYyLc5hLYrXySvkvioQnGGZ2gIdyIGCvFJdWa5oSs
	cD4jLna7kNI7nqdJFZoWVU1sEC/QH77TnAs+wlMKdtZnR03LWdxYYpmHmktrRVQcFL9g+MiCzxF
	bWK3+KgrhrITh5pAZSriHj2qClN+NtjHM=
X-Received: by 2002:a05:600c:3b12:b0:490:545c:7a8a with SMTP id 5b1f17b1804b1-490545c7c2emr224012755e9.20.1779810131642;
        Tue, 26 May 2026 08:42:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:4b00:f03c:ba00:3081:348a:50c4:2d80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5c32esm35301088f8f.26.2026.05.26.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:42:11 -0700 (PDT)
From: Jamie Hill-Daniel <clubby789@gmail.com>
X-Google-Original-From: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
Date: Tue, 26 May 2026 16:32:16 +0100
Subject: [PATCH RESEND 2/2] selftest: seccomp: Adjust test for using both
 `STRICT` and `FILTER`
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-seccomp-combined-v1-2-304b1cc3ad24@hill-daniel.co.uk>
References: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
In-Reply-To: <20260526-seccomp-combined-v1-0-304b1cc3ad24@hill-daniel.co.uk>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779810129; l=1026;
 i=jamie@hill-daniel.co.uk; s=20260302; h=from:subject:message-id;
 bh=IhTA4SRq4kxztkMEQE6gGj3QktcRDsLFW6PL05IOesQ=;
 b=ightoZdPjxZef0wn/Yq84Wlb6EYSPnq7FFX3ME8HJemLgnVNUpHJ23+bgSpdzhF+XYsH4N3/v
 sgNM06OSdNlD8NNSiHlHKsBkymYc5cQNfIOtFpoaPraznMsNhpjnnSU
X-Developer-Key: i=jamie@hill-daniel.co.uk; a=ed25519;
 pk=ovqCXSlFUjrT82WuRtIuXB13U5n1yfxM6o0M5O5J2tA=

This test previously tested that applying `STRICT` after `FILTER` is
impossible - update it to test that it is now possible.

Signed-off-by: Jamie Hill-Daniel <jamie@hill-daniel.co.uk>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..ba042828dcbd 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -516,7 +516,7 @@ TEST(filter_chain_limits)
 	}
 }
 
-TEST(mode_filter_cannot_move_to_strict)
+TEST(mode_filter_combined)
 {
 	struct sock_filter filter[] = {
 		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
@@ -534,8 +534,7 @@ TEST(mode_filter_cannot_move_to_strict)
 	ASSERT_EQ(0, ret);
 
 	ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, NULL, 0, 0);
-	EXPECT_EQ(-1, ret);
-	EXPECT_EQ(EINVAL, errno);
+	ASSERT_EQ(0, ret);
 }
 
 

-- 
2.54.0

