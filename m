Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703872DB78C
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247918; cv=pass; b=mZxBvUpoYs/M8hGyHTpgwFPqropIwkl6LiIa1VqooKBNGwM5ydmd07ZVUI2dgTskV4hu0UvF0Q8W6YzMSWsSwtlsbQ95Hn6iaVPyo6XhYRyOJ7Mx3P7zPMBKO9Xqyqq5epiZT8pz7joe5ewl6S5oXdSDm5T4VoGAnfJiOB7QnbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247918; c=relaxed/simple;
	bh=+Qls2skSc/3vmZca9FbusO2tssEcMmdJgi9u1ZaRRZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCBVf0tvCYD2ujze99+hJeFBgAFtkRiurvxpL620JoXyCFbfNZMkdbO3vFsnFrwHehP3CIagM4UHfURxHOasX0XEjtfwEyBnrRSh6Yiy20wnZJoY9uO8Vq6jqlg9YJJYKubbZLq6dH70ykUJT0xQf0apdTyirFs1LmNgmP6TjfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxm54qHQ; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxm54qHQ"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-138129a622dso1227143c88.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 00:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247916; cv=none;
        d=google.com; s=arc-20240605;
        b=Fi36j9OuTJGGZUFQ7SpHV4aVCOf4qrOpc9+H+9sKYH60Qc058JINtbNNxL7qtljNtc
         QKHvAkZTD05oNP2N9XMGAfKhqFnHRzqyLe4JuixOFlBb5t/rUR/a4ZNyEOg5avQCHr8E
         4euCx2fQmhdk1IPgPbLJdhaWz9UrSaXgY5ePMHEoYSIh66SBzQfHPD5+pfL0LLHtWFsP
         8F4yGEOgM+vf93ei832yFEvViFXpx/nPKQMxB8ajf2KWBxuO4yU/72ffwc7FsUWtueF6
         VIVzpTwP321SpD+i5L8vA9WN1qd2Tg5gQUG2wArtX3MRzF55dyR4zlhnS6WERSKQOHS0
         43iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ySAFFGZVCImVoCKxPs5cex2u/fdf51xmls8xn6ywiMk=;
        fh=Hk+c7LaTgtQdrrU1wgp5rjyS6qTWSh/h1KQ+WVa2Ass=;
        b=U0JemZ3MxmCMN362afdvTf4ARA718K7O8rztrXRfCxOZXyTgrboHK1m3eQWOk+X89Y
         r6jrQw59t60vrWPyToKIKpLzft6zrJVYvu0nrJlWIOEnStpJYUAQiad4QxrjvmCzgYMC
         iMAG+QbFyK8C1uR+kreMwZTqDkzHMAb4QTq3sJVzvB5I4GVT7dcYHCFZ+Dnt8e1k/lqf
         zYwNoshjHj4Mxjgt+8YiAq3U/Uy5advTWKHI19LeWGmobaVvq0nOe1Y+72dLTNmVcw+D
         eVPkizt2HJZousDIr0wMBM4XHQm/54BgC2TiZl89z/1APsJ3WZHFW2GYwBCmv0sWkiTw
         7Jbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247916; x=1781852716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySAFFGZVCImVoCKxPs5cex2u/fdf51xmls8xn6ywiMk=;
        b=bxm54qHQ7BEliOa27UeqSlYEiTrVztCM2OfOnFapoIrqPcFceUHBInvR1IRqJAQgG+
         pYP0ks/dz5gQXQcOE/UHtNavFcMcH69TezmZVqPpJkdWZ2hAMoRYb04q9/9auCDeNPpR
         UUaociiZ7oTP3E6+wR3zd7WypUUsMdR4GDgMvFqOMQ9HQUfSwCBfVANgATihoiCl8sxC
         Zalov4LTNuAh7q0M1vN9WXWdDQ8U3lSq/xu3dsaCiPi/lNfafnrI1pkoTVkzyYMch5tp
         aygAs8K3XoBVGhtZVsqlmloibyR1bAXlaG1T4gPk6E7E0GQKKITTSiEgt430HV9md0OC
         dNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247916; x=1781852716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ySAFFGZVCImVoCKxPs5cex2u/fdf51xmls8xn6ywiMk=;
        b=N1uP029vfE8/i795cpvX9k7SEBZ7cTGzOgAS8KxiIFSyZ1ZWE2VINncQgyhfgWbEz7
         KRbHkCQeu4kJxtQ2OpDAxRU1wP5YJu2WGY6nbusF4YKHHU+UZV6NvWawxWIuT3g7Cl/9
         qcuCgqX/TJhVOmYaHZcIMs7l7ti1ukDlxAu5Y7Dv2deLzpK75F4Vtzoe42yQwnxUf7Cj
         U/yTY70WN2Ttd4jgUTazjnZtmgu1e9LKLmVMxBkI79uG0zEh4nLCP5u0ikV+yBScY5VW
         EOA6QcSP9E9ql3ywHmZxfExhArhPnKrzrFwIk0SHhQ0dYtzys8Yp8OYbunQv5Uq0kw5y
         tQYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/jz3cHSVru+WsqURIiPt+fPmfcuR/Q/4ha7bZRsAv/TsVoYw+PmTV0R88I4LpFvXdNAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9zYtqcDFyoj4Tpe72hKUBOiB+sMGunezE9mOhlaoepf/uqyA8
	f2VS4z9s79OCMewtqeAHCUkrYjrHQ3IdO4tYD9bh+c3BOKCQNRK6jzLo0t/e+7TmkJXCj1rWuSP
	/66r/lmmJtEbVvPkSOm6MD5fS62v8yfbWW+dQXWXY
