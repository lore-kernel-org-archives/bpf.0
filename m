Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41947140C
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924014; cv=none; b=JETsAybN1Q6NunPKkqrfkrDCU15U3feaw0LS4y6Y0+UinLzmwCwv6ugP3CmMD52l8eMKiewfyQHmgCNxO64QEw0CnsXg9MWYcfae0SN8TGaKdepHnVr0luXrxvxmV4KB685ZmKdVDT4O8RdA8chWr0uOFsgfsw/W0mi9GHwyQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924014; c=relaxed/simple;
	bh=qMIrOtqwDGQK7tR1Bzev9TaGmRY6zy0a+hjBj/b95ak=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=li8wR90Y5CNXcFr2fA6HTv0/u7CzE9fDGNZS5XLUgFlPo+rOnv6AsxSaMlfo4tiTzXGM0DWTRiQCUV1ZziTSVcsqvIvh1vusdzRwD0fjxr4QzuZw3tA/2ZHdHLfQjhRD4bQIFuz+B8BqtS0Uk1m6XzNA6bdIEY37Cr3KcehPJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2WvOcgR; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2WvOcgR"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so2587961a12.2
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789924012; x=1790528812; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yz1+tTRLmkyE0kaHQfyasd/tZYeHVlGzAW89MX5E2p8=;
        b=d2WvOcgRipppSk6g1D6k54nvA7uurpMduo8lqT1kInmFMvDftVTr9ergIqywGHImEJ
         d0CwIw9Pkfsqd603LqR0do4zbQAQFcxCVjUdTDGZ37ny2STI9rLDVjS+A1aTGqi29mT1
         eAaV8ELXNiZ1d+ofFLDxV/QS7/g4958cJhNC+NomHLCOKNtK4TuMkbSOJUg4z6b91Mc9
         vNqttL1inu9W369GYWCSHCP0RCf6LQafwh4ZJqYp4QsMiaE7yYhD1guNUakAb2WDaiYr
         Zc1qo1+UCmjLggx3zbRUhu2hprQnnqGsd7RYcMErBoMOn5O+ZBASvqi9wFK1SSwarjpR
         xz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789924012; x=1790528812;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yz1+tTRLmkyE0kaHQfyasd/tZYeHVlGzAW89MX5E2p8=;
        b=2krJ5lpQUPca3u+0EXq+CaIukzGIFuA5h3eHH4owYRMCUJzbQNBe2t0oYA17hFR9vb
         P/P1Qe1MRPoAsMPUTLCMzzUOqpLO1FVXqZYMD1Mrm/ddW2IsUB8vLMl3FhUpLq/BNXq4
         8YEBtd/37yN4HBS4KVUSujI7479TOR+Sr+gv9nDpgLcR2VRnQwE5DJBRboGf9Pn4+5NC
         WHQKPeo1iotemXWYe5IWQoUMmD4XRDLDiqkF1q2Bb0n+/4kUF6AAAgS2SmYGM1QyMsiq
         wiflxmWw23EpR2yHU6tm7qXIE/UgmvijPkRhOK1qp7ckMdLhbUp6jNUtJMWyW7mxHs2K
         1jtA==
X-Forwarded-Encrypted: i=1; AKwUvByAbi2m3Yf3QX5OqjpPuemWCrfp1Vzvlg3R2ClqU4++LYGJlhSaRryrq+Ltmov0/555A8s=@vger.kernel.org
X-Gm-Message-State: AFuF++kFC7ch14rzTSgg4S1g14YT0Da5nq7rrmSzZ3FPCzgw2t2qaQ/P
	xtVNRAZMhvcXFtAZPyesFJI9/FSuUtNWfHEvCoJYr+g38yOVjmCfCW4V
X-Gm-Gg: AYBFou0wMReZun9ZD9o8ab5ihIwE2WYVVGpb8K/VU7R0NzKs2y0QwCKZMNIfsguAz6C
	o10XXGeZkx48jIpGroT9vfoziwG83a2AWTIYDw8cV12opu9MUh0TdKPhoVXxCy7N4w/qBiBrGpg
	Ix+AVc880ri9dd243Jd+fVjnWXVuuMF8+gQJ6u7UsTsGDuq+EGiNAwBLGNiefAxGMrDNTiYMNA4
	gH+QZn0pKmiTiR9oLvA5P1SpvQoytqdP1pdNRtOQD3q8DrQd9MlnOxSNvUkCUnDTCKetxM/OZa2
	jwbnGJLF6LBfK/pDbAN39T6cgXOQHMB7mxUYB+e6Xw0t8yNuZyoguB9ToxQPUcDTGTEpj6Yky1f
	50BGWrW9S9tXOeKQQIEl2d9ZiO8H84B5b39Yr1k7CFlDGx2+SJYjvcsdGVKY8KfFfQxjZwPvfhB
	w8FtyRXTriyCJ0lxfjtwzyG3KwmiA8gH1N3NDQm2sXPP/gIcmBi+aAmSeBUp4MfuXEnhcyUn1KB
	KBVqrNfbtI6+KS4Ci7h2ziY3JwfGcbdMFA//j/2VeC0feBa2f/lNFwxwhCvbJ2RX8+Fgtm86uju
	iFz6
X-Received: by 2002:a17:90b:58c5:b0:39e:6c69:9b97 with SMTP id 98e67ed59e1d1-39e6c69b286mr7319728a91.60.1789924012326;
        Sun, 20 Sep 2026 10:06:52 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c37c64csm9614016a91.10.2026.09.20.10.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 10:06:51 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 17:06:50 +0000
Message-Id: <DLKB3UXOH0IS.1UL8NV9HSJFXG@gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/bpf: cover stale CB after LWT IP
 encapsulation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Peter
 Oskolkov" <posk@google.com>, "Xiang Mei" <xmei5@asu.edu>
In-Reply-To: <20260920163211.795547-4-bestswngs@gmail.com>
References: <20260920163211.795547-1-bestswngs@gmail.com> <20260920163211.795547-4-bestswngs@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 12:32 AM Weiming Shi <bestswngs@gmail.com> wrote:
>  .../selftests/bpf/prog_tests/lwt_ip_encap.c   | 288 ++++++++++++++++++
>  .../bpf/progs/lwt_ip_encap_stale_cb.c         | 100 ++++++
>  .../progs/lwt_ip_encap_stale_cb_freplace.c    |  32 ++
>  3 files changed, 420 insertions(+)

This doesn't apply to bpf-next.

And 420 lines of selftest for a 40 line fix ?
That's an overkill.
