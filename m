Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935B49468
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711956742; cv=none; b=ljtn0Ywc1zFvbxdb+k4hqF27FxwDPTWHrfCk9ucXw8KEp8tN6ufJC9fE3/vd8/SiPu9mBPFavktSGQCc3hn3DB56WTh0/VwvO0YRyFcDioiuV5dpyX/cVsbCVKzVArgkWgP+A+oqRwnrhG03z+1ZMHUbCv13uX7T0PQu94B0wNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711956742; c=relaxed/simple;
	bh=E2OvbR8Y9EfGSS+5Sv3FbD9q2hZ3fz6/lXWfMYaBCYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcS380fZG1FFJpHBqR9o0UqYptwiLsP2PN/4Szh0xvz04E/dpK4HMyMJe97uN5raR2OibkE5fwvKB+CGawUy6Y8MpfN/oyZluTL3Y2EgkLmfnCoUD21Ea3LIqm4x28/TG1sQ9f3x10vTH+EOjoPyY4LHGcW/kz+GNFItwRpBavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KhxcH15d; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KhxcH15d"
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D6DF4249D
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 07:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711956733;
	bh=+ydULlYumW86H0k1QJy3F+4RQ7Ta2EUdgWzksXidHow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=KhxcH15dhnDjqA38FPHLMJwjDyT6gPtVbc1C7bvf4RBkuciFaCyFZ15kKYmf2JcS5
	 8/nkuT58BO1y/v/V6Sr5ogYD52q09U0VfYM2KJW3Hl9AYSp83mWO02g6H0p/YvVyLV
	 r1ELJPFkYJLrGMlTInCVqYWKlRXymmpkOPLTeaPQMs9/P5dlLLBHwg0+ZdA6ngP6Ww
	 fZ/9cRG8RpEdWAfLerucLKgBhqlnPxEvWG75E780EFpZXBTooUbVPVfTX6xfelgs18
	 sH5mphMs5CdPaCruEcwM2MPRovuNWOKnyahaeQvetduxoynN3H3GvSUPMYi+jBW3yw
	 8SLyUAMueFd/Q==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56bf8c6d3e8so1032124a12.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 00:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711956731; x=1712561531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ydULlYumW86H0k1QJy3F+4RQ7Ta2EUdgWzksXidHow=;
        b=ur/+1KWIJF2cC3ssogSFuH8NzNuSPVk/eWQ3kQZEv/wDvP5zFEzqgBP09iXXxZASQS
         6bFnfjvhCY2sCq2bnzfGIe8PW1jvmQhzpa+T/reAhb86kNDUp8jp82VrSv9zQXGaUUq0
         2I1KDDnZeyYbCWFVOwIKdeWlsL4p8KJMCVQhApme1ppjSmZaJcRn7CdPDG9B8p7YGwsf
         CYIhZzebgrjpJ8Sz+cEFcR8tqpEGyE5W/T+FOSjdkiVmWNedo/Q5vB6jINrLAIQ6owvC
         LmgmCKEpILDRhBXh5UxyPzoEE/V0UeY2gHEk5rfcYXOw1nlw5N06dDiUcpIZnf06nX6n
         PEWg==
X-Forwarded-Encrypted: i=1; AJvYcCULntKRFgeaz+O0aZmbcpyNWihljPVJfA0EEH6aHh9h5zVqF7+WpdzZxAfWo70d/VeD34R2IDEPcEhANxck9Tjh81NC
X-Gm-Message-State: AOJu0Yx4RZJmoNH4/kSEEsC0T4tIR5Z/RercPt8A9g/eT4Pr5nzvKCEP
	NPt8f+0TFV/41JJN9cvmJRWLQAOsu/87S2zqfm2UGc8HY/0sDfitWdqDqntr/dRXQ6zZ4yKZJpP
	KA3VFVRgWUpvkBYoc+SXOasBGErHh1yx+PR1cEuWn5JDjgKMx7skX4GyMkElCfLs8Nw==
X-Received: by 2002:a50:8a99:0:b0:56c:5a49:733 with SMTP id j25-20020a508a99000000b0056c5a490733mr4894151edj.10.1711956730682;
        Mon, 01 Apr 2024 00:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/s48cbhw5kWGmUnFjm93DIbZ7N9w0ByK1ybfJnUyLWeOpcJdNno7LzBS/t0R7Nxtdny/Jkw==
