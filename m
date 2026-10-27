Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127873;
	b=5exSY/6TttzW8cf4Qq+x3kBPpNLrM3AQP838LOqVl8Iem7FWaL/YXy4TuGQA44jupN4w
	 7VymJZdsL6YAkIhbdzbyBmOBx6dp4OYPk7oST7BacDIw9y3bzHaxaVZMl927wcOuu/b/b
	 9pmPT5YGaTKuFqdkXOalCo8DFFixJ/vqjix+KeojBHvICtI3ZIL9NKlKpUKdvyoPC+Ns/
	 0KlsOtM25YmmkWBKXpzCiEMyuXD1g+l3MmpmuxjVLI2AcnxNuZtJjZ0m/tPD2KU0K9gjL
	 Xn5/cgAIJg9vlQA5RPfz/DH3ENoy1KxKlLUPhGnoeYXJ3Ijg09WKwwvVOQ64KCF+t3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wf2DwANFDdumVM6h0eejSh1F4hdwHN+bdunDYOAs/r0=;
	b=HygjfSd20ZujTXzr4Uj3gcXVwzeXhvTMOd17bBSjuvgXsSSq1wwI1DLufeUPxgZuRGJy
	 AGesJgvyES3UBjvta/dQ33zRfq6MMWEwgy1i5qfIhGVy/cpNlnttYf8aC8xTLamzWMSMG
	 J5Rzts8UImVqcalcpUNwHO189AV0N09trG5yQ51YlUs8XxvSdS51rzPF+7Vm1EhQ8hFj9
	 zIrPUdBS2lBgHt8yYGdwYJ7w8Zq9GVt59WRLBDDWr9gtLLaFY3cFINvo0WVwQD+xgoo34
	 qbq/OCHTo7SbWMQQ81pjWq3E56udSYPbV1+giMgtZPragQhU7H+9PQWFcLMenQ4St4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gXI756am;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E202606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E202606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gXI756am
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd623dfe420so229177a12.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127873; x=1793732673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wf2DwANFDdumVM6h0eejSh1F4hdwHN+bdunDYOAs/r0=;
        b=gXI756amW8Uc62eTQvEIf3xDFCjnYoHmvuOV6St6R6m0c+8syV8OuErBLuwc+xSJ2o
         bFA4wq12L8NE4hqFmFhqbuN55OlDiPI2g73YJ5ouyZeo08wfMGwUtrlWYVtTPwOR5z2I
         AVJ16PzGeCtnrx84fZXBzSgUA7Bha9P/b7Z7xz/LsAFn6rF9vuc86SuSaK8BIOVHtgIo
         vpBOaHe+7UoDB62zS7mQWJcICoMrEo0ELW5Lk0+F+nLi7kna0Fu0pit6BgrNLxoT7QgN
         wTTL+zPoeV3OH2aLpIDmN9XJ5bOb4diTD7umJtSGtkGSkaIwrE354GqutFdHV26//0RH
         URsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127873; x=1793732673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wf2DwANFDdumVM6h0eejSh1F4hdwHN+bdunDYOAs/r0=;
        b=mQSlZkkfcrBdy/ZY1uBuMbHGPOy1Pydh/oWwLNvMt60HleI00TUttV88IKlaDc/vDl
         Gchy+K2EWK6qrephic5UoIu961YlPE8nslS5mrLJ2yMhLxIj1sYJq4/5pMch9Kj0EQX1
         CD/kKjwsar/Ygt1khEpDpi2a6QmP8d4QgampLGVHOBdwlcqg3gRlSBt+HJEXNPK8Iq3j
         mtx56cr2P3b+XeaJgZi8jnnNpd2RYHyTQVN/OlQQqj5Kp730Xi2LZ0FNvWxKupM/zQw7
         Ry7db704RPaXeOpBA195v9BdtDoTmfv97u0rIw5hKzWHbKfGF4Cz+uX42zewNDRhzMLs
         JnWQ==
X-Gm-Message-State: AFq9FYJuCVahkfh23YMpeGGeV52+YNaJ+TQzI1HpPDgLbuG9iX0oymiG
	4Z8poNwDtFCWivIVvRyINAuf6afFI94GQgsnXScZkzDGaU8yJCbBSPF4HuWhUg==
