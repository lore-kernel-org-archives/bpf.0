Return-Path: <SRS0=7rOB=3P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66481C2D0DB
	for <bpf@archiver.kernel.org>; Sun, 26 Jan 2020 21:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CA120716
	for <bpf@archiver.kernel.org>; Sun, 26 Jan 2020 21:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHvidQUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgAZVaT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 26 Jan 2020 16:30:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24051 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726294AbgAZVaS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 26 Jan 2020 16:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580074217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgLsNnXIs4bLR799WuRvndkBFnI0PA7oUD0BFNAV8H8=;
        b=GHvidQUkZf90BEqY4tvm+o9v/p0L3v2uoDyJi6d+abFJN8o9GYawa1VvTpe1wqN3/G4/m8
        opyOtzm+iPxvw/p5iVkOlF3o/7WtqT2s8W2g+HoUszH1tLpz2T/7J2leYELsdhUrzIJlAj
        0Jem+J1u5x5H5kATiVgAaRvBGuVgmvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-_gOholJ2MVeOBn2UpFCArg-1; Sun, 26 Jan 2020 16:30:16 -0500
X-MC-Unique: _gOholJ2MVeOBn2UpFCArg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E83813E3;
        Sun, 26 Jan 2020 21:30:14 +0000 (UTC)
Received: from carbon (ovpn-200-16.brq.redhat.com [10.40.200.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75CF73D8C;
        Sun, 26 Jan 2020 21:30:06 +0000 (UTC)
Date:   Sun, 26 Jan 2020 22:30:06 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     brouer@redhat.com, bpf@vger.kernel.org, bjorn.topel@intel.com,
        songliubraving@fb.com, ast@kernel.org, daniel@iogearbox.net,
        toke@redhat.com, maciej.fijalkowski@intel.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] bpf: xdp, remove no longer required
 rcu_read_{un}lock()
Message-ID: <20200126223006.2b8582c5@carbon>
In-Reply-To: <1580011133-17784-4-git-send-email-john.fastabend@gmail.com>
References: <1580011133-17784-1-git-send-email-john.fastabend@gmail.com>
        <1580011133-17784-4-git-send-email-john.fastabend@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 25 Jan 2020 19:58:53 -0800
John Fastabend <john.fastabend@gmail.com> wrote:

> Now that we depend on rcu_call() and synchronize_rcu() to also wait
> for preempt_disabled region to complete the rcu read critical section
> in __dev_map_flush() is no longer required. Except in a few special
> cases in drivers that need it for other reasons.
> 
> These originally ensured the map reference was safe while a map was
> also being free'd. And additionally that bpf program updates via
> ndo_bpf did not happen while flush updates were in flight. But flush
> by new rules can only be called from preempt-disabled NAPI context.
> The synchronize_rcu from the map free path and the rcu_call from the
> delete path will ensure the reference there is safe. So lets remove
> the rcu_read_lock and rcu_read_unlock pair to avoid any confusion
> around how this is being protected.
> 
> If the rcu_read_lock was required it would mean errors in the above
> logic and the original patch would also be wrong.
> 
> Now that we have done above we put the rcu_read_lock in the driver
> code where it is needed in a driver dependent way. I think this
> helps readability of the code so we know where and why we are
> taking read locks. Most drivers will not need rcu_read_locks here
> and further XDP drivers already have rcu_read_locks in their code
> paths for reading xdp programs on RX side so this makes it symmetric
> where we don't have half of rcu critical sections define in driver
> and the other half in devmap.
> 
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

