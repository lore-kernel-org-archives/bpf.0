Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794193439;
	b=EzvQb+ECoJ+nrMni39MxtKAlLvf9PSlY70Zh4cvdrvlnVxm1newTwVWM8BID3DEv7BG0
	 3OXd5pfEeSt8cbQMkacOuS/8SW1N1KE5N1VRAddXSwdeiKBqSxm1S0QypbicpogYiA1l1
	 /jcSO3kGiXv68nkYHrSe37CItbehtnotbMqrjV6QY+TTE/ijwMxdQCT1hkCmcxlMNDdQ8
	 OsW6NkH9SCumKqlOlB0mlaG0qJNThixmyUZzxfOwCF1WCtDPMzmeSY4cywP3cqPicC0c+
	 ug4TBi9iH/Xus3ieNgPI7vOkjkd2t+9Cy3+G2BJjO2VyTfEel4Hp+0tNLyeDHAD8oYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794193439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=49Ofl39dJb7gh/iP/LhPJ66n/2RlMBuRyjkGefnfkiI=;
	b=eQzQNJE3nP4pzHXWQQhJw5YFQqb5Dcqs25zLYUA7h5J8pmLETkRKAubdYiS+Qk3MXNqt
	 kk7z1mtkxOkrCfqdw9ZKWOdLbf80dMV4VOVAVHn/R9hlnA5c8HYggbvIlMNyCiZssBAyP
	 YS2Xby43Fx6DVbdgMEDLv25IL5UMKkh7lMJi6wSoVComKnIbVHtK+VXnFvRFgvKUmW9tv
	 WRgx+Py0Rhg/j76mA7FQ03NZlITzq+uCteeufa6q1Vmznci7HqeENOyqchlS+3kaWXbyq
	 +UExvudf4Va1d0tEc9GnIfZcrYCTjlY9FK4kstXqExHg+yYoi1EgT9JMxOirGi82kEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=CsY0zSFN;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1831606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 03:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1831606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=CsY0zSFN
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b10ca4e3f9so189938a91.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 19:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794193438; x=1794798238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49Ofl39dJb7gh/iP/LhPJ66n/2RlMBuRyjkGefnfkiI=;
        b=CsY0zSFNop9s+D9SsbaLfqmJrwVB1rdiesOGl3tLLDF4OuilG3m8A8izAuiS8kB1LG
         P1rk8TUvZ+VOcAcFSVnMDNSy/m3EztGoTbHNCu2p6ejjm5vsXPIvAVnxzM3IqVFcbeKq
         r9q8SKKiykKDDXio+iNZfvLrcqq2CeLc858vMSPs6Q0XvnzRT4E1LU5X53ikfvcC41wT
         SG/VSENtREfNBDOYF3TpaSEts2gDHKzDpOeGbAti2cRmKsFcMAhXABlSkS9B14ausqk5
         1Fla3TMAkgG+A/N8qKUS0rnsqH4ao/P2LRMjbH0qgRo4jutBP3cBoR4PCrRsOCqWTbAi
         JA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794193438; x=1794798238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=49Ofl39dJb7gh/iP/LhPJ66n/2RlMBuRyjkGefnfkiI=;
        b=OuJn/0VpUhxoLgvs3sc+5tfu/lA73+g1bVCIY/10SWsIyN3I3u40B8LrW/VO1PoLI6
         Kj+zGVB3AlHf40niD29QLuAI+DDq2dTvhQ7M4241oMiCJKrYPzmJb+KJH4F4wwtgYny+
         11JhkK3mx+8a3fv+6eaBB8kxbBAp/mmLHHcq1sbMCN3X4ZH7BPf1PwLDg4huroRi3fT0
         t3tMjtcuzKV1T6Bbtg6ghPFAxjzh5Ym55NO0eqU88N9Dasu1pZ9JM5UG90G1XFTRyIvr
         BrxDlXK3KLQjSjy0zlHfukxcrzoek/6JHfGl9UXswHe/XYtpG9wnjk6o4FzM+OguB8kg
         NUGA==
X-Gm-Message-State: APuU4Z/qmQIeM/IkySkEbm5RKwgY48WzuhkTgvN1HOaTh5WPqg4ucYkU
	xhYM6lZFMXz0meN5OuSU7ZKrfWvnzF/K2AKe5AGYZJgCy5JIWyGQ/vlrl6VqxL0yPR7ik2wYYim
	k7DZDDA==
