Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623050;
	b=lQ/L7oOTptyZ1cwiPWnWIhv8NXL9ybPehD/9/V0hKR0XCa8B98gSY+AjSZ/XA+02Mxkr
	 2dOUXHQ26wJSCfqT2h3/tWeCIxJx/pOEqjlKgWDHrVKfY6tyOfK/PHDDuKHjSZ/Rt0Iy1
	 /1B3bypcYTtKx924hJoJu50b5VSkgf7uNM2HxFARaNL15g8aagAqPJ3j9OlSJXaD2P8mD
	 OLcohv6r/+EndbtGRezsea7Jhzl4injR3wXVHPgZIMk31gKglKPHsuONPRrZ+t7kS0myJ
	 3WhICJ7pxvOf3Bs8f/hNFcvTvHgbwapw5eDZek+TbleNa+HVOrvHr6I/tgjS+r4e2XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=/vslpHUHQt4zv0LMPIebRm/wLQOZFs5cvdXDbCFaR+E=;
	b=BWF9VEdwvmbJ36Ct97zp5iSgZQJ+vR7s33p4a/FvsVFiaaOyBGfZ7ZLWvqnj9afxaaiC
	 w51dpbOJ7J/n5KHUL8gMhy9FMBGA0p7pPmNmb1n2v0HavuYRtOv7iD6pPq955duRk3cyG
	 hvfgaBszTvoyHFYctErrNSpl4Oc3Nyqk+qGIcQyEjhGFylFnPoGgvseUNYncAzJnbDwOF
	 fBNrs7ze3b/4FqC/IrXlAXbl+zrNamGqcS2IM4q/UCxiatB5QnjDzHCutoA3f9+KFfaOB
	 m2L3pISmx3ABYcM7knWPx8/7DwO2mIqbiTp/49iEcWaPMwZEOKZY5oPMbNxcHg22hYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=btSZZLME;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B39606A330
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B39606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=btSZZLME
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a315ed211so3598425eec.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 04:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623049; x=1794227849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/vslpHUHQt4zv0LMPIebRm/wLQOZFs5cvdXDbCFaR+E=;
        b=btSZZLME4NXKTBXQYwPzJB4oGl+56WB0aw+k0g8i/7pgJNTpaYVm3SoJKV4jwKkoDm
         9Pn7LlFO7+TmcfOKxY5Ww6qhXB/tpCS2xpmuJk9rjGn4ebRZhynfPjh069AG0ANRS5P9
         PT54Z9cYPMEBD/C6Ay41YorqxfnKcDt0v1J9+amowN/k/Ibd5IW+MS36fTnR1hOMLIIv
         llob5TH6glydf/uFszEhkP4dTL0E9cwz+QLpYoKbFmXBN2/Gk293EYrjMwy7EEWDbEU3
         vYOMCrmLkkHiLDqtw0x3OYAELTE6JeD7Q7bsBBdErWkbiP1RC6TxTuLr7+IhCzVtDJs5
         Jk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623049; x=1794227849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vslpHUHQt4zv0LMPIebRm/wLQOZFs5cvdXDbCFaR+E=;
        b=cV6dvEg+7ExXcU+rofh98d86blzynqbUyGubnWbB91J7ZoFuEQKWNVTb02xh/V7M+Z
         qoQPQjccoTNUgx94hgY5hILJhHZ8dmraM2Qr2k/IsutYRbiyoVJWCixHe27k/u3nAxk9
         u8dtdywIjZArivHLMyFAyLAHIFcSDshQrBwmN+n/LKwYRJcnXr9L5xyinW847xPciCxS
         YdofRwCO7SSNCnk4a1LMB5M4cAa1orLoNV4ywBwLt0Uc1o9n+E+tQyoqG8Ma7ioPUZx+
         uRjm3CQ9JO3MoeQN2YS76BKLb2Tps3uOlMNsIaKQjbYGS9HgmtybW2HjLBdefswB2QS7
         PHEw==
