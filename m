Return-Path: <SRS0=9soK=TZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BCDC07542
	for <bpf@archiver.kernel.org>; Sat, 25 May 2019 19:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43FC20863
	for <bpf@archiver.kernel.org>; Sat, 25 May 2019 19:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVGkmV47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfEYTuN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 25 May 2019 15:50:13 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33513 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfEYTuN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 May 2019 15:50:13 -0400
Received: by mail-it1-f196.google.com with SMTP id j17so13823972itk.0;
        Sat, 25 May 2019 12:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hq2Q+SroIm5Cvrf0DMQ5BAqoxzUgEF4GXLxfPdJoAAM=;
        b=JVGkmV475Lko/G7JcPn7dTWYetmlvNVrYVPMizW4RzjwUHPKcrqg1SGLJhgwtSTZ3F
         IUeZqBFiGKkY3QNwCBlgaYfJWLPZtSAUO2bMCDTQJpk3obDLSe1BL3x7IG2tAbhod7oa
         WqB4AQ1SlmuUdJ2QgM4zeTsEWrrtH25Irv+HmE61te8G7abj8qH86Yx2jTwYvplT9anC
         pC+nrUJdxjZ4SPLwo6rCylee0Ts+wrpHw0X0qnhEy1t0OMov5RDByhBNmL4s5HyNBUll
         xLUHwVueAi4CW3OzO/LljOVrPNvveWn9tRGDLVZCnT8HvqVW2qim++Q91+7m4XNaQt4g
         W4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hq2Q+SroIm5Cvrf0DMQ5BAqoxzUgEF4GXLxfPdJoAAM=;
        b=PPR5M2QRYPrGMrxa2je4hPBxaY4f6DkQaPxHFBYMk5dZIqGoZZrRZ7KgKznnbO15j8
         1rLzey68VmDaeI8kf1aNMgNp53CjQ3EEbdzGK0NIRqE4IvQJk6iVsIR5lYl+xSoYb8AK
         qCpTevA2UT8C/DwIFhndd7uLSqe9rU2SQXFImi4tPCDTGdiPapWitoD66r4c6DFeETB/
         p+dtoihacjHZUhP547Xch+TWPJXBilyvqnQ4nwP6DVsIZv5G8v4DmUNOajw3LzlceXuw
         JNzg6zNKoyOkW/LTxUVwnWYktbN34Ux1ftCunkNKJhMqkKjgdS/x/5aBpc89sBhjv0zk
         fLkQ==
X-Gm-Message-State: APjAAAW76IKmj7rUjwNvHZSqIka0TWHRhVbiE9ecUaSRNP3sVqux19zz
        nSNyyd7MkR+c8mivLK+F5rFz5CJd5673oC3NOFM=
X-Google-Smtp-Source: APXvYqz5kKAjBqB3SkUW1i7NpkW2r6ygoNsz+E6oh87V/fQDXBopo0z9hF2793yWsLhGrGcoSoqqnbbovrEZ1G+p1xw=
X-Received: by 2002:a02:ccb8:: with SMTP id t24mr26073389jap.59.1558813812596;
 Sat, 25 May 2019 12:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190524222856.60646-1-sdf@google.com>
In-Reply-To: <20190524222856.60646-1-sdf@google.com>
From:   Y Song <ys114321@gmail.com>
Date:   Sat, 25 May 2019 12:49:36 -0700
Message-ID: <CAH3MdRU=buwX9ie2kz8KQyPRuiQJ9vPy5FMvqe2h8f+tOpcTYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fail test_tunnel.sh if subtests fail
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 24, 2019 at 3:29 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Right now test_tunnel.sh always exits with success even if some
> of the subtests fail. Since the output is very verbose, it's
> hard to spot the issues with subtests. Let's fail the script
> if any subtest fails.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
