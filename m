Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDE49F115
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066401; cv=pass; b=TunmAwT4+lhO8kjUWhuFHcnEcaPhInsUahKaC9EOCdYmCvS5MNi3V+PFrwZubO1mmMPsAuQGRg4axbMmboCCNz2MINGbqAJvSjRR4WGMg0zWaA9NFRa7/w50uosH773VdSwJjMhMx4WNkdYw9Y87T4lZkPNjVP2dGOpzLfbnh5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066401; c=relaxed/simple;
	bh=PfWD4VpdWtdSjVgCMYbGy7PflI7LLghvMi+QrsP2eAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1d8PiRfhZwNoVWrYncit1QMC7ffX8RV6SmKFvTiNVKRH8mWZbdOv1ijZC/c3xZY7KKlZthImW/mM+KTWrRZJ0IZO+09lYas7gAOE11ksLzcDvH7zzNLaciI8xMMHWuL6Z5IizWNUn2bllmq9A02ZjumWTz8w0nV/4qmrPJ1w9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFUv0rFw; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFUv0rFw"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bce4e278baso2236485e87.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 05:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792066397; cv=none;
        d=google.com; s=arc-20260327;
        b=oy9IzZ/EtidP2JlHw48HqH1N8oqgA3RbCuUE1cXbp7i1ijCcaMLLdwW252g5Ce1V9V
         4GhPbVpzSZyVJZwkLKKYBbo50GWcekt4ZZHKyc4pJl3MCyTrEoLPh1QD/JHSfeHi0c2s
         2wScfh0gKfLnzAzlw+wjpUFR4Is++axIe5P0NT+U1Eqt0JSrY19MTrawSbhNyz/MX3+g
         X2SBdrbUf43W8gFHWKXbhmUgiwsS+fqZqzpPcqOlC0LQBsfSwbgNLwgJgky2tGoaYXRp
         fxoK9UzVZPe4YeWTne2d59NaexiXpmulNlqjTWHoHjLvky8wy6+wZAgEbN7FeyQBQwLO
         M+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PfWD4VpdWtdSjVgCMYbGy7PflI7LLghvMi+QrsP2eAY=;
        fh=TayetCvcaDXmxJG2x9i9YB3l/qJqbUtwcHfPAADHtX0=;
        b=LEF8vtjF4uabGrM/rpEUD4oWumXvvTNL6B/K1xPmpMALQRdFV+DGtGNgXpodmom9OU
         CbUnjJoBZMyYeBw4fdf9bEajIkbhAyCLfCPPHScd02rzq89BPvxV6/0KrMkfQ49Vvbk8
         Eq/VUqO5ShKqhlneyDXdUdmSo6kSc+u1OWCbn2xNXzcZqXws63hs/3c+yymDY7IFD0gr
         +++8BxZE8o+1iw+bXDrGUKgFFpq+BmGhVxwG/gLs08SIpjc1eD/LMObc1vSLEGZnn5W2
         pPv9whZCxFce2Xvdv8h+dLvuZmNAK1xc1Ty+Y9Tc2Pxn7geI/4HU8JJk0ZeAiBZeUX4M
         vjMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792066397; x=1792671197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PfWD4VpdWtdSjVgCMYbGy7PflI7LLghvMi+QrsP2eAY=;
        b=MFUv0rFwkY46TMBt7X8wNlMgYfH2YjM20arVDogzgWTSRu/Y6LyM+DTrbXsuUU4IIM
         KMefd9j1ptRsfqlo0pBgpWwYnuwS7fgCGXKEckghBS+1MbY5V0k43XFCPQfNBRIo7rqn
         7ogA4wk4yI3JLiTiW/wgvj+yXuLzs7al5YO7pu1bm4MGoB+M3Ehh8qJsKATWAJkHuduv
         PK7Sw7a+CUJ3u0rQgaaMXwZoRqciyvgFJdV9v6dr96LtRVBOr1510olmTRyInjU3Gj5i
         ycB+cHUT0QzW4clXhHZ1Tr619ClxvRi78UB0NIs+BHrDyy9A1FwE0I9Iucm1YJ3qhBiM
         Q9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066397; x=1792671197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PfWD4VpdWtdSjVgCMYbGy7PflI7LLghvMi+QrsP2eAY=;
        b=DnewXG6ayhdecSPomgO5zHLiBEoXWY9zEb9pFVuM9rkTJEQvZeYcgryxwPhPyC395v
         x0dappxVyVbU045TXCLLrV3ieULWq+wgU+GUuSo8/emnbFO5NaXfhhjkTVRRt9rhD0JA
         CKjFojnTf7V0+fdJHKS7FI4pv3q0Tlpj7ArBCHO82m4hHxTeC475mhCiY/lkaBrLYMRv
         MVSJFWk5iSPz6IS/71ACz8z+X1Vu5R6plhL4A/uCADwZBV9BWBuAq5i1o+sShV6Frupe
         Oh8Xrv4Zk+3qtnbQ5aZUZz8DdhriO02/2n/RQF5HuDllCFkryTW3sdDmcKs5BuF5hwSI
         /j+A==
