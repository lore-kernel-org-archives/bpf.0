Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0BCC43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EEE21A4C
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550252602;
	bh=3OC2ylz/xp6Bn9TupbmpRDB3V8XjuOSVYHKvaT954hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r4yn1hwuOcI96QHgEPzVc4X9aNZTOhivZZZVxMQ3wL8Y/iGfoWAMNhXOwGCa/wSGr
	 DuuUvbNe4Fpe23IavXSCh9Pjqoz95OX2UwXSZ+7jCzOpBwqNaYxOPy/83FDI6DQZX4
	 XVHxjbnsaWpMNkiME8wCQYusZAfpq3RTm7XYBr90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfBORnV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:43:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfBORnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Feb 2019 12:43:21 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A1521927;
        Fri, 15 Feb 2019 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550252600;
        bh=3OC2ylz/xp6Bn9TupbmpRDB3V8XjuOSVYHKvaT954hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fpwizs6Dsf0xtq9dyY73fScQ8cHszSRQdOEO8qeVUQb/0rIhbmyS9tCblvCUyICdQ
         vKrIchio81OQkP/HPY9EY86/X18UjDWmjr+KllqBpYSazgj4Q3TECzag863piZlTkC
         5IC1XKBegCQvUB7Rj+FXhGI9hczdoXTvgtqq2WYo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1EC28410D5; Fri, 15 Feb 2019 14:43:17 -0300 (-03)
Date:   Fri, 15 Feb 2019 14:43:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
Message-ID: <20190215174317.GG31177@kernel.org>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org>
 <20190214131156.GU3269@kernel.org>
 <20190214132029.GA7074@kernel.org>
 <20190214140118.GC7074@kernel.org>
 <CAEf4BzYpCieVmjuwW-yuiOLuAfhZ9oTPGCZM-O88Jii2rrnP0w@mail.gmail.com>
 <20190215171538.GB31177@kernel.org>
 <CAEf4BzY_uZfb0WrmFjVZiOgttJzc4C81NX3_K0K7uAugHKUWaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY_uZfb0WrmFjVZiOgttJzc4C81NX3_K0K7uAugHKUWaA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 15, 2019 at 09:25:48AM -0800, Andrii Nakryiko escreveu:
> On Fri, Feb 15, 2019 at 9:15 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Thu, Feb 14, 2019 at 08:37:51PM -0800, Andrii Nakryiko escreveu:
> > > On Thu, Feb 14, 2019 at 6:01 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > Yes, libbpf's struct btf is immutable read-only view of .BTF section
> > > that can come from either file or kernel. When I'll be adding BTF
> > > writing (encoding) API, it probably will be done using something
> > > similar to pahole's struct btf, that supports dynamic growth of types

> > Ok, I noticed that libbpf's btf__new() does load things into the kernel,
> > perhaps we should have it not do that and instead have some other method
> > for asking it to send the data to kernel, i.e.:

> >         struct btf *btf = btf__new();
> >         int err = btf__load_to_kernel(btf, data, size);

> > Or have multiple constructors, each specifying what it actually does,
> > i.e.:

> > To get a btf data + size and insert it into the kernel, getting its fd,
> > etc:

> >         struct btf *btf = btf__new_to_kernel(data, size);

> > For asking for BTF info that is already in the kernel to be obtained for
> > tooling to parse maps in running bpf programs:

> >         struct btf *btf = btf__new_from_kernel(fd);

> > And for the pahole case it would be:

> >         struct btf *btf = btf__new_from_elf(file-with-BTF-ELF-section)

> > that would then be used to do the encoding, etc.

> We already did that a couple of days ago, that code wasn't yet
> mirrored into github.com/libbpf/libbpf until yesterday (it was merged
> this morning). We now have btf__new(data, size) that just constructs
> in-memory BTF struct with index for types. And we have
> btf__load(struct btf* btf) that can load that into kernel.

cool
 
> We already have equivalent of btf__new_from_kernel(fd) -- btf__get_from_id(fd).

cool, if it allocates space for sizeof(*btf) and returns this newly
allocated object, then please consider renaming it to btf__new_from_id(fd).

> Adding something akin to btf__new_from_elf() might be a good idea as
> well, for completeness.

Its nice to be on the same page :-)

<SNIP>
 
> > > > @@ -645,7 +636,7 @@ static int btf__write_elf(struct btf *btf)
> > > >                         llvm_objcopy = "llvm-objcopy";
> > > >
> > > >                 /* Use objcopy to add a .BTF section */
> > > > -               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", btf->filename);
> > > > +               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btfe", btfe->filename);
> > >
> > > This is probably unintentional change, though not a problem per se.
> >
> > Eagle eyes, I'll fix that.
 
> :)

- Arnaldo
