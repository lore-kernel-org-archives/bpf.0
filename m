Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEAC3590A9
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994665; cv=pass; b=NbvFTlQyC5K87WGOLmdAqcjZiin5SrL+JrgaoY1smiuXvLuxFezLu7TrmCOW6gcFaRFS+2WpoRSpcwJiyn5IzWbFR0MKFPVVv13pL4JxOUntIf4HOrArc9JYPzOClWM4I2LAG/Aq5NYZu9TAeMlaVCDOjGbsSTtT172Cug0YA/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994665; c=relaxed/simple;
	bh=KXz8Z1YsAvBqjHVB5QBXZKVYV6oF9RS44FiMgG7zIIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCZntFlxhlzfZOPTjSOnSnMCbdTUpbBPyCFLC8WLi/huAMs1qcSleVNZmLakBiVnwG1/IDJYKpB37/+Jp3uLXLfQzI9KpHJ+ulWIG/sjiB/tlJOE78mWYn3CCegEWn3TzPg2N2dzs4e99ej4hR+57WxNqO3SvVQVxblszAEHAMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HM6ab7h1; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HM6ab7h1"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12776bebe9fso2116565c88.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774994662; cv=none;
        d=google.com; s=arc-20240605;
        b=I9vMFh7ZCodhOXW0rPGcgE7+40AVOoAqviDfKJqjnKrM89G35NbJvARGmCDGn4FYOk
         tcLGfJw8/BOkxvTpyniFavW856oZXh/S6u53EHBPXbdd1fP3MbBOeiltgdiaqEzZ4QP/
         cVFYvSXc7IVaFIjAchtGGDXbWnxqTnHd5KDLmijuwCtzHXk5y5Q7ssv9QDm2YMcLUoCy
         8hEUUk48MOZ3wB+trDzRb7sF5FEED24DfKYofhHCepvjGlVGuuHtdoOXBgks53OSt6I6
         oC2XfXYpYq7dGNrukweg91e1qpheZD5Ij4YI4V2V1mctsmfK/8oQfb2UG96GI0VJjjeB
         8f2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r4kc3eBNKApVvBhR0MrUdh/NwLBBmhES3WTvFsU9iGI=;
        fh=l2huh44s0HXq8QSWtSs9axHfMXtT5maiwLtudaepxN0=;
        b=GRTZ+rrDHoE0XyD+PKzA6BX3E44DbKKd34KKQX33/bNjeHU71Z2u6Z462Sr+kWs2aV
         aj6i1TpqQDYEFdFkJuWpU8kyTFybHmkcpxH3Odgn9uLAzZV3v5VaKKDjHqktzyoAwl+/
         uJlL2dL2rPmZJr7CE/b6UbpQaC0jkXMLuALtcendbhUYc6ZyQYAG6wBdRQEQlwqRZqgr
         xlC4R1Azv/SFze/SQVL3XJJEuArMI8bRwJhbVpDR54W3uZ5jJniW7EfuIA+p6fc7GYwq
         O1w9f6HQefq/C0Bszb+PSSKyEdghbV83vacQJQC9/uhXWdRpvpvFIZ37QITNcCGLE32k
         ikVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774994662; x=1775599462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4kc3eBNKApVvBhR0MrUdh/NwLBBmhES3WTvFsU9iGI=;
        b=HM6ab7h1ilYQVfb/3UM4pRXH1ZputZepe+FLPcABlQtMy83+hm5vnj4MOLSP6EaR6u
         t92P5IAkgNgly2CBF3mrNzm39DAeZtC3fiL9SZ+Fa8tU7RbB8vxqySEQWqTgk/n5QG+h
         Ikzfa1+kZMkqLf+fO/3kC4aSAS6dNCawWSzQMrwswnQLFEjpjk/WyhT8HfOZnH+2biVC
         V+Lt7BxvoXcwQJXM9deBF75sJLTo5KVsOINRt62RB/DbqbOxgTfavY2V4OlMXvGmkGop
         qxBhvfEaN+mAU+EHemXchi+Q1vw0USBuh0pZ44o9JsV/I3tdaHPZv8QbzqUSYsvWlmUZ
         PXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774994662; x=1775599462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4kc3eBNKApVvBhR0MrUdh/NwLBBmhES3WTvFsU9iGI=;
        b=GyTfuxOQkREfnfUW+ZOdV2yXvZBOx85aRy5fJ9JkGi5k5TzNTA9po7ETUu7dtA0sBy
         he5dsF5b7HtDkkwILkxTiXfRgxMTXKn1wO8yE6egH8eVnr570T+wKUABIVutGdSIe3hQ
         rOmEbesKTO29toxnxR+G3is70D2VzOc22Gr3F9uwO6c57xkZeto45nhxpBiVr7C3cKwO
         7K2qH04VXipkv6OhGEm+lrOvWroGbGH25Kjru7EHuoJSBOLH3PX839uz9hoLTQevlAed
         yHzQO4+UOWS/fC/IAMjE6i+Q112BAGvwDR1B5iwLnDWNwORxIvLbBHBBaiZyXnBK9fhy
         xEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAsRu7nSSmZJg0fN6JhcF5Re+oCjU7fsERmNnTdxHc/ApXoK2sfScGmhRgwkF2MGgSJqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydr4f4Dblj4EyBN3GyzRiU65GC408PlAI+zAtV0bkyG+bSX5Oo
	nWtaEW8As3/eiunlF98dQg3TIr/lQKop4K0pi1Rv8mFKcUSCD/OPe4z+Za/aTMO8M6Wnbsk6bp3
	rmtGV33w3tntMpFowGVD6dIwJd/1WjpFgOVEWk8Lp
