Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541336;
	b=hbFHp5VyRcBRub+Bdeaop2OGVtHQtc/Y4SvuU1V/i9wS3pWt4tsFP8e7duyvaatXrnQL
	 2bTq5gc8tCJKIWj7pMn4R/+4Of7tNIrc7u2RdwixsYKss6OQB2HRRu7kj3dcDg9GiGM8e
	 Rffm6SituELNVENg6YFe+9fvB5JqX18GImTsmo6E600YeM9tsBwmRsjVX7P1CqLZCT7Tn
	 fnaXYka9GDG0pa32aZF1B0Ty5VJJcjU7u/gb3QCGUf6aCakGRnBdKNti3Vp8LNafV3LoP
	 Mx+z4GfBHuYUYMtfrl08LUBydKdco04L2a7h3i78OmT+i9nzpGCh34uqlSQa6zwPuuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=WlcWiZFsIF0dEuDGLSJlLXhccf1fNyo1Yhd/8482eB0=;
	b=zMAvR0xhDmiUi5I4fub4/vOWW/iPQu2CpbVLH0p8g7hqwy/Ni2FK06EV2cvZFGIh7qlu
	 IMluBF3/IduHyffW/cMqFGzLHsOLYALerCTNQnvzBuFGLz6aGxPlYGjTt41z2uwxUvkzk
	 u4ZgGBYXdUrYoRhnpqnaiyUuYrR7jSJgBS1fAlY38D8RjK6fa+VPftSBqT1z42xRVZg9s
	 q4q0X8S8ROcYB7XVPnIlVl497BwYHAuNLdJV6j5zmN6gtc7aKTDRvFSC5fLDBjHNBIAwA
	 bA8ERfmK3tDCR/zA6PIy3ltEq6FIk6KHFOJpclTrMyLyqRDdbcASy81D+RTTQ2uQ6Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kE1mXW+R;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280A606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 00:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0280A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kE1mXW+R
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8246b13cbso998355ad.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 17:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792541335; x=1793146135; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WlcWiZFsIF0dEuDGLSJlLXhccf1fNyo1Yhd/8482eB0=;
        b=kE1mXW+R0uc0RnzhxajsZVWU0NhpBfWoKjK3jty5B4cabEiFHnnZ/XNzcOjkKDdwDO
         1OIwxbRFVD8iyGuOsBIrDRs2jP5psmdKfjx1oe5iflL0oaqJqcVdfPeWgEg4KVwPfBdI
         NwSrdF3cZEIxIxfZdHTrMe/akrd2T92k098ALJG/aq7kKThuEzJRsQDRHFs2e/B7JSQO
         tnAfhmBTa8ufVBfk6sf+kWpyDp3vSAjUdEMEPBE/lbYQSUmUfvadYDNTzt1YCitkU6ia
         1nwv/Cj18HpIuVc2s5uYaEYGHtp6KsLvZU1bgpZR8iFOZpKTRnXVGI/HYlRAWaz4fJdj
         O41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792541335; x=1793146135;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlcWiZFsIF0dEuDGLSJlLXhccf1fNyo1Yhd/8482eB0=;
        b=h5psLxH76Y0Yu2/x76UnEBlhpazLBqXIQUl/3EEaT7bv5jHzB1GQFjgFT1plUtjGd2
         Z0HqxSHTyy0JPy+mA1sqFKz/EixIodBeTfX0qICLupGtc9yk3BlfutXuxrgOOKRHU/+C
         NfwGPzWJwkFYXC7mKO6Ufs9p/28qs8Ch3yk+tbG35kS4gotx1fp5suzXt7PTUTF5CliH
         EOvK6dL4ND1l/aZe/4i7HNtIXjvd6niabDyb1FSMhxF+gYviiml210uraSy/CDU2Lblj
         pBUzYwec/E09v8rfL4h8dYIjWozQHPPu2iQweFZzZXswex3hrbLQD/sNS7xH/eWJ3+2s
         wdSQ==
X-Forwarded-Encrypted: i=1; AKwUvByv4ZaNNcFLIls0hPJhqAnESz59A5mlvhqQNuG0/wbbQMytV6dSsm/lbbIGxehbraV7L2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzaU0g2OMrDWiPwULRdJH09gbuZspsNfFMLXcL/JhSwzsUdUhm
	0zWNe6+d4DuCGGvDorgpUXgaKVZWJZ2qZriHpPBzdHr7C2aRyo/QqBrL
X-Gm-Gg: AYBFou1VfiwCL5oqweEmpiCqomRuzRYJVix2Ou9TI+uEZRB3sp9FYy00hTQXRur2HSC
	CJ/9gzp3odkPQxhHbHhrI8JxIeQJS1Zsh2GZJTHH8XnzKjTXoTQlMcMYztyLJFXX+5z1QYtEikS
	47YZyPR7igFfzuZ6DlDOHMPri7hDzDaG8Ghcwukk9BvWiXx3R/tV/MtSfkdr3t0DqpkYiYA3WGc
	ZHyOta3wCzev4UfG5FiW+Vj6ylRrNMhJj/YkgwT9MyYCCNFHb+onlGv4MmK1LlnXd/5NZcLZWNg
	H5+IGTg6xZycOL2+ljvFZpAInK2bxxfJuoClo6YLPAbdQ6whUgqRSvPcUOu6X5tBBJ97RizuuT+
	MfuUBZWtvqp/KNs6h7z149DNmrGUYsEZ6kA5Uc+mmJMivjbbk6cpl7QsUFbnpqlGOxoNtRvy1pz
	QB9xghLOU46tuRlUyKGctbA0BRsOivmF0lkTo0XoKLGzb2N8XPcHpmrMJtOpgW8RhmkAQua//mm
	H/6cCVpGQ/aV6oVeltvEqXnsKCXhCTDWV6370SmrKg3slKUjg54A7Q3whSeQgImUZUPie0Z0t2d
	vrK+LbN4S8TLzwdQevOGtV4bMLfte56jjtDy8IaSMPFiHtdKyLvJhdALjGGx
X-Received: by 2002:a17:903:17cd:b0:2df:991b:4368 with SMTP id d9443c01a7336-2ea43febd22mr2776525ad.53.1792541335216;
        Tue, 20 Oct 2026 17:08:55 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b40fe7fsm3940245ad.13.2026.10.20.17.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 17:08:54 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:08:53 +0000
Message-Id: <DMA2VC8SJY0S.8O3PIVXWV2J4@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <yonghong.song@linux.dev>, <martin.lau@kernel.org>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 2/3] bpf: Reject unwind_goto and unwind_exit in
 offloaded progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <1cc7789274018beba70932ec8806130f1ff07eed56b62e0afbed41385630e4b7@mail.kernel.org>
References: <20261020231942.2568163-3-alexei.starovoitov@gmail.com> <1cc7789274018beba70932ec8806130f1ff07eed56b62e0afbed41385630e4b7@mail.kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 04:43 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> TL;DR: Code looks correct; only the commit message is questioned: "nobody
> looks at jit_required" holds just with CONFIG_BPF_JIT_ALWAYS_ON=y, otherwise
> offloaded progs were already rejected, so the changelog should name the
> configuration.

It's a nit in the commit log. Not worth a respin.
humans and bots MUST not report nits.
