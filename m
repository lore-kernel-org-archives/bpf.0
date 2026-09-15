Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC273D25A3
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438464; cv=none; b=LcaxRSlQXuroqDb63Vn6Li9CwHTVGKsr8wpPnOfWpojLCJ4nJ3UkRX1mojlTsIjGCYafrJ/CM657AYqmZjkqilgnHnv+b9Ke2Qd1l5yuCij/on3f6n2q/PZo3xpr6DKrT2to0zwzPhdALLGUUnPNbtXTGvHT2JAw40d/a0SKtpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438464; c=relaxed/simple;
	bh=/1WQcwweXawSG/8olW4NCuVNsiyfQve4wAhgNUxL7p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOVcVpoplX0mDOzxtsZ+A9nCNmICCFDD5bOC7qd6x35w7wA+L4CzuoiVYeC8HtExMDMP4+FGKYH7tQKQx9Mysc0nobJC7L+DEHL8pz4ZG9HlQVzTe0sJ/7h76WMw2fpUUpkrdGj7tG6DrJqinyV0whVE8yD0LsFLtYJb8SEdIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGP5zmmg; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGP5zmmg"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939656ff6d9so314236285a.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 19:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789438461; x=1790043261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7XHejARW/GsAN6R6sQQvVB3X/bf7ngCNqKrc+swjfGM=;
        b=UGP5zmmg2vbhxLI+oOd3kxxhAQOgN8h7nuBtmyQxHqvGSeN6wRICO2m6+VccV3Wiod
         6Wq+gfpDjk6iNfAmP6d1O1JmFTKIvmUbOucmkmNNSXyqQqkFHaFG96ZCMpyJYnxgcjGY
         Kl0rqv2H06RT5pmEdky4/eUgm9AV1/uLfBNypQEYoU/Cz1YRUTuwL2pHhT6HqFKCAQdz
         tPx0fCTMeZ7SfYkDpSm3+vKpTcKkglE6u7WzcGeZFQxmVkkNp5aUsvrmYXiMmogjRQ3I
         jfujHplAyzkbrwQmn1PIwcd/0HUW9VKZlzVxI5QrpbcImfmXylU0qgS1f21dhyP3eT38
         hmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789438461; x=1790043261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7XHejARW/GsAN6R6sQQvVB3X/bf7ngCNqKrc+swjfGM=;
        b=G9LS/Y2NKWaOMdnVca61z3hVCLt/p3dVF+gSbsjzEjkP0+X3N8BM+mZyvsPQsGlzY6
         ZNcInG9dVDpKI8gSCoYDLQJDyujQJXpDSqlTSXbPYegeEfThKxLxzIFAXUVdJCdQLv83
         +D8R8u5putvU96H+gcUi54wArvh5zlOp0DVCCoY6FkDoMR/D82tJ5n2NQbv6/wr9Nd2r
         H2YULcaaFiXPEmIFOOuZEUptc/107rzpFNPYYCogi9Ulq9+JbX4PNrEkp4RovVxK1th5
         MGi4dVvv9VdrQiAdMR9FUU0c22tDB26QBvUmEdsL+uje0+dsjJwd9zumH4giWT1dsrlV
         hxkw==
X-Forwarded-Encrypted: i=1; AKwUvByhF/0TpPTxlV4ROtwPR09kDl3cZAllj/yB/Al1RXzIN/d/z6D1OpFiwA+yBoTlLOWGRNE=@vger.kernel.org
X-Gm-Message-State: AFuF++mse8v9qOxWC1hwyiJ7Wys6W39NW/OPn9Ng7+5hu/LvlCwY16By
	MbAK1R5RKP2HWNoPyrjrUDD/YP8ooEjthHYT2RQ59VMll3/lxjyLjf2S
X-Gm-Gg: AYBFou3Hb7MeQgmKn1njgMDwLzxY6e1Y+j13wf4kQTcO/vH55+99+ZrkWk1mNLC4BBg
	SgVAnu4TxM81V3CDKrV6rXf2rgST9Lx/ATdJATx4YiADzpRuMCDVzBFl8jtoRyT4GOonSYNPdAc
	N9uLPa3HWLfoMdjBNus+knV1wVa8wiPlf5by6G4YbngDEn9PuVcGxQG0PfBYtzvhDBEXZvckwm4
	3JccEEbEMi+ukODLLLGRUziTWFVDOq6WsXo6IXjYUrHvCl0IKs1lx41S2hj7Xmb0iBTJssSVRSV
	XVwLP73fAvaHrLY5wMWjH5JhRIdTZ2njfariAZ+6VyihkWX17dVmbJrwD89NdV5SNS8WOLEaiua
	yNp585tzZ5zHdhhjjJ83tmhdy4xgENYluLI9ITDonfp41nUmm53c4LBBLe5IseyjrNcvXA0L5MV
	KTVPh69bKI7J0dh+7M2oGYVR7nWuKsm1njFsLfE9mwS8siO/uY4/r/i1u+dhn9+JBs
X-Received: by 2002:a05:620a:6018:b0:92e:5d44:73fc with SMTP id af79cd13be357-93a297ac480mr768891385a.12.1789438461227;
        Mon, 14 Sep 2026 19:14:21 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47e800sm113147306d6.27.2026.09.14.19.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:14:20 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	udknight@gmail.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com
Subject: [PATCH bpf-next 5/5] bpf, x86: Add unconditional byte swap to the i386 JIT
Date: Mon, 14 Sep 2026 22:13:38 -0400
Message-ID: <20260915021338.1520964-6-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915021338.1520964-1-main.kalliope@gmail.com>
References: <20260915021338.1520964-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i386 JIT rejects unconditional BPF byte-swap instructions, which use
BPF_ALU64 | BPF_END.

Route them through the existing big-endian conversion emitter. On
little-endian i386, it provides the same 16-, 32- and 64-bit byte swaps.
The verifier treats sub-64-bit BPF_END results as 32-bit definitions and
inserts zero extension where the upper word is used. The emitter clears
that word itself when verifier_zext is disabled.

Assisted-by: Codex:gpt-6
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/x86/net/bpf_jit_comp32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 2d8a3a961e91..bdba05b72ef3 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2037,6 +2037,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			break;
 		/* dst = htobe(dst) */
 		case BPF_ALU | BPF_END | BPF_FROM_BE:
+		/* dst = bswap(dst) */
+		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
 			emit_ia32_to_be_r64(dst, imm32, dstk, &prog,
 					    bpf_prog->aux);
 			break;
