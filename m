Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31A49BD82
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102779; cv=none; b=liRyXuGO4h+Fe1oMDTI96YHWMj/hZhtrYWRIjDJUubkeXO4Xg14l/53sUeZoMeRkaF7n3y8sftUYudjwosB9hsCcskkxpkwRzHeYTk+kpvuMmyr7t213OXrYjU1hFhM29WKO0rQoi+lPc8HhaNYrRe9s36ICm9/MPZaN5ArNGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102779; c=relaxed/simple;
	bh=IuMpNgCx/wsRt/giACaxjy53WAUkwMR2mJuQ09sqhYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ffatXud48HVinfcbMeATc6+oXWUTMoIA1YMY0LwGk6TIWcT4dSTHrCRXj0c1Wkl/wtHQ8V1+Hxlzon13FdFOoj9+79cBejr2V/1MaeEzyzZ0QG2zdtqmR4PJt3xk6fnv/WTm8UhVme1ngrvAUns0pqu3nB3Lfwr+vn4yEYI1nMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scCWnbb0; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scCWnbb0"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2c0356so157461b6e.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790102769; x=1790707569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvBW23f2UuBKO8svIifjsjiemFC1LwQ9bznHBbhEXQs=;
        b=scCWnbb0xhmsAtCfiaPQQ/PnR491Vl9Mgp36n3EjZOAeN9cpUrfc6YlI267aUQCQ+h
         Ycdr4njzS5rjrgnwDOVR2u8jSHx37FCQKlvJwxrwQgMqxjsbEuUsoAeFZDG3MY225Yhh
         ePDF3gnibux7M5Yz8RM77vJJ5iNtUA6AQs3OtCPKLlxZXqz5nmWyfYo+TlTyvUx24bZm
         PyWcj0GMGeogWSYhj4XvUumq5wkHOk9RhXGT/ctW1YMeEZEJDly5TqHf4U8o8KR4ytxG
         L1I9c4pt/BvCTUhWeA9qeIc7M3m0aQYq1X7vM3eR/FxIxkOLZgauIrDm+DOdLQ4IY4cW
         PDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790102769; x=1790707569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hvBW23f2UuBKO8svIifjsjiemFC1LwQ9bznHBbhEXQs=;
        b=KApdc+Zal2W18RqfM4rj9EMix2Af8bNZdnGEc01watJ1b6phobC5gfmViXWrnMHnOS
         NcmnAmLZnw0jG+9w/sS/RV2EokHYsIXrTUrN4KSu7q5jNshXawinL6zNGZX5ei/V0nbd
         1XAXKVzD1cM++sdV/YrHLn4p7JYuHgrGlfzLa6MAhbFzPpZuJlDQSqqha8BF0MVlqB8J
         t4yXoETdC+WdciPOCyyJkadGG/ZIQTWWuvdBJP0NdTAACsfHWOmdnaAVoNr83Y95ZpEE
         LY79Z+CsV55bI1aETRvE5GfC67Tlhx9NiaChIXdwQGQVXkhN+alUXU5q/dLJy7+EgzWG
         SSfQ==
X-Forwarded-Encrypted: i=1; AKwUvByWYJ7tnDT90pXZkHM+k8+GN9y4/BeI/Y89+eljimyLe2CfhpRJZfuxogziE+U3Z0iHBR0=@vger.kernel.org
X-Gm-Message-State: AFuF++n8hgylmQHUDa5UO8r0fEXzVNFFYDx+kG4XamobeqaeLEpAZWn4
	tHZI0m+5N+as1kOfghtti+WP+Z/gMoAaY3szHg53lX5zSo7oCvNq/KZQ
