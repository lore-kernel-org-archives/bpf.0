Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB8C433EF
	for <bpf@archiver.kernel.org>; Wed, 22 Sep 2021 03:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B086E6109E
	for <bpf@archiver.kernel.org>; Wed, 22 Sep 2021 03:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhIVDXG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Sep 2021 23:23:06 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58006 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhIVDXG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 23:23:06 -0400
Received: by linux.microsoft.com (Postfix, from userid 1095)
        id 230F02089D9C; Tue, 21 Sep 2021 20:21:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 230F02089D9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1632280897;
        bh=ZCZQpd8d/kjTTvQT1lCNL4kw8IYVQK9XcOkt/6XBBi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfhujFUkuORWBe0dLW370hKNJFhwIH5LZ924mupde1a62hAqEK+YEoxUIL+j+48ra
         ZtB0zTCClR3piKQvxov3OuLT/6/gFqpLasp3lRpN4EIfdEcKIh/utmE1+VE6SW/9j2
         rwpFfMD9J3Sl40GoKedIckciGJaDe89DLcjCiK0k=
Date:   Tue, 21 Sep 2021 20:21:37 -0700
From:   Muhammad Falak Wani <mwani@linux.microsoft.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Muhammad Falak R Wani <falakreyaz@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: Use sysconf to simplify libbpf_num_possible_cpus
Message-ID: <20210922032137.GA19826@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20210921060434.26732-1-falakreyaz@gmail.com>
 <CAEf4Bzau7EdBifN_Y_Y3HVs6Mm_UogytTzjXE+vB+W_HTiprmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzau7EdBifN_Y_Y3HVs6Mm_UogytTzjXE+vB+W_HTiprmA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> "This patch is a part ([0]) of libbpf-1.0 milestone.
> 
>   [0] Closes: https://github.com/libbpf/libbpf/issue/383
> 
> Please update in the next revision.
Sure, will send in a V2 of the patch.
> 
> 
> Also, keep in mind that we ask to use "[PATCH bpf-next]" prefix when
> submitting patches against the bpf-next kernel tree. It makes the
> intent clear and our BPF CI system knows which tree to test against.
> Thanks.
> 
Apologies, duly noted for subsequent patches.

> I'd say it's still a good idea for explicitness and to show that we
> didn't forget about it :) Plus, if it actually ever fails, we don't
> want to WRITE_ONCE() here, so please follow the same error handling
> logic as it was previously with parse_cpu_mask_file.
> 
> >
> >         WRITE_ONCE(cpus, tmp_cpus);
> >         return tmp_cpus;
Sure, will adhere to the coding style.

Thank you for your reivew.

-mfrw
