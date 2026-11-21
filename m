Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299268;
	b=jiX1Bgb7feOS84uUDoy7Th3leFnlblfk9piPRZC2VZDWIU/fxFZOdZwuxEVb3dmgHEWd
	 derhDJor500wHsbqTUjIlDABXQhELX6xiMoEOyKYcsMG+cO8lLKRtPp2QjEZEsnPxe6lU
	 YcG8CTdJyv2j35GWg/okI4PmY28nLhMtn4mS9tlMxxU5z7EMsaM4XWVNR/cANMR+YrvJU
	 zrohaaSPs0pP2uRqVQ0qP30N8lj+neDV88GtVLi/H/+3J7YuZYroZwB82G1IyBGe7so78
	 A3nB+g1Ydzc7WeNwCArpq9zjJQHtQ05aStBdmvJoQl8Sf2gparAjniIb31+oQ6X+ruQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h5d3YWTFGvSB866WO3GvchKOrHxsPDiKYwlAlJXvIKs=;
	b=fxUpxl3HXbQEoZW6MtN/efPh6CP+N3HvGDLueS3eWQW0c5jCdF0L5kV8OGIssJR3nxrL
	 BEN5ry2oULBzk3dLtnDdCp7TatvEf+C4fP2isyyeaJ5+2atoBFWF07p6+OWqAQajV6fSI
	 QaiEAuXmCp2IcNg+PoQ1zSVMVVRG51UY0G0lSEx8vW4rcuI5xqHKclX1LOiRVCduDgoGD
	 ugd1uYwZAbut/s/4A9vCDcn7TNEYKcS2g36S+avl03KiMxpzWbQSN3AJjcjifGDyaMMEz
	 1K5aB2hk7zLmBs5C/A11UF/aaqWDA6gLxUGyunRX9dF1Djj9RUWI2jjnTyHJrzGJJfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SeZv29lP;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D9F606A32A
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 22:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D9F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SeZv29lP
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so939861a12.0
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 14:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795299268; x=1795904068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h5d3YWTFGvSB866WO3GvchKOrHxsPDiKYwlAlJXvIKs=;
        b=SeZv29lPqUCssqtjQ92FYFksjVmAzkkoVOMUTRaA7dtL6L3VtjdeMrtxuHD5HlNBWJ
         faN71GICCY0sSksJ1nC5nqClmpqO11NGuoQ+SDZdKvGX870v7hTaVFmn/cz4agApmbqS
         +h/a2Kp5b37Znmk/A+1j5tSpNci240J4jinQovenbzbHPzo3rQxZ8/00do46CjCCaiIg
         rlUSt3cJeaBAQSDTR7hA3+97DtUwMZjC61rVK36Mp/CilvLhTKQHQw04yOWNbwhxNEDQ
         YcPD6HnwjyzDfSfv93KC5eUau/8dclexpvMNlfF/bG9Ji1reRdFHLDF+uE87rP/JQPVU
         BKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795299268; x=1795904068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h5d3YWTFGvSB866WO3GvchKOrHxsPDiKYwlAlJXvIKs=;
        b=vThaA4/7i9Bt2ve5KpBmCB81z9tIAms4b72LODSKaAE5mUYnl9z1he34EKJmaW3nky
         8lg+R0H13YB/LGWXlu3h6gXuneoMvWHHtZPshJQvBzapwLCNmgixZ6G7hyurpdXB5SqS
         uAosYO0xdiDoKCAEaphmnPIFhfrTYxyJrAySNFlcOU93YN79cM31FOWqFfSj1FpexZQc
         BNWuLY7r43CX8ye55gn034ZckenAtd4Sw+Rc7t6FXcsSIaVg7kPPcWZDodHqoLT0HfyF
         wsGAaBSVJULl8TkBZ6SI1jxlpiCVT5wLKvUYZ9fAT9wVlsHhHMg7ksri8kls+CbGVBsq
         NyOg==
X-Gm-Message-State: APuU4Z/caIlOTzYV/qQrGvoDgduGiAVqHRdjxEsP4Sz3fzKrVLrPxtzf
	5gRJcjPwsGP1O57M8QXKSEEBmNuBxvFw68DEPpJMGlMWf5m+7T0bqT9lBAv00g==
