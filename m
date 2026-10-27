Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113377;
	b=uMUB7jJo5G53nSqYCfVtVmSZlJZ77NdzYnWGSyafa1IOI/hJiM5xJqfqLxjHDLs61xYZ
	 YYHEnpTtuYbnPTcF5eelUscgzdU7qFEm5nT6/psqv/T/qXdWLLj6zoayXiDHYICBOB2eJ
	 ztDfVw9v/X85lSO3uRjl6CTCgP7xINsFj/aVMXOAtXES1Wtl+GHeXALPd2q4oB0G0BWsc
	 mO0twmcfoLWp+vN/5WgZoy/H9I380SynsGDnEgL4ngIXAVcjNwidYBLb96nlkH4HyAfAq
	 ebS9eAUIffhRj85vulpcnyyirzq04eOGeAD7e53WYvXJkaN7Jxf+JTyEVF1LBW/qUzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xMtUtPiKGPudRcl9yoWKWTK5iT7yT/I2Zu+Y8WFqLV4=;
	b=OSvIrDAXHBW/vPqcSVKKq7861BTH6i7VWKMfvXSSIMrWPuPRBJnkNFxkHdG/gzpy93Ur
	 NYPVjYhSEHmrixnhceFMXh5S40RaivhUQq7YAp9lQ2/bVhgebPld/y+uMov7hi4fL+Vv4
	 aTmCgDqseF2QlszkEI8FGXymueet0eaFgBod7uHFk5drq0CXRoBSmLjh898u8HTgbqEf9
	 xc5XQoNW5ite6h8kOQJCIvOIZHQGMLfX4esR7edO5mePfjTy+TlLAhFVd6bY/EhgBdG+j
	 ajfwegsYOTSZa75v58wq8/GBPoCCDvXl9alhekbyMK1lHOeGnSoyf0+5Kl+jsT2Q8Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O570ZE0j;
	arc=none smtp.remote-ip=74.125.231.203
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C264606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 15:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C264606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O570ZE0j
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-4f3f1adebb0so1552432b6e.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113375; x=1793718175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xMtUtPiKGPudRcl9yoWKWTK5iT7yT/I2Zu+Y8WFqLV4=;
        b=O570ZE0jGBbZRJ58fxR+AmHreUcx/FKLecraYYCQdKoAqZa2+G/VoKnXmzjRjnECqf
         lHZ2X1aWN1t5uzR/OUUYTZJUsxJ5cDStMDeuI9QNJ00TWEs0wHz1w6z9jyz9JS3RyX0L
         S680qr4RrYY2TJNIQJUqX3DekzV5YdBB3WXcXIkC/A/23U8YdHkhUPZgIMbJEfKOIvG4
         NQdIo9PVhAGDS1ezeJV8sYIb68wFePf/ZsCA/J+wW4Hq8B4EhPnRNZa08bHZd1l5sFR4
         8txyC2FMxCTsRtsI2Oj0KsB2KGSMNhO2LNEkbWkdaX6N9m5kseXjA8SkpKZwjS3t5vR2
         dsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113375; x=1793718175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xMtUtPiKGPudRcl9yoWKWTK5iT7yT/I2Zu+Y8WFqLV4=;
        b=RoVqHETa+ulLjOEWTbVgf2a7KGgv/V4xuSLgzo0saZZ/F9RR+jjWaYvwAiWdpc2Lor
         iKYFfVjPJyzO/u8n56r31yDunNcbazqL2PQtBJ9XcnZzN0f4dQ9AFF2CBTEMWY7XxlU3
         US1nffhCUi+AqDfwbFnA+UO9nmSLXZtQ4R3DPSWfzapHylj39n/KffZRSOuZ/cITqXWE
         zPKxQ5NTkz0NFxkl831JXslhzdwFur4ILt6rVmqZik/YYkph1FPM+2k2Qe7zIIzotkol
         lp9RP463kmO3M6kWpfyUMS2y0VOt+veEpZsf/oNb4o951ODBRKWGZPXotrXpDCl0PQ9F
         sqgQ==
X-Gm-Message-State: AFq9FYIgKhC5wmBtekFiwgBiuwmiBbFLUmgAKFL2z2bBsBIHteu9CZy/
	yuY1lOpZpuVos5PmJdTOpNXKKVa3AnZIaZ8p1pKPF2hp/oZJ+lOqVwsd
