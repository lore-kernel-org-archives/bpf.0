Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129073;
	b=SDaTTgwUnp4CEFsHfpto7luXzh7A4BHyErihyc5RH7b6gQtMW4jekwSHDC+OvKwh0xon
	 U5WV+8aP+JRMTVX+GuYxrMnHqSWZPp39DOcSito1RIJqWzmXzc1aw2x23X187fPHkVL/M
	 1E3QK3Z+9Te8wpN97Pthn/eVrG8BEZiVLn+NtcKUWWF2Dsek/WTnhe5mMKB3VkGzWwaVf
	 z08HFejXzJwDB4ESai0Pt3jWMmaSxIANOAWTNO0FY+387H/BVAPKFDFV1ZNtVC3KaQLZw
	 JZA/5dWouUSLPXMG7DLmhLu0mR6dDCET9BpP4Y2XYqp3d97sgSXUNEG4WyaVVF1dO2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dxcXCNo+EN7f+kfs6bWcfzAqNhLfnjukyECI0v209bc=;
	b=agfdm7/dCgE8Ybn5HVf31lDs+BTfQeShnTaSO9FInePmJnAibCDeTwt2TeN40Dxyi2yg
	 Mr+N7/PNamhtew4GEQwedIlhMrma1kzNL7pntxE7z683q9AhXnLd2k/O2jVbveO5N6nRw
	 hMi+19wCnyvSlUAXqANqk/JRj5Pgmqp+7GXbvFmYizMN3AaQm6ksomp598JoVQ2ObuXjc
	 IvjXMTDgS7+4+5yljBOiwHhOezHcy8k0llbU9RleQM7n38btoFt8oK/FBInZ/iojUqiNC
	 /OMaK6C2REeL9grKT9afA63jJRd3K71DfZ6lUZ/iL1BlDiHPHjhv/o5aNlwNfUMd/zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=vtnAo6mW;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F3606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A4F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=vtnAo6mW
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so1826395e9.2
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793129072; x=1793733872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxcXCNo+EN7f+kfs6bWcfzAqNhLfnjukyECI0v209bc=;
        b=vtnAo6mWSTFcX5YZ+IcCuYPbU9IxPsUaVXlqqafEXH/bgGxD4W7SYCppGG/BEZZh2+
         QgDO+vgNlVFDu9gvqzXGX9elHWiUPMN4GivTI8I8FpdKQtWixEzumn99LQLa7i9Icyp6
         a5jUKgoCHlQSM/b310LdDYUoqucMl5yA6zTlz+3qQMj1OwRTkt1WzorSePCnvZUz2Ur0
         vyhcxjzmCpbouEKepS5XHlfojicv5Utq9Gl+hIORYD9MGwwmnKG2AsBNnMnxUfayAUcF
         O9VKYlIASjO8YQmbgaRbSadCQJQh0jqJE9TbXVAAw2yuXCfUXiYcST28fl1GBFQoUjXj
         M8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129072; x=1793733872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dxcXCNo+EN7f+kfs6bWcfzAqNhLfnjukyECI0v209bc=;
        b=oGbDpgIQ9Yg01QeCG+r4LIeltgT1jonqlKY+I062A3hIy0sL6FI9W2VivFuF/jbIMq
         7EkZ4tXWvFmdRLLJM+luYMux4IJkD/5Qg97Qy34mE13N7W6enqaEo9qxmvCQdX5wwl7m
         29alE9HTdTRL2XkbItUrTr2YT1crfJ5Ueds0AEKf8G4L3JNBA0DoIiPoe/hr19XXWqrR
         uU8OtNKpvVjullT1hOH9meFkektcDvWfaf/tNw3odPQ9FRKpo5MsrDkGSwg++SfO4KU+
         khULf69zaBlcJLNNbGxdCouwX7QdDS4lkeZQZ4FNOFrpp84EW0dTpUnU4EAt5DIuAQ2F
         Qz2Q==
X-Gm-Message-State: AFq9FYIjVV/R6+Iuk8iMFsNxrHCoR94Kf1bb5gmHXKOYOE4G8FEN+prT
	z7pjyJLA+YuCZHxHC2Xc+K6cStA5YHCIkOgwxtI0YFefcjNIiTUvzyffMPs8bPXXetQ0FATkJGp
	zXPJkTGo8DQ==
X-Gm-Gg: AYBFou1i8Srgc/nVP3fzf0TXNsxOf++3O53adeeVNUK1X4kJ9m8EcRPzupFGwnDfEY2
	qaosWipesUxUvSuAWK5NP51Mpj7BrsB4Tw3+7vFa0He8dYFZ8DuzB0O8kiPRVZaTd5jg5svcTxP
	XI8ehqL7Th085WJQKvlCaEAJ5nzzdHew62TwaTI909XK+IApwRdrq+1vfoCahyce28ir7sD42jI
	bwNDyxnmKyCL+3f7dLEQvh1ux6zxABRS3UTIVAogUWLMrTVkf92xVUyVien571zbHJDHliAZGFF
	1KgdONZAPXONKrvv6yiKoh55j+1XglqRUBZVPOGHd9uVBKf6uFrI3di8CR3+MNlwWHyFg8HlLiS
	3jFvksj9M8upy1a18SRRRH3WCeE7LaDPrsxFFKxfktSqKqwWZtzJt5WoMstG7wMjPm0apzqOFPl
	b1n5fqIhhsBKB8VjZsHDWROBSuqPb9kOFdUH7F3GRlj2msBUugYfhXQjFepgOzRxcjySsulJLy7
	Ou1AIUhXUj4gxttme5HXF6xKkw7iQefjjNeGvgpRrBb
X-Received: by 2002:a05:600c:8591:b0:4a5:26b8:4507 with SMTP id 5b1f17b1804b1-4a526b84dc3mr125885655e9.21.1793129071777;
        Tue, 27 Oct 2026 12:24:31 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2eb1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92e103d91sm4721385e9.0.2026.10.27.12.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:24:30 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: libarena: add explicit buddy_grow() call
Date: Tue, 27 Oct 2026 19:24:12 +0000
Message-ID: <20261027192413.5038-4-emil@etsalapatis.com>
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

Add an API call for explicitly growing the arena through
page allocation. Useful for programs that do not do so
implicitly through buddy_alloc().

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  1 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 958450fc5f9d..90674ac077df 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -78,5 +78,6 @@ int buddy_destroy(struct buddy __arena *buddy);
 int buddy_free(struct buddy __arena *buddy, void __arena *free);
 void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size);
 void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size);
+int buddy_grow(struct buddy __arena *buddy, size_t nr_chunks);
 
 #endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index ed359d4af1f4..d12c8924a0ad 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -812,6 +812,32 @@ void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size)
 	return buddy_alloc_maygrow(buddy, size, false);
 }
 
+__weak
+int buddy_grow(struct buddy __arena *buddy, size_t nr_chunks)
+{
+	struct buddy_chunk __arena *chunk;
+	unsigned long flags;
+	size_t chunk_index;
+
+	for (chunk_index = zero; chunk_index < nr_chunks && can_loop; chunk_index++) {
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

