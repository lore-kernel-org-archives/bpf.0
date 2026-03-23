Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03281482E8
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 02:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774232337; cv=none; b=QdUrQQmuhVT47nNdqkuDbenrPwyT6jzcC0LN6PjvxRomwJO7JPHnx5YjX/mrQy2xXepUv8IERTV86v3LFRStPXnqAnvH9/yw+IQgoXbaRBMx7HiKMOYxUJb0TVoUSWldj9xzQ/mZk7sNxrDeHC63meo6v8GRLrwH+ZzHiC8MLe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774232337; c=relaxed/simple;
	bh=3F2YTwMiInpUo7vYiWA4QSWv+6x2KTNxHJOzazBbxiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALVT4IKo4dZ7A2TFqzPY57dVxs4iGoJIlHXCwWN+7CpM8IaHW62q3ZoTD850F9P9c1HzbISpnZiCK/aqBGDTdq016VQQAgis5V8POKf6wJDC6qf1msHDAqr3iAoWxDexhIWfDHIh/gJJreWdiLtjQBasFRSJ2/t40+Wc/Yg3lAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/xBYe0K; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/xBYe0K"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so2946554a91.1
        for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 19:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774232336; x=1774837136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ooe4HdAHw7dJGZq1UaghqqlXPLswv0YlfyU3aXugIk=;
        b=W/xBYe0KUceib4qjxEmSwQXKXJuAnWk+8WQZZR6ddsR+i0dcAX659+hJKoYV6a2Ltz
         DOGd2T+2L5udFqGL2Gd6UP1XPfHuBxMPfEpXWrPhpuzThP4wzpj4+W8URPGLWlotx+Qr
         YfKAfB+Q54Admiaqne4FibIj2+OHZ4HcyUUfNmzlnfDUt+tcJUXY3qMtlJLkiOR6UAZg
         scuhRjTKkFIZA+QGjfLOI7HbDEI4I0+YBf5Ia+CCQlYV+zqY/dq21lGe5rLyfIkwIcTV
         +G+1xUGjsYPKFpgKQnvjqVMTMM6rBW2Hlo4jJNl+bgfwwnl17R+ojz8b8t8XNT8tASFz
         Vr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774232336; x=1774837136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ooe4HdAHw7dJGZq1UaghqqlXPLswv0YlfyU3aXugIk=;
        b=TDYQz/rWENpJbpB3XoDWsBF68DMNhmT6gyJ0qwSAzhlswDp1YU+KOHfVUhvCkuxb4y
         bpgt3TGGTd2HyyX6xYdRMwJMtavevtSIvlQXOd1pWQuKWVZtijb2kAfS6FVKSUP8aX/N
         EEDbkY7XLpmWPmPV+iFDOv1U7zftj2ehl4yGR9KbejHYWHlhGM3kgWS4KgGs6EE4RnoL
         ukSr+8dZ6o4pmmUuGJhmNOsTUhUu8sS6DR+gfdEv0JavTVWwFAtZctQfG6K6nsLrtaLE
         wqJsc6SHfkLXWcFf186DBbCX74JH1TxTjV0Oiv4oxASaL1AKRZuNVG/AQBhiIyrBpEWt
         4UkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVISWfBkQnut0c4RZgZJ2dmdPivZGRpMs1vFVz7yjk7//KXrnSItirxZBuESvUVbGEjspE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCgPacS+o8kln67DjMkiG9tWPfdSgL+IYx6RP/uQLCqgufaxvj
	wDwfFTrPlyuloVg8Ip2YQd2YdBDxa14VYK+b9N0YJWr0vc667zc19nm+
X-Gm-Gg: ATEYQzxYls9Pio9inYJ/X/MWuXJQMw05UV8cUqFlKR2lEE+JTqRT5hwZeWO3muMX5qy
	kQGbGkjs86HyXwwXlMedAmWhw6ZgRJRylVF4liPuivmVubEE2MCvS4JFEHoAuV/FFPQuL9fOlAY
	9Q/UUCtfcILoHG8EiZoHjGmluTwMHVqoeBN6ODEalsuY02e9bypUcNn2pdHfJtqGy46h3eqw4MC
	AI5MPDuP2i5yS31/O9htZfddN8AC0ols1nWi/APa6V2Il5ZYKB+Md2kWsB88/rrUUTi+YvqO9nY
	a7Wsfj8eZ1OJzKHmHr102NhcQhMfOtXkJfW+TxfbPocN/6OE5qAXpmA3/yQ7NRgJ88I3ZSz5AHH
	Xufkn6a/bLiCWx1PSwq+OiMY31mZJfsWgO0VcLN0wqhDplxBCzgZ2rQ/UV8E1UKncC92hBiagdq
	NHzXkMFGsbYOvNL952cP84
X-Received: by 2002:a17:90b:5111:b0:359:ff8a:ee3f with SMTP id 98e67ed59e1d1-35bd2d3b921mr8332433a91.30.1774232336155;
        Sun, 22 Mar 2026 19:18:56 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd24b541csm3766621a91.0.2026.03.22.19.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 19:18:55 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	olsajiri@gmail.com
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: test access to ringbuf position with map pointer
Date: Mon, 23 Mar 2026 10:18:39 +0800
Message-ID: <20260323021839.101316-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the testing to access the bpf_ringbuf with the map pointer.
"consumer_pos" and "producer_pos" is accessed in this testing. We reserve
128 bytes in the ringbuf to test the producer_pos, which should be
"128 + 8", and the "8" is BPF_RINGBUF_HDR_SZ.

It will be helpful if we want to evaluate the usage of the ringbuf in bpf
prog with the consumer and producer position.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
v2:
- don't set the max_entries for the ringbuf map
- add comment for the producer_pos
---
 .../testing/selftests/bpf/progs/map_ptr_kern.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index efaf622c28dd..d7611e7018ca 100644
--- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
+++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
@@ -647,8 +647,14 @@ static inline int check_devmap_hash(void)
 	return 1;
 }
 
+struct bpf_ringbuf {
+	unsigned long consumer_pos;
+	unsigned long producer_pos;
+} __attribute__((preserve_access_index));
+
 struct bpf_ringbuf_map {
 	struct bpf_map map;
+	struct bpf_ringbuf *rb;
 } __attribute__((preserve_access_index));
 
 struct {
@@ -659,9 +665,21 @@ static inline int check_ringbuf(void)
 {
 	struct bpf_ringbuf_map *ringbuf = (struct bpf_ringbuf_map *)&m_ringbuf;
 	struct bpf_map *map = (struct bpf_map *)&m_ringbuf;
+	struct bpf_ringbuf *rb;
+	void *ptr;
 
 	VERIFY(check(&ringbuf->map, map, 0, 0, page_size));
 
+	ptr = bpf_ringbuf_reserve(&m_ringbuf, 128, 0);
+	VERIFY(ptr);
+
+	bpf_ringbuf_discard(ptr, 0);
+	rb = ringbuf->rb;
+	VERIFY(rb);
+	VERIFY(rb->consumer_pos == 0);
+	/* The "8" here is BPF_RINGBUF_HDR_SZ */
+	VERIFY(rb->producer_pos == 128 + 8);
+
 	return 1;
 }
 
-- 
2.53.0

