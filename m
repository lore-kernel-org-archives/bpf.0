Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8836BCF3
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925360; cv=none; b=TxXptf1zcVFkLs2Yp0Z4AcFEsLzObW7hcZS7yEg/7WT79DcRM5P8moU8+tzeo8cfmyQUWEkIMujPfmTLirEwyki+ME3KmSbGjfObfZqNwhwuzBtEJbMy74KGY6V+AzM8WNDigei0wuvEHQlR3Y60Ru+e46rUfeFVv2PRB65nMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925360; c=relaxed/simple;
	bh=hrd0NlY9pBKuduf76fdmrPBnyckvVI6lRHdi9c3/5Sg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IP4YtdWXKn2xf5cSoJ+F3fZgdSufrtxOcSUtdBc/n7Rt7HU64+SO53dTtaHo3g185q92knHzSqXDZdJ+OTI03IOjciSPp5xGqKafrE/LKYt6TvHQ/diw60pT44Fuhgwh9S+Fg6zP8rPwQOfeF7hNm0IOVkcMm/cQMAe5nztyHr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToZNpNBU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToZNpNBU"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837b7903f3so64474595e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 01:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771925357; x=1772530157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=srSVsiV2b/ln5UzP/d6flconP4PG3Pc7vryxNaoWscY=;
        b=ToZNpNBUa7ULlHFexOnmI/c0h6jdjDxvckF46bfE0/ypJ4VIPVNVhQw/GfRsUsuhxS
         05FGbcZtUWFMT/2mSEFBSCbOFbK2ga15yN9b1nFt08L/NhZBEHXndLDXNoiLy+DiCQND
         UBR9a4wfDOyjDNRJzP5SJxuH4//WnDDt05M858ZDGQLXlEdZD30SNlm8DmwWotlI1uWI
         I8K99SORg6nNIxGUqpKEPCfOpWBaflwVsiS2LstkNgeQDpzNBZufNDedbz5Lq4aElHS3
         J8ZKiX+igIRhKUJaHCGZZpKmVna+F6bURE7S7qjU72f5SFcb/1u2AzQ8lX2wZQhYAz1S
         hhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771925357; x=1772530157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=srSVsiV2b/ln5UzP/d6flconP4PG3Pc7vryxNaoWscY=;
        b=r3zS+7hLZR+93zUDSMfqJL9GGevdxRiFYpDRVqedjuonNqZC+oJJPGHdZuiNk8CTP+
         /eFYntKTgtrlPhkoggk1JKcMzrDqcazNGCpKniyfMUI0oWm3TYhOF1MKTZHmCzrCJvkB
         tSg18YoMsEJ0BTM4WHfKVuNboYzfGTrBOtzGGiHTWKX/3xbUVaPYXbbyP0Usj9VkO+CO
         ksn1ZBnwUa90ZRAj8JI3N/hfzqBh/2F0wt4rQzI4fdoL+BcIaFY2AcRub/tIk67aGZt5
         YtvjgFQ+7kGdMMRNOM2PmATClU+11WDyGtfqAExuzDKqdV0EHdIQJX61dmxZf95o4Hb1
         jKCg==
X-Gm-Message-State: AOJu0YzR3C8rSbn/h+chWODTXqrbDKzYsxvEtlmJ63TnVzGf8nZtasIH
	FpRpiOf6HHO7+KdP7r6dS7WuHEkSKLfiy2rh7xiZ9IH2+nmbOP/FLiv+UYYL+MBzhTe7btGDFHM
	g0iF3lEq4CChHYUsnwuokIYcYYCPWy5qLiulGlfuiciqHuk/QhDDrRpCjw1mS7UrgGY5gwP+W9W
	MuRfvAHXEIb8dShTtEUi2RxCxMFks=
X-Received: from wmbju22.prod.google.com ([2002:a05:600c:56d6:b0:47e:e4a5:c5f2])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6298:b0:477:5c58:3d42
 with SMTP id 5b1f17b1804b1-483a95fb23amr187555705e9.10.1771925356794; Tue, 24
 Feb 2026 01:29:16 -0800 (PST)
Date: Tue, 24 Feb 2026 09:29:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260224092915.1925488-1-tabba@google.com>
Subject: [PATCH] arm64: bpf: Fix UBSAN misaligned access in BPF JIT
From: Fuad Tabba <tabba@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: tabba@google.com
Content-Type: text/plain; charset="UTF-8"

struct bpf_plt contains a u64 'target' field. The BPF JIT allocator
was using an alignment of 4 bytes (sizeof(u32)), which could lead
to the 'target' field being misaligned in the JIT buffer.

Increase the alignment requirement to 8 bytes (sizeof(u64)) in
bpf_jit_binary_pack_alloc() to guarantee proper alignment for
struct bpf_plt.

Fixes: b2ad54e1533e9 ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 356d33c7a4ae..adf84962d579 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2119,7 +2119,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	extable_offset = round_up(prog_size + PLT_TARGET_SIZE, extable_align);
 	image_size = extable_offset + extable_size;
 	ro_header = bpf_jit_binary_pack_alloc(image_size, &ro_image_ptr,
-					      sizeof(u32), &header, &image_ptr,
+					      sizeof(u64), &header, &image_ptr,
 					      jit_fill_hole);
 	if (!ro_header) {
 		prog = orig_prog;
-- 
2.53.0.371.g1d285c8824-goog

