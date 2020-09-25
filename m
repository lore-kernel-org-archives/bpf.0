Return-Path: <SRS0=/Hy+=DC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486CEC4363D
	for <bpf@archiver.kernel.org>; Fri, 25 Sep 2020 14:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF36F21D42
	for <bpf@archiver.kernel.org>; Fri, 25 Sep 2020 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601045183;
	bh=3w5NNqc7jT6JaZYPF4bZ4mg4V5ds7q+TVD2DX8grWiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=umo1QR5jBbN+D/G8o27nlPEkcGgQNHBR2j+dQFLoJN0dOSa248EILqgtthYWYf0bV
	 bUHUcLd+H2AwRyRLONOiUqB3m9XG3riYwaaRu21Fl6rUak5w5NWUSDBPJDUtzA33Ag
	 Simpyjr1W3Ky9XZjaG6HfhFRqE6SxMlvwNCG7DQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgIYOqX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbgIYOqX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 10:46:23 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EB122074B;
        Fri, 25 Sep 2020 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601045182;
        bh=3w5NNqc7jT6JaZYPF4bZ4mg4V5ds7q+TVD2DX8grWiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G7/fA8Y9vYqD0QHIrh+ypvz+Lt/wfPe5lwSL0+TK28bfKmah6wyA1QBdT96N6VvXF
         pERfjbHC+hNmqvDuRHg6xbGAyOihsBv8P2qabuF+qDPEyUfwmG8/RDrcdaSsVWSqNt
         1UemJLaOVZOVVaSpDrI/6gsSml2bPdYcXAOwHyBo=
Date:   Fri, 25 Sep 2020 07:46:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/6] bpf: add classid helper only based on
 skb->sk
Message-ID: <20200925074620.4ad50dcc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <2e761d23d591a9536eaa3ecd4be8d78c99f00964.1600967205.git.daniel@iogearbox.net>
References: <cover.1600967205.git.daniel@iogearbox.net>
        <2e761d23d591a9536eaa3ecd4be8d78c99f00964.1600967205.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 24 Sep 2020 20:21:22 +0200 Daniel Borkmann wrote:
> Similarly to 5a52ae4e32a6 ("bpf: Allow to retrieve cgroup v1 classid
> from v2 hooks"), add a helper to retrieve cgroup v1 classid solely
> based on the skb->sk, so it can be used as key as part of BPF map
> lookups out of tc from host ns, in particular given the skb->sk is
> retained these days when crossing net ns thanks to 9c4c325252c5
> ("skbuff: preserve sock reference when scrubbing the skb."). This
> is similar to bpf_skb_cgroup_id() which implements the same for v2.
> Kubernetes ecosystem is still operating on v1 however, hence net_cls
> needs to be used there until this can be dropped in with the v2
> helper of bpf_skb_cgroup_id().
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

FWIW lot's of whitespace warnings from checkpatch --strict about
comments having spaces before tabs here.
