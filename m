Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DB27FD49
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855853; cv=none; b=NOCj/dl4AyECF+mdBixKdWhLJnCMOvI7B6GCZRfiT/kC/F7lbSAlzFbNli4WdrB3wGUbOmRKBsMb+2Ks+hYrXmMt8aH//2XZem6Hbat+Ij/461GiHtHdWGffgS35qWO6s9IZN/uiI0Pc003q/4q1sfaDpOA7tMYnwVP9l0fzCgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855853; c=relaxed/simple;
	bh=GmM0gwjP8emtGhqZB3WjZ23JIZS6tYHfWWkTP4JxzXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzsprSeXA/uy9wOK1dl9LKmDq19uItWBWLwJtGg1M+yCWB5lHFb2u8LrEvpL/uwdMIWcGqxqq5HCDZcSNiDgjHIZVb5KPdj5Y3XHx65smIHHOd/gGBOpemdHoO7u+3a0RPD9aV2tEsA7s1Yv0+cM78Dc7n4vMLQ6Lvrba3HSDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLgUv58n; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLgUv58n"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-435a11957f6so3718605f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 06:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771855851; x=1772460651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6Bwp0Tecxg67yxK3DKEdNEg3+pqu/PuVYfYSL9GDIA=;
        b=dLgUv58n1ub86vSa2WSh7dPPzs8MuECFQ/VAqu+EEVE7S4u9GTi/kDsoTF7aPTvo1j
         JfjmQjYH2c9Uw9H9hCLhGq1TU7L7Qqk2Aur7kLHoVKJSUkssfu3a6yIXpv9qLtAOvWfy
         p5H1tFQxa0rv0h5ZwU1ACBZ0SX8eG7ErG8CoXSIc8L3mcKivK/n1ywLJp2M+4tk7RGFv
         oUdmvEmamZ65IfWA6AcB2lzNMB2YXWsG/82qBVL2fvmqUXa1xPVuw9KEaKQ/51c7dkir
         xAzZDS0jHSpC2/VC6qWvCwD62FpQ18u0ZJw1S1uej63NyJlfVEd1cyXZtGL5gaqBOaSx
         bKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855851; x=1772460651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6Bwp0Tecxg67yxK3DKEdNEg3+pqu/PuVYfYSL9GDIA=;
        b=JgLH/HQis/UUwS+Q+ym0M9klNkKB6jSB9cF55QwOUeilTF8P6jVHH7txdWi2qInllB
         +I/PyPNHigNaSJJ+qm/eV49Uh6ct5c6Wat6O0Z6MXJEHE05fE809bZWdIrILFRUpcD5k
         p1aGRry6u8HW6iZvZGZ5Yoz9kGi5KBXM3EXJdlxItkLwCnJKgSo5C7nFoKCl5mttaUrq
         EEfIk68nCW+6hWO8dR1e67u/3pYuhNLp3E165K2e9MhIDLbkjo/DCeovpBtM/X4n3kFx
         5rLblroeJW+r5Vx4IERo7kUTM33JrWmpbVV9Zj1EOC5SvG8T6OmhQ2uq7zaBJOvgun55
         CNnw==
X-Forwarded-Encrypted: i=1; AJvYcCVyl7QRkj91zMSTnQNcQWaQI6VCF49AmB2lGmX6oQv6Kueb1lysHQ843Keh/t9q5eUDH2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmT5meeArIgeNH69cSwY3B/ZI4I0OiJEkIGyfT0lBKd1IIhmYe
	EnT1DWRXtrz7bpjhbtgOM9zVLNoNDb9Xx8ZJ0GK8rlm1JUCuL0Z9a8o9
X-Gm-Gg: ATEYQzzQtukDTkX8H4DqzFE/BvYPfjy/W36UmbBgidCT3+lWFVFE/fFIemXPTPNcjbC
	gGwN6vAFQUI7anRRUtyV10ee1Vo3ZE/uK67p4Z2bInHR9YUQtcZcz3hUF9QLxAuxfZJ3uQ/Slkm
	xZaqS6KpPiiBc3iYsL6F4yzojLjd8q/9jWKN/6pYJOOgkGTV4myMogBOElU/smScoe0oLEL8d1C
	k/fu3XH+gNK2IVs71rWcTFvWze2t24xxiVN4rA277vw0GGNXcbenkyDaYZIJh57fTK9W+mVfEZs
	Zry7q0BCGOFy/l00ZXvy3REdumtJLda0JLq8mIofcJkoaakd2ceKTBxcfjcFZc0MOEdB/BUwZD0
	jSyRIzJ1wwvhIW8UKjhd3MwRhbHKW4m0qNHVCzV22SVhyITx+wwObY2Quszbu+Ybz0HPg2VMwUk
	RPxFwQa6moNvgTpiZ2qpMeotyqG8Ox/qvnP+cmH5wG2L0ZrPV1ZA4zR59a/a+x5l+Kx9PWMXRjn
	geIO67s+w==
X-Received: by 2002:a05:6000:2483:b0:436:684:b94a with SMTP id ffacd0b85a97d-4396f154ceamr15154135f8f.4.1771855850694;
        Mon, 23 Feb 2026 06:10:50 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:36ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm19464640f8f.6.2026.02.23.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:10:49 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	bpf@vger.kernel.org,
	axboe@kernel.dk,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v9 07/10] io_uring/mini_liburing: add io_uring_register()
Date: Mon, 23 Feb 2026 14:10:18 +0000
Message-ID: <a03081e83292f7ce106613be2bcefba385881b4d.1771855761.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771855760.git.asml.silence@gmail.com>
References: <cover.1771855760.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper for io_uring registration syscall, which will later be used
for region creation. Keep it generic, it's good enough for now. Later it
can be turned into a separate region API, but I'd rather have liburing
introducing it first and copy from there, than the other way around.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 tools/include/io_uring/mini_liburing.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/include/io_uring/mini_liburing.h b/tools/include/io_uring/mini_liburing.h
index 81513b82433a..ee75cfc24d84 100644
--- a/tools/include/io_uring/mini_liburing.h
+++ b/tools/include/io_uring/mini_liburing.h
@@ -70,6 +70,15 @@ struct io_uring {
 #define write_barrier()	__sync_synchronize()
 #endif
 
+static inline int io_uring_register(unsigned int fd, unsigned int opcode,
+				    const void *arg, unsigned int nr_args)
+{
+	int ret;
+
+	ret = syscall(__NR_io_uring_register, fd, opcode, arg, nr_args);
+	return (ret < 0) ? -errno : ret;
+}
+
 static inline int io_uring_mmap(int fd, struct io_uring_params *p,
 				struct io_uring_sq *sq, struct io_uring_cq *cq)
 {
@@ -280,11 +289,8 @@ static inline int io_uring_register_buffers(struct io_uring *ring,
 					    const struct iovec *iovecs,
 					    unsigned int nr_iovecs)
 {
-	int ret;
-
-	ret = syscall(__NR_io_uring_register, ring->ring_fd,
-		      IORING_REGISTER_BUFFERS, iovecs, nr_iovecs);
-	return (ret < 0) ? -errno : ret;
+	return io_uring_register(ring->ring_fd, IORING_REGISTER_BUFFERS,
+				 iovecs, nr_iovecs);
 }
 
 static inline void io_uring_prep_send(struct io_uring_sqe *sqe, int sockfd,
-- 
2.53.0

