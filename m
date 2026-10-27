Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127879;
	b=jRfVDRxdcztNktcO7vYpE4cPZVhoWKRKFwor70txuUz0pWNTs/OEujUgczV/FEA+1GlU
	 LkXYpeSC8Q88/cQoycSiL1+/toIJAURXiFOyrXc+9J6XxgyXXLNMxzQbrqVbfivjA8gxJ
	 Xlgqz92DHWQE1xRAAUfezG6ugOUZz6h9ulCH+KVvu1O/puACI+IdvdozOMfgKBaNzLX8X
	 3cqsrCyLnPT6xIx6CAp2qz+mHg1UvyaG4Fl4+J3JhIGqaonzxGstW5XSs+8pteDz3eXfI
	 wO/zV+kpmdu+ixzYj+UNAXrJUW9sulkGA/IXNOnRmzmOeLYok4Yi4yDOtegk4GjAHwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8kGD0BEdPndwBbd8dTsvwz3ooTY6IqtoAoqYoD/dUAo=;
	b=cIuoRFVwJiOMUXJWxsjSadUvm29y4ZOhkt6vIkBg/utv3HaeUDGyUztckT5Io1Mi1D3c
	 mOeo2aNLHT/+JWYMXnwmuKBJkFsNdoyY4tkseuG1CW04FXKurQP+fISsSmXPY6u/AO92E
	 0exfOZSSswSzsGFLH22uRcsvsm1Pn5qn3x6M0TGG2y9yYSncCjp6KEzzpAE/qhCVi0Cl1
	 Z0MuSSP/IrADH4uMZPqZz+40jv5TZ6tDCFIxLg/hET37dbaJ2emh9LVDG+j6oM63WXSNZ
	 QphSWaAmNo7/wVdM/bQdi72UAaQpakz4ldxTYujRLAIYISsTuKQ5zuSp5Z071SVRHmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EbHZ6Gsa;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40250606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40250606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EbHZ6Gsa
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso852615ad.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127878; x=1793732678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kGD0BEdPndwBbd8dTsvwz3ooTY6IqtoAoqYoD/dUAo=;
        b=EbHZ6GsakDBp3zwp6yuKvrq7/oLKkJW0Fj4hQUKoKj45uiX1rnBGU0pVwHosOiAeNG
         Ft38I0/wOaat6B/iO/Aru/TJ/OFiemHW8ilvv4LrqUpydPTylH6t6dMdxGR3Vff+TpBu
         KtVDSs4jADHds0SUNl5CCi+ctyorLF6jHQlKWZUuTmvvCKzoBcrwiqwD48Fk5qmbWfIa
         53othGRn23cZzlLpPvgKlFUBIeRPDbO0klzE0szrNsStDJaoc0p7aAAHR7SHq52hV1qA
         4HDq72tebvYlwjzm47pW6di8+XMwZXcoh20fGMpL49kHrY8FUGiqwnsoT0kJTmzp8Awg
         1/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127878; x=1793732678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kGD0BEdPndwBbd8dTsvwz3ooTY6IqtoAoqYoD/dUAo=;
        b=aZ3ALwH9DxOf5DsP/Sw1mW+8dWK01SsD6X/TpM6phLOwYs5riCZrLRiRsb1xTmfP5t
         rBKismYmGhsKNDV4DBm4odZgD60dMtWhrUzcPsUhlFZ8TZO4bqMDPH06PD4V4wwEKqMW
         PCWNYOoIBeigrgiymV3RXjb6oblr+JnItJAQLle+lyYvjgFj8wHIsrBtu/1Z3pghV60Q
         z6AtvdvKjHOmHtJI32xds9QLD882JoZufNH8zi8DNPFJuxVdMhYa7MlaGqXwNS1TCCa7
         7WlTe4pF2geXZwurjp5sF8Bf/G/gsLLUENR4BPSiQrV73sDq2zqQymhGhbnj26bmIpc+
         WSAw==
X-Gm-Message-State: AFq9FYIr79YYEMIp1zJJfji7jG6ABNJWPt2LUnPs6kuL5b4no7ztFdLd
	IoZRn9lnUd4aiiLo4GWoXtJaCZzd0t1R49F3D1TuL98sFuHqt4xVRemCKL2FXw==
