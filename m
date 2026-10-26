Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983640;
	b=W3XliZ5MT+oGQfdqa1kq0zyQ+SZutiSK8cy1UeXagvo7ayhYGUVDgyT2ewH3+4fLUxZG
	 Pyah1VRT/f8fFKyyNwu1KsZhxPosGd7hoYtbFUieHPXMrxlfm/zkcXMfscFXPh6eQweIG
	 b35DjMRrtYsMHwp+wLHQ5roKCi9QUnH6Cmi6vaWiMYPZHoT39utGABb7HCkuyzeKiiy1w
	 ZZA2id9fApPEwqpOQE6b9EjC78DFxXoW8/zzHtnaHJm+8X7jUtB4t/4hgbXJE3JQ+/8il
	 ROhM1tVOwArfbOyPmhwHV6ZLDtM7po0S5eyU2ZPt1HDPh/0vyCNi4EMGXfwMAXds5BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qx+IHPyXF3w7egBJka0ORJovO6IoLPRdlwviXC66HSg=;
	b=2mY7t1QTXfqLRb0qF4qGD5NHXK/OzZf/WdNYL0m85Ybcp4Gk3gyhfGYZBEY5wIWmP83Q
	 mAI3olOipHMxsEAB4BRytYQpaLyZKN/eM3zu59vZrala727ApI7a8aWeQXGkHWPs3gmgD
	 nLo4gNbBHKzEvppwO8oqJKXAviU1Hn784l6qMuu6x0W4BDwADwpHgfDg8qI9UtQoeVOIl
	 MBhT60HcM4iMPYGcyoxAnv+WUQNOgXu1NJlQH07qMNapeyXEgXGGniEAqGQg3APrbIaH3
	 nfPDqsnVaepFRIx1OdvH/eFqTiyzqc2Z0R5og7b2VVW4FGqdP7xk89oJQrmwExLFsLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ihcxklih;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9F4606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D9F4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ihcxklih
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a089dfee18so1749761b3a.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983640; x=1793588440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qx+IHPyXF3w7egBJka0ORJovO6IoLPRdlwviXC66HSg=;
        b=Ihcxklih51+6EZmkecNdxeyVrJ+eoS9kUXbHbllo5D/0tJx0ZkAeKMJe1Tg3C/m3Sg
         pngcEkz43i2rYayZ+tyv+Z0ipLlhz9ovREwvq0EEj6anMGaCyty+gcSVwBHFRAQXti/b
         UQeppEuS4XWv8D1oWohyPcoCATHfA+mXmJnoVFT3MszzWNEOTexxyzQBRVPST2dEbjaX
         QXnFxM3Rqv5ge6QH6t6q4qdcM1bBcq21NkKERLaaIAJJsBHubRwQvu31axCjXR+U/1gd
         rba8f64WEZp+NKxpah1U1q8/MuW50x7+TRX6fK9oIMZctY9d2US4ELWK98zCVptfkz48
         o6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983640; x=1793588440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qx+IHPyXF3w7egBJka0ORJovO6IoLPRdlwviXC66HSg=;
        b=dEyWWB2pONJ37WGm6w2x0ucytIh0jX2n+NFyPwdXKZggJd4JKK12dhSW/xqIBWIwK7
         FPbNLbiUChVt/heN1B2Ckkg9C0N+mUcS5PtMB4MjzTSOJVK/s5DxbfuHIZ+tDy4mSveu
         70JiV/X1TGTuX6CC9RCBTZZg2aK0uzlciGL4pOFg2a1Q0wd5CzbIoN+hfbR7SL6/0DQx
         ngw3C1hPyDXqbwy4NobqAH6NIShFxtuS7RXGf1xJu4SSIBUDbEQAysQUj2xZ8+b7Dsx2
         Zi9QgcuUmgn3LUAdg8e+NO48Iah5yVHILE/fsmsi7caDV07SU7VTDb8x4MP1roYHawC+
         tawg==
