Return-Path: <SRS0=13Dn=Z3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05767C2D0BE
	for <bpf@archiver.kernel.org>; Thu,  5 Dec 2019 01:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D112A20659
	for <bpf@archiver.kernel.org>; Thu,  5 Dec 2019 01:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH5IvmNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfLEB7b (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Dec 2019 20:59:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43802 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfLEB7b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Dec 2019 20:59:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so1575060ljm.10;
        Wed, 04 Dec 2019 17:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oWkFNr4QlzStNffmGQUvt/xh0lAmaw/Gu1WQ6Zzy3Q8=;
        b=PH5IvmNPvyK5JL4kIAAyXiwS3sHEk2AcY9mZMzlKd0bp4mNgOOJt8Vc8dPpHq3tNT/
         iUiQ5nIPcJBPv9bQ00sHXJHz11TKVfkM0Ntq3d4lEPya71oS+D40qvNuSLN5Ea09hd2e
         Q7okCQUF0xJ1ldcENmtUy3i3mcz5oQu0QZNulsVmHx8kS51Z8BKL7E+OJ6NOas/z7Jpp
         aIINBSt5/ZHvrrGtf/jxnyE08OLh1HVBCUhV8Dg0gMMd7T/vlfAqE2UainiMPsTnuV2a
         dzVRGP7WKuIiu1PSWv45JrP7GtktVLr02IlkU3UV7GTzMRimqbMvGjbIi3QHxy6A7xnw
         ew5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oWkFNr4QlzStNffmGQUvt/xh0lAmaw/Gu1WQ6Zzy3Q8=;
        b=DqqX4W3eO2IgYMC0YKt6z9j9L1jQMocaTTLzSOUXaP6Z8ydznJgLjOS/e2JhY+UDYq
         SHZz5UQ5JgUiSxifNWr0aoKIPIgO9aNedhZpyZCn/w907+IjPV+XjW1pVANQXi7Q2umz
         Y9EzWdiOaawuCHXeXS1+I34lsOm4nygb00fbEKMZu2ntsTPI/IoPRMrRhMXcq2kcP8TH
         u+tAgz6Tu7WRObv7YFYMr0821RBj0NyEAl9izv6CyVNfUnFEfEbiTfwowbv+LH9LsKDa
         /ND43kBSWhsCekgmH7po36E13Y6GoJvMBqZ23l50m43AR7Laq15aDZB4gzDbxDKWCdId
         FZkQ==
X-Gm-Message-State: APjAAAUpAWQI7utc36SX4q7+G6fnhW+iH5Nk6vndvJP8JS5S8gJxbXqI
        b49JYgOeVBJonCkHEkOTQyW3U7MWhgECvGL0m6E=
X-Google-Smtp-Source: APXvYqxJXZogFBPqDe217DfUqObeOYrjvUFgdG8aYQ/KRrdaUCaHT4B9wzlaC3MctFZXQUAopOXqjPMGLlD6TEGsPUM=
X-Received: by 2002:a2e:8508:: with SMTP id j8mr3815196lji.136.1575511169140;
 Wed, 04 Dec 2019 17:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20191202215931.248178-1-sdf@google.com>
In-Reply-To: <20191202215931.248178-1-sdf@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 4 Dec 2019 17:59:17 -0800
Message-ID: <CAADnVQ+=vqK9hbNbaRPtJSVGqN4EP=tDpPam7+1b7g0A1SGo_Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2] selftests/bpf: bring back c++ include/link test
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 2, 2019 at 1:59 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> Commit 5c26f9a78358 ("libbpf: Don't use cxx to test_libpf target")
> converted existing c++ test to c. We still want to include and
> link against libbpf from c++ code, so reinstate this test back,
> this time in a form of a selftest with a clear comment about
> its purpose.
>
> v2:
> * -lelf -> $(LDLIBS) (Andrii Nakryiko)
>
> Fixes: 5c26f9a78358 ("libbpf: Don't use cxx to test_libpf target")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied. Thanks
