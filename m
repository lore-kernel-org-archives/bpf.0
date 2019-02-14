Return-Path: <SRS0=Lh3l=QV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE1C43381
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 12:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D06222B6
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550148483;
	bh=0Wp1BJQrnoyEi1TnISbb1cz6LmUntOkPDd9yG2YFi3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IgPAjc0VTqti1PxwtZ2mB2/egaMu1bZN5cNDWW83Fn2O/uPSctjVIyY4w91dO3FYp
	 tKI3199O8mUiDynS07FsbXRIOonhdmINOehY5l8jYQBigZgxLh52Vo6EoCkHRjRejD
	 eWK0Cx4jRSvKvmOarsFiOl7L0F7i0tNBrbm26KCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403921AbfBNMsD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfBNMsD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Feb 2019 07:48:03 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B77218FF;
        Thu, 14 Feb 2019 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550148482;
        bh=0Wp1BJQrnoyEi1TnISbb1cz6LmUntOkPDd9yG2YFi3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rg2apVSF2k9Hl/YVyTnMUK64PF4dwrXf+DdCVK1wPJzDH4Xc+c1qi7fIqZDY3if5Z
         5bpL/Sry4zDVt3G9+dttUiEpCb+PHQmexYRYQlJTA5FszithFN7HNpLska6Ofq/7ev
         XGV4CX9kEFNHZ2UCRo0JRQCf4HA804Nn3v3hWY9c=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9DFC7410D5; Thu, 14 Feb 2019 09:47:57 -0300 (-03)
Date:   Thu, 14 Feb 2019 09:47:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
Message-ID: <20190214124757.GP3269@kernel.org>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 13, 2019 at 09:43:43PM -0800, Andrii Nakryiko escreveu:
> Hi folks,
> 
> I'm working on adding btf__dedup() support to pahole when doing DWARF
> to BTF conversion, which requires usage of libbpf from pahole. I've
> already added libbpf as a submodule and pahole now reuses btf.h header
> with all the btf struct definitions. Next step is actually using
> btf__dedup().
> 
> The problem with that is that both libbpf and pahole define their own
> incompatible versions of struct btf, which causes a lot of naming
> conflicts when I'm trying to use libbpf along those structs. Pahole
> has it's own internal library centered around struct btf with lots of
> useful methods to manipulate BTF data. My intent is to migrate most of
> that functionality (e.g., pretty-printing and BTF types construction)
> into libbpf, so maybe in the future pahole won't need it's own struct
> btf, but for now I'd like to avoid blocking on that.

I wonder if we should have a libbtf, with the same licensing as libbpf,
as, for instance, pahole would be interested only in the btf parts, be
it encoding, loading and pretty printing.

In fact the pretty printing part perhaps could be done exclusively using
the BTF parts, with the dwarf loader just being the current BTF encoder,
if we manage to not lose any information from DWARF, which is the case
for example, for multi dimensional arrays.

Having tools/lib/btf/ in the kernel sources would be nice for that, in
the long run I could even make a leaner pahole in tools/pahole/,
starting with the basic BTF pretty printing and in time getting the
other features, like struct reorganization to eliminate holes, etc, that
could, in time, even be something interesting to use in more situations.
 
> So to make progress I'll need to rename pahole's struct btf into
> something else. And I've been struggling to come up with good succinct
> name. The best I've got so far is btf_info, but I can't say I'm too

Humm, I think that what is being left for pahole is the encoding part,
right? So perhaps rename it to btf_encoder, the btf_loader part can use
libbpf's btf struct?

> happy with it. So consider this email a solicitation for naming
> suggestion. Keep in mind, that all the pahole's functions of the form
> btf__xxx will be renamed as well for consistency. If you like
> btf_info, let me know as well, I'll just stick with it.

Can you try thinking if splitting this further into 'struct btf_loader',
'struct btf_encoder' that would live in the pahole sources and that
refer to a 'struct btf' that lives in libbpf (or in libbtf, at some
point) is a move that eases your current needs?

- Arnaldo
