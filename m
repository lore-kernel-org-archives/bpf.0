Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118562;
	b=e76dK5U3RcEkBi8JK9NVMzhWH9BXeIMSR4gUErl0VR1cuRMvsl4azXoORp7pgG2DTLTs
	 AySCzVZ9wtkivces7cp5XhBqbCS1taQfpn8A3IW5A/xI7HZ6fLqZvOfNTdU86Pk9WPYo3
	 sGSEj6WVHHubOcMtqJdOhK8GyCl/FJTKHwqh+HkvynNHm3yI56mI3QhclG+URQr55xZu4
	 KlEUvdFOWb8KPF6wyQ+OHE+GS2ae/MrVnXnzjyNDxCH+NybtkWJ0ewlyxZwBfAKDx8Qul
	 n0VHWGJUbcqJVu8y13dID46F7me/SVdZHVxZHbFeiijeAD5bAr9u6wXqHgEwKQ7SzZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lmNt8UHMJZ1LwZOmio/ru6CKGlng7+kmKVOojz71M+A=;
	b=yJsOLgwoLMXqFbUjiHu6OjbGf2CALtGPJDxJUH38ZpEB9OkHLgZD2BVBdwlEs+WyBn9Y
	 R7ekuh41TUgC5LqY8dKMyBQo8OnffQpx4L0CEMtkh0u/CVspJouWT3WQgS/IPuR8JHNG8
	 HVNNS4Z/uL9rDIvYJxC+9Ggx26L+5USS+YO8zasYy3A0tdUTFqZksmhq9hYvrQp2rhmEF
	 sMqGgDsTdARyMX7/Q+vrMUpPHOW85D7aY4bSxCnUGO303GGhN3iFWkcjGbRsvJv1vbF4I
	 TRDUKD+uZy30eMBWetPBtKSCvzLzekz9jwihQcBLJMCOm61PpoSf2Ft10A9/CeC+bmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=szuSOehL;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BE606A327
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 16:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 828BE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=szuSOehL
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdab938dc83so62990a12.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793118562; x=1793723362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lmNt8UHMJZ1LwZOmio/ru6CKGlng7+kmKVOojz71M+A=;
        b=szuSOehL8ErGz12Js4Yi0VnfK5ww2JV2teJ03U2AMaXOPOae+6w16Dt8CjmcvyCcRb
         3omBkggi5Nsm4Ig9GUmcKhPq46O4AyMpWHJeMdbBPEcIBvms5/BJrUi2503w3X2VOfZe
         rEF1HWgIccKDMJ0XX6lL5T9IsNwNfnV5TFQDNwsGLbKfYYTHUV4anFpgCByrmVz8nbLm
         Hkyy4PPd+Gt73JtFbhaHhzQfUZnuRintW/baCQ/drcwBu0zJV4IcSRIoMpqHqHhCPdXV
         /MloBZMSs3yAIfiJonwN7vLEjKTlxfRAbnJlax7890Coaq6f6vm1MrU2+EniJxZ7yDnk
         X2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118562; x=1793723362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lmNt8UHMJZ1LwZOmio/ru6CKGlng7+kmKVOojz71M+A=;
        b=FozZJ0n2GKSh9adXSpmksGz1HVl0LgNYwCjuwYli6IUNVT3rDG9kOQRsMrVrlQgR6P
         GPoZ43ozJHwQ2dzm6doRfgUahWk70PeUEv0k5pK+vYq89sKlKugA10JHkuWPvc94WHGL
         faWpRSxSsCT04w6N9r0nhmvgYDQVgNP3YHkT8MvqsY9yWIx5hXNJ7p+PkBknVVU1sT5e
         7w8GFJ6dyvhCDqJ2bxnUfShwUTr11n99I5X2eYPUsGN3AiQxiWKkvG0bI0nPUg4bvHf6
         UYe5XfkqYSmes4pECaKee7LWRbvkNihnXltbips7hhwJOiupC1q/sjiptcSdTxcYu/LU
         VR8Q==
X-Gm-Message-State: AFq9FYKJ/yU725WQeSugDwF0KK07R0eW42Ph+OTdg3Cgk8YIZO4T7SP1
	Ri24mRIoUbJ2LXd7Q0DgZPvbSzncCYSahD4R/TXsTdPiYLiDRKcwMfG3SoDpX7Ut0lQJKY1vx1m
	ibKs1
X-Gm-Gg: AYBFou12C9FkMJaMv7SXbRlNm1YP81vMIZx3XdlT/GldlDMsvQg1zcD+5ntMnoSAthr
	DhWnq9+MelB4vIcKgnnuLOaNqaXRy44DsjljahCvDl177e/iEcvvE2+HJlckca2lDESCIav59u/
	Lysf0CSqb5wQy1GMcn9/NwNRBb6ptSTB9mZUIgr9te5vLurCmvLkcRIwu0LYoyceyJVjRP9NOUZ
	P0uMBG9PH1STtb8nxSeo7eAe8ylP2lRKeunwmRoQz1crNZ3LdLgafPhRX2twIqUdb0eblwoJ9eQ
	aN3Wk09zxp7OILAexra1qz5Db4n6RnFn7eXTB/OU0ifxXmgfq4ui7Sdp8U6JIXyM8c7ZZ/qd8PS
	WuK7gh0+UiES6k+ZS1VGQQhRw6xJy5TPXHN4QsuqLVLX9FFsiNW6JRiNCTg+ywK62RvxCPaRuIv
	YVGsWd9hm0ZC8OWDij9peNpisv6sI/XUjbbtZgAhjz8v2lRp0ttdHR14hIf4BltnQhEFVchEswK
	EAZqimbJJ8klRFqH+y9tjtUhFpm5lUcDSt0Qyj5oQW604EjO0V9dTg0fUYfVygw1kkS/buEhNmz
	H5lpXMkU5Q4Q/n+ZYw==
X-Received: by 2002:a17:90b:2789:b0:3a7:d2b5:2e99 with SMTP id 98e67ed59e1d1-3adea9d6f7dmr7568463a91.20.1793118561909;
        Tue, 27 Oct 2026 09:29:21 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb75254sm7288854a91.4.2026.10.27.09.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:29:21 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 2/4] selftests/bpf: libarena: make allocator growth on alloc failure optional
Date: Tue, 27 Oct 2026 16:29:14 +0000
Message-ID: <20261027162916.10996-3-emil@etsalapatis.com>
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

