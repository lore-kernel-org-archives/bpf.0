Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518F364EB2
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141889; cv=none; b=ktswX3ssqjLPTh+kVgY2G8XnSLVI5SnpA4T38+71T6XdQXlkEavNW4raNvQAgCdI4gEqCc1MjC0daXXTgR/P5yqpAAv5lR47j9TIPljIIcxVHdPjuk0b54Epq1+Qv0Iv4xNtIjY1Z4X4byqJIgBFPlOvT0aXxaQbKdnZP2u7ndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141889; c=relaxed/simple;
	bh=BAy2wS2w78jisfRWNwcbbtn8R+3j8ekGotqSONtZAxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKDGeFYZWdRxflIHG/ScIUUWZZ2dgE/+pp4hNR2IidDztL0LDJ26mXn+ayRuZO7mIDnbWs1XIh62AzKKczbgid06n3oynxKPcn1Iwl2srg7WM6fArI1G9dPvxAVtB/KLefFzUGHFsXL7qAcBqEdasTKdskSmTwN0dj7CjWhVdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=zCGE+pWM; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="zCGE+pWM"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6a0702b86so607677485a.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 10:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770141886; x=1770746686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvF4zPiM/74nGlGB7v4G21yGEcsL8UoXtHrhTAhYimg=;
        b=zCGE+pWMq2f0t2FLuInUUxgaMsdQ/AS1CGhF3nPLlUyFngRX2cmlU6PPp/QB07MdZn
         VYx9OqICdSFUOACuez1qxWBbEK0fuTfI1r2OsZkJMxs3MM3QPT+qDQ6j3W4qJy1NXorz
         Pnfae7UtM1pX4FNAnhdCfCrYCUtxoN/AKgwwp23gN7cWQjTeakuepVy8EwX0mbd0+BC+
         X0Bab2ITUCZk/WLNjfpn/SefmgDTsYkZw9CECcLUL0bjofaNJ9H57IVHRT96J9UU8rV9
         tXwTRBiA03ffTdDSigSiVBh4vkSO6u6ZbRjT87X8z7D7PvoUEYVWnMkWpV07/XUOrdje
         NIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770141886; x=1770746686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tvF4zPiM/74nGlGB7v4G21yGEcsL8UoXtHrhTAhYimg=;
        b=N1iSEWwVY/1o0UGEFbg60dJ6wLXPehIVKTaP/ypnly/zBw2QTjpiI3Sj03L90WU7up
         p97b5f4PKJX4wFVWfZPWFPUM2tcHDfTbuJ0qJSMfHIOaP0tvEqJpjMZcoQLfd73OCzXB
         SS1hf1OK5cLm8zOEHno6bTSLAwijWGIZy08tEz9cAXMMBC/5W4eu1KJEISSnd2VeOyaD
         XaONSinGO/IeWXzgmzVDUeW7w1dfiLkH+nhhwGjQea6GXQ1lwhh5TmMyRQPO7fCOsP+8
         v5i6AheRVe+gF2n/SqWXEn0eDKauZPdPS/WkrJoEAVoicbze1hzPO02+ndqS7zhxfvvm
         SwRg==
X-Gm-Message-State: AOJu0YyrnFkroL4euI1pNKr8XzAwIGf56w2uhtEsW1n4T47RdiNrDwcK
	hcod7Xht0ntHlHnJ6l2R8hO0HjoSc6LLVi/h+ymdz/i28AudumrWy76Mbf6AQxhmKcm9Zy2w1iz
	l2xll
X-Gm-Gg: AZuq6aLPP6763m4tvpwE7lea3aFJIKZX9MJFVKx2J530yzzUY3o3Pg6D2zgE2OWyW2b
	oGNVm2sP5cRHw97K+uteTk7zgDtqqn3+Lofc3tfR5ethANkvOkJYYycIpUh7x8Xh62qcgJUjw7I
	sxaymUyOnGRhqOyno/r2SXliVoLI2z6prLXmt+W09XZpiIO2lTa69fhxLlbPH2cZyk63+VPzNwv
	2q47bAzYujFrcEqlmUZoIaOacxgU5m7SOk7TCHDGeioya+c6ayDXUDOTMdZnaO45qSj349O0hec
	4e4+VzKMhcy/eDn/wMyScmnXRPNhXmTVQZVeEyiV5UaRKm3z75dVeiJJy3QDt8PxBaj4QYO6mf7
	LtlUI4Df+hyuAEDggOk8kOP83Mb/UmSYJeDvG2g6f746vlGZ2mBQlpNgCy69Q4WhCwhQGC6M0s3
	o+t4nyfK3/9ddT7z44p2ON
X-Received: by 2002:a05:620a:3912:b0:8c6:a373:c4a1 with SMTP id af79cd13be357-8ca2f84a04emr55343785a.24.1770141886318;
        Tue, 03 Feb 2026 10:04:46 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa8144csm20469185a.14.2026.02.03.10.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:04:45 -0800 (PST)
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
Subject: [PATCH v2 4/4] selftests/bpf: Add selftests for stream functions under lock
Date: Tue,  3 Feb 2026 13:04:24 -0500
Message-ID: <20260203180424.14057-5-emil@etsalapatis.com>
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

Add a selftest to ensure BPF stream functions can now be called
while holding a lock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

