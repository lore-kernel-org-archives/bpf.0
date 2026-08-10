Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396FD340403
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390426; cv=none; b=EN3UMW/A3JH4XJYf+vEhbjiO0ds2wpKLf+8b5ODNze7mvI1VEoY7dMGK649W329BNqq41B5b8Nk4by/ZD8F8xuepKkvYI1LGYRkNj4elwVFhMVQdj1Zy8PFEmTuWtiz+xa3nANpygPxEszNgaR0Ykq7GSamH6UqIF36NfCs/RVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390426; c=relaxed/simple;
	bh=NcE21inJC1eLEwtxN+vVJZdzKFgng0QGoxsFyu5O1Dg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=deIHF06gh+QQ+6i9r88jln6BZQICkMvgWL9UZP5au5HVauERoWsKOtoiTqAJqo2Cut8xWFLC1Plr+uxK6QbKknSPFj/ysfSITtGYQA1TOIeDGNjkNLx9X+e+9gtBnV8TP4Xpvrd4BR8EbmsuvaGicOtN7hdk4ysKntD7J9jzqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPvALMmF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPvALMmF"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38f620399a0so70147a91.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390424; x=1786995224; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NcE21inJC1eLEwtxN+vVJZdzKFgng0QGoxsFyu5O1Dg=;
        b=JPvALMmF3rH4khoI6AfqnzJmuG6rzgnB7uCqba0iiG85SLWId+z52SsEHolP5qQbr+
         Qbqn0mLmdcn+W3m5tSoPVyNba2035E/Kz/3FmGjwy70WZBfpXuStsOWOizbGNzpmcS1/
         wXtkDlsZbxnRt1C2ivUNft3FzIZNyPkoRpvHMLADOKKwj8U1jLSXyM8oHFkJT4cs1ONm
         YGXPjSSvoWuBNnJQj00fNspMwS53AQShiB2pxgkIWLLiB+A1K41Dk+3D9IhsViZ3CAS/
         wFJYO+hYFivaboY4ZFbmJE35PC0jxToXcMus4fV8rYCgXHxMXYbQ/QYG/eTO8xIYs95p
         kl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390424; x=1786995224;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NcE21inJC1eLEwtxN+vVJZdzKFgng0QGoxsFyu5O1Dg=;
        b=CmyQd+PE61jTl3spGqHA7CDjrZoKXTyLMnzkRjOrlSpgkS1KYrr2lbopSUYSTqKjnX
         e6obdp3CXJur7iSeWqL9mm3iVfphV+A3URLfnj+X71KOnzL14QRIapfHXNaAzDrTO25o
         1t5cdSeqv1iPrnw2NgNHSwzkTsrIv3hMEaMyPn8jZDcd0l/mZZrrK8zgUyxGdG1mRDCW
         gYO1qrE5FvDzxRMpF2mXaGcCKd0bvU/4WD5mNCIJvQvAdmm5P+hzZe+qkr6E55i9lPWg
         IS+zB8VO2NfpkqnQGdoG0CxXqrz+CIGwnL7diOtxZT33CksK0nsn4jhfyeIfDMBdzVYM
         jQxQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzeS7hRI/C8ogqVSFxWsbM9rRsVYikmvzHsrs1NXRWbodCtYWqvmmm7Ods/AO07fu5jMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBPrr6S6OBYZUP6b16R7b3PO5bWl9wYlZkbK7w3WPCE09lnZH
	RLs18x3AbyR1+pgxt8tOocXnD4rtX77axU+rCnHD2teZHAkXJbk/yLPY
X-Gm-Gg: AR+sD13wg/pe3NHBUv1F8F6jjFmaMknE7hCkElU0qraOYPf9vLzaRIEb16L+Sdu2pKR
	LRhAoEYXg8c9yjz1Yfz7/0og/fslgCjqLofEoD+1yEJ/MDjcSyTBOq2Rp5LcYfM/dyRVl34xxxH
	110amLSDwOmtYwwmvqLz2alBp4uJi89PgQtNtoOQxFzsgy/FgJLks9n8ntwZQIcDplaTl5pAuFs
	xFvDsAY7vKZmzWxmYC67R2ifBglCJ+5Y0qBtlxUzVtE7/JpZCjQoeQkEXC32ulnhsToEqCdzCAZ
	f2VPhB5iwUdkChHG5MkuRufrImWjhYScB7+LT6RNDom7rncbTF34C49TTaKah++oWi0YEXseh1q
	pl2EwDu+WXS6FxTt/yPAhGRsterA/16cAr/vTmRm7z6XiYcY7ysPhPmhvFdivW7OrQi0r82SZg0
	nXIy0ZxEEUWpmyk8Ed1obByOsiNM6ZQeWQht4U/R2AyDgKVr4L4L68KbT2IKaRxCCBdb5iRs+3s
	w2Wvzcd4eqyIrtQ
X-Received: by 2002:a17:90b:2590:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3903c572a05mr47972136a91.9.1786390424573;
        Mon, 10 Aug 2026 12:33:44 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d53b873asm725701a91.17.2026.08.10.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:33:44 -0700 (PDT)
Message-ID: <5b9c87a351b0a77e1eb36a7ef63abaf3bd172451.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Account for preempt and IRQ state in
 RCU protection
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ning Ding <dingning04@gmail.com>, bpf@vger.kernel.org
Cc: memxor@gmail.com, puranjay@kernel.org, paulmck@kernel.org, Alexei
 Starovoitov	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend	 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org
Date: Mon, 10 Aug 2026 12:33:41 -0700
In-Reply-To: <a3c4305c694a07aa020f4b0f0e4fe7f58672b5cd.camel@gmail.com>
References: <20260805233940.3966981-1-dingning04@gmail.com>
		 <20260805233940.3966981-2-dingning04@gmail.com>
	 <a3c4305c694a07aa020f4b0f0e4fe7f58672b5cd.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 12:30 -0700, Eduard Zingerman wrote:
> On Wed, 2026-08-05 at 16:39 -0700, Ning Ding wrote:
> > Disabling preemption or local IRQs keeps the current CPU in an RCU
> > read-side critical section, but in_rcu_cs() does not account for either
> > state. The verifier therefore rejects safe kptr accesses and invalidate=
s
> > pointers when another RCU source ends.
> >=20
> > Include preemption-disabled and IRQ-disabled state in in_rcu_cs().
> > Invalidate RCU-protected pointers on RCU unlock, preempt enable, or IRQ
> > restore only after the final protection ends.
> >=20
> > Signed-off-by: Ning Ding <dingning04@gmail.com>
> > ---
>=20
> Hi Ning,
>=20
> Thank you for identifying and fixing this issue!
>=20
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> ...

Please disregard the above email, it was meant for the
"bpf: Compare iterator types during state pruning" series.
