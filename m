Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2D24E4A1
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786910105; cv=none; b=U59qqQ0421SNxeIRHhmekwymOriI8x8+gfzcHF65fqTHbSQx0jVd8XXP9a0ZBPGW+uFYxCskI68/pQbvvpm9sGMGxCkD4AuUaytTAn0bU1Zgyfvg1+mq1TAblNp5KvwFGJQR/Ye0tXmMENpfNCch/LPo6YBUZyhtOHrFB27y4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786910105; c=relaxed/simple;
	bh=U9hqBn1wlKYt3q4dU0J3dak+CRZy2fBfaaXE/62n9SM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gk82UrJEs2tSnjZzUNHlS2iokUe78LeC7HKr+HuWU5gbfnMl24ZxgV0GNR2jHXblB2eTJj/iiVYY4CYzSfGXeipZW+YQgJuJwDmtN04DUbmAuDqNWTA+JhNBM08IsI4kWYqNs+j+rqfchWQAwW945gE4h5nfLqIfjkzrfngML/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNHlAcJ0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNHlAcJ0"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso1579261a12.0
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 12:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786910103; x=1787514903; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hJMR5tmnCzNQwuFBEr/gYKx0nnQ+Z1grIK6wVeGOUl0=;
        b=qNHlAcJ0LmKaNK9x8tzjw4uBdt2TcuxPoD2lNMm3MOxy6x7FhIGDZF4/cSc7RTm3H4
         Zk0co1P50QeguPBoneiflQQlD+5XdMsC2Z2l2/waPsJO5tPD+0e5iMG9grzahy9PqGFK
         ln/4Hy2PJ6UJjxjeHW8ECmD6v94ZHDkuULj+1yDUJCaRBmbj+UKSTP6Fzw6MugyuD6MH
         WMxU1TDs37R0mmg6SOt1f0AViNuclDuo4YXzuRkkpDvmHmY7OB3C5wocvyzRdDYOjMTw
         3YndJ2MENDUVq7v6mXeT0T+B8SsSO7nt5j/+HzVwQiIZpREBRgAMKOJxDWRe/O7zwA29
         6r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786910103; x=1787514903;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJMR5tmnCzNQwuFBEr/gYKx0nnQ+Z1grIK6wVeGOUl0=;
        b=GngY0GBolTMT2R5fHzHRzkzrWmrfJZQ9Y8esVTKupqiaMnzgi7C+/kwolFGR/HJig5
         fHsFyOirteYeHqRgQotXWZYwE6gDkFaOM/5BOLp7y/wwjpWu0xpMTVHvbfHxAnHihwV5
         9Yf+AbF1Tr1yMfu6hfRr7SeC9Zk7rseU3kaQfKVIrITS4iV5Zh4aC9BWWlOYeRh0RoWQ
         tqayVXFY4SIhzQ7TazSPsFSpDPr0ps4/6sWEjiwd33AifSqdxU6gOG5fxwAb80FmqL/u
         edWT/EkBR82e+NWBza4ztFYuid8C200U8BEP3pCwNAZBUB0809SxbHu6TkPhB8Jh0Ddy
         4n7A==
X-Forwarded-Encrypted: i=1; AHgh+Ro2l0/Nj+0tZDVB3mFjkbS+Zr4VZrVFhpNzNV3nAv4k+z6ccoJTt6ogkfdPI3MAaxk3Hc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmIiUhz+eAVfYYsCVOSBudWHI8iimxEAyLIn5HPj4yv8+jbzr
	4si4wbJWh/bVD8Fv+JEbFu/89DTrflji2n57WcbiSOogXVQXpg2+Fl+R
