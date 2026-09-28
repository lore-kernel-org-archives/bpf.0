Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9F2FFDFC
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790554592; cv=none; b=t3KGKkF0wYAiqJhLO41Lm9dzIerwWZApNaAmtGA4XxBI4WXcVkmghZF5gDadm9HxPbCQmiltyAX3QpWGjseQvHvhzFv803VyIj+udxO2EJoPAMJiNpW+tiUlUUt0Ne4HNMGcf+v4vaYFbADOu99uehiX0TWL8R3VrUWfO7M1RKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790554592; c=relaxed/simple;
	bh=MZDwc/QrqggaDyiAlHuiFPze4Hb4NZUgzn7i1xBiLa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PCDgpzkqwbolNK9XH1hhn9MgVca8eUryiCcbehvvtLk6mMzbpn4R3R9KRkZclXmk8uONH64TkwMrOQA8kqkoWMfaZZVTMJz3kaGsFz/tMqLeerSK99xmqJpWk+/d2mTk9Za1PevIPc69RyctyDZrR1rq/ab0zhVimT5RS+d1lFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKRw5RV9; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKRw5RV9"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff23af865so18272535e9.2
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790554587; x=1791159387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4mj/r7H0CDGSv3pfYOaU+eNcxZTUnXfXbb47i31YnE=;
        b=pKRw5RV9+mG6CKajQysuQ5F85frCFytOJcRbtvTNI+nXxPX3mKvSKApx62Q8ok2Syb
         DnipfTZtLSw8iSX1t2HZKG1v7c+h4q1ShHQ4i/JHT0h3HOumGncNqb0UwCIbwC421Mxx
         MyXtZsHvAy7vKg1tMOSeQKE18OpZpcFbdc3uz0YyytIsErrEaS8lTGyH2UKx5bMUJrg8
         UFLsMnnhaob7/Zs+Q/qCzucbmJ5HICxowLZnPaBCteh9STl8JMefz1vcBmLb6rxGu5i3
         UVwjyYGWeLUALIzeaS/gsk5IeVLQ6RHqCS0L1KL6mQOGe2lg4folaHKhH+JVHQvCjMRF
         9jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790554587; x=1791159387;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i4mj/r7H0CDGSv3pfYOaU+eNcxZTUnXfXbb47i31YnE=;
        b=RHWU5ApDlJ/L7n5vhLYRIpY2h8eDseiVHWp8HbHWM3331bSiW+JfkCI/xiRgA4E5QK
         4xWFMhOPZmBLMrodTevl3k+UzHttfiWsJ1FsUdpfn44yZXT7AhZMa2k0V/5notuMfklU
         ow2wN/3ZZqyBrUmAk25KcTUX9tLacqOgFbeeP+Ki+G0/zp9LwTLyl0SFlNb2DNro6wGJ
         L1b12StyI1pwmYp2wqS8YtZpR0Ul1VBJHp1TUTfAxp6ICuM8oQuVfqqAUYwkdCssIPAe
         EsqXxjwvNiwtJQY3k2vlm6qQ24DLuf2WmQgTrR+TWuqx5VX6G3kSawHeD/UTGkykCwfd
         x8sQ==
X-Forwarded-Encrypted: i=1; AKwUvBwN7BH/hvikuOrgAo6PojrxADgiFNYbRNJx8bzhql3SFboh1gyRT8HheVWuZWJv9K3WuqE=@vger.kernel.org
X-Gm-Message-State: AFuF++m3qOaaNM+2j9vjTzYLCzvw9fkrfJSqqxYEZgju3y/ZVjA9SgAR
	XxGPFMJdJQVmP818dTpQ6w2+ISDdzb2MFM2WggUxzMchQ2ZZJzOXPGqQrChtd8VluN8=
X-Gm-Gg: AYBFou0pqQfBjF2/bES7w9fRDo/CI101fprNZS/SImPBu1pKbmRsKiQA0DQUzDHWoUD
	AOZ79aKECPl/klZrDEQo0u3wNusplMDGs4r85e3OPtGqf+EtKpeQrihEii/67HicMsknMEfT26E
	hAkXNYQOITGl8+8oih3Q5WbgH2d1YfzfMT+/S8KxSNdxvJRfS5o3m1aJVWie7XqHpQBnFnOTBPh
	eFwPQxGaDCrHJytaTNB2ASfebrp701GO8hDNOVV7NM/Dn4uLtXxxRW3DNpZxoJzhZlfIDm4fGYA
	r4qd9goU67MCBWxcbNPobDWayxu5FYy/9EubIpGrae622J/rfJTkN8SKnbzgZGBxVjhwPRzs2OC
	b/LwjYxCCyHIMtWgloCTT0G6TUq4TmttCF4R1sv5jvE5eOTv+9rb4vo1YyUd1kXz1ymXgqlOnab
	3a6RdWx7fatsCbdbs6cWllQ9dcJiV47lbQiIaJgx8p8CJVsTALncmc30PHwisCUcUD/JXVKBhHR
	fopjeY=
X-Received: by 2002:a05:600c:310b:b0:49e:7862:c09e with SMTP id 5b1f17b1804b1-49fe66c6289mr199135805e9.14.1790554587215;
        Sun, 27 Sep 2026 17:16:27 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0016fd7b8sm105837005e9.2.2026.09.27.17.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 17:16:26 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
Subject: [PATCH bpf-next v2] bpf: Fix bpf_loop() depth check to use 32-bit max for nr_loops
Date: Mon, 28 Sep 2026 03:15:42 +0300
Message-ID: <20260928001609.429840-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The verifier compares callback_depth (u32) against reg_umax(), which
returns the 64-bit upper bound of R1. If the upper 32 bits of R1 are
set, reg_umax() can be U64_MAX, causing the depth check to be
ineffective and triggering excessive push_callback_call() invocations
until the complexity limit is hit.

Use reg_u32_max() instead. The change is sound for both runtime paths:

Out-of-line helper path (kernel/bpf/bpf_iter.c):
  bpf_loop() takes nr_loops as u32 via BPF_CALL_4, so the runtime
  always truncates R1 to 32 bits. reg_u32_max() matches this exactly.

Inlined path (kernel/bpf/fixups.c, inline_bpf_loop):
  When fit_for_inline is set, the call is replaced with inline code
  that checks R1 against BPF_MAX_LOOPS (8M) using a 64-bit compare:

    BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);

  Any R1 with upper 32 bits set exceeds BPF_MAX_LOOPS and returns
  -E2BIG with zero iterations. Any R1 that passes the check fits
  within BPF_MAX_LOOPS < U32_MAX, so (u32)R1 == R1. In both cases
  reg_u32_max() correctly bounds the iteration count.

Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
Changes in v2:
  - Expand commit message to cover the inlined bpf_loop() path
    (inline_bpf_loop in fixups.c). Requested by bpf-ci bot.

 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6bc5bc56f0d3..6ef037ca18c4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12185,7 +12185,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		err = mark_chain_precision(env, BPF_REG_1);
 		if (err)
 			return err;
-		if (cur_func(env)->callback_depth < reg_umax(&regs[BPF_REG_1])) {
+		if (cur_func(env)->callback_depth < reg_u32_max(&regs[BPF_REG_1])) {
 			err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 						 set_loop_callback_state);
 		} else {
--
2.55.0

