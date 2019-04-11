Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79768C10F14
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 19:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4CB2073F
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 19:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDKTzw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:55:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:46426 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKTzw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 15:55:52 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEfnZ-0005MB-Md; Thu, 11 Apr 2019 21:55:49 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEfnZ-0002sE-Gh; Thu, 11 Apr 2019 21:55:49 +0200
Subject: Re: [PATCH bpf] bpftool: Fix errno variable usage
To:     Benjamin Poirier <bpoirier@suse.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
References: <20190411080332.24574-1-bpoirier@suse.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <626302de-83fc-8c6f-4b55-de0bad746240@iogearbox.net>
Date:   Thu, 11 Apr 2019 21:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190411080332.24574-1-bpoirier@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25416/Thu Apr 11 09:55:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/11/2019 10:03 AM, Benjamin Poirier wrote:
> The test meant to use the saved value of errno. Given the current code, it
> makes no practical difference however.
> 
> Fixes: bf598a8f0f77 ("bpftool: Improve handling of ENOENT on map dumps")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Applied, thanks!
