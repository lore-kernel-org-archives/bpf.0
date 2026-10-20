Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792540036;
	b=zLZ2+dUWgCOMGixYdRw+wRlxcSWzIpHvt3efC96hdbzaNeIebjUVJzdwXiCA4TbuvwfC
	 TlLAvGM/2on0n3P68SfCDYDCNwShP1AKoiOaXGlXZspO/6cKqrEzb1GbA0FnbpUWV26ht
	 5Pr444FsX6khX+T+/wYsaHumIgaGhxWgU/naK5ZnrHhJpijlFlJzfZ01ou8+Lxj+oQ7DA
	 qwgHSUHISO2oJ5N97BlwLJCqYffmeIjibqvnBpy4m/fjGY4H8ZSuVUkkjvi4bckej3unB
	 vz6B1inj/ZlHhagHmbwf92ZyCjeOc6WjDwWV/TnQPQZ/DTcKoUDrPfYg0eoq95/Zu1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792540036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KnHZNWqb00JGhgrEZBKfPufFpsb8GJ0yM4PaYKBtjRg=;
	b=CwrlZU6Ad53deT7iMmLfpTStuU1A0qFByTBoK+6GU+9pcYnaoH55w7kkmqEg+wESTLGX
	 KBLl0LNCdj//EeUbcMpZUILrq/N0dVHRB77cdXywN3SLyGI841chJh38AFoxXAxS4Ol0W
	 ES90c/89thJolMy32XBcLqhCj9TcYIJ65j4GRlvLezQxDsivsw0l/GMPQGKwc1FykkjGv
	 QWHsMvb0se/J36ozfI9jaOd4Z3merMs/JBvpKiq3cArKnoJieIiXUSHc9XfBpRMfXK5Al
	 tufsf487JNw+R0HT4zLBDyzqzk+li2eHVSOiWwNyAu+yaFq6yx8f/iMA4/bpMY8Zv/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmdz26rO;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062C606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 23:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B062C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmdz26rO
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3514b90bb89so274446eec.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792540035; x=1793144835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnHZNWqb00JGhgrEZBKfPufFpsb8GJ0yM4PaYKBtjRg=;
        b=jmdz26rOoQM6PqBa/sBB+kHc+fEkaOhBsqw/bSMkCnvowaAEXrTTf0xs+iOnY+Z6Y6
         +iBAWlyq56S6jdWoyNeY/WwEZB8HMW3gQHlUMa0Olzs7T9LWTCMmR3ICuUtnCVCJcFPt
         EqGaINUzvYdrkDBJMqj40iXBeC/p39rOhzxgdu3hNuf0ID089Jkpqng+7akeDNqV+Ldx
         VKSvoJnDwXN7q4zkrm71B3SP+souKeY4J5jJZ9ljFzjFqrVvn+OeVkvqbxmjHV/ufaXc
         /rdqo9np4oLz4+cI9wxpmF3LoRD8ONIRG8W7K7XOl3ta3D2NLUgTc+HEEwE6EEy+SPFT
         IkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792540035; x=1793144835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnHZNWqb00JGhgrEZBKfPufFpsb8GJ0yM4PaYKBtjRg=;
        b=W8NAOwK56AhFSU5TdMGsXMaqqXNIjnFdt4H4gJ6LHSEBZvJTULF2W6S1qq9jHiBXKK
         SZuscTXK/YWTzq4WIPo6mqVCV1vNT8ZrUwCDH1uD8kgu8tSgH14Sv3H9/fXpnmc26hx0
         1ihTsu4joqk96jeEYWhIHz3VEgIxEe5FpS/XkeNFPLTuEhwfXAgeBVh9bPBwGaPHWHn0
         u0fGmlqO6vE+TYltMdg9tSh88V/Q4ITarMyiI+togbIuGnk1n5Btt70jQCaZ8cwWjsZq
         DOm/1Y4Yaj9N05WCY/ZBe8CX/hkQ9EEFCrouthzufqVqewdS/17RIvS96rLUsN9hi2bI
         3Cog==
