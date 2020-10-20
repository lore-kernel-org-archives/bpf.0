Return-Path: <SRS0=ZEGR=D3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A31C4363A
	for <bpf@archiver.kernel.org>; Tue, 20 Oct 2020 16:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33B622251
	for <bpf@archiver.kernel.org>; Tue, 20 Oct 2020 16:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603211649;
	bh=k/CzWaaRtw2aJTqNhOY3m0LJsco5GLdq4nD5iASwUx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EBF8xlNg9hfCEprUzlt0pfUHDNZ2ca3z7kl85vlUnUiQx2Fijs/rgsXI/a4esAAVd
	 1+/aawho1L3z6+NuilvKWGPNuk6RSvYrzlY31JG3HCG9cfz8QFraEok4neqj3hWyVK
	 8j9ZwsLwxpvR554V8uVKgSBORxNvbnqL3sfG57oA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394686AbgJTQeJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 20 Oct 2020 12:34:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394687AbgJTQeJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Oct 2020 12:34:09 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99CCB2224A;
        Tue, 20 Oct 2020 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603211647;
        bh=k/CzWaaRtw2aJTqNhOY3m0LJsco5GLdq4nD5iASwUx8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eHHMAEtwlcQ1vJr+a+c8+8oyQyY1h+DRiRuXExmMfwO3UAlP8zNHtScitDcF3X2Tl
         x1aotzkzuGhhoakKWR6Mli4K7PWRRfiVs5DYlvVQ5TeiajkHy5Gcid/hs1WjiM25RS
         BejACx70FVNBJpukgCeUBcOb8U0H4Ea1XVswbbMQ=
Date:   Tue, 20 Oct 2020 09:34:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/3] bpf_redirect_neigh: Support supplying the
 nexthop as a helper parameter
Message-ID: <20201020093405.59079473@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <160319106221.15822.2629789706666194966.stgit@toke.dk>
References: <160319106111.15822.18417665895694986295.stgit@toke.dk>
        <160319106221.15822.2629789706666194966.stgit@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 20 Oct 2020 12:51:02 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> +struct bpf_nh_params {
> +	u8 nh_family;
> +	union {
> +		__u32 ipv4_nh;
> +		struct in6_addr ipv6_nh;
> +	};
> +};

Folks, not directly related to this set, but there's a SRv6 patch going
around which adds ifindex, otherwise nh can't be link local.

I wonder if we want to consider this use case from the start (or the
close approximation of start in this case ;)).
