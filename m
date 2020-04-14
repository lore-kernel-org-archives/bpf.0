Return-Path: <SRS0=O1Al=56=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9200C2BA19
	for <bpf@archiver.kernel.org>; Tue, 14 Apr 2020 15:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F46F2064A
	for <bpf@archiver.kernel.org>; Tue, 14 Apr 2020 15:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHQGXyP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440347AbgDNPVf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:21:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30629 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438971AbgDNPVe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Apr 2020 11:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586877693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t56IV5IcGFIFk76C/Oe4RMyeNWF7V2Xr/OgkHc14pEU=;
        b=dHQGXyP1wT1EtjFk7l9gFlxzOR5So5EA1qDhTiMPdXv1oRlhaTubDg/b0qsTKxl/ZYqNI4
        DeeYvxPRfHL9aHuXzjeQ00JqScQtkVTTXAWVr2/N5H2Tm5FAiYnxHv6k+sJLaVBne77gdk
        kIJ6yusxC3bCh1T405jFBGFjyCOtyUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-zmazFg1JMD-P2aCg8tKd3Q-1; Tue, 14 Apr 2020 11:21:29 -0400
X-MC-Unique: zmazFg1JMD-P2aCg8tKd3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 402C1107ACC7;
        Tue, 14 Apr 2020 15:21:25 +0000 (UTC)
Received: from krava (unknown [10.40.195.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50F905E240;
        Tue, 14 Apr 2020 15:21:19 +0000 (UTC)
Date:   Tue, 14 Apr 2020 17:21:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v8 2/4] tools feature: add support for detecting libpfm4
Message-ID: <20200414152116.GD208694@krava>
References: <20200411074631.9486-1-irogers@google.com>
 <20200411074631.9486-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411074631.9486-3-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 11, 2020 at 12:46:29AM -0700, Ian Rogers wrote:
> From: Stephane Eranian <eranian@google.com>
> 
> libpfm4 provides an alternate command line encoding of perf events.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/build/Makefile.feature       | 6 ++++--
>  tools/build/feature/Makefile       | 6 +++++-
>  tools/build/feature/test-libpfm4.c | 9 +++++++++
>  3 files changed, 18 insertions(+), 3 deletions(-)
>  create mode 100644 tools/build/feature/test-libpfm4.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 3e0c019ef297..0b651171476f 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -73,7 +73,8 @@ FEATURE_TESTS_BASIC :=                  \
>          libaio				\
>          libzstd				\
>          disassembler-four-args		\
> -        file-handle
> +        file-handle			\
> +        libpfm4

let's treat this the same way as libbpf and do not include
it in the basic check, which will fail for omst users

jirka

