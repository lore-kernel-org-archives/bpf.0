Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793076422;
	b=S0P9fLzytgFxywF10EKYNEyq+m5v+LWTmcACKqlQSP3yjV7Pg+yxFoyKxLvUscKtsCHa
	 EHaCx1UB/0vuJvTVIyBi6u23gHJBwNSgIgxFiVOrAG928aPWLzU3keDiKB/8f5iqUh6Xs
	 d94bNWC2/TeEiBcaFjNIqpyRphAmIksH0TgXk8vq3hTpHHqLKkDxHx4rRwkAhixcGZjP0
	 kCDOmMSpgl7dHL1pyKeom1Bauz9n5BcIaGb+1DObU2hwiqdxq9O9dDiV+QmXyAGCLReb7
	 bQdKgx1Yvp6xpiTkgNYTrb2aKmOR81B7jPLlmZB0lS2XGnvj2jB4+eivlPsF9YFc+Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WURMcEEiv9km0HuI6txsDrElGgFNRy2mTCX0NtkHLm4=;
	b=dOd2XSJUWpqp9xfVFyu1dlCejaBMGZSqIlHu9Tc1S5i5EskkTNL1/6o57XdXfTH7yBS3
	 fEEo39Y68F1J/ND2Id7SEu+8D+pxHxt1mZ/oLO0tnZSKe9ZV/4OBiyaoWa3BzE9CBQQXF
	 +9/EZ3amRpPxeJTAUld8rNF0i6gYC8CPuOOxBCH5N80AznA7kR1L+X7KbgzBfLKFZOdrp
	 jYG9I389MWj/QL6yRqfwaZ+gTGWUHsiWohm+A6x7NmHduY9e0U4P25lAcZz9gl5+sa5/u
	 B3szcxrHSxpN7lXWPaC/8jrUGFryOg1ziCzakt3qtD3apWCffMZwJlCHZ6nO39TZFDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=m6bBvmSW;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28A606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 04:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B28A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=m6bBvmSW
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so4477617c88.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 21:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793076421; x=1793681221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WURMcEEiv9km0HuI6txsDrElGgFNRy2mTCX0NtkHLm4=;
        b=m6bBvmSWGHaosFaUuodvNtqp3GmNS1tz0C5ZGlflVDcZ7YcZiKwBrG8N7/58QywOrP
         nGo7Yeek8LM4Ma338xJnPpxzBdoLYWDiucejDkX5D2uOa6sG03WeW4JT7OnCxU6xVf7y
         2dG06cKm+PIISj2kww+AwE7IazcUUQVEBOzazPPoltwZ+K/0j/g+Sh2WJ8MRxKnCVFiS
         qQEJ9GlFgIIyx25iw1VzwoqfOE6Rr2spBipHeoXmiiaT3yAjMa69VJyfh6oFG4kCgXMA
         VWudhOa3qykkzrUObW5XGPe/bPMS98tSM4C6z9jjn6V4bseCwB1tS3XFYJ+YpdxtmlHY
         DrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793076421; x=1793681221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WURMcEEiv9km0HuI6txsDrElGgFNRy2mTCX0NtkHLm4=;
        b=qLpOzK9zWaKq6eRxnfVyYY7BrU6yrm45wBA5M10JNfj6o5z9DDK9so+VHyntATqz5L
         rKrArftDATmiMIoryeQMXn8PPbudHaZJmZY9JjYFPL9mEHU4h/zSN59ygAAi9EelS3IT
         tSvzXED2YJ6AEzQe10qrr2ZPmlJNaw2uF9p13Bn8lIQLQ7lPU50axOmNoFzWzIfwOElv
         D6HmeS5Vj+mxzzAoE0nZCZKX+t4ejwaw5MQVdDP143dewht9+DjNlHmeE1iTLYhEtULF
         r6AwoEQRmcLbzTQsHcOmA3CYRWoigWTUFKi0aFygXlbF+lQrRNPDQ1y1397x8hpfI/eg
         nWmA==
X-Forwarded-Encrypted: i=1; AKwUvBzbdv6Vs/QiyUlbhmGHstwIlbqTsPsVcCj4gBrgSgdkW7fb/CY6RH1Sn4Er6AJVHxuC+CY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4qZ3prHfCKmsFhxIioc7/TQcHCJ4ZTApU/sDiFxoAuoY6wrpI
	4j4yVMti+zKyqUWH4Td7gprpbfF0LWzztRGcXSAVVQeXB8ydmhf0ZQy1eO/BWhLiVSI6
