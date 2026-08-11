Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25E2C3257
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 04:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786420917; cv=none; b=SWsfew9ncjlTaYeT2rNezXgQHUx3W/F1zwLY153xiUB1xFjAnIKa+cc7ONmBowlcGRLNcFlW10hGgOV9wQJy8ZNUobVVMR8rFtNdnYjcWlunEwBlBHpsC2XbNET+jIICd3gnSjH87/q95RWfwMxJQ322SMkY9HUEi9GNIoTpPnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786420917; c=relaxed/simple;
	bh=JKB8c704sCV4XMi2SILB65TPadhP+/dZ+kBPOImvi7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYKX6A5Ep75NBMceyDo+2dzbrirTxrblj5sUt9v+D9Zl3Vs2KY7zUivKOchjGp1v7P280ybfF5UbCluNYxWNTb+g/ak5bA/lr5gyRlmHX+qd85SbDXWSPkbCIzb6ObtLE1zb6am5/3Xk26CUlXjaYd/zLgZyZuk2oVQiua3vSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haxzS+Td; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haxzS+Td"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca957432c7fso2541439a12.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 21:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786420916; x=1787025716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TUF/Ie1CAko6dSXUa4KbdnibBpL2SvEJG3sel4Ep/bY=;
        b=haxzS+Td+tHg7WO2xu21LqUhUxpvz5k45ukPO14aDo/YNqVY+uZ0Z61+qdwpxb4j+p
         BTgcAtC2+W5jKivlZTATVvI6IfCnMPSYc3XBqA/SgKUj72sRnDU2UbWlyWQQvc86pdKb
         iAPBSqK1T75HkIqQNnvZv9WTXlo/dr1O6omyjvP7RvnoKzrriorb8DFwUpOS9BcJfRfr
         saVGL9D2c96s1plnEOggMV3jFx02Out/uP8g1A+uj57oxHdoEZ0Y5u3fZW4mS4FPF8Ap
         G7JF7CRe1ckvL5kfEPzinSafwk227yBZfszuTwFu/nBX8bH42YkYN6xsXguYQVo1F5Xz
         JZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786420916; x=1787025716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TUF/Ie1CAko6dSXUa4KbdnibBpL2SvEJG3sel4Ep/bY=;
        b=NeDmiDeABBvQFtUjZkTHEG0icx76qFeO+51ig0wzCgJEQwsqV2TBlRU7oMwTTylr3w
         7Tgz+9919vQN/HupHcqx6ishDOgURVvv22mqdrKwO5mtlKw+J0zd2BvdWEdY0GI5lF7M
         X9kIAHft0umd3P1t/nETg2x7BydoPDEkccxyirSDGoXmiH21t2htixvkKUM9pdyNNcwE
         CCmnoeouSuSRFLyErSDEqbPHZ55nGQSeWh65JJnVDLwMwYSniS4vzQbpniu023gP1UDu
         7ohK/2zf43s2ezBfCzwgdb0T3OCU4CNPzJAGxp2DqHy5xTiBQip/exPxtIHNIV5iaTDs
         zD2Q==
X-Gm-Message-State: AOJu0Yytso30wmDRDodtA4n3LJWXMy5hsM7+w4CLtpD0fk0k+HfYyA37
	nzVydloGBk4rRs0Fnw0X8wl+zdPXWyHwiA1k6EpjhMNqZwU91RKEmlHzGASSFQ==
X-Gm-Gg: AR+sD11otWQYY5WCx76jcq1h5XZH6Sq0VBm88CcovMa8TjO8SgMbgJ6IfS6KDT3y6Pr
	k/TU0mPAje7NzCbXSf7t8U6dV5rD4Te3tzeZ0q+olJsdnD5kFwVEd6aU7+8r/PP+ScLFTupf53d
	+cZ2zTxJoGnu6qexrGs7wh8MhH2DMWWL4BVIKP2KVKYP41KNmKSEx/j6CNZk8j+KH8MAhc82i3l
	14P942l02EkqOZ4j4Pm8Qd/jLNJxm79Q6qXs0qPmusSuyFxc2pQKW1qfJiRcWotwiSxaqXlKewB
	jzn31h9NsYLwm3x+fXlQN8VrSbfYuQ08reL0DKu/TxxvCxSaBy5njQGwbCouGnCSDREgO3y1l8i
	lA678dBL/EThO69VnBO+4I7VV+lQqIYP6qgyJB7v8HlldrxzntbR2QmuQSd67y5VX2AvIJWSmMi
	+P3bwa1tuGOfj8O+MvDJKybKaX80EAfP5Mr09sQrzMX+ZNdWnx1fYyUPeDQQpN0Fxz7Ui/nODT/
	80oOObPRjgepN4cppCWnqNmGJg=
X-Received: by 2002:a05:6a00:4f8f:b0:845:3fea:96c with SMTP id d2e1a72fcca58-84fa873633cmr252213b3a.21.1786420916032;
        Mon, 10 Aug 2026 21:01:56 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbed8bb9569sm163683a12.3.2026.08.10.21.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 21:01:55 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Ning Ding <dingning04@gmail.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf: Compare iterator types during state pruning
Date: Mon, 10 Aug 2026 20:59:54 -0700
Message-ID: <20260811035955.132989-2-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811035955.132989-1-dingning04@gmail.com>
References: <20260811035955.132989-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iterator stack slot can be MEM_RCU or PTR_UNTRUSTED. These states
must not be equal, or the verifier can prune an unsafe path.

Compare the pointer type for STACK_ITER slots.

Fixes: dfab99df147b ("bpf: teach the verifier to enforce css_iter and task_iter in RCU CS")
Signed-off-by: Ning Ding <dingning04@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/states.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index ea2153cf28d0a..4e6aafad33bd2 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -812,7 +812,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * infinite loop check triggering, see
 			 * iter_active_depths_differ()
 			 */
-			if (old_reg->iter.btf != cur_reg->iter.btf ||
+			if (old_reg->type != cur_reg->type ||
+			    old_reg->iter.btf != cur_reg->iter.btf ||
 			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
 			    old_reg->iter.state != cur_reg->iter.state ||
 			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
-- 
2.43.0