X-Gm-Message-State: AFq9FYJErI61CyeFc5vXZKhe+7xSYYx4LagwSn1n1W8mlNo4UItkSBLZ
	FmAQ1yzHoSsycYvoF5U98068zq0TNCK4Cp3Thg+P59BCC1P3SJuJYjlz
X-Gm-Gg: AYBFou1VghcSgIG6g6KLa2bs0io7w5iIQAAe5fFoVAyWQA4Iox8R22DBsy52zIjXFJv
	KJkEyMeSZgn6gLxKAYJzCEOLf4aZaIwJgdcakBl23AajuAwDLDeslRszufaCxbwN/B0cl34Bx+n
	C1St2BYab1OVANKvtrwBp3oQsyrHE4npEobWW6vfTF8qwq1YipGW7GVVm6RVE2UrcMNEeO+IQTY
	LHm5oxzV2aB4LAoEOxuIXjILwU6vHVra73s0iVr1lu7VLN7HSDCM7a/8NZlkEvoWnobtfXHIda6
	GUXDcESWv3LLGjMmya5BdvkQsqUWce2DTERGh2/xRjD9aNwvcRy2rEC5CdGM9NL+TkLvRzl2KiN
	H4bPFgE3aGxUnXAjM7ZNjlHmK9DcbrBQ3OE0b1uvr5sQRAOuNlZj//ud65/ZszUhMPN1ynqRjNN
	xXSyzLoaq/OkOz6QTANeikeUO7xPHnyekeMOn26uHqkoMcweaK39FAOUvsA8HUKx8cs2ySL9uuY
	e552LIUrpKtI9lXmI3Egjub7rTpHzP/vgocB8TxnzOU4HQ5VERp5e7lhrtdb+Nfr1B9xoiWWAVV
	sRcbyJpLloCqsfezJMFXk6r7JEn9SW4pYgm0KasLhqdLCw==
X-Received: by 2002:a05:693c:4088:b0:36a:2f6c:490e with SMTP id 5a478bee46e88-36a30009ecemr21223699eec.6.1793623048591;
        Mon, 02 Nov 2026 04:37:28 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm36326095eec.6.2026.11.02.04.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:37:28 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 07:37:04 -0500
Subject: [PATCH bpf-next 4/5] selftests/bpf: Cover a nospec jump that
 becomes a nop
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-bpf-blind-nops-fixes-v1-4-844300e42cdb@gmail.com>
References: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
In-Reply-To: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luis Gerhorst <luis.gerhorst@fau.de>, 
 Henriette Herzog <henriette.herzog@rub.de>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Hengqi Chen <hengqi.chen@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

A conditional jump that is unsafe on a mispredicted path gets a barrier,
even when it later becomes a 'goto' over dead code only.

No test has such a jump, so nothing checks that bpf_opt_remove_nops()
keeps it with its barrier.

Compare a pointer on the mispredicted path at a jump that always goes
over dead code, and check that the barrier and the jump stay for a prog
loaded without CAP_PERFMON.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_unpriv.c  | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index a54b5a58b945b..b9d96366e656d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -1072,4 +1072,39 @@ __naked void nospec_backward_call(void)
 "	::: __clobber_all);
 }
 
+/*
+ * Compare a pointer at l0 on the mispredicted path, so that the jump gets a
+ * barrier. On the real path r1 is 0, and the jump only goes over dead code and
+ * becomes a nop. Keep it with its barrier.
+ */
+SEC("socket")
+__description("unpriv: nospec on a jump that becomes a nop")
+__success __success_unpriv
+__caps_unpriv(CAP_BPF)
+__retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 = 0")
+__xlated_unpriv("nospec")
+__xlated_unpriv("goto pc+0")
+__xlated_unpriv("r0 = 0")
+__xlated_unpriv("exit")
+#endif
+__naked void nospec_jump_becomes_nop(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = 0;						\
+	if r0 < 0x100 goto l0_%=;			\
+	/* executed only speculatively */		\
+	r1 = r10;					\
+l0_%=:	if r1 == 0 goto l1_%=;				\
+	r0 = 1;						\
+l1_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0

