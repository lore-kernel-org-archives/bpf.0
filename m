Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1FB390218
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791385565; cv=none; b=RYQjf8861e3D5dvJuFoqPFT86YS/dviO0Zu2A9k1M0pwDmxRgXb71hczFriG6w1I83wKHkbBrrCxjhjqgufXdZZxiiXbhp9P+WnhNEcEKaTpvSxE27AmCCYqejSDmc0Q135+JDE1QjlvqZ1Q78Cq46z1y9ilQAr+gGAt776CKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791385565; c=relaxed/simple;
	bh=BuxgSdj9uwuKcVpI5Xz1omLt7G33cgkXilCJZJKKC2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBvOupfXob2rtaHWuo8GZrogjKhDq8YOge4CUgLQ3oJ1j2qdFXix/b2/3JRjHhxyjrb3o5X1sNwrG+DPFyJk1AP79GwCPmJi1MK0zby9y80iruVbY+3bqmpU7QgNa696zcwXg2cpc/AU2fgmdkhmNI4f9bZ7sLXsfbVHK9BH1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIfXJsuK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIfXJsuK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so13597615ad.2
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791385559; x=1791990359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OaWPz8ymTndY1UM0E/ig3g/hxMbCy3R1NCdfYqgDgvc=;
        b=lIfXJsuKpQqgidzcnIBz0v6zworzLydlmNwGljA4c57QOIotcDlfuE+ku5/dKJMhV1
         hBQledV63yWHxyxxizpiLVeiMkoQ7AKmvlQ5AAk5klvJW362IwTSfJOzUC3AMhv/M3sq
         05G2g5i1ItZ9DYb5j22Ab7QQIe4PA8th564UTorXJbtxo9onfZQR/95TAJNzAfjpyjbB
         XPoTd49TsJWnnVZT5gK+itsUit2Bsa+rwZEgkAxY9JrV8Vr8lolp8oTcSbv+H7ocHeiq
         j+x87FyjcaoGq+rqRkdpTH+wGV+PmU4HLd6IQJirxve81X25lAgDx3sHehSH28UJRnTd
         ktog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791385559; x=1791990359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OaWPz8ymTndY1UM0E/ig3g/hxMbCy3R1NCdfYqgDgvc=;
        b=t1OqRFs0F9MGxQMzr8heZ04/2MjNaxmcDJPGvaXNNzu7RIvfILqW3cVU/w2unQw1Ac
         vXS3IpdhUvgPUZlFfcjW/lSMcxxFAkObmMct+SNqRgq4KIKWzhWbTER3eAMge0asrOmA
         ZZyFlmok+NJ6S9kYd5vVvuvVBKxP2cwyDY6prBjT37K0FD5xsAZhkd/uKvT1IOyp9vIt
         hPhgWJcNzwMVMki+5c+IxS1XND3Qp1Hlsl6GjCLbFmJv8EM9UVS/+2jQZZIdU67/RnDr
         WqVy7YKDehMIWiCap9Pskbn+dNjzPcnCLwmi/ekTB0/lJoCRpdLXP7/0ZAOEq5vzdGrM
         jkJg==
X-Gm-Message-State: AFq9FYKabsx8i8b7zD4/457pxlSHMg6EtunAPztB6UmJiV0+8n4Fi47Z
	88qVnMVdiLRS7nJzfF2y+redB9fx46nifGst/ZgzqCZcvxU7X7b58VR+kkL1DKPKfpc=
X-Gm-Gg: AYBFou3jS/htvEC/2NZ9Egl489vXdBETiBMDR6eF1VD79xJ8+oe4VKkOrLZLSpACueJ
	/kkUg8GLCmVi4vLf1BpmTdxU8apq1yRQt+JtPOIusTQ+qQD/8EWVA2AS4DxZflgo/eyLTa0hx5x
	H/GOtImcmjasx9Z7O1nLAk1rxpOSiql/P+n8cabBjF2ZEH/alSUKWYy6WjfjPsZadhi2hJfV3iS
	3GD6IP1gaAVFo8xf9wYn3p9VCCmEvmuUBCD1GSoOLUdNvTZgjqrsLo1DaFlq2mi5/XyFOJ6BUIx
	kZtv3ZCtmXGdFlUxR1W70sYRsKq06TWWSBuO7EQUjdqeXw6O5ypeLywfzI8MQH0KSzePCGXMweQ
	+fijqscuduN4Sf15QnLJNm7hRoKKV3SDq8ukkYLXUjGSZmubSZPOTBe9jvY6aNW6NsZsWtfDsEA
	/SW4lQcGVK2888piKuBO+6+9Erep0UiwCAAr0DMEgygQbAyh0ArhdGIwnQVe12pHzJjmYLyig+q
	yx91JUmWMcEXdKnS8qwgw==
X-Received: by 2002:a17:902:f690:b0:2d8:d4d0:792c with SMTP id d9443c01a7336-2e6003b690dmr22740805ad.16.1791385558962;
        Wed, 07 Oct 2026 08:05:58 -0700 (PDT)
Received: from DESKTOP-31QBR7C ([103.120.166.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604b63d9bsm13249255ad.84.2026.10.07.08.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:05:57 -0700 (PDT)
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Subject: [PATCH bpf v2] bpf: mark kfunc memory size argument precise when buffer is null
Date: Wed,  7 Oct 2026 21:05:49 +0600
Message-ID: <20261007150549.1334-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_args() allows a null buffer register paired with KF_ARG_MEM_SIZE. When buff_reg is null, check_mem_size_reg() is bypassed via break, leaving the corresponding size register at argno un-marked for precision.

Consequently, checkpoints created along paths where a nullable buffer is null would prune against arbitrary scalar values in the size register.

Mark the paired size argument precise before breaking when buff_reg is null to ensure proper state pruning.

Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
---
v1 -> v2: Fix email formatting and whitespace mangling in submission.

 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 72a3f5998dd2..1dcca0c737e9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13191,8 +13191,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return -EINVAL;
 			}
 
-			if (bpf_register_is_null(buff_reg))
+			if (bpf_register_is_null(buff_reg)) {
+				ret = mark_arg_precision(env, argno);
+				if (ret)
+					return ret;
 				break;
+			}
 
 			ret = check_mem_size_reg(env, buff_reg, size_reg, buff_argno, argno,
 						 BPF_READ | BPF_WRITE, true, meta, &failure);
-- 
2.55.0.windows.3

