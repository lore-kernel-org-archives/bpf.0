Return-Path: <SRS0=s2Gn=7Y=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA44AC433E0
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 14:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB3E2065C
	for <bpf@archiver.kernel.org>; Thu, 11 Jun 2020 14:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgFKOY5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:24:57 -0400
Received: from www62.your-server.de ([213.133.104.62]:57470 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgFKOY5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jun 2020 10:24:57 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jjO8V-0007zx-2X; Thu, 11 Jun 2020 16:24:55 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jjO8U-0004DG-9o; Thu, 11 Jun 2020 16:24:54 +0200
Subject: Re: [PATCH bpf] tools, bpftool: Fix memory leak in codegen error
 cases
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org
References: <20200610130804.21423-1-tklauser@distanz.ch>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <43fc718e-4720-1519-7231-96f9ac1b50aa@iogearbox.net>
Date:   Thu, 11 Jun 2020 16:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200610130804.21423-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25840/Thu Jun 11 14:52:31 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/10/20 3:08 PM, Tobias Klauser wrote:
> Free the memory allocated for the template on error paths in function
> codegen.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied, thanks!
