Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CFBA3F
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711956743; cv=none; b=BXH/pZbRzox0D78tp9qXmRDqv1SmIiydh2HO+zxyKl/YKZVew/iQ3b8HV9CipLQ+71p+9iIsT8I5uBNKAr8SRQQmQckL8LgPANefse2OcJURO3oGeeXbKGHCuj3oi9FOZJiJNzoJ99XQH3jlwPdsZzorxYcavkwApLDkOP48hjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711956743; c=relaxed/simple;
	bh=gIfeuyMiLA+qG3mIP+HMYnQdK7NPvoQUwTsiRfQxpFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMAFLvOaUn54ZMbGC964jXwvBSPCj1A+dNHRqpPgPCk5vrSHYf774m6XZNfeVzK7j3T/YsSeDiOv1J5wUm1v1S5hb9PBPZKXfg0K2k15lW2zcNUF2D/ffOTS4Wtk5OhFN/4daOXhWm3w0FrI/lTQCHk30PfKeL9IQBB+Z9XbaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KvZu+P9A; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KvZu+P9A"
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F3CE13FE1F
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711956731;
	bh=AHzGweR9mhy06+J1pxtJBnh5aZr93umUBtlWOhz9jgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=KvZu+P9ACUMECUQaKNwm36WIk5sylV706Zt6HplQ1tKrHXST4JN9w1QlVsBxFteNZ
	 DJA9Ez75eCvjF2jvednbRJmUwSqlOq9N9dzK/5Ra2tsSTTa3SUfcGkRzrzJtnCue6i
	 SKDNF/jwmv8hkgIkETQB8EaC2XtmQig9Pw++QF4mP4dW7uoxlbythEi2MznAHZken8
	 W3Y05xwNXNQtNWMKO2ffZUDxNDiX0GhHHEPuhaKIPPk9oNL7RYI5XGeAJhI8Vc0OXe
	 Z+Hb4Mslg/yYkVSCBZ0zMpxqELh0umpVNXIEpmtaJwlgU1esFUQ8vc4qXmkJUwAqhk
	 t8f4GBWd2qgPA==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-568a9f3ba97so2647337a12.1
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 00:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711956729; x=1712561529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHzGweR9mhy06+J1pxtJBnh5aZr93umUBtlWOhz9jgY=;
        b=RCtgKcNbHwyLKDuwkiOizdDCyVlvYXRhZK1WqRn91OGiy0ZvqbGtsNHdpRxjozvUkV
         hsMUzT67CXvLoJ8Ml0rhMOVJEzA3D4eFUdjoYLysNhVNXzW+SY62MygDIIjGBahn248Z
         RTZLDOX8a3o7cVeU+5IMZU7Sopvv45gfbYE0C0Oqv4+r+1XAkVaFMRNzLuIXSnyOvTcZ
         GOPqz8kukfL7G6Dudlk0IGiipiyu647sdVrMCLfYPNdaGpr/JzHb5Jor78DmxsYL62sE
         pTnGs2pmGS9L5VEZjdKbeA5LARjyvJkcrTvYQqzeCCikKRpYxix4n95s4d4oS7UFySNV
         Ilsw==
X-Forwarded-Encrypted: i=1; AJvYcCUrP7tmYiTCz/P0KdvKkrc5OiV+r6pepOWIiKOdq9jHV2xYUWvnV7MUqIBuY9xRsdqRAT67miQxmpcXCdC3denyTBAd
X-Gm-Message-State: AOJu0Yxhn0rPCgdvyj8yIVQqIqafqAxQM/iV/W9Wnp+ZGKGHu42a+E0C
	ej9+lInN2w9ZpTgwkzmEYuRLlyVmuhv0RQGq8lvmYrb4UBvWp8Vvas0wBBV222PAqrjrr5bNHnA
	zSTYM+muY8KhaBSo/C/3/QBBfhl7H16uL2DVDpepln9vEdlcAPohHQfrF0ybGweP2xw==
