Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212867;
	b=IZaZrhXHXZD+FblBKdjw+/X/dzISRzo7rC6Ohlwjzq9iN8HjualBxW53eGTf71xm7KG8
	 KZ3Irdzkxj4d/WGToqATB6KvE5TN/dY4tlDBDjT46LAKfEz5zdYl6x0JC0DiRjmLtoZRD
	 Chli+j8kf0O1K8MtGPsiEF2doz7d3bvbic1Ul0A50sOEfG95xal0ueAyn2qjem7cTdnRa
	 XGjCfdZVg7hwBycWXs+RqWG0yGwqL4bXZQ612JXz/fqry/bFq0Ck7Y234o+5VrPhNYIsa
	 cpt7YAVmuuAwNB8ZtiizxuVtb73TXRnIoPDEKUzo+rhPZbvxI8jmKvW7NN6wfXpTjAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=CtcI4A9AUaZ9QE5chm2vJYBlWzSI/cMSN3q2vOlZeo4=;
	b=Pr4P/l6FgwlqVv4uIef/xoHavZh+9LPYAcAEtQ7oU3S2SPo8P2T7CzfiyCZNLRsQkD1z
	 KvHcYvgA1d6TRH8mv7eSWDyvjluCMJUe6pQPmi52mD7MI5HEOmYSeRZMuhQXTqkxoQtIz
	 S5oOWy5+Sw3R+12Hao0WwWGD1N5oNE1KNUl9osS9axtP7JcRP5v/PVBt9719s88J4M2ud
	 uzmc1Gt1TqJ4W+33avDfNvXTp7IV01krpMPbQnnnFXor5sHGLgDk7gQsADY0hwmO2u2DF
	 dkY5ICjcb7NXdFNo1YxT/YpdomjCsITmMNCI21V5ErA2MNpm4zwolfLSKkU0buJdsng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huz7HcSL;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D1606A31E
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 18:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA4D1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=huz7HcSL
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so811247a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793212866; x=1793817666; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtcI4A9AUaZ9QE5chm2vJYBlWzSI/cMSN3q2vOlZeo4=;
        b=huz7HcSLqwNY2lvBvJ6ZXRgjOt+juXzXXlA814WLx4K5PYvEXMgyW3PEcVh9evhMyQ
         vdViOSWnzxS3Oej+wWbV5AMFgS0om7CFhxI7GubLGNCpW6oUpyxil5L9kTWnnTHsHQWC
         kLRe5670HTGnNB/TvCK3CHJOA+nARgvTSJelrf4QeV/xDtdQM30xTmCarfxAz++2xymW
         JN/gjGRgOnmMeNuMsu+CZ3XLTAy+7J0iU4zZnTKMonTUDfWiUIz/YX6gCe2zU0WyRzKk
         hPJwLer9bdwDEp3QFIBA3l/ItrpFehcLyQ2HxlpogJGF9phdVXEAdjabmBdvW+HfV6CG
         SkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793212866; x=1793817666;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtcI4A9AUaZ9QE5chm2vJYBlWzSI/cMSN3q2vOlZeo4=;
        b=bpHr3ep3XZdwrOrMBV0plZjPrhaJq/L+tKbeDsj6PRo6aMheB97dQYBVEYUH5m9cRJ
         ReYsTNcp5qf2MdvC+ioWOl8T5PtHUbtsar27+TQQqxa+n2d2lFXwFMx9jBB2O8zm/J+X
         xqV6f0GY0jv/aqnRpDTfLbHYekoXLB6XhgZ98KRjD9VqrjQUuvQfHDcx2FdGcdgAoY0v
         P700C12+mU6VSbjFAWTxn6HeotRNgsKGojR2aVGY8e14zN7ygnjdT3Tf1flzQQ7Uh711
         +V97Zlu0o84hPD0p6RUu6NlhBbUurcAubQv2b4TaLwC53Qy44/njEzPzQ3SVAWjxjOZe
         h80A==
