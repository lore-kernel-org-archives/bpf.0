Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D10C4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 14:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9278020830
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 14:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDCOyb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:54:31 -0400
Received: from www62.your-server.de ([213.133.104.62]:47236 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDCOyb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 10:54:31 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBhHX-0001OZ-AC; Wed, 03 Apr 2019 16:54:27 +0200
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBhHX-0002AP-4D; Wed, 03 Apr 2019 16:54:27 +0200
Subject: Re: [PATCH bpf 0/5] flow_dissector: lay groundwork for calling BPF
 hook from eth_get_headlen
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
References: <20190401205734.4400-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <879bec68-a47c-2214-f017-429ff01a11c6@iogearbox.net>
Date:   Wed, 3 Apr 2019 16:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190401205734.4400-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25408/Wed Apr  3 09:53:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/01/2019 10:57 PM, Stanislav Fomichev wrote:
> This patch series fixes the existing BPF flow dissector API to
> support calling BPF progs from the eth_get_headlen context (the support
> itself will be added in bpf-next tree).
> 
> The summary of the changes:
>   * fix VLAN handling in bpf_flow.c, we don't need to peek back and look
>     at skb->vlan_present; add selftests
>   * pass and use flow_keys->n_proto instead of skb->protocol
>   * fix clamping of flow_keys->nhoff for packets with nhoff > 0
>   * prohibit access to most of the __sk_buff fields from BPF flow
>     dissector progs; only data/data_end/flow_keys are allowed (all input
>     is now passed via flow_keys)
>   * finally, document BPF flow dissector program environment
> 
> Stanislav Fomichev (5):
>   selftests/bpf: fix vlan handling in flow dissector program
>   net/flow_dissector: pass flow_keys->n_proto to BPF programs
>   flow_dissector: fix clamping of BPF flow_keys for non-zero nhoff
>   flow_dissector: allow access only to a subset of __sk_buff fields
>   flow_dissector: document BPF flow dissector environment
> 
>  .../networking/bpf_flow_dissector.txt         | 115 ++++++++++++++++++
>  net/core/filter.c                             |  16 +--
>  net/core/flow_dissector.c                     |   4 +-
>  .../selftests/bpf/prog_tests/flow_dissector.c |  68 +++++++++++
>  tools/testing/selftests/bpf/progs/bpf_flow.c  |  19 ++-
>  5 files changed, 196 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/networking/bpf_flow_dissector.txt

LGTM, applied, thanks!
