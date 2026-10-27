Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118564;
	b=c3NAiif+eJCTrCP008K1PM6K8YSaBvoNoW1xRyhwQevAyeURxYErfmfqI8nSbx9k5sVc
	 DtQwpYvCLRWZqXYcqaR0WRlR5C47t9ltXk/DsdyRQsGOG9ZvBABOLw6xRueg+ztpd+ZXs
	 xZz+GzMLggNEf+TOkqew0VT2tsjTrdipyr58Ams5Gb3lrehJ2LwGfwpyY1j2AG8JZGdFi
	 uDNqGK2xgBhyz46rgKONfZznCX3aFfjC52988x8iv9hdkSszxYarKCCHtBYMLTr/W09rf
	 P0X6d//P8AGEQBiG39PUgaQEP6TnWU4+b4ulghLXM4djKh441NuzPWJUvUiThYhdliA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X0VLXPG3S4E58Rf7KZ0ScKDXkz7wxuqbSf7F0/RO0jM=;
	b=eH5kgBtPbaf6Me8uTfyuG6aubYz60mufYjhYHwff7epttULLJEoQAlsbGtwXUZzJ0SRV
	 cYQ/ShGshhlWUBRDR2lxlXs8b+GbhcbnZ8JG+ze2iZOMcwZUKkmj8gHGqGEiWqRlbwJ4n
	 DhjoHPLybGqcnUXFxDf/g3eELa2CxuD3YW+RPEwrs7y0T6bPlejSOoafY7DefGkmOVHE5
	 ufnTJQoH5Z52d6BmdOM/ML6O94cRDWrYCen3fWZIc+B9lT5zlTaewmA7tNdFhL7n+Zz0C
	 j7/TH9ajcpnFqw/Z+EU/0lWBPoe6u5sg40B9NQluyWMvbWlYzE9XoByTA0gp9exvCsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b="K82/OGWZ";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B37606A31F
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90B37606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=K82/OGWZ
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso72134a91.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118563; x=1793723363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0VLXPG3S4E58Rf7KZ0ScKDXkz7wxuqbSf7F0/RO0jM=;
        b=K82/OGWZAizrBpyhubMcJMcHc8Yt02VV0h1L5yGNljw+D5ut2qKCEY4YjYIHKnEzwv
         dOyJR8pQ5oSc2wdgFxtf6UUDnNCrLdAbynPDwuqXrQWyLoJDctXjF4L32HmwDQ+CeROQ
         uoO6gQd9g+MEpRhBOYzCAmTHoGZFMyI8fSba7afXwOM3KSGFPKNPfp5ooBzK7KORItqC
         eh+WvSWTmkjpTvSMybmpXOOvqN1PI1L3NPnj6PeAWkNfiRm9zKKiZVZUpxtJH7Qp7VHF
         yGjJLUQPPBT2YNZaX4iGtXQ06PWk0xva+jH1p+pDWx2nOMEK1PVBvA0kYWEEQEiHVj7U
         iotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118563; x=1793723363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X0VLXPG3S4E58Rf7KZ0ScKDXkz7wxuqbSf7F0/RO0jM=;
        b=jYR/U3kuXJEveif7SN1BxP4ZfCyAEzgWmDcTNWiyJ4F7AZ3ERN0BfgRUKob6NVwEBW
         W/6XOfxs8YQBTbB3uDxz7EQJa01+srXsn++a9zS8FOLEEVsnlUjg+Rz+dFBrl+pDoXP1
         VcriQh9puldP+mNG5855T2zxWb2Z0r/8j2JZSfstjz0214XuUQzV3cmgL5pngHR6uPoG
         ELFlVEp2u3AZDe7v+je/xYwg/0JhsmY7jtXrWOjKY0uupU9RH0aCVnMtubb4RkFI0thL
         h30sBHmrXJHmtUcjTuj1jJqfKii1ezUFooJILUbStcQMBO0dyJem+qipFAGGhq3/Osbx
         5DIA==
