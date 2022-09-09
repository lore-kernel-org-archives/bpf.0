Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8041ECAAA1
	for <bpf@archiver.kernel.org>; Fri,  9 Sep 2022 20:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiIIUiG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 9 Sep 2022 16:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiIIUiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 16:38:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEEBF8255
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 13:38:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id q21so4242989edc.9
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UolCEcU+l29/KUy2oMUWlCUkuY6OxYvvLugdKXCddiU=;
        b=TY4QoV6OMXp1HcKmqLCTy5lxivleaj3LNYis5SW8r05mXpoyuf/y/93kBQpzH4ewJF
         B3tCUqKVE8faSAtOurrTk7SE3ckZf7hxvsyhzAFONHbnMuE3Fep+4t3e4WK849uFyzdn
         yiotrK/ZDzPAU/m+W8CQ6vfsVlkQTAhNL3xpzuVTaOCsKjzjDcrVDZjlhwX6bmZWansf
         Cr/9LdfprnBuqXXF+Jqr3hlR9994/u5rYhNPn98CKuI9A9bvbC+aCQrHHgCsUb+KkgLx
         nUFo23JAtJz2mh/VLDOmL/O+MiokhQ0gUL7JVrQletCRqgDPczM7wS1fzgECzjdvkE7t
         oc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UolCEcU+l29/KUy2oMUWlCUkuY6OxYvvLugdKXCddiU=;
        b=nksMbpsVoX8l+J9mqRo/LFralSOxw2d+hkGskp+zfzsdH0jtf7H02RNV9uF8NAG4I2
         b6cZIMddzTfP49Q9s/TcVCfoZ463We0K+44Ar+A1sCY/Q3oOYV1Usi+R4B+5lOMsV4Wc
         4bMEG5enZ3epssqB8C3ZhmicUS10yZWNCXu70I62a8dENgdt9BFNR4jXtvwtsNdZnBem
         yzo3Eaz+odpx5ENMNpFoYYD8fzc7+lfz7upC35DssEmOzcqmAt6w4mJVwlxfDfo/uNNI
         fzjI1/EbqmsXlnRB7PeNzLle+U4M0hJYgMTSy2a/KQfeKt0G4FYcCdgXuwiBhtp6a0xP
         rg6w==
X-Gm-Message-State: ACgBeo2gaS0BkAiZVHfPkXQybn3nCSeHiG2qVTJ1sQqDkdkvhonUacaQ
        /KF1kNq/nctCXpWhvmlzYlvXxZwQnhMQ3ghXzJE=
X-Google-Smtp-Source: AA6agR4iCuwIKeoKsjWuLJxQJDE2XUtL5KLinApVvEvJJ+AGuEdNlSrqk2Sn+2U7xnI6bNg0Jwf5Tka/ltGLHbbfytY=
X-Received: by 2002:a05:6402:2751:b0:443:d90a:43d4 with SMTP id
 z17-20020a056402275100b00443d90a43d4mr13241424edd.368.1662755882673; Fri, 09
 Sep 2022 13:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
 <20220908000254.3079129-5-joannelkoong@gmail.com> <20220909195224.7e7acdcd@blondie>
In-Reply-To: <20220909195224.7e7acdcd@blondie>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 9 Sep 2022 13:37:51 -0700
Message-ID: <CAJnrk1aF9-viBD+50FKLNnuAayN5oV_X+txwkJO6DdaEi+J7HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: Add bpf_dynptr_get_size and bpf_dynptr_get_offset
To:     Shmulik Ladkani <shmulik.ladkani@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        andrii@kernel.org, ast@kernel.org, Kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 9, 2022 at 9:52 AM Shmulik Ladkani
<shmulik.ladkani@gmail.com> wrote:
>
> On Wed,  7 Sep 2022 17:02:50 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:
>
> > + * long bpf_dynptr_get_offset(struct bpf_dynptr *ptr)
> > + *   Description
> > + *           Get the offset of the dynptr.
> > + *
>
> The offset is an internal thing of the dynptr.
>
> The user may initialize the dynptr and "advance" it using APIs.
>
> Why do we need to expose the internal offset to the ebpf user?

There might be use cases where knowing the offset is helpful (for
example, when packet parsing, a user may want to know how far they are
from the start of the packet)
