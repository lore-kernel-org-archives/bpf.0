Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE70C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 06:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4A52084D
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 06:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX/UGpzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDLGBN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:01:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39570 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfDLGBN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 02:01:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id c189so4985323qke.6;
        Thu, 11 Apr 2019 23:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vs8PkQFaNLaqLeWu2Os8E+Bq0zSxgqt9s/A1jO0eogA=;
        b=WX/UGpzlPtSoDcbrXJ6hgYOlKdvfpr9WTRsepSh/MRPIWPGxPokxN9UxeQSzPcgsfs
         VmLGUbNr2r5jGQeKasIAvVbofQf8IUlLfeqPaoZpjdGCCZ/LaxuOiVKWRjZYqQGvPcfv
         OIijfIZIEglfID6uFaK9RkoC+7wQe+DfVvrNTf9qlFcLgMXpM9kDuPNar1tRZbbTqVgc
         6YiB55zOmjIiZya7QH2FV35Je9OAFsWOToozC2X/XUajG3aT1i9w2yBqb7wktdUDRGu4
         zK+97Vru+9kBUnnkaFp5YGtJnip62Hr4QISWFXfn/FgZdQFAuZPwAnBmZ7u/JIQTx8Xu
         p1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vs8PkQFaNLaqLeWu2Os8E+Bq0zSxgqt9s/A1jO0eogA=;
        b=J1HHkiPIn3/BoPTsQWru6yFvmB7FunFJvuYOj1y4XwjnL0I+IkIVC8WmZjjMuo26rr
         kdnF615r6U3jW+6m2Lt97+lsQsSyHwXXLsb2UY5lXOFuzKvhtLKpJjyS8nedF+g9h7c2
         h2v7LWiT0KnYl2R7A+Z/t6oAtb/dxv6VtoSmOqfVq6TxI8ovrWsL8jejDZqNnkxOy8RG
         mhUZqOeHbtTF4JApUtBb7L3b2AWNV69I3cbHHMbsk1kQQ0/HsQYlhib+2c3/Tqm1VzYQ
         p9ZnA4uY8xJFZOsBfuFE0MWpGYhQ7QvlnW/kE+qYoMCdMgbGUnWsvXeDTqQNsL18ztEW
         sBpw==
X-Gm-Message-State: APjAAAWTptDndC9sWumC9rGyqbA4Pc2rKo+yHJRBPnJ7hDwsJhxLpbKp
        wFv0kqmI2525sDRB4kgLWixM7e2hza/lf6rNPCA=
X-Google-Smtp-Source: APXvYqzNh+3S/AGUoUPB2pEL9ai6DER/BRViyj3Ihk/dCDfrMcnll7Q8d64DV/ZYsnzIGmQeNYd0FC4oM1Ys6dlh+IM=
X-Received: by 2002:a37:6b01:: with SMTP id g1mr42067386qkc.280.1555048872112;
 Thu, 11 Apr 2019 23:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190411225316.125106-1-sdf@google.com>
In-Reply-To: <20190411225316.125106-1-sdf@google.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 11 Apr 2019 23:01:01 -0700
Message-ID: <CAPhsuW7a0XxoFF0V5TFRYqAKHu9_d0gfYGTnfTcEWch1sTBung@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: bring back (void *) cast to
 set_ipv4_csum in test_tc_tunnel
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 11, 2019 at 4:08 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> It was removed in commit 166b5a7f2ca3 ("selftests_bpf: extend
> test_tc_tunnel for UDP encap") without any explanation.
>
> Otherwise I see:
> progs/test_tc_tunnel.c:160:17: warning: taking address of packed member 'ip' of class or structure
>       'v4hdr' may result in an unaligned pointer value [-Waddress-of-packed-member]
>         set_ipv4_csum(&h_outer.ip);
>                        ^~~~~~~~~~
> 1 warning generated.
>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Fixes: 166b5a7f2ca3 ("selftests_bpf: extend test_tc_tunnel for UDP encap")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> index bcb00d737e95..ab56a6a72b7a 100644
> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
> @@ -157,7 +157,7 @@ static __always_inline int encap_ipv4(struct __sk_buff *skb, __u8 encap_proto,
>                                        bpf_ntohs(h_outer.ip.tot_len));
>         h_outer.ip.protocol = encap_proto;
>
> -       set_ipv4_csum(&h_outer.ip);
> +       set_ipv4_csum((void *)&h_outer.ip);
>
>         /* store new outer network header */
>         if (bpf_skb_store_bytes(skb, ETH_HLEN, &h_outer, olen,
> --
> 2.21.0.392.gf8f6787159e-goog
>