X-Gm-Gg: Acq92OEaj0k1tvgMIWBWHosUZczroTsGT1f9DjcLNpthM1x3tHyFMojnC1BXHIzHm7i
	6OGfx9DepBomvbtB/YFeXk97gFIgApMrIqWrQCtnPYe642B0IZhiI6savf5nvc504nj3ETM7Sks
	cIgk6c0whRCuEsEtr4k3hlh17lp4QlhdZ9GoaP6+5KqmXWEVlTZbh1pHm0RZheAnIkKvG/V6piZ
	a4ZREcj1SZyucwj54obSI9ti02pkZ0yiZri8VfYX+f43Cxq4vNnKiyN8GmTPYtBU4rkpEFbG1fa
	GBNYvO9vvenESnvMrzMXdwGYYjLgtj/Oz39xut6GbKC31NG7+tjCeOFDPJIQnaXTXHoeoepd0Oq
	wztMHUkVw60dqmRkD2cf40pNU/onnfdF9CwD07FOPAeTmbFXk/iVy
X-Received: by 2002:a05:7022:f82:b0:12d:d972:b96e with SMTP id
 a92af1059eb24-1384bba8b3amr736453c88.20.1781247915492; Fri, 12 Jun 2026
 00:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 00:05:03 -0700
X-Gm-Features: AVVi8Ccmokh-rVUbp9NLMiWL4MP-Zle5S0yShB9T0PhjR4_ZLN2X0FgYOQboXjs
Message-ID: <CAAVpQUBL1pFxgVtNjM=YcWuE7YfvBpUf65WBpUBzjVZJgz=hTw@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: clear sock_ops cb flags before force-closing
 a child socket
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 2:29=E2=80=AFAM Sechang Lim <rhkrqnwk98@gmail.com> =
wrote:
>
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
>
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state(=
)
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me()=
:
>
>   WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
>   RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
>   Call Trace:
>    <IRQ>
>    tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
>    tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
>    tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
>    tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
>    </IRQ>
>
> The child is freed before it is ever established, so it should run no
> sock_ops callback. Clear its cb flags in inet_csk_prepare_for_destroy_soc=
k(),
> the common point for the IPv4, IPv6 and chtls forced-close paths and for =
the
> MPTCP ->syn_recv_sock() failure path (dispose_child), which reaches tcp_d=
one()
> on a child that was never established too.
>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