X-Gm-Gg: AYBFou22dUnsL+MA1+qpqyQoq+9cUjuycyQIdX+UW2rOj9nY4h7Zqb8Ho8V4J/UfBy/
	D6SdFJpsAEkkuCeJWsD458mDOUNApEdMiQikU5LPUkoFV9kMTsAhl3stB1clADTkS7nh0VZmHnS
	JcA5rHJ4fxq87f1jxj7lZ2NiUZuascXY+bPaXPGcPPshW40dFsnaq1PgT5S/w3H/RDMqCevxSEU
	Sac/MqqtbUwTxmBmOhPpGkYLvajBLS+3x79xNw7TpJ+p4vNc7DYFD8SG8arJQRcgyxlHY9FOY5k
	+P+chvIZgpeOiEbd1gJb2v5pXPkLmCgWtynAXr1TFGaAIKQRu5N7yzDsCzVUnjJU5nr4YbPfs0T
	XH4qe1npzQprqGU2IPgAR0z8liGL6z8CEX5i2Ul875Qky+QaZyrZ4+rilkwQdsPfyzeBqLC/wfW
	Et6kEVXkfc3DW/yLddpJQZwHDPY8P7iiWe7QFSwLJUCOlnQxwHb9KJnlDTYDDRRb1rRJ4AruFFx
	DL3nqPCyg3YcPF5Y0fgP88V4N7oYht7qYVqRjmYT6D5Se/MOyuMUWqeC5MktEt66dbvpvkl+GKN
	8VY6eSi64rPubYShUcuJHbEJ8AMWmMk=
X-Received: by 2002:a05:6808:14d1:b0:4b9:e65b:8c33 with SMTP id 5614622812f47-4d5b8cd7d75mr333208b6e.33.1790102768645;
        Tue, 22 Sep 2026 11:46:08 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4d5c43a24bbsm147545b6e.7.2026.09.22.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:46:08 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 22 Sep 2026 12:45:58 -0600
Subject: [PATCH v3 4/4] kallsyms: Unroll 24-bit sequence reconstruction in
 get_symbol_seq()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ksyms-tune-v3-4-681a34ea05d9@gmail.com>
References: <20260922-ksyms-tune-v3-0-681a34ea05d9@gmail.com>
In-Reply-To: <20260922-ksyms-tune-v3-0-681a34ea05d9@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790102761; l=1647;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=IuMpNgCx/wsRt/giACaxjy53WAUkwMR2mJuQ09sqhYU=;
 b=yS/yGjzOac4hLV4AjSFZ5EelcHRPIABxP3zNa55tRBvDMQ9hjwXNYUKY/aAcVbDC1o5X/qkv+
 VdoviOApkczAe37evfvRkm/lYAf+lj76e/eHBTzZCKBe70sD1vYOqhi
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

kallsyms_seqs_of_names[] stores 3-byte big-endian sequence indices that
map alphabetical symbol positions to address-ordered symbol records.
Currently, get_symbol_seq() reconstructs each 24-bit integer using a
3-iteration for-loop that shifts and bitwise-ORs each byte sequentially.
During binary search in kallsyms_lookup_names() and duplicate boundary
scans, this loop introduces branch and loop overhead on the hot lookup
path.

Mark get_symbol_seq() as static inline and unroll the 3-byte extraction
into direct byte shifts: (p[0] << 16) | (p[1] << 8) | p[2]. This
eliminates loop induction variable maintenance and allows the compiler
to generate direct loads and constant shifts.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
Changes in v3:
- Added as a standalone micro-optimization patch (addresses David
  Laight review).
---
 kernel/kallsyms.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 06c79ad70cfd..8f76403e0e7b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -281,14 +281,11 @@ unsigned long kallsyms_sym_address(int idx)
 	return (unsigned long)offset_to_ptr(kallsyms_offsets + idx);
 }
 
-static unsigned int get_symbol_seq(int index)
+static inline unsigned int get_symbol_seq(int index)
 {
-	unsigned int i, seq = 0;
+	const u8 *p = &kallsyms_seqs_of_names[3 * index];
 
-	for (i = 0; i < 3; i++)
-		seq = (seq << 8) | kallsyms_seqs_of_names[3 * index + i];
-
-	return seq;
+	return (p[0] << 16) | (p[1] << 8) | p[2];
 }
 
 static int kallsyms_lookup_names(const char *name,

-- 
2.55.0

