Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937274;
	b=Yr3x3g1XLTIPOk9vw46Dj0yaF71ZXw/tlCjOD+/NHWKrWprJuTcmM7gGEYtWrcKHT2J2
	 83ryh6x2jzjxPbL4zBjUVkOZRWx0tFL4EUPtSvMRoMF118q6MyVVqXBjd2olBlaVHOrjX
	 L94L27IFWHAg66obkQjP/pBhXtjH50SXSeweiYYFVYew1u5OeOXIRMVbN+ibwnp4NJQT/
	 sDsc2I8Qxcez6zP9SrWVPxUMjrr63Upcng6OcQXVDV+bq+IIdHbBUbchr72Q6z2pPxybF
	 Yeaz/XfkYJMix3XJ7E1LZjMsLKhJFcG9Q/SStbN1BavQhoEGDPFFVFyQ4vof5nPtR+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FCLy0GRh7GRl4RJbwZ7iS0iYBbYXSP+cacGQRSsKetM=;
	b=t88NT4OvwY2T4P3kIB8CQQ0tRf0OsTy9m79lQzgfpjMPnvsQ1fRQQk1hhJmCMUfKz2kq
	 MjUrnpaNqt2q7RoUiB/6C7u69EmhOY6y9/krgakWuZR2tAnQH6dmppDkf0BoZ6oJkjSP3
	 QUR7vNM5S6JGJg20skWRRLsCk41Yz/wEr1oT3K1ghFDSc9hOCIFsCzHdahiynp8brohTV
	 c4PNC8BJdkUU/ioIicZChBgLXm1Zxc4nmZxzm2UqjEAdK7YpSpniQFYaUceeFdyDC8wR1
	 7XI9EGCxdclBFpAGl+02uYSYH5B/F9EcijPtR8b6hBWWuExQzk+W14xfCiAmmDg6dkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ygpejfg0;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA61606A328
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA61606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ygpejfg0
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed28bac8d7so1066225ad.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937273; x=1794542073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCLy0GRh7GRl4RJbwZ7iS0iYBbYXSP+cacGQRSsKetM=;
        b=Ygpejfg0hpc9IMnBKsUFglanbhqt21NMOpKw4e/EWEkJbFNho+IAOggtFer4WBeacr
         HCeiVKUT2oNVH2UXgQf6dweESrTpXr1kXFxH/JhaE4GqQIIXtm+eb2PxMGWCxryVUUN9
         ORB8D2/AisT3DQJ0c/t1dpRiO4s3jldeIYt61hVhmEoypepNf2uhIKaFAVu+6CXsObjO
         ysZAsc8L1CsV1EuU84i13tcxBGKugW8Kgf809VePScTRkycvzmvlaBtaAPNKZYhXjcU4
         /of6uxZ+ba3Q8YZDwuCT9u2rmzDzL7d/5LgXASNZvaiQdgCTsi35eYcrtCXDLvGi5XO3
         pYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937273; x=1794542073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FCLy0GRh7GRl4RJbwZ7iS0iYBbYXSP+cacGQRSsKetM=;
        b=T2lRqaKzcpl7e/gvAI6T8VCNRWtqX+3f6/UjHxNSTDwuJKkvVykBdL/DZwxgf5DoC+
         0ZpbpC6sY8OQjp6sceWAY95c06VNf3+/U2K3UACM2PbWE8fiOJ+kO3xWHr7A4tgPFp0T
         QBhvEqWToQc8PKN4yMAQmVEMA0mqkhT9I0gpxnEhkp+udQfvYqxAhH5K98gGEyF7ps/0
         nfECd5UOaykUEaf/FogtaNATR7XmpW/fxPNu7yLdgFYO5/+/19tqN8ByeSeJsRLpNQiR
         IxCdHDs8e7m1INs5nJN8+TFL1/c44R30/ExRthJ8Z7DwXYALyJE6gY62B8c8wqsOfvjb
         bHHQ==
