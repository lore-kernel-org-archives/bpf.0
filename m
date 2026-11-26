Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664307;
	b=gl2LrSEbh+SP6DLd52jucOBeC4OtxY0IvXC7SFL+iXJnBDAX7NVK15ri4KwSbTJIt5mB
	 JUa0qfhQW3VgSn+rUPghYqVhH2yHUkDcZxl3dm0Ghto9r8LxXCXLLlC35a0m0QlsUe+A9
	 uuJdkDr1+fK5lad5hqk7cimFRxleEAsquOjXnjuHkROdFxDxmjRm9LAX9ejxx230Qar3B
	 yn4dE1QI7zJibwRQYC07+pnqniK2UDd/oM9LM2zpzlWTsW1ccaKBxvzODE5pfbSzIhdlK
	 ZG4vLmW0QXNvavMqiEzV7xE+bTMvXi6G11QUcWZ8IogzMFrS4vfO1wCnWDyU+1+iCmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qJGqwSNNDW6zIg+emgHruInwvIE1Q0xMjdAk0bvJaJ8=;
	b=Iismu3SuTIcnI1UD4DdFYrt4gE3NUjMz5vvjnOvOe5A4t2S0sj7qym9dYWHDxFr0sYmy
	 V8yBcpYcZhXqiqNX2w0h7bhGqMnPY3NPN5Bc/uTv7YrHS3wQcH5//PUKuTei0vLEUynIN
	 ZefUUxmDeAbLsrFbbULUbiWdfA4xxxhZ9BhX1lShgTjKXXPkw/K+4mrZAWrFvcRWH+3dc
	 Bf9E8qpjyTjwpL/HbigiTKyIJXKlEQm2WxzBjfakuKHuRDJyVQgu74avc4ZyCW+vXywSk
	 YKVFWrZ7CoFLut4yupYmo7OwTOXL5Utgqn0G+gcJoI/YN3+H23SFWJuTaX4snZ6GMZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AL+0tYeq;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D4606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF7D4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AL+0tYeq
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso3141644a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664306; x=1796269106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJGqwSNNDW6zIg+emgHruInwvIE1Q0xMjdAk0bvJaJ8=;
        b=AL+0tYeqEOP2ok+7Zrfje52ofjD+bensjN3210JuY64xNvEKsp2W0D/61yL3/VBk5E
         kh6gnbqjIbPGkaJ1OHlQ1+YfMNmkGlG5bvy260eq4LREZlQp/P/nDCLdpkILkQ26nH09
         L8GNRjNTPabTc8nVS7yAUfhtfguEjgpRIui9FOL/itvgX9JIdhm9LlENuTdzXUqk1K1I
         GivYtBonVIvP2jx1b/ISwygn8ti2OsBfTsN3sbcPOApBd+tsMd7KFPBMe0kDLBnaxAnO
         f9ysj5pv5ap0D3fUwnZVPPRTQ8ZEfLD6oXtrCo59EzVciRBVPbHgU0vLF/KDhWQoHNHG
         QpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664306; x=1796269106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJGqwSNNDW6zIg+emgHruInwvIE1Q0xMjdAk0bvJaJ8=;
        b=g4DMbP94D3C+WLlXXKoNTwG+bu2jf8TbAnccj+upvlnCN5+200IN72eJU4nx2CZY0k
         W/koGyHK4QP6Py/5WuW/8YxgL17geR54DbiEIO1okgpQ/HJ2ThezM/b5yVGZ6Ime+Gr5
         9l4cXRJjTUk0KUqdr+82FW4x7r3DmuqRTFcGwySV96ZUiSGeb/ZL5Dg+JnuDR4T++nCB
         K1GVd42Sk6jL40WO5tUDxawsgjLmkTQhQvwQMOF2kMqv1m/Vqw82BPEq66pEI3YXTft4
         MCc6MFz1W/mCAV53P1atBe6LdPRSDsS1Ih54iFSemW9sSxZzVtnBdSqURS984g49uPbz
         7ovQ==
