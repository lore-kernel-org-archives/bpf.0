Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD1BC433E0
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 16:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E216620714
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595521779;
	bh=RUQDCU/r4+nb/UBP4ayzcebZRr2bgQyVMEfS5BBIuP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vzW0Knpuq9K8uIlreHpSklA1zc8YbTOr+zYOrpWLOlMZNsgxkb0hHxTkBMnVKuB4a
	 k2HF8jQ1nOa1itClADrRydABHWB9rGSUOlRtacMhRXqlAoaTk9nTxIfbCDLHNUnESC
	 A7eGMlP7ex69hE8pySFduO+0TZEED46Qckm/9+68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgGWQ3j (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQ3j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 12:29:39 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28D7206D8;
        Thu, 23 Jul 2020 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595521779;
        bh=RUQDCU/r4+nb/UBP4ayzcebZRr2bgQyVMEfS5BBIuP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2G61JMGdG5JFN14HeDSYa597AxtJGxgzefRnKgk8UJCST+CHG8U9QLha9mKUFOiC6
         aXyyDhpcyB/Zo/R72mGkSGgk5H1ow3geZ7K9DFfBQbXVMXgj0uGLGkkvsYsGwxPSdW
         xFb5/Zp2kXVZtD5C/AO6/hnFlcZXRfuk6YCavM1M=
Date:   Thu, 23 Jul 2020 09:29:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>, <kernel-team@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Neal Cardwell <ncardwell@google.com>, <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>
Subject: Re: [PATCH v2 bpf-next 6/9] bpf: tcp: Allow bpf prog to write and
 parse TCP header option
Message-ID: <20200723092936.615fdae7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200723010412.1908242-1-kafai@fb.com>
References: <20200723010334.1905574-1-kafai@fb.com>
        <20200723010412.1908242-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Jul 2020 18:04:12 -0700 Martin KaFai Lau wrote:
> @@ -3345,6 +3489,7 @@ int tcp_send_synack(struct sock *sk)
>   */
>  struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
>  				struct request_sock *req,
> +				struct sk_buff *syn_skb,
>  				struct tcp_fastopen_cookie *foc,
>  				enum tcp_synack_type synack_type)
>  {

Kdoc missing for this one.

While at it would you mind putting an @ before the other ones?