X-Gm-Gg: AZFdTZdj+AlR+7nlANYxmAPxh9lvlZfs0ptsmxEDYJOivGMm8HLcs3Tvhp5RV4VqPpG
	vb1wp3C6xWqFoH9jwg3usPiE//kJcvs+sAIte65Q/COHKsvB6KHZzisWkaKExKN1RFDW79IKsed
	aH435+aEokD/+NFA+97lIt1MufWu7j/HWxuSyRVgw2uc/eG8R/twolmOwYCcG/Spvt3OLPPkYvP
	WysJZ5P3ReINtNTSK75vIrlTofScnIqdVa5pgC0s/G0F+jQyC7fxl/33VNhmRpPouncAuU219qO
	njIEN4p+fQ5jqeFOk/umdit7oi16ACgU7jLHuIpK9DD9IyNPK0c9fsLnujkdi7LcXVSFoLNA6y7
	SANnAjJiRcwV0OyqaDO+QY7+CtDAlE52qSz3GwaPTz0qGYyZSTKBd3i20C9f3kWBq8FDm2y+/YQ
	VIY2k9LpPSoD8x8LLnxGqnQ1AJP54tgiqL+RWNxhdDCs4FVSR45fr2ZE2aKzEcrwAPzBLSSRq5w
	iIaN6wYWwFWTjUD9H0mZ7nsDBuc40v7TZX62+nRBDoU+R62y32URyCZqANmJb7b2UCcuDXLbOxP
	6YZCoXxx74SjjMZZREqHNK/xH2iDav0jYLtQD5PyUNkCZqod6RVUkmWO8r/jhhAvEbP2/NjBV5W
	+Bq8O7Cm+P7/oyEqAymABlrEtzoy+da4qyL6xBiKI3lgLmjMjmka3P9eNe4X5aUsE9PWlYyGRVQ
	==
X-Received: by 2002:a17:90b:3b8f:b0:3b3:b36e:8c3d with SMTP id 98e67ed59e1d1-3b41cb466f4mr6248372a91.62.1795299267458;
        Sat, 21 Nov 2026 14:14:27 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a34asm9654652a91.3.2026.11.21.14.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 14:14:27 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 7/7] bpf: Replay an offloaded program with the precision of the good pass
Date: Sat, 21 Nov 2026 22:13:44 +0000
Message-ID: <20261121221344.3958866-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
References: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
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

Only offloaded programs are affected. A valid program loads, but nfp
can refuse to attach it. No unsafe program is accepted, because the
pass that the driver sees is a full pass with all checks.

The driver must see only a pass without errors. So the verifier runs
the good pass once more with the hooks of the driver. This is the
replay. Before it, bpf_partition_for_pessimized() tries more precision.
If that fails, bpf_restore_precision() takes the precision masks back
from prec->undo.

partition_next() makes that copy. If find_calls_to_unproven() is over
the cost limit, partition_next() does not run, and prec->undo has the
masks of an older pass. The limit is low after the first good pass, so
this happens if a later good pass ends just below it. Then the replay
can join more states than that pass did. In a test with a stub driver
max_pkt_offset was 448 in place of 56. If that value and the MTU are
above the packet split boundary, nfp refuses to attach the program.

Make the copy in bpf_partition_for_pessimized() too.

Fixes: cd97aa1387d9 ("bpf: Do not let a join raise what a program requires")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/precision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index e6dfb9f4bd..33b180b35c 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -1645,6 +1645,9 @@ int bpf_partition_for_pessimized(struct bpf_verifier_env *env)
 	prec->good_budget = prec->budget;
 	for (i = 0; i < prec->loop_cnt; i++)
 		prec->loops[i]->good = prec->loops[i]->precision;
+	/* bpf_partition_more() can fail before partition_next() makes this copy */
+	if (prec->data_deps)
+		memcpy(prec->undo, prec->data_deps, 5 * prec->words * sizeof(long));
 	for (i = 0; i < env->prog->len; i++)
 		if (env->insn_aux_data[i].pessimized)
 			note_unproven_after_pass(env, i);
-- 
2.55.0

