Return-Path: <SRS0=E2Hj=CT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BCFC43461
	for <bpf@archiver.kernel.org>; Thu, 10 Sep 2020 16:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8695220719
	for <bpf@archiver.kernel.org>; Thu, 10 Sep 2020 16:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKhllOYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgIJQ6i (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgIJQ5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 12:57:48 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD57C061386
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:49:46 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id s92so4529315ybi.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FU8qhjs0nfDZBWwv7FbTQftbw87IRF2MBO4TV6/OOVQ=;
        b=OKhllOYAwbEUs+EvNd4bPN92GGcxAbPqE3elj7oRqpCjCSJjOLwlL23WW4aRBtje/m
         3nrxLhR/kIGRriYZqP27Dn5Tl3iK74QEX85XT2EOzl4kNlOWJCxbsZXK06S31jcdPxBc
         91KCEUMqH2W9pSJeyHY3Ln+TED5+KEJ67PQ7js2GT5CEULStBo3sW/vXTer+iPpa7MWG
         NZF5L4NvbWAbKd2w4V/Sbrq87SAuI12DHVQN84bg8neiHhZvkYKfjpm9E0/68DPi3xPd
         zWrEzJ4RZHo6nJPjGN//ubEBnYXlvyEotRm2DkknJlGST+RguQZrupFf5sYKzQwbxwiF
         k7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FU8qhjs0nfDZBWwv7FbTQftbw87IRF2MBO4TV6/OOVQ=;
        b=IIaUXOsswdCsYdKtR72eoSasK9S3cZaYhGKneHnxoaOe0HjIBn420mauLpizfTCjVA
         Jxt+qglLmk1a+QVgeAOZHxSxqerxfN4XQmByHFqA/0T02Pz5Z3hwfaGjALLJbfFt1nS+
         l0i8Hheby5u1BG1Mm3q811L5Isd61XOxs1BuEBKpCfhfbcaY1amNcVWFP1vdYga1/7pl
         IniudKRq/fZfX0QZY6QMTtatZSMfUCPJac+hpjcrOz5SOCnhfp1turSbpoVqof6RMg6E
         Koo8+LCuYx9nK1iv68kT8gFY3eeBYkJeXjyxLcwC3nb1a3R9SdlbPvI5xhUTsMHsFeWv
         EFXA==
X-Gm-Message-State: AOAM532DmeSXXWGmoqXcS9KYa+NjMtGY+GGzEjSoteVQhKjyWGy+H22e
        S9sll/nH1wirh9dtzglnt1re4OuCpGvYUIi++u8=
X-Google-Smtp-Source: ABdhPJx71y08Q2+eJNa3lN+veYrjscbuMabLx1nCVBDoyKSB+pgcNL7VxsFp6TXSLNWrtoL4UVzWeBxtGOUoHzNN9xI=
X-Received: by 2002:a25:9d06:: with SMTP id i6mr12681115ybp.510.1599756585347;
 Thu, 10 Sep 2020 09:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200909232443.3099637-1-iii@linux.ibm.com> <20200909232443.3099637-2-iii@linux.ibm.com>
In-Reply-To: <20200909232443.3099637-2-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Sep 2020 09:49:34 -0700
Message-ID: <CAEf4BzYRPqZX5POq6X8hdHmy3303NUEyqbE5ePKpgbrMMxTJXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Fix endianness issue in test_sockopt_sk
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 9, 2020 at 7:52 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> getsetsockopt() calls getsockopt() with optlen == 1, but then checks
> the resulting int. It is ok on little endian, but not on big endian.
>
> Fix by checking char instead.
>
> Fixes: 8a027dc0 ("selftests/bpf: add sockopt test that exercises sk helpers")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 5f54c6aec7f0..ba4da50987d6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -45,7 +45,7 @@ static int getsetsockopt(void)
>                 goto err;
>         }
>
> -       if (*(int *)big_buf != 0x08) {
> +       if (*big_buf != 0x08) {
>                 log_err("Unexpected getsockopt(IP_TOS) optval 0x%x != 0x08",
>                         *(int *)big_buf);

(int)*big_buf here?

>                 goto err;
> --
> 2.25.4
>