X-Gm-Gg: AYBFou0Z8UiVL8mFlBlizCg30iqT0mQT01l/6+FoburMcTNEc0AqKT2msdkNuOpT+Yy
	Fi9NvyDQ+ZKBQdBQqs/9NvhRpE/ruA9Yxfi1D0XYu+115fAqZf2Nlt6m3KzGQQDiOYcwO+TJvih
	DcfB1C4GJsxIaB1tYQhzNd3csu5MBPEFCf4wyIdt2HK0TM8CGe4vfhmlvCEpgIDDliapGj+ZZgx
	sRSSjU/mJ64W/Tm97TVN6TkEs9owERLETsfOZ/DnIFgPx3Qw+0UGqHoKbQDgG14qCG0DVK25fd4
	c+r/9pTaQniHs+jCawnMWuf+DYqNby4HccHc42RsN135FC3JC7YbPIxX9yIgsiUhW9lcG0mh9AD
	5CD8Csm7kSiy1dfzh1pMSiQy2+Mx9eVYvsu2KEGogNsQloxoV53YPFPU8xFoPcGn7sTT6zE725j
	wPfkWp6MhUeDTRT5dLunjtROrfl4jsvkHi4QkDQPvqvfoFyFSrwBcUAaj82SOZAi2/pq/isrUzF
	oLwhAXluBPHmEkK1vm6hUh9f2zyJKhWRTj6tMOhRkm/B8VsXZUVrtY3h4/ocuwlLCFXNkpQCO2i
	Bg/v9i1wHz+OrPBgIcSZH7bED559hR/HTk42oXjaiw==
X-Received: by 2002:a05:701a:c941:b0:144:fa58:95d8 with SMTP id a92af1059eb24-19935fcbb52mr8965104c88.27.1793076420958;
        Mon, 26 Oct 2026 21:47:00 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2001:49f0:d0db:fffe:97d4:c0de:15a1:9c01])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm28781261c88.22.2026.10.26.21.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:47:00 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: edumazet@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	jonathon.reinhart@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] tcp: check congestion control restriction first
Date: Tue, 27 Oct 2026 12:46:49 +0800
Message-ID: <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
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

tcp_set_default_congestion_control() takes a reference to an algorithm
before checking whether a non-init network namespace may select it. A
rejected request returns -EPERM without dropping the reference.

This affects module-backed algorithms too; BPF is not required. For
example, after root loads tcp_bbr, a user with CAP_NET_ADMIN in a
non-init network namespace can repeatedly request it as the default
although it is not in tcp_allowed_congestion_control. Each rejected
write leaks a module reference. Since module->refcnt is an atomic_t,
2^31 such writes can make it negative; later module_put() calls warn,
and rmmod can hit the BUG_ON() in try_release_module_ref().

Check the namespace restriction before acquiring the reference, as
tcp_set_congestion_control() already does.

Fixes: 8d432592f30f ("net: Only allow init netns to set default tcp cong to a restricted algo")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
  - Check the namespace restriction before bpf_try_module_get(), following
    tcp_set_congestion_control().
  - Describe the module-backed reference leak and module refcount overflow.

 net/ipv4/tcp_cong.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 8e83ef81fc187..e3f462f161dd6 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -288,12 +288,12 @@ int tcp_set_default_congestion_control(struct net *net, const char *name)
 	ca = tcp_ca_find_autoload(name);
 	if (!ca) {
 		ret = -ENOENT;
-	} else if (!bpf_try_module_get(ca, ca->owner)) {
-		ret = -EBUSY;
 	} else if (!net_eq(net, &init_net) &&
 			!(ca->flags & TCP_CONG_NON_RESTRICTED)) {
 		/* Only init netns can set default to a restricted algorithm */
 		ret = -EPERM;
+	} else if (!bpf_try_module_get(ca, ca->owner)) {
+		ret = -EBUSY;
 	} else {
 		prev = xchg(&net->ipv4.tcp_congestion_control, ca);
 		if (prev)
-- 
2.55.0

