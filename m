Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793925209;
	b=mmobtIKwaO/s2zhWRKRCseufsSlgEStoF5EIi/4C3GRoMrmfF75BEdBmWIFpdh7nq+zE
	 4E5rqE5Cha88vPG04RtYnouepi2C58KXktElOqXU12Ndc07FbzX/44sMlK+n5TRfXybEb
	 FCcdXQ2THl6wh1EnMpEZ+J9WO2URXF86fzOXX48wp78IfUnyowOa/Zdsehzo6aKm10JY1
	 hpSNnKx+bAiZ3zHQx6+dYt6QawbOA/kEp6cIfWZ9XRceaP0KhocOl1GG9M02uotHfzB6z
	 EbbyIw6M1BsezSNvTI+X/nMmthn47Gt2DMjKppq+aLMYUA3m3Q4FdsC8d9Aj2NLlPyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SwtNDvLuC8dzEY+y1VuPyC8x8lvTjr4xeYCs0VMxuA0=;
	b=bl8+I7yocOCJ2B+Y1R0/dIQyjQBEM7GIJSQJPG2DBvovjjmj6qwpSxWkUAAcx6E6oMv0
	 vqUR6p++uF7PSglrnsXJSLJCP6NAu7KHIIZOF/53VChUDja3Q5O7TqWc8/KSCtGzIkhKj
	 hE4a6j4i7WmxkBnwUYV1lF2C7bdGL5B80TN3+PkawEWXb0yF+Vp00c0qHq6FewNqFEvKN
	 WpRS0fLNwokxUh0kxBGWdTU3R3t5Y9hthJgkL+AAvEpiSksEkR9Tacc2ukXQ2GgN43QGP
	 zYoFF5s61QdJK1q1mo/bLmsOlG2I36Sh3qKgFmGsRpgCFVUYHBWEnz/g+PvypzAiULA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ywu+sHfE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FCF606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 00:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76FCF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ywu+sHfE
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-54492d8a988so6751cf.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 16:33:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793925208; cv=none;
        d=google.com; s=arc-20260327;
        b=SMZLcsMOBEmBwjPOMPGCkncpiMHW5b3bdEUM0kzq8FWTg1NjoJavGQsEr16C+sODuc
         9wertVUasOqvL2QPEDQgPMnGjK7thgwKLRFHTJY53R4Hy4M2BuAv3sCQPpqCFu5O5UzO
         bieXj6dW5M6r+ym6h0HTQxQc2HLTHZSNvJH5kwc5z95jgv2OpJU54VcAt/WjSYjTJBff
         8SUKg789LYjMazq3iNupF/XJ1/rwsIji2IxrisKia0SUN8Ulp0AMAODm4BSiNHH4Lj7V
         Jw0JL66fQ+MaLDm8720aUZH/sRBiE9aUmNvCfpLomCFatmvBIXqKhkQjQzdlunlFY1IK
         EcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SwtNDvLuC8dzEY+y1VuPyC8x8lvTjr4xeYCs0VMxuA0=;
        fh=f0wD1zSoPgrkmRnm7QQbzBphONSEJ4UGLO3Oj53QgX0=;
        b=J0qbtbDYZjQJQ4KOdtfSKv7OiSbNVCzTbXXnjr7h+Ic45o0tEJs1jVhxf5T12D/b0E
         8gmjfrGUpMH1+5ww83C9ldh6Yp4Ic214JQszkXYpF14rLxufY+Pd99C9EPzPuhZaEQ6r
         RsTpHnlZs0Cm0AbQFyDhGjcSvu6v8qVpyd3/dTSKL1bFnjWYmgNtkBygMylItGvSvDaq
         59kf259SxHBmrA6+eJeh8K3/+Sn5nXNqNwVSL8OTFd/4IHV3v4+kx/SZ+4WL84KKh2DT
         Q97zFUaaf8v3mPS/c0sY/0hdK9MMbPFpihIBhv+pSEWZJWaJpomh6L3RnpH6E/7qUW99
         njug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925208; x=1794530008; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SwtNDvLuC8dzEY+y1VuPyC8x8lvTjr4xeYCs0VMxuA0=;
        b=Ywu+sHfEQDyswjTmGQokotF0uy7u7pCMR1FBPVPt/uNsbambe0jjQhrWBXTfquzB9N
         GZiNFD1lNrI+2ZdS1Tv/9mkxSh4zUclo/6ejLOo1qkntPK9yqrWWXXyXztvxwgcxo34P
         swCeIhL4ZNgjdIjw4H28L0g4fpaRDpvIgx+zfmvZiie+4msOl8OOKP5KfViJ3jVQpIee
         axQztJfZmKw5NBT3LA1Dzunq0a0wGb6S8okE4abdMKE60zQWa4351nRk4RjQCjKBY/TV
         8iO0zjweZMJabLuprxT9KX6flJRTA9R93M9WhgzMUf3ANqix4ArOKDfhKDBzVT8wAXGr
         9Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925208; x=1794530008;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwtNDvLuC8dzEY+y1VuPyC8x8lvTjr4xeYCs0VMxuA0=;
        b=d4PkBfoR/+IiZhx0u2CS6r2XE9phzoyvCv76gwtXTdjUctAf43gzKdEJpPeLRoGMfu
         KniBno6ecWOwVC3zTzVFCmOL1rNq+JBWMv/v0b32CexEo75cmr6iIBgox+YivDHYmJ4z
         yt2mlkRiekGJ8Vx/fVBR+iQ1Co3cwEl6oTbu3gV/Al43KaEhgRClyctoCTFi6RRSGmmy
         TpAxngdToyXcp1ur5DRlj5pem0S72U4DXbAqXBVw0deltuDorvJC3CPWMNJ7DwdWFUon
         NjZrsx/l/rIArObRrHv5BuGv3tAJxaYKQh+behPkbBSEJkMyWMUX6u6GFGQ1+evoGdOk
         iHHA==
