Return-Path: <SRS0=AFkz=DO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6D6C4363C
	for <bpf@archiver.kernel.org>; Wed,  7 Oct 2020 21:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D9322087D
	for <bpf@archiver.kernel.org>; Wed,  7 Oct 2020 21:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgJGV0p (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:26:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:44230 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgJGV0p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 17:26:45 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kQGxP-0001Cl-O5; Wed, 07 Oct 2020 23:26:43 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kQGxP-0008tn-Ew; Wed, 07 Oct 2020 23:26:43 +0200
Subject: Re: [PATCH bpf-next V2 1/6] bpf: Remove MTU check in
 __bpf_skb_max_len
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        maze@google.com, lmb@cloudflare.com, shaun@tigera.io,
        Lorenzo Bianconi <lorenzo@kernel.org>, marek@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, eyal.birger@gmail.com
References: <160208770557.798237.11181325462593441941.stgit@firesoul>
 <160208776033.798237.4028465222836713720.stgit@firesoul>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d80644af-d920-c771-97fe-c48023697eac@iogearbox.net>
Date:   Wed, 7 Oct 2020 23:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <160208776033.798237.4028465222836713720.stgit@firesoul>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25950/Wed Oct  7 15:55:10 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/7/20 6:22 PM, Jesper Dangaard Brouer wrote:
[...]
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> (imported from commit 37f8552786cf46588af52b77829b730dd14524d3)

slipped in?
