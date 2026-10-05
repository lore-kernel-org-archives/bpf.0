Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C237E310
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240466; cv=none; b=SSRS/OoBxZiWCwz09HxyAcMnhJxhBo2BKoKTOWGtwvJnX+HQq2D7HEHtyY/Qt6Jvj582uQuM7Mb7QDvpLs8cONIe/7Z0SXun6rd66BDM8gKbNAPwoQ4jeIeMDD4Cj7js1/FLgdfyRwW5EsCPMt5vCX0tIVCKjjCTIvSGyleJEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240466; c=relaxed/simple;
	bh=XJxAKxG0TBthxZ+cdhPavwBim/EbIiI80E6SjLMFF+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbMouM/nsvq+xhg2zea1IC9enEuDjZRdV0m4PmSSFB2IishLwZs8MfMJlcfC3VqTs7xVGQpdgbnD0qyNH3vJFr3VpaUYgh5w8R3ZaG5rwy2qCvjruNa1sE7K3dYHf9Viq4XKQMTZw7SkYzDwNLoYJWNdB6hNBOGTTRtd67XaG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxCYe2xR; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxCYe2xR"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a81335d55aso583365a91.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791240461; x=1791845261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JiaT2c5cjTe3MsSYDeTAHnzZNgk/tz9XRA/TRKMqdxs=;
        b=AxCYe2xR0dtJrEdyt/fl27MERg9CDWKs2NgtWLAk5QhWFIpjQtM2FntqOD94Iq8rV7
         vvVmrUGp3JueZ65dx8T9kh/ljSH5477WK+OjOqCn8dwEpRKA4GQ/cFJZ/ryYhYtlHzmh
         o6l7nC+oNn5dDUkk25HIiDTt5rbzkJ31AQHnL9pe8iP/NF6vKRqLOl2xPw2IU8/cPTqw
         MsaqAg5z8ZjBwCG1NS8uGnDTcFBLbeLz6aSjR3mhZDWGQAmcyKZmP+ys+2l/SWs6tDOF
         WYqIdORi54HJDIDJ89dObxeauIvBGgSYee0z6C/DWFnfnEnujN/FpEPz2m57+N7K+S/j
         O8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791240461; x=1791845261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JiaT2c5cjTe3MsSYDeTAHnzZNgk/tz9XRA/TRKMqdxs=;
        b=VzVY3bc3HDGVT+zBSDhADN1GnAn8sk35bTxmXFyRJORpLMUMcIB1wW6iX5AnBrWkcf
         q7aIO/04P/VdNYuqcHqjrs4BJFHeB8a0Jcu3SvwJJWjoVeo3AIXCs5+xuihIEXsbISIJ
         5G7O7DIY5KQk9gcO4g9F6WN57XyaCkwhLlp+1/Fi14czdidJGtvB2acO2oXzFal41iO2
         Tl2aCEfX8x0k/SZOop8c+29IhdIGXlLmoBW6KiQAKXDupsC8uJEk3/UOmsCe+dIy8Ayz
         IY0eLFv5gIOhDNkIK83PNQo+cTh3SN57IQGsu4axpDyzaVV2nkboepXTYlTujNH6oWId
         DLgg==
X-Forwarded-Encrypted: i=1; AKwUvBxzHJP7wVwq8dWWP+uRMqOBnxsEAwK72/lShp6TB0BeEDRCB3MkID8D5VeUU1Gje+M/U3g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIp87qBjmTQS/YuKFpTdl5aJ6J8ZckIV7hKYj64MgFpupqEnOU2
	Z7Dh017/e6Mgyksu819xJvdUeaBJH1RCosIIUN5f+Lp5vi0YDxWxywQm
