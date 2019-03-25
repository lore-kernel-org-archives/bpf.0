Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA53C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 14:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51E52085A
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 14:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfCYODm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:03:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:41434 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCYODm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 10:03:42 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8QCO-0006X0-0O; Mon, 25 Mar 2019 15:03:36 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8QCN-00019Y-MT; Mon, 25 Mar 2019 15:03:35 +0100
Subject: Re: [PATCH bpf-next] bpf: test_tc_tunnel.sh needs reverse path
 filtering disabled
To:     Alan Maguire <alan.maguire@oracle.com>,
        willemdebruijn.kernel@gmail.com, shuah@kernel.org, ast@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <alpine.LRH.2.20.1903250930270.2818@dhcp-10-175-167-141.vpn.oracle.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <43e1c55b-3072-ce55-460b-279187dba2c2@iogearbox.net>
Date:   Mon, 25 Mar 2019 15:03:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1903250930270.2818@dhcp-10-175-167-141.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25399/Mon Mar 25 08:46:48 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/25/2019 10:36 AM, Alan Maguire wrote:
> test_tc_tunnel.sh sets up a pair of namespaces connected by a
> veth pair to verify encap/decap using bpf_skb_adjust_room.  In
> testing this, it uses tunnel links as the peer of the bpf-based
> encap/decap.  However because the same IP header is used for inner
> and outer IP, when packets arrive at the tunnel interface they will
> be dropped by reverse path filtering as those packets are expected
> on the veth interface (where the destination IP of the decapped
> packet is configured).
> 
> To avoid this, ensure reverse path filtering is disabled for the
> namespace using tunneling.
> 
> Fixes: 98cdabcd0798 ("selftests/bpf: bpf tunnel encap test")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Applied, thanks!
