Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842817;
	b=iP/m3IG2jKps8NkWvXoJvDaAhEdsUVEm8kVyv6o9lVn/DTsOC4ivZ5NRGfqGkm50fNXM
	 7v2fRCkUgp21BjMVzAJvUtxZ0OIwr/Rso5ljMFXheEsdOifFIupwPDuBU1exVwpElpggX
	 Dgwt1ycFV3bAqX5knsWvOCBnn0A0JDIu/XXtHVyIeEQmo3yo/enAiH8Mk0fa/Y3ZttYu9
	 54/cwSyZYEdkoy5ldxRoGPcZqbgqNwEr/ojoDi/CG+ZlTNEhlfb9PMb5DkQVT0Aib+XSH
	 CtH5iGVfve70FuE+8hrpWISJkfFj31Ss0+Z5hOfxlMOeaIFg8dYL5PWIG4vQVWLvoyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5cc9MrK3LHDg2VgyYBlB89Rlidb+17QqXfhNgqaLqRU=;
	b=Lf7pQvHS/s/+5NLqM4p376Ym1z3sVJ3J7qcgUMydKhIxO0PTgSZOJFge82ofebj4kOt+
	 0qfgTQ8TdpumHm/Lwbd0NUOCjCiNKJzCZaKcbmZOekqwpGHsiM9DUWpp+WqQxKfRjA78C
	 Yabo7ltwSdxBTTYvIAQ0A6AUMLKdsIUbyaWp7UxsCWgkNo96+bJdsxbT8KlvJ0Gr89Q9S
	 XAlBU1WRzCkcjmfT7nYL8s6qNd1SAcRspOAv935xf1sROAb2qeVbbC3AAp4LpvrveUIqQ
	 Ynhkf0YbPJ8jTiQXsOBlpekZujRlAP4KgE+V2gHp7kV0Sy7UnH/I098ZhJ9yBPfAiEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KY04tbsv;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82078606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82078606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KY04tbsv
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so1536466b3a.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842817; x=1795447617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cc9MrK3LHDg2VgyYBlB89Rlidb+17QqXfhNgqaLqRU=;
        b=KY04tbsvjd2nqxPwNjJD0DnB2EgtyJHrUBvOwrfIx9AOYCU1gBfXkVuEH5evOmdhMr
         5ltEqjYaaxSHksFBOMXFLAuFIJlITeeGXg3dOtATO4BpAAqEE27LwXCojPYpGsu7Md4X
         KtwaIVOSPRqjNLaLW1fddfq5MHN7T4gt0GtB+lG9XPjPr5iDqJx/zY2Ej5jK0ecA2oi0
         ONun15MZC/aQe5ktcgVibZcrRyhkmROPcmJmcJ334Ke86ltEO5YoN2B0Q8w86Hmy3P09
         SF5N6wieeMNJv9J2Ng5FablepSBHWzvcCFEZPZ0CCzjO4cYdRHsWYztopNN8I4BHVx+m
         wc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842817; x=1795447617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5cc9MrK3LHDg2VgyYBlB89Rlidb+17QqXfhNgqaLqRU=;
        b=pz6wwvZhfGuhT9opmO7sZJ+BWv0sWNa6r3dgISGMxPDYJ5giKPp2YeH+Is1kLv/Rso
         y4XNpaQ6k7UjAudPQEFWtVpYEFkmV0P4Alw9IhhkZuTarW+G2EkTxmDp7v4mrV5KqZ/U
         M347qLWfpJze21hhnsCEIJvqBsyqBpAaPnz4IlrzbjslsUdXF1P0z4tYH/AKKnxcJFtY
         Uj9QduUWlMSRWGu2j9eJAUcvPog1lmr8wic+Pi0xA1+2dX79HJDjrB/NvtNabr76JaaQ
         dB+8fPMGSIy/manx45A/OoG3UxvhfsKd6Qj19Qfn3LvWe5xmVy80PPNjTnl2pnus+ass
         H4lw==
