Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C92FD695
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537792; cv=none; b=AZubXdR3uys/E1L3L4vACDK7dEIsWXQooMkKQUuJeXTiu5twHgeKBGfHqxYtjGIQgE0RtMs9z2b3zqfmncR9FqKe6C/PQuDikBwEm6zqXUqmN3fhTuBFFtmXrBoOswpbC/HDG07EULJg4aFmjtiiZtNSm8sWRyuefYkMxnK0OAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537792; c=relaxed/simple;
	bh=ToW8ikv4PpccRu44YHrzBEPS+IftgtGISd4HvBggkTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA7iWuQUieTK5Xk/rrU/r5EPujKdt51uYiIAy+EmLDmpzcX/qxN6+jobM3lQOUzCSfolyy+3Aw+8EecRgVC1cBIIhyse2jdHzRocfWCVRW16jA63Cg82InoDf+wDC+SB3T0vbK/M97z2DBoPfqpExZijjWpWT81yIoEJN7cgpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=DL2w5PB2; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="DL2w5PB2"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89461ccc46eso104591036d6.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537786; x=1770142586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOkO+CKFCLFl41ui/8tQJFIfhMCDdnVSoIZEfD0CQrU=;
        b=DL2w5PB2fD56wVZS9sIU4bWKZBIqe+y6PxBg8tRG30I+6wHcmmx+EWIDJ0683Q7h44
         8hjhAcJelUItDhxxGX/ddY5Eam0YM/NDt1TaSHBli2Vj9b5rfS7TFepm/0OegCMv+XD6
         ljdyZeaoHhMrgwLohcnaVru4A3lwoGGDvlzP+6uwXrSfXpadKAuNnN2NbJwz8Lie1G9/
         FUCBBBklIYsnDAt0gZBLADZ6OBTwUXRjh4+8HCsoghfK2U340OwkzMsFPHiXF0aSiCDy
         YocZ9ylQfOIK7ToZS6sgHp9trcuPn4r8IeA2zPEs4IgQPqvY4i5h22Y+2IWLksf7hCaT
         oniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537786; x=1770142586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LOkO+CKFCLFl41ui/8tQJFIfhMCDdnVSoIZEfD0CQrU=;
        b=nCKE4NuVrbndi5CMC/DHN0gydCynC6oalxG4H9X2Lt0TAq8Uiu9+99dfFqxg/JCUis
         h6M+JT7AU8qGy52ft95I86VyBYq9Rwg+NVvcyw9HogJ0Ig6XYf0L57xxPW+sAaF1HFLt
         tpSGn32emj206/T7A+pT7Tq+86ZAlvBq5fWmI7XToOSCDcGemWO3zYtQ6PBkoMQ8IrHU
         WOzORcJ7sSWzaJ3vTU9TZW4Y7kfa0AdRcWyat/B1CUcIrLFY5fnQ6XTzqfyfJUdtJbq1
         mNJLFRv7fuQsOfIyd7MVBv5NDV483u0pnb6si+RjuyO+c6mYO9/sG2QLydmHIvhjN1n7
         po+Q==
X-Gm-Message-State: AOJu0YzN2F3oab80u7td+MZyc3aIPo6pBX90RzNxX4BYW34vuZUVNiEI
	/IIhNRoeC/BRZBq++ZrJo3GMjhgquUJkCEIeEY+TofNBw3P7sZz3GZ1f4GVorZlZc5BOdoV7Jwz
	W7CKz
X-Gm-Gg: AZuq6aJ54280SrY/wwD3ga1isMedgZwT4v+qSqr05HGblmmK1gzVaMsUVOpryOfLINR
	CM0ld8GORwdcHybe/hjAOLlgu9KE9QVHgOYewKw3kxyVmRvGdTeYnIqKJlM2l2cF4w/NoGJNKX3
	Y1YAEOGJayX+JTnMZYhd3uqu0jpzmh2DIMjpew+RybLokWcfAoKYUlka/dMlOIoOBC+Nzs09sQy
	5nm61okgzGtRB1SNZPSgJzWsV8l9f8PGe1u42d0Ht7NF+xbkciFzaHzgCS45Y9YU0H0GZLdhkrb
	tocb/ey6dobnq7c0M2MEYAxWFuZbxuxlpAAOFBmUtGnh7p4ZMPSKzB25oOE6mxJWr7j2aaXd4eJ
	LQWUvCJi4aQWHj/qIjGvlyE5k73BJRhQzA3MQQqQw7Q1EMcNOhKCixXWjKjmW1Z7m0hBTP3YBl2
	TXyG0ZysW5WSwZrGTmUQJc
X-Received: by 2002:a05:6214:202a:b0:888:8913:89af with SMTP id 6a1803df08f44-894cc806d1fmr40193026d6.15.1769537786429;
        Tue, 27 Jan 2026 10:16:26 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:26 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	etsal@meta.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 01/13] bpf: Add bpf_stream_print_stack stack dumping kfunc
Date: Tue, 27 Jan 2026 13:15:57 -0500
Message-ID: <20260127181610.86376-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127181610.86376-1-emil@etsalapatis.com>
References: <20260127181610.86376-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

Add a new kfunc called bpf_stream_print_stack to be used by programs
that need to print out their current BPF stack. The kfunc is essentially
a wrapper around the existing bpf_stream_dump_stack functionality used
to generate stack traces for error events like may_goto violations and
BPF-side arena page faults.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 kernel/bpf/helpers.c        |  1 +
 kernel/bpf/stream.c         | 13 +++++++++++++
 tools/lib/bpf/bpf_helpers.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b54ec0e945aa..c30a9f68af6b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4562,6 +4562,7 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 24730df55e69..6e2cbe5f34e7 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -245,6 +245,19 @@ __bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const vo
 	return ret;
 }
 
+/* Directly trigger a stack dump from the program. */
+__bpf_kfunc void bpf_stream_print_stack(struct bpf_prog_aux *aux)
+{
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	prog = aux->main_prog_aux->prog;
+
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_dump_stack(ss);
+	}));
+}
+
 __bpf_kfunc_end_defs();
 
 /* Added kfunc to common_btf_ids */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index c145da05a67c..6d8ae3887618 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -343,6 +343,8 @@ extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *a
 /* Helper macro to print out debug messages */
 #define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
 
+extern void bpf_stream_print_stack(void) __weak __ksym;
+
 struct bpf_iter_num;
 
 extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak __ksym;
-- 
2.49.0

