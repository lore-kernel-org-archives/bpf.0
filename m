Return-Path: <SRS0=7UPC=4O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B668FC4BA1E
	for <bpf@archiver.kernel.org>; Wed, 26 Feb 2020 17:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9068820801
	for <bpf@archiver.kernel.org>; Wed, 26 Feb 2020 17:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgBZRif (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:38:35 -0500
Received: from www62.your-server.de ([213.133.104.62]:42586 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgBZRif (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Feb 2020 12:38:35 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j70dk-0002k1-V0; Wed, 26 Feb 2020 18:38:32 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j70dk-000TpF-Nx; Wed, 26 Feb 2020 18:38:32 +0100
Subject: Re: [PATCH bpf] mailmap: update email address
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20200226171353.18982-1-quentin@isovalent.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2867a370-b070-2e30-2231-4fe8c65a6eed@iogearbox.net>
Date:   Wed, 26 Feb 2020 18:38:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200226171353.18982-1-quentin@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25734/Tue Feb 25 15:06:17 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/26/20 6:13 PM, Quentin Monnet wrote:
> My Netronome address is no longer active. I am no maintainer, but
> get_maintainer.pl sometimes returns my name for a small number of files
> (BPF-related). Add an entry to .mailmap for good measure.
> 
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>

Applied, thanks.
