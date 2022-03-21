Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E04C433EF
	for <bpf@archiver.kernel.org>; Mon, 21 Mar 2022 16:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350910AbiCUQOQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350899AbiCUQON (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 12:14:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3486E4D0;
        Mon, 21 Mar 2022 09:12:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 928AD2DD;
        Mon, 21 Mar 2022 16:12:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 928AD2DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1647879166; bh=uUsgLXaCqc4u7i5BhAraPiODgV7em7kl1FyplEXfzE0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MbfPDcTlkwm1sngqSEcf+JlMiQcAw3WDtnDZ8KVMIIIiHtLSD01GTadoWi7wk3MoY
         qBZqW4wfW5Ck6KZJ4+3dDEpYXVk6pztQ1k4BncCyHJ9OzZW7iLVyjpiugwhG2KvrRb
         2I1g42IxumlyTc9U5yRg2QnfjGmIk4YTOC4wNZffWUrSUe7vfMNZuLkCFTDuLaw446
         6GbJ5aI4yLn1d1k3F9bCDKPEsluTzkj+zKWqAFUXVt7BNPCRWGWW8KkGAB/cYMDE7s
         aXXAlFHkJSt03k7/LeBfYRRf4bzFbXiiuNs43GnkTEB0YhuJuWy6dYFkroof92mtny
         5aoYxxaJL3LXQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Mahmoud Abumandour <ma.mandourr@gmail.com>,
        linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH] docs/bpf: Fix most/least significant bit typos
In-Reply-To: <c40b0d55-e3c9-2027-765b-a4868ae16795@iogearbox.net>
References: <20220319164337.1272312-1-ma.mandourr@gmail.com>
 <c40b0d55-e3c9-2027-765b-a4868ae16795@iogearbox.net>
Date:   Mon, 21 Mar 2022 10:12:45 -0600
Message-ID: <877d8nnv2a.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 3/19/22 5:43 PM, Mahmoud Abumandour wrote:
>> The LSB and MSB acronyms should not be followed by the word "bits". This
>> fixes this issue and uses the full phrases "most/least significant bits"
>> for better readibility.
>> 
>> Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
>
> What "issue" is being fixed here? Why would you not use the acronyms? It's fine
> as-is, not applying it.

I *think* that the nit being picked here is that the word "bits" after
an acronym like MSB is redundant...

jon