X-Gm-Gg: ATEYQzxuxMs5P3l0M/SXzE1Cu3y3MZF5IFn2B0dr6MYRZr6j0SclQj80m4dzCr5qVtr
	251NzzE+HwWXr/8WQBso7FCDUC4UbSz4ySnpKjg+0If0UihdEjShHPhgw1qlz/AY67RPXYhUrGZ
	pwLNvwn3ocfelMe8yo+zx1/ByfvCtrr3wLTaCm0Vv3oCrnyCbizWpfkess5m7FZo8r9WwxrOs70
	9kYhJiRFbS+82vmGeqkh+DudPIqtKl11X7v42/IzU3cudsCAI3ZUlnANdSp02kILLmASNZSfaIx
	RYAwYjJDnqlPgo1SUWkIvta4q0v2DztnayUYgMaMJUGiqhvg4Lge4W3XvZl7Kpc43jzB0g==
X-Received: by 2002:a05:7022:684:b0:123:2c98:f65d with SMTP id
 a92af1059eb24-12be6437dd6mr762968c88.13.1774994661813; Tue, 31 Mar 2026
 15:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330080746.319680-2-jiayuan.chen@linux.dev>
 <6ee24770a2b014219d86839b2243e1b7bad4dc4f520457269d5e8ca2b21c2cb8@mail.kernel.org>
 <d1a739d2-c4ea-4fae-aeaf-f49e75dac0f3@linux.dev> <CAAVpQUD1n7L6LkP32H_Ct71RLNpJ2RQWFc8w08+c8h=U_tDjpQ@mail.gmail.com>
 <79805496-9996-40b6-8cbf-0beaf7dd5473@linux.dev>
In-Reply-To: <79805496-9996-40b6-8cbf-0beaf7dd5473@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 31 Mar 2026 15:04:09 -0700
X-Gm-Features: AQROBzAQ8y8qSCQrKpuNkixRyfIBAjxtkwpMokHCZ1Bvt_oQRokJ_pel-hcekD4
Message-ID: <CAAVpQUBbAQO8rSE-WSS1M7kEcD_sQ_9zHTyJg-+v2FoVuHZ8Kw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bot+bpf-ci@kernel.org, bpf@vger.kernel.org, 
	clm@meta.com, daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	martin.lau@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 8:19=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 3/30/26 6:35 PM, Kuniyuki Iwashima wrote:
> > On Mon, Mar 30, 2026 at 2:26=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >>
> >>
> >> On 3/30/26 5:00 PM, bot+bpf-ci@kernel.org wrote:
> >>>> #if IS_BUILTIN(CONFIG_IPV6)
> >>>>       case htons(ETH_P_IPV6):
> >>>> +            if (ipv6_hdr(skb)->nexthdr !=3D IPPROTO_TCP)
> >>>> +                    return -EINVAL;
> >>>> +
> >>>>               ops =3D &tcp6_request_sock_ops;
> >>> For IPv6, ipv6_hdr(skb)->nexthdr gives the type of the header
> >>> immediately following the base IPv6 header. If extension headers
> >>> are present (hop-by-hop options, routing, etc.), nexthdr would be
> >>> the extension header type rather than IPPROTO_TCP, even when the
> >>> packet is a valid TCP segment.
> >>>
> >>> Would it be worth using ipv6_find_hdr() here, similar to
> >>> bpf_update_srh_state() in the same file, to walk past any extension
> >>> headers? The IPv4 check above is fine since ip_hdr(skb)->protocol
> >>> always identifies the transport protocol directly.
> >>>
> >>> In practice this is very unlikely to matter since TCP SYN packets
> >>> with IPv6 extension headers are essentially non-existent, but the
> >>> check as written would reject them.
> >>>
> >>>
> >>> ---
> >>> AI reviewed your patch. Please fix the bug or email reply why it's no=
t a bug.
> >>> See:https://github.com/kernel-patches/vmtest/blob/master/ci/claude/RE=
ADME.md
> >>>
> >>> CI run summary:https://github.com/kernel-patches/bpf/actions/runs/237=
35111188
> >>
> >>
> >> Thanks for the analysis.
> >>
> >> There are many places in the kernel that check nexthdr directly withou=
t
> >> walking extension headers.
> >>
> >> I'd prefer to keep it simple for now and leave ipv6_find_hdr() as a
> >> potential future improvement if needed.
> >
> > +1.
> >
> > Given this feature is to create a reqsk to process on this running
> > host, it does not make sense to support such ext options.
>
> While at header reading, does it need a pskb_may_pull() before reading?

Ah good point, now that we read skb->data, pskb_may_pull() is needed indeed=
.
