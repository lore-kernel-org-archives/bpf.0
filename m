Return-Path: <SRS0=+2DZ=QZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D642C43381
	for <bpf@archiver.kernel.org>; Mon, 18 Feb 2019 19:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4872184A
	for <bpf@archiver.kernel.org>; Mon, 18 Feb 2019 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550519722;
	bh=BXIaOS7OubjzYjHkVc4kqY0LdkWzoSj2bvg+4XvDqjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1GzekkGWZ0BdgC1yw+e/DOJ6aoYmnNjQ3vxmrpIKKMqjJ8kblGKy2toMzkRZDF/+g
	 5k22jRW0vvjSW/uCTiAbilDbCXaNyrvdytIxsR80foXVdW3VnKYkoDewy2I/WvYtG5
	 3jOmQ5rlAmdczLuoynyMP7EvDrurxnxmLD/fx4WY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfBRTzV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfBRTzV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Feb 2019 14:55:21 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.100.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5D64204EC;
        Mon, 18 Feb 2019 19:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550519720;
        bh=BXIaOS7OubjzYjHkVc4kqY0LdkWzoSj2bvg+4XvDqjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTmRB37C0pwfSrRt/hoGvvA4Gg2v6MS7orfQJ5DLxjl0cqmnYCn7qYyEgjeQ1h+2T
         FUzmh7jEI/KLLT7gG5m9r04nEveqlCvyvJyhJAPTMELdoRfgUF4Oi5/PPH3tXKc1av
         amOIHfqn5ywjaR1Xk3g+AuLc+RJBNcds5GxHzltw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9A2A0410D5; Mon, 18 Feb 2019 16:55:15 -0300 (-03)
Date:   Mon, 18 Feb 2019 16:55:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH pahole 2/2] btf_encoder: run BTF deduplication before
 writing out to ELF
Message-ID: <20190218195515.GT31177@kernel.org>
References: <20190217082018.1008069-1-andriin@fb.com>
 <20190217082018.1008069-3-andriin@fb.com>
 <20190218142900.GR31177@kernel.org>
 <CAEf4BzYCD91JaoJyTRi2i3BS69=TkJVh34uc8++Wwd7B5nExLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYCD91JaoJyTRi2i3BS69=TkJVh34uc8++Wwd7B5nExLA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 18, 2019 at 11:38:41AM -0800, Andrii Nakryiko escreveu:
> On Mon, Feb 18, 2019 at 6:29 AM Arnaldo Carvalho de Melo wrote:
> > Thanks for all the cool work!
 
> My pleasure, it was fun! :)

So, next step, tag a pahole release and announce it, but I wonder about
the libbpf linking, wouldn't be better, for now, to make it link
statically with libbpf?

I ask this because libbpf isn't yet generally available, so perhaps we
should have some logic to detect if it is available and link against it
or if not, use the module stuff we have now and link it statically,
wdyt?

Hopefully we get the problems noticed via btfdiff before that.

- Arnaldo
