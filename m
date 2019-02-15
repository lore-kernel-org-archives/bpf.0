Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D88C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 17:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46B421927
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550250943;
	bh=Y16TlgUijl34yiyB8gKRW8vrXnyW2mNYWigIEqpTLh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YaOl45BmHKIla4Cs2RrjQeG3xJYISl8xTjUuJPjXd010HR74xdZFApxJSgnCgJrp2
	 3Ow5LsOg1Zy60ACq+UDzP3bQBZjbHbxH3rWrnAwLfld8ScFv+T2H0EDbSxMtwi0V9T
	 L5LdFTS5wvcYVCSagfev8MfaKhl6y4xpyRmDbwUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfBORPm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:15:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfBORPm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Feb 2019 12:15:42 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C9112190C;
        Fri, 15 Feb 2019 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550250941;
        bh=Y16TlgUijl34yiyB8gKRW8vrXnyW2mNYWigIEqpTLh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7ES5EbcqZpJOxYdLLDTv9MIEBa4387EahN2d98SpVbt0f7kSOzvzqD31ayuAy34x
         d6C93rOtLY3lRT5erA7PxRavtYgtt0CjdeOEzkcEhjtGP1C2pda0m4X96dYu9gSxuV
         Wl4g/GiYW/vibWYHSEAlJe3Ree3MEKX3OA4rFRs4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A245D410D5; Fri, 15 Feb 2019 14:15:38 -0300 (-03)
Date:   Fri, 15 Feb 2019 14:15:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
Message-ID: <20190215171538.GB31177@kernel.org>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org>
 <20190214131156.GU3269@kernel.org>
 <20190214132029.GA7074@kernel.org>
 <20190214140118.GC7074@kernel.org>
 <CAEf4BzYpCieVmjuwW-yuiOLuAfhZ9oTPGCZM-O88Jii2rrnP0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYpCieVmjuwW-yuiOLuAfhZ9oTPGCZM-O88Jii2rrnP0w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 14, 2019 at 08:37:51PM -0800, Andrii Nakryiko escreveu:
> On Thu, Feb 14, 2019 at 6:01 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Thu, Feb 14, 2019 at 10:20:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Feb 14, 2019 at 10:11:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Thu, Feb 14, 2019 at 09:47:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Wed, Feb 13, 2019 at 09:43:43PM -0800, Andrii Nakryiko escreveu:
> > > > > > happy with it. So consider this email a solicitation for naming
> > > > > > suggestion. Keep in mind, that all the pahole's functions of the form
> > > > > > btf__xxx will be renamed as well for consistency. If you like
> > > > > > btf_info, let me know as well, I'll just stick with it.
> > > >
> > > > > Can you try thinking if splitting this further into 'struct btf_loader',
> > > > > 'struct btf_encoder' that would live in the pahole sources and that
> > > > > refer to a 'struct btf' that lives in libbpf (or in libbtf, at some
> > > > > point) is a move that eases your current needs?
> 
> I think pahole would be simpler by using struct btf for btf_loader and
> separate struct btf_enc (or whatever name we come up with) to encode
> BTF during DWARF->BTF conversion. See below about mutable vs immutable
> BTF representations. For immutable parts libbpf's struct btf should be
> enough, though pahole is dealing also with endianness issues, so we'll
> need to resolve that somehow.
> 
> > > >
> > > > So, the btf__new() in tools/lib/bpf/btf.c is basically a variant of
> > > > btf__new() in the pahole sources, probably we should go ahead and make
> > > > pahole use that btf__new() and do changes in tools/lib/bpf/btf.c to
> > > > allow for it to access internal state that it needs to do its job?
> > >
> > > No, we can't, because tools/lib/btf/btf.c btf__new() is centered on
> > > getting some BTF buffer no matter where it comes from and passing it to
> > > the kernel.
> 
> Yes, libbpf's struct btf is immutable read-only view of .BTF section
> that can come from either file or kernel. When I'll be adding BTF
> writing (encoding) API, it probably will be done using something
> similar to pahole's struct btf, that supports dynamic growth of types

Ok, I noticed that libbpf's btf__new() does load things into the kernel,
perhaps we should have it not do that and instead have some other method
for asking it to send the data to kernel, i.e.:

	struct btf *btf = btf__new();
	int err = btf__load_to_kernel(btf, data, size);

Or have multiple constructors, each specifying what it actually does,
i.e.:

To get a btf data + size and insert it into the kernel, getting its fd,
etc:

	struct btf *btf = btf__new_to_kernel(data, size);

For asking for BTF info that is already in the kernel to be obtained for
tooling to parse maps in running bpf programs:

	struct btf *btf = btf__new_from_kernel(fd);

And for the pahole case it would be:

	struct btf *btf = btf__new_from_elf(file-with-BTF-ELF-section)

that would then be used to do the encoding, etc.

> and strings sections. Then, once application is done constructing BTF,
> that modifyable struct can be "sealed" into read-only struct btf.
> Whichever way we'll go about that, there should be minimal changes to
> pahole to be able to reuse that functionality.
 
> > > So probably we should backtrack to my previous suggestion of having
> > > pahole use 'struct btf_loader', or even more explicitely, 'struct
> > > btf_elf' to make extra clear that this has nothing to do with the
> > > kernel, its purely about loading/encoding the BTF info from/to a ELF
> > > file.

> > So, I have this in my private branch, please see if this helps get
> > things moving forward:
 
> Yes, this is exactly what I needed, thanks for doing this massive
> renaming! See just one nit below about probably unintentional file
> name change.

yeah
 
> > @@ -645,7 +636,7 @@ static int btf__write_elf(struct btf *btf)
> >                         llvm_objcopy = "llvm-objcopy";
> >
> >                 /* Use objcopy to add a .BTF section */
> > -               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", btf->filename);
> > +               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btfe", btfe->filename);
> 
> This is probably unintentional change, though not a problem per se.
 
Eagle eyes, I'll fix that.

Thanks,

- Arnaldo
