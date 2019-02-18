Return-Path: <SRS0=+2DZ=QZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97455C43381
	for <bpf@archiver.kernel.org>; Mon, 18 Feb 2019 12:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1FF217F5
	for <bpf@archiver.kernel.org>; Mon, 18 Feb 2019 12:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550493884;
	bh=0Qb3ZhTksMlm0W8/gx4hojS5ct/3rxFRYoSWqYinLK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1t06SG+Yy0lPyXW4JDqSGoF4ZoYMjrpgv5LPnmKTqQoK/unsBJZLDaNJayE9utb3v
	 XqJbXcgTCe/D6658XNYsv9woYMnFF3Ba/6dCZVc7z6CykcEm0QzzFJwx5F3ny1JR/a
	 EtjU5elbIEW4QdpuwR1VfM65cswABXKymoDtd/TY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfBRMoo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:44:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfBRMon (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Feb 2019 07:44:43 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C59672173C;
        Mon, 18 Feb 2019 12:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550493883;
        bh=0Qb3ZhTksMlm0W8/gx4hojS5ct/3rxFRYoSWqYinLK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWC9emWoRFmavbg9bwBKO2QjZrdXZeBREfhD7F+7ESuvWYD/rWZNJlb1l96p5MKic
         K72ufJtmE3RiC9xjbs9kWv333gOukbmnPKjCotZUYfW/U+4oh69KzQukNhgEMRdREG
         62SpONvgL/jJvqkKzcujwnQLf1LEc9MYmY0iMN1c=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A9BF410D5; Mon, 18 Feb 2019 09:44:40 -0300 (-03)
Date:   Mon, 18 Feb 2019 09:44:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
Message-ID: <20190218124439.GM31177@kernel.org>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org>
 <b156837f-ed18-caf6-7120-5ecfabd4c5ed@fb.com>
 <20190215172515.GC31177@kernel.org>
 <0b1583e1-5e19-0685-7206-ab3e4bb20b70@fb.com>
 <ebb687e2-4a68-5c7f-0f92-6d03e34c5bd0@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb687e2-4a68-5c7f-0f92-6d03e34c5bd0@iogearbox.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 15, 2019 at 09:21:22PM +0100, Daniel Borkmann escreveu:
> On 02/15/2019 07:47 PM, Alexei Starovoitov wrote:
> > On 2/15/19 9:25 AM, Arnaldo Carvalho de Melo wrote:
> >> Em Fri, Feb 15, 2019 at 05:17:27PM +0000, Alexei Starovoitov escreveu:
> >>> On 2/14/19 4:47 AM, Arnaldo Carvalho de Melo wrote:
> >>>> I wonder if we should have a libbtf, with the same licensing as libbpf,
> >>>> as, for instance, pahole would be interested only in the btf parts, be
> >>>> it encoding, loading and pretty printing.

> >>> I don't think it's possible to do such split.
> >>> .btf.ext section only makes sense together with bpf prog.

> >> Well, that part, that is not about types and only makes sense together
> >> with the BPF parts could stay in libbpf, no?
 
> > I don't see how.
> > .btf.ext is using string section of .btf
> > It's all connected.
 
> > Even if it was possible to somehow split them
> > I think one big library is better than a bunch of smaller ones.
> > It's written in C so .text size concern doesn't apply.

> +1, I also think one single library is much better. Keeps dependency
> management simple and only after ~3.5 years now mainstream distros
> have finally started to ship libbpf as a package. Splitting would just
> create more hassle for users and slow down wider adoption.

I wasn't thinking about two different tarballs distributed independently,
just two libraries as tools like pahole don't use the BPF parts at all,
just the type and function descriptions, i.e. BTF.

I.e. something like glibc has, where its a single package, but it comes
with multiple libraries for well defined things like pthreads, etc.

- Arnaldo
