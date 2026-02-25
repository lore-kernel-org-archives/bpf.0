Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A733A1A4C
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036643; cv=none; b=UzIEu8XTu6ivSfHHJ3GGUAfWam4u5MrQjdM2sES4Ftekhciy2CRhJhqHpQC8UaeRxBOWCDCFN+Sgl3nX7Pvz7XJbfi4bYraPGxofTO+cpo8vIrf76TVa3rDQG1R2ctcEKXXhNBn9cYjqDR0WjPsXpvinpk/lzpxj6P2sqw0qXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036643; c=relaxed/simple;
	bh=kokXdhp7comMoc8tXu6qzKlqHIvgwiP47cl8SZ+yAWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tpidBx1F8ckQPQAi3p29akHLMBD+oPmmcARztrR2D4EV67z4udlPJ0OswANJLZRjy68qT26/fZ8vuLPQAUTAbm9yoqANm6XiEEB9uM1YMmbXVKCZ4X9veqLbAUlPckBw6omQVS00ngwsp82O91PSuqYwBppVHOHLWdmz2E7oZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFh73sOt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFh73sOt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-436317c80f7so788297f8f.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772036641; x=1772641441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnsxlxPMXF8aCWWQMyPib+q0YuCYb3YUUqixUPRS0hk=;
        b=YFh73sOtpIR/XxZVtLizvfLJxuGddZXPkS2CFM3DB/iCy9jIlhJ9GRbSwN+5RavaSA
         2YvhGXBc8Jy0TZym3FT4X4gZ63CkWtI/ebqYmPTL0c8z7nXxktTxpXWYhP1MuUZN/w6h
         fugO7dM5Vuo3la9kboqpD1ycySJPVySKEWHAGweBpAo0i2AvXNsNIqBynn/R7rZPYqAw
         18slpLrRpdi6vg59mz7vBmgOqONFUFUvgG9CtrKOPRnVt+DaJVEW3DoANGGHI5GIKno6
         CdnhUCm9PtvkN3oUVSEiUjD6TE4Bv+P+iP6mvgxAtS73Lr9XzzocOznI4V7YUQ3SSAmx
         7bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772036641; x=1772641441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dnsxlxPMXF8aCWWQMyPib+q0YuCYb3YUUqixUPRS0hk=;
        b=oAVet0hcLQmiXo4pEGpQL2V57qIKeAdH0LMiJQ6CWXR5HnGYzFVDd0StYMOk6tq9VW
         L7/nbUBfzSNfFELSwA+siB33TyaIGBFS6yge5gY/uxOh0lcRFffhTgas5DIsbpeVGqC9
         Eer/Z2YryyyfqDwuJctQwvuEQZuiTB092m3rmPZ0AHZPOW50EL53PmkPHxX/Iz2rfUV2
         yIgV2yquwCkuh1ffFnMKpqt7XfyeE8Fc3rUIhpWQa3xt6O7lySCjmmogozDCc4p0Nfio
         kX3tCxFanmFAzY0MT72xxJNk150U/SFvv9sN298AmbxI2JUv+rZTpqkGfrFe592fcCmF
         EhSg==
X-Gm-Message-State: AOJu0YzREozbBQZ7C2ne9K1BxXGL4AI6pqUwcOi9W3eVQFbSfIF0Z+lo
	QCYg4WKyUw7IKiz1efj1Q17xB7sKVoMedvAs5SVp1QHvS5flDqWT0JWY
X-Gm-Gg: ATEYQzyrrxoY1MrXNoLmM1pfYovLmXDcs+AX7SlgUX6NOVs+rCqqkDTjSLmW5XVbFEu
	1rDhnorOx/fDBJMy16abaNaVvF3K/cld5fiTlsOpXzRcc+tN4poUEDmiJj26mHJ3EjDkP5Wxyv+
	Avae/PVzINRIdMDhI+egKgZC/djAJPRbfi09j4yvO75fk2DarsexaETB4s+n0IEvSof3y84FVos
	x/A842CaijQh+HTMW89u2Z3Hm9HHh8oK/utpLXq6a4H4WnQpYz9iAxezzUKKG/Pb1FxTY8+rnyj
	+qUux+A019EH/TpagrfoD8A1rweITzDIHZyWNEDIsgXUQTdIIc45LvX5KqSk7DM/TLSi/NmVRRb
	lSdtk8gjiFV2Yn3QgPOkwE5n0tKB3jRkENPsS36Gn7cfFVn0ioYU5mdNZ1ryOcEQJieOoiCvhEq
	17ndfPOv92ruQFBIIPow==
X-Received: by 2002:a05:600c:8206:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-483bd74eeefmr72513545e9.15.1772036640450;
        Wed, 25 Feb 2026 08:24:00 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb1afcbsm35876595e9.2.2026.02.25.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:24:00 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Feb 2026 08:23:53 -0800
Subject: [PATCH bpf-next v2 5/6] libbpf: Add tp_btf.s section handler for
 sleepable raw tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-sleepable_tracepoints-v2-5-0330dafd650f@meta.com>
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772036632; l=1230;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=sTYtN/ZyNNA8Z8IaN3oa0kklzd+0Cyskll4lZJFhCKk=;
 b=5M+c7yxrH+YjtRskYdS6o7rKBYm6CdWwrLpkGG9urkUswrdREfsnSVId67Pur7Pz0AT9HxE0K
 DD4fkiJduE0BFcZ0clYBWtLOg+R0Ira8aU1ahqt53wh3h567/z1S28L
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

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
index 0be7017800fe..7109697b22b7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9863,6 +9863,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("raw_tracepoint.w+",	RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("raw_tp.w+",		RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("tp_btf+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("tp_btf.s+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fentry+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fmod_ret+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fexit+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_trace),

-- 
2.47.3

