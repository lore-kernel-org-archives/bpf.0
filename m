Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A73446B5
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430505; cv=none; b=XJxUWV9VVlkyce6wYso/sob8MUr9T7BBKiz8vPFBZSgFjqZZK+V2XvRS5deKRlbq+12Ec4nB2HzEk7VyP+fJLvNH0uJcgl81AvuPEb6FHH4LxJmsqBeoE0tG+g3jw5BPqiNXGvIUUEsN1NEcFTYdkIocUvBWGVYSyxmkHHb53BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430505; c=relaxed/simple;
	bh=r6KzobY856m6UYM7nIksd7uqzkFUoe3+hRllek01hOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vCWV8HC08NI5L9vsbRd9n8/V+ZQgqKWIk8Aeb5p/KQ/NpU6ob15nyTtj/wLi4hM2tb5BQs0Xf92XDrxGq9bV8189QI2wWqd9rQK/4tbcGrbGVQlH8gTvyIQWncxhA0uCXEygvjWaTpWoD2htJhJZwRxzx4dYhikT2C/eROm7ORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs2yUDlm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs2yUDlm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48068127f00so58554065e9.3
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771430502; x=1772035302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c69agu2eMXDfIrKYc3glahycpJyRaFCB1UlDbv7SzxY=;
        b=Cs2yUDlmJ4QiCZZdpdDmcDIsTOnC7xXmW69/4pS9Tij7al2WUrO1vH6OMrHP+pKyhI
         CumsoobVmbfN2Ojk3q98E3/DTjkx6bqpZ1dYl/dEhmSpPo2kcYLXEwTM2cDxSNYXOZWm
         0I1w9Sp7IQclY/f2VLAMQHy5WxH0u01pGEMXSlMkMTzQgAUCkd2a5khxhiR42MNgPoTE
         7LfKUhKjZiYGMjRL5TU9ZUyBJ8QG2tjfqmmFbJRkcIVStlom6uQH9WeDO+Owmf9iJepQ
         G+IiLlrP2FbuTjlYrbdNthExIGdFBT2C/2/AvCSvM0Ymk0klTKEdVZ+FWP7MK1WJif9E
         Z0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771430502; x=1772035302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c69agu2eMXDfIrKYc3glahycpJyRaFCB1UlDbv7SzxY=;
        b=odK9Wkup82uyObPHhlTCFcFkb0tNpYZTQ/06FLFIKfJ0aGb/gvGrWlYKeOXGwiCPL1
         GoAv5qxdTOZ32QFaPhzRAcwTEaHqa+qKys1Sn79DtZbepoaPSt0pLjcJfueedMD4cdEL
         cdWAHGTEAsTP2Idtn60Rhhs6evj0vFHs/GHlomRsEieMtGrjxz0n81Yybp+24hm/qf/0
         52V9gddlIS9hQmMWQqf+YBRYbuDIin3bonnbpyq0+dSy7QUqHIcSgP8SF0cK1XWVQE3x
         aebsj+cIcWMOiDipATxPtKP0rqyukvlFvUEY7XXVdZgHoXLNdxZ+cJ0YHtv5/6z/x1M4
         D4Vw==
X-Gm-Message-State: AOJu0YzGFz+Kky97YBHHHpsPFk8T7tl1noEa1BDDKSOaZ/L9sILoN/MR
	S6uxrrPU77+O+rz1gLQtSfQfcHrmljOmhiLcSz8pYrbHFrHuP3x1wy34
X-Gm-Gg: AZuq6aJDuKWf28HRf6mQniIUg3ByPkn21EsFPOFKsb9Uv+SnN/gXxgBuLUHEC6K05X0
	vqAZGaRWsfwZnyn6GYXvEvCwoixiSyDE+cHg/w4bkArxyU0lrxcqzKV3KMu5n4bGJVNh/7qttqy
	FiX8JmHr6sicEZ9Sm2ZWs+iW957zYGfoBvhHMT11rYvLBLYdf4TI9wxmdE6aovYMkOH26i8dnPD
	1RNx/d8NeHLeaGQEyWLNrKNgp/WFDOJH7p7qeAYbef13+/sP/G+CGrsuRuo+GSrDlK/e91Y+i85
	pzozthGDpjG63ed2wSFepwzlWjZkWYg3mWahgc1zohDQc68Zdj4L7YcpsaogrJf4G5SmHxiVCpl
	nzeYNyRgrdv0X4OAqrncOAB8RpxFOtCLyLmQ+ULRQ37dXV71Tw5yYb1iabPMcExFFK70HtwPSR9
	4Vs17V/m0=
X-Received: by 2002:a05:600c:1c25:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-48398b7b130mr37928735e9.32.1771430501760;
        Wed, 18 Feb 2026 08:01:41 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm672367145e9.3.2026.02.18.08.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:01:41 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 18 Feb 2026 16:01:22 +0000
Subject: [PATCH RFC bpf-next 5/6] libbpf: Add tp_btf.s section handler for
 sleepable raw tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-sleepable_tracepoints-v1-5-ec2705497208@meta.com>
References: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
In-Reply-To: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771430494; l=1286;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=mVtZ0pOrSyAFPIdKm4F2nZO/cqvPsMzXy8DMWTzXcWs=;
 b=gE2biJYMDoFrgy2xVT/8dHjT9hrUELC/IWimlik6YuOY9f0szVG/FYN2HHSBymtVnXc1SXMAN
 3a91cSe5q6jDby62nzUxd2U03mXkuJGDHNAXZ1GL7Gl1AuA8iSlIphj
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add SEC_DEF for "tp_btf.s+" section prefix, enabling userspace BPF
programs to use SEC("tp_btf.s/<tracepoint>") to load sleepable raw
tracepoint programs. This follows the existing pattern used for
fentry.s, fexit.s, fmod_ret.s, and lsm.s section definitions.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0c8bf0b5cce44462414e99a958260e940148e818..e5be88238d3fe589b0ded1c46bf03f26a4e64bb4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9854,6 +9854,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("raw_tracepoint.w+",	RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("raw_tp.w+",		RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("tp_btf+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("tp_btf.s+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fentry+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fmod_ret+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fexit+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_trace),

-- 
2.53.0

