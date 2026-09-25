Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A44C4F6C
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357646; cv=pass; b=btNA3EHLBBcLVNsQBffXITBZlnZmixnoAQWpTMgUXrcoE4CEFpumPZsSLthYfOPMRR2H9CO4mkc/GJ6NvqDg+AN8BFOO/u4um1Kq8myTEgheuXANPhjvUH90oiUcKlsZzumfbOQfnhxBf/Jk+bvhVg1Fms6aW7Fxw+nSH4sxfcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357646; c=relaxed/simple;
	bh=mQdnL9HsYodgPW9uFVatJWvbArhVGUHBOsTYFjgu3oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN5mcp634eJJavafys0PgHdfbWySH6ndgxoTl544wjRD5ISnw5dx9AZ/xd9D4YZ6UXr+UtnDTvbRa2Lro3CN/xIsrZaEfgjqqSZNwIS/eNTvJTv8o+ARpCYy0lfS5nl/PXSw6w1g7ztk9RFoXJoKjKxFj4Wef0TQPjeGfZarbQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/ckpnlW; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/ckpnlW"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c206dc8b0dso948342b6e.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 10:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790357643; cv=none;
        d=google.com; s=arc-20260327;
        b=IBoEJYvdXCgak5A916YYzeYO5ugO27WPuJ3mSaxbrMKojAuosdKbY43rDKrYOoA98R
         WBj8HqSTtolcQT85FqXNiu234mHGX+bUV9yngwGNwEY+8W54tDOrTGUSJNVO1eMAVsAf
         wYytA8l6mO7I+vsjxcUlYuZBFGHdgQ+uo4hxJUkx2KmLupbV8kLc0Id6dhgOvT9VYW8q
         tj63e5KOAMEN3qLGRKX38NtsIImyX/IuUyf4A/44CQgAEGBvHTXQ1zeuWmL5rvlYZP+B
         xF67O4YgSjhyVjp9V8BwZTsSER7qOTegRVly8dz0rKaVxWLiv+yrL/nkxsgJWiVB/J83
         xgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N7CM5MKPS1617cb6aVjlWe3PLLcimRFckPzGRxTHdUg=;
        fh=u4XtEOlXPmCDEQHVyvB9VeBuG+lhMUSjxbp9mzsRDZQ=;
        b=iT9mKkJo0dFcvYtU3zegxbpFt3IWYq6vWKinKWboKhuZYT+cttebUbXxNxwRT8QOrx
         jQcu1PS9FoZOMSXPBpug4QuuBhh985QZ+tLrNEuO2LHsCkNMNPXINH4LCM2CNDGHwzS+
         hP7MUVP5A92GTMpkhqDosw753sFFhh/VrVY1rV1E60562HpLBqtUNa7xogG1n1mWfLd5
         Cp9r1uCNWmnX3OwZuR5+wC0l2Yx9AGbqc1xJxTynBbHnIK+x/NiEjEopzJ1ffIiWvMKI
         dGQ8tOLHrOwlrpKdUHEA3K6uYy632Y7Vz2HJEb71xPhUWcANR6oqCm6TYb66m1kvOrMc
         jhzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790357643; x=1790962443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N7CM5MKPS1617cb6aVjlWe3PLLcimRFckPzGRxTHdUg=;
        b=F/ckpnlWO4XRZZ8EydSk4aCsKkhrRv/F2NqWzYdfma6eJUYprgYyF18WRvBQ1rKBO1
         Lt9j8oVe6ATxh9+/aaM8CHT0PdZ0U9AMP/gsYO4NuyldkflNm0Gnltwx+Jur5lBVNGmP
         9xhBqipd5KoBYWzPDWUR3WeYI2XYQQzdwX24Nq4HRpElmsLd1I0zC6JvLtur0XMtQBUU
         gmGg+qQE54oMOyvvz/1tHxydTSHwFD3VWveWRvXCPbe3Z73YjQREa5WaZmX8CnxC6LVH
         pJKQ+QGxomaY6nNhxzN5KQfEdRFACyns0L5fYkfeK78ykCwIX60+LttXDUFF1dG/f7sf
         oSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790357643; x=1790962443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7CM5MKPS1617cb6aVjlWe3PLLcimRFckPzGRxTHdUg=;
        b=cyxFoq4SkWigeGmMzO+46+s12WCfkrC51p4QP02MfqEH244ybX1r1VaqEQ/elvt2El
         ZIWifM4AF8bWxhNaOg2Yg03dIrQPE4ppr4wkfo4124w3yLGhp+X9fRAf55G8CJWpU2OS
         /C6Y1Pp4gNgjBi9kIpFmaZDoyXTKAbs78lVF6Kp9WORBHoFXrCBDP+nIK3RrQ3TcZznn
         FtOFVWxcctfOSC9kZlBCNXH3GwFGiB5LbLuVy476Yftsyko3cnvyLs9gRkIp/ubWzPXn
         2cJgQTo8kRs+R67rqXSN6nOqnLusv7bGGdq3i1VVFro5XKrJGIEJgmtjuqPxZ6St8d5o
         Op5A==