X-Forwarded-Encrypted: i=1; AKwUvBwdnOS5a+jNUE2i/ewW2lfrJF5HKNC0E4Pf7yO0sKz0hSM5xYNN5rTpOkSGc9jmRJvD760=@vger.kernel.org
X-Gm-Message-State: APuU4Z8++uPL0oexUNt5g6paLxbHGHot3eH8JPUY6uc2/+sEDr+71mxK
	rdkrlgLSFfSuAr2V/IFHHGxFxCPoofHjyxXhMzWSahnvqMYOOkeM9Dn5WvOwyZ0cauDlNGR5M02
	2h4majVOGabdxpxexttsHcTbLS5IOfCPOajzFm4CNtzpnwoKk5VU66lYq
X-Gm-Gg: AYBFou07BOWudaLBAADCgz9r0dDel1Zwpai5a/WpKN9VvpOSu1dLgoVICg+OEMjibjm
	JltCA2mSaFTYvHBppO9R9F4e55Y8LjPxWiN2j7AuG4eEp75EV7TsPSmmHxaL97flRYEinVZy8b9
	Ffn5ORLh+JPTkKBe7CNznPiujUWZApxzHnv+YSnsxZxMcIeACzPHVWs5TON4F5NdaaHMeqAxdXC
	U7s9CyUVVUy4G+k0PYl7tDc6xY6/RfR601vTNoJhK3C5DwrLeZGdEuFDSW1Z06dUaFEdY4yQXmt
	eIKOcBWxwb2n0PDX/7SyYVi//rRzvxaDCKl801x6ICgUXfwtXPyvQySX10fk1I29fBQkmf36PsE
	3kUodIwkijx+8ymFyJfEq7UnYW/TI/MMfkgA=
X-Received: by 2002:a05:622a:4012:b0:542:fc60:fe23 with SMTP id
 d75a77b69052e-54e1aca53b6mr6923411cf.3.1793925207042; Thu, 05 Nov 2026
 16:33:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030043145.2185700-1-weiwan@google.com> <20261030043145.2185700-3-weiwan@google.com>
 <DMMQTFS3ULM2.3HSJGB1UT085M@gmail.com>