X-Gm-Gg: AYBFou2/Ax0cEXjP0KRHCdaqCTEL3erbWo+Fu6BAKlmmS0lu5acei3Z4M+xlR6HYvKl
	TWywyhe8QjoCSRcofocbugzKXAYfjEQCbGecPiZ9qKPRe2oJSzTb77J/TzAgQhXb0xeinZ7De3q
	vI0woIT7TUxFsq27+DDwTOzDsVShOXt9fZd6CotoJjT2wfMq3bUd3y9tVNq2OLnThG3c9aQAbC4
	sZgevnnpkbVG2TPNOdSMU3YVl/v9NRlL+LqrOkBDMV+esutRlCVNFov7r/nFoGHJazDg1KwxqmT
	YVMrSbc262/RUnTh9sLcbFzLMePSA7ShVm5PQj05kShPeZPBa4FuoVR0z3ucPgNy1731yHvvYJl
	fRoqp6TdIwD4GU4sD++M7R1XTV9KilvJ7jW2d8xF/4ROPYa6F33AYDWRZtMaYxZGtMIcpJXAZ8+
	ZzFpDE+NEZbEyzudG4s33jmm4tNe3dY8lg0fSgApzY+ffSLP7oj+WHqHwa4yjTnOSx
X-Received: by 2002:a17:90b:55ce:b0:3a4:a383:f9cf with SMTP id 98e67ed59e1d1-3a6ce7cea1bmr11382885a91.38.1791240461172;
        Mon, 05 Oct 2026 15:47:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8543bf138sm1537403a91.15.2026.10.05.15.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 15:47:40 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:47:36 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
Message-ID: <asQoUeoXFa2-ofPu@devvm7509.cco0.facebook.com>
References: <20261005154533.4147685-1-kuniyu@google.com>
 <20261005154533.4147685-3-kuniyu@google.com>
 <asPsATnTIr0Fxa_b@devvm7509.cco0.facebook.com>
 <CAAVpQUBikn+8Zb_01T5aebhRyhKpHpWFbWHwk-vV=N9S0LCQXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUBikn+8Zb_01T5aebhRyhKpHpWFbWHwk-vV=N9S0LCQXA@mail.gmail.com>

On 10/05, Kuniyuki Iwashima wrote:
> On Mon, Oct 5, 2026 at 11:30 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 10/05, Kuniyuki Iwashima wrote:
> > > The legacy SOCK_OPS guards some hooks with a per-socket flag,
> > > tp->bpf_sock_ops_cb_flags.
> > >
> > > In contrast, bpf_tcp_ops was initially designed without per-socket
> > > flags so that users can simply define only the callbacks they need.
> > >
> > > However, it turned out that even attaching a bpf_tcp_ops with a NULL
> > > callback incurs measurable overhead in the fast path. [0]
> > >
> > > We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> > > 1 bit left for a new opt-in callback, while not all of the 7 existing
> > > opt-in hooks are in the fast path and really need a flag guard.
> > >
> > > Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> > > update it, both of which require sock_owned_by_me(sk):
> > >
> > >   * bpf_sock_ops_cb_flags_set()
> > >   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)
> >
> > Can we return -EINVAL from these when used with sock_ops?
> 
> bpf_sock_ops_cb_flags_set() is not allowed for bpf_tcp_ops,
> so we could add a check in bpf_setsockopt() for bpf_tcp_ops
> to disallow TCP_BPF_SOCK_OPS_CB_FLAGS.
> 
> But not all of bpf_tcp_ops hooks are opt-in, so we cannot prevent
> attaching bpf_tcp_ops to SOCK_OPS-enabled sockets.
> 
> 
> > If we keep one flag we can presumably put both tcp_call_bpf_Xarg and
> > bpf_tcp_ops_call under the same if conditional?

[..]
 
> I assuemd we will use the new flag only for bpf_tcp_ops and will no
> longer add a new bit to the sock_ops flag and fainlly we can deprecate
> it under a Kconfig like CONFIG_BPF_LEGACY_SOCK_OPS.

Don't think CONFIG_LEGACY is happening :-D I might be overthinking it..
Realistically, maybe something like bubbling up cgroup_bpf_enabled(sock_ops)
is an option as well? So these (old) runtime checks are happening only when
we have sock_ops attached (and/or separate mechanism for struct_ops?). 
But if you don't see anything wrong in your benchmark, let's not overcomplicate.
