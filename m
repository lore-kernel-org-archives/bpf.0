Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E35C43334
	for <bpf@archiver.kernel.org>; Mon, 27 Jun 2022 19:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbiF0T03 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbiF0T02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 15:26:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3183325E3
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 12:26:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E0E9CE1999
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 19:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56635C341CA;
        Mon, 27 Jun 2022 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656357983;
        bh=aIDigAr3EgD0yRTm0bAta4YrTxb34XveoC3d8fdCo5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bOiqZ1RhUm/wsYUFesgbSeWzMbojzJTNw0GHsCYrfOJ6fgESD2B8vRYAHE41D5AXc
         GjbtFhveQalY44lBXsNBr7oFKSBeCCuBRgrv+wsXlEFaOh6PBf/ulXRvDPPyNzeCpC
         kY2CQNPMwIPeRq7CihXDF2oIPCeP4Sy8+Ob9bZW6dOrliUVGBtL0QPgq5En7eXsXiQ
         D+giyBVexXeib5L0BCxiaBlLmFSSZzIz8vfSyp9fnIEaVF/xIxLQQXfAWCOCP/Py+3
         kRDG7QDnBtV92uus1hfDc2Iw8l+KTDWWVb9rDbXyUQ/dORpDkdGET2oLrvcD/HCO/V
         WVH9EDBM/UJZw==
Date:   Mon, 27 Jun 2022 12:26:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf] bpf, docs: Better scale maintenance of BPF
 subsystem
Message-ID: <20220627122535.6020f23e@kicinski-fedora-PC1C0HJN>
In-Reply-To: <5bdc73e7f5a087299589944fa074563cdf2c2c1a.1656353995.git.daniel@iogearbox.net>
References: <5bdc73e7f5a087299589944fa074563cdf2c2c1a.1656353995.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Jun 2022 20:22:55 +0200 Daniel Borkmann wrote:
> -BPF (Safe dynamic programs and tools)
> +BPF [GENERAL] (Safe Dynamic Programs and Tools)
>  M:	Alexei Starovoitov <ast@kernel.org>
>  M:	Daniel Borkmann <daniel@iogearbox.net>
>  M:	Andrii Nakryiko <andrii@kernel.org>
> -R:	Martin KaFai Lau <kafai@fb.com>
> -R:	Song Liu <songliubraving@fb.com>
> +R:	Martin KaFai Lau <martin.lau@linux.dev>
> +R:	Song Liu <song@kernel.org>
>  R:	Yonghong Song <yhs@fb.com>
>  R:	John Fastabend <john.fastabend@gmail.com>
>  R:	KP Singh <kpsingh@kernel.org>
> -L:	netdev@vger.kernel.org
> +R:	Stanislav Fomichev <sdf@google.com>
> +R:	Hao Luo <haoluo@google.com>
> +R:	Jiri Olsa <jolsa@kernel.org>
>  L:	bpf@vger.kernel.org
>  S:	Supported
>  W:	https://bpf.io/

Can we pause and think a bit about the purpose for this entry? I've been
trying to make people obey get_maintainer.pl but having to CC 11 people
is a asking a lot - especially that this entry regexp-keys on BPF (K:
bpf N: bpf). So any patch that as much as uses the letters "bpf" gets
an enormous CC list.
