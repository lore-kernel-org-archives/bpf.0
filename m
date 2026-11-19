Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795090429;
	b=CMDVA2FkwD9zJtwh3wj+GsgZWTP92xCXHDviQPj7tGYqt1WTXFJLC3IFRdMbij+P1FLo
	 bx+HZnjv+li4hgVg0M9rQgWwD4cQl8UtQXhcelHUZq7pU+AjUHLN62fTuskC+5tN4U7yM
	 i5vkoY8OWoZ2qlOM+l9Nj0fijgAoUJ7qb7E8wXYJgainXBkHVWcgbFXRgHwarRg726wG6
	 /jm9o8Va8z6e/3pFwJTst1b7WCtIEhAHAq+E6l5AEXZfBzQtPlY7GEMvNeURT2D9JBPvi
	 V0cdOa/bWxY8M7of5bE96RXLqKQPla3cwszksdtdO0+up3AbBdK3J1TEDl1Ccj6tqEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=JbT2l0hVPosruCtl/bxiI9ZT4pAz+/Pr6yTWwpIv1+Q=;
	b=ipZNQbjtKUeO3BmScoA+kcOXfcdlB/w97KEdpQhmxo1q3SnIcDBAdnre9qP2xYeZCvww
	 s6lhXlzPpS50tZOPIX9xsYmKN4ubhCVh2FIKRLVNETOGFxwq9dr2pFr6J3BTn0h2bAqPW
	 axlTdn/0Jd1D0JXBNmcdxMP5XQIV2MKgc8I2ZtbFCsVw8nWOc2W1thRguX5rcb3RKKJFo
	 agg6V2w9NEm+kdfOXYPGnmSxC1F4+050l2wZNeMSKxt49hYTOQFZa9stXCxPWk37Fj11G
	 NOYEDmz21ZcTLTuxehP5I/xPh9T54543MNbMNrwZO3owoLp0UJqA2jA6Js3+N5U39cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=inLLQQN6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E86606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 12:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8E86606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=inLLQQN6
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b40a522c00so54011a91.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 04:13:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795090428; cv=none;
        d=google.com; s=arc-20260327;
        b=fXZ2nJnNEjLdjO30o9RURV68SI5yXPLhBvE2aJXYJ8+KyjzPl+uLKWKB9I8CVLrtNM
         qmMueW9s7/7b04r7C8ifXP44XSB3yYuz3Zb8nHia/IDov574pV18QBLEn7l47gvNN+gy
         jOp6oruwgLJJ1/Sdu7Qy+3/7XKAUCsmqcVAWYzaCoOYAbfg3p3FkHsuOQhHp6Bxl80bP
         ai/zOsvmSxnzd3KK8RmKdARVk4HB6qZWzQD+Lj5h8dL4GNlqPtxjbJ0NhRBwafGk+yDF
         yhVpFR3gye/zLEBJd8QasssZKP2yHrpFdjzPmjmeX2Pqhcipk3/YLhFyga1WIYk4uLdd
         n5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JbT2l0hVPosruCtl/bxiI9ZT4pAz+/Pr6yTWwpIv1+Q=;
        fh=ku+/Yl6EElTk2k+qyBotu9RkzYJWLUlpSFAar1udNy4=;
        b=Zpa+fbq7EQugcdWZEh6w1nm3U/UhGyH5rzsu8PNQqAkvvIBuLBbsKupRjesCuhT/WS
         HcobSwEn6J+VpR7v9fERV5VX2M6JzkiK/6ffpquNHEptf3rFqF5+//wto7+XqAFSslN7
         6z/RnXTDW5f/fFWPVrsDL9Pmzk/Ia0teAVnN5ZERS11a77fC9ePQEps+Kspew0VhDRMV
         2g8eQ2k/SILMeUGfL+pBiTGz2iMAs6UtEeOFsiA65a95IOu2bm8uHAVjYlGkKyLbX1AP
         4jtRS/9lsxMNkKKerZ+u3N0YlytMS59YQTCovkZx0i+VBlfxwEgnkVcC/3Dh5E9np1Of
         Oijw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795090428; x=1795695228; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JbT2l0hVPosruCtl/bxiI9ZT4pAz+/Pr6yTWwpIv1+Q=;
        b=inLLQQN6+oyuRpEFmArfNCzpH2ozMRZGx89k/DACqwt11IvxS2uk9OtFmBLo4Vhr4J
         V04tDyjCtChQCMDg+Z0yurrLdLqxBvdkqoQ4yirXWIDrydA7i5COBE+0solb87kLt7dQ
         BamkEF9vbM8R8qAwhkfuZZHMK4QC397FjZQQNAjNa0eDoqfTF1Ax7RC8Fp6GjNu4oSx7
         1mc8awM26ZHak6n8f0rMVtyqMPKhGdWnJypjWZJXKS5VQd17VjONQ0CQfcoxeddyjYmf
         boLx2SRKNBMM/GjEMeYOtSlqhrOcgCl4AV4k7HzYNmibRCx9/H+XYfT1eASGaNsK57GH
         BwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090428; x=1795695228;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JbT2l0hVPosruCtl/bxiI9ZT4pAz+/Pr6yTWwpIv1+Q=;
        b=ctsEZ7ZgFtxZK5fs/TZcyuK71EfbOYCdWIyVIs7xh3UnFcorhGIywKY2qsqxj9F7zp
         9edU+FpkRA+1DS6K3zX+pzWAnPHTvGtE+YiMxXb4o/dCKa0DhsOwSffmiTO9y2kI/r91
         AcZxwo6RZzws6p1QiXff32S2OpPVeZJQT3vtUGTHqh5yCuKe0RDPjG1jIfD5g0DJco08
         uYqTiZ6SxtPtRay5MCgmJBdf2XVTAWoUeEM3VLQ7YsJ9UWZvUoW9HkERkJPLKHO3+jYO
         aFqxP8aom08Tf1F3KuZira23xqwYdiKVNggntb3ZDYbJ9t0I0WNHkHwOlc1H072CtRJ4
         1+bg==
