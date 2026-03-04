Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A373DFC73
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648155; cv=pass; b=hlH1lbfGIHYDQTmuO8c42NDqSTT5hC7ozve2VwinXB103O4HWTKbTWolNaq57hrCj92+EPlNw+nEWhMuPcEvId7R9ggKYVrBw6r7QQZSKNUyXObxeeK/Mv5nc0X2knBE24NRSbtRrFn9vQGwf9q4KcGLMjiNm+fwIZ8D9sepfcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648155; c=relaxed/simple;
	bh=9MwzP3uhQnku7obL0CECuVhwCCCsDCe3y2WbQ/ADWWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOhuBzwI23UW5jWuBmTQpEtV7Z8354j15kU1VraGLfxkml8YRmCMXDFcW0rbNHD7RAY+vjHnzxLGM9kGZbC+Gd618lAgpdke7ZsvGPbj9pCg0ICQbkC7O1fYwdJA4l6IViVYABSr6aZ499Movru0xVUrC69S1E1OaO5iDdhGzFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yJGtS2/i; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yJGtS2/i"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a133cdd4aso20689826d6.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 10:15:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772648152; cv=none;
        d=google.com; s=arc-20240605;
        b=d3vbnwLr/NFA4U1+JO5zpUIwRYGJxTPrBme1IouFYY7Nf4CZa4UqzICX0SgUlng3Iq
         ybuYnDcaDM/RItyPyXpeyTUM+t/XPpM2SEgXC1k6Nse8FqgY62CymKbjVaVjLcvaCpgW
         KBsUh0XxCizFeSIzaxEsNNOBWEn+QY/COg73tRGnDhzv5GbuWS6oq+nhdSXBaDJIIhPx
         t4OpIvleNY42wfxCGZshH88MBjQQSaeIMGB4kWCps+7f4OnYh5wWYQOheExEx5sEbKMu
         gu4fiuPx0Ax8TuWzsxW6v7dTNx+HueLo1DKjj8M4flWF2wBVnjVx8uHFZm1kazq29vb+
         ck+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XcOBwlD6MQYPkUV4YAb3fb3w0HLmtc6PEbH9Af68W8o=;
        fh=Wiazwz5i2ox9S2HjkAdVaeQsMemHjOWEh7xpEP5QmSw=;
        b=OiCqn1HmOtLtnconb6kbXg6I/0FrUOOR7011p9bTlygqjUTGjMKiqOC54KBpPFuVcm
         G65iHKGLAw/kER5FwCwVQkRQYY0OzlLwCGh9pk/67LHXt01/Z6Z0nJwG4ZuFduHLYIsc
         IR1LXSimrQg3vPbKQganT0sAMPY2rTmkz6Sfn6bQYLqobcZLRlEz78JMSYl6FXjWx6gF
         f4wcWMg9ZyduyEfq3zRZI+DX173ngqlRuSbTa23QxdkEYoM7RbDVGQB1aQwGc7VOYWTk
         AqA06bHxcfqTIGJZGUfpm90VhUJ/fVzjhg4VFkCoMqmJd77fL9fhYRSxHeQ+s9RJ4mM8
         eIGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772648152; x=1773252952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcOBwlD6MQYPkUV4YAb3fb3w0HLmtc6PEbH9Af68W8o=;
        b=yJGtS2/ihA4fm35w13e6pcmk2o9uQWOwktFVSk5BYpEbo3WWpVfpwrvclt1ZQU+BzI
         YZrTKuIT6lbdHTJjgF0gU6X5KhQfpf2EfC34hdess7WthRfcdlPyVMdKZDV87M2cpzZZ
         iGBC8SjvWi6HMhFtr8FxbWHVwdUlFw0jPXFO6e4tkWCylZ+W9nIvUjmI9s0Wb5JfLnq1
         Ch2d2xDWtIt8TKwyRse1hDFG8vKUf6zyOtNJFocU/AmYNOtv4Ox0LOk0ZMjeBcIkInfa
         s9+Kg5wA0VNKy1EVD4zlphF5RvnkvFnGsILwsdcyKLizZLG08C5pig9OCH6xRnL92nqD
         SyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648152; x=1773252952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XcOBwlD6MQYPkUV4YAb3fb3w0HLmtc6PEbH9Af68W8o=;
        b=rMNh3XIBVCETFR4qNTqHgpHi6ao/rOqxoO0A3RPUM2BFePLkVMCVygogEbHhiZtu2J
         i5FLBLTjmlQxNWbmMJbzNec/5Jw9y+5k4X/jLTdsYTXr+0mMfiUZqDiiZJW1twSn79sc
         E7pqWh3ylvkBl63cJJyZ9v93z1OVMW7G0jdJrg7GzTIfiq0L+guaulywNSiIk+kIv7XE
         hUVi85Gcf5ohkWIWgMcpkEhO2TgmAj6UNwiOiBkQmzAz2zJDUkMUp1IHMw3TjYjhmdXk
         3tcjwckmqdqD7esVEdxUQ/UNj2u2rQF31Ha2pHGU5c7DOJwzQDfDuYPqCMQGNeFMTlQ4
         YFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqFsaCllaOFaJTrYKwtaPnJfr7Gwp2d85jyPiwLR3Vf8oQ8JZ6bNEEcg8DCZxHXxcdYKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZ0iFfwLcx09q0AXXFp2+fcdvL2wBqnGxJHjb5v8XfW5zis2Z
	5LN2YkzVF2xCb0qZFwkdvuCHXfY1jOtAK2oO/rFJ771kD0M4x8LLilS8FA9iLRz0stO1ralEwXM
	34ECIcPIo87huX7/aHbwsnoH7KvnmmO4YL9EAkVjb
