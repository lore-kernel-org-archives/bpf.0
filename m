Return-Path: <SRS0=3byo=6X=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15E9C28CBC
	for <bpf@archiver.kernel.org>; Sat,  9 May 2020 07:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3205207DD
	for <bpf@archiver.kernel.org>; Sat,  9 May 2020 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589010734;
	bh=BSB5Ai5myIgouRj5Sa4lqMr9MicvPbVSUsZcxvz6BQ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r491jiEYoPiPs0SmDrdf+zWGcRSEtCpDpc9KTr9g0RGxQ+4dKoQAv9qaK9wDzL9NB
	 Nz43yHaXPOx7fN6qQYuG4tKXLC8uvrJuOSB1kr72uD0H8ob2XeXl/tR57nKuoJmZI2
	 4A10Y1fEujV/dooxMkTqh4YGzbHlsN5HqjLSzoaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEIHwO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 9 May 2020 03:52:14 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:47504 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgEIHwO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 May 2020 03:52:14 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 0497paTk010240;
        Sat, 9 May 2020 16:51:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0497paTk010240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589010697;
        bh=2V92LfBMVAyVrFXs5lPr1OUX4aisTenE89ByV2XZ0Yc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jBP+CKa7kC0qTwFsBAkCFOtPN8P85iXmEoaulhtBOdNH+4Xc0U972VfXpqeBjqMDD
         Gdue98JQ/Ig2GSRdvzedNUBOzjV4BXTNHgCwIpOeu9H3RVLyDZOAoUgl9ojhAWAM7M
         ekAHcRkF7RulH2FLGdyxNkw0XXwsrL0K+gDXXCcSqIlULlnx8ng9RKbbj145N43EIf
         SznUMP1Oayx9m7ZG3fZlPfMnHxzHJXYXe1i5cPj+gi6sx6wwQtS6vnNJEW1UcI35AL
         66Txe/cAyPCmwhIcq5/JLOfq/0+G+nG3FOA03pUKxihiGZ/rCjkHAZJONxWIYidIQg
         BD56OZTMeOH7A==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id t8so1556683uap.3;
        Sat, 09 May 2020 00:51:37 -0700 (PDT)
X-Gm-Message-State: AGi0PuaGN8xDVdjNYJTXVN+FwQUbT08mmOO2TkxRlk6/d26BAo+BD1O2
        rSy3JBOZPjDYadpgrQDyIUCKBH2jgIfFttEa3gw=
X-Google-Smtp-Source: APiQypLaIMCTVq1ANNjDJgY4g5gg4MnTRnSdctLVBtJBnr92xLBSycZrX64S5ReBIc7Y6HjAjAU8Jqir0z6QzJOv7iE=
X-Received: by 2002:ab0:4ac9:: with SMTP id t9mr5406736uae.40.1589010695831;
 Sat, 09 May 2020 00:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <131136.1588999639@turing-police>
In-Reply-To: <131136.1588999639@turing-police>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 9 May 2020 16:51:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2xMR9fq+bJCc=1wLuEM99fPNagDc=NkFoDKNi-YCpDg@mail.gmail.com>
Message-ID: <CAK7LNAT2xMR9fq+bJCc=1wLuEM99fPNagDc=NkFoDKNi-YCpDg@mail.gmail.com>
Subject: Re: [PATCH] bpfilter: document build requirements for bpfilter_umh
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 9, 2020 at 1:47 PM Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.e=
du> wrote:
>
> It's not intuitively obvious that bpfilter_umh is a statically linked bin=
ary.
> Mention the toolchain requirement in the Kconfig help, so people
> have an easier time figuring out what's needed.
>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
>

Applied to linux-kbuild.
Thanks.


> diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
> index fed9290e3b41..0ec6c7958c20 100644
> --- a/net/bpfilter/Kconfig
> +++ b/net/bpfilter/Kconfig
> @@ -13,4 +13,8 @@ config BPFILTER_UMH
>         default m
>         help
>           This builds bpfilter kernel module with embedded user mode help=
er
> +
> +         Note: your toolchain must support building static binaries, sin=
ce
> +         rootfs isn't mounted at the time when __init functions are call=
ed
> +         and do_execv won't be able to find the elf interpreter.
>  endif
>


--=20
Best Regards
Masahiro Yamada
