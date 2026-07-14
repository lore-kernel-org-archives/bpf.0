Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7242BC5D
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071043; cv=none; b=VekNnVJ7/n/FLE6n2HsomE9pk2IxNbZuRTnwt1/Iwe1WJ7bJomnLLnsKgY3jqvqM0NsfhLy6iMgKFUyan8pJIfeXgVJNxyUTCfg/cwaBfKyq7dzkuSBfkLSNMZgZ7hsXN6nsEF531e+h9l6p00C39FxtdFI5y+D8h7cIp1K52gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071043; c=relaxed/simple;
	bh=kpxcfS/qnfpsxoLYLPp84x5FSHC7irhbPO8MXAUtSh8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nyyS1BqdkU3tOZ6bj7hB7/ProTJWOGiCD/vO1XB9I+vQiw9FaRSlXhRFJ6UT1+G/wv9LfRn397wve/cAaLfTGpoJgWJ6oU9WdC7bvXJrHLwZSOCbewAl2Qn0WnkEtKewHNp/OvPzm58cIuYwpuJAmEMQQl0Tu5swt+oh3weDHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HujybX7c; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HujybX7c"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c96c92c0980so946849a12.3
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784071041; x=1784675841; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kpxcfS/qnfpsxoLYLPp84x5FSHC7irhbPO8MXAUtSh8=;
        b=HujybX7c11bw2AaOmPiECnMSw0poi6i/aUZbROGuybXi3gOs8gwUIZ/X8DsMotkSni
         pQa6eaO7YNzjx26WP+ryqiscBbehKMm9Z7KQIHtJC4yipDpyvGX0EfHaOx6wyiD/fLSN
         JFUmhshc/Gk4duC21jRO22qdvG5mskDNyWW3ArNoq5yjc0IINgVPblFwPrC7SoAUVJcA
         a6rnRGgvCruBLxngsNSJ/c6S0rMEfdx1AZbD4tKFcz1HY5VcGBPP2HkeYxA68dUdRGIw
         TTfDKxrsbOpfbwrRhji466dc0NohW9N1qHx5VFU/drc18RWg+4qK0OJEo0vPFgy2xOu1
         WZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071041; x=1784675841;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpxcfS/qnfpsxoLYLPp84x5FSHC7irhbPO8MXAUtSh8=;
        b=lqv4NqtuUOP6dq0D5gL+UFY7sCYUhGsjcDikVA+wI+E/QaKhkXkbZowhTQZs6mM3N1
         9ZcSYa8hM29Kh1VdIzur7KPC/pvkrk7uwqBfNQwBYeCg5B+WaQLuqySajtGPdA35XF5x
         sDR26f886c9+Abq/kxB7WN5T87f3sab/LUnVuEoEc+qHOTneO8A3FtgBELZVQwgqQeKI
         cfUZEI2ne5dXGdSjZwk6aYzjlwFGJPMsa6PoQgcVN3QNDy8llKcZ6fL2J+Ff4m63L+Xu
         jQMWj1nentqZ4K70sOjjE09un6vtzawHPRhWYqc9t/5r3OMSJ6G7zxivky3YwnOum9cM
         2xqQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9qF1Xoft7VDy9XdGX3Bj/q69Z46OVIviEYMneJL9/8PaKQ40OpJvIid+9MpSARIx9nKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZPGwGrrQnUi5QysEv5HpAoxfQ5de054Q0BF9AC1ErrKdkWPA9
	amkiS6xdzC0A9JWL2KpiKugme3bvHn393wAFQB7fDSKx6g4yEJQkO4W6
X-Gm-Gg: AfdE7cm8PRQxMI0RmCiDgauUQEY9dZ180urGx7olP074Qxj4Mz73Yh68WHMTVakmlXL
	/i0k1KdtcnmrTP9Rj0+AoYWuvB20SPfV7F5R6dKp7/X1tKUvCPkLsA9UHYHe4QtzU7xT3r9q/oo
	/GYFIZpGgDFaJQBKAXLBMORrvIJGk9IonNeUBtCmtug956WI54Gkg5TIsJvC0XvdFgTuIdqyEo4
	2sK0sfvsMAuE3n2ceclrLZS/48MKZsGlGbZ92x/DheTtc2lKc9Tg/efSkT1X2CJifFPtjFdKewu
	Je3bxCGg6I8iU+7waWDM0FfgaMDuJm17XtscAmoZ4r2jEc9PQLVCVB0Yzb+1dFr/0ecM29e2ioX
	cFlmfTmVfcGJna3Ki/nQMzz0VPGzba3gbTApz5PAztv6YCypHZ3uKjSBT1mrBq1gfI+0WWj0UCj
	Ub88n9w8M+RafW47YDQvBl46BxXjk3Bg9a6Rga7zvyriKvwdEY5FGXc6ZdSHAx9mPhnRSh+w==
X-Received: by 2002:a05:6a21:3418:b0:3bf:b755:ce6a with SMTP id adf61e73a8af0-3c110777342mr17988292637.12.1784071040919;
        Tue, 14 Jul 2026 16:17:20 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:4e45:4dce:ff04:add3? ([2620:10d:c090:500::2:30f9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm152776346c88.14.2026.07.14.16.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:17:20 -0700 (PDT)
Message-ID: <b7c1fef812fc5b0a353596e082aff28a67cfb018.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 16/17] bpf: Report Verifier Internal errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 14 Jul 2026 16:17:18 -0700
In-Reply-To: <20260713153910.2556007-17-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
	 <20260713153910.2556007-17-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-07-13 at 17:39 +0200, Kumar Kartikeya Dwivedi wrote:
> Augment selected existing internal-error paths with Verifier Internal Err=
or
> reports. These reports avoid suggesting source-level fixes and instead id=
entify
> the verifier invariant that failed.
>=20
> Cover non-overwritten BPF_PTR_POISON helper argument types and inconsiste=
nt
> kfunc graph-node argument classification.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Tbh, I don't think this is really necessary. There is not reasonable
action a user can take based on the error message, except for reading
kernel source and figuring out a workaround. It doesn't matter how
nice or not the error is formatted. I'd just drop this patch.

In case you insist on having this as diag_internal_error(),
there is no need to have the error report function that logs it two times.

[...]
