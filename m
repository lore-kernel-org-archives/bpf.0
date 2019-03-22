Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28045C10F00
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 02:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB71221900
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 02:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzHsXtVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCVC7X (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:59:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41804 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVC7X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 22:59:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so478806pfn.8;
        Thu, 21 Mar 2019 19:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=daG7hdk/YQ4hsrvMXwY+6U2q40zTbtis0mj7TzPWD2w=;
        b=dzHsXtVy9ei/gibQfFgoL73xoVXcJ4ygIqaxQiz+HotVTdMwMPHsrIHeEbSlIp+tt6
         GmVnMgNaJLEzzGiKrSvOZkiJhyQEgMdobQx1ElcRFEbzNxejG0PewRf0tvhTLk0hSL9i
         6HPmyivRN9qyuZOi30jR14QxRUcjHyhbKSFKQimPje+Q6VSD7BYdMUd5YLqfZSAljvCZ
         bReOrRyghma9gblMO38JotWBbh6wqoIca+9wsHkUgn7WuZ5Psx9hzc52MqYE45veXlen
         Gipg/1JVx9Lgf1nnQcWAfKRNZ00vnreSKLCKnqfVRVN4yBDg7oOKVK11oUJj4RYsm2mN
         Codw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=daG7hdk/YQ4hsrvMXwY+6U2q40zTbtis0mj7TzPWD2w=;
        b=GzZOJ0eP7dUDqFtDKCiBaY4ZMnmQENaq6whrL671SYh7bgcWIk3Kddsg+lHNqvby1k
         PdWInXEvw1iV/zj7/bC/pWxMUIhlX2CrQqMWAKTAXKbX8YzsZdrn9YxggU7bdWbahjfe
         yZrWwgjz7t36PKBIam3T9WYGfTbe3q3jbxlyF0mTZ9DNuYw9ToAC+nIrOkpRJnQedCwv
         ex0zD2WGdLNbkQG6LNAnz2M8SqLOEvBV6ggVxm/sCMilQTpZGj4bi6EqU3eaO+dVkJnL
         9aXtvRhH8JHCMa8bBysqoaKV0xeew1HLZ4zZimaGQCcxH+2+Ikm78F2upMKRhsbbIAwB
         pQSg==
X-Gm-Message-State: APjAAAWumF5OM7m6kv8wmbZEIQQGPe6rig3SwDgutlbQIllnDFqVTwyl
        g9V+3/Ajpi4/cd5cE2S56r0=
X-Google-Smtp-Source: APXvYqwyfOSzfDqkW9bJxgzg2eICERhBsEmknCz3x+1f67Ph0aBeBtGdxxYSBS9C7tSRdCrmLpgNRw==
X-Received: by 2002:a62:480d:: with SMTP id v13mr6891989pfa.125.1553223561881;
        Thu, 21 Mar 2019 19:59:21 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::d464])
        by smtp.gmail.com with ESMTPSA id f10sm6672045pgo.55.2019.03.21.19.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 19:59:21 -0700 (PDT)
Date:   Thu, 21 Mar 2019 19:59:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH bpf] bpf: verifier: propagate liveness on all frames
Message-ID: <20190322025915.rwxwrgxccf7hmyje@ast-mbp.dhcp.thefacebook.com>
References: <20190321213436.22379-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321213436.22379-1-jakub.kicinski@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 21, 2019 at 02:34:36PM -0700, Jakub Kicinski wrote:
> Commit 7640ead93924 ("bpf: verifier: make sure callees don't prune
> with caller differences") connected up parentage chains of all
> frames of the stack.  It didn't, however, ensure propagate_liveness()
> propagates all liveness information along those chains.
> 
> This means pruning happening in the callee may generate explored
> states with incomplete liveness for the chains in lower frames
> of the stack.
> 
> The included selftest is similar to the prior one from commit
> 7640ead93924 ("bpf: verifier: make sure callees don't prune with
> caller differences"), where callee would prune regardless of the
> difference in r8 state.
> 
> Now we also initialize r9 to 0 or 1 based on a result from get_random().
> r9 is never read so the walk with r9 = 0 gets pruned (correctly) after
> the walk with r9 = 1 completes.
> 
> The selftest is so arranged that the pruning will happen in the
> callee.  Since callee does not propagate read marks of r8, the
> explored state at the pruning point prior to the callee will
> now ignore r8.
> 
> Propagate liveness on all frames of the stack when pruning.
> 
> Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>

wow. Applied. Thanks a lot.

