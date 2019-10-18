Return-Path: <SRS0=UnAx=YL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0C8CA9EA2
	for <bpf@archiver.kernel.org>; Fri, 18 Oct 2019 06:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6051321D80
	for <bpf@archiver.kernel.org>; Fri, 18 Oct 2019 06:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8Zlmc+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504296AbfJRGUB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:20:01 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:39287 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504151AbfJRGUB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 02:20:01 -0400
Received: by mail-lj1-f171.google.com with SMTP id y3so4967148ljj.6;
        Thu, 17 Oct 2019 23:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcNReyNrRltv4yUc/bRjZ6f05nyo0YbTID+WXyc7yUw=;
        b=F8Zlmc+G7JGaVnDlzKXea5IHzdDeExc1KIg/2F2lV0ELcfJg+0GsGCzV/2khUaoTVm
         ZKCEfq6klIJuVgO6UByk61ng/SPBxh5iUt6rJKom0+qmstodqWmAalr8WsI+a9obpofc
         f4ECJVH7Prv34K4Hd3FN8OagNXrWDUoCGT6oUH/SQ/Lrsl8/POLmHJfPrvtBiT1NrgXI
         LhYwYQcvA/vHlMN4FmZh0nnf75prnigOfa6pP8Ka/zmORCmbAaEmVJMjIbGRVX4lTl7/
         l0xl848ToYu1MTEL0Q0ysZIA8iKN6zBjEr/HstPMuTSiV8bmtDaZeLi4y+o7fqMjIJ6j
         k86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcNReyNrRltv4yUc/bRjZ6f05nyo0YbTID+WXyc7yUw=;
        b=T7dKUnM+3K8oKMAcnXdHErUOvFOqWutdkPVGQpblPtg1bJnmp5OUjHIsTkWiwp51ts
         XI5Di14uXjn66o8ecOnhW+6/tbvnPxLaVcdtjypyvWN7DuKRIMPZZBIATpwKH898GPO5
         M2v7k0xPI1bWGOpyH0NvMu+RlGPblMgPgOxZBO7HhIFoUU/Z3H6dsOiRVwo0BUZKxHU3
         /CBR0vqce/6aZbg+U1LyT5yq0ki9qKM+IoFnejPeDIi2pvazVsREj34w2Ch1DlI7gdjX
         JzZwT+OqV4LQQrYLTrY3h628ANfAKvij1NBht27w3td3m430n5+ovkNB7IB6IgOS/D3P
         pcBw==
X-Gm-Message-State: APjAAAWfxHa99RHJEIPJ4IdDoQ4PJAZrwTbkwwDTb/Y/vGMTo0zuQcs9
        9agAI+oMWWDCqO/baGXAZA8xGQmgRyEkeIRpxkE=
X-Google-Smtp-Source: APXvYqwaqW9qj45Xdr3fBSMuYny2RKFAHScC1TfqUMnsaoHH34NY+u7sffDnaHabNIRBK71UzSt7LLB7zPyfVjqAz2s=
X-Received: by 2002:a2e:9cc9:: with SMTP id g9mr4855977ljj.188.1571379599375;
 Thu, 17 Oct 2019 23:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191011162124.52982-1-sdf@google.com> <CAADnVQLKPLXej_v7ymv3yJakoFLGeQwdZOJ5cZmp7xqOxfebqg@mail.gmail.com>
 <20191012003819.GK2096@mini-arch> <CAADnVQKuysEvFAX54+f0YPJ1+cgcRJbhrpVE7xmvLqu-ADrk+Q@mail.gmail.com>
 <20191016140112.GF21367@pc-63.home> <20191017162843.GB2090@mini-arch>
In-Reply-To: <20191017162843.GB2090@mini-arch>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 17 Oct 2019 23:19:47 -0700
Message-ID: <CAADnVQKWN87F=xnbBwwm+B04rt5HTRRmwMjepqWrgsxuS+sPHA@mail.gmail.com>
Subject: Re: debug annotations for bpf progs. Was: [PATCH bpf-next 1/3] bpf:
 preserve command of the process that loaded the program
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 17, 2019 at 9:28 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> Tried to do the following:
>
> 1. Add: static volatile const char __annotate_source1[] = __FILE__;
>    to test_rdonly_maps.c and I think it got optimized away :-/
>    At least I don't see it in the 'bpftool btf dump' output.
>
> 2. Add: char __annotate_source2[] SEC(".meta") = __FILE__;
>    to test_rdonly_maps.c and do all the required plumbing in libbpf
>    to treat .meta like .rodata. I think it works, but the map
>    disappears after bpftool exits because this data is not referenced
>    in the prog and the refcount drops to zero :-(
>
> Am I missing something?

"Some assembly required".

I think first variant should work at the end.
I don't think extra section should be a requirement.
Sounds like with 2 it's pretty close. Just need to make sure
that prog side sees the map as referenced.
And more importantly bpftool can find that map from prog later.
