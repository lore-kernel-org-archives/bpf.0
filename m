Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D85C433B4
	for <bpf@archiver.kernel.org>; Thu, 29 Apr 2021 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DBD61449
	for <bpf@archiver.kernel.org>; Thu, 29 Apr 2021 14:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbhD2Oxh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhD2Oxh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Apr 2021 10:53:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7FBC06138B;
        Thu, 29 Apr 2021 07:52:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so11006838wmh.0;
        Thu, 29 Apr 2021 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NT2Hp5L7Nzz9ajwEixcLZ1tduHrYebJ8JgwbrGCeGp4=;
        b=eawt6e/TOibftbO14Ix2cKYi48eF5QkXhccJtV7T/zH9JAuDBHWCMlKKXq6QB/rwR8
         xazsWW4vQPjOHBvJJIg4Z8JFdXaaKaS2aykLS2DvGTBhaZV/wD+Hi9f6Zl/waTqeGTmH
         ZDe8/AMQsP2vqtODBs/Yjy364zoLNGO4zIyTAe9CuOFwU2prsCOwUQiQIl6T+GQ30BYT
         6/6j0SYo1mmdpsFh5YELRy5xL9oSnXnHwAh1wM6/GeqMlOscGvyQEnik0gGVtmf4Flpz
         5xcOpUEYn4x5gomgQnzahaFwkcnr8aJK5WiQgJzmq+lqkmOiy5Zp9RVH3IIL0DN4WmiY
         3P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NT2Hp5L7Nzz9ajwEixcLZ1tduHrYebJ8JgwbrGCeGp4=;
        b=JF8h5gelT2i61s5ZDVVElufo+Tc2PWiLNIBeeAous1IAxeBeWnjDwIL3ZDOk8I2kif
         s6rah7B3qI2D77R7YUvs1aEZ0nyRbUZvSgAEb6saSxtli5r9hrfRGH3C27vKU+xqcrNb
         WN23Mpj1pFJbTz3AWkNCw6mXZF49pa9SxEdGw25I62uEEpwW7R24Whm4OiTib53efhtH
         5zKwJGkYHyQKVzHouBsBCVaVKUe4GHhNSYD0Dau0LvKx7EY1xWkFgLQovzUQARGBk6a0
         koac7TD98TXywl3REH4h6L2Poaz2iHjUvcX2a94Cyjl4ja+cKd9mxXoY5uHaMjDaNqCu
         Cyjw==
X-Gm-Message-State: AOAM5336d7Vb1V54ZNB/+WI9Jr2D9Y25yOm0/rDHxgbbCuvId4XKmptr
        UBZPMMaAX3/TA4pt0idSn5RbCuu1QksmAg==
X-Google-Smtp-Source: ABdhPJxFUK3O2WPjLR+j8yphVDyp+vFb/5YE9rqDfUYuGfhkKikYJzMaMH/MCHlJgi0MYbDwwgTD1w==
X-Received: by 2002:a05:600c:358b:: with SMTP id p11mr10969493wmq.143.1619707968966;
        Thu, 29 Apr 2021 07:52:48 -0700 (PDT)
Received: from [192.168.1.122] (cpc159425-cmbg20-2-0-cust403.5-4.cable.virginm.net. [86.7.189.148])
        by smtp.gmail.com with ESMTPSA id k11sm364663wmr.35.2021.04.29.07.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 07:52:48 -0700 (PDT)
Subject: Re: [PATCH bpf-next 3/3] bpf: verifier: allocate idmap scratch in
 verifier env
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210429134656.122225-1-lmb@cloudflare.com>
 <20210429134656.122225-4-lmb@cloudflare.com>
From:   Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <a467432f-065a-1b3b-b7eb-7e62f70918bf@gmail.com>
Date:   Thu, 29 Apr 2021 15:52:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210429134656.122225-4-lmb@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 29/04/2021 14:46, Lorenz Bauer wrote:
> func_states_equal makes a very short lived allocation for idmap,
> probably because it's too large to fit on the stack. However the
> function is called quite often, leading to a lot of alloc / free
> churn. Replace the temporary allocation with dedicated scratch
> space in struct bpf_verifier_env.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
