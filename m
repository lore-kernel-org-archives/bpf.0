Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9EEC54EAA
	for <bpf@archiver.kernel.org>; Fri, 27 Jan 2023 08:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjA0IUE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Jan 2023 03:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjA0IUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 03:20:03 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981DE38EBD;
        Fri, 27 Jan 2023 00:20:02 -0800 (PST)
Message-ID: <a208ed96-20e5-43d3-13e9-122776230da1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674807601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ov/FJthsCODGeWj8ILAwNRT93LKgz9Jx2BLZQJFGouA=;
        b=VvpwaWRgkPXmVGVaxMPg0j7GTF9JSJn1hndRbmKIDgfs8CFaBdUmYJOfni4D7xIfmVL7bN
        ZrttmyNQPsGKC8xh6GxIWlIDzD9wwK9DjIgVcYjx4tWVV+43dzRET5LsMtobKHNxUfUq09
        3IabGtps6eJVAfRUs/mF28o+asZtQr0=
Date:   Fri, 27 Jan 2023 00:19:54 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 8/8] selftests/bpf: introduce XDP compliance
 test tool
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, pabeni@redhat.com,
        edumazet@google.com, toke@redhat.com, memxor@gmail.com,
        alardam@gmail.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
        gospo@broadcom.com, vladimir.oltean@nxp.com, nbd@nbd.name,
        john@phrozen.org, leon@kernel.org, simon.horman@corigine.com,
        aelior@marvell.com, christophe.jaillet@wanadoo.fr,
        ecree.xilinx@gmail.com, mst@redhat.com, bjorn@kernel.org,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        intel-wired-lan@lists.osuosl.org, lorenzo.bianconi@redhat.com,
        sdf@google.com
References: <cover.1674737592.git.lorenzo@kernel.org>
 <0b05b08d4579b017dd96869d1329cd82801bd803.1674737592.git.lorenzo@kernel.org>
 <Y9LIPaojtpTjYlNu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Y9LIPaojtpTjYlNu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/26/23 10:36 AM, sdf@google.com wrote:
> 
>> +    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
>> +    if (sockfd < 0) {
>> +        fprintf(stderr, "Failed to create echo socket\n");
>> +        return -errno;
>> +    }
>> +
>> +    err = setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &optval,
>> +             sizeof(optval));
>> +    if (err < 0) {
>> +        fprintf(stderr, "Failed sockopt on echo socket\n");
>> +        return -errno;
>> +    }
>> +
>> +    err = bind(sockfd, (struct sockaddr *)&addr, sizeof(addr));
>> +    if (err) {
>> +        fprintf(stderr, "Failed to bind echo socket\n");
>> +        return -errno;
>> +    }
> 
> IIRC, Martin mentioned IPv6 support in the previous version. Should we
> also make the userspace v6 aware by at least using AF_INET6 dualstack
> sockets? I feel like listening on inaddr_any with AF_INET6 should
> get us there without too much pain..

Yeah. Think about host that only has IPv6 address. A tool not supporting IPv6 is 
a no-go nowadays.
