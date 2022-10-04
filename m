Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23303C433FE
	for <bpf@archiver.kernel.org>; Tue,  4 Oct 2022 14:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJDOZc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 4 Oct 2022 10:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJDOZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 10:25:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD541AD9E;
        Tue,  4 Oct 2022 07:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 06F76CE1043;
        Tue,  4 Oct 2022 14:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2869FC433C1;
        Tue,  4 Oct 2022 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664893523;
        bh=qUqbsJku3xvlwf4BvYVaEXk5kVg6vtgqU1ZEsBwQ07w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vn8bbe6CoCL/3i6puA9++idmY6Msrgx8E2QjPyE/7nQZ+mlnoeaXU8D7YnQoZ9Ekk
         O2BdYp+1hr7OsG9hwq2zhM4oPh1+7AT+UFM/2nX9fUR8bsRY1ESEvlQuYaPzemiC2a
         0ix594/sqGgQ7vOeNXgoTMxVzs+SUz6YS7R02hUVOVT/mvV1zsg0F5oSiq8C7Lg17d
         SEoXHI1K1S23Ae0kggftydrrJbMGd1STboFO+e3zpBC/iiEZHr1g5/psvCNRB6m8nv
         9RTHjjuIUs+JSi0Q52TbjTh0QEyeCDu9yvgcUi1BtxGCDzvMz3cQVl5U6PwgDj/gCt
         1OEdr9KxfoYRw==
Date:   Tue, 4 Oct 2022 07:25:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: WARN: multiple IDs found for 'nf_conn': 92168, 117897 - using
 92168
Message-ID: <20221004072522.319cd826@kernel.org>
In-Reply-To: <YzvV0CFSi9KvXVlG@krava>
References: <20221003190545.6b7c7aba@kernel.org>
        <20221003214941.6f6ea10d@kernel.org>
        <YzvV0CFSi9KvXVlG@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 4 Oct 2022 08:42:24 +0200 Jiri Olsa wrote:
> I did not see that before, could you please share your config?

allmodconfig
