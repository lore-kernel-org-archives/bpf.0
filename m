Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965128;
	b=WunU/f8aEv7H2D15u1C0X7EtHcRDKLWHI/oTaanzK6RyNNkm9BTsalj30W6WkgRTLpOL
	 TXsEY1iZRBpgrbskaZOIv9wbrAvy833/Q2HdlJK+3NuJpKY2YsEUO68szBBWH8u7Hl2FO
	 rhFP+DnyzWwRlJa1IKJNGLzTJtWfoIGQXvkbmL4HwySgUzasIjlQlUD9Ey0fCREoUCCo6
	 zcHg8cKKmzHHi9t+KTRRFYGQVtx/TjQyblTrG8Lt5bV2IHIPrPu8UXBP0Z/4BrWppbNVV
	 NdqLQPp9MvRV9psZpQiaHzz6D3jDt6fYzl1AkISFrqbG5ci1dWsmWlFqUdedZ106wNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965128;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=/jfLHbBsiNk6pHzafuB3Dsviz9dVAGhH/4U+1XXEIc0=;
	b=WFLMxkEnUOKyPWxftzjw7guVCoIdyagt21z6lEgoYV/B1baTm8Q79uHiNNX4OdowMQUp
	 vBlADjKYte/rFDVrd+dmalMd8Z5Zbm/FOYTF49tIEcJWCelbGBTjED0B9WZnHtjT7lQGJ
	 S0a6zVMTlyV4P3uYFSpgUSGJPehu7v2Iyx5j+Hpnbw6eV22n8gYPzirOnTbhcU7UXelIT
	 anMTEb0uyTEzcD0AZ+qU1EjU6hF7ELDqNKeLgkqGQ2YvHSr+2GjdUQCR3ps9N6Dg8eJvF
	 ahHzu0Ik2sLdXO4AwS9e+fhWZ9auBgx6dX8bt6MMrZvOJYpQJcb8Mea1Z6dMOoyYmGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818E606A335
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 11:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8818E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67bf3c6654fso504011d50.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 03:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793965126; x=1794569926;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/jfLHbBsiNk6pHzafuB3Dsviz9dVAGhH/4U+1XXEIc0=;
        b=EddXhpqx3fXLkXQTQcqdgn+S9gJgw4VoYIbzNHCI9+s2TFVhDUgriqrnfEhWE7Buzi
         PxsOQMVddO9cSGUoOEKAv5EOB2lfSkUS4nPmnjMN5x+ATn7P2HLMk17SP1lvW7yGr5n/
         3eviginUHzZim7+PP5rgJSsYYpoVkKlJRJerF7ORjspRQP5ZHDiqaxcdFAjnvhgTTSoU
         XV5dZlm+HPaNACTSbTVhUbTSXn++DtEIj8EMVhOPr/HLkBZsWlNR+CYRhT24eyvVwiHR
         KBtJnnG265AZgKd456i2xU8QzG9G5CE1ZmzIFff0xngg/aQw+Q8qqbvQZ6woKdh5UXim
         lp/Q==
X-Forwarded-Encrypted: i=1; AL+hErGDfCPlRcoNMzDDHEczUXeE2gXA2feqQVWXh3eXXkqHLuIrcxyOB8waFz2TTLURh1dUPTI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8efDV4BVJivDpfvYxaoJB93ilxls5x0hooTAa6Wv4CvejkkVk
	ui6kxoU6ZO73KqWK4s/i2G/j+tuw8tjLIAvOc2wgpxttFYJ7zEeiN0mEh8cAOA==
