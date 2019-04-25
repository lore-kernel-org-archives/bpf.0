Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735C6C43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E769206C0
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfDYVv2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:51:28 -0400
Received: from www62.your-server.de ([213.133.104.62]:57480 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDYVv2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 17:51:28 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJmH7-0007fZ-Iy; Thu, 25 Apr 2019 23:51:25 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJmH7-000GpO-DD; Thu, 25 Apr 2019 23:51:25 +0200
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, Jann Horn <jannh@google.com>
References: <20190425213724.25056-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <06278cf1-2fa3-e338-533a-4157acaa5bb1@iogearbox.net>
Date:   Thu, 25 Apr 2019 23:51:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190425213724.25056-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25430/Thu Apr 25 09:58:44 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/25/2019 11:37 PM, Stanislav Fomichev wrote:
> target_fd is target namespace. If there is a flow dissector BPF program
> attached to that namespace, its (single) id is returned.
> 
> v5:
> * drop net ref right after rcu unlock (Daniel Borkmann)
> 
> v4:
> * add missing put_net (Jann Horn)
> 
> v3:
> * add missing inline to skb_flow_dissector_prog_query static def
>   (kbuild test robot <lkp@intel.com>)
> 
> v2:
> * don't sleep in rcu critical section (Jakub Kicinski)
> * check input prog_cnt (exit early)
> 
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Looks good, applied, thanks!
