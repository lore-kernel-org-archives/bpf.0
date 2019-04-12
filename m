Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93925C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 23:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5948820869
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 23:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5JrxaTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDLXcy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:32:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44881 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfDLXcy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 19:32:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so5826530pfm.11;
        Fri, 12 Apr 2019 16:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VjPJWhd9vWGeLT3GWyWYYYTAvkFqlIGL2f4fh4kTiVo=;
        b=k5JrxaTm/yydpB0r0k1JKxKkxRBqFrzjqHghvG5mAPRTn3+8cqhxHKEdPvhvTvFl3b
         dkGsRmq9Caey9/CX2LR5ikGCWPJMaTHytIk5Q2GX7HRzWfYt1UDOjutyJUtCSk85Srsp
         fooW4Z2R2X7VtauBEz1wseF5QeS3IjDSyBP4tHrrnEzIIOuvBVN5QFQCCvjqr1Rb44yf
         1FHx1GNRtK83xW9FOKGH1xe3lgTnZTly3JxSXwJCt6bPXtdHyxG1Hgs9PFL26W/KEF87
         nEdFL6eSjoluWF247P31bFCdlZrj33hEpyY0MI4o+N9JVtpAaTIV8UVa+ZHzCEc7YjCJ
         F2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VjPJWhd9vWGeLT3GWyWYYYTAvkFqlIGL2f4fh4kTiVo=;
        b=h/RRWNbOtuIxCs4iUflQLeu6/YoytTSIwpIgazIPl0Z5KLUC+XgRTaeRs6EvYfFQ7R
         v4xyvZ6LI9C49HLoTsVRNXGOmgcKF/8Cu5z3idGaRhwxmRF9vRaXDCgOUNEOTomu/OTF
         /PZr9aSsIbOwkGNtbvCirBval3s7ZAhpcGx/g5vz5tpyLDLENyZQegKczyuNIsDYvsTm
         v1VVMojUGTldlQMpmYMXlQzBaVJBZdwB334ZicA5IRMLI7YYNMIPFnvjoDfwh5xaAnO4
         EmUTrDZEDDIjp7DLmONoE1JLnxkOB3wWHa3F3PYp/ygFeBCp9Jrvz/a5P4JnCYeufL0v
         R8Nw==
X-Gm-Message-State: APjAAAWwUvFqA5FhSfPg2teFXFoc890hUFftDKDCl4U11v8qb/X5jmzn
        nPHn11VsLvSoA1fE83OH4qU=
X-Google-Smtp-Source: APXvYqzqrrzBeDMm7zbrPLYhWztRhUQdrvWbQlg8m+JAsZ8bWpt5FH55Cxf0wfEY54gbvR6M+VEU+Q==
X-Received: by 2002:aa7:9ab7:: with SMTP id x23mr39410443pfi.27.1555111972749;
        Fri, 12 Apr 2019 16:32:52 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:e505])
        by smtp.gmail.com with ESMTPSA id n26sm116922741pfi.165.2019.04.12.16.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 16:32:51 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:32:50 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: two scale tests
Message-ID: <20190412233248.iik56fgcnmyk3pm7@ast-mbp.dhcp.thefacebook.com>
References: <20190412214132.2726285-1-ast@kernel.org>
 <CAPhsuW7qxRywrDQ8PLWiFwHtfSsc+24LD1dPBnsO+jpQf8adfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7qxRywrDQ8PLWiFwHtfSsc+24LD1dPBnsO+jpQf8adfA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 12, 2019 at 04:24:51PM -0700, Song Liu wrote:
> On Fri, Apr 12, 2019 at 2:41 PM Alexei Starovoitov <ast@kernel.org> wrote:
> >
> > Add two tests to check that sequence of 1024 jumps is verifiable.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> Shall we add a test that go beyond the 1M limit?

1m is not uapi limit. I'm working on the doc patch to stress that point.
Adding a test to check that it fails at 1m would kinda imply
that it is uapi and I very much want to avoid that.

The purpose of these tests is to stress the verifier to its
internal limits, but not more.
In particular in these two tests 1024, 8, 512, and another 1M
are limits too.

