Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F29DC43334
	for <bpf@archiver.kernel.org>; Tue, 21 Jun 2022 16:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352036AbiFUQqL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiFUQqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 12:46:09 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9952935E
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:46:05 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 074FF240109
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 18:46:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655829963; bh=9NFrpHEK1253e5SRIiXwnXZcA4pySTps2N0wo2G9FTo=;
        h=Date:From:To:Cc:Subject:From;
        b=cjE7jf2lzPo3m2mUywY4i73mGfsa/d/KjWAacwjv0ewTgOFpPGAguU4FpQkSqwutc
         86xcgnX0OAIixkaraKkrpEEp/8fF4oiVr09eAzef1O50GbzOgnql7uM5uL/ojWJAjG
         i6YGH78+Sqxmx/CBjhqz+glduCqGUwE719Lvws59esmV1EtPYYOOKTWJRM8x9r0vM2
         1ivgv5TPejyCQc0G3fjr7isbOZiQy0nuOnZergH/d0wdtPeVXQlgqudzaB+FpUcigI
         rRgTFRUQyJmY4zFnqH3/ldGGC5Bjrw4a8CokZdH3eTtVTWjmgyDPeTUPZHjO6Rf0/U
         rP9cRFJRukmvA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LSC7r0T7bz6tmb;
        Tue, 21 Jun 2022 18:45:59 +0200 (CEST)
Date:   Tue, 21 Jun 2022 16:45:56 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 4/7] libbpf: Add type match support
Message-ID: <20220621164556.4zh5yajzlvf6mglo@muellerd-fedora-MJ0AC3F3>
References: <20220620231713.2143355-1-deso@posteo.net>
 <20220620231713.2143355-5-deso@posteo.net>
 <20220620235919.q4xsy7xqxw2rrjv3@macbook-pro-3.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220620235919.q4xsy7xqxw2rrjv3@macbook-pro-3.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 20, 2022 at 04:59:19PM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 20, 2022 at 11:17:10PM +0000, Daniel Müller wrote:
> > +int bpf_core_types_match(const struct btf *local_btf, __u32 local_id,
> > +			 const struct btf *targ_btf, __u32 targ_id)
> > +{
> 
> The libbpf and kernel support for types_match looks nearly identical.
> Maybe put in tools/lib/bpf/relo_core.c so it's one copy for both?

Thanks for the suggestion. Yes, at least for parts we should probably do it.

Would you happen to know why that has not been done for
bpf_core_types_are_compat equally? Is it because of the recursion level
tracking that is only present in the kernel? I'd think that similar reasoning
applies here.

Thanks,
Daniel
