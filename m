Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB46BC25B0E
	for <bpf@archiver.kernel.org>; Tue, 16 Aug 2022 13:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiHPNJ5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Aug 2022 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiHPNJz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 09:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0E3B1BB9
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660655393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8awJny9/ykLwiE6dZBhJI/2SwPImayCQ0hkEt7cHi1w=;
        b=Dhbjp3KWP2M9OrvxeYc8Fn/kuXdJU+zB7HIyDxaE26cau6epxE8xy/qHDM8yHQJX7cEAzu
        rIndTR7kP0Qbqx4t+EgAMwQ1ch7ffmpPDMA2+4Xk/HylMBEAgJfIPSv4WpQ+u7rCgjIO8R
        /MjP+GfrQJG+rUWjgdMybC4QYTqpwc0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-CUgRfkWnO82eztXDflM4gA-1; Tue, 16 Aug 2022 09:09:50 -0400
X-MC-Unique: CUgRfkWnO82eztXDflM4gA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 949E13C1014B;
        Tue, 16 Aug 2022 13:09:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F7B0C15BA6;
        Tue, 16 Aug 2022 13:09:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220816103452.479281-1-yin31149@gmail.com>
References: <20220816103452.479281-1-yin31149@gmail.com> <166064248071.3502205.10036394558814861778.stgit@warthog.procyon.org.uk>
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     dhowells@redhat.com, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bpf@vger.kernel.org
Subject: Re: [PATCH] net: Fix suspicious RCU usage in bpf_sk_reuseport_detach()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3961604.1660655386.1@warthog.procyon.org.uk>
Date:   Tue, 16 Aug 2022 14:09:46 +0100
Message-ID: <3961607.1660655386@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hawkins Jiawei <yin31149@gmail.com> wrote:

>  	if (socks) {
>  		WRITE_ONCE(sk->sk_user_data, NULL);

Btw, shouldn't this be rcu_assign_pointer() or RCU_INIT_POINTER(), not
WRITE_ONCE()?

David

