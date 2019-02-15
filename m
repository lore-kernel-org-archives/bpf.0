Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE2FC43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 17:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470DA222BE
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550251519;
	bh=e8VyFpv1LIAYOgV9vsmIAEMTv6xYdWjLZNT/2qGxNXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YBPaxmLroibolkHbwK3GNZEHK485az37bweIsx2e6r36EP8FWtlVBOETdkZXBdexD
	 YVmfjP8By/KFffEo0pNzf2I7VVY5w28mkSpQfzad8HWsU0RhIiyI3qTX1Kqy7hk3Jy
	 wl8hzilDnZTg2IRStuD3GI8rgTE4G0LVCOHSptMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbfBORZT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:25:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfBORZS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Feb 2019 12:25:18 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC3C21929;
        Fri, 15 Feb 2019 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550251518;
        bh=e8VyFpv1LIAYOgV9vsmIAEMTv6xYdWjLZNT/2qGxNXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=soGnTNopUykyv/MBD+dYJlu5HkJBWt62cFwpfcOKbBOrDNovfVxV0Znq8rAW7csM1
         Ae9CXM3uIFupAL9uQAL7Zpf6EOIAmbmnEOcTBkUvmhl60Bs10wms8oI766Q21Z23ts
         qkOc8tgMxkhHU/KoEj5WtshiC6Pod1Re7IQfnPZA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 33FB5410D5; Fri, 15 Feb 2019 14:25:15 -0300 (-03)
Date:   Fri, 15 Feb 2019 14:25:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
Message-ID: <20190215172515.GC31177@kernel.org>
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org>
 <b156837f-ed18-caf6-7120-5ecfabd4c5ed@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b156837f-ed18-caf6-7120-5ecfabd4c5ed@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 15, 2019 at 05:17:27PM +0000, Alexei Starovoitov escreveu:
> On 2/14/19 4:47 AM, Arnaldo Carvalho de Melo wrote:
> > I wonder if we should have a libbtf, with the same licensing as libbpf,
> > as, for instance, pahole would be interested only in the btf parts, be
> > it encoding, loading and pretty printing.
> 
> I don't think it's possible to do such split.
> .btf.ext section only makes sense together with bpf prog.

Well, that part, that is not about types and only makes sense together
with the BPF parts could stay in libbpf, no?

- Arnaldo