X-Gm-Message-State: AFq9FYL5BV4J2jHV5w+MWBifSgr2nK536a/0GDZVGnW3epnA3tvctGcI
	4aNUjwt6dzCxIMkSD1WWnqJG7xA19CG39IHdt5lJnaAPE5Mjr3soArCAdj7fK+sH
X-Gm-Gg: AYBFou2/T/40ydeUAWMX4ahxAd4nNKG8QsPZlirJHFYWjs6dTimSmtU2ILRorjDbKq4
	teTlX3qSKlbARB5tGwiIwDPGZykEnxmFkqEEuUpVOqlTYSh0j8Mj2HoLs+1Ns4z1c4GIP8aJNqA
	ITjfuKeDVWvIYnp0edOtjilEAgiy9/WTqvUHrVTgY8jc4+nN4osPlM45THEd6o+wl8+L8Qr116y
	vmZFUo5B4FvBa5M7S6nr1gvb2P9UGcqL7Jagw7wuIflXwhpe+QcUL8YV5o/g91Lo49N4XC6td3m
	3AMbFGJf42fBRSJN7L7Tjpz8p18G+l65QS81BVsjv1ok7QOyAf0dyT+qUmfdDaPaEXGfkg5CLsE
	2dihIFzYD0GcAX4b+X/v7/VvT1K2isMVwU+KrO7Szv3yAFihsAfmOl5FEdlGwp6ZyOzj3fNjKkF
	5XJZNDUNMYo4gz4qVFATbLZTPKIoLyfdVtOWe+SnDsNpTo3mvUjQTw67h6vuFO+2RQnOU34dj7f
	CyvqIfQGURWNAliKfRUbRWUE9yIZYtsD88aTM/FgZdobDzu8hzod1Y=
X-Received: by 2002:a05:7301:1624:b0:365:921:8ce with SMTP id 5a478bee46e88-3674db50acfmr840363eec.32.1792540034653;
        Tue, 20 Oct 2026 16:47:14 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::7:5753])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm2644619eec.24.2026.10.20.16.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:47:14 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: reject pointer operands for 32-bit recurrences/latches
Date: Tue, 20 Oct 2026 16:47:04 -0700
Message-ID: <20261020234705.375067-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Avoid inferring loop bounds for the following program shapes:

     32-bit latch          |    32-bit recurrence
  -------------------------+--------------------------
     r1 = ... pointer ...  |    r1 = ... pointer ...
     r2 = ... pointer ...  |    r2 = ... pointer ...
  l: r1 += 8               | l: w1 += 8
     ...                   |    ...
     if w1 < w2 goto l     |    if r1 < r2 goto l

Scalar bounds for pointers represent only offsets from their common
origin values. The 32-bit operations above also depend on the runtime
base address: the addresses can wrap at 32 bits without the tracked
offsets wrapping. Thus, offsets alone do not determine the
iteration count.

Fixes: df4761bd441c ("bpf: Support 32-bit linear scalar evolution")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/scev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index fea77772ca96..44916071c16b 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2024,7 +2024,8 @@ static void log_incompatible_scev_values(struct bpf_verifier_env *env, const cha
 }
 
 static bool scev_value_compatible(struct bpf_verifier_env *env, struct bpf_func_state *st,
-				  const struct scev_value *a, const struct scev_value *b)
+				  const struct scev_value *a, const struct scev_value *b,
+				  const struct linear_latch *latch)
 {
 	const struct bpf_reg_state *ra, *rb;
 
@@ -2035,7 +2036,7 @@ static bool scev_value_compatible(struct bpf_verifier_env *env, struct bpf_func_
 	}
 	ra = scev_reg_for_read(env, st, a->ptr_reg);
 	rb = scev_reg_for_read(env, st, b->ptr_reg);
-	if (ra && rb && bpf_same_memory_origin(ra, rb))
+	if (ra && rb && bpf_same_memory_origin(ra, rb) && !latch->zext32 && !latch->jmp32)
 		return true;
 
 incompatible:
@@ -2267,7 +2268,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		}
 		return false;
 	}
-	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
+	if (!scev_value_compatible(env, st, &initial_val, &bound_val, latch))
 		return false;
 
 	initial = initial_val.value;
-- 
2.56.0

