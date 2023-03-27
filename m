Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ACBC76195
	for <bpf@archiver.kernel.org>; Mon, 27 Mar 2023 22:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC0WeY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Mar 2023 18:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjC0WeX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 18:34:23 -0400
Received: from out-57.mta1.migadu.com (out-57.mta1.migadu.com [IPv6:2001:41d0:203:375::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B5C1732
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 15:34:22 -0700 (PDT)
Message-ID: <bf14832b-6c91-2623-6db2-488621e99d7c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679956460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRn1qDRZ/LtwfXFq0UEqZvGlMaDAtvdBOgLi02au+fM=;
        b=N/bl+mXDFZJsWvMVDwhL+tc2t0BBXQrIcLJSO54ZTmfEJ7DXVT3OvBUeJMUdVm/zmxYVxN
        79t+QYKAVJIfSBZe01PQWYCRf5LhrwPzvTKPEpsDf2fwqA6GRARHeCaePUE115bL7ZBhF+
        VfvoxhtqRvuztrm6eBoMAMVu+jJVA1E=
Date:   Mon, 27 Mar 2023 15:34:16 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 3/4] bpf,tcp: Avoid taking fast sock lock in
 iterator
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        bpf@vger.kernel.org
References: <20230323200633.3175753-1-aditi.ghag@isovalent.com>
 <20230323200633.3175753-4-aditi.ghag@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230323200633.3175753-4-aditi.ghag@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/23/23 1:06 PM, Aditi Ghag wrote:
> Previously, BPF TCP iterator was acquiring fast version of sock lock that
> disables the BH. This introduced a circular dependency with code paths that
> later acquire sockets hash table bucket lock.
> Replace the fast version of sock lock with slow that faciliates BPF
> programs executed from the iterator to destroy TCP listening sockets
> using the bpf_sock_destroy kfunc.

This batch should be moved before the bpf_sock_destroy patch.

