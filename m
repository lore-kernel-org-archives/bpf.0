Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129065;
	b=xe1XcLGSlzLBOLHMuGcx7hg3sI4FCWVTe2o9rAsv+jdVRmWhvjy5nLXkLbAURuKssyHk
	 kNdHUDXmtGc8ABMAQPp7CB89527fWtHCPHz7ARUeq3DIYR7Jn/n5dsNauglS+eKfAN+lI
	 9IUxBeqqt6op63KByCJXbE5gq9BnuJp4qdQbzMNrRfNBGnoiFu0WUSOYLkZc4aDSkFhza
	 QyKSzgTgIRhFAbqA19ynY50s+BlR4AJdScPyHtJ8wrxR3ZeAebpHpH6Dp73AhbQh13TCy
	 89D7/CjwzYkvXsP/wyGVbZeL/2M6mSX+OWUPbRsVAqazB8T0kJZ6EO5OoLC8XhHTVVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=naiD4iesaV5pH7Y3WTVOwbtKuOOtNqwIdyHwaDd61M0=;
	b=nTsYBk5gSz6YxIu3y+ykrA5ogDPkCSlKWg1CExjqX4AwouQ1pKOyGYf2bk5n7jmqPfWL
	 QGcp6IaoEEBkZCS3qneWr1shKNE12oLyowWYlul+mJ2T+GjiU+BK9dj/I1MW7JtziVeA1
	 yJLBqxfTqr2SqmT7CYP1g/jv+kni/kmHNtL4fzUXZAQjOKjIXqGVIDSpyVpXJi/NFlRuO
	 L7bNiAhOnFcCmZ19O7NCaaKucXc3gY6crpGQoGG8eRlCYw5tES1cfw3U4fdVt7qSX4joP
	 BVpYbaCiEDAvWyUbbTo8Vk9t2Q4oDOuEyRwLuh/HzO517J/laEwqJe1ktcUFRJxeobw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=NtFZSfMV;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC466606A31D
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC466606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=NtFZSfMV
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a214af2076so2029685e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793129063; x=1793733863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=naiD4iesaV5pH7Y3WTVOwbtKuOOtNqwIdyHwaDd61M0=;
        b=NtFZSfMVupjp/ncL2LlulPmDsbLKRtwI5J0yj+1FzsxtSMscly14XlKmbe0pnJIrrG
         90Sk70sqgZKXN85UO3hbWQheWHq6T1R/feMYLPf49pHshOjz2qbgw4T3rYiWN1168Jm1
         FEx5aQfXViBRdDuRKHPBKBgRGsgmerBfhnfQ0qXRlHqUZTUPYaSWvOlU8XeziQ1QGiUQ
         1CCacOdvkAkYjYMMCpeOOMOjEbDHFjXVfZq3JiX6V7Eip0V4we+QuoDqg/jzUlCeoJpA
         ao5/pwX7N8vaJuM3LQnnnpOXtmkVkOTmvOBusGoUR7KBySR3ql9NrFYoCM/JwaUkRG7B
         ihwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129063; x=1793733863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=naiD4iesaV5pH7Y3WTVOwbtKuOOtNqwIdyHwaDd61M0=;
        b=0NEFv0f0Z7N5Q52fQqboc11ZUZgYOj07A4PU1VLdenB0rOn619zfU1JVieDFzKLUAb
         PjxRAsHJiLJGLHYQ9Gei8LGvFrT8hHuI9VKiCis4yIueF2oA6xWWywE+G9MX4CmtpL3K
         cuYDMidtvQ9jIE2dnvrteZLXXpzoNSw/YYo6AxCE3uZ8+mnKibHlLC7gj8vXU/NLByN6
         GHHGrGoJeExGjZliUO7cD3he9vrmlHRZmcNaENcEyEKFPyIEGzBuCRJ5WKvIHroG5leW
         0KJsGGJJnWBYOK3fcSUBZZwtQaHioF8c2YjWIYNNJn8pGmkZLo2lLypZGsx1ygnSFt0k
         wcYQ==
