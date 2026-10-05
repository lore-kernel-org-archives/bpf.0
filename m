Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D930B529
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225459; cv=pass; b=ZpwGQpQHayNvTjmR3d6+oK6/iSSMtUJMhDyE61JfQQk+gtQVMHinpMIRaB4OXfvI9khqhrdeptTIgXmocjiTL1qzwqIY38fsn0xg3IqZ0XHIWDw/SbuytUK1hMAXtpwXl+EmjQxQEuhvnnXWdy2rAqWNNSBYgFJ/RjOjpjJHOok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225459; c=relaxed/simple;
	bh=2JU+Sheh6MQ1xEoN5samKQCu2q7ijg0IaggxyuAyf1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3qF70Q2Ux24lPLqoNgD9oyXojwP0bfE1htbosT+zFNRQrpYsy0Jgyjp5tLBfyd08q6mk2fopOD4NEt1o9HebUs5aBsWP1U2O+4rUZ25eNO7DJ2QkguS9bJJLhIV/uq7q6LyL8eFxt+PDCUgnSxTKozAswE9ZgfCDXKJEBLagTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZ4FvSS0; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZ4FvSS0"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-149241d04f5so2398717c88.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 11:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791225457; cv=none;
        d=google.com; s=arc-20260327;
        b=HNOCdslhzNcNbcJiMQP9dIYtsslSMv08y7B6GTnUo7BF+nALiyxCOn5gtRzQNZLo/r
         R7St8O4TloyxmfnH3niCWS4A3Y+tgRUVNdvBXGEv9zUwMuendWbqhe6hjUZyrwSCq3y7
         y4KPfirkQ3Bric4GMus6qVbCr7UUrxV74mFQzwd+R4T5XFw3syg66l0/0sWhbNmQ/Tl+
         tp8zuferJE0pihw0GbPzfP+SG1Cl/D3TktveaQG+WzRCDAgQljKdZZ3io0zO+EibMw+U
         FVQEIEt2kKbeiLzEZAmZgMaeALq7ceZCXOFKXySnNrGbH/SSuS+S44u+KOv2sBl2gbO2
         +3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lh9jWG1rCxabPueueZRnWmHBAH9yIQrASjMRaLKUo30=;
        fh=+Jo/Uy86hfkenp1rWT5ZLxJk5+Nf2Fj9/XcL1UXZmeQ=;
        b=KQnkZa9G5jrXxk7iRuSBVaI9K53EiM0JrgaWocX9UU2c3PS65bpl1jgQEry5d7990M
         jaYchnQaZxyGwqCJBMhtyzVeKmTXxG4cHF5lyfT4f5a+1ZGZhHWMVTR5kl1McwAncSmk
         TiPDbTyEg7++ETEI0pG3YSLJ09G74ozDvQrdZ/mzL5++RzqdTKeJrjG6As1Gyhk3I1Yw
         DPWtY8s6ELdr2EcJ5NiCjHhINhxxi6gQTtVMpt5qt34AlppzTab0DIk35e2xBiSmYKw2
         9il9mkmD+aSl2WydPqLxNF3RPdaoG4DmnWY0BTE/fHLJ79yKQj8l9FGbBX608+WB30JZ
         nbEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791225457; x=1791830257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lh9jWG1rCxabPueueZRnWmHBAH9yIQrASjMRaLKUo30=;
        b=AZ4FvSS0jSF8Qo7UdXfySa2q1ycVumXiEJJQJ7/8/EKkRj9QNEodm1mTZqikkIOs6y
         w0zAlYJK4EZNLwWc5mM+X7+fMCOe3sQ9bgqkTt8MTe8IyzqzAbls2uTjytGsfhiXdvy2
         vZhuFtWHNr2uFjQwz9of/ZSJkSQx6aMJOEj0mso5eAUvw06Ehn3/y0mUT6/CtmQNpnEZ
         gJsiv3BiBsoedwI04P73DU5y6/W31k0WDivD4LRULhKhJnzT88OxY17L4cm6m7SRdfOW
         QqE/KG5gYQcXvI2YrPcMPTL43FvVYXlaLyIGRZitIxyG0sPZmUUQEWs072WVXGjSPEXC
         FNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791225457; x=1791830257;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lh9jWG1rCxabPueueZRnWmHBAH9yIQrASjMRaLKUo30=;
        b=VzQZjwDjvAvr9bVctHq/5IAes+EBrOlsM57wMyLUkVgB5T/OqtxcmVxreaRJFRwyND
         qzEriH/ecyyjaDkTBFxR59bQXGabzzeI70126fFbLUqLLaL/fyMlwv0NECRj4QGYHB+r
         zyjfL5+a7UuljUQs8StZStZla1+8Xex/xrhGVhIgxK4Sve/5BWHDX7bT4J+VOnzdHNiq
         lZcJXqRmwnW//CoOXUCjx10DU2Xms/g6b5+FVZbG/u+CVzixKd0jFDXQ4ub5Wvrth3+J
         GKJ9y3VsRXSje2nWnhrJ7RjfjQvuIbtjMNQNkSGOyyCN0rsVbzfFEoriNPo1n1Bh5OGo
         VEvw==
