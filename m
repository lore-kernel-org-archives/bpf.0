Return-Path: <SRS0=Mla6=7A=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF6BC433E0
	for <bpf@archiver.kernel.org>; Mon, 18 May 2020 19:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D98C5207F5
	for <bpf@archiver.kernel.org>; Mon, 18 May 2020 19:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adk8l2ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgERTVL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 May 2020 15:21:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30348 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727770AbgERTVL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 May 2020 15:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589829670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aSbxTSPrzIp3VDezJFwJiz6MVH3rgu048cSWIkAJasI=;
        b=adk8l2exnkAH5MHyccLDxhPFX/sXNEBoXgE+fmiWXVl6QCudLjw7tX7zU9Q4fquqG5SG39
        MDTCqIABGx+k1//3Wbx9lPflK+Zaei5BrelZEPlLxsnQWz1uf7h0RPovOO+zPujZiJOAJi
        gIiD6jTqPn5zr4wQarQRwATxz4+juk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-oqZbrwZPOpKG5KnhHnpyFQ-1; Mon, 18 May 2020 15:21:03 -0400
X-MC-Unique: oqZbrwZPOpKG5KnhHnpyFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 368EF1800D42;
        Mon, 18 May 2020 19:21:00 +0000 (UTC)
Received: from krava (unknown [10.40.192.87])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0F45B60BE1;
        Mon, 18 May 2020 19:20:52 +0000 (UTC)
Date:   Mon, 18 May 2020 21:20:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: metric expressions including metrics?
Message-ID: <20200518192051.GE11620@krava>
References: <20200518191242.GA27634@oc3272150783.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518191242.GA27634@oc3272150783.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 18, 2020 at 02:12:42PM -0500, Paul A. Clarke wrote:
> I'm curious how hard it would be to define metrics using other metrics,
> in the metrics definition files.
> 
> Currently, to my understanding, every metric definition must be an
> expresssion based solely on arithmetic combinations of hardware events.
> 
> Some metrics are hierarchical in nature such that a higher-level metric
> can be defined as an arithmetic expression of two other metrics, e.g.
> 
> cache_miss_cycles_per_instruction =
>   data_cache_miss_cycles_per_instruction +
>   instruction_cache_miss_cycles_per_instruction
> 
> This would need to be defined something like:
> dcache_miss_cpi = "dcache_miss_cycles / instructions"
> icache_miss_cpi = "icache_miss_cycles / instructions"
> cache_miss_cpi = "(dcache_miss_cycles + icache_miss_cycles) / instructions"
> 
> Could the latter definition be simplified to:
> cache_miss_cpi = "dcache_miss_cpi + icache_miss_cpi"
> 
> With multi-level caches and NUMA hierarchies, some of these higher-level
> metrics can involve a lot of hardware events.
> 
> Given the recent activity in this area, I'm curious if this has been
> considered and already on a wish/to-do list, or found onerous.

hi,
actually we were discussing this with Ian and Stephane and I plan on
checking on that.. should be doable, I'll keep you in the loop

jirka

> 
> Regards,
> Paul Clarke
> 

