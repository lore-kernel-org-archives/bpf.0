Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844E7C433EF
	for <bpf@archiver.kernel.org>; Tue, 21 Jun 2022 19:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352707AbiFUTEE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352715AbiFUTED (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 15:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD93424F01
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 12:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A53261686
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 19:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2280CC3411C;
        Tue, 21 Jun 2022 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655838237;
        bh=DXwpMAEfnhLyH14rL0X7EyXd3OkjumhwAcs/I8GDWjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v00VOdDeCZyadE3cjqoEVHjOQL2eTeBQSv/cBt15zixo665FiSJgSgEt5UmU5gOFa
         rINni4FIAVr8ZaFu6imN9tDziG7xSwbRt267Yqg3ZhId9Sf9ddTacwDXcn8t+Y7wql
         KaOJczgyq6wq5vNoxNeoD+y+MFfPRk3+14P8vDu4=
Date:   Tue, 21 Jun 2022 21:03:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mangosteen728 <mangosteen728@gmail.com>
Cc:     ast <ast@kernel.org>, andrii <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>, daniel <daniel@iogearbox.net>,
        BigBro Young <hi.youthinker@gmail.com>,
        mangosteen 728 <mangosteen728@163.com>
Subject: Re: [PATCH] bpf: fix trace_output_kern bug
Message-ID: <YrIWGg707NQrIjdc@kroah.com>
References: <CAB8PBH+BkggqFhFeTdmuKAErg8NGKhcTyRH=v2UkevC11S9Jxg@mail.gmail.com>
 <CAB8PBHKgc5vD7d9SHj+2pfhhGQfzZ0KMYVVT3aW18ST1XRTJMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB8PBHKgc5vD7d9SHj+2pfhhGQfzZ0KMYVVT3aW18ST1XRTJMw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 02:56:02AM +0800, mangosteen728 wrote:
> From: mangosteen728 <mangosteen728@gmail.com>
> 
> For the third parameter of this function, whose flags is set to 0, the
> perf_buffer__poll remains blocked.The flags value of BPF_F_CURRENT_CPU
> can receive the data normally.
> 
> Signed-off-by: mangosteen728 <mangosteen728@gmail.com>

I do not think you sign legal documents with "mangosteen728".  Please
use your real name.

thanks,

greg k-h
