Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D73E8674
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253385; cv=none; b=B9TkuJRhVAWjCuInujmLOu+AxvQi/SYXzHXwhfjsdhWeFDMkIWThZI1z7lbv+IW++lFBFSO2DpEyrO4YjV+pgLQ1nxHWct4W1qlVRY0A2bkwdOjZ5b2ptx70E3EFyBDiteEUKS2/g9Mp2aGH4u8mrs0m6DAUklz4Fqq7JjkHjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253385; c=relaxed/simple;
	bh=tu20uvVhUf0HsrBXmGavDtu/SqoiOL79Kus0w3CJ9zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwVpMo2qD3IEJac6C4MsQgEMrYYbEzIfBvIiOKVryZ/pkODCblo/DQLHse9SiZtRxmRCFds9KvdlfNiDACfVaOCdEdR7vVWwWsejORq4z1pUxos3UgjBw2oRhMjHRw46LpnpbL6lhHBcsV5NeP6uOebsdFS3fzCHS7ewBF2I/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mt0l7k+R; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt0l7k+R"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso1488615e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773253383; x=1773858183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJigsdVD8XTz4GskV0xyxzrPfLwFWa2B99gGhThV7/Q=;
        b=mt0l7k+R3BmK8T0B0IVyM3ucem28lO3fuxNxZwi19bZETYFTzHP+KgP5LvIngRgz7d
         ZlC5e1Vy78rHeQXv1uUuh1zOVpwzrD2foDZsfvK96XvmpRB6nzU8MJxRafV69vEEXWG7
         iT4lpRZ+W2cTyuYiKe0s0dWhUKf5f7QGD/MhAWOFErtIaDq7gSL0rIMGPXI934cvMY/w
         IVznn7MFk0MSwuGt22S9z5Xa09xfbtU+L8q1t0RuIL703PTpu9qG2ztdVQaGHs5LtZXU
         PWE4WmR62Sx8LQ3BNEIZx7y63HiER7kQbEgCCaCj98XzUr/i9OloMAt+Oc3rEq9n25wS
         +DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253383; x=1773858183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PJigsdVD8XTz4GskV0xyxzrPfLwFWa2B99gGhThV7/Q=;
        b=NRLv4FKJhKAxDVBxdshEWiGlrOwKuRGFJKZQ8vQrK9ZZn+edI4mKejMJzOM4VSbbv1
         /k+2PyfVufheTvQ7PD6tYro4ELN4ufEkozbTGKitACO63/xpVGeZddf3Sk218jU4cgcp
         RQiXe3rZNQqKq7rIE/7LK+FCoD/N2QNQaaZI9Sw2rtSUXUpGpAOkuj2EimyxWKP14Xqt
         CnXnLjf26ToJY5IEdCWQdohfz4SfmM9M1FwNFgdF2O3kNG5QfPCVSakAZoalIyQ7K35L
         uQqZICdbDan0MtPEcoM2eLuKRdHkslNWUpHdSJeOpcDn2gr4wk39m/0c3lquXOcje3+t
         Uhpg==
X-Gm-Message-State: AOJu0Yy+tktIn2b+yu7TxJgGwEH6Wtu2EKZJz88ALjlXGjDYmJK+Rs73
	Q0CLNfwj4h6+PCheIMOHCOFBLamq+248VfHPzGO4dfFAhsSocbJTIA7s
X-Gm-Gg: ATEYQzz6dWFfAWqqEo1pF+YqeuVCNIOLeIx1ItBjMPXjv23HYcd2/7kkNzqnknbt/K4
	0zPcrPKuRVUtKSBF1FZkgG0mzxzDzGTiuWax88cgt7fj4SfZVfICzoKeDdIpt9KohtMIV0J0bBn
	oTZ8VKUR0Nl51rx//QEsLKYzdqP8Xg/r3vgfMUo81f8YqZERfcX+uw6sVsMrKa0uGm2I4VhAuSf
	VJwPx7TrJU4Nog65NWjSPMXkNxbEEPuF7eJ/J54gTJLDOnngZg3D5G+kAUJ4OhdJADVsBRq7E4o
	ybyUqPOdg7pTRF/wrNojP4tgUktxdXvI6aJq4Q6DiGDuy6zhVCIrlvuYveYiof1l8/H9Ubtgj1m
	SRJpNzVK41dVAEGeDOr3f97X3SVkXJ89qQ6NjlIjtvyoamMM8zcwyvVbNzuZHdwfj3bTARmKDAi
	a8YFX+Wxhp+15yJQzQvQ==
X-Received: by 2002:a05:600c:1f8e:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4854b0ca217mr62241285e9.11.1773253382455;
        Wed, 11 Mar 2026 11:23:02 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273e8sm1162050f8f.33.2026.03.11.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:23:02 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 11 Mar 2026 11:22:51 -0700
Subject: [PATCH bpf-next v3 3/4] libbpf: Add tp_btf.s section handler for
 sleepable raw tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-sleepable_tracepoints-v3-3-3e9bbde5bd22@meta.com>
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773253376; l=1284;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=LOul7MYG9zKx52ABji4/EYuwfy0bOfOpVegkgp95gJU=;
 b=DvChXFDE4pihzZ/TAQm+QzGXakMnr9C/qehA7SkTvS9IrQsXyOsP0OnMXblvSflizqY/2aNsX
 jkusWkGMd2hB8VwIj7phQTMOohy143NCpOmqSZddxVjXyy3bkDOKp8V
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add SEC_DEF for "tp_btf.s+" section prefix, enabling userspace BPF
programs to use SEC("tp_btf.s/<tracepoint>") to load sleepable raw
tracepoint programs. This follows the existing pattern used for
fentry.s, fexit.s, fmod_ret.s, and lsm.s section definitions.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0662d72bad20..7b65869f5c8e 100644
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
2.52.0

