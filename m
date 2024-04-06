Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BF3B2A2
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395223; cv=none; b=hZwo/7v6LR56t5s6nc+xmU0QaHK5U4qYY/ZfdDpDgHLici3UbErAmWsFFcV9qK1UqqTyjZK6JYvXREv5L0gUD2JKtbvoBttMCepB4wkDUn0KEkd33Ec7x0vC8XTm4scJItlrtQcBuVI2osOhT4c8AnuwFO54LRy6+Nb9bpM8c4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395223; c=relaxed/simple;
	bh=a78vMWglkqZNxVpizm3bz2mABJk4IrXHntVwOv9hkR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOf+ynDH40QtDS1r1nmWMUl9/rKZN3D7vG5IITKAEZT1Ag2ztHNYdVPNPZrU+v3kH3bvfda204r+JNxCRWZigdTMshtNOGPeBud1DWUn9SFJacZdwDVuqmtxpRw2hLs7CyifZ3tsrwP5YuF06TTNq0JfXRNlQQifRguyxep+/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vmsuGGo2; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vmsuGGo2"
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DF6EC424A4
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 09:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395217;
	bh=U9JiGxHu1Zu7lOUTn6nQmFFrRqhFXaTmBwUIearvaJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=vmsuGGo24oaZbKZFIXkYa+05DycEitw/wz+rIRGEtHAWz87kgV3BH0MMHcZK9e9F3
	 E3XVfTxcX8aSUK/bXlJ4sQozTXugcN4TEv5vwegJ16njQ9OlX9JTIeFHVazRRwNbIz
	 MV5T0qlB8Qr6TDX6P0of5FteLf+mJdyUr4MIn526exZyEMVmVM4Jzs3J6FQppFhLlB
	 i1HBPLh9EpzmXtOka7Hmi1OivoYYn8tr1qArtId03O6wuHmZsVb903qljbkSwSITgo
	 2q4mQK03TDHzSww2tJcTllLjcx5kmol0aUnkm5u3O8EtU6tkSmP7pcCBFCQENAk86i
	 DDu4C/LjPAfJA==
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516be44ea1dso2472119e87.1
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 02:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395216; x=1713000016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9JiGxHu1Zu7lOUTn6nQmFFrRqhFXaTmBwUIearvaJY=;
        b=GdnrDn5n/aawccRWT31UlZEIb79UoFa8p7mb9wWhZ+g7ragMsefEXruFHIxb/ma2G2
         XE7x/n96u2n2vgIMBSb7NwE+YgNcCUMZOhnKTu5wZRg9Zfg5dsR8xTabvqTr9fx26ZCX
         9v0Q4hhZ+H2Pn+CUhZCsS/116bJZM0ygzBRWSBY8t4Tc5dZMBHM3bqHF9AiPk1I1k3GJ
         /hQtg1ZZd+nBJclADnycv0qCtUNcSPIoTfZM49Q93wpZ+Dg4S6phn192hW3EtIBvyCXn
         i6Ittk10CN6QB0pOqxj7ko9SjhgLYfUhO2eAph6M904iYoa86DzRzFI+18Ao7uKsKe6C
         tnPw==
X-Forwarded-Encrypted: i=1; AJvYcCWhl9J+WyqHjKjnkGblzDjhHr6i/6eS3LJVz0Pf/dPMchQjUZUBEiVVcM9gnRaG96Chuc7YAWQURymiLyhRRbVfHO1k
X-Gm-Message-State: AOJu0Yw5lWin3U6FX/7r9N6B7Lbl6Hnd/+YPaoormMTsPPtJX6MNX/4V
	oURVwB7GEWpbmByZBL4m+vWa1LLBLZUWb8tT8ZOrZeZr4OEPZDAO0tbj5Ijq/qGB3tYs4Pj2Z+W
	woy5AiArMTTdsF6EjM00tyK416EyHj27TVgPkEn+Kc0/hM0qxBGlvzAETVvFkGf2FuQ==
X-Received: by 2002:ac2:5df9:0:b0:515:d50f:c6cc with SMTP id z25-20020ac25df9000000b00515d50fc6ccmr2674255lfq.63.1712395215921;
        Sat, 06 Apr 2024 02:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS/Wj4fTtj4EhH4SwuK4rc7frejoX2SMVVjV8lwzSRp5JOOCrfUKz3Ui9mytME96ZdhQmWHg==
X-Received: by 2002:ac2:5df9:0:b0:515:d50f:c6cc with SMTP id z25-20020ac25df9000000b00515d50fc6ccmr2674231lfq.63.1712395215460;
        Sat, 06 Apr 2024 02:20:15 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:14 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] libbpf: ringbuf: allow to consume up to a certain amount of items
Date: Sat,  6 Apr 2024 11:15:42 +0200
Message-ID: <20240406092005.92399-3-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406092005.92399-1-andrea.righi@canonical.com>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, instead of always consuming all items from ring buffers
in a greedy way, we may want to consume up to a certain amount of items,
for example when we need to copy items from the BPF ring buffer to a
limited user buffer.

This change allows to set an upper limit to the amount of items consumed
from one or more ring buffers.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/ringbuf.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index aacb64278a01..2c4031168413 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -231,7 +231,7 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
-static int64_t ringbuf_process_ring(struct ring *r)
+static int64_t ringbuf_process_ring(struct ring *r, size_t n)
 {
 	int *len_ptr, len, err;
 	/* 64-bit to avoid overflow in case of extreme application behavior */
@@ -268,6 +268,9 @@ static int64_t ringbuf_process_ring(struct ring *r)
 			}
 
 			smp_store_release(r->consumer_pos, cons_pos);
+
+			if (cnt >= n)
+				goto done;
 		}
 	} while (got_new_data);
 done:
@@ -287,13 +290,15 @@ int ring_buffer__consume(struct ring_buffer *rb)
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
-		err = ringbuf_process_ring(ring);
+		err = ringbuf_process_ring(ring, INT_MAX);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
+		if (res > INT_MAX) {
+			res = INT_MAX;
+			break;
+		}
 	}
-	if (res > INT_MAX)
-		return INT_MAX;
 	return res;
 }
 
@@ -314,13 +319,15 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 		__u32 ring_id = rb->events[i].data.fd;
 		struct ring *ring = rb->rings[ring_id];
 
-		err = ringbuf_process_ring(ring);
+		err = ringbuf_process_ring(ring, INT_MAX);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
+		if (res > INT_MAX) {
+			res = INT_MAX;
+			break;
+		}
 	}
-	if (res > INT_MAX)
-		return INT_MAX;
 	return res;
 }
 
@@ -375,7 +382,7 @@ int ring__consume(struct ring *r)
 {
 	int64_t res;
 
-	res = ringbuf_process_ring(r);
+	res = ringbuf_process_ring(r, INT_MAX);
 	if (res < 0)
 		return libbpf_err(res);
 
-- 
2.43.0

