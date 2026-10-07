Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666D3DAACF
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394577; cv=none; b=r23VMTqlXpBRvcFNGv2/LX5KR4UgYAg3m4IcHUbTycICRsXEBqZjt0dIU2UDs30ip14Y5NmfUdrqe2MV9S1bvoqceQ2I7q2Ysq+YkPClfButwgNxDk7DwxdbSJhLtOxCyeOoOrHsK2PL7OEgZJlS2cDPhX37qk+3+wyAYTmlNf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394577; c=relaxed/simple;
	bh=j/d4+6UO1zMm/OSkoPxAoOFd0Pid5fsU1BUtdsYxUhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELNHNQ0mj5FiojcIjpZTQgOH5Wi3O826rLFe/54dxbCFpJDSGZ3ZaCznnRuvmndlrqsrrptF3FjFxPbXfaD4vmnEZNiwNsO8tOhxM1ZmdmR1yHn8d8hnw4+1Bf4GspaA0jyGtvM84dU0wiZ8Pgz5tdIuY+nmBjY9Ua5S10A2WXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ExPPqALl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ExPPqALl"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-533930955a4so19558321cf.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394575; x=1791999375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjHNn5scKRu7GjAo0oWLpeiDoRV+YLIFjeS0Mb9ZdUA=;
        b=ExPPqALlJCt+9yalLWk6RbFsYivWW5PHzO+MziQ4gRUj80vSE3/IQKFc2QIJukWwni
         Y0kNq4zWDXN0t+chEYH2HPYIhYryYDMYDTeMAfMaui0DoisWOtj02CCMYL3XDHrQNNxl
         X6vsPcUqIRA+vwqLMCYKYGoH2Hav8+NJRYiNsAaC7Jf2bdfNwM6jeCOMoLdAZwyWsbLA
         H0V62ENlIXMK3ZKruqQBTqqcIZWPeyjvJBkD+8vAx0/nA86UMAnh6Yy9ZAEa43D3AOis
         7PhW0pCnNtJKFYDGkR/w7v1zbKXwu/IFQdQ/l8FoVbaglXueHQByKEU+LqHtOfPmNvw5
         Jl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394575; x=1791999375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjHNn5scKRu7GjAo0oWLpeiDoRV+YLIFjeS0Mb9ZdUA=;
        b=KBHURNNCFRAoHz1v3jJKtZuwSc4LHFQNUREyM7c3Cre8rr8pb9+D8KNhB8a/2QLeAV
         DbKtoIX0Hp6vLe+ZZ/y6PFIxXSvWVL8ogHEAj+GQzqPBJd9v2h1JcVZFuDAjOWU2xSs9
         5nF4mOA9ZUI1ZdMVzZLha/dik+7NgAwpyHi80k4avXilhgDCs5pezdHOinvsw8Ot2HP8
         G8laeXff1aV+xzM7zm397o7RgcPJEfiJfIvpkrDwYTKQxlloYtPE1zuyI7C4arTJ4ulx
         nbcOcPiBBrzuC9QRmEk84UFC4GfR9TMWM37+XKEkU9WciLUHlg092KSQYfKQg8YhlAi6
         kUwg==
X-Forwarded-Encrypted: i=1; AKwUvBxCFKU9Gu6y7u5ECh1P2oyb+oWTZqSbBlB6rOqu+DIEjtKJ7xpC0iKshTAO6aPxLUyLWrU=@vger.kernel.org
X-Gm-Message-State: AFuF++mBpylxqCcyIeTmCFA1WHent+xKU8VHIh11+xsrk53VmFtXmbnh
	z8wwwlgcjjDNLP7Jxmy+g/xaMJps77G/DUeaGYt+r8ml92vOwoyS65i04ohJOQUac88=
X-Gm-Gg: AYBFou3Fx345UmOI+QigErxDDlsRwpWkUcHj0vbk3lEDdjtIvk4FfygjBxAfmx4oJDt
	9D0ub9CMi1nETavPYxXKWVtCMH1trNdGYSfsTKRcAB2DRGpoEmiaHskkl2mIN2fFrq0yc6+nY0v
	/NnC3n2EBZhHkb7iqKMurgRMeIiBg/jvjKkg4fhZSnYeiiOM2mTN0sE+ThvO8NLEI1xZKQsXQTF
	GWCk412etFbu254w3JTizhbPs7G+PTagKDVMDdlrtHE6GdCeLzPg0lNTIubq6xqxVpotFQCwvKf
	MIsahT+vTEmEz6ENSM5LXnQz2PU9HfcDu6svddlj21gEf3sJJskXyFbSqCD014Q/lSfSsqTafNP
	sLaFqVnypmDcEqAe6FmZAiMcW8pdrn8ZtB+qFAGgSV+p3MfC/GyuZ7MjvCrej+NNi0bD47q6tBG
	w+M2OJp41XeGFaCBngFWFjMdaZXuM1l3oxuLD39PKfLqG/hBdJSJggNiMC3JEQkPRvxzzv6ULdx
	BeAsXIIPyIKks8=
X-Received: by 2002:a05:620a:450a:b0:93e:7ec5:1832 with SMTP id af79cd13be357-93e9b70037emr607249785a.23.1791394574606;
        Wed, 07 Oct 2026 10:36:14 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e99157d6asm267866485a.23.2026.10.07.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:13 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:36:00 +0000
Subject: [PATCH net-next v2 1/8] net: skbuff: don't BUG() on bad arguments
 to pskb_expand_head()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skbuff-bug-on-v2-1-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=1395;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=j/d4+6UO1zMm/OSkoPxAoOFd0Pid5fsU1BUtdsYxUhA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMuGVBMQK42cE/Snfa08JC0fmwBrbf2GQNY3ya6ddo+CZ+JOvEDsXz/NSgzmaXVXIxa3Y07tuSV
 +hFZ2GlKKiwE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

pskb_expand_head() BUG()s if it is handed a negative nhead or a shared
skb.  Both are bugs in the caller, and both keep getting hit: commit
2cbb259ec4f8 ("bpf: Reject negative head_room in __bpf_skb_change_head")
and commit 64e6a754d33d ("llc: do not use skb_get() before
dev_queue_xmit()") each fixed a crash here that took down the whole box.

The function already returns an error that every caller has to handle,
and at this point it hasn't touched the skb.  Return -EINVAL instead of
crashing.  The warning is DEBUG_NET_WARN_ON_ONCE(), so debug kernels
still point at the caller, while production kernels, including ones
running with panic_on_warn, just fail the call.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 43ebe61c7fc4..d226fe77d484 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2303,9 +2303,15 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	u8 *data;
 	int i;
 
-	BUG_ON(nhead < 0);
+	if (unlikely(nhead < 0)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 
-	BUG_ON(skb_shared(skb));
+	if (unlikely(skb_shared(skb))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 
 	skb_zcopy_downgrade_managed(skb);
 

-- 
2.55.0