X-Gm-Message-State: APuU4Z+WsiDfwZHe42fQ4YH0brfAhEkd4bIYOVS3BtG5UI1ScsrYo4UW
	s/rLQ0M7vHMa0W7EW6mcVXL39pVSHt6qJMsm0tOUrDeAmvrtTiY0bE7rVl/Sf+AgPiUp5Z7ZX7F
	NRbS17nQ1bJ+7cguIoDCAPLzWKil3v9lJUEKJ6gkSbw==
X-Gm-Gg: AZFdTZdonuFvptOJGUHE+X1PggucohqQ36iW0NVzNr6k57EArQEOuS1IV8r78g6Vsbh
	fYGxub1Fk1YIP174yWgndvfNe0VV+/ApLvleG/028XJa6c9A5x5oVLeJMJoQ//Ut/xkzZTkcE7q
	sVN+QJdsC6nFzlagOGhpwTUekpGUXBAlFPeSMK6izvKw+2rczgg1DzNo5lpfeIXOJR/vv/Raklp
	Puke6dwr0uc01IAlwbu63FX9w9YA2VYgwU2ysetB6ic0TM5h1BPmbVh5e8AtslaJHrPHI5zoy0C
	TkmW3VoCtgEk50TGdRZEi7F7hlg+u2o5HD1JQK4mvDQWrdLbpEadsRUocJ7ySsRh9//bi5upwLi
	h773AmkaYzy5Is6Sg7slNelkvsktwth/Scg==
X-Received: by 2002:a17:90b:4a84:b0:3b3:c107:8458 with SMTP id
 98e67ed59e1d1-3b3d07d54b3mr9810306a91.5.1795090428106; Thu, 19 Nov 2026
 04:13:48 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-4-586376ec3672@sentinelone.com> <e3ed9b2d-7778-481b-ba85-2ac3ac5de877@linux.dev>
In-Reply-To: <e3ed9b2d-7778-481b-ba85-2ac3ac5de877@linux.dev>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 19 Nov 2026 14:13:50 +0200
X-Gm-Features: AclHuK-Tue_GiMxMNcBIIEZsjERmHRrqNIXs1mIZQ207vV9T_xJnd-gwW1o_iI4
Message-ID: <CAPnbwjq7TDed+f6dTDfQcdLSZtV=AwDiLVpBK2t7ke6vpngSpw@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v3 4/4] selftests/bpf: Add
 preemption recursion test for tracing programs
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +   return is_jit_enabled();
>
> Any better precedent for checking this?

I found none. Unfortunately user space can't ask the kernel for it.

> > +   { "fentry_s_percpu",    "on_fentry_s",          PERCPU_MAP,     B_DROPPED },
>
> Is it worth covering fexit, fmod_ret?

They enter through the same __bpf_prog_enter_recur() as fentry, but it
is two rows each, so adding them is minor.
