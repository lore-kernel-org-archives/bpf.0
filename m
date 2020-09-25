Return-Path: <SRS0=/Hy+=DC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5B3C4363D
	for <bpf@archiver.kernel.org>; Fri, 25 Sep 2020 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ECB021D42
	for <bpf@archiver.kernel.org>; Fri, 25 Sep 2020 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601046023;
	bh=/hcZrQBk6c3ZUDPJ9tBI/HFhM9gxyHp4Nl9AXMNCJgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wHgejqLN/gmdYk1yZuUF89lxUaUiCxJnaSKLnr7+fL3BhVRBvCli1XqkIRYYASeqS
	 AnM+/gA8/41aGWC7d/Z7ignTZfFH9TAH7+9nzS1eZlojejaGgpmsZF06eRII6tBaos
	 Mb6qcOsxW2FR/H07JmvTa/ub/2KDRdR9QgM7B6mM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgIYPAX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbgIYPAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 11:00:22 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9DC820715;
        Fri, 25 Sep 2020 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601046022;
        bh=/hcZrQBk6c3ZUDPJ9tBI/HFhM9gxyHp4Nl9AXMNCJgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sOhU9u/AcSHN01u+C/3/rDcW+A1ojw4SWLk62TOJS5W8VgVePr4kF01v+l2kRJWeu
         APnEQRrnheDgmUunO4gwgU7Jqdp5q5LdCZ3UnUZZ/JGySoH4nWb/7zqA88d7M3bfNW
         yti6l+T7Wysu7HR2/h8Ir+yj9HsOZZeBPjvlus6M=
Date:   Fri, 25 Sep 2020 08:00:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, ast@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf, net: rework cookie generator as
 per-cpu one
Message-ID: <20200925080020.013165a0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <dc5dd027-256d-598a-2f89-a45bb30208f8@iogearbox.net>
References: <cover.1600967205.git.daniel@iogearbox.net>
        <d4150caecdbef4205178753772e3bc301e908355.1600967205.git.daniel@iogearbox.net>
        <e854149f-f3a6-a736-9d33-08b2f60eb3a2@gmail.com>
        <dc5dd027-256d-598a-2f89-a45bb30208f8@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Sep 2020 00:03:14 +0200 Daniel Borkmann wrote:
> static inline u64 gen_cookie_next(struct gen_cookie *gc)
> {
>          u64 val;
> 
>          if (likely(this_cpu_inc_return(*gc->level_nesting) == 1)) {

Is this_cpu_inc() in itself atomic?

Is there a comparison of performance of various atomic ops and locking
somewhere? I wonder how this scheme would compare to a using a cmpxchg.

>                  u64 *local_last = this_cpu_ptr(gc->local_last);
> 
>                  val = *local_last;
>                  if (__is_defined(CONFIG_SMP) &&
>                      unlikely((val & (COOKIE_LOCAL_BATCH - 1)) == 0)) {

Can we reasonably assume we won't have more than 4k CPUs and just
statically divide this space by encoding CPU id in top bits?

>                          s64 next = atomic64_add_return(COOKIE_LOCAL_BATCH,
>                                                         &gc->shared_last);
>                          val = next - COOKIE_LOCAL_BATCH;
>                  }
>                  val++;
>                  if (unlikely(!val))
>                          val++;
>                  *local_last = val;
>          } else {
>                  val = atomic64_add_return(COOKIE_LOCAL_BATCH,
>                                            &gc->shared_last);
>          }
>          this_cpu_dec(*gc->level_nesting);
>          return val;
> }