X-Forwarded-Encrypted: i=1; AKwUvBzDeW6hGBO8kMly5oxs5jNDw8UT0FDysiG0wjpT3llcIqxcN6Xw3WtzO/Se32XPMjm/w5g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv2lyQb3KO1gNj0jupxr3f+QjW1AOEnAt+HxxKuMR9arjElbnX
	YvDtvnDhC1VulPCcHtzjcueAKEZGu9rfFpRRuw+oNY2ehr4ysYlAMRWyq5jy0LwkyXt+XMCfwXJ
	smQJ205Ib80nuHvaV1FNGSN86b1ijKeU=
X-Gm-Gg: AYBFou2RqZJlxnqWunXnHg0E5uSK7qclT+2ztIJFmBZIedNJ2EqCZKgY2VyznbqWTMJ
	jVPrjA+YsVzpAAnR+Qb9YjTlX8ZuJQSnbgTZVjqxcbBaXs+pIPOqUb/n38vsKQeU8XE51WlyOY+
	m0onnBEVHnoPBpwEbO5RKZFyjHxO+jH+F1RXwIpGU4t1ry223PaD3NRqkbyJF/Bx0ZiE21miHaY
	onnIbJgTkz17e4HbT2FKvGvOHAvD9UbP10MUW/5q5TvuUwhIWm0DIunwarPSTmJb9wUTYRXVD2a
	VLuF24EliD1at1kf1oksrSz55z04cCKdj4/DDgraag/8YMFA0AHDcMP/scnevp/LoWn7F5qsSOJ
	1zueIALmwpL8roqmJeLy/urfgLDcnoI9wE81J6RtUchE6xhrmtM+5eR+uMRPqC39f1FDRDA==
X-Received: by 2002:a05:6512:b1c:b0:5b8:e9cf:daa6 with SMTP id
 2adb3069b0e04-5bcdd4f080cmr6853474e87.10.1792066396625; Thu, 15 Oct 2026
 05:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013103906.2660384-1-wferguson@cloudflare.com>
 <20261013103906.2660384-3-wferguson@cloudflare.com> <877bjk893u.fsf@cloudflare.com>
In-Reply-To: <877bjk893u.fsf@cloudflare.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 15 Oct 2026 20:12:39 +0800
X-Gm-Features: AclHuK9xypnzrrqwCcprd2CwQO7kzSIQ141D-bgf0CuqS7x-S8jo7RzifyoP-go
Message-ID: <CAL+tcoBjfDEVGvvSXZHkiMjq5jat+5OJE-7uJr3MvtFyzn+KUg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 2/4] tcp: add BPF_SOCK_OPS_TCP_TS_ID_CB to
 assign a TSval identifier
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem Ferguson <wferguson@cloudflare.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:51=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Tue, Oct 13, 2026 at 10:39 AM GMT, Willem Ferguson wrote:
> > Let a sock_ops program pick the identifier that the previous patch
> > encodes in the low bits of TSval, for passively opened connections.
> >
> > The width is set per network namespace by the new tcp_ts_id_bits sysctl
> > (0 to 8, default 0). A listener opts in by setting
> > BPF_SOCK_OPS_TCP_TS_ID_CB_FLAG, typically from BPF_SOCK_OPS_TCP_LISTEN_=
CB.
> > tcp_conn_request() then runs BPF_SOCK_OPS_TCP_TS_ID_CB once the request
> > socket exists and before the SYN-ACK is built, so the SYN-ACK already
> > carries the identifier. The program sees the request socket, the SYN
> > (bpf_load_hdr_opt() works on it) and the available width in args[1]. A
> > reply that fits in that width is stored with the width in the request
> > socket and is inherited by the child, including Fast Open children; any
> > other reply leaves the connection unencoded.
> >
> > The callback is not run for SYN cookies, which have nowhere to keep the
> > identifier, or when the peer did not negotiate timestamps. It is skippe=
d
> > for connections using microsecond timestamps and while the sysctl is 0.
> > The width is captured per connection, so changing the sysctl does not
> > affect existing connections.
> >
> > New /proc/net/netstat counters report how often an identifier was
> > assigned, declined by the program or skipped. TCPTSIdEchoMismatch count=
s
> > third ACKs whose TSecr no longer carries the identifier, which shows th=
e
> > echo was rewritten in flight.
> >
> > BPF_SOCK_OPS_ALL_CB_FLAGS grows from 0x7f to 0xff. The tcpbpf selftest
> > used 0x80 as an example of an unsupported flag, so move it to 0x100.
> >
> > Encoding makes the timestamp clock appear 2^bits times faster to the
> > peer. That shrinks the real-time span of the peer's PAWS window, and
> > peers that keep ts_recent for the RFC 7323 24 days stall connections
> > idle for longer than 24.8/2^bits days. ip-sysctl.rst documents both,
> > along with the lack of TCP_REPAIR support.
> >
> > Signed-off-by: Willem Ferguson <wferguson@cloudflare.com>
> > ---
>
> I think SOCK_OPS are considered legacy.
> We probably want bpf_tcp_ops struct_ops.
> See [1] for an example.
>
> [1] https://lore.kernel.org/all/20261006192601.1875100-11-kuniyu@google.c=
om/
>

Exactly!

Thanks,
Jason
