Return-Path: <SRS0=TB1Z=WW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D5C3A59E
	for <bpf@archiver.kernel.org>; Mon, 26 Aug 2019 05:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF680217F4
	for <bpf@archiver.kernel.org>; Mon, 26 Aug 2019 05:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApM6RTYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfHZFdm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 26 Aug 2019 01:33:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36876 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfHZFdm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Aug 2019 01:33:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id s14so13170785qkm.4;
        Sun, 25 Aug 2019 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhOFBbgl6P8q0s+wLsiNkGdReLCBCFDR8bQudp8LXo0=;
        b=ApM6RTYD0fWpWEt11GrxnqMSqUyIIBIc/Cq9v8pAuMVwyOob+gsIRnTT6SkmL0Nz7b
         4kSn2SdzxoiR/iQ4p9S/1Q0FUfwSUUr0jW9bfJivakgtkV48kJ+tCzgnsKWiD4xfWigf
         TRvxuVVGnbrUoHKLxZVqSXjYRg90LTNMW91OCIHyx+YRQrqDxD/7wFYIU30Yz5YYe1ya
         5soNsWpop9PZ48MxKxvUQJHkZQG6YRbANHCZpAD79g3T1Q1W4uf0PAsTrpuZFYOJErOa
         sqUfs1dSHabxAAxQtZtlDjTsz1iGsPHhxfjLAfPf8MqNlNaKYTaoNxCXcQMjcClTCg9a
         C1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhOFBbgl6P8q0s+wLsiNkGdReLCBCFDR8bQudp8LXo0=;
        b=n3vUdrWjNpRXkLC6KAoTOiDz1aKCiJvENsmxYEv7k1sy2p0TnHw1z3Doab+4yJjnb4
         sRoyCbdVlZ017Rr3tSfvp0PZ8K2oB3RfIVzR4rnrX0MPK9xz0gNoX4KFRzUNAjBFML4Z
         MtFw/Z0plbwTtbrjGEwrnbUCr/pYyJdLN4Xk3O4x3+3uaQP8xqRz6QdF/k07Yz3a0F78
         h9Asf/wXprUZJy4dbe8s+INqwUcIBPr98OIGypXVGJ0y2RkgAXTQmZnU+wkWpgj3Lwsb
         Wn+mUQYDrVMbStNbR2nnrctEyD7hC4CW8dFWiJtbz5ahFCd3YSsf7Uol/nD3eJXpP6PE
         3u6Q==
X-Gm-Message-State: APjAAAWN6XpUotlsVtqsLUFLjybTZQcgopG8Wpl3rC/gzkudrPJ4ZBJr
        NbQjO1ggRbrez2dYELzlo8Fg6Ib1261dRZ30du0=
X-Google-Smtp-Source: APXvYqzics8yC4CKYC/l/Mur3qoh33FSvSB3tSSsA0JhZ5NA1kWsVHr72inJYa6enXJp6+ei3wr2nJSktPwFkZJxJ3E=
X-Received: by 2002:ae9:e8d6:: with SMTP id a205mr13808102qkg.241.1566797621511;
 Sun, 25 Aug 2019 22:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190823055215.2658669-1-ast@kernel.org> <20190823055215.2658669-5-ast@kernel.org>
In-Reply-To: <20190823055215.2658669-5-ast@kernel.org>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 25 Aug 2019 22:33:30 -0700
Message-ID: <CAPhsuW4KOsW4aharugR+665YCcM5G1b5t9xL+ZeKo9UjUmPYSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: add precision tracking test
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 23, 2019 at 3:00 AM Alexei Starovoitov <ast@kernel.org> wrote:
>
> Copy-paste of existing test
> "calls: cross frame pruning - liveness propagation"
> but ran with different parentage chain heuristic
> which stresses different path in precision tracking logic.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
>