X-Gm-Gg: AYBFou3p9RJUjHJvK4pX+Uage72KYWXLzne9yxqNzznSwy7HdqCT6km1ZRS0msoO6j7
	CI2rnkLIt721dAlKjkwCv1w0pPi5MtUcv148nM8kwrqgiQZZIzhGsc9RlgM09y0NHxFgSZk5Y+M
	iWBnTp77VrtRtxcUKddjIj7ChVF5E9+DjYTh3tPY8FsQ/mCd2RLQIHmEidzv2t1l20r00rxAZA0
	wHSdGXqsDkn/n/kF5b9F1GQ8x7McGBO8W3xgDbt7xqrzmH4qBCXgwg7j3hTPtFuqr9LTg+4VmfJ
	6nkzcBJsrsbCNG6nIh7B09BF4SeFCwxOMmDc21Ge+TejHghjxtuIArmFVEN9WOo4Ng6hQtDcbWQ
	WgiG2qZ7AlG+SveXp4OzF2lWXWPlvQGopch527lY1a1P7u9cD4DBrNn9moBKfCrwD9hMmiAb5ri
	LFEoeWPIfxDmPpPG+nvu3GtHhfThd6ngAavVCNmjud5t8RSgnEUF/1jbjoRjPloTzKWmMNjM0qz
	ASz4hXvXYUEzxt9hdRRg09BjmoGNAXx0++0xe+gEtxzupKeY8x5F1WwkofP46TjGDAJqEQKB8YT
	SD3fyCO0i1uK6BUz7UsfrjB6m5euPtpJSbkWsIKh7EGp0R2PYRR+lD9XLDM=
X-Received: by 2002:a17:90b:4c84:b0:3ac:9599:a689 with SMTP id 98e67ed59e1d1-3b12d373624mr2243941a91.34.1794193437892;
        Sun, 08 Nov 2026 19:03:57 -0800 (PST)
Received: from enjou-Legion-Y7000P-2019 ([74.52.12.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b12743e889sm4981759a91.0.2026.11.08.19.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 19:03:57 -0800 (PST)
From: Ren Wei <weir@nebusec.ai>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	void@manifault.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH bpf 1/2] bpf: Reject user ringbuf backlogs larger than total ring size
Date: Mon,  9 Nov 2026 11:03:44 +0800
Message-ID: <ecf1a73cac8881d58b0b5957fb72caaeaa055339.1793951856.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793951856.git.rakukuip@gmail.com>
References: <cover.1793951856.git.rakukuip@gmail.com>
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

From: Luxiao Xu <rakukuip@gmail.com>

In __bpf_user_ringbuf_peek(), the kernel ensures that a sample length
does not exceed the advertised unread window (prod_pos - cons_pos) and
does not exceed the total data capacity of the ring buffer
(ringbuf_total_data_sz(rb)).

However, the kernel does not verify that the entire advertised unread
window (prod_pos - cons_pos) fits within the ring buffer capacity.
Because the producer position page is mapped writable to user space,
a malicious or buggy user-space producer can advance producer_pos
arbitrarily far ahead of consumer_pos while populating only one physical
lap of data.

When bpf_user_ringbuf_drain() drains the ring buffer, cons_pos wraps
around the physical buffer repeatedly within the oversized unread window,
replaying stale or already-consumed samples without new writes from user
space. In the worst case, this leads to excessive CPU consumption and
watchdog softlockups.

Validate that prod_pos - cons_pos <= ringbuf_total_data_sz(rb) before
attempting to peek samples. If the advertised backlog exceeds the ring
size, return -EINVAL immediately.

Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 kernel/bpf/ringbuf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 447863ece26a..cfd4fe4e85ee 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -761,6 +761,9 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *s
 	if (cons_pos >= prod_pos)
 		return -ENODATA;
 
+	if (prod_pos - cons_pos > ringbuf_total_data_sz(rb))
+		return -EINVAL;
+
 	hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
 	/* Synchronizes with smp_store_release() in user-space producer. */
 	hdr_len = smp_load_acquire(hdr);
-- 
2.43.0