X-Received: by 2002:a50:d698:0:b0:56b:cf40:f712 with SMTP id r24-20020a50d698000000b0056bcf40f712mr4806229edi.19.1711956729427;
        Mon, 01 Apr 2024 00:32:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0WRJkDIMWT00K5pp21gpKN/ARz9FyR5f64Ct8AmND3JMwZyQQQXkDBg+wYzzg5NAPBCigcQ==
X-Received: by 2002:a50:d698:0:b0:56b:cf40:f712 with SMTP id r24-20020a50d698000000b0056bcf40f712mr4806215edi.19.1711956728926;
        Mon, 01 Apr 2024 00:32:08 -0700 (PDT)
Received: from localhost.localdomain (host-95-248-169-71.retail.telecomitalia.it. [95.248.169.71])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b0056b2c5c58d2sm5096511edy.21.2024.04.01.00.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:32:08 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] libbpf: ringbuf: allow to consume up to a certain amount of items
Date: Mon,  1 Apr 2024 09:19:01 +0200
Message-ID: <20240401073159.16668-2-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401073159.16668-1-andrea.righi@canonical.com>
References: <20240401073159.16668-1-andrea.righi@canonical.com>
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

Link: https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/ringbuf.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index aacb64278a01..81df535040d1 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -231,7 +231,7 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
-static int64_t ringbuf_process_ring(struct ring *r)
+static int64_t ringbuf_process_ring(struct ring *r, int64_t max_items)
 {
 	int *len_ptr, len, err;
 	/* 64-bit to avoid overflow in case of extreme application behavior */
@@ -264,7 +264,14 @@ static int64_t ringbuf_process_ring(struct ring *r)
 							  cons_pos);
 					return err;
 				}
-				cnt++;
+				if (++cnt >= max_items) {
+					/* update consumer pos and return the
+					 * total amount of items consumed.
+					 */
+					smp_store_release(r->consumer_pos,
+							  cons_pos);
+					goto done;
+				}
 			}
 
 			smp_store_release(r->consumer_pos, cons_pos);
@@ -281,19 +288,18 @@ static int64_t ringbuf_process_ring(struct ring *r)
  */
 int ring_buffer__consume(struct ring_buffer *rb)
 {
-	int64_t err, res = 0;
+	int64_t err, res = 0, max_items = INT_MAX;
 	int i;
 
 	for (i = 0; i < rb->ring_cnt; i++) {
 		struct ring *ring = rb->rings[i];
 
-		err = ringbuf_process_ring(ring);
+		err = ringbuf_process_ring(ring, max_items);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
+		max_items -= err;
 	}
-	if (res > INT_MAX)
-		return INT_MAX;
 	return res;
 }
 
@@ -304,7 +310,7 @@ int ring_buffer__consume(struct ring_buffer *rb)
 int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 {
 	int i, cnt;
-	int64_t err, res = 0;
+	int64_t err, res = 0, max_items = INT_MAX;
 
 	cnt = epoll_wait(rb->epoll_fd, rb->events, rb->ring_cnt, timeout_ms);
 	if (cnt < 0)
@@ -314,13 +320,12 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 		__u32 ring_id = rb->events[i].data.fd;
 		struct ring *ring = rb->rings[ring_id];
 
-		err = ringbuf_process_ring(ring);
+		err = ringbuf_process_ring(ring, max_items);
 		if (err < 0)
 			return libbpf_err(err);
 		res += err;
+		max_items -= err;
 	}
-	if (res > INT_MAX)
-		return INT_MAX;
 	return res;
 }
 
@@ -375,11 +380,11 @@ int ring__consume(struct ring *r)
 {
 	int64_t res;
 
-	res = ringbuf_process_ring(r);
+	res = ringbuf_process_ring(r, INT_MAX);
 	if (res < 0)
 		return libbpf_err(res);
 
-	return res > INT_MAX ? INT_MAX : res;
+	return res;
 }
 
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
-- 
2.43.0

