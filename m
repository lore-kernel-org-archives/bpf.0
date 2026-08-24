Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595073AAF4E
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559938; cv=none; b=kzU5IUmGFI5N0a4xBRWZCKbT9bfSVVi3fwTm5A8RqvjPNEEy0AY1BmZwXnQ4WTN7mxs80sfq7YfxlZjxsffVJNtbT59F8cB711LVsFm6xSajho0dMqXbpE+i/pidvzw65r/hcd9MRA64g6fXvqUhZAgWiB+QbYak7CUmbIajF60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559938; c=relaxed/simple;
	bh=IOliD3NqtH520Ztxb1yUI0/5Hm4hRsG+1poq3pdo7qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYg82midTJrzH7EVcumKU16g2t4swbv3OognFN1pwm4SaBrelnXZE1jNBD6BBj7mmqHvPOO/Rr/vdd27UPGjs6krFpc0LD8Oik5s00ifRPdRdfXtmAeWyh3ljDyiMsIzZvyaxNgyxyn7s1wPxU2hR0T5V6slRqQ2Kqt78F1xeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=EX1oHobJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="EX1oHobJ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso2241711a12.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787559937; x=1788164737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkSkQZtonja8QIU9hlX908Taik0FNQPbNyTPUmw09LQ=;
        b=EX1oHobJ3rqNO2iLDJdXYDqH2Kn3GDi8iWEJhN3XziUYVKN2545w2TTZju/on10Me5
         WQz/ONRO7pV7M8K67vaNj0nm94e17/Wam50GwxOvvoWLGILLebs1bFhuIfHUaqi1M/Uq
         Xv/gfmI54DEhTU+X/16wtaygdEXhtfyK2mCF9D1N0cge4RTo6cnvO8t/H9el4veleTdm
         qXJRK1hOOEjlyWxfr94tMMwl4+0mKKK6EOXwVHzsAT+jY8Hw9Xr0Fqi6iViSUEHZhe8x
         YX4aiWd3x8u/9/IGnwXSFjDMi/3PUaOKuYehQVbbCaDcY+mKosE/JBI9faWzcvKIrXN+
         IdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787559937; x=1788164737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkSkQZtonja8QIU9hlX908Taik0FNQPbNyTPUmw09LQ=;
        b=m2eP4/rYrO8THvNcglA5cktR7GmqBNEJa1FUHks4KBV/B5fgEMUTvEvWzeWFnxc8PY
         80U7Yx7p9XdqgKGdqZf1q0qw3FdsQnkfMZxy7mWBG6JjSfoKv1EF8j4BrxEAZsb3b4Cz
         Qv72kAdNXAVjukG3ACXk1ks95n3fuWq9hWqIu/4p/RFTSUMBY9/4N8qQH3dEck3fi7BO
         DUttoyus9bwJnejeh9iFWkCEBwgmMz3Mu6CkNo4bYinA9SZu9BbOXapRiO8kK1ExDRLx
         TqQIQ/X236FOVZEwTga1QZwt+FDMKNKfpRL5yHp1bhHIoFRcUt5wyEHMZhZwpUEGbS0Y
         sslA==
X-Gm-Message-State: AFuF++nyQ0phscnJ5yKIhGkFCoC2WvejRmMYlyq9iI8Lq9+YV63ZJW1W
	xIGfrL5uZhtKuzPAsMZFrZYdODJyohkRRer9Cox+B2Wko6daXvhp6egaN6pKgksBVHWvm+vjacU
	KBzzy
X-Gm-Gg: AR+sD10+b2mMBVRCm1BjhlbvwiQMOP3+gv3e/4pu85vBQFAC16SiaZPKoqDAPz8i4XG
	oqeMnEzwCptMulVNU34///ZuVbTrkzaqwI2KVhUpeG2x2166iwDtwAbN0PG/CQ9lj8vKokmG+vv
	KrvZRUJOMrbPFapQfC6QRKdmZx11TkLozbvAybNL1ht5s/lixsc/JsxXr7kG+oTajzWCWDO620l
	NddpJHU2Bjt/JMWRqcOgoWiHv7lJYBbS2DvWQwV3XF1rkLWWP2a3M91R0BKIPmWuzhvy57jbLwe
	RZoy2HtwUt3qtffmyzoZJ7MYOzqJna88apb4+5qRsYVahqZKyWEDUUHMLVIbSt4n1NaiY8Q3dBF
	lqFHFucs+wSIKoz5Je6SKw/WOx4m13VJQ738sVCkdllRlytbzua9uGBCrljtDuVIYY9U0WLOJ0e
	Yr1BpDl2y9roA5m29qEzhWDDFnptoVlJqb0WBA1XH4L1vV4IAUvpK3DKbqGQYh6CrGLYPBQ84Qv
	sBolRqmQfT0BRwuH+908CQ=
X-Received: by 2002:a17:90b:3fc5:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-395df5ec7a7mr29257250a91.11.1787559936628;
        Mon, 24 Aug 2026 01:25:36 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4b46518sm9518512a91.17.2026.08.24.01.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:25:36 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 3/3] selftests/bpf: Test large allocations for both sleepable/nonsleepable arena users
Date: Mon, 24 Aug 2026 04:25:30 -0400
Message-ID: <20260824082530.47553-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824082530.47553-1-emil@etsalapatis.com>
References: <20260824082530.47553-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We now use different code paths in the internal allocator when
allocating arena memory, depending on whether the caller is sleepable
or not. These paths mostly differ functionally for large allocations,
so add extra testing for that case.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/progs/verifier_arena_large.c          | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_large.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
index 6ab8730d4878..e388a67d9129 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -284,6 +284,7 @@ int big_alloc2(void *ctx)
 	return 0;
 }
 
+/* Nonsleepable because it binds to a socket program. */
 SEC("socket")
 __success __retval(0)
 int big_alloc3(void *ctx)
@@ -300,7 +301,31 @@ int big_alloc3(void *ctx)
 	 */
 	pages = bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE, 0);
 	if (!pages)
-		return 0;
+		return 1;
+
+	bpf_for(i, 0, 2051)
+			pages[i * PAGE_SIZE] = 123;
+	bpf_for(i, 0, 2051)
+			if (pages[i * PAGE_SIZE] != 123)
+				return i;
+
+	bpf_arena_free_pages(&arena, pages, 2051);
+#endif
+	return 0;
+}
+
+/* SYSCALL programs are always sleepable. */
+SEC("syscall")
+__success __retval(0)
+int big_alloc4(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	char __arena *pages;
+	u64 i;
+
+	pages = bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE, 0);
+	if (!pages)
+		return 1;
 
 	bpf_for(i, 0, 2051)
 			pages[i * PAGE_SIZE] = 123;
-- 
2.54.0

