Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA31C433FE
	for <bpf@archiver.kernel.org>; Thu,  6 Oct 2022 23:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiJFXPB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 6 Oct 2022 19:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiJFXPA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 19:15:00 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4551C102;
        Thu,  6 Oct 2022 16:14:57 -0700 (PDT)
Message-ID: <bf1c436a-a137-b174-a61c-854da95876df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665098095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vC+9z8mlRna35nRgKm8R901fuUaH8Ni2P2DKMf2ns1Q=;
        b=lkY3f7ph9E55Fl6Gdkw/fP8x63KlGRlZmY01AB7fJO+QZjZSIZieOCX6d3R9Zg+Fmm4P53
        iGTksTIQgv0WoihZ3/P9wHIqDTE8qx7qk7fKqvlGIgqrWy/zNm0GaJIKvI9u4oyqNd1Ykq
        xphVzo1Mdn/CvrXqJche6s1Wx5RSA9g=
Date:   Thu, 6 Oct 2022 16:14:52 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 04/10] bpf: Implement link introspection for tc
 BPF link programs
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
        john.fastabend@gmail.com, joannelkoong@gmail.com, memxor@gmail.com,
        toke@redhat.com, joe@cilium.io, netdev@vger.kernel.org,
        bpf <bpf@vger.kernel.org>
References: <20221004231143.19190-1-daniel@iogearbox.net>
 <20221004231143.19190-5-daniel@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221004231143.19190-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/4/22 4:11 PM, Daniel Borkmann wrote:
> Implement tc BPF link specific show_fdinfo and link_info to emit ifindex,
> attach location and priority.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>

