Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34386C10F14
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A55A2186A
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 21:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDKU71 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:59:27 -0400
Received: from www62.your-server.de ([213.133.104.62]:57054 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKU70 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 16:59:26 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEgms-0001TC-2G; Thu, 11 Apr 2019 22:59:10 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEgmr-000ChV-Pe; Thu, 11 Apr 2019 22:59:09 +0200
Subject: Re: [PATCH v3 bpf-next 0/4] L2 encap support for bpf_skb_adjust_room
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Willem de Bruijn <willemb@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        songliubraving@fb.com, yhs@fb.com, quentin.monnet@netronome.com,
        John Fastabend <john.fastabend@gmail.com>, rdna@fb.com,
        linux-kselftest@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <1554818803-4070-1-git-send-email-alan.maguire@oracle.com>
 <CAF=yD-LxDeBehWTzZknjMNXnj5cmr1cqi00DCt1PCYTecy7KAw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f644ca6d-f82d-c5a6-f4db-80988dfe7897@iogearbox.net>
Date:   Thu, 11 Apr 2019 22:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-LxDeBehWTzZknjMNXnj5cmr1cqi00DCt1PCYTecy7KAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25416/Thu Apr 11 09:55:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/09/2019 04:34 PM, Willem de Bruijn wrote:
> On Tue, Apr 9, 2019 at 10:08 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Extend bpf_skb_adjust_room growth to mark inner MAC header so that
>> L2 encapsulation can be used for tc tunnels.
>>
>> Patch #1 extends the existing test_tc_tunnel to support UDP
>> encapsulation; later we want to be able to test MPLS over UDP and
>> MPLS over GRE encapsulation.
>>
>> Patch #2 adds the BPF_F_ADJ_ROOM_ENCAP_L2(len) macro, which
>> allows specification of inner mac length.  Other approaches were
>> explored prior to taking this approach.  Specifically, I tried
>> automatically computing the inner mac length on the basis of the
>> specified flags (so inner maclen for GRE/IPv4 encap is the len_diff
>> specified to bpf_skb_adjust_room minus GRE + IPv4 header length
>> for example).  Problem with this is that we don't know for sure
>> what form of GRE/UDP header we have; is it a full GRE header,
>> or is it a FOU UDP header or generic UDP encap header? My fear
>> here was we'd end up with an explosion of flags.  The other approach
>> tried was to support inner L2 header marking as a separate room
>> adjustment, i.e. adjust for L3/L4 encap, then call
>> bpf_skb_adjust_room for L2 encap.  This can be made to work but
>> because it imposed an order on operations, felt a bit clunky.
>>
>> Patch #3 syncs tools/ bpf.h.
>>
>> Patch #4 extends the tests again to support MPLSoverGRE,
>> MPLSoverUDP, and transparent ethernet bridging (TEB) where
>> the inner L2 header is an ethernet header.  Testing of BPF
>> encap against tunnels is done for cases where configuration
>> of such tunnels is possible (MPLSoverGRE[6], MPLSoverUDP,
>> gre[6]tap), and skipped otherwise.  Testing of BPF encap/decap
>> is always carried out.
>>
>> Changes since v2:
>>  - updated tools/testing/selftest/bpf/config with FOU/MPLS CONFIG
>>    variables (patches 1, 4)
>>  - reduced noise in patch 1 by avoiding unnecessary movement of code
>>  - eliminated inner_mac variable in bpf_skb_net_grow (patch 2)
>>
>> Changes since v1:
>>  - fixed formatting of commit references.
>>  - BPF_F_ADJ_ROOM_FIXED_GSO flag enabled on all variants (patch 1)
>>  - fixed fou6 options for UDP encap; checksum errors observed were
>>    due to the fact fou6 tunnel was not set up with correct ipproto
>>    options (41 -6).  0 checksums work fine (patch 1)
>>  - added definitions for mask and shift used in setting L2 length
>>    (patch 2)
>>  - allow udp encap with fixed GSO (patch 2)
>>  - changed "elen" to "l2_len" to be more descriptive (patch 4)
>>
>>
>> Alan Maguire (4):
>>   selftests_bpf: extend test_tc_tunnel for UDP encap
>>   bpf: add layer 2 encap support to bpf_skb_adjust_room
>>   bpf: sync bpf.h to tools/ for BPF_F_ADJ_ROOM_ENCAP_L2
>>   selftests_bpf: add L2 encap to test_tc_tunnel
>>
>>  include/uapi/linux/bpf.h                           |  10 +
>>  net/core/filter.c                                  |  12 +-
>>  tools/include/uapi/linux/bpf.h                     |  10 +
>>  tools/testing/selftests/bpf/config                 |   8 +
>>  tools/testing/selftests/bpf/progs/test_tc_tunnel.c | 321 +++++++++++++++++----
>>  tools/testing/selftests/bpf/test_tc_tunnel.sh      | 136 +++++++--
>>  6 files changed, 417 insertions(+), 80 deletions(-)
> 
> For the series:
> 
> Acked-by: Willem de Bruijn <willemb@google.com>
> 
> Thanks Alan.
> 
> (quick response due to iterative review: checked out both v2 and v3
> series from patchwork (a super useful feature!) and did a git diff)

Applied, thanks! Small follow-up request though, will comment in patch 2.