X-Forwarded-Encrypted: i=1; AKwUvByVowlG6j0slyxxng64J9IXs/iJyaE9bqUIw70i2sYOGgbokYAg84cpYOT9QM7qc2yxr/U=@vger.kernel.org
X-Gm-Message-State: AFuF++ngFVbD7pLVsg1OuQYPlGKNat/1TC2/3jvvGyIOSuZLGP1r8714
	VAAj8FMdkn8Db2mwWPYfFaD93GvXcYypr5fIwO8Qr/b7/52xfq0vqm0GWRRtx7AUaLFlIcXvYHv
	Y1SsTwJ7e+PQhFpbW/hHUPYqZg4DJGr6NLZJx3YBe
X-Gm-Gg: AYBFou1l3+L1ci6UXWHTJsyV0UFyAMhcondZA8QtBAGopEq+d0DMDDv1KvTQ5gq4TOu
	FcsSra8WVlwK+l36fPuUEBrJCH6iUrAUy+bkB6/7KTrGvU5jcIr4442iDA92eu8APHhqKYcp+Am
	FXDQV/wZ5zn0Plqd4Y6fG5rR+uBRi77aPr2hXL6R+5CSzh6oQYOrO6LJFU7SYNG6FZwZiW18WOq
	RdQoP/wC+jihXfrsm7+OfsiE/B171BFXknyASw39G4ExmUVib8xnp6s8qNo0lf/JZdXYf2TmjV/
	x5RsxghKeAGd9XkW4n80/S6+NdbAUVJk+6UAYNf+6p4WLB7PgF7kb9aFO52OY+yeH39SOtrZcb9
	Vu8FitB/jq3zwdVk/iD1iQ05LnR41lAoO9/nNa9UlSWFApiFHVCJgRwOuUy3+m6H9ehXu9zlei8
	66khxYwMkIP8Vg9UDTE7DSxw==
X-Received: by 2002:a05:7022:f51a:b0:136:b50c:c0e9 with SMTP id
 a92af1059eb24-151c33d34cbmr10196374c88.21.1791225456263; Mon, 05 Oct 2026
 11:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com> <20261005154533.4147685-3-kuniyu@google.com>
 <asPsATnTIr0Fxa_b@devvm7509.cco0.facebook.com>
In-Reply-To: <asPsATnTIr0Fxa_b@devvm7509.cco0.facebook.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 5 Oct 2026 11:37:24 -0700
X-Gm-Features: AclHuK-8QnzKqa05dEZjVlQCiqXkS0NX0LuNZTU47FVLnAJahel19JQ74BKYS8s
Message-ID: <CAAVpQUBikn+8Zb_01T5aebhRyhKpHpWFbWHwk-vV=N9S0LCQXA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 11:30=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 10/05, Kuniyuki Iwashima wrote:
> > The legacy SOCK_OPS guards some hooks with a per-socket flag,
> > tp->bpf_sock_ops_cb_flags.
> >
> > In contrast, bpf_tcp_ops was initially designed without per-socket
> > flags so that users can simply define only the callbacks they need.
> >
> > However, it turned out that even attaching a bpf_tcp_ops with a NULL
> > callback incurs measurable overhead in the fast path. [0]
> >
> > We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> > 1 bit left for a new opt-in callback, while not all of the 7 existing
> > opt-in hooks are in the fast path and really need a flag guard.
> >
> > Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> > update it, both of which require sock_owned_by_me(sk):
> >
> >   * bpf_sock_ops_cb_flags_set()
> >   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)
>
> Can we return -EINVAL from these when used with sock_ops?

bpf_sock_ops_cb_flags_set() is not allowed for bpf_tcp_ops,
so we could add a check in bpf_setsockopt() for bpf_tcp_ops
to disallow TCP_BPF_SOCK_OPS_CB_FLAGS.

But not all of bpf_tcp_ops hooks are opt-in, so we cannot prevent
attaching bpf_tcp_ops to SOCK_OPS-enabled sockets.


> If we keep one flag we can presumably put both tcp_call_bpf_Xarg and
> bpf_tcp_ops_call under the same if conditional?

I assuemd we will use the new flag only for bpf_tcp_ops and will no
longer add a new bit to the sock_ops flag and fainlly we can deprecate
it under a Kconfig like CONFIG_BPF_LEGACY_SOCK_OPS.
