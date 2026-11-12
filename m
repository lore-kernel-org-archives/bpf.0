Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513549;
	b=p0brEdy0zU5WwUIbV0ScLKNhVeQVc72MTgmd7Z8acqYnb/rW34+v00jocH24c6zYTLOD
	 UibqoqPD4nAb+BjjR8JCMW+8pN+WMS+CwtP23DRFY0S7LDrpKvcr220fiLDBhkfLUqpi7
	 Azgulb7vEqngCvBewuk5hYjIfk8vpBfp4MbbCkoleVyl8hSsp0ChW7Q5QemH0YNWMFoJb
	 ZHx2lKpFklAHaBi8xgrAbebShgrPveakiCozgZpQ9pY0TNHQuqVGCRKS4TM8WPTJrl644
	 uwaKAErlPFA3KdKfTC2m9toeIinA4XMgYUzolNWXjDiAOpOMvmYVEoU9BnktTlez1aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=T/wWb7fRaZUGBhzDhHV/eUFOWgluySiOaHkvWzqe8FM=;
	b=yh5VDD8ks/lOGyT1K8WPHsCfMoNTI+pue/wITEl6ZWVkMcxr2pq78BLNCwtBaYEpPfeV
	 fTwPO1EmDdUuOLgVUPIouA1gvyrE8D2bC5e4g6syB0t10ycxcvlnvcj7eCHVPozTyesl2
	 8NfKSz6mYve3TNo83Wqi9cUjCWvu3HsXK3mFqdLaPeL2aMoWe+oOYRccRVlCWjNv+6SUR
	 yp64AQnWGb4oaubq5prn+1midTuIILhiwsfu83WQxSUjX3pnZN1o2/RdXHiRG9Txa29qX
	 0Iu7nPBTJCJie7TYOoHd3WA2ZHXK2uZGZL7osQsrG7snl6mGMbLEWn0vd5UGQPFKbPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nZ99iNli;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF0F606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 19:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF0F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nZ99iNli
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso176845a91.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513548; x=1795118348; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T/wWb7fRaZUGBhzDhHV/eUFOWgluySiOaHkvWzqe8FM=;
        b=nZ99iNli759lMAvhBbAMaHI4hL3nQwqz1Nsq0QOZXT8qpzrscDd3JSrlc3xG0/w1ss
         Nm/+eLkmQRT1o7ffssVqdFEfKY1Tg0f9G6j1GiHyJikbuFchJSqkXb4hrb/POXYl44Xq
         YBKDZRwUjSdmcl87FPpc9Nguo+mzOXATLf0hIs1F3C18yIWDSQldm7zk3Caxcl7TSoxS
         RrFf0GyszcFOdlOVRqel4dF/0Sa3LoQMY2vRsXDoHxHkX59n7ZJLg4VHdVctijhiV6he
         KAY6C72+00GzPDhM5Tk2cHQ8TnLprNZ7kmUEqGJ7NRYrRdqhaFRESOQdzlX97UQqOf6g
         lipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513548; x=1795118348;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/wWb7fRaZUGBhzDhHV/eUFOWgluySiOaHkvWzqe8FM=;
        b=KjIFRAmXBzDUFGid5KSa9b3V+QBSS+Ss+Xjl1e4OqgtzirpBu4GWKkgTYz/fX4tE53
         ssDBV46hRr+zpiS8prZcmMCgQRWLiZfSf+kEzMlCoBb/7VcmGixG8AtxpYaaJ47COzrx
         O85BZ/Zw5VT7mBC8ereVjC42rRTdAIwEtHc8u1OF2icCr3zsqd7yyXSrP6boetXvZV7B
         MOxT63APpOTPE/gO05V0ePRbCNUA/AkmL0GnPbgVSQ7NdX3sNqt3pMy2iNPvpjOQA0qq
         z2qrtkVouCXxbntrrIjXAowibTV2sl0Uw1a70JAY9dLGlJQNQLA/Wg3YDWyEqFuUsLqd
         M9eQ==
X-Forwarded-Encrypted: i=1; AL+hErFS1OxLphaa9ZiBLkP8MgsKRKP6gx34QlaX3WeSFBNOIjBnRsSeYt3ozFxvKEEzdyMcenk=@vger.kernel.org
X-Gm-Message-State: APuU4Z862ZjGLxHWnRebAFP0XF9nC7dCfAErzZKFw+2Jjn2pqSYvFiTO
	YGEKl15/TgklqhlxMoT/NRCswGHSKVixAG0u/vrfVpcHDJUUXBUd0Nzk
X-Gm-Gg: AYBFou06NS94LFKuyruQ5ch4EJXFhSy7GJma2FDZArngy71wqH42bzP3ukDLCdxCTKA
	el0k8hmvfaDKtVAJQ0LY0TERZv1AOwJcgEDpAy5bsUok+/PGhO9iZDJfOCZaTZKXty08EybxAdD
	6CdX9KuBRJg1Y/tPOIRpgjc4S8DpUlQwT9wiGpE3kTS+tphdAMCskex1jAeekZZTxZ+l/O5C7hC
	+MFGy5MwE2Q+tmEZGAbytAjEeD+OCo3VmgYanwQ1cfAYkH6o4B6xNBukis8Xk6XDvuO5bTh8niS
	mWKq2mBouWXQqv5rznnExHrzIQlTRRI8tJVCMMRCM5/2X5da5GuvoX0GPEAL39jFduatqSklvnt
	oTL6BECKSD8AaIF+BgM+Y/tEmGzbvl15vjVAAnql8dGWPQgqFUpIgRcAiaiun3nyC3MxG5+aIwD
	TiWOFzZxZEP8J5csOjxhhHwMo3Y1D/FWcLGAWRusrs/FL1RiAltQAG9uTTJr8zgLZVSo2pbk/G0
	4tWis//Cl3Pb2rKFPQ67dY1ktLb6y1QcwmqaU3KgoxdYvkbIHTRGRIYnwO6Hzr/vU1at3BcibDA
	3qEOw89wHgWW0itoXMs0OKI0W8g4Gl7OqnOKj5gpgHsCxLIGj90JDs6HlSxiio598M1t0urNzM5
	IM5ORpRE9XmDkg734RdTlAwg7ylYqKOZbbQ==
X-Received: by 2002:a17:90b:280c:b0:3b0:a9de:9886 with SMTP id 98e67ed59e1d1-3b1b0b669camr123766a91.12.1794513547754;
        Thu, 12 Nov 2026 11:59:07 -0800 (PST)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec3a903sm838062a91.8.2026.11.12.11.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:59:07 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 19:59:06 +0000
Message-Id: <DMTHYMNVPCR4.1GZZE98IRO363@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Fix soft lockup in fd_array_map_free()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Li Jinyue" <jinyue.li@linux.alibaba.com>, <bpf@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <20261112122015.3356106-1-jinyue.li@linux.alibaba.com>
In-Reply-To: <20261112122015.3356106-1-jinyue.li@linux.alibaba.com>

On Thu Nov 12, 2026 at 12:20 PM UTC, Li Jinyue wrote:
> fd_array_map_free() walks all map entries to assert that the map is
> empty before its memory is freed. max_entries is not bounded, and the
> free runs from the bpf_map_free_deferred work item, so with a large
> max_entries the scan occupies the CPU for a long time without a
> scheduling point:
>
>   watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/u8:5:8894]
>   Workqueue: events_unbound bpf_map_free_deferred
>    epc : fd_array_map_free+0x7c/0xea

I don't think you root caused it correctly.

pw-bot: cr