X-Gm-Gg: AYBFou3OR71vnKjCFdKPl5EcHoW7zXo3XTcuo+MIGcisYcDmoH5RnjAGgesvOmraveR
	2tFC4JMr9QHasYl9kLVewqK/hALN5fb90TriI1/Jx/PQ+e6rO4ohyNquYal5VU7ee7tMQUliC/0
	sCLikrgiMPEskL7elHwFYQ5VUbwPIuH69m44dXrnWq7U1NvMwveeAe3E4ES8htsm5iv1WAgqQP9
	wL5/szRzmawf5Pja/wxo2Y7vN7PpNnKujWvd+HZ/LKMg4VBHeYtl5H4YCMoid6F+NKGHnzNSz/N
	LsQLXmIQup78cwix5Zi9n1MznHx9mPUq1GobNafsK2+CJLVIGWxjz96XC38IHmDCYjDLg/M2L5W
	CFJiyTC7Ego3uKOcm1xEtY7a52bU8Co+7F1EuEsVdCVPU2YIbUNoSk8q7Ty1yJ9JkkKv4kNOl2b
	TweyMeG6OVCJI9lECLN0OZjDw/jseAazOAWEuUYHAWtj27al28LhV2nTi4yCB4Y+AVsCXWEFWpl
	WApi+2UqgRqhBhryGoOnd7JnpVK22UD+MaoZeY4WF0LBANfrjzS04mtjIviDAzJGnzGOP1YP0eL
	q2fz/gqY0hmB+pfTWLM=
X-Received: by 2002:a05:6808:250d:b0:539:ad19:d0af with SMTP id 5614622812f47-55c0020a836mr7093980b6e.11.1793113375046;
        Tue, 27 Oct 2026 08:02:55 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c04248804sm7886907b6e.3.2026.10.27.08.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:02:51 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] bpf: fix out-of-bounds frame access for async callback stack args
Date: Tue, 27 Oct 2026 23:02:37 +0800
Message-ID: <20261027150237.938383-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

check_stack_arg_read() resolves the caller frame with

    caller = vstate->frame[vstate->curframe - 1];

without checking whether the current frame is the outermost one
(curframe == 0). Regular programs always run with curframe > 0 inside
check_stack_arg_read(), but async callbacks do not: push_async_cb()
builds a fresh verifier state with frame[0] as the only frame and
curframe left at its kzalloc default 0.

A static subprogram invoked as an async callback (e.g. via
bpf_timer_set_callback) may declare up to MAX_BPF_FUNC_ARGS (12)
arguments, and arguments beyond the fifth are passed on the stack. When
such a callback executes an r11-based incoming stack argument load
(is_stack_arg_ldx: src_reg == BPF_REG_PARAMS, off > 0, 8-aligned), the
spi bound check against bpf_in_stack_arg_cnt() passes while curframe is
0, and the code above evaluates frame[-1]: an out-of-bounds read behind
the bpf_verifier_state.frame array. frame[] is embedded in struct
bpf_verifier_state, so for async callbacks frame[-1] reads the last 8
bytes of the object preceding the stack element in the verifier state
allocator, and the resulting garbage pointer is immediately used as

    arg = &caller->stack_arg_regs[spi];

whose contents are copied into the verifier register state. The main
program path is not affected: do_check_common() forces arg_cnt == 1 for
subprog 0, so bpf_in_stack_arg_cnt() is 0 there and the bound check
rejects the load.

Reject r11-based incoming stack argument loads when the current frame
has no caller (curframe == 0): async callback prototypes cannot declare
stack arguments in the first place (e.g. the timer callback prototype
has only 3 arguments), so such a load can never be valid.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5f874979b8d75..1fb3e89ac59b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4232,6 +4232,11 @@ static int check_stack_arg_read(struct bpf_verifier_env *env, struct bpf_func_st
 		return -EACCES;
 	}
 
+	if (vstate->curframe == 0) {
+		verbose(env, "stack arg read with no caller frame\n");
+		return -EINVAL;
+	}
+
 	caller = vstate->frame[vstate->curframe - 1];
 	arg = &caller->stack_arg_regs[spi];
 	cur = vstate->frame[vstate->curframe];
-- 
2.43.7