X-Received: by 2002:a50:8a99:0:b0:56c:5a49:733 with SMTP id j25-20020a508a99000000b0056c5a490733mr4894128edj.10.1711956730256;
        Mon, 01 Apr 2024 00:32:10 -0700 (PDT)
Received: from localhost.localdomain (host-95-248-169-71.retail.telecomitalia.it. [95.248.169.71])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7df97000000b0056b2c5c58d2sm5096511edy.21.2024.04.01.00.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:32:09 -0700 (PDT)
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
Subject: [PATCH 2/2] libbpf: Add ring__consume_max / ring_buffer__consume_max
Date: Mon,  1 Apr 2024 09:19:02 +0200
Message-ID: <20240401073159.16668-3-andrea.righi@canonical.com>
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

Introduce a new API to consume items from a ring buffer, limited to a
specified amount, and return to the caller the actual number of items
consumed.

Link: https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/lib/bpf/libbpf.h   | 13 +++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 tools/lib/bpf/ringbuf.c  | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f88ab50c0229..85161889efd4 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1293,6 +1293,8 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
+LIBBPF_API int ring_buffer__consume_max(struct ring_buffer *rb,
+					size_t max_items);
 LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
 
 /**
@@ -1367,6 +1369,17 @@ LIBBPF_API int ring__map_fd(const struct ring *r);
  */
 LIBBPF_API int ring__consume(struct ring *r);
 
+/**
+ * @brief **ring__consume_max()** consumes up to a certain amount of items from
+ * a ringbuffer without event polling.
+ *
+ * @param r A ringbuffer object.
+ * @param max_items Maximum amount of items to consume.
+ * @return The number of items consumed (or max_items, whichever is less), or a
+ * negative number if any of the callbacks return an error.
+ */
+LIBBPF_API int ring__consume_max(struct ring *r, size_t max_items);
+
 struct user_ring_buffer_opts {
 	size_t sz; /* size of this struct, for forward/backward compatibility */
 };
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 51732ecb1385..bb3ed905119d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -415,4 +415,6 @@ LIBBPF_1.4.0 {
 		bpf_token_create;
 		btf__new_split;
 		btf_ext__raw_data;
+		ring__consume_max;
+		ring_buffer__consume_max;
 } LIBBPF_1.3.0;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 81df535040d1..c8123e326b1a 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -281,6 +281,32 @@ static int64_t ringbuf_process_ring(struct ring *r, int64_t max_items)
 	return cnt;
 }
 
+/* Consume available ring buffer(s) data without event polling up to max_items.
+ *
+ * Returns number of records consumed across all registered ring buffers (or
+ * max_items, whichever is less), or negative number if any of the callbacks
+ * return error.
+ */
+int ring_buffer__consume_max(struct ring_buffer *rb, size_t max_items)
+{
+	int64_t err, res = 0;
+	int i;
+
+	for (i = 0; i < rb->ring_cnt; i++) {
+		struct ring *ring = rb->rings[i];
+
+		err = ringbuf_process_ring(ring, max_items);
+		if (err < 0)
+			return libbpf_err(err);
+		res += err;
+		max_items -= err;
+
+		if (!max_items)
+			break;
+	}
+	return res;
+}
+
 /* Consume available ring buffer(s) data without event polling.
  * Returns number of records consumed across all registered ring buffers (or
  * INT_MAX, whichever is less), or negative number if any of the callbacks
@@ -376,17 +402,22 @@ int ring__map_fd(const struct ring *r)
 	return r->map_fd;
 }
 
-int ring__consume(struct ring *r)
+int ring__consume_max(struct ring *r, size_t max_items)
 {
 	int64_t res;
 
-	res = ringbuf_process_ring(r, INT_MAX);
+	res = ringbuf_process_ring(r, max_items);
 	if (res < 0)
 		return libbpf_err(res);
 
 	return res;
 }
 
+int ring__consume(struct ring *r)
+{
+	return ring__consume_max(r, INT_MAX);
+}
+
 static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
 {
 	if (rb->consumer_pos) {
-- 
2.43.0