X-Forwarded-Encrypted: i=1; AKwUvByugg+QsNdAebIslltWeHoPmxDH1ACUjGpA3OU0ysh3GhdAfllIxb7srgSLgEpceGUhc3c=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2r0HHzoQ3LY+eclEe72TmcGblJIeWjUzLKk9N4D2K42faHUDC
	Dq94Nkg2/PvRqT80x3xSZ/Xa8+auptZLlQxfKsGK8vI74qzrHc3zqlvc
X-Gm-Gg: AYBFou2sh0FR5oGvyRJTyZH+rJ08AgWoVa7mfWNJS+D2k2Cd3uKpcSrtMyoWwGf8Xv3
	seaaYZ0pBRJKulVr9Ais8Ak8FMoRx1kToZIhwYB/28MhQ+KJxjL4n5DCD9rvRhriCD1AQtgo12m
	xpPB/rUCAN1XcyzXrIfADZHi9gHe2tZRCVAXAmzGHdkVAY44oLf5EHtK1OOeN/lfM5VAj0WYIL6
	z0XKeiNAmDMnl4/lOaSnnmfaE72yzMIyF3SXh6jzNT9YLdJKvcj999xgLCusyUrmuO4udt/mLdz
	m+KzBUpvDJNHU2Fe0jpYxFUs5GpgkynfsfKgQeCCmYbmS1O+6GRql5sAxH9E0TpXzQe1mYTyzVI
	UFPXv/REkjY/Zenm6CpZcgHuRf5W/rW0wa58JYqYPKMvXu6O+6vWUY6HwXwS17cqPj7+/6IZfko
	U+Co3N5RRELz3x521u6fQMGxoEOjWG+SBqejVvvmWTA8tLIpMDCIV/S6beJbntW3oKqMEjL9Tpq
	hWUnU78jdJfHF4oyJvYVNuoR544hhfbil02owuEUITntW0JBeMRwWlJLJjbrVi5WbFUudcAzckn
	lC2CUBVEpO862qKSWK9YY7CHxnWlS3m249zrkoTQB18gvpQmVomxHaRnb3Rsfwg325VMYmpIZMF
	YP/bis1HWBXnlQ102u95+IEihAM1UfXnzVA==
X-Received: by 2002:a17:90a:c883:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3ae6ed5ed78mr177339a91.28.1793212866098;
        Wed, 28 Oct 2026 11:41:06 -0700 (PDT)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm582040a91.15.2026.10.28.11.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 11:41:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 18:41:05 +0000
Message-Id: <DMGOWPMN84X8.XMJMHFQ87RVI@gmail.com>
To: "Daniel Borkmann" <daniel@iogearbox.net>, <puranjay@kernel.org>
Cc: <memxor@gmail.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 19/21] bpf, arm64: Split 24-bit immediates of
 add, sub and equality compares
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261027182445.1156335-20-daniel@iogearbox.net>
References: <20261027182445.1156335-1-daniel@iogearbox.net> <20261027182445.1156335-20-daniel@iogearbox.net>
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

On Tue, Oct 27, 2026 at 11:24 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> An add, sub or compare with an immediate that neither the plain nor the
> shifted 12-bit field takes moved the immediate into a register first,
> two moves for most immediates up to 24 bits and then the add. Take two
> adds or subs instead, of the upper 12 bits shifted and of the lower 12:
> an instruction fewer, at a cycle more on the path of the operand, as the
> two depend on each other where the moves did not, so an immediate that a
> single move produces keeps the move. A compare for equality takes the
> upper 12 bits off into a scratch register and compares against the lower
> 12, as the subtraction keeps equality.

[...]

>  arch/arm64/net/bpf_jit_comp.c | 113 ++++++++++++++++++++++------------
>  1 file changed, 74 insertions(+), 39 deletions(-)

hmm Can we drop this patch?
It saves 4 bytes and adds a cycle of latency?
Doesn't seem worth it.
