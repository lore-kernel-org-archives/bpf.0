Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463146;
	b=nDA8M0bWEIVpWn6QRbeOYN4HbWEg0HDVGX4yfxc3uFraz9q1/iNMGPSFJ0xjfhbAbtaw
	 z759JMSO2LOVRk+yUk1WJAlF8QFOCTL0KYda4Me6rlHp5dT9vnUKrV1D7Tu48g5FAIEv/
	 9iMAoUHq3sJlKCnBfW9WvCJiuT6YAYiydgBxqtvwtRwpqC/zM+U6B4n026G4wcQ1JMK3u
	 4KYLvShwUfwWeR4WPuCO33n3W//WLwb+aisBHauaQ8hCsfE8saSMFT1r66agK/yYliIRJ
	 bh+7X0itY4+FKo3bIjwelSUI+7RgQP4F22z+rs7oTa3qDylto3EjLlgjTIkNU3BhYZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=F6ATnaq77N7l+Nz/RetMd0pcd2gSJbfOJlthrtWXFyM=;
	b=utPVOpMKOq2dFYL7Dw/nHyRDtieqBJQlQnLcTDUa7z7ChdVJAYSfkDJYWge5eJU9H/9z
	 ELW6XSTPlUk7GyY7nNYORZZNQ5GpS4tOEqgDsOLju29S1Br2Udo7X7QXGfl18H5ECj//+
	 71n2WCv6jD765EsXVG4C4q/d9VDi+sVLCyOXuAU+hrSMKagSMbj/DxwagO74grKOoFsc+
	 ubzecnt8cNSewtfYsE3qwnOJyCs5NML8yFYKafZTGOd1E3v4+xbnHDqi3RU2qBzVpZziV
	 sPV87BNOimZy1TvtDQapEJp580fJMI6Zb3kH/pbRm/efeG98YATM27MQEEmOaCEwC0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E8HxaQEj;
	arc=none smtp.remote-ip=74.125.225.72
Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494E606A339
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 19:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2494E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E8HxaQEj
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48df4afd489so1032465f8f.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 11:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795463144; x=1796067944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F6ATnaq77N7l+Nz/RetMd0pcd2gSJbfOJlthrtWXFyM=;
        b=E8HxaQEjDsaplGNIaE/euas28bg5LBKdRaLm0OmmUbr+Zu19l7WC6YwZPVb2wcjnFc
         tHqVKU3ZbOZ/v30/4Kqtu88uKWEIHaqWWsBLnYYyubIvbDo//MkIM5/dwGAnUZXf6dsi
         tRPmxgjLYJ8nYX+Zq12E2E5Ew7lWLz1SkfSIYtpf/KsH1JWu4Aoq/Gr2q612KYvIzewe
         YK84yUuCy64JjbRWDcbkF88z0hRDpWUdJKJU5JuOwl3Iefi1Dz1qgpH/u/HrgMaMDkkm
         dNZx6mJ1yuoYpYZ3qCjWUUJsekiy5b75dgNOH3ES+nl4eiJuARAN2YChoV/ta5s+BSYV
         SbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463144; x=1796067944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F6ATnaq77N7l+Nz/RetMd0pcd2gSJbfOJlthrtWXFyM=;
        b=Ubyb2U/Xi+wFM/NLL3jUpc0gEg+/McWjbZKTLTVbBgmK6qftGM2thP0d1DHDCL4/VW
         vYM4xORxdyNeg//JZSfKeylqh/mTaKUAn+1lXmRvx/QaZ60PwgttlGLiRNFoZkMjzAj2
         l2Qajlj6UbTIWKkjFdEuICloeuWPTO1VkVLq8CP5D7t1/6bLKj9AtY+NLYVVoNLnjrKT
         YMVYo8c4SPYU+zoz3n7Vi/fxis1iXjsOQ7AL1JkL1mNbErHbyDKV1aNx3XELknb6TtUO
         XVcY4olH1raE0QudX/b/jU19Jjd+C6coalkGMb2T9s7P1LiFINvjavyKVarGkimmlySa
         DMEw==
X-Gm-Message-State: APuU4Z8xqnNoILZ8MgBRE+juNt9EQuS5oE00sFqEiCyIrUkC3f0JSC/n
	bfWYmpt1DQm70mE1L4ha7hymnQZqMFI3aNzkgH9wovvECJPL+OkIxe0nfcyB/c1gyBs=