X-Gm-Gg: ATEYQzyPKSxntrE7g/vDLUpaCgAkpYhwSH1oHP4nDAjwTW3kO9Ky5guPrQybwxOBOvu
	oz1AebPI0JnbbQJOnyTBft3zmm8/K9JiBfINZsIB6S5LMW67QpFOlre6sc7rIYKMoV0nExb3pmW
	uXBWKxNjiAsEp/EweE5UGhkIOd0oRjpM1qrXy918nPN3iKLiuUYbbo6TtebonupjrKBHMOymQCe
	Bfsqa89wgKWEGfRy7s2RrL+Mj+cZnnHY8tdziopnYShWmy+lYAuMLNxvoUhDKEelcgX/9QkEV+V
	A+GzeQxz
X-Received: by 2002:a05:622a:1386:b0:4f1:b947:aa04 with SMTP id
 d75a77b69052e-508db2ca0bdmr38936101cf.18.1772648151053; Wed, 04 Mar 2026
 10:15:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304111517.2088694-1-kmta1236@gmail.com> <072854a1-0521-40ef-b963-6e3e56084281@kernel.org>
In-Reply-To: <072854a1-0521-40ef-b963-6e3e56084281@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 19:15:40 +0100
X-Gm-Features: AaiRm504-7or6_xU6D4WOOgH2jGgHMALSXeOqt3vfn5JgtFDBEissEU0hjIFp34
Message-ID: <CANn89i+Vdj_CnnJZEwp9dfiAV-z1eSFBp+4a9z6FDS5Rw3k4EQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2 RESEND] tcp: shrink per-packet memset in __tcp_transmit_skb()
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Keita Morisaki <kmta1236@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mptcp@lists.linux.dev, 
	Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 7:09=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Keita,
>
> On 04/03/2026 12:15, Keita Morisaki wrote:
> > Use struct_group() to group the three fields in tcp_out_options that ar=
e
> > read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt=
()
> > (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memse=
t
> > with a targeted memset of only that group.
> >
> > struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> > CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is eith=
er
> > assigned before first use by tcp_established_options()/tcp_syn_options(=
),
> > or gated behind its OPTION_* flag in tcp_options_write(). This memset
> > runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> > bytes to 4 bytes reduces per-packet overhead on the hot path.
> >
> > Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dy):
> >
> >   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
> >   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
> >
> > Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> > already used |=3D without a prior clear. tcp_established_options() alre=
ady
> > clears opts->options at its top.
>
> Thank you for this patch! It looks good to me:
>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Apparently my Reviewed-by: tag was lost.

Reviewed-by: Eric Dumazet <edumazet@google.com>
