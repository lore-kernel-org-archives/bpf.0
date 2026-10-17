Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579481A6820
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200923; cv=none; b=ZrOcliJpVsQ8zJiFuMuLw3r834vRg797l2V4gsXHdwToR+RiL8FfIT1h8bb3zOUqDkQ7RTJ0Ioo+2skmcDssPKhqSomppiN2TvFkUMP9BWVBWORGSqJ6e5qX8zy9Ai7r3OFk4tcyeNgBSYNiUPuMm8O8rI/NlYhSnbpqRHgzG0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200923; c=relaxed/simple;
	bh=j072dmJGJh9JYnWnegUC4HEcIamnTJExfBdocQj1cGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hcw1lFbNNPmBIsdxw82DPznULowptOiKLM7ajzY8mC08QLMBjSms2REZ5Vm8OSfpTYAhsq/AL6GBY5RyjtrrXgQYR6O2dnAA74LkLSLVK7D8VaDMJTqsiOhSRd6KNPvUPNtDs8HSNkReW7q1dwYMQmAwKtBETTPLoxmAw+L0UP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez9ioo6c; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez9ioo6c"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so560085a91.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200921; x=1792805721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EGU7UzSXLv0MNZMeCBzs4ACNNB6+IVjvaLOnGlb7tVg=;
        b=Ez9ioo6cHOI9/mex9TFv8lBM9ONoIQ6bQDaJbjZAdlbXusMCHpUWDaEdoQ3UR1Qo8Q
         645l5zLsPdTmrNaW3ohKX4/Y6IPSyMOfsUPJN8z9qcae42QgcWR5wToDYetTr7IyJ5xx
         EZqavyZLgA0aY7uFxFTHBXUgio5hxKAI5Wr4lZR23DxpYN4KSrbRbA05xI5wPiRyHnSr
         lyT9tpt5FlN5l8bPm8BQuMPaTO7XMCcwVdP3VQZbDOxWWv6Jb0pBms3sh4oHfBGgRNuB
         G30QKq8N4WI4FFX/7JmgMyGhpfe9AgpmJLpBkFItrhV46wwgLr8kIhpkM1kSOrVGP03V
         d1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200921; x=1792805721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EGU7UzSXLv0MNZMeCBzs4ACNNB6+IVjvaLOnGlb7tVg=;
        b=JKJ7jX9TAMN7xZpfhh0uIu8kVdnlWaXWMXtKUlKi9RfW6tKvWPhf+E0rnFGL1PRMrW
         Z7/17kjfHRKWJy5RDSQ4ECW8UjR6/75rCopSslFgnwXVCu/9/Xv2BxnDOv8NXgvZVXV8
         j2l8Em0B28+q+SW7PJdL2tGSUb1s6ZRUC7GyUgijtzdGb4coxxYO/MTF8ZzOO8iPRNCP
         KHQg/0usZtxr8Pf/SdAScTSCsoGGW53dpjShX+KNPeWUAAMUUEvPAOGvCM1ZXDsrk8CS
         vCfU2cRjT27Uh27kctFYT0nEnY+TlsXJadGhPc7bp/EpM9+sPueCcE/6/yleCYyRpzK1
         qq/Q==
X-Gm-Message-State: AFq9FYK8CTPe7N7uOFY55kBYoiTBrPbdWJYipZhR9Sm4slRiCuJT2usg
	MDC2NjvGAaRhUeaoH8lzv3JSniRaQPTejyZDWhSvGPHfNKvWoyCRS/7ioIwuHwUu
X-Gm-Gg: AYBFou0TU67kUQEjmibHWbOlONBGOF/FPah65mK1HXh8kCM6PnTBM3YoXNBI3/9/lth
	B7zHhrMibFWAM9FqauqwLg25rv/4iYSBg3tKHSqK20ZC6o0xAwKARIVrluC6bpSYk+Ge2sesA69
	+ZtfDk0a9IgzI0Vy7Op1493TX6VHPJHSeJDHimcpNadF7JY2OuS9W+Db7ICHQqwlUl7B7sP6dAC
	bxx7TzQ70kETTxQ0qPnLEhBhYamHt1z4ypJB0rLC3h78flwCnkYcuT+VD2LlEAC4JaUcoFqank/
	lzruePHE5vp4WVk5pq9Zr6YUudeNYadCvAADL5brEaYerBp8kUG+Ti8xruAga3+5WzuYBaI/Nqf
	ASQzJvOceaTwVXWHB1atyepu+qRtl+8caOo6AuyNtdIbFqswkL9AdJNbQ6AqATZFVDLXAUXSV9B
	onwxi4rvFNO0lxHItMMxtD1bmiYSwg6GClqJR/R8DT5h8anHBcRVnUua+1CvGexaxh/sz8WNirK
	iaUC/GXL3mvu0fWt1+12uGOh4boUX7LHy176rzC28W/FhmhJZ4xlxchikqA++Cvd8wQdZFH/zvz
	b5ZbxcpasghZ36WNYlTAnDrWKOT5J99HBmsR5EV+Ea/Q
X-Received: by 2002:a17:90b:1d49:b0:3ab:1e1c:837f with SMTP id 98e67ed59e1d1-3acef56d593mr1172956a91.47.1792200920498;
        Fri, 16 Oct 2026 18:35:20 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc38b457esm6754771a91.0.2026.10.16.18.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:35:19 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 38/38] bpf: Refuse packet slices for packet-changing helpers
Date: Sat, 17 Oct 2026 01:24:51 +0000
Message-ID: <20261017012451.364800-30-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The helpers which may change packet data do not take a packet pointer as a
memory argument: they have no pkt_access. bpf_skb_store_bytes() makes the
skb writable before it copies from its source, and that can reallocate the
head which the source points into.

A slice from bpf_dynptr_slice() of the dynptr of the skb points into the
same head, but it is a PTR_TO_MEM, and the verifier lets it pass. The
helper then reads the old head, which has been freed:
bpf_skb_store_bytes(), bpf_lwt_push_encap(), bpf_lwt_seg6_store_bytes()
and bpf_lwt_seg6_action().

Refuse a slice of a packet where a packet pointer is refused for that
reason. All other helpers take slices as before. bpf_dynptr_write() and
bpf_dynptr_copy() can be used to copy inside of a packet.

Fixes: 2012c867c800 ("bpf: verifier: Accept dynptr mem as mem in helpers")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03b19829f27a..1cf7f2e57a16 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9693,6 +9693,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	if (err)
 		return err;
 
+	/*
+	 * A slice of a packet is packet data under another name. A helper which
+	 * may reallocate the packet must not go on reading from the old one.
+	 */
+	if (is_helper(meta) && reg_is_dynptr_slice_pkt(reg) &&
+	    bpf_helper_changes_pkt_data(meta->func_id)) {
+		verbose(env, "function access to the packet is not allowed\n");
+		return -EACCES;
+	}
+
 	if (arg_type_is_raw_mem(arg_type))
 		meta->arg_raw_mem.mask |= BIT(slot);
 
-- 
2.55.0

