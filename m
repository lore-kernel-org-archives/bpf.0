Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3CCC04FF3
	for <bpf@archiver.kernel.org>; Mon, 24 May 2021 07:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E30D610CE
	for <bpf@archiver.kernel.org>; Mon, 24 May 2021 07:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhEXHWd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 May 2021 03:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232128AbhEXHWd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 May 2021 03:22:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3F65611AC;
        Mon, 24 May 2021 07:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621840866;
        bh=aebQqeP1Et0R6r0nSuFxUZP6l819ABYo96hm19lWjSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKOs7/K3I0HLePoutwTraN3QZ4J3oFjBISqG6JntRnuoiCKpfAm8ox6Y9QenlbsCo
         X/Qn7YxFkaYCYKuA2fmJYpfujneIH3/LHMqgV6e6/MJKqq9g7wb4TM8yz1KeOcw70O
         ok2qeLMSu6fmz3ENRJ8UJb2UGliS5JCjpqOcGBHU=
Date:   Mon, 24 May 2021 09:21:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liu Jian <liujian56@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, sdf@google.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: Add sock_release help info for cgroup attach
 command
Message-ID: <YKtT337G53rMDiAH@kroah.com>
References: <20210524071548.115138-1-liujian56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524071548.115138-1-liujian56@huawei.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 24, 2021 at 03:15:48PM +0800, Liu Jian wrote:
> Fixes: db94cc0b4805 ("bpftool: Add support for BPF_CGROUP_INET_SOCK_RELEASE")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  tools/bpf/bpftool/cgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I know I do not take patches without any changelog text, maybe other
maintainers are more leniant...
