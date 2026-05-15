Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946F341AC7
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861609; cv=pass; b=r1tiDhA/jtu20xQOj+ZL7nDc3JwloT9k7mTtqhYHb+9hbt51gEpB3SAjKyURcE7tsAV2abIfUHUvItcDEIRz6W27Iwv+2vQTtI/+M+oUUChqaPV0yAVjaHXhHrJgK1X1o6WewF9HbfmMybuYeK7qWaCAUfqgdEZR5gLTWt/Xpdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861609; c=relaxed/simple;
	bh=zR1yYc9OM8/abzeKbNBLcU2waXyUwdgxJgy2JNeeQrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkD3T8cDHVn9x2xszhxlaVt9FSSttEzMd/8KcbWqBCDzcK0BVX69kSkI2bbQrOuaYaH/d4WPRE2QhLOs8ExBtfdo7OdWHUcme6uz6vcGGZBEWgNjuG4M9RReSga3qL0vPRLqOz/NUv2/kY/aILsC/sB4l0mILgm72LjyJldR+e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAlYK5Ku; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAlYK5Ku"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67cac5ece75so15573828a12.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 09:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778861606; cv=none;
        d=google.com; s=arc-20240605;
        b=lw/th1DEpeMful0cIOBQsiShC0r39SbWz6xvUsbryJg6mQcwZUpk+O6Hp9plGoTiu5
         TGS/qZ1B8wPZPYgz1GTNaD5nQ7rZ9Zwm1btW6whNNdY6zBlH+7iI82DDewjc1X1mZupX
         mEVOnEZ+R6Fz+uLA80kaQbj2MexvYvIO5T/1W7JL4QXEoDC+Ej2ZcdFt9XwNym8UJbQk
         VIKFl4xXK6v6gwLEVUZ+WQ5Wk125V74Nhv4TtTKnMjt+1uLA5igy10tOO9ah17na9e+4
         HMS3UFzjtK2XGn3oG0GdxhXrFRZvbVtBb7nEBnr/KYYXZ9gpvD1J8ZDkmtEQ+2z64EUZ
         xOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RdcWSBi36KnefYlCpM3Langpu7uSIZQhoWSIjSgZsAs=;
        fh=tlEGSbXDVjbDcaL51xtZHX1JT0p1IyST8krYqRBsCxA=;
        b=lXHSrryLJaEm3krDOaRf8w4khiQL+0Ry54y3Db3TomYNWfNUKH+d+m575sFveFV4SM
         ksx16bVLIcuUtkGR/1I0N6F8VfOukZtpO2i9MVkvksxaIgu0m5ghaqO8NM+sq4lJmfux
         s/cge3I02GlQDR2ZqgDt0p3gGbdWiWxkzqyvFqMbNSY14NzrB1tC0ODsjPGYQ06oRgno
         kbiimyU91fpwwnv2fAAbWOVqkJ8v5N5SsxD9QUQ8jrEFYbEj/fQ+6n2JEugW4K/18CGY
         G40LqzFvyOzKUm3jb7g1WlGEvGeNeuGOK9cwCAcvtvjtswm/ABrKgNUhpBCD9AAkNZ4S
         iDug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861606; x=1779466406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdcWSBi36KnefYlCpM3Langpu7uSIZQhoWSIjSgZsAs=;
        b=aAlYK5KuUM7wYoFNKdy8WyjLHt/suDkMJJA+KotAxncEydrn6WgtWDlHLjOGdhSafp
         LjJFhFic15WqS2MCaIijewIv00VLOcqFURiVirsFot0/ra9kxwyuDFdxHQvhsc3RaoCb
         hzRkE9Zl7yrs4DZGZMsNJ0HoAzEKSvZrHouyjEmSSrcfzPqBCxfFMa23YkuJw51HpUAr
         LaxhQzK8m8sS8eJgKFSNaZA62moNhzrPjEwAQpBe2ZV7vSLdjAHura42lMlyCcKYv441
         3UXlm6Kzh1v13tQV9+h3vtYHRHw5MCjC7S/6pUE1WjlkMihbknFVnbKUb91WIgz3DCK3
         hDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861606; x=1779466406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RdcWSBi36KnefYlCpM3Langpu7uSIZQhoWSIjSgZsAs=;
        b=hiDz9esfrxDRFnLOhkomwF+l/qlrzwUaQpwRzt72r5m7+CDcLZkwGGiC+QOmQVkX64
         fNIPEWu1lZt93dzNBH7s2wdPxFotxS/dNRDsZcOsJ+en7CG/Zor6LzMNHKFZiEykDzJQ
         teEkzA1bFzYogMjkhSb554uPlUsEx5jlOvr+FTNUb4RsM2mTBCUuYEMthEOsj750rqSa
         AeXSJpVs/1HXVbOshkUSZqLewm8v9bpF0e0i/4D/CVreAuNUeQreZQq7xhbKBeCq/t66
         /8CyvR9MsK1xRX/9Zqpbr/JVWwukTFDR262+MD3J44qEJ+uodnZ5bKTDeGtNcR6w5uO8
         KCjA==
