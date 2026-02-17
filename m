Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8453783D0
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361033; cv=none; b=T5ElJjXvOCp0v8xpG/FUE+7xTozJq03KlKstOW81A57qqeLTKkSYjO2RIUPTDq5LUN0z4X1mSjjzq6U7Q7Nmxoeq8qnqmsrExzTJBNq68Z5l5Ul6ZIzmjEI6/DWSnja5Dr3uzYmQdy+G8Pl2wu+Hcg8Bj3MOniFFM+it8GsCiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361033; c=relaxed/simple;
	bh=djbfW5hLb3dO3/OnEcdrr5LSRIa6dgD9Gv4FvXLGCDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzL4YFV6Er30sZ2WDHOnx/AdOtYe7RKZ3QUAcoKg8amzqTMwItYvtVUO+HtgupbyYf6uAmsgIgEtXIpmGlXjX8dWebnA8JIAz9pX0n4Ju0PDrg2W9ZzUDlS1F9lHCXhqCVXaehDA0usvtvWxNdtXBS+K19Mbn0l1qWoJNn+McQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=f4eHK3Dx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="f4eHK3Dx"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6aaf3cd62so487952185a.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771361031; x=1771965831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxrB3xj+8E/lV6zQcdhMU9F4e3xwFpNFWI4mAcA9T90=;
        b=f4eHK3Dxfeja//olMVmoiTCP+CRTYaWcTOhuvouhV1ca9Shexd+OahVq1ijyMb3xJA
         QgIzAwiND5XoyDzfZwlttZOnq0eTyuHt0NmkToO8f2GzA9ayUhOF9NAFXMsgu2kl+Sv3
         cHeCGF924bDg5nh+27avKmI3PvrCBY5zdhuhKMLKRh1Rvarl5aXMZJOVtJnD1cbSyAiV
         Nq6dTGsZ4WFd3JRm7pn9hm6ZNNfm4Z7qVyBidljjaFG3Eo8WM3SuLzBi9jM4TQDMf4QK
         /bl5YHvRpRoXJu3+9sjNJhvwukb2PVRybcLIi/UqB3yRam6LO01mqaO5LJRBcVwZYfbs
         LkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771361031; x=1771965831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QxrB3xj+8E/lV6zQcdhMU9F4e3xwFpNFWI4mAcA9T90=;
        b=uLTlexFWSOM8/3O2U9lqT4PohaddCZRUg3HliZeXi/OAx6lLyxwhHMn5UoJH/cBUsg
         4nbo+gY/73ZJWDtv9NbG2IW4qRHij7SHVCoI1cET59iYAf+4gwAtussmZ7TnuYMr3J6U
         l/hyHORR4wWaS6zPvByMG6cggUq9eEytb14l0nznX60ogPmYF/B64bq8qOWAoYhyxjsn
         lJm5WwdkuBnGSS+6eVfluWX4MhTSGqJ+8eh2+6gprD9BKN/c8bUj0VHcYAu339fi27dn
         mGj8WciusWwARKU+Zr16f8cHo280fzO2fzdzDYsAz99Nhwut0wQ15Fb+IN0XlM/Bm1WI
         s0Fg==
X-Gm-Message-State: AOJu0YxQHYLrsceXecdlqlr2kclmBpUqvIUZBTG5tdkkMpXepEwNDq5L
	ZKPyJGG+dUTtN26eXGEJvniV8bKxbxlOpFxB5/2Zl1EavNbDZ9jsh8psr/7nYX3jmxDN5RP7WG/
	lLAHOO98=
X-Gm-Gg: AZuq6aILlOFt8wz6eqgNbULBdjbvFlJmTih4bmsYyPwG++clw+wcoUQZLrZ+dpE7mPw
	mwrowER/HbfyxmnVZPBDdZEJg+clECR/XbnxuBSBeyr8qw/+g0sARb/XzpWUiT5QWY+p+E0w8gl
	dlNTsw+3tIlyuraO/934y8Rxj52pJz8Gj0s237HWxZo+C+RhE+Yk1mNPRyEkCAJeSXbL1IuhqbM
	4ikmj4W9qVsZ66P9J1Ge9Bu+hkucXrEkPnBXWJxnLbsX16xK1yoOCEZY56C0oknUpG337nWJHCD
	QRWsxgBFTHZdcKcdh3JjTDNnqm1huiKTOBcJl1ptB9+2RClPEjSYHWH70YCJ01jw2nCwAEl0Gir
	RL0VhE16wnGc8Zvb4KRH12yfCffVblAXuSBoUxz8XiU5g4wStg8+em3TUuIJjMjhg7zvVBQYNEA
	2cRPPHVtiuVxSCbuwF/HIuDA==
X-Received: by 2002:a05:620a:44c6:b0:8a3:e51d:63c9 with SMTP id af79cd13be357-8cb4226f894mr1840354685a.25.1771361031568;
        Tue, 17 Feb 2026 12:43:51 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0e12eesm1645349985a.15.2026.02.17.12.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:43:51 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 1/2] libbpf: Do not use PROG_TYPE_TRACEPOINT program for feature gating
Date: Tue, 17 Feb 2026 15:43:44 -0500
Message-ID: <20260217204345.548648-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260217204345.548648-1-emil@etsalapatis.com>
References: <20260217204345.548648-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 728ff167910e uses a PROG_TYPE_TRACEPOINT BPF test program to
check whether the running kernel supports large LDIMM64 offsets. The
feature gate incorrectly assumes that the program will fail at
verification time with one of two messages, depending on whether the
feature is supported by the running kernel. However,
PROG_TYPE_TRACEPOINT programs may fail to load before verification even
starts, e.g., if the shell does not have the appropriate capabilities.
Use a BPF_PROG_TYPE_SOCKET_FILTER program for the feature gate instead.

Also fix two minor issues. First, ensure the log buffer for the test is
initialized: Failing program load before verification led to libbpf dumping
uninitialized data to stdout. Also, ensure that close() is only called
for program_fd in the probe if the program load actually succeeded. The
call was currently failing silently with -EBADF most of the time.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation feature")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 tools/lib/bpf/features.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b65ab109e3ff..7d24b99a61fa 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -527,6 +527,12 @@ static int probe_ldimm64_full_range_off(int token_fd)
 	};
 	int insn_cnt = ARRAY_SIZE(insns);
 
+	/*
+	 * Ensure the log is NUL-terminated even if we fail to start
+	 * verification.
+	 */
+	log_buf[0] = '\0';
+
 	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "arr", sizeof(int), 1, 1, &map_opts);
 	if (map_fd < 0) {
 		ret = -errno;
@@ -536,14 +542,14 @@ static int probe_ldimm64_full_range_off(int token_fd)
 	}
 	insns[0].imm = map_fd;
 
-	prog_fd = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "global_reloc", "GPL", insns, insn_cnt, &prog_opts);
 	ret = -errno;
 
 	close(map_fd);
-	close(prog_fd);
 
 	if (prog_fd >= 0) {
 		pr_warn("Error in %s(): Program loading unexpectedly succeeded.\n", __func__);
+		close(prog_fd);
 		return -EINVAL;
 	}
 
-- 
2.49.0

