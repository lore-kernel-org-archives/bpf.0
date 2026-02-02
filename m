Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6FC2DC763
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060799; cv=none; b=DP26TOPP548gRVwBYqHLuR0UgWj/O+HCY96uw3SHyQPmhJ1XrqbQdf3l2yCgHIlISN1kU7pqDvpHeVKjicLpJNclc6DXL7thTPJBU2caRrnWAo0E7XYsaue/2Qce6X7OugKe8FMysQtr5SiUq0RB22z2tjZMcf9uynq3TnK/OmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060799; c=relaxed/simple;
	bh=B1wnvNrdcViyegMBeIbZoeRshu2nxdsMOLRNaeSDTmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVtxy+vphJZW7/+eDYBnQuVel1QY5bfGAakYc7sQEaomlgxhqSazCEx0tJP5qlXJJv9E2rfzMoIzCPpQ5I6+waibvR+6AZVn3IhUq84erfEYOycM5vsg6CGy8eAhONxtI77ns6Jzpcb5cDkpDy8Z2qN4NaN4E0xqEFyHty4HMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=B8zzSwf6; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="B8zzSwf6"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c59bce68a1so367675485a.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770060797; x=1770665597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJPravhn1uH4S+6wlTjkYSFdvIbfs8bYIJsMU0Suppg=;
        b=B8zzSwf6xfX+8pc+x9+O8U63Ng9KtAfMbe8WKpRuEkTp28z56KgZ4RpcXX3VV3Hfdi
         9yyqnJ8+JFsZagap8Br6YXPxPZ83hIhObE7nzNPF5JArrQ/T/cknxmxhYAltXVFHiW5p
         +NhK3ym460jXFWpVwmLfD8VXn+rugbzE4whbbBKcgNz0NEr4YZYBB5bB01pxbveopo/7
         yCUOiWe6DjypSTGrheYIfzK7oB7AtcuJJ2nGTlSuZwVUfEhivxKhHhxB+9RFjdn2YXW3
         LPW3mr5ApCIFyldqbl/dMvyJHBa7g4xkm9qFemVyG0JioNqXa5bsp3AOk3HLtKUQCyUe
         MPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770060797; x=1770665597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJPravhn1uH4S+6wlTjkYSFdvIbfs8bYIJsMU0Suppg=;
        b=EiQtlxDZ0QooufaWWQNGfifdGL6B9biN88hj80uwrtBAPg3XqmWvoTU1r+6RMfc/HV
         bt/B3xBKMNpLXOlTz3AuFTArKNwh+RclBtGQdqC0AKFkErz/OnBTo32DJMSq3JcXwBLC
         0atPWzNNbzfi+zW1N514HlI4x6XVwCK1sEwL9kyDmFLZpMYa76CjIPsvX4NMx0FTjB0j
         vsw7Qy3z8eMjlMskFd3Sez9x45Z//4SRu1ITyGgRf5m6VOwiEJgKtq99sx4whJ/wFfv4
         n+81ogCfTma0tNkWdOtYaSj1v+HBHgDX7SnyB5e6UGGhKeiPTKECFkDZ69O72OndMeTn
         U+Iw==
X-Gm-Message-State: AOJu0YxxfS0wTxs144X8jYOppMKyOWVkVRcVjQByre3G7iZ4Z1v6cY38
	xb0rRJkGPURbAHCNZZhxoO+n7iUs5LxePI0WgDKiFwZYC6AsXB0eRDLzd7aGgIKjtoq+aqwwU9s
	cazaR
X-Gm-Gg: AZuq6aKxJzTBRUOnTuBodNq6MZ1DYukCPHn0AfXN6jSLCuxtkxgE8eivLsdhfJcH6AG
	BwIQEYH1Uub9Z0MiGJhedeKZrSmUC+oRd1EexrmX0hCRgXTb+W2UoHng1BcA3dWCp0WofYWAgYc
	YA+oBDeNzIiNsu815JXEN3DPY9mHRvO8p6ON0LwyBoTw7dUAKGPPzOdR/IKeF9OisZjaVEqYwHQ
	Hjrdd4VOcuiDQB5r8WRg886+jsmL9LfyHl1zA5RNFGibmy0ylgwWEVcGZswF/Ets/pE/D+mH84N
	myOiz9WoyCPV3lHmSfkYMJJmCAw/WpjoCQVNkXPRrllUWFXghml6JHnlkEST+LYQl5TFlyva1n8
	+6h4zcCwQWi/37/rQwdg1qWUrmkbY0p/Y25h+WtxvUcJ6v1Ck9OZSen+CxU09RRVIbAsygo2sjy
	CzdOzm94/eTA==
X-Received: by 2002:a05:622a:216:b0:4f0:21f2:cc98 with SMTP id d75a77b69052e-505d2264d85mr149766541cf.50.1770060797138;
        Mon, 02 Feb 2026 11:33:17 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745d7a9sm111971941cf.5.2026.02.02.11.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:33:16 -0800 (PST)
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
Subject: [PATCH 2/4] selftests/bpf: Add selftests for bpf_stream_print_stack
Date: Mon,  2 Feb 2026 14:33:09 -0500
Message-ID: <20260202193311.446717-3-emil@etsalapatis.com>
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

Add selftests for the new bpf_stream_print_stack kfunc.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 tools/testing/selftests/bpf/progs/stream.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 4a5bd852f10c..f63b378de090 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -234,4 +234,25 @@ int stream_arena_callback_fault(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
+int stream_print_stack_kfunc(void *ctx)
+{
+	return bpf_stream_print_stack(BPF_STDERR);
+}
+
+SEC("syscall")
+__success __retval(-2)
+int stream_print_stack_invalid_id(void *ctx)
+{
+	/* Try to pass an invalid stream ID. */
+	return bpf_stream_print_stack((enum bpf_stream_id)0xbadcafe);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0

