Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129069;
	b=Fqxj8N/1xI4+E0GRmcp+WgSnmPHvdKJ4Vyqknz41Mfv9r3uxGbPmTHiaufB/G4/4eRLN
	 LboHU8jB/BJ4BOxn9KrYOrHJac7RUysFThmgafo5vXSfHu4fQg0KPrfiyY9WyIdBNpXYk
	 PQs1WrKmiIn5icCE22CoDK93WFJy0EqTH/zzcYRpGl4o5WvCsdfXO+SaBzyb6Ywd5IF1l
	 EE83ITrt1+hJjjP/bAm6xMpgLS5Tw30wPW+W9+hRrkGOgSxuq8+BU92EoGSNjxhyr4hzH
	 IhmT41hP1UEbPR6rfgR3IQIM1FywNR74YhePQ33RT/wZ5hRgUd1mUIfnZQ3iGS4SLvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lmNt8UHMJZ1LwZOmio/ru6CKGlng7+kmKVOojz71M+A=;
	b=Och2K6Tmw0hj5248WVPg1tolT68IJwenYk5BjwWStxwMfOPLPvJK18rxGykY9zgfaD15
	 qTpoad6YqJdikFHUQ0e8KhrrfOIodsfbMAPDrWt0axwWhTQHaf9jyD7CnJ0ru7M2SrxAl
	 hCD4ldhsJ791lbAsQcgX07VTRvOf5AAK6Dn9MpxrGR2d56dv0+uQcimCaNH0P09zeEzv+
	 nBNd2ozli1+sqkFnrDX+THUaeHO0/yhBl47zJGlbaM+h1qd/LilNWlfEa1cPKOKbFzcnH
	 LOk130QJK74OxxrBSmwtgbz3lE+sryInBc0J7iqux4wRyULQhIGml4N/9fAjKUGWV5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Sq9DV9HW;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477C4606A327
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 477C4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Sq9DV9HW
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so1790815e9.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793129067; x=1793733867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lmNt8UHMJZ1LwZOmio/ru6CKGlng7+kmKVOojz71M+A=;
        b=Sq9DV9HWlxYeRwxRg6lsRdjjUcUmmZPBSNtrkEdTPpxfx4b28MLjk/bgF34+zb5Nrr
         IbG78hiCO/6Z00oGElUdUe+FGpacX5QsrDbQjmlhOZ1DFB13AyFeBSYkDVr6AqTD0Xqw
         2utoyID/pUOWc3TKUxBoJiUPFSsSL0Tg5XfclBjxvMmtfdu2PFjXAhlMVBi25z2OCqFy
         ih4s1MXPjNOvCl5WFe2u9nS2etjc9B32H0HlHZb1rC6YPKw4hnaC/I8kbJBB0Jyvw2jO
         A5ULEHud5NMl9UBC3p7uov/31xGCa/MYGZaOnGlQQ6umGfM28nMf0Eu6m9i0qwRl7XxP
         fBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129067; x=1793733867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lmNt8UHMJZ1LwZOmio/ru6CKGlng7+kmKVOojz71M+A=;
        b=V2LkqEgwgYx3lkoiBTF7fRuH3uWkXsZ4di4r2cv1V+T/gzfM9JRB4Ne0fmPIWvEVd1
         JxH/FdrTthi4pXKPWZyn462PoIuXDKRv6A2l0YnykqsmbBdIpfUqdwk6Cn+/dyFCOQ2C
         3DrVFbXX5znXRCQCdQH3GzCw+i+vjyS6vcP8VB9T2fORdo9JYEkhBrqpH/zMYU+VagDJ
         TWs430JWtzPj022V9+NkePjhpsdmsp4ageDAe8dts6elL5H62m63eyPIXQGUlw2er0Ke
         7Qy4mg9jgvVk1MTeM5gMiy2Y+ayXXKbSAA4iO7lfTZg+Hq7uRIw7UtciZnEDR3OXlLzI
         6hxw==
