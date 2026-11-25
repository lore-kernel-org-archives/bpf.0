Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601804;
	b=M1ow0izTXoxkdcY1NCcBX9awuWHMCaHDnRqZ4PJZ/bdiZhJIVrJ0097bq8zrkjQsesqO
	 qeFazT0DqjyXCetuRUSaxrzPQSlxgN+lbbKnWaC1G4cQlPWO5PlR3JDuR4DhJRVGp3DjI
	 MC0srAfbBchxwjJPycPSa7EvjDPZvo9FhuBV5fJSIljmxl+1woROFkFfI0fvrQaASaKTK
	 FfuovGFPIiSh+clEtwImHvp5cya7CbFylvTO8ENKJ25qC/5nvbcMTuQgkX5V42caB4Saq
	 anJbphJXHc1tAFEt4FMicQZwwCUJUVJGl5JbeO8bhgvJOzoSNp0ziZBR99muDQnyOYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IFtO+2ZXdFvVLtcc6CSKA1c2Tq7tlIg6nOO3NX1HPvs=;
	b=uM3cbxVrGXi5+XcnPzEMEmXrG0ekgp30QXx1Xdg6qVYEZ8XZTFNBFgVCMZ7OS2DQal9P
	 geI/qw2g+PXc0Qpt62YLgaxpOXSLYpgdlSbYRFFnIUQiBBZbL1RNLaKckyqvuaUVoMUh+
	 NWyLrEbjuXK7boNyhN2Cs8dLPcPzNK8bVPmUBCHwTnCrOko8Bw4ZucIhI9VFhsPcU6enF
	 k79nsH7jTYVBmwU59ISBK9QBVB7BMqbUV2SS/5iiIqsCSmXb1dYZl+wrPJPHJRSVyY4dU
	 ETnKTuq0AL3pyLrZbS5n8jctxrLkgHadbPwu73UG+kQEyOYNexwb0BjC3HyixychMRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jjxk+FuS;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB478606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB478606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jjxk+FuS
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c515369b627so564575766b.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601802; x=1796206602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFtO+2ZXdFvVLtcc6CSKA1c2Tq7tlIg6nOO3NX1HPvs=;
        b=Jjxk+FuSjutGInOhfX+YCQhusD3MiaBFwj/BpuqjUCYUclAwE7pttaYZfYjupt41/1
         6WDM75X+EBO7EwvzLmWycTEL9I7PiTU/RI1aDzAZ0p2TYspMYuuMcVXC0b1bjsfYeGmU
         BpEmobrXIxDMKnU2QmcyKaa3fLoGHitydg4K/9BDw1ROBKghCg9hj70ItG22RRX7kTg2
         /JIU4K9ugDNKbjuN/DGSZnEL8ThyKxxz/3OUaEkEwIaKlShotU5a0QLKseXznZPyfm8t
         1xAuAappja4NhqVrDhVXT7PDlSd3JOC+ZAx1zzdKla3ndRu1Xtbtqx1V4NtcHerwQGZ9
         2IWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601802; x=1796206602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IFtO+2ZXdFvVLtcc6CSKA1c2Tq7tlIg6nOO3NX1HPvs=;
        b=WYEo+2CiA61LOwbGxscxP6wPnbhav2w4yHlLdspEkXJsfgcvcJ3z0dSisqSy0KLycU
         Ibhj8Cduj2OtdprgeviP1hgiRXw4lBEn9HBlSpoJ5UhFhgnU7UBCk9OAoVoVDobaf6V0
         ROtW4EujkyyOyo4yqFDyxLdTQWnZ+pODp7elD38gvSpUEZZBhBqMg3v7QNMacbne+3mj
         lur6oiNfz0yQ5LJscudqOJlj2zP+zESDWSyqAa3vcAhTf6u/zK5jUu3M6rVlMIoJBecI
         U4sRfkpDy+QoILa3fre6N1dWSKVaZ6hJR42a7uB5lWtAWLKFHsVG6jIZcNdp4ZtKacjn
         xGUw==
X-Forwarded-Encrypted: i=1; AL+hErEOxIn+pYTgIW+hJx0eSHgz86ksKvCzk4HP0BJljNX+6zoUjW03E0JAIcxHEPm0eERpb18=@vger.kernel.org
X-Gm-Message-State: APuU4Z95WK3M4UWEmh2+P3ZoppI1UFPOyAec57a8XtykXMqW05X/LKdC
	+ROG8yXtRb9qNxFTqipvAO6dbl03YbAIEwa8ZjKsm0hsneA3810MtS+E
X-Gm-Gg: AZFdTZcpKr5b8DW++JgRq6OvYPQJ8U57YjNkg6DDrC3JnV+FzqJ5EIQyL4p1M8pYeeD
	XvRspqsTL4wZ6t7/bDtM4S4KrX+Q4bzKFMQTaJwCqbjoPnQuOCL/DCS1EtLReeMzn4xwy5agI84
	4TBYs42/fGD5lr0ZDOgOect40mOE+eO1ar8hjju4NRjv7VFW4trAWTv1p92WypY5eyt7k0N7HHM
	R0ed9SkVi0pQr+1sSfKqH85mXstqSakatTiGb+JIpPb+8jGLvHUB72hD7Jhvi96qOK/SRobZRLn
	/bWltJs5kYZZFbFEi8+0ZOzx5VFbLb8qRbZzRdKVm+IGiAAmK6wLoHFM4yoN3BMwIvx6BZcVoz/
	Upd7C2E4ZI/VVtRwSN5szpu2RR6XTYozTZtgq7Ld4IOrDF1i5TC4z4IeH/viO3MSQWqEuj6Ln5e
	evvZqBjSlc15Waer/ASfowqKppTmBr1ZcprGu0AiIZj/d7vmUOYmMYY+IHn+2VUE5vblfgqbEg8
	TqYp1zgxbEhk2cqxBKF2WkRpxalFTvc1KLR2G6DQRZ+37cYA8/M5bg/qJD6JdgvehwE657ZDQhx
	9EcspUfv9G6AJjihGPQTvj4WnwAjoD954dGqWqsyeDnAeCw=
X-Received: by 2002:a17:907:b053:20b0:c49:8fa2:4a22 with SMTP id a640c23a62f3a-c513acaefdfmr956260066b.41.1795601801934;
        Wed, 25 Nov 2026 02:16:41 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm34765938f8f.29.2026.11.25.02.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:16:41 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 1/7] bpf: Require the JIT for fmod_ret programs on 64-bit functions
Date: Wed, 25 Nov 2026 10:27:58 +0000
Message-ID: <20261125102810.699464-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125102810.699464-1-a.s.protopopov@gmail.com>
References: <20261125102810.699464-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interpreter returns R0 as unsigned int. For a function which
returns long or a pointer a trampoline may pass on all 64 bits, as on
s390x, and ERR_PTR(-EINVAL) becomes 0xffffffea, which IS_ERR() does
not catch. Commit 3c5d146f9c69 ("bpf: Require the JIT for fmod_ret
programs on tagged 64-bit targets") requires the JIT only for tagged
functions. Require it for the declared ones too.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7013ed8cadd..18c7b9a6f456 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24882,7 +24882,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 
 	env->fmodret_retvals = tgt_info.fmodret_retvals;
 	/* The interpreter returns only 32 bits */
-	if (env->fmodret_retvals && tgt_info.fmodel.ret_size == 8)
+	if (prog->expected_attach_type == BPF_MODIFY_RETURN &&
+	    tgt_info.fmodel.ret_size == 8)
 		prog->jit_required = 1;
 
 	/*
-- 
2.43.0

