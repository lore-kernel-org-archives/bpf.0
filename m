Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201920;
	b=cAfZXJcGkchlgGKqTgZ/14CO3WRYV6cPwj7+AXVXZUGty6eWTFaTWxkuxIVEBd5XY5Iq
	 cqUYFE+vKUaaPkRrL07UEgjXTQajgTi17bOc9fNQ86MixA4wOKleCsp8IWAK2lTt0jhxw
	 e4z8NEK1oJNgtKwl84ZvuwIsJ682dPrDBT6yOxhTApgETFChh+CGvaBfMJCxkMZz6nt5k
	 ZINIHHuN+D9t1qMkn0rwwrkQYOT2g1/5Is26Ev4RS9VMu/NCEpJXq6FuqwdU5okopvkd8
	 2CeKshE4SL0lZfPgmiyZNpbmqSVk++vWo7O+DigW9jac5sY4bRv+wG1RcICYQXj6fNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=MfI8h61e3YMKVrq2h3izbDkMZ/iPIC2DcSVnmxWaK38=;
	b=DtHmZHJuTP1SzOSHfg/v8mYs9KYaZX2yTwcbMfFGGNAt7Okc0leXcdopSBg8mBx1JxPn
	 gNS96Hl6PXQjcM7C9c4LDjclKAhiriMjapBp94aJ0ReTUyzsK8pkHRpiLza/6y71o98Ke
	 UrIG3vF1d0WNHAFdoUMkLi77ZGpwYrl4lo6MUaHtvDqR2elqbEPBc0deWVVzMZKQLzyW7
	 I0pOqCSXGeEswRcUxUHzdyLz66YjK/BpGD6K3zlNNxxnZjyeXGWNixumd+NXz2RTwTtfo
	 qIheX+k+wTEo4zvPKYieJqP2/zZt/BSfGmMjJ6UVLBvHaCJ464SGRwq8dSDg4hk7iUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AS+HWRzV;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457760A2637
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 19:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5457760A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AS+HWRzV
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b41188c8b9so979840a91.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 11:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201910; x=1795806710; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MfI8h61e3YMKVrq2h3izbDkMZ/iPIC2DcSVnmxWaK38=;
        b=AS+HWRzV8TNC+o6UMnpbMf3MO+03DWGnm9XxWLlLJ5oNbpKebzojf0B/x2y0Lj0g9O
         vVxkrLDZz3SYkCkpS84UMY5Ln+nXfIFNl40EyDrREE5Nbir4Uqfq6y27HxdZvwxjil1A
         FS6UkJYPFtlGWPPNjiZDdtTg9gsbz4zvOAQKUzUG0KBAL1B/VMtfO7qY3pO1I0XRcy60
         7PfptsxDfy2IasrDsyObFTMl9LNTLnVGbcqWQOs+pDWB5ppVylqGxbo6Offesuxm2OM/
         BbJ0gu9GWwkchkCT/I1xaNtSLAd7F2oBcPUF30NJomnpcx0FW2aZDNJIhsbN3sNosX55
         FVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201910; x=1795806710;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfI8h61e3YMKVrq2h3izbDkMZ/iPIC2DcSVnmxWaK38=;
        b=mVx9kexMuBoz5R54TVuZLT0YDC6gjIoDup1oRjxO4t2GhFKHDoxsZPSrgifSLOFiwM
         Gs7iEDUuYUJQSzZ9qxuMAYpO46JxJJodQM3ttMCDKawe4XPucIxaDQmJ141DHY81NKg/
         o0JaiKdoYAFmOeHPDF6l7FIznEDpFd614i1JAvJN4WfNzRmmA8CiydJSoFqZgr2M7iWw
         krvMewUIaAi2jY+fUbV6VrWYRUfJL8gUmL4bMkqiio6UWPQls6K1K4Jg3QcXuRjXlIFH
         x8GoBbCziJDr/UNpuXEEEmDOjXwg3rt+hr9Uk3FM0iMvoM7LSoLD1vPgyjMwn5TLyPrk
         LXmA==