X-Gm-Message-State: AFq9FYIBUbrCC70mVGglj+p0slw0JljL5gmOgJVG33mNyKXvsHNJHmNq
	53xk/ibMdFH1legG19hVLsJ+9Fr7od8aURFJGtT3AUaip3IP7rw3o2wWT9erEEPWeq4guKJ4Ttm
	6i/1DLj8bPg==
X-Gm-Gg: AYBFou3Oojnb8yHQV3YcxbI6K08elSXb4Q7xVhUmMCC/Wf27vy+nKDIprplnMnK9e49
	ork80E/wJgGUQ0Zkx/d6zSOjcdsK3RkcNRavJI8mER4ernPeY4wKYIdYvPljJWsC3bPtXo0jDmF
	lVv68jAxiQZFzh7eB6awKntHUyPKX86oz62pSsDJj7GqRgFfl8p0jacWZkVkT+mWkkfVH+oP5Dl
	IBG6aElJFd+qUkLpyk8OL/UZ3jNf0iuN2jIbvXN3fTtIvBnWGPfMsl5c4mD7UkOuFMflc9a/SUy
	m0y887YXncrTupT2dcLaw2xqsw+ennxow73cf1uro3BW0GYBprEEJcIL+H68wpUvMtJc5ofntWP
	QQ+MmDElZ6h9nQa5SY6FrJHZ6KEYiYKRr0rBuwbAXGPp+si/c/N6vJVvjAwuCIUWpegk4VEjVbe
	pSK6uI0WDdOh599QqtYA/yEpGhepdcmrzehaOXlyAPR2UJum3v6dFw8fmaoO/1dAj96qHzWEs72
	CzeoZFFunV4PWIv3bEviJbuLTSZD7JhLMpaefm+up836QQMVqMWax5m0w/EfQosnA==
X-Received: by 2002:a05:600c:3e10:b0:4a1:80d8:aed5 with SMTP id 5b1f17b1804b1-4a35ac8bc6amr207094115e9.6.1793129063018;
        Tue, 27 Oct 2026 12:24:23 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2eb1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92e103d91sm4721385e9.0.2026.10.27.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:24:22 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 1/4] libarena: remove in-code licenses
Date: Tue, 27 Oct 2026 19:24:10 +0000
Message-ID: <20261027192413.5038-2-emil@etsalapatis.com>
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

The libarena code currently specifies a license section in multiple
locations. These sections are a) inaccurate, since the license is
actually Dual BSD/GPL, not pure GPL, and b) superfluous, since the
files already have the license on them and libarena is distributed
as a source. Remove the license strings: The code that includes the
the libarena sources should be the one with the license section.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c | 2 ++
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c            | 2 --
 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c           | 2 --
 tools/testing/selftests/bpf/libarena/src/common.bpf.c          | 2 --
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c b/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
index e06397dc9a40..636178f1fa6a 100644
--- a/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/benchs/bench_malloc.bpf.c
@@ -49,3 +49,5 @@ int bench_calloc(void)
 	__sync_add_and_fetch(&bench_hits, i);
 	return 0;
 }
+
+char _license[] SEC("license") = "Dual BSD/GPL";
diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
index de656b69d13a..8a0f06110606 100644
--- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -532,5 +532,3 @@ __weak __noasan int asan_init(struct asan_init_args *args)
 #pragma clang attribute pop
 
 #endif /* BPF_ARENA_ASAN */
-
-__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 2490ab1396de..552ce87875e3 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -899,5 +899,3 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 
 	return ret;
 }
-
-__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index d1af60b81838..d859bd538c52 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -85,5 +85,3 @@ __weak void arena_free(void __arena *ptr)
 {
 	buddy_free(&buddy, ptr);
 }
-
-char _license[] SEC("license") = "GPL";
-- 
2.52.0