X-Forwarded-Encrypted: i=1; AFNElJ+8eysqzkYL3mujB/PdGlsDbCNeL2Qze7lzWPIeC2h/62ckYeILqSHvjJTSnVbufPpvKQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWlD6sJh8qbZvCjo0ONWM7S7ebse3yyaugjjVC8cqhuBD5qjNP
	cA3xwJNQNsRUbz1clFFPSemievKInztqlw4+XAQW+QXGUW89pBc4uJZZNz4hHLb9+aXR+drpr6J
	Ye3GE+m1KPV9H6w3Roeag1iO30Le0NGs=
X-Gm-Gg: Acq92OE12XMrNY30+FJBp6+Lg2suzcwF/WnUsHvcNxhsxlDntsx/kYgM6i22FI2i27x
	lnUgS99XWYB82OOcus3+pi40Zv7+fe1rdBtBBeijS/taYERsT/HTD/kz/OpEXiNbfamPJEM3k2l
	XLY9hV2zGEcipByb57gPGxSQegogJM9fplB2Xv+Zexxj0iuyWYfcgO+lbf4PEvew5ACzFjU0Osy
	eZBVpEz6v+cmWLP0IqKTXqO5hFnL9r8JmGEKIEfBUF+tpPKsBsR1Tsp+okZMj3YQ6ADxZEiFprC
	0thi7tzUkqHUX31jdwP1+0jwwzN1IbkZXz+b71wyMvnRBc/MKrIDvpk4iGcJsJonmpnRTjaSEsE
	1B+USPwfAFE9GLHYy3y5BZHGSWnyJCGUUcT/R
X-Received: by 2002:a17:907:2d13:b0:bd5:2c3c:616a with SMTP id
 a640c23a62f3a-bd52c3c6261mr97395666b.37.1778861606050; Fri, 15 May 2026
 09:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515113102.2389020-1-arnd@kernel.org> <CAADnVQLYitAZVpXCTygA1uAUtN6m8pMkWzFi9su719M=nktmQQ@mail.gmail.com>
 <b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
In-Reply-To: <b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 May 2026 09:13:13 -0700
X-Gm-Features: AVHnY4LIZBVCqMg1hBQMiFvFAmVKWiP3lskvoyscc1J20sfPKogHZR-c06VLQak
Message-ID: <CAADnVQLa4KbzSHs-5NdabqKhXAYLx+JGei52gKNEv9ww+Q+Bbw@mail.gmail.com>
Subject: Re: [PATCH] bpf: test_run: reduce kernel stack usage
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <kafai@fb.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, bpf <bpf@vger.kernel.org>, 
	Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 8:16=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, May 15, 2026, at 16:47, Alexei Starovoitov wrote:
> > On Fri, May 15, 2026 at 4:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >
> > 1k?
> > pahole -C xdp_test_data
> > /* size: 192, cachelines: 3, members: 9 */
> > /* sum members: 120, holes: 1, sum holes: 56 */
> > /* padding: 16 */
> > /* paddings: 1, sum paddings: 36 */
> >
> > what s390 doing to make it huge?
>
> I think it's a combination of cacheline alignment (256 byte
> lines) that leads to padding before 'rxq' and at the end of
> xdp_test_data, as well as CONFIG_KASAN_STACK that increases
> the stack usage further.
>
> > Probably better to rearrange the field and fix the root cause.
>
> It looks like this change reduces the stack usage by 256
> bytes, and keeps it under the warning limit for all the
> configurations I was testing:
>
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -98,8 +98,8 @@ struct xdp_page_head {
>  };
>
>  struct xdp_test_data {
> -       struct xdp_buff *orig_ctx;
>         struct xdp_rxq_info rxq;
> +       struct xdp_buff *orig_ctx;
>         struct net_device *dev;
>         struct page_pool *pp;
>         struct xdp_frame **frames;

yeah. this is much better.

> Another alternative would be to allocate xdp_test_data statically
> instead of on the stack.

iirc test_run can execute it in parallel, so static won't work.