X-Gm-Gg: AYBFou2rzhyKLSdfCjg5/K5i22YJo9sUy7z6G6WI17lBQYjMkCTyleyJiNSS+V/JKoe
	QtgNZEnh3XOZOmcNKLnU2rwEqALMdU+FQKAgZwdx0hbY2ryAtxStLxpNZqUp7DnV1HRwq1E3obG
	vtdfXs0YnVZlq4XpWckKbho6ekzQoK2neueenbhIOzsRNpDCaPkMNqz6m1k/9xQA13Qemz/++z8
	OnHV0AVRy00vMDzLQafWtrKWTq6UQM8FI5Apd3fNJBMpUbAtcjClly3OGpUQJm8QLEp+jVomsOK
	kl2G7vWX3kK5BnhBEH074pBth/YhnWOl9A5zzSPFNlCMfE2B80LJ/iPzXfpTKchz/a3uFezGKL9
	2QcB5yU/E1uZMunnGBHJVFBe6Y2vD8p3wujGZpHw+PXHtE4ohbrrsLyBR2p49Z6HanuB3+ykDJ3
	6gPYnNONgi4J+tuXx3HiCQvkfSmjPpFyhBauoKQ2tUyYzStGsXU71IDRtsfbkJIQGlog8TV4uA1
	dsWPxy/oK76B/7redOBAhzafe1NaDY6BpPtQ6jVpePZeNsshPB/lXcU+//RhVs3cAyj/x+1AEgL
	AYyEW0RBQO9JuJxxcxzubE0n+H1dSL1TLpTkEFl1
X-Received: by 2002:a05:690e:b8e:b0:67c:1da0:6bd8 with SMTP id 956f58d0204a3-67c1da07981mr297045d50.68.1793965126563;
        Fri, 06 Nov 2026 03:38:46 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:5e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f8221absm16709167b3.27.2026.11.06.03.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:38:45 -0800 (PST)
Date: Fri, 6 Nov 2026 03:38:44 -0800
From: Breno Leitao <leitao@debian.org>
To: kuniyu@google.com, netdev@vger.kernel.org, llvm@lists.linux.dev
Cc: ast@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org, 
	kuba@kernel.org, tj@kernel.org
Subject: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with
 clang KCSAN
Message-ID: <au27Y9m78_3EH2v1@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My arm64 KCSAN builds of linux-next fail since next-20261015, because
bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:

  WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
  WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
  Failed to generate BTF for vmlinux
  Try to disable CONFIG_DEBUG_INFO_BTF
  make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1

This is clang 22.1.3 and pahole 1.31 (current pahole master behaves the
same), with CONFIG_KCSAN=y, CONFIG_DEBUG_INFO_BTF=y and CONFIG_WERROR=y.
v7.4-rc1 is affected as well. With pahole 1.31, the same config without
KCSAN builds fine.

The kfunc came with 5f549c1e49f3 ("bpf: tcp: Add kfunc to adjust
sk->sk_rcvlowat."), and 201a454df948 ("resolve_btfids: Fix the
--fatal_warnings exit status") made the missing BTF fatal with
CONFIG_WERROR. Without CONFIG_WERROR the kernel builds, but bpf_tcp_ops
is never registered:

  initcall __bpf_tcp_ops_init+0x0/0x70 returned -22 after 302 usecs

This seems similar to pahole behaviour sched_ext hit with a bool
argument, discussed in [2] and worked around in f2f095c87603
("sched_ext: Work around pahole 1.32 dropping
scx_bpf_task_set_lazy_resched() from BTF").

Here the argument is an int that clang reassigns, its location list has
no DW_OP_entry_value, and pahole 1.31 drops it as well, so staying on
pahole 1.31 does not help.

Not reassigning the parameter is a workaround for me, with any pahole: clang
then describes @rcvlowat in w1 from the entry, the kfunc is back in BTF,
and __bpf_tcp_ops_init() returns 0 (tested in virtme):

diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 2ba73dd6c52cce..1afa6bd7f508ef 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -370,10 +370,9 @@ __bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
 	if (moff == offsetof(struct bpf_tcp_ops, dequeue_rcvq))
 		wakeup = true;

-	if (rcvlowat < 0)
-		rcvlowat = INT_MAX;
-
-	return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
+	/* Reassigning @rcvlowat can make pahole drop this kfunc from BTF. */
+	return __tcp_set_rcvlowat(sk, rcvlowat < 0 ? INT_MAX : rcvlowat,
+				  wakeup);
 }

 __bpf_kfunc_end_defs();

Would this be acceptable?

[1] https://lore.kernel.org/all/DLRKT5MG6W2P.2V1P0QD4GQEKY@gmail.com/
[2] https://lore.kernel.org/all/7c139810be5ffc9764ed4236efc28794@kernel.org/