X-Gm-Gg: AZFdTZdmbG1IkxXgIfX/rMkKyWDMQ8+kSAcaiekm/Fliu8dMDf9TYrdAK48rEiCBjeh
	2mJo8mU13MZLRSCnfhxCvT8ng2Ep4LypfrImsYTwwqRd1g3NHRBJs+QtXfg6rW2wGSkYQyKMCyN
	AkjvalLGdMbw+ybN/Zi9cf9/9KXMc6Jw7gDu2dW8wmGyzWplUrst2FzzXTa2deE2EmQJdaY0Bi6
	PNSuKvoHMHZeA7rWxJJA3LWfZ/TUQLIJjNdvWrWdJGVK0l+irqA+cEJNKFkWGzgQ/ab+n20qNwd
	eLK3kmbndA82t/fYi5nI3UbVU/Jvq/7H7iAZl8nLSeWVc/Yf8Xtei6n4T4uYrLJqDHlA+yBg1p7
	HmCy5nCEhfU2nFQ8Pfmc82IImi54n9lt2Ubg/jRNzEhmH+iXMpnBI2PIE6XMWqCWbnkGjBgOd2d
	5NvwqAJ5Ldhy95IB7yFF3uqYRoZkF6qDpKBroJBhWyMhyXWLoAsx3witSHYjZtkhMA5UfN9jx05
	Y/JTOxqeAv0OIZb69AZmtCIrWlrIsR0+i6zeRLcO2ALvXINZpceUjqFfVnIlJP0R4DDoSIs8SWO
	rxxSV1IWRZigOpO4N8VPJKlwxndsi4lbNsDHisvp7BzRPqJzU+kM/7zvu4naZTTBNvnoOYJ3u5I
	U7KEJ0autdkj2TGoHNAgd0dHvqcm0aJskxtExcDUNTE5t9UljXlMaEmDcRMugh/ceSR2JQ+HPmA
	YWiArlWSjpZKxrHg==
X-Received: by 2002:a05:600c:4f4c:b0:4bb:8503:69f4 with SMTP id 5b1f17b1804b1-4bb888097a2mr318615445e9.5.1795463144231;
        Mon, 23 Nov 2026 11:45:44 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906635c7sm199755565e9.2.2026.11.23.11.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 11:45:43 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1] bpf: Let the bpf_fastcall boundary cover the longest pattern
Date: Mon, 23 Nov 2026 20:45:42 +0100
Message-ID: <adbe7671c30f744adf6682d6431b9d818039cefb.1795462417.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=memxor@gmail.com; h=from:subject:message-id; bh=2EcINuJ4YRR2QtY7nJJ/mvT9gcrcJHYA95C0XMeoT24=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIZtlqmBbIcPM90F30hlq1B2SDiy6oDXRQerpm6zTjDPm3 YhU2r6mo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOp6mZkmBmyUeG/aLHn70sd 6tOnlRwo2XA+6PDNyPvX3cSX9e+ac5/hr+zJJo6A8MmXIzye9rDPtd66uv+lrvzBicqfJ/r9aPM O5gYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A subprog can have bpf_fastcall patterns of different length:

  *(u64 *)(r10 - 8) = r2
  *(u64 *)(r10 - 16) = r1
  call bpf_get_smp_processor_id
  r1 = *(u64 *)(r10 - 16)
  r2 = *(u64 *)(r10 - 8)
  *(u64 *)(r10 - 16) = r1
  call bpf_get_smp_processor_id
  r1 = *(u64 *)(r10 - 16)
  r0 = *(u64 *)(r10 - 8)

For each pattern, take the offset just above its highest spill slot: 0 for
the first pattern here, -8 for the second. Currently
mark_fastcall_pattern_for_call() keeps the lowest of these offsets in
fastcall_stack_off, the bpf_fastcall boundary of the subprog, which is -8
here. check_fastcall_stack_contract() looks only at accesses below the
boundary, so the last load, at -8, does not switch the rewrite off.
bpf_remove_fastcall_spills_fills() then removes all three pairs of a spill
and a fill, and the load reads a slot that nothing wrote, while the
verifier took it for a slot with the type of R2.

Keep the highest of these offsets instead: every slot of every pattern is
below it. Start from S16_MIN, the value that says that nothing is
rewritten. Stop at 0, as min() did, because a pattern in code that never
runs may end above the frame pointer.

Fixes: 5b5f51bff1b6 ("bpf: no_caller_saved_registers attribute for helper calls")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b228ffbe3fe..01a74e166e89 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19933,7 +19933,11 @@ static void mark_fastcall_pattern_for_call(struct bpf_verifier_env *env,
 		env->insn_aux_data[insn_idx].fastcall_spills_num = i - 1;
 	else
 		subprog->keep_fastcall_stack = 1;
-	subprog->fastcall_stack_off = min(subprog->fastcall_stack_off, off);
+	/*
+	 * The upper end of the longest pattern: no slot of a pattern is above it. Code that never
+	 * runs may have a pattern that ends above the frame pointer.
+	 */
+	subprog->fastcall_stack_off = max(subprog->fastcall_stack_off, min_t(s16, off, 0));
 }
 
 static int mark_fastcall_patterns(struct bpf_verifier_env *env)
@@ -19944,6 +19948,7 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
 	int s, i;
 
 	for (s = 0; s < env->subprog_cnt; ++s, ++subprog) {
+		subprog->fastcall_stack_off = S16_MIN;
 		/* find lowest stack spill offset used in this subprog */
 		lowest_off = 0;
 		for (i = subprog->start; i < (subprog + 1)->start; ++i) {

base-commit: 84afebd853437e44cb71f718be11d90e4c1a59dd
-- 
2.53.0