X-Gm-Message-State: AFq9FYIokLIFS4UPPMfr1QVTu45H4A1E+6aLeU/IyQ84xzZ3oO1w/rSz
	hWkh1qhYRK+sS6kqzdFInWV8U4LStLbnkaYaSTidaeSbBYNdOevg6j2HlGoqbQ==
X-Gm-Gg: AYBFou3VpPyljsHiPngf4DRyRIb9i+cyu+CIJkqWFdPLkvuf6GafZv4ahmVtlKmkhSK
	yVKpojHrPlB3AtmpH/aolqc1F1s/ZFITjyapEevbnG8lOIPszVYhzYgH5bVIYHuTBHP3VRU/4v3
	Id9hladoNcQ8AtH8M8SMXYIZ68RxxN90VHVwhszTo/2qIwuxT1Hy8KTVF6ob5ulJ9gECEGqP8ev
	pQXf84fMETvCbq+obCwk4iEM+Tv8D/5AUibm7Ph6h4N8p7ze58jE0ENkH4biJZFTfPReiaaxyFF
	juSnmbZNVB5snHlfiZB2HMJTgJXk7mAqRl/5clh3ZxP+wgCtcdUTaPA2FkEalGbO6srX13l8N8H
	mJmQLI3DPokEtVjF7xHQjZQIQnwbdmEjKQYUuvgODbC1OXyy7oecmPsE5URTs7fEg2+ZpqcfHOQ
	FG1v5sHosy0dZkGqH23FeMaWlIaDW3/aox9Dg0wOUnbsgH0mD7S0bGspsYndNtZ275DorjXnENu
	ER0xlh6NtmPw6ey7AHlqRMn3/YNXoTAd9D65rU6MD6vgVSKoxDmDCPfKdJ55a1fsVRFODiaNEXe
	HmEZtJ8scuOk21JM7pI9ILb4jxawvTw4fYvipTSEk6dgSdSltmGcY49fWeS4Vh6k/gVQlEwJW3/
	OToC70eotdbrCFEll/RMfZZEu
X-Received: by 2002:a05:6a20:548d:b0:3e2:8c23:4d6d with SMTP id adf61e73a8af0-3e7bfa33767mr3730641637.15.1792983639690;
        Sun, 25 Oct 2026 20:00:39 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cc9073c2sm1147959a12.0.2026.10.25.20.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:00:39 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 09/81] bpf: Clear delta of a register that scalar evolution widens
Date: Mon, 26 Oct 2026 02:58:30 +0000
Message-ID: <20261026025943.404450-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

After 'r3 = r8; r3 += 4' the verifier knows that r3 == r8 + 4. The two
registers have the same id, and r3 keeps the difference in reg->delta. When
the prog compares one of them with a constant, sync_linked_regs()
calculates the range of the other register from the difference of the two
deltas.

At a loop head scalar evolution widens a register: it replaces the register
with its range over all iterations. Then the register is not linked to
other registers. scratch_widened_reg_id() clears reg->id, but it does not
clear reg->delta. A subsequent copy of the register gets the stale delta.
Then the range of the copy is incorrect by this delta.

    r3 = r8
    r3 += 4              ; R3=scalar(id=1+4)
  1:                     ; r3 is widened: no id, delta is still 4
    r4 = r3              ; id=2 and delta 4 in both
    r4 += 1              ; R4=scalar(id=2+1)
    if r3 > 10 goto 3f   ; R3 <= 10, R4 = R3 + 1 - 4 <= 7
    if r4 <= 7 goto 2f
    ...                  ; not verified, r4 is up to 11 here

The verifier does not verify code that can run. Clear delta together with
id.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index fea77772ca96..b321bfee36c5 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2390,6 +2390,7 @@ static void scratch_widened_reg_id(struct bpf_verifier_env *env, struct bpf_reg_
 	switch (base_type(reg->type)) {
 	case SCALAR_VALUE:
 		reg->id = 0;
+		reg->delta = 0;
 		break;
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
-- 
2.55.0

