Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFCEC433DB
	for <bpf@archiver.kernel.org>; Tue,  9 Feb 2021 06:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F26164EB6
	for <bpf@archiver.kernel.org>; Tue,  9 Feb 2021 06:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBIGlj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Feb 2021 01:41:39 -0500
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:36514 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229636AbhBIGlh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 01:41:37 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id EA68D81238E4
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 06:30:54 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 748EE837F24A;
        Tue,  9 Feb 2021 06:29:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cord02_37123a627605
X-Filterd-Recvd-Size: 2169
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Feb 2021 06:29:51 +0000 (UTC)
Message-ID: <87ec5ac2e1a41000da9a7158491a22f83295c1a6.camel@perches.com>
Subject: Re: [PATCH] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
From:   Joe Perches <joe@perches.com>
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
Date:   Mon, 08 Feb 2021 22:29:50 -0800
In-Reply-To: <20210208234002.3294265-1-songliubraving@fb.com>
References: <20210208234002.3294265-1-songliubraving@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-02-08 at 15:40 -0800, Song Liu wrote:
> BPF programs explicitly initialise global variables to 0 to make sure
> clang (v10 or older) do not put the variables in the common section.
> Skip "initialise globals to 0" check for BPF programs to elimiate error
> messages like:
> 
>     ERROR: do not initialise globals to 0
>     #19: FILE: samples/bpf/tracex1_kern.c:21:
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4323,7 +4323,11 @@ sub process {
>  		}
>  
> 
>  # check for global initialisers.
> -		if ($line =~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=\s*($zero_initializer)\s*;/) {
> +# Do not apply to BPF programs (tools/testing/selftests/bpf/progs/*.c, samples/bpf/*_kern.c, *.bpf.c).
> +		if ($line =~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=\s*($zero_initializer)\s*;/ &&
> +		    $realfile !~ /^tools\/testing\/selftests\/bpf\/progs\/.*\.c/ &&
> +		    $realfile !~ /^samples\/bpf\/.*_kern.c/ &&
> +		    $realfile !~ /.bpf.c$/) {

probably better to make this a function so when additional files are
added it'd be easier to update this and it will not look as complex.

		if ($line =~ /.../ &&
		    !exclude_global_initialisers($realfile))


>  			if (ERROR("GLOBAL_INITIALISERS",
>  				  "do not initialise globals to $1\n" . $herecurr) &&
>  			    $fix) {