X-Gm-Message-State: AFq9FYIANIM6jvD2sSVoS8lLqVpOzMWGYHRcRmnzNCmPZxPTnsDpjDWz
	c5RRCrGlSDwZWQA/HGYSajnB/lIn4MSVzmWj/NJwX3EuscoNUh5rf6aK1MngeNHPoPMDEI0rhdz
	IP43xekIxjg==
X-Gm-Gg: AYBFou2OvUFP3qH+Q29Ra8a9HravOP98fzBQtvjY+fwSVbAk553NcIyos8I4FAieNQd
	QRTKszwpZi1YMqQ2ImtCMgzYtqK8Bl2zD+2O0SsMcdVkDQqX8+K0uKc2Z46P19+gmp4MvwXSSqV
	EO138I1H2ELcUaBU4cZM56VQGU8tZ+tSg79bfDNT3WFmlVy6qcPnJENaeW0/AcWgJH9u0CFcSj8
	k1uHUwIXm6JFER4fZwFd19b4OmmN5wW5g/8yXHHQEnLFU2RuTjYOAgvCaz945mv1x2CJAuaDntj
	dt/cQCzhH3wXXY5vpE7h2XOGA6YoEYalvGHeByhRMLOCcqyZbM9QhULa4MdfIv2ATUEcbMpJXkO
	OHlOTErbN/RA3rg6GZmNNAVK2z8Xo0GDqIMo9j2av9i+AVnWzMaXtG3dylyXPNbWJZjQdQ181Cr
	zVV+Rpop/G4x1e1DxAiS5mPd+1H/L66C6spqE28iNIBaCbEdV1AzVBJWUT66jq72tGlqRM3MLae
	O+gxsyfTpGX4Nt7CjGLnSgg9Q0IKJFuxS0mRLNJY5zH
X-Received: by 2002:a05:600c:c4a7:b0:4a2:1655:87e2 with SMTP id 5b1f17b1804b1-4a35acb2316mr209826035e9.19.1793129067380;
        Tue, 27 Oct 2026 12:24:27 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2eb1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92e103d91sm4721385e9.0.2026.10.27.12.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:24:25 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: libarena: make allocator growth on alloc failure optional
Date: Tue, 27 Oct 2026 19:24:11 +0000
Message-ID: <20261027192413.5038-3-emil@etsalapatis.com>
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

The buddy allocator currently always grows when an allocation fails due
to a lack of allocated arena pages. This behavior assumes that the user
sizes the arena to be as large as the maximum allocation size, but that
is not always the case.

Add a nogrow allocation option for users that want to explicitly control
the total mapped size of the arena. With this API, an allocation request
that cannot be serviced from currently mapped arena pages fails instead
of triggering bpf_arena_alloc_pages(). The user instead explicitly maps
additional memory into the arena with a separate buddy_grow() call.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  1 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 20 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 528c69a1f38e..958450fc5f9d 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -77,5 +77,6 @@ int buddy_init(struct buddy __arena *buddy);
 int buddy_destroy(struct buddy __arena *buddy);
 int buddy_free(struct buddy __arena *buddy, void __arena *free);
 void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size);
+void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size);
 
 #endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 552ce87875e3..ed359d4af1f4 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -747,8 +747,9 @@ static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_
 
 	return (u64)address;
 }
-__weak
-void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
+
+static __always_inline
+void __arena *buddy_alloc_maygrow(struct buddy __arena *buddy, size_t size, bool grow)
 {
 	void __arena *address = NULL;
 	struct buddy_chunk __arena *chunk;
@@ -772,6 +773,9 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 	if (address)
 		goto done;
 
+	if (!grow)
+		return NULL;
+
 	/* Get a new chunk. */
 	chunk = buddy_chunk_get(buddy);
 	if (chunk)
@@ -796,6 +800,18 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 	return address;
 }
 
+__weak
+void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
+{
+	return buddy_alloc_maygrow(buddy, size, true);
+}
+
+__weak
+void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size)
+{
+	return buddy_alloc_maygrow(buddy, size, false);
+}
+
 static __always_inline int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
 {
 	struct buddy_header __arena *header, *buddy_header;
-- 
2.52.0