X-Forwarded-Encrypted: i=1; AKwUvBzLoKSus36Q6sSG73i/FtezeRnVcv08ocvHq+K876qmpOg7rExS8YqaibgNaSM9tRAXO4c=@vger.kernel.org
X-Gm-Message-State: AFuF++mycuExkZBl4a4pFKp2Sqg1HK7WzYma0LLQ7TrI1FJrIAweEfJX
	GWMe+Rtd9hl2q3COIkbf/IsE0VUEeirBRhjk1eCurb+9picu3ra0ro090UhRGA7N2ngtFw0Pel4
	lK0jLfwqTSWRulxOz6F0sXl6iPUFO7zc=
X-Gm-Gg: AYBFou2SSWhbpo65qbZcJ25gOHROZIvLiBWUL3+Laz/GfIhU9UM60Nl6Xnbf1zmJsl8
	xs9RqqwzCuygQLV1LmGnQYZXIlN0niUTGdh0iEYm9+ZEHpnBE9uoZSh3Am27d3aa0mhvT9ddaUG
	AqbAzQctv8MsfZVJm4I+wOWj4kqI9rJyQ7R5qN4dk8LHzmZ9Uau0qC2uB5pTaQPv915C/aKAW8s
	FYzZ6uKeEYHca85FYf03GjqO/Jn0GYfgU8rzq+3TzVcDDpAS/7k3FDibmFhhEgEdvBjUagzedhl
	vqKz/jFq4JQ1ctKCHjbFyhvS0LzPJzK3B1z26og7b4BBPuT7lfe/tBXB79bP2x2TcA==
X-Received: by 2002:a05:6808:30aa:b0:4c6:eddf:ca6f with SMTP id
 5614622812f47-4d728922debmr8500114b6e.12.1790357643082; Fri, 25 Sep 2026
 10:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-4-kuniyu@google.com>
 <DLNYI40PF2Q3.1KYC8MHZU2VJ@gmail.com> <CAAVpQUBGSahLGEqGQCD2_0Ro2e-=59W7mhVyxOnoFU==LAK9tw@mail.gmail.com>
 <DLO0KBIOE5JY.3DY4JTZOWT5IU@gmail.com>