X-Gm-Gg: AYBFou1pEknJA6xUzjqAOmUC1MuwFc2rfdn0pKYxW9FVf58CTFOhNNLb1R5++Ea9Sdt
	QVG4gytD3wAc8aF065bJ1XdSVH5HRW30INkiyCLkT1KY/Ag1Jw3AThkUUHuCOBWTglfutSfNCJT
	vv0PCTw+SqzYPxdfAfoH5qw+Dy5RKtQA4AY+riyS/v8ULkFn5cahQDCq+OyfeGcUACrs2R8kVVv
	dEWaGteOsmvjvaQkQZptgs80w1UY2hjlxWM9DGj1EPUPxwMJTqIkkfoXm4CnkHGyKR/qE3TzVXv
	mGVFuh3UPKu373lTh9Fm7Ejafw5BQ7l9Hl06LAQ7OLy5tZmio3T2g4qhn3aZ5hkbl8hag8wGBU+
	nk/bcJYyjb1sZAq/Wlrqtjbrzm73oPhPCnEgiCNDSzfWzWxXhHG+prvX/HRDLOOT7SXHSrcA0SB
	SKPqv/ZRzfzQrg4I0IFCbQDeAWnnSxrCM8/E4rq/baL9fbx3vj7tIJFITITGgv5axYuJhRSfOj9
	LqmJzO6kIEZ+KwAzH1wjmgNokpfV5aNxBCHDQBDrwIiawEM/ZM/03oYyab68rldxER3ID0zBhkg
	EIDbkkBSg6a6EhLSFUpnHw0JSiiXX5tOKA6jMD4Amv2Ifo77BMXr8wM1OKXFOufOplTN/qESnc6
	KyiXmVDkJ4C2s6KYfeeKQCYJ2
X-Received: by 2002:a17:90b:528a:b0:3a7:da33:ff2d with SMTP id 98e67ed59e1d1-3adead62207mr8346765a91.48.1793127878318;
        Tue, 27 Oct 2026 12:04:38 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae578b5f6esm125195a91.11.2026.10.27.12.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:04:38 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 14/19] bpf: Reset the range of a packet pointer that scalar evolution clamps
Date: Tue, 27 Oct 2026 19:03:09 +0000
Message-ID: <20261027190314.1440199-15-alexei.starovoitov@gmail.com>
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

A compare with pkt_end sets 'range' in all packet pointers that have the
same id. Then 'range - offset' bytes from the pointer are in the packet.

When a state returns to the head of a counted loop, bpf_clamp_scev_regs()
gives a new id to a packet pointer, and the offsets of all iterations. It
does not change the range. But the range is valid only together with the
old id and the old offsets.

  1:                           ; R6=pkt(id=1,r=0,off=0..100)
     r5 = r6
     r5 += 100
     if r5 > pkt_end goto 2f   ; R6=pkt(id=1,r=200,off=0..100)
     r6 += 100                 ; R6=pkt(id=1,r=200,off=100..200)
     r9 += 1
     if r9 < 2 goto 1b         ; clamp: R6=pkt(id=2,r=200,off=0..100)

  after                   bytes from r6 that the verifier accepts
  ----------------------  ---------------------------------------
  the compare             100, correct
  r6 += 100               0, correct
  the clamp               100, incorrect. Nothing compared this r6

Usually the verifier prunes the state at the head, and the range has no
effect. The verifier continues with the state when a different part of it
is not within the state at the head. A flag in a 32-bit spill is
sufficient. Then the prog reads and writes after pkt_end. A write to
skb_shared_info crashes the kernel.

Take the range that the pointer has at the entry of the loop. No compare in
the loop found this range, so it is valid in all iterations. The state at
the head has the same range, so the verifier prunes as before.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 89f96682af3f..7b82fd79f9cc 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2914,6 +2914,13 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			bpf_log(log, "\n");
 		}
 		scratch_widened_reg_id(env, reg);
+		/*
+		 * The range of a packet pointer goes together with its id and with the offsets
+		 * that it had in the compare with pkt_end. Both are replaced here. What holds for
+		 * the new offsets is the range at the entry.
+		 */
+		if (type_is_pkt_pointer(reg->type))
+			reg->range = max(entry_reg->range, 0);
 		err = bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
 					bounds.base, bounds.step);
 		if (err)
-- 
2.55.0

