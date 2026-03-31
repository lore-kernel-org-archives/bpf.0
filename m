Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9933B6379
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940697; cv=none; b=uMQs82qhCbLjBl/s7xXp5aUk9PIRoFGX0nPVQjg8QMFLZp1qTIGmeR1fzwgaBfXBsxKazpo36zy+8cJPoaT2IV/sJcQjJWlIrsGmd66WtjDhO62XPTD9YibCwVcYTpXV6SC6AEEQpF6kls13UkH6/VPrb/9o9dDegTChTdz8/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940697; c=relaxed/simple;
	bh=Ig4osFGayyTKiUDrdhynu9gUM5VDbzOye01+8vxPoP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxP6Ptmpk5dwZnGN2dJnGzlcmV2HU/fC0z8F82Cz3dDDzZzZW+b1VvXBdfhQg5UhqCihGZIcaZljB/icNmJxlQAjHO9Cq9005yjc79whhn2CrEait9UkkuegOl20Dd3B7VwVwdsjvZngC8v+0KlujFK8lXTpPPwKaJRprU52GR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjBMfmUN; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjBMfmUN"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso2232962a12.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774940695; x=1775545495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6lbWXtnbhC1yTNbE69i6SmEZlVhDlB2Axaw0Jgrh2l8=;
        b=XjBMfmUNPI4q+3Ewm7D1ZxWRm+6EmkOf/XHJEHk2nDdP4f1vAw45xRDslQBGhWUo90
         0SYj/W+JrPMeAI9IVA/eprWoEm3D5UtQ9as+YUS5nqEyF0tYjUSiDsQmbuRLoNIKkDnj
         dk7s6o9WcRwKdLICU/FczxrkPdRkdU+Y9ezL5TNcug4Ri8U/y6/+5N8DEgw3tbOHwlYj
         3p2X4flkHyk/UceEB4S8bzeOjbdi3vlNOayzjnmSevqK5E5zzmO2HInvDJErKhrNIHaJ
         21OT2/HbZfVdPpuXkD3Wo4ng1CFb1GGMe4FwBI38OcXNfoNZABslR90rXYojrIe88iTd
         8aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774940695; x=1775545495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lbWXtnbhC1yTNbE69i6SmEZlVhDlB2Axaw0Jgrh2l8=;
        b=M4XxdWKXALPqsAfxiWBhjOMXjfR8Xy9rHJ/bYOWGt0njYYIjP1sSEV1uyuG43XdTpY
         vZWGIg5jIhFBaHFYEHtJidbNZM16cOqlMnkT4IMhgMY+McJFfyVGbQQQSVI3REIrp86n
         lGQVarDaYjFOeT4LGACLn+ZeN5UInwh/IQKh52SdHa4SVYuT7gKGkdPF6DR8PTECPQrg
         HREGiW4ngkwl0S0R/rGOaA7cnk7H+m8Y2tQT7imW4EEV9sWjgJ3U0AqHwOqiqaNBDIEb
         ApxTtjVnJzGwaK1YhrFb4jyyyeRdesn7tV2ved1xGXR2yfSzw7eE7aG5pt9Jmwgt2vz3
         9gsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbNstXlq+r3rYhaYtlkp3+x9V34dhzU6germLo7FKBQqnrZFanQ0sCgnww1WxUwD8+eAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlg6QWyAbpnh1ddjXNB2Tej7WK+vCKwML5sq9m5hY5eM16XziR
	52F5kYoSWcJIg5N0Nk1518zrahDRlpR4wRwGP5Mk2Nqn+hgBBGbT7Z9+
X-Gm-Gg: ATEYQzxmo3w03DQuPTG1pbtfd6SFB0TwjFEPs8cN2qrCKJm1ThuMaPpxoykw+1ejO4b
	UzK0vlhrNj/L6yeWPaswwB68rj4jepRC5nV4kRG/lky6+dF/kHRMBf/OiJl/xg74z/lfUngYRji
	/JVEmcWX+G52cBmjV3vsfLbAaYyHySW8oAT8hZQKquNPLLCZK/WNqAf/VEKd7G8bMgHDPep5Lme
	SopK4KjoPnlocI5UNXwjoyjMzb/XT4sJe+u7gHJGhgqMR4ZePQhePu8a2XPhzPQuewN4h5TgVv9
	YCR5dzeYXP658StRyh2kcCFgiAfwIdb4Rb2BJnCaBOX3hu/TJEz7G/GgMjqTlEZLpa097za6QTW
	YyYNOw+hGYrKDzA/OQcE1AEwcfHzfAXIknWdA7r3vD1o89pLFt9esq0UAwRNwIxj2vKggxkfILa
	wGfbyLaDxW7kzZNsGUbA2C
X-Received: by 2002:a05:6a20:7f8d:b0:39b:c9ca:9736 with SMTP id adf61e73a8af0-39c87aea4d3mr15490809637.46.1774940695284;
        Tue, 31 Mar 2026 00:04:55 -0700 (PDT)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76b78de2a7sm226149a12.13.2026.03.31.00.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:04:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v3] selftests/bpf: test access to ringbuf position with map pointer
Date: Tue, 31 Mar 2026 15:04:34 +0800
Message-ID: <20260331070434.10037-1-dongml2@chinatelecom.cn>
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
"128 + BPF_RINGBUF_HDR_SZ".

It will be helpful if we want to evaluate the usage of the ringbuf in bpf
prog with the consumer and producer position.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
v3:
- use BPF_RINGBUF_HDR_SZ instead of 8 in check_ringbuf()

v2:
- don't set the max_entries for the ringbuf map
- add comment for the producer_pos
---
 .../testing/selftests/bpf/progs/map_ptr_kern.c  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
index efaf622c28dd..373c8d17ea55 100644
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
@@ -659,9 +665,20 @@ static inline int check_ringbuf(void)
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
+	VERIFY(rb->producer_pos == 128 + BPF_RINGBUF_HDR_SZ);
+
 	return 1;
 }
 
-- 
2.53.0

