Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793311219;
	b=r9+O6VT1819cc0YlRzmu1mqBd0v++s5sAh8YXt94IKJ1Iobk4mMTe8P1CmPD2TF7ZSZN
	 8KcUt/R4D733hI5kz2aaVqg5V9nZpne1zlglX0zbiMC4wTGEv4tkPJhSH0PQ1l1XFsdVi
	 /yKLUbj0JNVxWJYvhtqnrKdu9SWnh9eOic5OpzFe15/PQcaqyXG0gdshSg12Tgbsvt2hD
	 KEPfSgiyK+bXsAOL+TVUFzAwHTUBONFZMiMNSQKCZjTHLPbWNKYOu/E15v15+aqStFWbe
	 ce4VJjhD8SLHro3lB7DAL+c3OYPdwrghRAidNJG0EGxUqv1m0qmspXiKnvK+G3JnpNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=IFhjJU50NRnZLc/6Fw9ifnZsiu6cQSxgUNU45JN2ns8=;
	b=dE2uF+XIfR5Id9hPObYumo/Y54cd9Dql51Ec52YKoGpfGvWlRfBjLzdxPJm5lCfNmkk5
	 /gNZJBlCRhUAivIHxMcvJpTzzZfcFyzu7lGPVfYYtFaa2U2ImjSeVUI7Qk2+jAMlC7dCc
	 azBdsp/aNZzmmifuRt3Q/ExNxIYUhJ6MI+qwkydwFc/VoNbUCZ2P+GHE2jqWV22ypcTqW
	 uQUyJQW9qjVpQFMTUfQuoMfIM3ah8MgQu5qqlo3YzjcDewK4hlL+IbdYQS9etfXOVMFKR
	 mo4hiVNBezgYPxLY2gu2l/Y2P9j8lU9o3AOlFu1JcGFXbEVVbM3DTVwqvMoecDSuJTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8qwY5B3;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C6606A31C
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 336C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8qwY5B3
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso15890a12.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311218; x=1793916018; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IFhjJU50NRnZLc/6Fw9ifnZsiu6cQSxgUNU45JN2ns8=;
        b=b8qwY5B3aFWWxz/PBbe9uIYv3kLsa+X3RRKSf2g399pHjxebtRtQh9nQA88gtDeQSr
         JEgwWvhueA5wsQTTp0bqNb/O20aQi8sKs7GwiPb8vOBMdx2Ob7PTzrmglVUITk+zz8Jh
         6i3N9ml69VYCyT/PVGKlx11nl+Toll7b+DIUO5ZRRqaeOf4KlD+BHjg0sISxDUR7R0z9
         TlTNYpH9UUf8OPQmIV/i/fgEjjlrRB4iqJnPVAI8wcZQpAj3K5pdo5+Kkv54E902LDBa
         cVbCyl51CrdqqR+o7HEOQmeebZT7flc6t81EflGQohpGKNvpzEUsXm3RatL2citXaodm
         BiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311218; x=1793916018;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFhjJU50NRnZLc/6Fw9ifnZsiu6cQSxgUNU45JN2ns8=;
        b=FFfcCF7+P9bjepitX2QNEvND/Do5v2AeGb7s4DUpQPrJXZpNkgBauzgzLA9cCXbDV4
         UaJkhSApXAX6txgVpoEfBFpJ1B5x3Sg/B0zkMkdq4sQkmgkcMj6VoYnQ3Jk4t0bRp0ms
         NYCisTYQr/uNavha/5xPHteBcDJ+CoaFQBhWdnrVqZFpta82AFxi3YHspi0QndnoShH1
         h72ybQqmCfoe3j70NHL92ugkiXwgnkkL2KLVgkwRHqZiDBMYzuNx1YmJdomE72jl5eWT
         BUITbBr5DZc5Dg9GD7F0o0vOrNpMYHqQpnOhlVq+M4GsiLwXJAh5vgyFf3V+0Xx+9kK6
         /lBg==
X-Forwarded-Encrypted: i=1; AKwUvBy/Sq/ACCD0a9pOgnNLnH6gVTHGRcB81PTVgnaRlMVJWJUTs3gddNKtofzgXmIvthXOAFM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGauzRUwidK4rCq8adgcwwCgZzw/2Cn8kbKm85z3HMkvY8iCeI
	/X9zUuE9wuS5aQ7NY3aO/xWQMsSfLzwp+y64Xs6uP5OmD6JPoWnHxPHR