X-Gm-Message-State: APuU4Z+gav5pzYmM9/laAvfrfs44wgGQpzS+eqjV33wSCuQ+wmC6EqWe
	MmYc3KsJP4ytWoq4R16uw4fxY5pHaMwNRWIK9lcq9xSLLxr6jsgLGqI5P9je9Q==
X-Gm-Gg: AYBFou2aIXljicdWnV0iNtMkME5p8jPpHnD33C7kK4RFUgxADXWLNh+PydYQqHgwZ2k
	D0ATfdbPapdYOl4GqfusTxj61iYolU/dfUzVgnrsC+BUmTrAkA5EF7ieU3IRRUGmdULZifm/GeD
	o8tuE4z+qvMwHqbcYRT+FlQnV7qI3MKpM8+sW194t+tLtJ+t4phs47GbEB8OJN6Iu/DTc7uacgA
	QTsnHOKZifv8Qsq0meKDtgqXAWIs3MjMpl2MHq3MrUG57yBnD9BPis8la7jeqh4ClqLSYs15MMu
	oeaZRzQCSYm8nBLSn7Kzc+f6vv+b2ckIY6DjDoLZecTDrhh18SXKjuPIfy7sOHRgvnKDi3G6oyp
	bRxJQBuxKKq5Zejk4szawMuwgTonOfwx+jHICpXdusjIlDHavvD/1IEiMAuzRyhDiy83FwO37HT
	NQEFOQ3wPqql2XyCiKwvEHauLZnnW72Ba0cFPaESjq19NDiJDCESs+Jp4pWTkufO3irV1AVe8PA
	LjklIRPApxbBebhhOfC3wbBHQthWIIKTRTZvPlztQZwusYrJR03FFDIWrD91km5VDNjs4PMAjtS
	9IkzIQDetIjCLxRclGHvizDMcTUElQQ3HM4YL9AaidYflzhIIFfById9h0MkVhIXZLBQl+HkpHZ
	LAcPG/cHGuv9TsEraVDHuN/VJxFiIE5WbNG+zkJUdm9gE/OxDagN0NVpKVMNFZnHgLUdjmyNxDA
	==
X-Received: by 2002:a17:902:ebc5:b0:2e9:6645:e9a9 with SMTP id d9443c01a7336-2ed40da9c8fmr13689205ad.32.1793937272996;
        Thu, 05 Nov 2026 19:54:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d408c4sm1171475ad.31.2026.11.05.19.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:54:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 34/45] bpf: R0 is live at the exit that an added may_goto goes to
Date: Fri,  6 Nov 2026 03:50:58 +0000
Message-ID: <20261106035111.3315285-35-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

  const volatile bool debug;

  if (debug)
          return skb->len + 7;
  while (*p)
          ;
  return 0;

GCC emits an exit for each return, and puts the one of 'if (debug)' last.
With debug = 0 it is dead code.

The verifier adds may_goto to a loop that it cannot count. If the prog
holds nothing there, may_goto ends it with 'r0 = 0; exit'. Until these
insns are added an exit of the subprog stands for them in the main pass:
bail_insn, the last one. Liveness does not visit dead code, so no register
is live there. r0 = 0 is cleaned from the state that gets to it:

  R0 !read_ok

Mark r0, and r2 if the subprog returns a pair, as live at bail_insn.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/liveness.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index c8f74063913c..e930d928afa5 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2880,6 +2880,11 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 		 */
 		insn_aux[i].zext_dst = def32 >= 0 && (mask_hi(out) & BIT(def32));
 	}
+	/* the exit that stands for 'r0 = 0; exit' may be dead code, see push_budget_exit() */
+	for (i = 0; i < env->subprog_cnt; i++)
+		if (env->subprog_info[i].bail_insn >= 0)
+			insn_aux[env->subprog_info[i].bail_insn].live_regs_before |=
+				BIT(BPF_REG_0) | (bpf_ret_reg_pair(env, i) ? BIT(BPF_REG_2) : 0);
 
 	/*
 	 * Forward pass: resolve stack access through FP-derived pointers.
-- 
2.55.0

