Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE926E6F3
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006685; cv=none; b=ld9ZW7UpJ+T1Kczo4j53uvPyNenZbN+O9+HwLbKHPHZ37BCIwtnigRLJLG38bI/GS3Gd3Xm6iyVa42LWx3a6bVKuHG3cKc6QDxhlTsCoKrD5KtGr2IPCi9DDGxKnymlS6W+wF4NIxy1h2tgXVpaU6YzwMpHCYb8/bmFjWYqBrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006685; c=relaxed/simple;
	bh=usbpJBcxLrUPf95k6N7MY2esIkXyQ9yGfRgICaB7CFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAUJPCv3EaZhVSRxHM4eaTfiD9Ci8Zn9yIusrJQyDuTat3vVK302NU/PwdHf0wTKP4tw6/CuWrc1CgSsrrtd606kUTfDxbmUTp7MmBSQrdJMBI4X59oR0RRkYihMmhY6DlrPBXX5VMLf1e/8AGle/TvAuGAMEsH3DCChPbE5B1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=lcpSFNtn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="lcpSFNtn"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89473f15ed8so10593386d6.2
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 10:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771006683; x=1771611483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jg6BYpRQG9ImlU6D4334ekeP/xEFs0Cv8b7kHPGoNE=;
        b=lcpSFNtnxDbeExFe8TXU+KCq+bYTuN2FJAnumEVQQpCTWLXL0DvBZrJJhLQdZ42Ky/
         F3xsNDgLRejchkgrS94wzutCiPHGAQ7khcAijh5kAEr+qf7ZUYynSVmJ7ckYVQm8bOUk
         NSXGqTX+TgCM6PWEqg9tlq3yHPMGkoVJ1LfbK0SOD8L+sGT8wbNUr6W6wqSJa2HJU1X4
         KfYdCK9G4ZvgKmzc3dMZR6v8yltSqmvMY3cEpDNSib4IOPjgx1t5td941oHck4Rxijdn
         nnOkoIlUNzddEWyNi1F8+QjfejC2/Qpci7R4jwWBCuOuQoFXp2EdL+W+Xi5uUwxGOHoa
         X+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771006683; x=1771611483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jg6BYpRQG9ImlU6D4334ekeP/xEFs0Cv8b7kHPGoNE=;
        b=O096lkpbDboHSXAaGeZY7xBPFzVNA5TgCD8UYpRXhhCx17qx5daFzpYg/g67NZTRDg
         Wm85wzoU74lPdzQIuqQykgXK5U6+lCeMbSJgnaHz7hysO57itOoJY/dMnFJzWjm5n9+d
         G9jIVXaUXYIIeKAGqvCTsde2j1gDr5QeBrwnfc/Kn3T/+Y2ZS7bYy0EIj6LLBSvA1ajY
         +ISlU2OT3ZzWhArwSZRhzY/F7a5FebXoyaOennA13ZYLGnQUV1aDXahyrCaDoLpt/zC5
         xdBmu+3YUDCkvE/7eix73ErBmVA28p4JVDFqtpFlWsHA/zuml8WFMPSgXD2QJbhwTQLU
         KNOA==
X-Gm-Message-State: AOJu0Yw59AKqVmrFDDuM73cg8bjKzMofB6T4FzRn/d3S8BXhYY5gcB+7
	COT9UiqOrfKseE7jJVdxl8XnMnOQD1iiMIZ8ToVJvelvT+Y+9fp8EWjraHezdQxS4UE0oEfPF9B
	rT7G3F8M=
X-Gm-Gg: AZuq6aJ9QxE4TtLbveNjDeqX1dB5OFu/hbd52ujOKRIQ6zpeswYUuba91xfzPZCFlhJ
	+VZ0ZYGfsZOjMKDWZi+N1o1j6UBj29uthRzx6KA4zuAvkvNugI8hBru1uSD3sxJ0zaCImFK0rdc
	0ksFH5abIGLJTMUeVWh4sY/zlNageovsQvEtkuvhC9OlSm2m+xE48DI226EiNWQPvCGrsPkDoo4
	L5vfdeU44ltTYoc6JPhoJMWpIGlgleVAUOb9rGJIxCYZZg9fOYAR3OP9RoR8M+8bwtw9gUa6vzM
	Cw0H7oD9w8V22ZuDN6ywF4q7GjDMS5DNkJO+y/ofvyKx0HpbrhJO0vC9kcDZ6oPUJM0kzhZKTtA
	n/5DqIRGw2pKL3dDiTKb7aqud3U/ChPOKMPEWGPZGQIBjZtK9BkjUNGhezmMWUgEm9mDfHfA1DU
	wnEMenCYhtUteLGZMAx2GKmw==
X-Received: by 2002:a05:6214:4104:b0:896:f588:b2de with SMTP id 6a1803df08f44-897361ae1ccmr39778036d6.32.1771006683528;
        Fri, 13 Feb 2026 10:18:03 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc91eccsm67337166d6.13.2026.02.13.10.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 10:18:03 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 1/2] libbpf: Do not use PROG_TYPE_TRACEPOINT program for feature gating
Date: Fri, 13 Feb 2026 13:17:51 -0500
Message-ID: <20260213181752.505318-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260213181752.505318-1-emil@etsalapatis.com>
References: <20260213181752.505318-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 677755d502df uses a PROG_TYPE_TRACEPOINT BPF test program to
check whether the running kernel supports large LDIMM64 offsets. The
feature gate incorrectly assumes that the program will fail at
verification time with one of two messages, depending on whether the
feature is supported by the running kernel. However,
PROG_TYPE_TRACEPOINT programs may fail to load before verification even
starts, e.g., if the shell does not have the appropriate capabilities.
Use a BPF_PROG_TYPE_SOCKET_FILTER program for the feature gate instead.

Also ensure the log buffer for the test is initialized: Failing program
load before verification led to libbpf dumping uninitialized data to
stdout.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 677755d502df ("libbpf: Add gating for arena globals relocation feature")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/features.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b65ab109e3ff..0d432072f46e 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -508,7 +508,7 @@ static int probe_kern_arg_ctx_tag(int token_fd)
 
 static int probe_ldimm64_full_range_off(int token_fd)
 {
-	char log_buf[1024];
+	char log_buf[1024] = {};
 	int prog_fd, map_fd;
 	int ret;
 	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
@@ -536,7 +536,7 @@ static int probe_ldimm64_full_range_off(int token_fd)
 	}
 	insns[0].imm = map_fd;
 
-	prog_fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
 	ret = -errno;
 
 	close(map_fd);
-- 
2.49.0