X-Gm-Message-State: APuU4Z9udbmYg4OY95HL0r2cVxaqEYDaYEtvBx5YvraFu1o+9QRkgCqK
	y8CYrG7QGNdcgzvSC6Rc5fmBg5e1a0jU78/yCM/o/izFx766yNhgWuaK/9TNMw==
X-Gm-Gg: AZFdTZebtQq7JyWVCfefSNQo7uCwloftPh/9BM7MSZcXamTuWh5L3MhZ/1fcYIKza7V
	Rqw0wEIbUa+SZqfQgbyHLsiliLK8Xlk51IfUoOLU5tkuOL9d9nxSE6nxN1/2QjTos9z6fc1tA2c
	gifkthk0cORPXzoxux/sId8SEM5J6sHYTXpLtTv6O7OVC3et/PmlVDOlsmg/X7Vde8JOUO3IE2D
	T82NnNqLSr0vJZt/EfHiOILioM+FJN2EqtjTeqsdvgHyR23DNu5COjem0QiiaEBbmcardvb6NSf
	j1LHKskWxiCImbmoXd436qEIk86hjl1RtCojuExKowSH+YcUl7oP8Xn9KZeoWvvjYY/CEAaQpRK
	j8V5UpKdvFhP3eLM/XZtQGARR0AXUErKQv6btJhsTkwnjsdogqCk1EZmuaUDTLZ3QEGjS2nq8xm
	pdlhSWAtcoW++xVlAFzvlQUh7w3KStsO6VErc7lsLnHbCNDcgIHGLehdaNc+Ej3IOTynRTnj1ml
	rQcHwT7wWkwSqyGi67OCQ6HF4NfqFJTtCXuZjfde3YzGGTFQuqjVHP24Cle2MNltQHVJ1+9e5Uo
	C6Ms0yyH6FPonAc/eBkstdxPl97bXkh03TNczqzkHakyQc+Wf8KmW2mL8SmpEZ1zlVF/NkYaVz4
	P7Er20s78TczXoA5dSUuAG/JXhW6VC6HMC6xvcb+ITnMbDtykit8xyOOzJSfZnKopbWfEEOkIOQ
	==
X-Received: by 2002:a17:90b:4f8f:b0:3b4:f260:72de with SMTP id 98e67ed59e1d1-3b4f2607685mr4268237a91.64.1795664305881;
        Wed, 25 Nov 2026 19:38:25 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecb486sm32960069a91.16.2026.11.25.19.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:38:25 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf v2 1/4] bpf: Undo insn aux changes of a failed speculative path
Date: Thu, 26 Nov 2026 03:38:13 +0000
Message-ID: <20261126033816.4124847-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
References: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

If a check fails on a speculative path, do_check() adds a nospec before
the insn and ends the path. The check can have written nospec_result
and ctx_field_size of the insn already. The other paths can use the
insn with another type of pointer, so these values do not apply to them.

Save both fields before the check and restore them.

Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d4b31990fcb9..c553e1533ace 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20649,7 +20649,8 @@ static int do_check(struct bpf_verifier_env *env)
 	for (;;) {
 		struct bpf_insn *insn;
 		struct bpf_insn_aux_data *insn_aux;
-		int err;
+		int err, ctx_field_size;
+		bool nospec_result;
 
 		if (signal_pending(current))
 			return -EAGAIN;
@@ -20802,6 +20803,8 @@ static int do_check(struct bpf_verifier_env *env)
 		if (state->speculative && insn_aux->nospec)
 			goto process_bpf_exit;
 
+		nospec_result = insn_aux->nospec_result;
+		ctx_field_size = insn_aux->ctx_field_size;
 		err = do_check_insn(env, &do_print_state);
 		if (error_recoverable_with_nospec(err) && state->speculative) {
 			/* Prevent this speculative path from ever reaching the
@@ -20812,6 +20815,8 @@ static int do_check(struct bpf_verifier_env *env)
 			 * markings for alu sanitization.
 			 */
 			insn_aux->alu_state = 0;
+			insn_aux->nospec_result = nospec_result;
+			insn_aux->ctx_field_size = ctx_field_size;
 			goto process_bpf_exit;
 		} else if (err < 0) {
 			return err;
-- 
2.55.0

