Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26728B7EA
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844890; cv=none; b=TtCKrZwumE1eXXplUqt+5Sd9KfNe48HlgoY8y2Ms4F5ETt+iB2un+7mpMqusDWpdrGFVYjSAjdgsRijjUOZEnPzkqRKO4exaDDfHZ2J9pYEH+8JZdjb05B5jYdUmgsdeeDOpiZTwZ7nmyvvj34S+b8HRa0oT5gGzobtxchweLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844890; c=relaxed/simple;
	bh=+JHDuzbi9ldVSnPat9JoCVKuhDe7bJHfcAxEvo5qEdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVb/5YET35I2E+s5aQJ2dctnKBc2bKsWJ/JHihUq/mwZpNaMp6ZcC9IgvNmIoziijuNiLRDQ8hb5fhDVyOYVU3mM7eBrfJeoFYyGq7yDJ/2g261w2FeWmHkYCwDdHcyqRElVV9l2AKVkA/WPlRT0QJw4PAeSJM+b0f8oziCamyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErGB402t; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErGB402t"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2be1ab1fa7dso1156054eec.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772844888; x=1773449688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtN8rJyxgujSOLUNp3Mg4U7/rRF526fUzTXP77KmtEI=;
        b=ErGB402tB374/J3A5IL5pF0oeQN318lddTPY9gZYTuyihP2C38fHOaNNC2I9xMFneM
         5J2Y0FiUvkPUDeGEaKduGASwQdKlfK1q9vOcTvS4hF6nErF8zf68XmbHK6eEiV7gUCYM
         yu7rPhW9n9/ah0Lp1MEeS2yuLQUN8WeGeJfToH64zFK9pqYIKFE4OSAW8+9fK3mjrTRh
         /GpTJoGGHyGeQHOKD5jY4qs2f4aqKMe8RQi/oDHo+yUyroaWEucj6awVJOU36WorzbJR
         6KEgHJqO6olIKFathyzW1H6sEB/fYJPQpST0ZvfIPwhU+j3/y6s0XcNkWkodfitzWfsn
         lckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772844888; x=1773449688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UtN8rJyxgujSOLUNp3Mg4U7/rRF526fUzTXP77KmtEI=;
        b=sG9RSImfA2d1zxS3xHJQS1XmNG6cyL85WKVEvFxD0Yh3HcJUz+t4VqV5Yh7A7obGRs
         1bG9h1F7uFr0jbb5RRcCYu3lq6qmntW20CBXTAtUU9r0YdQLmdOQsMkkaDEA3VPJZz1c
         gTI91SUSxCDJb+gW7gr/kczcaP0wsv5dm6qMVjYyrcYLCudK5c2+0FKd5dGbwHc2pvG1
         oiORm32vZDxFDCbQhVNVHbZ1JBU97rfuZjxVexLrelGgdlPQq69P/dJJifw+i6HW2sIO
         jvSC32XCVdi6x0ZBF1ktAUnZJtWv1hP8id5fJ0kDtzWaoZ/aE/eBHmNA0Ok00o2Z1vqv
         aGMw==
X-Gm-Message-State: AOJu0YzrOxi7mG4Tf5tbzYTVPUSBHgW5qwz7HsJSZwFPYCJ4i/kWGoXn
	miHPxMmPqFfDLC/U4f98EJoQGUtbH9UE72CAfJy1mBU2HQqWOSrw+cWhGWn0zale
X-Gm-Gg: ATEYQzzMaXmd8VKDYPNBh24mEHwZYKNgpS1xZiLX5rEaQ8I7ZNPVs5KL68tcdDhBanD
	RK/lRZw0TzrjpW0/DIfXrx2YeSoGV1JAIOG/eB8oJTERCWxVJBpNIgDa5AvKpbzEUw4qjizT7e9
	kDp3whp/RRgkffalRpG2srZ73nVdrLlZMCRb+jQ9V6oplWaaeFYZ1M/P33BBF2jU4U9GyQxhjdv
	GTgJb11WsIGEGlPCOUWAUBMfGTP1uxzsZ/akqrbGKge2CDiDlmpzVJJ7DKoIrDuYRcdPKY4/Z00
	75Y3+jSRwgnJZJsA+T+n32q/rhMj+OuWpNp8Zd6fycrAk3bKXLNAcd7YhdHAJZL4sip8GrC6pJ/
	v7lYMNDp53UpRBRP9iK/XaJAT85/Pt+WhA1nSyOJI7mpcKGDedASV+hLmOTHpSx9Rm5dfO+Pm89
	VfN6WSYGWFQW8D1YMXxVlz19ARHTUZSF8CovNJu9bAmvfq6IziLvYxwotnLZ7k/XVn011VfgoEr
	L/b3RE=
X-Received: by 2002:a05:7301:fa0a:b0:2b8:30b8:58cf with SMTP id 5a478bee46e88-2be4de76edcmr1730695eec.8.1772844887810;
        Fri, 06 Mar 2026 16:54:47 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f62d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948390sm2235110eec.22.2026.03.06.16.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 16:54:47 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	emil@etsalapatis.com
Subject: [PATCH bpf v3 3/3] Revert "selftests/bpf: Update reg_bound range refinement logic"
Date: Fri,  6 Mar 2026 16:54:26 -0800
Message-ID: <20260306-bpf-32-bit-range-overflow-v3-3-f7f67e060a6b@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306-bpf-32-bit-range-overflow-v3-0-f7f67e060a6b@gmail.com>
References: <20260306-bpf-32-bit-range-overflow-v3-0-f7f67e060a6b@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This reverts commit da653de268d32a80e135c9eb960a8147c186f1bc.
Removed logic is now covered by range_refine_in_halves()
which handles both 32-bit and 64-bit refinements.

Suggested-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 04938d0d431b38e086b50fe28b99e4ad2682742e..cb8dd2f63296b826491c8a010f4ece4aa20c0560 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -519,20 +519,6 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 		return range_intersection(x_t, x, x_swap);
 	}
 
-	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t != y_t) {
-		if (x_t == S64 && x.a > x.b) {
-			if (x.b < y.a && x.a <= y.b)
-				return range(x_t, x.a, y.b);
-			if (x.a > y.b && x.b >= y.a)
-				return range(x_t, y.a, x.b);
-		} else if (x_t == U64 && y.a > y.b) {
-			if (y.b < x.a && y.a <= x.b)
-				return range(x_t, y.a, x.b);
-			if (y.a > x.b && y.b >= x.a)
-				return range(x_t, x.a, y.b);
-		}
-	}
-
 	/* otherwise, plain range cast and intersection works */
 	return range_intersection(x_t, x, y_cast);
 }

-- 
2.53.0
