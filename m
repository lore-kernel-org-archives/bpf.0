Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB6377A8B
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505356; cv=none; b=K6KxNjUJfQFjrSDPqnlqb/MzaESYTv3tkJwPqAhQxO5V92+ajgY/xcWyzsUzef8guct4o+fdw8kVxpRRUhlRjNE+PUmi3DvWTsKxbjIQd+QGkgl1x+dZizyocNDBa8hL5M3bZ7lsXOHnlfFFlIpw8PCKyCGrzcUmrRHxbP5pnpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505356; c=relaxed/simple;
	bh=L9Q7H6XzdldeK7oJVUx64Jc4Oyk5d2RSK8iopIFNoWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaxXMxlblYL3imPak586QKDmp0grq7rW7z8+kcyEzXe4TZfyHlNalb81704Eunt7yAgegLBdPgDtAdLlKTznZw66wikkRMBmGVie4eTIfEGdbvg9s5oOrrySwT5iROggay9+FS3c3WXsvJYKy6JqT5Y0AyrveSIJMfhh1Pgly9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS+DCJiI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS+DCJiI"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so539794b3a.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 00:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788505355; x=1789110155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVyebJSrPANro9+ZzIJ5GUMECycDoWkIReTgM/W+/mE=;
        b=mS+DCJiILoxR1XUaV1ehfJL7EbSoHDnqGTd0E6E5+XC+5zp0avvBfBmM9AKAXVYyO0
         2x4SrB6Jpd8bqfRUboWLIzrCWO7DfaINwvSPGpCPzJIGdl/0iB7jC8drSJJ9nxsgUgSZ
         D7FAUyRgXQZT/AQpGMHq3GQ4zaFYOvG4XfwbnFHUEZldC8ORpk2jUtV7ON1Nu7mcknfB
         rUq5TsR37D5qxcLTI2ECnsU294IYwnl7Ffor9IDvUopaCyzTORjswhvKQNkH8Y5fPjcx
         IJMa+YLvM2H82e4rwfsJMu+T7+5z7X/b42mBEJ+AwgcfeecAfPaPK7xJLCG09oa4SfOn
         uNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788505355; x=1789110155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVyebJSrPANro9+ZzIJ5GUMECycDoWkIReTgM/W+/mE=;
        b=KCpWPvZ3JewE9Swuy9xVhjtJ3kR0KyGAiJ4PHon124dVHael9MBEyjTGQo1pC6sAik
         OUwy9v5BE2unGHnVbjyBR+V2Qqw+hhsLJK1L3oVrIfGj2e4sJhoMi3/BbZPKMIDFph6H
         yV8xlbdMUu58DcWJ54UQbXPhETs4P/uB+6MpMqsmJngWozLWUk9+RA+71LJTIcLg+cLR
         RBBXJ1mMeUop43c66N4jicnEv5xldt8rUMUeJPfsy0poYLlDyS97pWNF4TZ+4NcMKz1y
         fbMqDZP/K0SO+10OBUDKivlMSk/arnjAQjn2Rg7hYFMI8gaYOHQk6GB62WdKn2DB8PUv
         JszA==
X-Gm-Message-State: AFuF++mZbsO5t0vuAZk6bnr1uIPkAGEAiWQp3JH7WWNBLxqHhsxwRgAs
	5Et2BUM/KzTh9KA/wWEtrcwpcL1DC/BWmCsw4eeTvSmtkVa+kPAQYK0=
X-Gm-Gg: AYBFou1o10DdXe5Z3s7GftDQydR+oXanvhbSHfQpZ6WVsz6NX0JW2Ik+Bp9y2IBqHIm
	58+Az77WxlbbEpqnakRCgdLZSMsy9suFcadrupL89o4H2QyxaqPjoy13uFwXCLPMvJhcHdMRtyz
	5fhObjUC9ooIMUtQGYkdu+3fWd7nwWTGjT7M/KKKCCbMTGWFnCMTPkHPA3x2pl0Ux9vqPw3aBEi
	8GaUXMWQ8q8sW6oeIm+hxYNM4kT3BoH29CMkDNPbCti2MlQStKyfyG8nFtwtlCy5mpFhdnP08K1
	rRLpZo1oBH8Xq3G/VvMc6Hq72v5C9IKPyQ4kmRTGZDStYBcyuF+97I9NZHNnAWndSBHdCMtSmwx
	TrROQdyJ6mA+1CQIQRiIRmgYi/lKruymeJ+Kw4Y9KmADhxVKVksn6Fdco7qPfY5r96n+edLMAtH
	/hnM4Yer9KHzGCAwGQmO+BhVsAnuz2SqV410mmGRwRG6VqI++IXTSr9BAjP/FNGg4R+G6zPnEZB
	zp+qvcRRbXDXt1FV4hOCfDa
X-Received: by 2002:a05:6a00:9518:b0:857:72ba:ff0e with SMTP id d2e1a72fcca58-8616b667c51mr5437819b3a.22.1788505354389;
        Fri, 04 Sep 2026 00:02:34 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615273e3a0sm755511b3a.23.2026.09.04.00.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:02:33 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xu Kuohai <xukuohai@huawei.com>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH bpf 1/2] bpf, arm64: set up the frame pointer for the exception callback
Date: Fri,  4 Sep 2026 16:02:09 +0900
Message-ID: <20260904070210.4163193-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904070210.4163193-1-donggeunyoo.kernel@gmail.com>
References: <20260904070210.4163193-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A program acting as exception boundary saves all callee-saved registers,
so build_prologue() takes the exception_cb path and never calls
push_callee_regs(). That is the only place find_used_callee_regs() runs,
and with it the only place ctx->fp_used is set, so the callback prologue
does not emit the

  mov x25, sp

that points BPF_REG_FP at the frame the callback runs on. x25 keeps
whatever it held when bpf_throw() was called. If the throw came from a
subprogram that uses its own BPF stack, that is the subprogram's frame
pointer, and since the subprogram never returns it never restores x25
either.

Stack accesses through BPF_REG_FP are rewritten to be stack pointer
relative, so those still land in the callback's own frame. Materializing
the register does not: a callback that passes the address of a local
variable to a helper hands over an address in the dead subprogram's
frame. That address is below the callback's stack pointer by then, and
the helper's own call chain covers it, so the helper can write over its
own return address. 0x1234 below is the value the helper was asked to
store:

  pc : 0x1234
  lr : 0x1234
  Call trace:
   0x1234 (P)
   bpf_test_run+0x188/0x3e0
   bpf_prog_test_run_skb+0x47c/0x998
   __sys_bpf+0xbdc/0xdd8
  Kernel panic - not syncing: Oops: Fatal exception in interrupt

Set ctx->fp_used on the exception callback path so that the existing code
further down sets x25 from the stack pointer. The epilogue restores it
from the main program's save area along with the other callee-saved
registers, as it already does. x86 sets the frame pointer for the
callback from the argument it is passed, and powerpc computes it from
the stack pointer.

Fixes: 5d4fa9ec5643 ("bpf, arm64: Avoid blindly saving/restoring all callee-saved registers")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c18e005a41db..c5f55d6161fe 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -600,6 +600,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 		 * 12 registers are on the stack
 		 */
 		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
+		/* The callback may use its own BPF stack, set up fp for it. */
+		ctx->fp_used = true;
 	}
 
 	/* Stack must be multiples of 16B */
-- 
2.53.0

