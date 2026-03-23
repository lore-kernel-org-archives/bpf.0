Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E12BE02A
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307498; cv=none; b=UyU8XvZNfOg6Od9ywKFh9WNSz366p/frRC9jzYVcR1LY4zqSu7l39iY4y4BJFALy2i5WwA00Ss5/0JPfd0bfjTEmqbzkZXhJNDRdT8/ihCiOV7wDyEDSJ2R+ahoqzTvRI+7KShlMMosXcGHpaEQyt56EdktRyLLBDOdypCNHDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307498; c=relaxed/simple;
	bh=I+vvUzVsMvM93zzFYsiK+Ix+LvfH/cRjLat0oL0L6tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3f4tjdgxUnVNJCgNqpXgKYX4diBZvOABLInH0UIYg+u8r+EUN/zLcRArY3VU6Xv15zLUkiOnRHto9Yd0KAWrwBlt1oUUmvBgBxdJVHjahmryzIjAZNwCmk4E9W6PHV/KSt/Vgd69WMBIf9R6+O36Ko4NxsqFJ4DNlywwWAk280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4INo6vW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4INo6vW"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1555786a12.3
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 16:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774307496; x=1774912296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7h0PiQcMfuIA4QRKX7HAgdiCnBLQCRR8ZtPIq7M4aeA=;
        b=f4INo6vW+vjE55TpYuY5Rf79nGXpBYgf3/wHSCglLNF+uo5SQdC9nXZoOgqAOiJqsf
         +9PoAgWc7HX5WO91IoB9GQ2b1x/o9Hp7mrsgG1beC+80CCuCO9EOQ+dLoopUH+sbuC0B
         4Tsucb+B/z6Hro79Ux0OJt9hv8801kUdWsYyhOU/EZPIdnAsp3+AI5qA6+omO6Gyd0c6
         7qoh9LZe6mCpYlkpOAzrzVbX1VykuugeVoEt/QmcPnVG9fg3lfNAaVKv88L+rkrqOwpx
         MY8YD9VfL4j2TyFletHa6RsrQMI7lvEBtNN2/y+DUAyAp9xmZQ5jrF7S7QP1uuedGZ/f
         0MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774307496; x=1774912296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h0PiQcMfuIA4QRKX7HAgdiCnBLQCRR8ZtPIq7M4aeA=;
        b=kPKwEvx25mmJnC/6JYuA2CO6hroFAvQhxgSlh2upKgnbyri2qtgWxKynp6clw308tk
         BJpOfuixLbAG3v2qUiMcsrtPwWNiNKBEiRDDyQkVnxLhNW5yiDliHRP4WjFt5uDXhSK7
         QdYIja7Z4LN5N2umrCBmtCSOswVH1Kb62jEtKy/uIFKGbuBwjl1hkN27gg24dLD31fS/
         bDB0wZaGjix+d6Q7qDbYG0RgBTPS313HbnNYxcPXNRr4IfyLpgXsrAPc75I6uo72RFEy
         jENva1RvcpZlBDpW+Dzwr4V1OqMZMPfX9ZtKAFus7Eloc58UkIoIrMBOgG1db+5dOjJy
         enIw==
X-Gm-Message-State: AOJu0YxjeopuDMEv6Pde3BSOEO0NLPCIdTojbUS6gGGi2xP0NLT6xyNk
	Ow62bFjbEm6NtvMRp940euftcf7uXJp56vv0M5NkSTMN7iGm5IWgIAIWe7wVeA==
X-Gm-Gg: ATEYQzwQ3ZLHenDjSKTySDrRZggrANB2H9VuhHjgiRXs3sUNhHiNCZhbwT7vJVE55KH
	Pnpbg/6aF/fnQ1c4xpPg/cn7hzj4pj/kXhMypbdutEAnwYLNK7b7fR39sedppJJY0OnAKUEN5gS
	yyyC/yRBi+/edhpKkuAUW3rtv3sJP8CbJ+YQqHmolgyjI3R+/+x++Pzv/VzvpXzL4RshtLovGuz
	egxBzY+SuEx99UmTQ5bEc6twvXbv8+YgQE5WxgvEfPizscZdCDwJL+CFpymExaMuzhm5hJUVJqS
	auseSeoWcGBkAhpo8ipbJeoDIek+Cd5ftTA/Njq9IDlglIYfJtazMy10bARpzNSwtcNqOGdFYcb
	9gr/T/0vCMgGUZ1ulboMJT2d9lkcd2vYRfG6UP/9RiNi1oiHr2CF4Ng9H5QUSvBT9M0Xt2n1ui+
	ZSr6OQHshnhekSww==
X-Received: by 2002:a17:90b:5289:b0:359:9224:6c28 with SMTP id 98e67ed59e1d1-35bd2b973camr11405842a91.4.1774307496341;
        Mon, 23 Mar 2026 16:11:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0318f2ddsm171356a91.17.2026.03.23.16.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 16:11:35 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/1] selftests/bpf: Fix compiler warnings in task_local_data.h
Date: Mon, 23 Mar 2026 16:11:33 -0700
Message-ID: <20260323231133.859941-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compiler warnings about unused parameter, narrowing non-constant
into a smaller type and comparison between integers of different size.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/task_local_data.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 95847088961a..7819f318b2fb 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -120,6 +120,7 @@ static void tld_free(void);
 
 static void __tld_thread_exit_handler(void *unused)
 {
+	(void)unused;
 	tld_free();
 }
 #endif
@@ -222,10 +223,10 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 	if (!TLD_READ_ONCE(tld_meta_p)) {
 		err = __tld_init_meta_p();
 		if (err)
-			return (tld_key_t){err};
+			return (tld_key_t){(__s16)err};
 	}
 
-	for (i = 0; i < TLD_MAX_DATA_CNT; i++) {
+	for (i = 0; i < (int)TLD_MAX_DATA_CNT; i++) {
 retry:
 		cnt = atomic_load(&tld_meta_p->cnt);
 		if (i < cnt) {
-- 
2.52.0

