Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794801345;
	b=wl6hu94ntl12vImqeQJJZLqSboJ10OTt8GWoOnjefxYxn8mYcexTx7+/C2ddKxuUKv9A
	 Db3S/CzBzytWGGTL4TEpLl8nthEY7orhZazhActAe0BtRhdpftZDt8i93YaYiOsx6Dofw
	 vkPYfF7I/KOnTBVIlH5zChWYGHWiVYtaWKzvZBjIfw0FvDRQ2t2xgZq4+nC4TOKc0R6H+
	 sOwJ64b2t+wtsY9BQSCtVMtZY1hkLTQjFldEKDUCSxKL1LeWCrqxq6RloJ+Cik2Y/iYaO
	 ShY2xSjj729YQ4gc7ztcR93t25Q6L6qqwuCyIWiSsOy3F0MyYNF5mFeYsTit33qrvqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lPLYXRtdUzVxRMFi5L98tPD8dNCrei+9JW0B4GyCjnE=;
	b=kN9sodn6g29IwKPUM3dSQe0+n8juInEWp9pUUYgk+pCbYNGgSAi8ySfowxqZQFBemGz2
	 FpgfOLa3ZGhNFFKII7Jusm4IHAIgIMb6bEC8XxZzDxfZHuvgQFvD6XcsE8XZUNcXjWTMD
	 aoV+/DXhRFQr6e2++a/XjfPMdv6sHjRMU6HYJ0AJnHhgm2NSRmSfliEpyGykvlviURbKN
	 YcmqbOLnhF1UF8cSN0kTfy40sVYPXPbhLDBez2t27+9iDtzXhOy9EbyOpmwIVuQsHOc5e
	 ZtYDFCsjqGw+swZakTPB4pCAZ3nd/nKUbQzACLIuYKjtIOKXddaIZHq2Y4ydw7Ezc7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=XloESbbi;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E03606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 03:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49E03606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=XloESbbi
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so1098978b3a.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 19:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794801344; x=1795406144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPLYXRtdUzVxRMFi5L98tPD8dNCrei+9JW0B4GyCjnE=;
        b=XloESbbiyA1sWYOnXj9ixs/llQ3B2Q/8hWm/wMQfm1gIt/oHhCgMeNqwamBFahNkuD
         ie8M3VAhhEt6lAuEXjud0jC6LUzy2WxQcydWAKcMc9ke3uvuYeWMM4FKTWCQxBIOAyjS
         qFVhBzDreZ/94uY0+yEvRePqAA6B0as4NQdMW10xFCFdSQ8JHzDrdEzlg4HL6QGDYYz1
         nzB0tY763kk5SoTfgqnMqwIA07FwlnHLmImsYXgfZ3yHGMltZcagXJWrXAXyilJnoRTO
         KtW70orQI+PM+JOghTMbLHtu0CxKiT0mYWDjWYZEfjl6psGngfmDhR5gnNqaUx5veNFK
         K6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794801344; x=1795406144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPLYXRtdUzVxRMFi5L98tPD8dNCrei+9JW0B4GyCjnE=;
        b=t/m7UuKY8cYijKHksn3aZZKPkR5iB08Qq8U+FFvUS3yPTmWHibO5cbhsvh9uCE12QD
         iTSsbGajBBHLfVbhDi4KcVgRjwBwmC8wK81dsQvU7qG4siZpaa9rCo1t1k12IqGbxvV+
         HrW8VsWzvj7jBFp3nrvj+4KqY5IVSJPAMdMv1Gh7fPJKpBQ10pep5whWrPTnvbFCtyvC
         8UtCGK4r8aukzP2HMV/MrUxPf9BAYh86BxAaDjrnjNXX9zkRx9/+VDugXXWvbV3HzSQA
         5b8+kwgIuqcT70egV2f/jLlSFLuZVPHaUHjVMbnxrOHOIacaWqjqh02/3KtO9+scfBwl
         CVBw==
X-Forwarded-Encrypted: i=1; AL+hErGUSEETb9CNS8792rf1JaKJIl0ID+tGyOJasAr7zbAXV/a3muP4Nmhslr77heKSSXGeNmw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Brsx0lu2fOITnNjXe1RtycyYMF6c7PEUjEk383ruRQCH41ecQ
	x+DwXindYEOdpBGQSZ0wrlPTd3wa+xnkRzA3xbMmkYs9uoyVUOxa60ws0maQKyVaZIer