X-Gm-Gg: AR+sD10tgM7BYwl8KbqoQfU8ae69AXSJ0slTMRqotW3PJGcMhbL6Kw5Sx9aXHLQ/23M
	EFtEZqJ2IDC/lMkYYgqxqOD8bg5kI7yUXENJAzUk+UZixlw8rMin0MdD7kx5F51k9arPpCX9qFP
	PzWGSKblcnmE6ntWdj1mesQYxzXbhyPmDfq6fje66/HFSOyf9WcL4RJUlRIj27gEDf9r6nOZHEP
	DplqZfa4NwuACDsGWydo3iwuy41KdGMLeCQJkjnoB3r/BhyqVdE4XHkliNWq3sbKmNoTh2G+oqX
	F1qj4tjmVj0QAIAHeC/+UeBR44z7xSw620MFTARnE8jNYTYV1qETrjJv+H995HmZjWTt70k25xA
	nJ8TG/U6wwVS4ntNcF4Y3aYqZ+KpZw8YG13+K81N+7n9QKn9l1m+BphogH+j+CXm01FiHupi9CF
	0tP0WdM60jV/f4wz30LKQ/+DVaDY+MNm7uUtU7egbdz2GErLN4vUlskl8pF9v3wo59Xrv7SEXvj
	JJdCGM0SG7edhNn
X-Received: by 2002:a05:6a20:1609:b0:3cc:3d08:da2b with SMTP id adf61e73a8af0-3cc71ad1691mr21858188637.15.1786910103208;
        Sun, 16 Aug 2026 12:55:03 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc12dfddaf4sm804243a12.25.2026.08.16.12.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 12:55:02 -0700 (PDT)
Message-ID: <9b30b735a7df1584042a4dbed4d8f2f54cf2f395.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Reject a store through a fault
 prone pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Sun, 16 Aug 2026 12:54:59 -0700
In-Reply-To: <20260814215301.709827-3-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
	 <20260814215301.709827-3-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 23:52 +0200, Daniel Borkmann wrote:
> check_ptr_to_btf_access() allows the program to store before the default
> BTF access path gets to reject a non read access. ac65c710cc64 ("bpf:
> Reject writes through untrusted BTF pointers") closed that for a
> PTR_UNTRUSTED pointer, but a bare PTR_TO_BTF_ID may fault on a dereferenc=
e
> just the same and is let through.
>=20
> A BPF_LDX gets the BPF_PROBE_MEM rewrite in bpf_convert_ctx_accesses()
> and a bad address is handled, but a BPF_STX does not and cannot, there
> is no probed store to rewrite. The store is emitted as a plain one withou=
t
> an exception table entry and a bad address panics the kernel.
>=20
> A bpf_qdisc program can reach this, bpf_qdisc_btf_struct_access() permits=
 a
> write to Qdisc::limit and Qdisc::next_sched is a plain struct Qdisc point=
er
> which the walk turns into the compat type:
>=20
> =C2=A0 struct Qdisc *next =3D sch->next_sched;
>=20
> =C2=A0 next->limit =3D 1000;
>=20
> =C2=A0 BUG: kernel NULL pointer dereference, address: 0000000000000014
> =C2=A0 RIP: 0010:bpf_prog_c6e14e7f32c8e325_bpf_fifo_enqueue+0x3a/0x12b
> =C2=A0 Code: [...] bf e8 03 00 00 <89> 7e 14 41 8b 7f 14 [...]
> =C2=A0 Kernel panic - not syncing: Fatal exception in interrupt
>=20
> Fix by widen the check to bpf_may_fault_on_deref() so that it covers both=
.
>=20
> Fixes: 27ae7997a661 ("bpf: Introduce BPF_PROG_TYPE_STRUCT_OPS")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
> =C2=A0v1 -> v2:
> =C2=A0=C2=A0 - new patch
>=20
> =C2=A0kernel/bpf/verifier.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2e6992569187..6610e2437047 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5789,7 +5789,7 @@ static int check_ptr_to_btf_access(struct bpf_verif=
ier_env *env,
> =C2=A0		return -EACCES;
> =C2=A0	}
> =C2=A0
> -	if (atype !=3D BPF_READ && (type_flag(reg->type) & PTR_UNTRUSTED)) {
> +	if (atype !=3D BPF_READ && bpf_may_fault_on_deref(reg->type)) {

The change is correct, but it appears that the if condition could be
simplified as just 'atype !=3D BPF_READ'.
The function is named check_ptr_to_btf_access() and it is only called
when reg->type =3D=3D PTR_TO_BTF_ID.

> =C2=A0		verbose(env, "only read is supported\n");
> =C2=A0		return -EACCES;
> =C2=A0	}
