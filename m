Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (unknown [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C1DC433EC
	for <bpf@archiver.kernel.org>; Sun, 21 Mar 2021 02:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EBB6195C
	for <bpf@archiver.kernel.org>; Sun, 21 Mar 2021 02:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCUBqk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 20 Mar 2021 21:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCUBqI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Mar 2021 21:46:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0104CC061574;
        Sat, 20 Mar 2021 18:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2heULiZzRc9ya4FMm4sJf9hBa2CE3wvw1PQn8pY8k/c=; b=kVuWUxbMnCfTbN3+D71TED1rYk
        H3UbMAgc9Iq5PEzR9vW3ZIzK8H2N7imI49gh1LkBR+el7Lh/S5ZBs5Yo0LyOjGw22sFa5cyeY3nO4
        jp5fKt+wXego/5ADJiZtJXNEZFzEJDnI3A9+uSEn9Dxmg+zOHVvwACGRhlKuSijUngz9+duLVnWuc
        36vK0U09Se/o32yQZHGgyw88R2eOv5VAQ/rK3GQjKMVoqVCZGafh9ehLMcEOCUD96IqGOAAVqal+A
        nDuWvl7SXTVuvEBRcGtkI165uPgE1301umoSv/Fk6VR6w+2iuZiM4OlRKR7/YK3Fm7KB62rySRgAk
        BsKzsbmw==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNnA9-0028Jk-Qw; Sun, 21 Mar 2021 01:45:54 +0000
Date:   Sat, 20 Mar 2021 18:45:53 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] perf tools: Rudimentary typo fix
In-Reply-To: <20210321005755.26660-1-unixbhaskar@gmail.com>
Message-ID: <94a3b75e-834a-9bc8-ee31-8278e28d3d34@bombadil.infradead.org>
References: <20210321005755.26660-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_184553_896885_0201B717 
X-CRM114-Status: GOOD (  13.12  )
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/archictures/architectures/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> tools/perf/builtin-stat.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 2e2e4a8345ea..5cc5eeae6ade 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1705,7 +1705,7 @@ static int add_default_attributes(void)
> 	bzero(&errinfo, sizeof(errinfo));
> 	if (transaction_run) {
> 		/* Handle -T as -M transaction. Once platform specific metrics
> -		 * support has been added to the json files, all archictures
> +		 * support has been added to the json files, all architectures
> 		 * will use this approach. To determine transaction support
> 		 * on an architecture test for such a metric name.
> 		 */
> --
> 2.30.1
>
>
