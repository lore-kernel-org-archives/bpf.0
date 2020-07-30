Return-Path: <SRS0=uBQJ=BJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8CEC433E0
	for <bpf@archiver.kernel.org>; Thu, 30 Jul 2020 23:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE3492074B
	for <bpf@archiver.kernel.org>; Thu, 30 Jul 2020 23:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596150981;
	bh=jV18/jcAfyBNdKXiKomBQ4xuaDpihYjnYpMMURmt6/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aH3gdf8z82DMqP8rAIPqop8fPWwKjvscYV8AfwovujPB2fRl9OorSUQ5n3QRIHBmX
	 Sc2KCFY8X9h7E+kicrKLxTKUXZzs41eGvSifhOE3YT9TJpyBOGAAjiqT/TFbDuhV8Z
	 b0vV+61ioAD0+PhVAtAW33idwnII58wEgZuZwedc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgG3XQQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgG3XQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 19:16:16 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D6A020663;
        Thu, 30 Jul 2020 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596150976;
        bh=jV18/jcAfyBNdKXiKomBQ4xuaDpihYjnYpMMURmt6/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VSj6mhzGSAQOTQv2hwW5ylCeQQQyNExtDVnbqF3WJfya60aQAEtb5uWnlQ35DwYRY
         XM9aeGvJsrshNvz1XRVl/IrTi1f13juWyrEN1uJT/PsDtMwaDNvDoomTjsXuNWGZcC
         Od3OWtN9wk7RHBB5oRRrfFla3dv+VJ4O5BKTmsTk=
Date:   Thu, 30 Jul 2020 16:16:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Tariq Toukan <tariqt@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH v2] net/mlx5e: fix bpf_prog reference count leaks in
 mlx5e_alloc_rq
Message-ID: <20200730161613.7a0265b3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200730102941.5536-1-xiongx18@fudan.edu.cn>
References: <20200730102941.5536-1-xiongx18@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 30 Jul 2020 18:29:41 +0800 Xin Xiong wrote:
> Fixes: 422d4c401edd ("net/mlx5e: RX, Split WQ objects for different RQ
> types")
> 
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Thanks for the patch, please make sure Fixes tag is not line-wrapped
and there is no empty line between that and the sign-offs.