X-Gm-Message-State: APuU4Z9ApY6LP6WGW3kFYlQpnEukVlLYy1KuYzJ4l3igHdNiCEXzVcYN
	KrvdsY8p1DLdqkss0U87I/1L8/USGeoR06KWs1RlMTU2IKWdiEu3ByPiW34RwA==
X-Gm-Gg: AYBFou10glsS5oKC5iTHD4+mK4wQmLlKQZFDkZJ9F+Vmy+kn/Yg1Tzrgj0vwD7QfIuZ
	dxfcSuOmpw8elW6CGMjrJaZuVm8Ca1Z8xZkjqp8oEpPGV1dFwy2tpVHmYprrp1AN96uKUb3kcaK
	o+qhelBiOjSNLVXapdwpXFiZqzypZruEe6TEhsbMi8t/HA5ZeZpAp3JghokW7gMlH+C0XsUZfOw
	DjQNVulWKMs7QCC96VPWNIbEVzt2wR/sbFEiSiDORVWz7D2h87Vf5GgY09niEj6NzOHsRsUTCDd
	1tVg7VMmhd0pXfgHPgWmZeWQ1B8UJzabjCFQaAYcCDaLAMO17MimkcMOQ7bULgu5O9RscDzHJ3k
	TnyzPecgY8VS1IOZkaHHg5FllAgxTKDDRgPC08dyMC0lco8Z1oZIDjS0Eg0IRLyZlcJNljhE844
	mdFRert4IW/834BI5tDlfgmG5Cb3iKvELrbgfMaVZdaGKVTkfYMmfE4pZrHafRgpplb6bSKJnBX
	Kz4tu5hmYKnYTp/42i+y6qojUBeOKtCTuwGTqmKXgtFLAvP69yObsW91PqWqiJ4V/BoGnktYaQY
	7U4PiBA1aU6PsnSuuNbFVDTAD9d06orGBiEG2ZjlcItRx3UW0a5eZ4ppePA1OxnwUjcvFYUQ5Re
	s8GTfyfRmKaT/bS9IBkOqmiKE0hcmvkXQ1bcjAF6hoYXjlAR4khW8e6V3xdtkMWguxABzgQTiAw
	==
X-Received: by 2002:a05:6a00:4b53:b0:89f:d620:232 with SMTP id d2e1a72fcca58-8beb6970bcemr9080313b3a.35.1794842816355;
        Mon, 16 Nov 2026 07:26:56 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2d11ac8sm3804598b3a.55.2026.11.16.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:26:55 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 04/21] bpf: Do not inline bpf_loop() when its callback is dead code
Date: Mon, 16 Nov 2026 15:26:09 +0000
Message-ID: <20261116152626.4032587-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
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

The main pass does not enter the callback of bpf_loop(0, cb). When cb
comes from a table of functions, nothing keeps it and it is removed. The
inlined loop still has 'call cb'. The call goes to the next function, or
the load fails with 'verifier bug: No program to jit'.

Leave the call of the helper. It does not look at cb.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 8d1dd0770711..d1eecb95545f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -3610,8 +3610,12 @@ int bpf_optimize_bpf_loop(struct bpf_verifier_env *env)
 		struct bpf_loop_inline_state *inline_state =
 			&env->insn_aux_data[i].loop_inline_state;
 
-		/* the callback that takes a stack in arena is not for a call from the program */
+		/*
+		 * The callback that takes a stack in arena is not for a call from the program.
+		 * The callback of a loop without iterations is dead code, it goes away.
+		 */
 		if (is_bpf_loop_call(insn) && inline_state->fit_for_inline &&
+		    env->insn_aux_data[subprogs[inline_state->callback_subprogno].start].seen &&
 		    !subprogs[inline_state->callback_subprogno].arena_stack_entry) {
 			stack_depth_extra = BPF_REG_SIZE * 3 + stack_depth_roundup;
 			err = inline_bpf_loop(env, i,
-- 
2.55.0

