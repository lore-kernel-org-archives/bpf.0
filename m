Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983787;
	b=iqLvcOioJ82d3GXaXBabfVRdiH6kHWoG0jJPVqzp7ch4ZqXMDxNXarwHd7wAqLRroemu
	 6Pe+5aI5LYiYS9e35RBcRjvargF7vZrFX1UoP9BDp/05NSF17TfFFlRTAZztnA6jIVIhU
	 Uk+t1RgQZ1BPn0q5wPD8eN0k9NFNrvjyzZSodwISYUeLwiWQmQHY6lj/RzMk0DkjhSCtg
	 fuxh1TFZmH+87F5vopa8NeutK2IOGEu9ZIA83MPG8XJqKC52ro/Vz6V0aGzwsZnZvK3lr
	 4szxjrPeZbHTjPTsA+JGwZvBqTmAzoKCeh34EW2ciiDuObUGk+toSmWlaB73zPua4pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1XyInG3KEMIafDpaOEL7owaIV3237eW5IYzUrLpqT70=;
	b=k0/UrxgVPBzqZyfzpMc5P5s6Fr46rdaMBpOcIL8myFCtQNZu0NBUMpISgl10Gt6zh4aj
	 NuHdx/KLk7CPIP38fOYbr/tmHsVTERw0xltyJ85+mgOUpEOnBfrwBk/tkJDKdU9zObQgJ
	 NR12lVC34BSYpndLj0aE6ub+BKyks4bcr09SaYR04LWrGpMJaErS5mmLMYSVwOK+7Ql+M
	 uCM3S2TauBqW6qrRZiPBEK2bCvSoEZ8gfiXB1Kux8kx3jPVKKL+QdZxeILh25gUC7T4zr
	 nUd4bW8zfzCbWdxhXEnimxsN3TL50KTPBCcTksGHLELuYqSJEcjMSWNUc+JvGNUIQjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g30LieJm;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E2606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA4E2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g30LieJm
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc758830601so1501976a12.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983786; x=1793588586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1XyInG3KEMIafDpaOEL7owaIV3237eW5IYzUrLpqT70=;
        b=g30LieJmHyxdyp59EICWSYx+RtcaA9vdHP0Xhel0cpyrzc53YBuX8m/hxxl5543eNQ
         qv4LOWuOiOT5l1ATdLW5BwX+riFpvq2bg6gK6H5gBIGZw2poyRdc1LpVPOfngFvEyl9t
         zEZR7UfTr0n3CQ3HMUgxAaIpKIM/pk+k2qDRaB54NWvrvC+gzSOgfq59an2sCKlwhKKL
         HgeHyZM6biWqw77sg1skne8l76nmWNwfgXvvE7fdhbhoTgGHVT6zO08VSx9Wi4F5uw9F
         rjoBU+L5IERzAhu8D4dxFotwcWj7lKrBEOthygVzc6pwT7EzZTB0n785BSpGTtBMX2BU
         D4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983786; x=1793588586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1XyInG3KEMIafDpaOEL7owaIV3237eW5IYzUrLpqT70=;
        b=ZQWkriUP+dl7bBDbqnXs8cpktQsrKT+vgq6saT+qjjiMGJafkT1GgvIpOHge8QBvQk
         QmqFTMDBHOXg5UldtndWLoES4gmIX8Pxh44ngV2xp71EPBUOh/9riqrwzgGvpeiiz1M6
         cLJufQoSThWWoG+RdtjbljxbZLWFgXWlE3GhDvCpib8Ak3hcnAZoXqpG5HBLrIJeSrSO
         kzz2LuUw6tzNuMWShU6GjMhAx9oTgI9ZkYuxUHIdEPq5dBQywnX0dSP4BLPP+/ompOIY
         9lpw1ZRjVwn1l9AqtBFKrVPx7cUCLe8vUr4AwqpFuk9nl32sDAl3L3xuYRh6MMCNBt4S
         6yJg==
X-Gm-Message-State: AFq9FYISR2cZT7MR/aOWoGLvZkQnEPE42mbihj6rm5slpAmlnMqHaJ4n
	eCipa3UJdZnaQB5nWBL24S0alfSzCrGrp16cFgGDmb1OviK/32iPXtFqynMSlA==
