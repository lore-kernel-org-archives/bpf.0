Return-Path: <SRS0=Vsws=7D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDBAC433DF
	for <bpf@archiver.kernel.org>; Thu, 21 May 2020 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08F820829
	for <bpf@archiver.kernel.org>; Thu, 21 May 2020 15:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C459PlgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgEUPVP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 May 2020 11:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgEUPVP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 May 2020 11:21:15 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12954C061A0E
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 08:21:14 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t11so7455824qvv.11
        for <bpf@vger.kernel.org>; Thu, 21 May 2020 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9lkpAxU/Frlu8q2+TZv8WXsY+5fekFwCMxqOU2GbUws=;
        b=C459PlgMpa8qYr/Ahy0+Odf3EG4yZDSUOxlCSEUs+vVxwUqTKOmlVKvJpZ/abcX8fn
         7BtLnaWLCt0yWkz5ouOKN/pOmyT2AxSrampHkinUP48QYrjJT4PJ4QSaSuD3p0+yMASt
         eQKDY+G7Onm5nEfjgOj4YXTkrVikCzhyhE87IpPYsZo3K9DXDNu18MI1VSEAgBNJVowx
         ZRzjq1oAVSVpo/2S/65Sy0/bdqNPRlD5YXdYouIcqJtB7BeqZp6h6JXToBjAH3Oy951D
         mSwSHZMLXUTArnfK0RGWZRNCAwNW6o2zePN8a0nyL9gGEfRxr5xuoLgiJuiX2RK4YGQm
         m9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9lkpAxU/Frlu8q2+TZv8WXsY+5fekFwCMxqOU2GbUws=;
        b=c+1T8suT+U397yUQksQyZMm5hQPdVvj7I0ukfgQYZz1WQfNL7w+NzrdiVCQhi2EFYP
         Qi28sqQO7DDmojZNL55dcaZNUgZxn4n+XNKeRDgMMv7ZhpRtEBrYsLsKyIZnenJh4/ES
         g3H7M0WfGhRpgPAowKmEwrAjCQUVIFcAWsbKEAudX8Sp+HRVF5RFA7b+BM/ET44HdRQ4
         ICd1SBt/q4MdG1amT8wbhprGodVnW7+o1BRK2pbFmT+y83Y2S4u09FzTLOGSL9Rw+aWX
         ckTRBelG8etQHxyeuol0cwZa8c8YT7f63kVjmnyvv5aLwWQ3CxKXl69jI37PW3qXvF9K
         sGFg==
X-Gm-Message-State: AOAM533+mL3LZX3NOxo8HeBZkug6FZ7tYvMOWxzEWGU/z8abkkLjQdAe
        GX7ag7sNnfsDlLghjDu/HJ/+eHs=
X-Google-Smtp-Source: ABdhPJwEeEqc2SIIxOIk9bV5/VcJvZjsEaWLrXJuywDArF1hfveBKPIGJL/MpTKGOkINxIeFM/xgsEY=
X-Received: by 2002:a0c:906e:: with SMTP id o101mr10478572qvo.180.1590074473192;
 Thu, 21 May 2020 08:21:13 -0700 (PDT)
Date:   Thu, 21 May 2020 08:21:11 -0700
In-Reply-To: <20200521083435.560256-1-jakub@cloudflare.com>
Message-Id: <20200521152111.GB49942@google.com>
Mime-Version: 1.0
References: <20200521083435.560256-1-jakub@cloudflare.com>
Subject: Re: [PATCH bpf v2] flow_dissector: Drop BPF flow dissector prog ref
 on netns cleanup
From:   sdf@google.com
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/21, Jakub Sitnicki wrote:
> When attaching a flow dissector program to a network namespace with
> bpf(BPF_PROG_ATTACH, ...) we grab a reference to bpf_prog.

> If netns gets destroyed while a flow dissector is still attached, and  
> there
> are no other references to the prog, we leak the reference and the program
> remains loaded.

> Leak can be reproduced by running flow dissector tests from selftests/bpf:

>    # bpftool prog list
>    # ./test_flow_dissector.sh
>    ...
>    selftests: test_flow_dissector [PASS]
>    # bpftool prog list
>    4: flow_dissector  name _dissect  tag e314084d332a5338  gpl
>            loaded_at 2020-05-20T18:50:53+0200  uid 0
>            xlated 552B  jited 355B  memlock 4096B  map_ids 3,4
>            btf_id 4
>    #

> Fix it by detaching the flow dissector program when netns is going away.

> Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>

Thank you!
