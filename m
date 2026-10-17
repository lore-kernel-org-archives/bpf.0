Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D968384CED
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200836; cv=none; b=YQV488pHhQlVGso/Io17SE2LTsIiw/n07NbLc7q2b4p0WaARgf7Bo4KRmxKPDzaPf/h0aCQ02cWmktJAzOAfDT2bIVLzeACCsVspLW4sbqj+JveApDJon1omfmvqdCTmZrPCd0mjD2qdci/29IqWyBs/pivJuN80h5ewIb4ZrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200836; c=relaxed/simple;
	bh=rWcVk57bd7XJ6aqHjIBKbQ1NUfIUN7X6g0abtAxWmhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfUEg3svtE5eTlnZ3/iBh0TYlftsG6karB7jBuElqCwnYr3XNA0znYFnnrnWQgz8uGP7ANgY2A07o1G25yYJk+OHsr9Yhj/bTaccyc3vEYAoi9ImTSQJ/jcmUSbwA4cS5YNo5GO1KGStRnOg84PtpPuMnCvOXmSzFfyJGMy2eiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sveKlZqx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sveKlZqx"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a706146559so421746a91.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200833; x=1792805633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdXziGzorg1BVqALTIMKJSo9S3AbmbdZUCYUiZVmWiQ=;
        b=sveKlZqxNJEnj2qpKkfn8K8fp78QdW3/kc1hsE9gnTs3CKeI5B7d9Qm7u0r8COyWC0
         5aj4lPZXUnjSLPSCdqKZo/aoFMF/D4hOii5LEAIzrCAPTX0TMB6Z7puZU6dsatypoxqL
         b9SsaWCJ/dceIw5+WvaScxo5m0UJxFEO4I2Sh8Wz3+GwC8EMNHVjtC+ch+7Zq+4NRvjd
         l1y/a6AY6Ee+inyqB/F8O0KrdWkCbcNY65Vyiov1zrPjHaJVqlQ4SfPLl8OlPA1YpWfa
         6Opaj0ZgukAquGyXMhysW6p2k/sKAl22jjXwiRVAhSS+uEGB3pwa671wfQRnK9+hbPcd
         K2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200833; x=1792805633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdXziGzorg1BVqALTIMKJSo9S3AbmbdZUCYUiZVmWiQ=;
        b=KmTUVSw1XIXnLF2SNGMpsh8ciuCkjYPIk6VDC0bRcQkUKJ4PHz1V2Ux7tGKEde0bry
         FfhX2CMW4X/DqkNox5AjHxJs5KGfKGqxh6Ps0WU3NDpFO/yGALdImSpM4MxRU+NLynFL
         RfTAlN9bjE1LT+llHcw1mAwck9gbXvfigAi8YFojlAe6MHMbjbYqXu9rVR/Wq1EfuY1E
         3q7cnkyL7PywmKKoSSom2zfRnCRhQaCf/6lHDuYW++QEPODeBL9PiuttvCJ4sxyzF7P2
         HdywIRsIpH93N4ON7rUJ4y8H0AQQgQdKvbbPf+rFXSDPyvx8vcKfipoV13qY99ZC8OB2
         dupg==
X-Gm-Message-State: AFq9FYJGE/mv1yL32yQrxBYdaB/crzPbxxqiMzQnRc2eytll3qI9GBil
	uSR15z4FW0z8ukAvHuyg25IC0XvmV3uCiLkDySzWM4F10PPwBHboEJuLxgIWfKSs
X-Gm-Gg: AYBFou0C0RDUMIljwW5eT+Y2urDhPXc6rW0rpUPTsb609858fl8OHz1pyO8hYmvGPwC
	uRBynpDAvxHB/uyAZMT2R27O+0890RwSWtmjYG/oTKgUPLQSiWoS8JWcUDmrmgoO0mMZoccLk7+
	1dinen0itMu1wDdpzQL7CK0BMD55gsKDv2QHvTzZJ9fIIJTRh6E4jS4I7Y2khPGz47DQ86iy1sV
	Qil2PmX71BXoM1hvWmh61NErVBBzw5+bujxxnR4eo6Qjwf17r7ZsNlB4DEfQPsDLbqnT2X+Hgy1
	cd9KJIfH51Y74HirDdkx/lHP5/7YF1yYm7kli0rK5+Y9SxxU5bQwhoWDpUCY1HLaUKBRjqUUswv
	dxiYBydaY2ervSG7Edj1qIaGXNgqBfgQZQFKauSywGlAeedZbxQBQirALkLr4UssmPY7KxhtvGp
	7l2fyzStLWItYFZKyDnXjP64RgfohBoQqrww15SJLPd9MT+XEMAlLTmHUKNq5UUIcZWfp+z/GBV
	C//gtDEu8SZDkfXHE+BPa5xDeXa9K6mEAgYzS79U6oEDOwVFHwjCm2lpl3+/EcDGEQGRZCz/LNC
	nD52tJ49o4cDdEDOrxTfmoYYmdM0kndgEEh2oB028aN4zQ==
X-Received: by 2002:a17:90b:580f:b0:3ac:9d83:8856 with SMTP id 98e67ed59e1d1-3acee728d5fmr1409074a91.9.1792200833215;
        Fri, 16 Oct 2026 18:33:53 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f4cadsm6093997a91.12.2026.10.16.18.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:33:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 34/38] bpf: Let bpf_dynptr_write() mark a global function
Date: Sat, 17 Oct 2026 01:24:47 +0000
Message-ID: <20261017012451.364800-26-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The caller of a global function loses its packet pointers if the function
may change packet data. That is found out by a scan for calls of the
helpers which bpf_helper_changes_pkt_data() lists.

bpf_dynptr_write() is not on the list, because it depends on the type of
the dynptr: check_helper_call() looks at it. The scan cannot do that, and
so a global function which makes a dynptr from the skb, or gets one as an
argument, and writes through it counts as harmless. The write can
reallocate the head of the skb, and the caller goes on with pointers into
the old one, which has been freed.

Let every call of bpf_dynptr_write() mark the function, as a tail call
does. The same mark decides whether a program may replace a function.

Fixes: b5964b968ac6 ("bpf: Add skb dynptrs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index bce7b5abcfda..2ee950e9ac82 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -598,7 +598,9 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && fp->might_sleep)
 				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
+			/* nobody knows yet whether the dynptr is that of an skb */
+			if (bpf_helper_changes_pkt_data(insn->imm) ||
+			    insn->imm == BPF_FUNC_dynptr_write)
 				mark_subprog_changes_pkt_data(env, t);
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_call_arg_meta meta;
-- 
2.55.0

