Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF304C282CE
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 01:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A7F217D7
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 01:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="RGjR/Php"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfDKB0n (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:26:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39433 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDKB0l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 21:26:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id k45so3695419edb.6
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 18:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUQ0mxaM92VslOdC33djVT16m43uyxQ1M1q7gXQjDQQ=;
        b=RGjR/PhpqCRmbVmCreb7EC4wlSMmSY8cSSaGDWVRc1tdMdMzFJ5AMTXj40ua1814jL
         //KdjG9SfHOCwxhQsleT1rR7ZvNTj4DUUa01VcxMAi9xtwKWjAfYSbkkNFz+DVn9r6KU
         puV5h30ZmMvndaSD6Jj3w9vY65qemX4nsiyf7leeI7u37//CCziyc4Z4IlqY427JtQ3q
         r/MulYt7iKIcHyeDEaH839estwfn21BERyw5+fxZ2kyHodWtypuQV6EbZCisCUdJWfrs
         7jvdZ56lXois5o2FjtHPEQV7txBhqhzpvH+q+wfeYbD6ZguaEKne+QwKbhlne14RHkHt
         c+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUQ0mxaM92VslOdC33djVT16m43uyxQ1M1q7gXQjDQQ=;
        b=Ws+xZaJTLynS+fB36EqtCJZt8qQAVTFS+PaAbLIBHCZ3EHMQEgDJ0JoRVt2BQmbpfa
         IJFETyDFIrvRkNbB3BeK02l9vLdqocgV5MiNpB5btjwZdyyU3Cns9jK6Jx581kY2mQkX
         7wPmSxZrTxYVk/xo2/ZkcWB7Mb/6mnqT29SIs+ZiU11qbgZq6EOmtLmDlPhFIhRf2Uvs
         CyAbaBKWDZGBaQsyWJlXqp64bFHBH8AqlOzZ4808PtrUNaw00CSA805ZzUCvHQ2ywPMT
         /pGLnUi+ZePjRstLIgGtJbjc80kHvUxItlBJLQSpx3AHqummf6kY4hUZg1YxCzmxELcN
         tfTQ==
X-Gm-Message-State: APjAAAV+vKicOprpZ0HnQlycYaVEgW2/qK38wvT9hJEigs5hjcSVcGBF
        ZZKMlVfxTC/r/y9WUjg+ybTr1WFUSP5SHd4zKXs3bN+S
X-Google-Smtp-Source: APXvYqzjqbkHFP3BtGztfyihIjkbDjLmwqxl/7uqSpknmxgd+ZaOalp42/Toai2RySbXnMnr5GQHG4jw+XvGAqZXHiY=
X-Received: by 2002:a50:bdcc:: with SMTP id z12mr29552105edh.138.1554946000226;
 Wed, 10 Apr 2019 18:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190403154338.29990-1-posk@google.com> <82d2b94d-656c-2604-1538-468e2f891b99@gmail.com>
In-Reply-To: <82d2b94d-656c-2604-1538-468e2f891b99@gmail.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Wed, 10 Apr 2019 18:26:28 -0700
Message-ID: <CAFTs51XLObGg78HOO=jc8HqgKmuUkONcsCuH4jvMfOLiOKXU+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
To:     David Ahern <dsahern@gmail.com>
Cc:     Peter Oskolkov <posk@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 10, 2019 at 6:19 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 4/3/19 8:43 AM, Peter Oskolkov wrote:
> > This patch adds tests validating that VRF and BPF-LWT
> > encap work together well, as requested by David Ahern.
> >
> > Signed-off-by: Peter Oskolkov <posk@google.com>
> > ---
> >  .../selftests/bpf/test_lwt_ip_encap.sh        | 134 +++++++++++-------
> >  1 file changed, 86 insertions(+), 48 deletions(-)
> >
>
> Peter: What OS are you using to run this test script?

Debian Testing with a net-next kernel. What kind of errors do you see?
