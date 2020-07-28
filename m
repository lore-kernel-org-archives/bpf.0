Return-Path: <SRS0=s4C/=BH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E4C433DF
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 12:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DD420714
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595940345;
	bh=SjwVcjwzVcHmdTN1Be+lgU7GPgYwsx0Ln8MZ5TrX84U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S8/vK5hxPChJg+YSy+5rt75ZefIm9HTvL4AnaRsJO+lH1/+n/gnYLzIIywrpgs1ul
	 PSXAzQmclFPmbBZqETUhqJPPH7ipq1xVMKbFqNn5Jc67ufRYCHLTykhBy6kx/MC3DY
	 ySCbd3ZM5qolyFa0TzmMRNjUYugGnSp5rg4YFPBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgG1Mpo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbgG1Mpo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 08:45:44 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C731D206D7;
        Tue, 28 Jul 2020 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595940344;
        bh=SjwVcjwzVcHmdTN1Be+lgU7GPgYwsx0Ln8MZ5TrX84U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nimerbmlC9+vIEP0knA5mT6s2fVQUBe/yaUBtK4uDYtxD36l+mOm7D50faPD2b60o
         mrjH8eGPeney/6BYhThX9fA5+X/3hnik4WzC8SoZPGHZN91n6nQvsEUri71WoG1jFx
         srRNufOVmXMp0DIsK3nihFBZL8wudynKWIwVldnE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F3F86404B1; Tue, 28 Jul 2020 09:45:39 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:45:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 3/5] perf test: Ensure sample_period is set libpfm4
 events
Message-ID: <20200728124539.GB40195@kernel.org>
References: <20200728085734.609930-1-irogers@google.com>
 <20200728085734.609930-4-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728085734.609930-4-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jul 28, 2020 at 01:57:32AM -0700, Ian Rogers escreveu:
> Test that a command line option doesn't override the period set on a
> libpfm4 event.
> Without libpfm4 test passes as unsupported.

Thanks, applied.

- Arnaldo
