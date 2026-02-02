Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2257283159
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060801; cv=none; b=WRsPjUka+EE1m3quVHZC8pWroRLj1spHpAUc98owynan9JM40EQx7ZSm2i36Cs5+udSggzpQ8mFoBeRHEUAYGV8Lnk6E5zJJkqz9sHR77LR+gPTCFwH6igrnb/5xZ9CDLETSbSH7nksv8q8n+11B5ldVjH4RWcTP6KZG4nxH4jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060801; c=relaxed/simple;
	bh=71qa0NBEnQVLz/MGvsAFWWXy/GIqJx1b72rS9xSvfMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fooj7Xwo7JUJrm6EAmZjaFr+kyQDKJ5EKYnFWZsKXc2ZRO3/+sdTvJxdf0DB4gPfnleqFwrAwN0sxS1TUa1gZRyBsMrE30lPgh8fSDYEYVyza72iDbXTz7FXIZOTodxwDfJaN50E7IKHRtK0hdVyOkSEvIENw5KYlEO0MaWT2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=PQ3u3Uw4; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="PQ3u3Uw4"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-502b0aa36feso787731cf.1
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770060798; x=1770665598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MUh7H07M9VxQB6bge/8lmxlMqFhb+/HNB5zYD3dvro=;
        b=PQ3u3Uw41NIC2C7fJGlSwcIaNPOcKdRDKOL3U/uZMuSpHJAJFrddiK1/UHHACeAAOM
         3/5xwX2n/kncm82xAcYS2ztPBYXgTWs5PdW/s+ALOkUNZxjN+i1VLDdWpjUFM9E+zapf
         yvauCjbNCbY5BNqJYo5fGRhKXjT63PSvYlu1TQH/W1FVBJV6Y0HZg1B30hx0r9uj0RcS
         2c2Jr+jjF8PAjn4+HsmSAPec+Zos0kufugPXJ4EgpuLH3anfFy9TxJti3EfqZvfIEABk
         B3dkamdG64+2lzma/HWgkB4y4M/e2ZWvC57LJFUqgroZ7nfUs/xxgMhEnawbJy7xETOe
         2AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770060798; x=1770665598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9MUh7H07M9VxQB6bge/8lmxlMqFhb+/HNB5zYD3dvro=;
        b=r2hkSmBra2US8iqUDxbAQTlC+u42/oMFpVTrH0LkwyHuNO3dsSzDxaOz+hnIv7zlkB
         Yn4tKY/XQiaOsOlE7bi3wQJnatqnwf2aw6K58m7NEnNxEv4sGTQri9qgZJrU7zglrCjl
         ymGcyVKLqWSWiErwbnJm3P1XZGumt0KPUUdNyO567Wey4PkoFqHn30h3t5XMIB7f0eAn
         O7/vsau/2S59VM2RDssL2xsy+TmU0KGCqsYzexzZazz4zBfzhvGTNnrpJqOYWLFnbyGw
         QJFfQF6UHhWTwQa+pcJAm+JSicDpM2V1tEx74uvajtxIosoIRtADsfQ/1PdNcWxQC2vn
         nsoA==
X-Gm-Message-State: AOJu0Ywwt1pEBzrC1lDh/RP5bQ3s3Su3GbDFe71v0wThixFOuIfwmC/I
	n+7sE+9Xo/Ys+EwcAhi4ybX0iupQhIIfWN2ldevGz4vjdeW9dMp/hRBhieuB5LAPFS3C8RhIBRL
	vODJM
X-Gm-Gg: AZuq6aInYsueYoqZq5dXX2udtADJWoJyfnNMVblc7q2XWsCTuDOPm+D23IKNrKQNikY
	DT1E/t6z3JgnQJnpN6cO7nu50u2Fv19ZyD0lspbhkGgzKS31vsv51EvadFjsu4YHJ2N770/KF8h
	T/hK0OCy21p43aZJlo6HPHxnvP8UJTX2VtoqDveO5eaPVPIoBkLzH2bw3yP/5VEdpXGzgna+xgO
	Fl1L5MCWuOOHDHoeZmzOmg0WJiF0tBPpmLQhHcQTDEdaR7JnYLsBpIoLaBtr9r4eYfxxqQj1IOh
	0AJsPANG2nTXaejMMjrq+a0uThp6EK1sYaiVnwt8Nm7kunn4AIf71hgjrtU/bHBxMAivj881gGP
	u4E/NkC2QZi9F4j0ITALsv9X50wuCxHyB4vFpNWq9R/xhv6CFYZ+w+gnjUIcm60wj8At2lmVzyb
	LQb6N6brz+5g==
X-Received: by 2002:ac8:7d90:0:b0:501:43fa:92b0 with SMTP id d75a77b69052e-50609300308mr7587471cf.36.1770060798449;
        Mon, 02 Feb 2026 11:33:18 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745d7a9sm111971941cf.5.2026.02.02.11.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:33:18 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 4/4] selftests/bpf: Add selftests for stream functions under lock
Date: Mon,  2 Feb 2026 14:33:11 -0500
Message-ID: <20260202193311.446717-5-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260202193311.446717-1-emil@etsalapatis.com>
References: <20260202193311.446717-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to ensure BPF stream functions can now be called
while holding a lock.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/progs/stream.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index f63b378de090..6f999ba951a3 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -42,6 +42,10 @@ int size;
 u64 fault_addr;
 void *arena_ptr;
 
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+
+private(STREAM) struct bpf_spin_lock block;
+
 SEC("syscall")
 __success __retval(0)
 int stream_exhaust(void *ctx)
@@ -255,4 +259,32 @@ int stream_print_stack_invalid_id(void *ctx)
 	return bpf_stream_print_stack((enum bpf_stream_id)0xbadcafe);
 }
 
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__stdout(_STR)
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
+int stream_print_kfuncs_locked(void *ctx)
+{
+	int ret;
+
+	bpf_spin_lock(&block);
+
+	ret = bpf_stream_printk(BPF_STDOUT, _STR);
+	if (ret)
+		goto out;
+
+	ret = bpf_stream_print_stack(BPF_STDERR);
+
+out:
+	bpf_spin_unlock(&block);
+
+	return ret;
+}
+
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0

