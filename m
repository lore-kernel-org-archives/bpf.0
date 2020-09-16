Return-Path: <SRS0=xxat=CZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6CCC43461
	for <bpf@archiver.kernel.org>; Wed, 16 Sep 2020 20:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D413A20770
	for <bpf@archiver.kernel.org>; Wed, 16 Sep 2020 20:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBFNHl8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgIPUpJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgIPUpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 16:45:07 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E01C06174A;
        Wed, 16 Sep 2020 13:45:06 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id g96so1521059ybi.12;
        Wed, 16 Sep 2020 13:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a9McxN0SPcs/brf1883/a8qVYY3w5PNE9zRZ22kWcRk=;
        b=hBFNHl8VKHdu0bMQEIo7Huplgr8OaeHxOaNxi/9ASLqR8KxJY2Ao1BNb1V+M+c9lTg
         r9DBXjfMiTPgGu0H9PqiPKuSfwEagyVbq1T4d1A0gwI7A/pWVf8wuVZBZtybynO/g15W
         0ASVoIPojLnbus2iG9NilaF8AO1Ecxzz8SmM+YUFNlgwppNffjkkGoVicv86jWEfk8Dn
         qPGLvRXEs+dH+vboMLcNN690CROOSXE/6o1z6vbKJewwtNLPzZrL1v7GvsQHzefyK9Kw
         q1A/OKnQdVf3kyq5hKSRa3RdRvdHs9c3OOpCujmaUr21BlbJ3jfVhWmCE4MZCRLkOvPL
         c1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a9McxN0SPcs/brf1883/a8qVYY3w5PNE9zRZ22kWcRk=;
        b=kbQEsGcrwSCEjyIHz/v4Bg0xOjhT2mUOsPlwHx+1kuwCzPIGRh+TdabHDrq+wMYSlg
         xRiW6RGROkpvvH82BJ2zjDeFWBWK0Kw0srQrYkQZdvTosGSIEh9r3HvQWsVy6qHlOc9u
         EM0AkZZtiRqOS4oN+7aVZsnNFB5lH/sLFnU/91Mpa80Ys/vfOApN+PbRfHy7f0yGOr9I
         XA4n6YBh6e+OVx88nxO/USNNoLu6Up6r2PsEaK1irdE5hgz1YI5IYPjFhgVZvlilIM/Q
         ucwpMwGn8D9L69N8rDjMJfqtzevpvy+ndCkGLQFxiscpNVU2B69lP2SJYj82WCyMloCK
         Lo0w==
X-Gm-Message-State: AOAM530lk8thYWC0UrYetj6elhvkR65p5NUdlhnpKCQ3/2Pd4euc/yk1
        PyeyHUH6S0oAg2P4sNmSSGa2VH5d2PA8/Uktz20=
X-Google-Smtp-Source: ABdhPJxFmQi3hG59ryei3OUQBmRUhVx/C5Pyc3w8gF8Juen+cyyKHcwqrv4XeTjDfnxDiVK+BiYVjGF+Dp8QJ6TRoTc=
X-Received: by 2002:a25:33c4:: with SMTP id z187mr22702413ybz.27.1600289106079;
 Wed, 16 Sep 2020 13:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <160017005691.98230.13648200635390228683.stgit@toke.dk> <160017006573.98230.17217160170336621916.stgit@toke.dk>
In-Reply-To: <160017006573.98230.17217160170336621916.stgit@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 16 Sep 2020 13:44:55 -0700
Message-ID: <CAEf4BzZg7rSaRJ5GkcEoOvV2TKTA5etsr0xn_dYMtQL7Ly-w_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 8/8] selftests/bpf: Adding test for arg
 dereference in extension trace
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 5:50 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> From: Jiri Olsa <jolsa@kernel.org>
>
> Adding test that setup following program:
>
>   SEC("classifier/test_pkt_md_access")
>   int test_pkt_md_access(struct __sk_buff *skb)
>
> with its extension:
>
>   SEC("freplace/test_pkt_md_access")
>   int test_pkt_md_access_new(struct __sk_buff *skb)
>
> and tracing that extension with:
>
>   SEC("fentry/test_pkt_md_access_new")
>   int BPF_PROG(fentry, struct sk_buff *skb)
>
> The test verifies that the tracing program can
> dereference skb argument properly.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

Looks good, with a minor CHECK() complaint below.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/prog_tests/trace_ext.c |  113 ++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/test_trace_ext.c |   18 +++
>  .../selftests/bpf/progs/test_trace_ext_tracing.c   |   25 ++++
>  3 files changed, 156 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/trace_ext.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_trace_ext.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_trace_ext_trac=
ing.c
>

[...]

> +       err =3D test_trace_ext_tracing__attach(skel_trace);
> +       if (CHECK(err, "setup", "tracing/test_pkt_md_access_new attach fa=
iled: %d\n", err))
> +               goto cleanup;
> +
> +       /* trigger the test */
> +       err =3D bpf_prog_test_run(pkt_fd, 1, &pkt_v4, sizeof(pkt_v4),
> +                               NULL, NULL, &retval, &duration);
> +       CHECK(err || retval, "",

please don't use empty string here

> +             "err %d errno %d retval %d duration %d\n",
> +             err, errno, retval, duration);

who and why cares about duration here?..

> +
> +       bss_ext =3D skel_ext->bss;
> +       bss_trace =3D skel_trace->bss;
> +
> +       len =3D bss_ext->ext_called;
> +
> +       CHECK(bss_ext->ext_called =3D=3D 0,
> +               "check", "failed to trigger freplace/test_pkt_md_access\n=
");
> +       CHECK(bss_trace->fentry_called !=3D len,
> +               "check", "failed to trigger fentry/test_pkt_md_access_new=
\n");
> +       CHECK(bss_trace->fexit_called !=3D len,
> +               "check", "failed to trigger fexit/test_pkt_md_access_new\=
n");
> +
> +cleanup:
> +       test_trace_ext_tracing__destroy(skel_trace);
> +       test_trace_ext__destroy(skel_ext);
> +       test_pkt_md_access__destroy(skel_pkt);
> +}

[...]
