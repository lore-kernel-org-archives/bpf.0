Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129076;
	b=SIhSC1XCA0iGrPlhNwuCP7T4pRgC2aJFDd9ndaBm2URVQHAsUUPjr2iicZDZISREmWMP
	 7eHA6/Fpk03WTzVMOvpqWlmCE1DRs2iSHaTUOcogHx0/e3W6LDMa/HL/7l5oqoddNdc3D
	 qYQ1Hk2R0ZGV+OACASS+IvADRP3VmeFOX2MxxxWAqp1ozN2aU07uzR/giH7XWnXmA3eu+
	 m29RCP3IL//SXafc4HW7zaSmOLaMrD4MwO0uui0S3bkk2kKOKC0nTQATKL/bsNW0VGYRE
	 loV08Z0FPklSIzID0Qk+Ru5mbiluy04n3ew8nvmh+E/Ek2azg48lXwxU7o5Rx2ns5+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GQZGJeSpKyzleV5tnvZzt+FXSaWm72txTVpShChFQ+4=;
	b=0FziXcuLLajpcglPRdEI6UPkrv6h8xF0ygnsjrGuZuh1uYfZjpGnUu/eMtVg51OBXkA8
	 YzcL9oWfIEGOtTFmT094OVX+jCfLx6FPNhFBmhiG8IMS/5BIYEAWnDqDLOk3Gh5WrsUV8
	 qar1aOSONisa7RXASmMyDxAecmRlwzUVzCU3QtTH9Bua4+KmiY9J7V6RqH1fDq9azH/sU
	 nA+K6t7dbTEIEXdEgRp1JLU/rD+eXXcseKLpsf/pE7XmltKozFMH4qbQs4NhFhdB4W/yV
	 Oiz3MVI4CRtEVRCqUW4BI8rXZCJsyJBOXt/22+UjR2LSVs/ICuVCoMrNGExaiPqQQxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Sq+Ui4RX;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E5606A31F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C1E5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Sq+Ui4RX
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso153546f8f.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793129075; x=1793733875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GQZGJeSpKyzleV5tnvZzt+FXSaWm72txTVpShChFQ+4=;
        b=Sq+Ui4RXKyG1drkSr8mJYz3B6SR2clt1a2As+03Wvbb8ybxZHO54zvQcPTgjFe1znb
         vzhqd6IZT+ssEfsgodJU5iPFtdRB3RwkxPhGqZJ/Y0qWLatCX4aGTmNi5Y1XobJfeIn2
         M5mfApKVt9QE3goId4CjF+2k9DLKiQjGAQ9teuzzuF29jXcHLzkKX+N72oAi/u/AzUn5
         wo7OpI303JJ5Iqt/26M0kBkPXrn8E7Jnya4UD5B9cUiFVjsdAljk3YC7Fpkzw3ysHl0/
         NPus9Hmx7tx4dJ2yUG6LSViEHlqrnukTE4NGSCfjnWO4iLpoXFf1GXfA3HyL5jCnroL6
         V2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129075; x=1793733875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GQZGJeSpKyzleV5tnvZzt+FXSaWm72txTVpShChFQ+4=;
        b=UIkQIzBh35JekYICQBU/XZme6rk5RRjXjWVAFNNmy+/mUWKZ2XXg7QTQQ4Ox8MpMeb
         061sEE1B77JCCMIvV7jMA65yyzxa14sbQqJGnXnIDCV4vwlxIO3xgfkLR4+tfCeKsfPb
         muecBiGW4MWfHo3E0uDRccHaTnMRrEK7UO6rPXdyI806yxP3vPRsgocB2jPE3jbmEuIg
         rfOBbUqVpLXtAxzUqSGlnMGQpyzmoGDMll0fH2GBXDPQ4PlMbRKkU9mZMxWJLc1/v0OJ
         z/ElY43F4Qe7k7u9tWQ9YuMMKLx/a3wFc58UnLgtZ4Wm10pwYe7Yja92kW9XOLpwj2P9
         Jcrg==
X-Gm-Message-State: AFq9FYJNSjaCY2DyoH2/RU4UmClwOywmOWQuFVcW7XUXV3c82aAFbgf9
	DwHx1H6eVFLyeNicr8TNUmm90UUGJOc4Vwip95yKh9sBXxb8NCVYuOrNLLWmtcq20X5ALVsiIaX
	A/6NuA3TPsA==
X-Gm-Gg: AYBFou00jrD5HmgfNl+/6SW5UxX3C0wgrp4i5xOIp24l4/evUD4A1fv6X+0EdzOynjF
	jb7gIolrMCkpqrXITJlgm6SXweIMcjVNo5Hh7Ni4renpQoKLNMwEvgtwyaH2ud5OMMkfeoBYVur
	gBmzcQ+N0pJi49m6QVNgszp1J89WOx3SFoM1PYMcIzHOaimnPK48S88MpDO5O9o9Jl2I4E+pJ0x
	VbwORa4QAFbIxbnYbaq179jO57khlyz/JHFU7wsHu52wFBEj+FrJk1MsjarfpiFQrv6eRk5WMSZ
	VAph3ASszrsIRbefcXakNj3cqBosEHjAuj767EEBqdHNc7VVghkZpJkWo3Ofn07TeLRbmhcptjn
	pJRoYhc7psjkhqIS3rLhW0OjEx3zsCafBjr712RYkZRxbp2iyKWg/xptk5HPK4HICcAJ4bNPTYB
	iF0r/RP7yDXzat4s1G2b4Je8DmNpDCkwZ/+kY5Oflyf31qrESG0tskXqMqLmDLpaLf1MKYQ8khJ
	KnDyz7h2BynjbHrPYNDEHJ7kS1qNi3itucOkiJT4nhC
X-Received: by 2002:a05:600c:4445:b0:4a8:b8b4:6226 with SMTP id 5b1f17b1804b1-4a8b8b4623cmr46757055e9.28.1793129074717;
        Tue, 27 Oct 2026 12:24:34 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2eb1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92e103d91sm4721385e9.0.2026.10.27.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:24:34 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: libarena: Make zero variable type __u32 instead of u32
Date: Tue, 27 Oct 2026 19:24:13 +0000
Message-ID: <20261027192413.5038-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027192413.5038-1-emil@etsalapatis.com>
References: <20261027192413.5038-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the zero variable used for loop convergence to the user-visible
__u32 type to avoid missing type issues when including the skeleton
in userspace.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/libarena/include/libarena/common.h | 2 +-
 tools/testing/selftests/bpf/libarena/src/common.bpf.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
index a6220355a697..940e82cc2928 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
@@ -43,7 +43,7 @@ struct {
  * imprecise. To force the variable to be imprecise, initialize it with
  * the opaque volatile variable 0 instead of the constant 0.
  */
-volatile u32 zero __weak;
+volatile __u32 zero __weak;
 extern volatile u64 asan_violated;
 
 int arena_fls(__u64 word);
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index d859bd538c52..c3c5326d8ca2 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -7,7 +7,7 @@
 #include <libarena/buddy.h>
 
 struct buddy __arena buddy;
-volatile u32 zero = 0;
+volatile __u32 zero = 0;
 
 /*
  * Storage for the queue nodes declared by bpf_arena_spin_lock.h. Each program
-- 
2.52.0

