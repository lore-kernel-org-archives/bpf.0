Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF5FC433DB
	for <bpf@archiver.kernel.org>; Tue,  9 Feb 2021 21:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395BC64EE0
	for <bpf@archiver.kernel.org>; Tue,  9 Feb 2021 21:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhBIVqj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Feb 2021 16:46:39 -0500
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:40710 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234337AbhBIVNo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 16:13:44 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 306B8182D512B;
        Tue,  9 Feb 2021 19:02:15 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D26D7182CCCB9;
        Tue,  9 Feb 2021 18:59:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: road65_270c81827609
X-Filterd-Recvd-Size: 2565
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Feb 2021 18:59:31 +0000 (UTC)
Message-ID: <2b41e46fcf909bd67a578524107214fe4b1eeede.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
From:   Joe Perches <joe@perches.com>
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
Date:   Tue, 09 Feb 2021 10:59:30 -0800
In-Reply-To: <20210209183343.3929160-1-songliubraving@fb.com>
References: <20210209183343.3929160-1-songliubraving@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-02-09 at 10:33 -0800, Song Liu wrote:
> BPF programs explicitly initialise global variables to 0 to make sure
> clang (v10 or older) do not put the variables in the common section.
> Skip "initialise globals to 0" check for BPF programs to elimiate error
> messages like:
> 
>     ERROR: do not initialise globals to 0
>     #19: FILE: samples/bpf/tracex1_kern.c:21:
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> 
> ---
> Changes v2 => v3:
>   1. Fix regex.

Unfortunately, this has broken regexes...

> Changes v1 => v2:
>   1. Add function exclude_global_initialisers() to keep the code clean.
> ---
>  scripts/checkpatch.pl | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2428,6 +2428,15 @@ sub get_raw_comment {
>  	return $comment;
>  }
>  
> +sub exclude_global_initialisers {
> +	my ($realfile) = @_;
> +
> +	# Do not check for BPF programs (tools/testing/selftests/bpf/progs/*.c, samples/bpf/*_kern.c, *.bpf.c).
> +	return $realfile =~ m@/^tools\/testing\/selftests\/bpf\/progs\/.*\.c@ ||

You don't need to escape the / when using m@@, and this doesn't work
given the leading / after @, and it should use a trailing $

	return $realfile =~ m@^tools/testing/selftests/bpf/progs/.*\.c$@ ||

> +		$realfile =~ m@^samples\/bpf\/.*_kern.c@ ||

This is still missing an escape on the . before c@, and there's no
trailing $ between c and @

		$realfile =~ m@^samples/bpf/.*_kern\.c$@ ||

> +		$realfile =~ m@/bpf/.*\.bpf\.c$@;

I believe I showed the correct regexes in my earlier reply.


