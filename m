Return-Path: <SRS0=qFa8=AG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A874CC433DF
	for <bpf@archiver.kernel.org>; Thu, 25 Jun 2020 15:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9056A207D8
	for <bpf@archiver.kernel.org>; Thu, 25 Jun 2020 15:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405425AbgFYPCj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:02:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:33142 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405405AbgFYPCj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jun 2020 11:02:39 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1joTOa-0004NW-OD; Thu, 25 Jun 2020 17:02:34 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1joTOa-000ItY-D6; Thu, 25 Jun 2020 17:02:32 +0200
Subject: Re: [PATCH bpf-next v3 1/2] tools, bpftool: Define prog_type_name
 array only once
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
References: <20200623104227.11435-2-tklauser@distanz.ch>
 <20200624143124.12914-1-tklauser@distanz.ch>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a4167f05-04f9-4534-1475-3ed4376e7ceb@iogearbox.net>
Date:   Thu, 25 Jun 2020 17:02:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200624143124.12914-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25854/Thu Jun 25 15:16:08 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/24/20 4:31 PM, Tobias Klauser wrote:
> Define prog_type_name in prog.c instead of main.h so it is only defined
> once. This leads to a slight decrease in the binary size of bpftool.
> 
> Before:
> 
>     text	   data	    bss	    dec	    hex	filename
>   401032	  11936	1573160	1986128	 1e4e50	bpftool
> 
> After:
> 
>     text	   data	    bss	    dec	    hex	filename
>   399024	  11168	1573160	1983352	 1e4378	bpftool
> 
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Both applied, thanks!
