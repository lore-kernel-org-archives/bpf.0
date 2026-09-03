Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78A4BA9E8
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446680; cv=none; b=B4iP99ssBGksC43SHBfbUbHc4LdMr0s3AkaYrDGEdrHs5hnxdANZWB27Lg/r7x7acLotBoLrB3lYxMxVFLpFpVQCBJrsV6Q8j6HAuiSxd9OGY1EQHk/rAHozzAmUqLpaU/wVWX0Xqs/f9/k/T0mQSUowLLqHP5Ftt4OJ/0VGh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446680; c=relaxed/simple;
	bh=pDpAPUckNR29uSVD4ycQ+9wLPRjaQ7RpGu96+XdFpfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1djJ44C/dIyT0ikx0UtPtRN1kIsjvivETz+osR+LnVXN+Bvbeq/jCz3pTSW44BNJZ1iRnFSRiyUOk640JSg2kTlkWq6MVjvdu/6POW+iqH9hnlF8gLMGGM0Zu/GdNDU2/xQOttwtIzNxmmgESef5g6k9wUZ8SBuuFhoqLrdL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnODIKRa; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnODIKRa"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484372811e5so571291f8f.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446676; x=1789051476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l5N4AseE2rK9wGFK7QIBySEO9gr5bwymQdXAGXh+c6E=;
        b=PnODIKRanKAR+//ifO3TLaPmqflyLJDRg+s0iyFU8YWl/vn3eQnwIxE13V/S9ZrJTh
         PeuFcogVQ0QOUs0C3sHU7+B24+elXWzmBlYni9f+2O+A7feXcutcomLg/Dz2NCUEedb9
         JjdMY6/OlWkVXAdCq9V7TgXRMruuGCSDrj3DyYnX002lkt1+lXu497YhRfMqUwLUFS8j
         XX6VUMIEIPKF4wuvrx6gHSpnuFkQWOP/RcxcwtNt8M9dvXcQR1Iy68omvJDxzIZMngPT
         AwCCSn0q+rKZPyIEU8rJwPTXUBiRXuiKGI7vObP/6pmhSWmyEWADGSDEFwpgMWSomDBa
         15Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446676; x=1789051476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l5N4AseE2rK9wGFK7QIBySEO9gr5bwymQdXAGXh+c6E=;
        b=HZ6/fPEvAOe/G+4ty3zb4IRYRB/tfdLWh4N86ng5k0EYSVfRiTW03qYjr6IX9ojoHO
         4BSBKMtTKj/tTZg5I3TSVQXQlvRo0+0s5eXIgMOSbHR+pXpQIfzot2V/btmnud8yxkoQ
         4dT+rUJLkzIgzNfgRIfRCTU7RwHRBjEcRskCP4wWMkqCSi/j/sA22SsvrqwyimcAf2q0
         q5WG1N7ovzesxXUGg+l0Jrpyn1NPP57VyqF7TgwvVB/oKIXsc0MRMlNF02iY6Y1aSVjN
         jtxx5utjRXHC4bYo2zHDDADfDgg5cKGEepI4K/8LrueUJxTAFpn2rxDMV1LgHW0XZjYm
         OU3Q==
X-Gm-Message-State: AFuF++mxv+xSrrsINLLczoZWmzs39fkZ13lKNQCxuZvIRsmB4fuBec9G
	Gg8JkPjrGdCXgjDF5vHvWZbux8otqVv8dnZkIipFAL6gDtn3PXuXRLzxSvGLhJ9o
X-Gm-Gg: AYBFou0wIJtsWq6cEUYNIWWrXOmFqWQvxfOlD9eaw6eAkN0WlsaScYBHo4Tq8jv3y4b
	9kEOZ+cC/gWZwhLd2I1er7rckjvOeBu9O4lfVsMSC9gUdoYVzgivh+7V0yrBCaxJQjqEyR/yWUF
	y/cpQ8wTjHlRrk40JcSB1yll1oQCSG0WVPbOp+LB5zhDh6ToLgetuy825PUMMBpeNR4bzU2f2vY
	o1T+GkzHcdiNEnNbK4xTAG/SsdbiEAs8YC9eQpPV4vxjD/m7XKzlaqIw8a5PdSzE2BY3A0UQLCE
	BbX7MWesNQSu38YTzvxWM1Bbic1TzqdILK73ChdglPoe8jUuu8WPZ0uEwCe+CSrYIVhR2hLmb8K
	UpQmb/MmqwlYpZsixm8Coci9NGVtBbqhGlYrfNF7Ku8XmEVQLeNbpVK9iYC9F61EMWeECfljYKz
	aL/MHuNDhwwVsSHfKz3PIHjmoqCSCUNevWsTXx5aPM2NFxm5F6uHIvjNHxoa1Pt6ujCGOyNr3a8
	wznzklDnD7UIs+h4OK5CokEnwFDUdHAB8N1IS7zbTux4l99B98t02wNTxDNNGDzlBhF6eew8Pbb
	nmkT9sFlE3iDV4KhUDtfEt5Rp8A=
X-Received: by 2002:a05:6000:3110:b0:482:f2f0:ca3d with SMTP id ffacd0b85a97d-484913b96ebmr23085016f8f.14.1788446676264;
        Thu, 03 Sep 2026 07:44:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed3716sm15430425f8f.22.2026.09.03.07.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:44:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 01/10] bpf: Mark signal tracepoint siginfo arguments as scalar
Date: Thu,  3 Sep 2026 16:44:19 +0200
Message-ID: <20260903144433.1716731-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144433.1716731-1-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=memxor@gmail.com; h=from:subject; bh=pDpAPUckNR29uSVD4ycQ+9wLPRjaQ7RpGu96+XdFpfs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtmc39g/62e2zv5M757Hl9pPGdhYP/BfdHv1hzf4Rn6y s188sJrHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhI329GhsVWL37b1Cloh0fO /l/udKn39IYYXxOxnxe5E+Ridm/w+8Pwz6Sy/KbNhM1xmzWEvnpNWKdx9oFyXPOT66fyDRyldR7 X8AEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The signal_generate and signal_deliver tracepoints declare their info
argument as a struct kernel_siginfo pointer. btf_ctx_access() therefore
treats it as a trusted pointer for tp_btf programs.

Signal delivery also uses SEND_SIG_NOINFO and SEND_SIG_PRIV as special
values for this argument. Those values are zero and one respectively,
and are not pointers. A tp_btf program can currently dereference either
value and fault the kernel. In particular, signal_generate can run from
timer interrupt context, turning the fault into a kernel panic.

Record both tracepoints in raw_tp_null_args[] and mark argument one as
a non-pointer. This preserves scalar access to the cookie while rejecting
direct and helper-mediated pointer use. Merely marking it nullable would
not suffice because SEND_SIG_PRIV is nonzero.

Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index da36d4b9d31a..d6d243c262ea 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6717,6 +6717,9 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	{ "rxrpc_resend", 0x10 },
 	{ "rxrpc_tq", 0x10 },
 	{ "rxrpc_client", 0x1 },
+	/* signal */
+	{ "signal_generate", 0x20 },
+	{ "signal_deliver", 0x20 },
 	/* skb */
 	{"kfree_skb", 0x1000},
 	/* sunrpc */
-- 
2.53.0

