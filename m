Return-Path: <SRS0=+bqE=YK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08FCECE58D
	for <bpf@archiver.kernel.org>; Thu, 17 Oct 2019 19:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEB121835
	for <bpf@archiver.kernel.org>; Thu, 17 Oct 2019 19:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tn1Tj5N1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439344AbfJQTRO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Oct 2019 15:17:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40796 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfJQTRO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 15:17:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id y144so2947391qkb.7;
        Thu, 17 Oct 2019 12:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B3HAaoAbfAUuB/M9RxcUgMrecsA/2Vw04iSOtO6gkvk=;
        b=tn1Tj5N1zsaTV/WI/02oT3HLDwns6Ui1RTz+3ry+fNNgVyAuJq7dsrW2X1/XuTm8T4
         LAKn5xlUPkQaHa50Ejitx+9mSj0cENMP9fTg8w8395eBSoRgC+7flqgGW6kjRYS8VYiV
         22L7p5M8t+a4hg/4ib8n5OkRRHmSt36vWblcHIo4HGwiJWpp95L/MXQ+L7ahwLrkQnjp
         VwvBuVcUZVIR07l5HLlEWECgZDjDQnzruhVE2ArFyBxdPi84qrRibagSbhr6f+H6DWuf
         ThJ9KFvbhmqhuBH2LEbLu7V3/YssVk+3JUwZ4atrci4hNsSGi+B+YQKSz3cauY9oWTja
         J+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B3HAaoAbfAUuB/M9RxcUgMrecsA/2Vw04iSOtO6gkvk=;
        b=R0blZKCfEKDipZPjk/6VhrF58MH+E6WlRIq+6chfkqQULakHPUP9DHwManx3/TvjDN
         7G+BKfVoyP3529lS7g6qGFNaQJpxVreFyCv8RbvVjrm6yBHX9ZiVUY+9Kpt2fi/GPQWA
         8aZZv8SU9DC2RqAwzqDkJHanKKhEAFEc4qRXjgmGbgCr42Qx8zrNJc+PsY++00eHNuJl
         JZjUkvJrVq3Ppk5dpCfRJtSmFOZV18iqoqk+fH0sXdjrTQmksuSVYgOq38CKZA0jfq9k
         GxZJHyy5vmZ+fYm4hMigJzYfY0KwdqkpnFtz/HJnTXFPjKpvRUNARHdK1OQbuIi16qGR
         Vx0Q==
X-Gm-Message-State: APjAAAVdzspug3h4JYscwfs/rET58CNEJcgVgKwAUUt55UNTfe35qqW5
        If5PT+OxYQfb8P/PRGqXBdMmkxfacG3moAPxmsw=
X-Google-Smtp-Source: APXvYqz8jGuxwnPGeHC3kSxv//tH5+YofF4xAtN70Wim4+0PtLkNkE9lgWhEIqQuablWUINYXIzHXkkGT/27BlDi1FI=
X-Received: by 2002:a37:b447:: with SMTP id d68mr4976996qkf.437.1571339832740;
 Thu, 17 Oct 2019 12:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191016132802.2760149-1-toke@redhat.com>
In-Reply-To: <20191016132802.2760149-1-toke@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Oct 2019 12:17:01 -0700
Message-ID: <CAEf4BzbshfC2VXXbnWnjCA=Mcz8OSO=ACNSRNrNr2mHOm9uCmw@mail.gmail.com>
Subject: Re: [PATCH bpf] xdp: Handle device unregister for devmap_hash map type
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 16, 2019 at 9:07 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> It seems I forgot to add handling of devmap_hash type maps to the device
> unregister hook for devmaps. This omission causes devices to not be
> properly released, which causes hangs.
>
> Fix this by adding the missing handler.
>
> Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up device=
s by hashed index")
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  kernel/bpf/devmap.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>

[...]

> +
> +               while (dev) {
> +                       odev =3D (netdev =3D=3D dev->dev) ? dev : NULL;
> +                       dev =3D hlist_entry_safe(rcu_dereference_raw(hlis=
t_next_rcu(&dev->index_hlist)),

Please run scripts/checkpatch.pl, this looks like a rather long line.

> +                                              struct bpf_dtab_netdev,
> +                                              index_hlist);

[...]
