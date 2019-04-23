Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329D1C10F14
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 04:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0018920843
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 04:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgId/Ym7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfDWEGT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 00:06:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36010 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfDWEGT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 00:06:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so14630663qtn.3;
        Mon, 22 Apr 2019 21:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYD6dyH8eP1vSk7JMGsYKrySpQ07bbrpqoCW52yF7H8=;
        b=XgId/Ym7XgQwkCjAQjxlUeJRUQzCbxzW6qYaWccSOGaz5LmKBlVEW0UgFihPENZ25h
         8100GCm4LKYo0h7yTYA0/D4rooeRnSIpj5GdQF80frOp0XNg5ZEjaFWhJbghDjW7gj+m
         JvZZ9e8BM15fUXSGhwSt1DXVb5qLkuyXL0Lx6vIX8xCodZp9wIX2qUQPdBPc/2st/Wfz
         F53xamQrGwUIxIMwDaIamv4UV09zIBSGRXzJEvhho11b2aNs16Tf4FaIQBSmLRtNoThk
         vZwJ1mlqIwH8uwUUn4yihpik3qZhxyYjFqenMWnI8Y8wdXZMalxUAF/dz7Hzq/XWawx8
         7k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYD6dyH8eP1vSk7JMGsYKrySpQ07bbrpqoCW52yF7H8=;
        b=CpoE0sodToIgZm0vKDvfj7xNWSDZKxb1+DqtPewNtzOfJwJxmoFYjhogFLiMNW7tEr
         GB7E7hkp9wF64+lkdCAj04g6OwGeeMQzaVXTml88TErGTVTnUSIxAmTxH+GvTWFthpLo
         BdQjJs71uH9+Ay4QX6AG75hauWr80vs9mtKak/iG87orbtZEeRE0GiDTNIe2M04xPpne
         Tp3DAA8CdisOikuxp1gyKiYGsODnc0z79w/MjqVnnXcOHZsP6DMGcKlkfQKaVEZ0MXVO
         nE28bgMAhrtD4HrcD04Mu6XiluO/Xvm4XB51lCjjiZZ1SqhsSIyfaWGtSYSeEuOnObS9
         Lo9A==
X-Gm-Message-State: APjAAAXE8S9s6OK0DS4PsM63nxbBBeqiWwZJdsfZh2YQn9zjJhCfEwF7
        DozXByZXJzUUjmoMhxGHin2TAGdRg1qEtJMD9+Q=
X-Google-Smtp-Source: APXvYqxa76InVq6AZj1ekwabjhImlTcj3BJ29etJ+GfyFXzDWJmJbZkB7Q9iWRf6ooeh/9nwBYFrF3o74+8UHfveEbk=
X-Received: by 2002:ac8:311a:: with SMTP id g26mr6021172qtb.27.1555992378262;
 Mon, 22 Apr 2019 21:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190409212018.32423-1-daniel@iogearbox.net> <20190409212018.32423-12-daniel@iogearbox.net>
 <CAEf4BzZkkA2DouqZXH=oG9NJ7Gq7YXK5+OL=RAYbVthxgt-zcQ@mail.gmail.com> <82026bc1-066d-9779-ec3a-83e086fc1780@iogearbox.net>
In-Reply-To: <82026bc1-066d-9779-ec3a-83e086fc1780@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Apr 2019 21:06:07 -0700
Message-ID: <CAEf4BzbYZAsNkVkYddws7inyFkFGmwkQ9Yb0G2hUdw_5Kufgaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 11/16] bpf, libbpf: support global
 data/bss/rodata sections
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Joe Stringer <joe@wand.net.nz>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>, Jann Horn <jannh@google.com>,
        Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 22, 2019 at 5:58 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 04/19/2019 03:18 AM, Andrii Nakryiko wrote:
> > On Tue, Apr 9, 2019 at 2:20 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>
> [...]
> >> +       def->type = BPF_MAP_TYPE_ARRAY;
> >> +       def->key_size = sizeof(int);
> >> +       def->value_size = data->d_size;
> >> +       def->max_entries = 1;
> >> +       def->map_flags = type == LIBBPF_MAP_RODATA ?
> >> +                        BPF_F_RDONLY_PROG : 0;
> >
> > This is breaking BPF programs (even those that don't use global data,
> > as they still have .rodata section, though I haven't investigated its
> > contents) on kernels that don't yet support BPF_F_RDONLY_PROG flag
> > yet. We probably need to probe support for that flag first, before
> > using it. Just giving heads up, as I just discovered it trying to sync
> > libbpf on github.
>
> Thanks for reporting! On a quick look test_progs (modulo global data test)
> seems to pass with an slightly older kernel. I'll retry with a latest LLVM git
> tree tomorrow with our test suite. Did you see a specific one failing or do you
> have a reproducer in case it's something not covered where I could look into?

You need to add something like this to trigger .rodata section
generation (BPF code doesn't have to use that struct, it just needs to
be present):

const struct { int x, y; } bla = {};

This will cause libbpf to create a map for .rodata and specify
BPF_F_RDONLY_PROG flag, which on older kernels will be rejected.