In-Reply-To: <DMMQTFS3ULM2.3HSJGB1UT085M@gmail.com>
From: Wei Wang <weiwan@google.com>
Date: Thu, 5 Nov 2026 16:33:16 -0800
X-Gm-Features: AclHuK9xp-pEOHgQDu3wgVgSsasOVenE5wfE8_PWHekQkM41Loq5TSIyXBPNcLU
Message-ID: <CAEA6p_DCmSskWz5VUOQTmgcnsFDTKH3mSnOdxOxEJg2CU4k0vA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests/net: psp: test bidirectional data transfer
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 1:26=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
> On Fri Oct 30, 2026 at 12:31 AM EDT, Wei Wang wrote:
> > _data_basic_send() and _data_basic_send_netkit_psp_assoc() currently
> > only verify unidirectional data transmission from the test socket to
> > psp_responder. As a result, they do not exercise the receive path for
> > PSP-encrypted TCP data segments arriving at the test socket (such as
> > packets redirected across a netkit interface associated via dev-assoc,
> > which relies on SKB_EXT_PSP surviving packet scrubbing).
> >
> > Use the existing "data echo" command in psp_responder to verify that th=
e
> > test socket can also receive PSP-encrypted data from the peer in both
> > _data_basic_send() and _data_basic_send_netkit_psp_assoc().
> >
> > Signed-off-by: Wei Wang <weiwan@google.com>
> > ---
> >  tools/testing/selftests/drivers/net/psp.py | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing=
/selftests/drivers/net/psp.py
> > index 473500901879..e507951b440b 100755
> > --- a/tools/testing/selftests/drivers/net/psp.py
> > +++ b/tools/testing/selftests/drivers/net/psp.py
> > @@ -120,6 +120,12 @@ def _check_data_rx(cfg, exp_len):
> >      ksft_eq(read_len, exp_len)
> >
> >
> > +def _check_data_echo(cfg, s):
> > +    _send_with_ack(cfg, b'data echo\0')
> > +    s.settimeout(1.0)
>
> I'm not a huge fan of setting the blocking timeout here. If we are going
> to set a timeout it should be when the socket is created. Otherwise this
> function has an unexpected side-effect. Another option is to use non
> blocking reads with timeout like:
>

Will switch to non blocking reads in next version.

> def _recv_careful(s, target, timeout=3D2):
>     """Read exactly target bytes, tolerating short reads"""
>     data =3D b''
>     end =3D time.monotonic() + timeout
>     while time.monotonic() < end:
>         try:
>             data +=3D s.recv(target - len(data), socket.MSG_DONTWAIT)
>             if len(data) =3D=3D target:
>                 return data
>         except BlockingIOError:
>             time.sleep(0.001)
>     raise KsftFailEx(f"short read, got {len(data)} of {target} bytes")
>
>
> def _req_echo(cfg, s):
>     """Ask the peer to echo, and check the reply arrives intact"""
>     _send_with_ack(cfg, b'data echo\0')
>     ksft_eq(_recv_careful(s, 5), b'echo\0')
>
> > +    ksft_eq(s.recv(5), b'echo\0')
> > +
> > +
> >  def _check_data_outq(s, exp_len, force_wait=3DFalse):
> >      outq =3D 0
> >      for _ in range(10):
> > @@ -478,6 +484,7 @@ def _data_basic_send(cfg, version, ipver):
> >
> >      data_len =3D _send_careful(cfg, s, 100)
> >      _check_data_rx(cfg, data_len)
> > +    _check_data_echo(cfg, s)
> >      _close_psp_conn(cfg, s)
> >
> >
> > @@ -726,6 +733,7 @@ def _data_basic_send_netkit_psp_assoc(cfg, version,=
 ipver):
> >
> >          data_len =3D _send_careful(cfg, sock, 100)
> >          _check_data_rx(cfg, data_len)
> > +        _check_data_echo(cfg, sock)
> >          _close_psp_conn(cfg, sock)
> >
> >
>
> I'm ok with the approach overall. The coverage is sufficient for the
> purposes of the series.