X-Gm-Gg: AYBFou0uwpfLueUun7Ch4swbLoKE2Aym1Q2FBsjkjLysBBMT+L+Sh0s4mhzBtVQUNcY
	o/LI8DJRi6ki8swbMKN/iZqsSTL4dV9GEfo6bsP8o1keO2ZOySq37zWXHbEzHIukSVRNjAhDK+B
	ZY7SQfCB9EXbura1hsjj54cQ1f+FrD+dfGM9bfC2lU9soZglQ/RnYM2WAfQ35BuAY63BW6ziNIZ
	t0f+sRvzQUO//DIL3Zy1U+BRVB42vvbuPAf722v0xruOzLfdCBA5G+hDSq+lI7yGGoA2vcJ5HwF
	a3yd7M/fCzP1f1IHSAESJJJoz93p2atdwIim4Y2qdT8xkVchbYGFY7VIbjEWjLfrEkPjUYUQhhr
	vYhcINFKk5qi33/sG8twx+v1RSzk5wPjRvZDUvwUX6SNWi8qJneldM1TS8sO+m/gd9A9inuK8aK
	eLP0oc7m6czjHSRNaBXBwkBnObguNRxX4ukwLvyNVLTDxHjjqRogqD/BDRmgDThZh01KOSl2DJG
	2tEvBDWIOo+qG0yzj9xoRms82ng+6pS3FhENIhrTLCiReIRCa8Nrd2oT/ZIli8us167m4VC3d0Q
	5TV9DqKpHUu1nDwWq3Ca+v6L9cRH4soxwi0uFLU1hPaKq+7UR3rrpmiMCfnZU9bRVKUE5ESa2qo
	7xAg53LdqoM+AhIIeIqy78QurXGGbQl10j4KcXndHIOSdiAchdeKx0AFDhVeeKZKOK7XcTTlc7A
	==
X-Received: by 2002:a17:90b:4a51:b0:3ad:a462:f07f with SMTP id 98e67ed59e1d1-3ae580e0f56mr7624a91.45.1793127872547;
        Tue, 27 Oct 2026 12:04:32 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5792575csm36322a91.2.2026.10.27.12.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:04:32 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 13/19] bpf: Don't clamp a register whose type changed in the loop
Date: Tue, 27 Oct 2026 19:03:08 +0000
Message-ID: <20261027190314.1440199-14-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

When a state returns to the head of a counted loop, bpf_clamp_scev_regs()
replaces the range of each register that changes by a constant step. The
new range is the range over all iterations. The function calculates it from
the register in the state that entered the loop. For a pointer this range
is the range of its offsets.

A call in the loop can invalidate the pointer. bpf_skb_pull_data() does it
to packet pointers, bpf_ringbuf_discard() does it to ringbuf memory. Then
the register is an unknown scalar. Scalar evolution does not see that, and
the clamp gives the offsets of the pointer to the scalar.

     r6 = bpf_ringbuf_reserve()     ; R6=ringbuf_mem
     r7 = r6
  1: if first iteration goto 2f
     r1 = map_value
     r1 += r6                       ; accepted: R6 is 0 or 1
     r0 = *(u8 *)(r1 + 0)
     goto 3f
  2: bpf_ringbuf_discard(r7)        ; R6=scalar()
  3: r6 += 1
     r9 += 1
     if r9 < 2 goto 1b              ; clamp: R6=scalar(umax=1)

At run time r6 is the address of the ringbuf memory plus 1. The prog adds
it to a pointer to a map value, and the kernel crashes in the access.

Do not clamp a register that has a different type than at the entry of the
loop. Such a state is not within the state at the head. Thus the verifier
continues with it, and r6 stays an unknown scalar.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 6231d16aa311..89f96682af3f 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2897,6 +2897,14 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		    is_unbound_scev_reg(env, entry_st, r))
 			continue;
 
+		/*
+		 * A call in the loop can change the type: it invalidates packet pointers or
+		 * releases a reference. The bounds are the offsets of the pointer at the entry.
+		 * They say nothing about the value that is in the register now.
+		 */
+		if (reg->type != entry_reg->type)
+			continue;
+
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
 		if (log->level & BPF_LOG_LEVEL2) {
 			bpf_log(log, "loop header at %d, clamping ", insn_idx);
-- 
2.55.0