X-Gm-Gg: AYBFou1bu0yLkfMzQl+vt4MpXXS3A5twJllOja7aSBRYI9vzWyuxoxinV/gV4LyBXN8
	gJreG9DBY0GZDGijHljOkOooQu7j3lEKS1TSq/kMD+PS0Py46ticLWjpRzMDCqv844a+NAhvMBk
	smhkNBrpfASoLZ9kreJVzCLkT89yimF5DOCtNz2iy7pdpkI8POCpszma6wMhndRzjjZnar6N1/o
	78tTc6CA2+TJuXqg2aOCj4dLMQ3Vw3qh0sw1of8hpcsf6uyZ0PKvFb61dcBGvmTsANbkiydjpfW
	cOdf7UZn6BbelpQGUOPT9xw2wdQ7EJ/R7EzmJb5N3AYq2wfQbE1OfkbbF+Rx47hHzqpfVi/jv9J
	CZqeeCt2h8PiNgqF+3o+NSwWJpV5EFz9F4T45p6ZRIOrneuKOfxDo1XpkGUME4CH2Xk05CgYkgG
	9rp8bl/YgH8eQT8X1z1U7re82gmXJ+7nZCPCKkcWiQ/8uFyHqiizmAS7mcQF5tfsCjMFyssgcjx
	ywQEP0QFgs37hZeVrW1R/jyqyEPzCRnCa3yu57eea9hcXzFu3jgXQltW9ekjjg5D5ySQ+BCkg8H
	ztMrunD37AM2PEVQTbqGKoDD90/veXh6w3z2rP6mScprVYokQM3LKUrwt5mdUSk3bk9pV9i4rcA
	9SyQHAk2f1hDHuKygulmsgoW7yEiUdoTHEl2lwp7s+lfACg==
X-Received: by 2002:a17:90b:3812:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3adeafc470cmr5380040a91.53.1792983785918;
        Sun, 25 Oct 2026 20:03:05 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0dda7sm4660622a91.4.2026.10.25.20.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:03:05 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 34/81] bpf: Let scalar evolution see loads from read-only maps
Date: Mon, 26 Oct 2026 02:58:55 +0000
Message-ID: <20261026025943.404450-35-alexei.starovoitov@gmail.com>
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

User space often sets the bound of a loop in .rodata before it loads the
prog. The variable is volatile, thus the prog loads it in each iteration:

  const volatile int nr_cpus;
  for (i = 0; i < nr_cpus; i++)

Scalar evolution calculates how many times a loop runs. Then the verifier
does not have to verify the loop one iteration at a time. But scalar
evolution does not examine maps. For it the result of the load is unknown,
and it cannot calculate the number of iterations:

  loop header at 3, non-linear latch at 5

The map is read-only, thus the load always gives the same constant.
bpf_compute_const_regs() runs before scalar evolution and already knows
this constant. Use it. insn_aux_data of an insn describes the registers
before this insn. Thus the result of the load is in insn_aux_data of the
next insn.

  loop header at 3, header_count is 10

A loop with a large bound in .rodata reached the limit of 1M insns. Now it
loads, as it does with the same bound in a register.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 44d524c966cd..5c2150928ff3 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -775,6 +775,15 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 		switch (mode) {
 		case BPF_MEM:
 		case BPF_MEMSX:
+			/*
+			 * for (i = 0; i < nr_cpus; i++) with "const volatile int nr_cpus":
+			 * bpf_compute_const_regs() knows what is loaded from a read-only map.
+			 */
+			if (insn->src_reg != BPF_REG_FP && idx + 1 < env->prog->len &&
+			    (env->insn_aux_data[idx + 1].const_reg_mask & BIT(dst))) {
+				imm = env->insn_aux_data[idx + 1].const_reg_vals[dst];
+				return replace_reg(scev, e, dst, imm_expr(scev, imm));
+			}
 			return maybe_load_fp(scev, e, insn);
 		default:
 			goto mark_dst_unknown;
-- 
2.55.0