X-Gm-Gg: AYBFou2YfdPuk9a+5dd4iBcJHQKEltgxloSrlcTyQuZf0YO2kyLp2EebdduoCDy1qS5
	aQa/EBk/Ml18Z8E1LwDq5zr/BNjHCqkiUoHZt1DDsShB9zzJlfy54Rnkr3I/V3x3ET6QobFZ1In
	mOFM4Ya2b0ApPTjEBVs7HMj1XnBfz02ygv1AAoYGShm01A3CpH2oBKqQCXRUYHFgi/64EwgrE20
	aZ5wt7v/TPNEoGVElxbJ8bISH8ddiPccPfsZTa7s/K0DQu8p+TBKjtBvtEmBlRzdgrj8onWVZP0
	9ad91jOFrZ+arGYGlK8wuQHH4ZHJ9Onz09JqQkAlue1xhjErS+S8UAQ4/ARVpMdRJkiNCerdIVO
	5lLdutZh6iWdxUQ8RdyMQA4ammxO6iiDGPUd9TyO28lmNyRPQwSx2EkF1ZzVrC6hiQDSCDfhFgx
	H2Xlqt2iWKH3kDTmwrrMxYPIdNBe9+KHmKSl7ydeAS+ta2YjwchTxiM+uZfpVv25FVS2tyFK+ap
	PRujhsi7bG8dDfi/km0CcMFYeny1E1UNUb08ZUXsycGTkOmc9DZAoJdieWsk66vwmzDbAXdXbup
	6b1mrjSHt7HD7MHUgNgUCn8aaLwxyIsaep7WaIJMg5vd3EZDqBDwPKcGMfRmobjKiwQekxuSbYY
	OgA4zOZbqolfEU7bNRv0m
X-Received: by 2002:a05:6a21:7187:b0:3fb:5fb2:a4f7 with SMTP id adf61e73a8af0-3fb5fb2aa96mr1341727637.34.1794801344555;
        Sun, 15 Nov 2026 19:55:44 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc1886b12sm3463176a12.11.2026.11.15.19.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:55:44 -0800 (PST)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	benh@amazon.com,
	kuniyu@google.com,
	shuah@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 1/2] udp: fix reuseport rescore fallback
Date: Mon, 16 Nov 2026 03:55:32 +0000
Message-ID: <8c46325c4a433f02fdc7241c0c3884126cb502af.1794759652.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1794759652.git.zihanx@nebusec.ai>
References: <cover.1794759652.git.zihanx@nebusec.ai>
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

When a reuseport group contains connected sockets, UDP lookup rescored the
socket selected by the reuseport program. If that socket did not match the
packet, lookup retained the stale selection while continuing the scan. This
could deliver a packet to a socket connected to a different peer.

Restore the candidate that established the current score when the rescored
socket is not a better match. Keep the selected socket only when its score
is higher, and apply the same logic to IPv4 and IPv6 lookups.

Fixes: efc6b6f6c311 ("udp: Improve load balancing for SO_REUSEPORT.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/net/ipv6/udp.c||udp6_lib_lookup2||socket-hijack||m7q
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv4/udp.c | 11 ++++++++---
 net/ipv6/udp.c | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2e5562f353f8..23a8c951559c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -475,12 +475,17 @@ static struct sock *udp4_lib_lookup2(const struct net *net,
 rescore:
 		score = compute_score(need_rescore ? result : sk, net, saddr,
 				      sport, daddr, hnum, dif, sdif);
+		if (need_rescore) {
+			if (score > badness)
+				badness = score;
+			else
+				result = sk;
+			continue;
+		}
+
 		if (score > badness) {
 			badness = score;
 
-			if (need_rescore)
-				continue;
-
 			if (sk->sk_state == TCP_ESTABLISHED) {
 				result = sk;
 				continue;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 9dcefa162522..c5adeaaf5b42 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -234,12 +234,17 @@ static struct sock *udp6_lib_lookup2(const struct net *net,
 rescore:
 		score = compute_score(need_rescore ? result : sk, net, saddr,
 				      sport, daddr, hnum, dif, sdif);
+		if (need_rescore) {
+			if (score > badness)
+				badness = score;
+			else
+				result = sk;
+			continue;
+		}
+
 		if (score > badness) {
 			badness = score;
 
-			if (need_rescore)
-				continue;
-
 			if (sk->sk_state == TCP_ESTABLISHED) {
 				result = sk;
 				continue;
-- 
2.43.0

