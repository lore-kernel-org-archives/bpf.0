Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D56C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 01:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3DC2075E
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 01:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArpMwuBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfC0BYs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:24:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46367 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfC0BYr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 21:24:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id r25so10096787lfn.13
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 18:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Zgy+tftiwcmnS91fclxH/E/8BYJ4r+DizxqgkTPmyk=;
        b=ArpMwuBtv9UM/eznnc3QZqIsCCfTKviX+if22zCSb2mdCRe5n5/8kKxXuKzobsh/cw
         4IH8w696n3Teyf1nvDDF9KWGb7LjfgiYMS46U6VT2rIMHl0X1xDLUVDrSupetkzSgYWz
         iXKJv8GK9aFBkg9ZspsPGwyec9oTYDZQlFev4jZ0LrD4xUEp44HbFD4ZI8Mrn6mZgRTP
         C6ZCBTi4qKx/0zECqH5E58ifLNDMcxp9PZmUD/ypCE7L3NjtwjwxkkMU4OEyenkAxdFo
         0zj0EqaxQGETt2hO0i/qSAI8M6RlI3ZhLIDgWuyaFUPPoo3Bnpd4nNgQEeXGVHIciHFe
         nrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Zgy+tftiwcmnS91fclxH/E/8BYJ4r+DizxqgkTPmyk=;
        b=uZTe+9r9ScV6lurnovTx4hh7XcFneEXA2QR5YfI06oV4mAyQoqG0Ufm9fJAQjfIrnm
         OLIQqshKkcGHJjOIDFUC0S/cXK+fpNNQmTJldji+j215bQksPPe8iJBHJUuF5KgrNGsB
         ZxSjmV7rCqv2ZckjXD/hMc2xXvlMG5Nw7HXkG9GiDUQVBMhns+LCRL7asR8Zz9l1W6vh
         HmTWhd/pOGAAWVkS9+LnAf0KT3cu9TBiT4Yz5ulhl8YXPCivWs3mfg5pSl3n7U0u5cLJ
         m8Sl2UN6+zqabwhO9dtTURFxRttSvLbOtYFfg4UjtfNekJsceKE73clYhUU4qFdEAAYB
         hI1A==
X-Gm-Message-State: APjAAAUu+lYmxWYUrXUm5FH67zxSSK42OpWQcg/ZNuMuJXnHj428uhQo
        UWZUUXqw2x42aolH5hZWGWJROwIQmrRShrJu1po=
X-Google-Smtp-Source: APXvYqym6SOZ4BrHyY3vtJiunZ0TuGdroIr5Iojhesh2irKY6K5ONTDUP/mfJY1H8NgyQLNyuz30xGql6zlj/y03up4=
X-Received: by 2002:ac2:4304:: with SMTP id l4mr8837196lfh.168.1553649885526;
 Tue, 26 Mar 2019 18:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190315201749.556085-1-andriin@fb.com> <51e9776a-a0c2-fb69-6b8c-82b220c3e18f@fb.com>
In-Reply-To: <51e9776a-a0c2-fb69-6b8c-82b220c3e18f@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Mar 2019 18:24:34 -0700
Message-ID: <CAADnVQL=JjRx33xjikY6O34Gpy_7m5L_oN1mOPq9Q8R4rbaG5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] kbuild: add ability to generate BTF type info
 for vmlinux
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 25, 2019 at 8:59 AM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 3/15/19 1:17 PM, Andrii Nakryiko wrote:
> > This patch adds new config option to trigger generation of BTF type
> > information from DWARF debuginfo for vmlinux and kernel modules through
> > pahole, which in turn relies on libbpf for btf_dedup() algorithm.
> >
> > The intent is to record compact type information of all types used
> > inside kernel, including all the structs/unions/typedefs/etc. This
> > enables BPF's compile-once-run-everywhere ([0]) approach, in which
> > tracing programs that are inspecting kernel's internal data (e.g.,
> > struct task_struct) can be compiled on a system running some kernel
> > version, but would be possible to run on other kernel versions (and
> > configurations) without recompilation, even if the layout of structs
> > changed and/or some of the fields were added, removed, or renamed.
> >
> > This is only possible if BPF loader can get kernel type info to adjust
> > all the offsets correctly. This patch is a first time in this direction,
> > making sure that BTF type info is part of Linux kernel image in
> > non-loadable ELF section.
> >
> > BTF deduplication ([1]) algorithm typically provides 100x savings
> > compared to DWARF data, so resulting .BTF section is not big as is
> > typically about 2MB in size.
> >
> > [0] http://vger.kernel.org/lpc-bpf2018.html#session-2
> > [1] https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html
> >
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Masahiro,
>
> could you please review this patch?
> It's been pending for 10 days!

Masahiro,
Ping!