X-Gm-Gg: AYBFou0SG2LR/PlKJHUKMgE6wiFQkfo2ZI2mCkQh80Mnsrl+KBDcYsVpDtY1CAy0k+g
	C20TPYke2btoI6lQXUFVtvmgDJTQz/8XXqdDYhJ0J0Jg4SiNh/MSjYCfBVzWIhQNnGkJeZaEjRS
	KuCQp9nINirIrvSss6M4H+RgPUwtgVLIEFFWSqnAV4IVFe95WR/S00fzJF0CXwZyig9IHZNrVuP
	Gm+UaF+Qh8tsg+ZaB3F2n2QqkCILJOKyb2NEPpDvoKkp2uHHVtntUFA5sj2fuyBuHdtQ+PydLSR
	oMSt8BvrssX9RQ2RQVSrR27gnYoCCekAUW2VGO9f+MDAlmfMGIalBQPzDQwvKIfHnA31lzxeK5c
	C5yq4KGO1Mls6q2V5LBGRhs9Ws+siuxbP7hlpAEtP3who3yE/3dPLzVUphBgpKj9i+u1uvTv3jo
	cv4ExeU/Fo583PPGZreuNObZJl119yLC7nUMXPF0yPMdK3nk6mEVjB6E15rZ+jY/0VVySw5vIYi
	bFRw+PNxpSwcXG+nFt4qqwn3UvFmIGG4zEw9r+pNGYj5s8uBBrGj+TceFoX+5bZn5QrCYRxglaK
	ovOdUTC1FKd8R0uY3TysebsoM4tx7Fyt8Vcn+azBLETs9PL0r3mn3NrSrL2RnifTFTYh3N1z4T5
	jP4XNIbHPK40=
X-Received: by 2002:a17:90a:e7ca:b0:3ad:3715:d21 with SMTP id 98e67ed59e1d1-3ae897d460fmr248569a91.49.1793311218239;
        Thu, 29 Oct 2026 15:00:18 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cb2e:96f2:5ce4:2074? ([2620:10d:c090:500::4:5b14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845984absm1228515a91.10.2026.10.29.15.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:00:17 -0700 (PDT)
Message-ID: <8c5de3ca94f9abd2afd994b6a7f1428d5cb5875d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 00/11] bpf: Scope callback arguments to
 their frame
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Emil Tsalapatis
 <emil@etsalapatis.com>,  Nicholas Carlini	 <npc@anthropic.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Thu, 29 Oct 2026 15:00:15 -0700
In-Reply-To: <20261009202759.50520-1-ihor.solodrai@linux.dev>
References: <20261009202759.50520-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-10-09 at 13:27 -0700, Ihor Solodrai wrote:
> A callback-calling helper or kfunc can pass its callback a pointer
> that is only valid for the callback invocation, and the verifier has
> no way to express that lifetime.
>=20
> Two helpers need fixing:
>=20
>   * bpf_user_ringbuf_drain() passes a CONST_PTR_TO_DYNPTR over a
>     sample it releases as soon as the callback returns. Saving this
>     pointer in callback_ctx leaves it pointing into reused kernel
>     stack and allows arbitrary kernel read and write (bpf-next only,
>     see patch #8).
>=20
>   * bpf_for_each_map_elem() over an array or per-CPU array map passes
>     the address of a u32 held in bpf_for_each_array_elem()'s own frame,
>     leaking four bytes of kernel stack.
>=20
> Both arguments point into a helper's own frame, with nothing
> longer-lived to anchor them to. Rejecting spills of the dynptr pointer
> alone would still allow derived slices and clones to escape.
>=20
> Introduce REF_TYPE_FRAME for this use case: a reference owned by a
> callee frame, dropped when the frame is popped. Tie each argument to
> this reference so callback return invalidates it and its descendants.
>=20
> Callback setters repeat register defaults and map metadata setup,
> while reference release couples descendant invalidation to object
> release. The refactoring patches give common initialization one owner
> and separate invalidation from reference removal. Frame lifetime
> tracking can then reuse the existing reference machinery.
>=20
> ---
>=20
> Patches #1-6 are non-functional preparation. Patch #7 introduces
> REF_TYPE_FRAME and its diagnostics; #8 and #10 apply it to the
> helpers, and #9 and #11 add selftests.
>=20
> v1->v2:
>   * Add the refactoring patches: release frame references in one scan,
>     and fold diagnostics into the REF_TYPE_FRAME introduction
>   * Replace temporary argument mask and deferred register scan with
>     reference acquisition directly in the owning verifier state during
>     callback setup (Eduard)
>   * Reuse callback_park_dynptr() for the nested drain test
>=20
> v1: https://lore.kernel.org/r/20260922010333.1226537-1-ihor.solodrai@linu=
x.dev
>=20
> ---

The series lgtm, but it needs a respin because bpf-next had moved.
Also, what Alexei suggests makes sense to me, it would be a bit simpler.
Ihor, please take whatever approach you think is reasonable and respin.
If you decide to respin as-is, feel free to add
"Acked-by: Eduard Zingerman <eddyz87@gmail.com>".