X-Gm-Message-State: AFq9FYIuLnA98hBzKxsn6eLYUF2Iycds7/I9C9fj2H2vfsW68Hn2iHG1
	tVtDArr7RVXbpAeRj55hWW04QIy27uabeNILkhfNP20LFf8f2Mzw1J7Ouezup967zUc73XINzDG
	8f1HgXLg=
X-Gm-Gg: AYBFou2AYIOpj6NrKGBxi6/HPiqNX7gl3aN22LQ5779rbLuumbcAcgH0X9bJtTI5UhU
	RzTiQ3rgW5gCRqN3K61HiAvPtXUgPGExz9tAQyDzhi18coRiKPBlLCOfGThF4xP9lCE65jfTGvz
	bkF4ZgT3294sTW9mSDsG5RDyb/vtHaS18T+XZR0ZvcjNbyoQ8yeR8AJ6gSY1zA4Dd+8PSv/6aQj
	a/2ZHg/nb+/K//Wfcf5oRxeQ2jPy9kY4o0O0Ke8konNXIWe3tYJUhTvbPokQI3H5Saz/F6jzP4C
	pc1oW0hiteJ4u4BL9EdbdpuRJjmTCbLLz/P5tdKf7TVto0g+ry/m9+9bgnfBXs1RJpFpHwgRaCj
	TXRuTIapFRCRvXWDZ3xuSQf5h1xegE4UElcO2ldLl/OUAh21xi2Zip3rvSxqirQkrqJu3CquX4F
	I9X3q8r4gs1neP8XVRokhq81YCqJgB/Zh+I+py9qAmiQvhoW4Ch7Mbnm1SBrBZPHrIBpJT3AAR8
	mm2L6+SO/VTKLM4xB1WA8JsGSlaYDm2KyTSevjnLMNemAc3Dgf63SH3It2tqk66jVr9wf3+38Qo
	swwfzqroFvKZT80OeKXXFSHf/8pG7JsBHB1R4Nz/8nwC1kCHtRZf1sloks1JdFwi1XA=
X-Received: by 2002:a17:90b:564d:b0:3ac:7f4c:a690 with SMTP id 98e67ed59e1d1-3adeafb0449mr7828112a91.35.1793118562937;
        Tue, 27 Oct 2026 09:29:22 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb75254sm7288854a91.4.2026.10.27.09.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:29:22 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 3/4] selftests/bpf: libarena: add explicit buddy_grow() call
Date: Tue, 27 Oct 2026 16:29:15 +0000
Message-ID: <20261027162916.10996-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027162916.10996-1-emil@etsalapatis.com>
References: <20261027162916.10996-1-emil@etsalapatis.com>
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

Add an API call for explicitly growing the arena through
page allocation. Useful for programs that do not do so
implicitly through buddy_alloc().

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  1 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 958450fc5f9d..4cad0649dc17 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -78,5 +78,6 @@ int buddy_destroy(struct buddy __arena *buddy);
 int buddy_free(struct buddy __arena *buddy, void __arena *free);
 void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size);
 void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size);
+int buddy_grow(struct buddy __arena *buddy, size_t size);
 
 #endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index ed359d4af1f4..f06b6bd5c088 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -812,6 +812,32 @@ void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size)
 	return buddy_alloc_maygrow(buddy, size, false);
 }
 
+__weak
+int buddy_grow(struct buddy __arena *buddy, size_t size)
+{
+	struct buddy_chunk __arena  *chunk;
+	unsigned long flags;
+	int i;
+
+	for (i = zero; i < size && can_loop; i++) {
+		chunk = buddy_chunk_get(buddy);
+		if (!chunk)
+			return -ENOMEM;
+
+		if (buddy_lock(buddy, flags)) {
+			bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
+			return -ENOMEM;
+		}
+
+		chunk->next = buddy->first_chunk;
+		buddy->first_chunk = chunk;
+
+		buddy_unlock(buddy, flags);
+	}
+
+	return 0;
+}
+
 static __always_inline int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
 {
 	struct buddy_header __arena *header, *buddy_header;
-- 
2.52.0

