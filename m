Return-Path: <SRS0=D/lL=2J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8495C43603
	for <bpf@archiver.kernel.org>; Thu, 19 Dec 2019 07:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F34124650
	for <bpf@archiver.kernel.org>; Thu, 19 Dec 2019 07:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiuH/iSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfLSHS2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Dec 2019 02:18:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60239 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbfLSHS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 02:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576739906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvuyE3XNLiqrKcITgNM9IqSO03KcCDguA8aANa+9ouw=;
        b=HiuH/iSpzYlB7D7SgG3p25vlyAgXg1xcu9o4adX4yUcinD4UagZOmgpkkOuakzvs3Pkbg6
        sLfnSZQXrx1g14Gyice++Bp3KXKBK+IyUOIa7TQ8ov3qJ+pWAPZ0LaX6m3pWJFuQv6uyfl
        F9prHiZyg82F1nZHP5RV/GD9I6pjH9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-YCLQbHarP3it7edjCKN25Q-1; Thu, 19 Dec 2019 02:18:24 -0500
X-MC-Unique: YCLQbHarP3it7edjCKN25Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF557DBA5;
        Thu, 19 Dec 2019 07:18:22 +0000 (UTC)
Received: from carbon (ovpn-200-37.brq.redhat.com [10.40.200.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24136620D8;
        Thu, 19 Dec 2019 07:18:18 +0000 (UTC)
Date:   Thu, 19 Dec 2019 08:18:15 +0100
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf-next v2 0/8] Simplify
 xdp_do_redirect_map()/xdp_do_flush_map() and XDP maps
Message-ID: <20191219081815.0b07de1a@carbon>
In-Reply-To: <20191219061006.21980-1-bjorn.topel@gmail.com>
References: <20191219061006.21980-1-bjorn.topel@gmail.com>
Organization: Red Hat Inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 19 Dec 2019 07:09:58 +0100
Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> wrote:

>   $ sudo ./xdp_redirect_cpu --dev enp134s0f0 --cpu 22 xdp_cpu_map0
                                                        ^^^^^^^^^^^^
>  =20
>   Running XDP/eBPF prog_name:xdp_cpu_map5_lb_hash_ip_pairs
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   XDP-cpumap      CPU:to  pps            drop-pps    extra-info
>   XDP-RX          20      7723038        0           0
>   XDP-RX          total   7723038        0
[...]

Talking about how to invoke the 'xdp_redirect_cpu' program, I notice
that you are using BPF-prog named: 'xdp_cpu_map5_lb_hash_ip_pairs'
(default) but on cmdline it looks like you want 'xdp_cpu_map0'.=20
You need to use '--prog xdp_cpu_map0'.  It will make a HUGE performance
difference.

Like:
  sudo ./xdp_redirect_cpu --dev mlx5p1 --cpu 22 --prog xdp_cpu_map0



(p.s. The load-balance hash_ip_pairs is the default, because it is
usable for solving the most common issue, where the NIC is not
RSS distributing traffic correctly, e.g. ixgbe Q-in-Q. And it is close
to the Suricata approach.)
--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

