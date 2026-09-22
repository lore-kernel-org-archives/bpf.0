Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F33F58D7
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052487; cv=none; b=tb39b4iJqvnZTbWibI/UDyWemaTgxzKmDtATUnI188J1MDClXGTytrLcIRMPWpxppBB33sQuigha/OpJBT7KsmFGbE/zDetHJj21+LZMAdBrgdjs2nauEHPjUaIPfc9IC2v5fw7MAQSGCotWmtKRio4FRNKLkySBnftmwy4bY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052487; c=relaxed/simple;
	bh=DRso7SbL8e4As3H+pvVXw6BzQtWRETrRQMqxN1VYZOQ=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=OuNyqP1/z1GqIsnLRkbDeFRk3oUTT9Sevb5tPg1l1g9ozpXDuCTbrPCRXdOBKPIPM1ar4cXuAXwlLofWOcw9CmUkxJ1Ow/ClxI6I4Rdptf3lMP6iI47e78C1e9fhhUCqyUKJRzdeaqeoxeRFwBj7ocX2AgwOd0iCvC07Ukx0Gbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPhu+Tcd; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPhu+Tcd"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so4123150a12.3
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790052483; x=1790657283; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9yu04hZXDiXWGAL1P3A8arsPpXEh1RVC3U31vsrwLYk=;
        b=RPhu+TcdaWpiRoXAg6/wRviuBTZ7KWfATLI5nL/A5BHcoOP6fNRNoTftIWHRjgYHlu
         muQbLOadTfZODfG2fGvSkWe5oYq7y2PcRZIbbstDYc3FKwlQI3/1wWHrmPWyC95yRO8U
         NaOfGPpnqy09lvYFF8ujCE5BBY5eK7EQE4wiewyKoiWavZQ6/Gv/bP5KDMw/90j1m1e0
         K4VLg5GSC0L1FyEzCdiqjH1BIuNMmm7qNo9/Ev+7T1WFev5XCHYiWLl+0N39C/9rWHpQ
         HoyJb6N/Dz9WsHDrTd5+8POP5xKhb9OKNPdof0eqUDkCbuUa6/vB4E4ycoMAILDEzm2l
         uniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790052483; x=1790657283;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9yu04hZXDiXWGAL1P3A8arsPpXEh1RVC3U31vsrwLYk=;
        b=esr3EKIB69QX2x0sD1jKC1EZf4h8qmFxXOc+T9jrCvULiBDl0lEOq4qxXhF3Tr2GxZ
         PlFqillSAkzXC53sYS45T4d7AMwa2GbGx6aq7XsaVRUFE0rvv+n1WLACLmtxDRDkqNf9
         hUUEctxiMhN80n5LTPsiBs6fwB70Ni7ne2dN4xJLyeWCqijxNmFjxGVlTxnn2hXChese
         xxRkcmDxUju8GSTt+gUXhls0XeT/kQa7KY3/p2Zy6r7oFVDbzG8p+dtQshAdOrzQbOR/
         mJgCy+OdnMX5g7P1BUhuUx2dETX+AdAlbPRSyLtqvYsfCkpXLrOhalMTrNAhAk7EU4qJ
         lqbA==
X-Forwarded-Encrypted: i=1; AKwUvBw6HWmQSqK0bC0DPoNgqJIZG8ZEIjZmGyN6ep6QZAU8+CCudc0/e4NqkitW40WKZ2CteE4=@vger.kernel.org
X-Gm-Message-State: AFuF++nahJaw9sP2Bd96D8o2zLg5BVGeZ4OIkoNcr18ID2OyTNiIbmhQ
	Uj3bhzLK+XI0K2VR3/OAjjIF5QHdCVJ6MgSCqFENwZ4yj89tMVHf23qG
X-Gm-Gg: AYBFou1K/ns7HHQrZo6CzL8iqRLCnII5Q4IxK1aQ7LgMzn4hPGF52s3sfpMER+5oh51
	tBX0eXH/E7DsyoLIIEm/zvwCglvPbZYLrC8pxwQxbNo7kv8Ag60X7VrDr2TAtkAf7JrEQeCDOWp
	e6loeQBBCnZMe6vxwtmDCHp2Q05KOuB4c7OsycsKX04YO+mouNjypFErnjmeizuKU0hm2dY/0Ru
	6o9bmIKb7338l9rKFyzJuZpnluWaDhDHWwEzd/Ot/ntDW3L1ZUhYuM0wwen1NRr6wGIFiArSSNt
	LCMBL9XtOUTkF6pV+gwSCBbiG6bGShx697sRUmmhyN7PgCp6uxDNoNIxZgGfBJY2X/FnR84oehP
	0IgfZgziN5B2uP0cJ7csF9QX+ut66Z27erlYq55D2eRsdQAa+zQB4ffaxslIpdsnBpEcgY+nOPX
	hp8Ek6Cd3nwOsAbfg57GvTe9mK92GfSPbmgUG7U2NmVpL7P3MuC7nCO+ni5roGMHimrxkRTmXkd
	s4oWyHVmUK9xyjl+jk4Xwv20UYp58a/C6TihxlAsgd8jK6qFOveuVdUlA8cEWlClcXxtBxoNvIl
	dVeF
X-Received: by 2002:a17:90b:5388:b0:39e:21a7:5dff with SMTP id 98e67ed59e1d1-39e54d1e037mr20177534a91.11.1790052483431;
        Mon, 21 Sep 2026 21:48:03 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cbe369dsm455307a91.0.2026.09.21.21.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 21:48:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 04:48:02 +0000
Message-Id: <DLLKN9WTMVHD.1601DUU5LBVAB@gmail.com>
To: "Eric Biggers" <ebiggers@kernel.org>, <bpf@vger.kernel.org>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
Cc: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Karl Mehltretter" <kmehltretter@gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: crypto: Use AES-CBC and AES-ECB
 libraries
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260922040413.28885-1-ebiggers@kernel.org>
References: <20260922040413.28885-1-ebiggers@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 09:04 PM Eric Biggers <ebiggers@kernel.org> wrote:
> +config BPF_CRYPTO
> +	def_bool y
> +	depends on BPF_SYSCALL
> +	depends on CRYPTO_LIB_AES_CBC
> +	depends on CRYPTO_LIB_AES_ECB

This will break the build with CRYPTO_AES=m.

>  struct bpf_crypto_ctx {
> -	const struct bpf_crypto_type *type;
> -	void *tfm;
> -	u32 siv_len;
> +	enum bpf_crypto_algo_id algo;
> +	void *key;

No need for this. The bot was wrong.
Reading any field of struct bpf_crypto_ctx requires CAP_PERFMON.

pw-bot: cr