In-Reply-To: <DLO0KBIOE5JY.3DY4JTZOWT5IU@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 25 Sep 2026 10:33:50 -0700
X-Gm-Features: AclHuK-sff44s794tgsAcngyJnbbpblhhK2X94GJjlaw8Y4g9ipYLVjR2x_AJcU
Message-ID: <CAMB2axN93iJnrZAk6hWraSnz32FtRDdpz_UbzsVB4YU7gRK_3Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 6:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 24, 2026 at 05:39 PM Kuniyuki Iwashima <kuniyu@google.com> wr=
ote:
> >> can we drop the flag ?
> >> hdr_opt_len() is called for every tx skb without per-socket opt-in.
> >
> > Oh, I assumed bpf_tcp_ops keeps the same behaviour.
>
> bpf_tcp_ops were moved out of BPF_SOCK_OPS_TEST_FLAG() guards on
> purpose. None of the existing members has per-socket opt-in.
> hdr_opt_len() runs for every tx skb, rtt() for every rtt sample.
> See the log of commit 3bb54768fe3e
> ("bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops"):
> "A per-member/per-cgroup gate could be added later if the extra
> fast-path work proves measurable."
>
> > We have a bpf prog to turn the hook on (from cgroup_skb/ingress),
> > only when ingress rate exceeds the allocated capacity, to signal that
> > via a custom TCP option and turn the hook off from the hook itself.
> > (and I planned to post another patch for that)
>
> That should work today without another patch and without the flag.
> cgroup_skb/ingress prog does
>   bpf_sk_storage_get(&map, sk, 0, BPF_SK_STORAGE_GET_F_CREATE);
> when the rate is exceeded. hdr_opt_len() and write_hdr_opt() do
>   bpf_sk_storage_get(&map, sk, 0, 0);
> and return when it's NULL. write_hdr_opt() calls
> bpf_sk_storage_delete() after the option went out.
> cg_skb_func_proto() has both helpers and get_func_proto() in
> bpf_tcp_ops.c allows them in every member.
> egress_read_sock_fields() in test_sock_fields.c does the cgroup_skb
> part.
>
> > Anyway, is it because calling bpf prog is not very expensive
> > or per-prog switch is preferable to per-socket flag ?
>
> The switch is still per socket. It's sk_storage instead of a bit in
> tcp_sock, so every prog has its own.
>
> While such new flag is per socket, but it's one for all progs.
>
> And you want to take the last bit of u8 bpf_sock_ops_cb_flags...
>
> As far as the cost. A socket that didn't opt in pays for an indirect
> call into the prog and for bpf_sk_storage_get() that finds nothing,
> but only in cgroups where bpf_tcp_ops with enqueue_rcvq is attached.
> The members that are not set are NULL and bpf_tcp_ops_call() skips
> them. That's what hdr_opt_len() costs on tx.
>
> I don't remember what Amery measured, but worth benchmarking
> for your case.

I did not benchmark the initial bpf_tcp_ops patch set, so per-socket
gating was deferred. Before deciding whether to add such a gate for
AutoLOWAT, could we compare:

1. No bpf_tcp_ops attached.
2. No-op enqueue_rcvq() and dequeue_rcvq() callbacks attached.
3. The same callbacks performing an sk-local-storage lookup (or maybe
rhashtable).

>
> >> The prog in patch 8 already returns when the socket has no
> >> sk_storage.
> >
> > Yes, but this is only for bpf verifier.
>
> tcp_init_autolowat_cb() can be the only place that passes
> BPF_SK_STORAGE_GET_F_CREATE.
> So for a socket that didn't do setsockopt(BPF_TCP_AUTOLOWAT)
> other cbs will return NULL on lookup.
>
> tcp_disable_autolowat() will do:
>   bpf_sk_storage_delete(&tcp_autolowat_map, sk);
>   bpf_tcp_ops_set_rcvlowat(sk, 1);
>
> > Just an idea, would it make sense to add a kfunc to move bpf_tcp_ops
> > callback to a shadow pointer by allocating sizeof(bpf_tcp_ops) * 2 ?

A bpf_tcp_ops instance is shared by all sockets, so this would not
provide per-socket gating. Making it per-socket would require copying
the callback table for every tcp_sock, which seems more complex than
adding a gate directly to tcp_sock.

Am I understanding your idea correctly?

>
> Doesn't look right to me.
>
> Amery,
> please share your thoughts here.
>