X-Forwarded-Encrypted: i=1; AL+hErGp7bSuW1DmACWaoy2RlP1L3bHIZtKCfMx7WkXtTh790cnx//WQ6UYxkvEjL+4t9lgky1Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NifWkcwIghIzJqqPTnGD9Cd4+7wrXddVtwlHMS5oX/WDkYXts
	lD1KLg92YjS0KSjLdXtgrzeYgQzoS5MyD5l4UdgI5krI5CbpJDsNI2up
X-Gm-Gg: AZFdTZddlJOotw+5n9PEsERHD7yCXUWdzYWcIy3Qj7tuyXDCBJCqxvunLIesJRzMBrt
	PZ2NHTuHtrFZTr0t7dTMC/IYGUevbiGb/ai8ML84Cg8UavR07mkD1Urc18DhEP5vb8Y4uPbt2pz
	H5w8KatRTgIUC8vCnKv+eyitUB+xMcH8EaiEBiXB8wb7CZkq4EMNoDhcocITQOwCzfSZDe9HgUs
	9jebxNOVBXuSBhGmreBdtQlccyWJq+DjbSxHyG9vFbRjJ3DO1Re7ceCT7+yHTZKU9iN/q0yw/oS
	P6L8jKxsF4kfjrbgCXijWUr6/tNimrTsUtErg6x3NO1qF3yITlAQfbdJXOa4u5h2ol1JIcZedx4
	ND/u4l+BNWa5vCLoAEAUhLnKfgq3p9dkbeAyXb3ljGFa1KZaFH47GP7dVUDO+ww8nrv1MqcoE3p
	O2yHn+hJRGZ3d697xpFzGJR0iTvPWS9nIgQVNjIW5aOEo/v65qTehbUwUmolbZ51PW09m0StQHG
	4w/ORs4TCCxJQrecFB9hvW+5G+rNf7E7ugIN4uRe9xT46a8e/F4xfx4cPCVVV/cljtnj18zlkbL
	DlWI1CI2nkPW5pqRyn8ZqZ1PSnqcbyULhp+Derp3HDTgcFzijm1z6i/o8YhGkiQN6S6KyNNt8v2
	qzVpebPAk+WAI9I6nZ7bpwynIFFGzrkJdeg==
X-Received: by 2002:a17:90b:39a7:b0:3ab:a3ee:33ad with SMTP id 98e67ed59e1d1-3b41c8d95f0mr3666281a91.22.1795201909486;
        Fri, 20 Nov 2026 11:11:49 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm8522514a91.10.2026.11.20.11.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:11:49 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 19:11:48 +0000
Message-Id: <DN09YRKU82D1.1QHV2CIFW2C6H@gmail.com>
Cc: "Steffen Klassert" <steffen.klassert@secunet.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>,
 "Simon Horman" <horms@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Eyal Birger" <eyal.birger@gmail.com>,
 <ipsec@lists.linux.dev>, <bpf@vger.kernel.org>, <stable@vger.kernel.org>,
 "Jiri Pirko" <jiri@resnulli.us>, "Victor Nogueira" <victor@mojatatu.com>
Subject: Re: [PATCH net] net: xfrm: interface: restore dst_orig on every
 xfrm interface
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jamal Hadi Salim" <jhs@mojatatu.com>, <netdev@vger.kernel.org>
In-Reply-To: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
References: <CORE-5IQX.v1.r0.20261120050801-1@mojatatu.com>
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

On Fri, Nov 20, 2026 at 06:08 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> with skb_dst_drop() before the route is installed. The helper allocates a
> metadata dst per skb instead of a per-cpu one, so the route it records
> belongs to that skb and is released with it; the per-cpu allocation is no
> longer used and goes away.

kmalloc per packet should be ok here. xfrm_bundle_create() allocates a dst
per packet already.
It also fixes the route leak, the double put and the if_id mixup
that Hanxiang reported on Oct 29.

Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/48129353.1960c.1a1859496bc.Coremail.xuhx@hust.edu.cn/
Acked-by: Alexei Starovoitov <ast@kernel.org>
