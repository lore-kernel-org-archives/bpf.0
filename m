Return-Path: <SRS0=Lh3l=QV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6A5C43381
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF3B222D4
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550150434;
	bh=/DvLFXETul2dyzaosIEUJVSAA+/Cgjibd0pVX9htHpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uW85lsdu8PIJEREx/Na3goJeW7DQEBJbYlSrBaw2IAZ76z2NP+CeHQPpHkb+aKskR
	 5lBJTv8u/FJ+cfe2wOr/lwVzOawtbYL0MS6hGfibFApSKv9hV+P1y1R4BZPHAqPFEJ
	 OaML6NHlqvPbKuGH6+7xbcxPmwB3eUj6jUwWKEgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404049AbfBNNUe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbfBNNUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Feb 2019 08:20:33 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C1A218EA;
        Thu, 14 Feb 2019 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550150433;
        bh=/DvLFXETul2dyzaosIEUJVSAA+/Cgjibd0pVX9htHpA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BrdTlsiQ1u7UfU7HEy4wAx23001KuDjK0+Ff0aJiwwdM8xY97yIFonS81MX67DDmD
         iN9PDpzsnYW6DnRoOGmBLUfsGLcBAi32K4XqN4wbqohBN0/bGCZxcghPUTe/el/VT2
         9lqP/uWdEXRJFl53VA1lu0VCUas1eo7g7N16DIdM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7169410D5; Thu, 14 Feb 2019 10:20:29 -0300 (-03)
Date:   Thu, 14 Feb 2019 10:20:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
Message-ID: <20190214132029.GA7074@kernel.org>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org>
 <20190214131156.GU3269@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214131156.GU3269@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 14, 2019 at 10:11:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Feb 14, 2019 at 09:47:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Feb 13, 2019 at 09:43:43PM -0800, Andrii Nakryiko escreveu:
> > > happy with it. So consider this email a solicitation for naming
> > > suggestion. Keep in mind, that all the pahole's functions of the form
> > > btf__xxx will be renamed as well for consistency. If you like
> > > btf_info, let me know as well, I'll just stick with it.
> 
> > Can you try thinking if splitting this further into 'struct btf_loader',
> > 'struct btf_encoder' that would live in the pahole sources and that
> > refer to a 'struct btf' that lives in libbpf (or in libbtf, at some
> > point) is a move that eases your current needs?
> 
> So, the btf__new() in tools/lib/bpf/btf.c is basically a variant of
> btf__new() in the pahole sources, probably we should go ahead and make
> pahole use that btf__new() and do changes in tools/lib/bpf/btf.c to
> allow for it to access internal state that it needs to do its job?

No, we can't, because tools/lib/btf/btf.c btf__new() is centered on
getting some BTF buffer no matter where it comes from and passing it to
the kernel.

So probably we should backtrack to my previous suggestion of having
pahole use 'struct btf_loader', or even more explicitely, 'struct
btf_elf' to make extra clear that this has nothing to do with the
kernel, its purely about loading/encoding the BTF info from/to a ELF
file.

- Arnaldo
