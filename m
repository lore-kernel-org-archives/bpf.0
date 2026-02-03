Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F93EBF19
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141887; cv=none; b=EChIOYC1VV4ytBk+QF5qDOvYxzs18LIybA+q644ScCoGtdLAsnBEdBk1Rsj2vYVlKCD6Hk4Nx+1JTmJW9sb4ZSah58Q7zsRORYsOq4j3tsFyvaCTAWJ9/GzO9NfRlW3FjaTSa7Mn0Qowd0Krvt1kpgBiTU0vLUayhnJIoIEufdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141887; c=relaxed/simple;
	bh=j12EPnvkpt6wo+qlTgfCUfe+F+ogYsHhfcZu4oLDJak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXQi8DaF5jIgqJZ0rCMhoz/6dMbTqTb3Ro4L+MNnIA34Znzsejyml81ahzIiB1JPVcDBtLUKw1CyqmENrlYIbrnLL7mt6V9Q7aQeVOiR3W/hTOhdoqB2jGDrHF2iPxplX+3ACnY8/e1SP1W4C20lJGhXjqVV3hjnDbYxsqGI/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=e0nYOG6b; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="e0nYOG6b"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88fca7bce90so74559746d6.3
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770141883; x=1770746683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuDceZ9cEzQ+kHDsvUF6wXmbsGU2yS3GWijpn9Vnbpo=;
        b=e0nYOG6bSi5bJaz7YpwuJIzqEeFwBm+lYk16l+BgQltN6w47HL/DaoWCAf8I3sKn1A
         9f8z5pe6j2eeZRrnhYi9YK5WCTdA+2h9qNx+MNj63ZknP7ryXpwrJE8lZNJpVnzpITR9
         XvaKn3/CTEtkDsuiRO//gp7D/O6iptoRrqLkAjmXzDwXM4DwrpbL2X7Z+4RQo0x0E2u1
         LnpJN4+BJzunWH869Oo0eNBhMMftKHi1qKug/tyWdeYXkY1EUJl4TpqNMtKuUIM8Unwp
         PSbmKv7Wm1YY8B85GGgk8gMqmuRRi8iade/KRiP2EEN8/d047zGdT20gCmKoWfwyn/Ab
         BkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770141883; x=1770746683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WuDceZ9cEzQ+kHDsvUF6wXmbsGU2yS3GWijpn9Vnbpo=;
        b=Wamy6SN95rIhBEm1/Ndk6RmvBV/Uqgom5R1nXEZbs+0tuiowENjVK+Qpe8f7uMUMez
         OpSlzvwxmEcQBDU6qt/e03o0fg1IG4KlSzIJGucr+8RaCuxZCm5xsv9/NPJOC26nnkel
         EhYymomsgGQhjxL7Tj7XsAkNFq/Zd2cDHhjE3AebcAlJ1NK28Nkcawz8GNDGbv7V2rcO
         NqVEGcJBh7cQsRuOY6fbwV8NBpTLgZCDab5YkUNoqjqiu57vqfsCkHmG3EFqG8zD6sRV
         EAR0OK2sxOG3NbmukZvSnzCp+kHyenncsrMzpcaYTYhFTqmAU7G+0uNdUw0K6SRHPTVO
         5+eg==
X-Gm-Message-State: AOJu0YxNkhWKPARPaQ3RLwRVCRU1AASawt0AzQ49mue/C/a3U/4fy3zk
	+eckrzfADYTi8nOztYWWrkBjb3eV3mKqJ65g69t4sHtg0HGQZlMtrhYKgBb33TGUXVrf+58OhXo
	X45Ik
X-Gm-Gg: AZuq6aIG7tiovhtQoyVgs2jXdPe7ouLeIF3KnYb8eYRoEOyzKKDqG3e/14ugpkKJQgJ
	prjsUo2/a3Km9xgvq9e9egvIHzwMNmszPZ7Omr13lBF/YGIW3uggSbEb3WVo5PLn/iWFIXSwark
	LorM5lb5oRbDy0d/X4Gnu/8htQGyPW9vOorqxcGRFrr8o7+ml1oKrLP1Yxqc93luLGxquYUzvTn
	OY29RG+eh8uz+hmltcQCesW3MVf3XfKG/GNEFEqud/qcaHsWogNW1g0Y66oNA7ogillRDZtfGjB
	t/7JtMiBbKaD9RW5eCYjw9OP+2AlvXV30QkGg/WblMGU+bs3866hI6d4yn75kRE8gehzEmosbZJ
	55LZh5faXugIPhT2rZxIfZxak+ix1ub/f32GMmb0LWdmXTCfqn3ZQxyja8yDiNErnYfFXiEHqOR
	qMJwVdqj28f8gYZi4N9qB9
X-Received: by 2002:a05:6214:130b:b0:88a:449e:81a6 with SMTP id 6a1803df08f44-895221a58dfmr4411436d6.47.1770141883241;
        Tue, 03 Feb 2026 10:04:43 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa8144csm20469185a.14.2026.02.03.10.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:04:42 -0800 (PST)
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
Subject: [PATCH v2 2/4] selftests/bpf: Add selftests for bpf_stream_print_stack
Date: Tue,  3 Feb 2026 13:04:22 -0500
Message-ID: <20260203180424.14057-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260203180424.14057-1-emil@etsalapatis.com>
References: <20260203180424.14057-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for the new bpf_stream_print_stack kfunc.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

