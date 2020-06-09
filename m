Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C101DC433E0
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 15:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8A520812
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 15:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591716889;
	bh=SjUD8eXXZBGDWqYSqypEuULp19RlOZk9QwEig+BKhWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QqqJtmtvKY99IK4jYhFnY8bIVAEIyD24EIDkoUzYJhThmpzZB7VRrIjOopHCzD27+
	 xgVy9PceiNkR3X0AoUn5zjB43aCLvVGwyN+5cv59ENjmZFlQA/kXPvgN9mpKRglCCu
	 Gbaj2t+OFqvYgPmXqgDI7m49dpezF9j4w6OifX+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgFIPes (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgFIPes (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 11:34:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 977322078C;
        Tue,  9 Jun 2020 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591716887;
        bh=SjUD8eXXZBGDWqYSqypEuULp19RlOZk9QwEig+BKhWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qgjvGX24h8SPLgzwY5OO7GMOfvs81R5fGNtGbiT00wiKibqlYwPIQg1P/gAtQKWL5
         t2/oZMXoRDtQfCjr56HVQUTFRLSXu2kHkM/b8T68TovW/v0Pbm0VWxwxF/rRa4S8Xf
         Yb4Kv+6qQRohC2pJlood/fWU7UAsKpC5b1sp5csM=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F91A40AFD; Tue,  9 Jun 2020 12:34:45 -0300 (-03)
Date:   Tue, 9 Jun 2020 12:34:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Irina Tirdea <irina.tirdea@intel.com>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] libbpf: Define __WORDSIZE if not available
Message-ID: <20200609153445.GF24868@kernel.org>
References: <20200608161150.GA3073@kernel.org>
 <CAEf4BzbEcV6YaezP4yY8J=kYSBhh0cRHCvgCUe9xvB12mF08qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbEcV6YaezP4yY8J=kYSBhh0cRHCvgCUe9xvB12mF08qg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some systems, such as Android, don't have a define for __WORDSIZE, do it
in terms of __SIZEOF_LONG__, as done in perf since 2012:

  http://git.kernel.org/torvalds/c/3f34f6c0233ae055b5

For reference: https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html

I build tested it here and Andrii did some Travis CI build tests too.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
