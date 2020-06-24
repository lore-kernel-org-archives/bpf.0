Return-Path: <SRS0=3qi6=AF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E17CC433E0
	for <bpf@archiver.kernel.org>; Wed, 24 Jun 2020 08:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CD020874
	for <bpf@archiver.kernel.org>; Wed, 24 Jun 2020 08:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0CkwTMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgFXIJV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:09:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389226AbgFXIJU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 04:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592986160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+VOaBnXFAoVjainQQQLxY/W61VZcJH4bMHVNHhNhEc=;
        b=f0CkwTMdjEIF6MeflS+UbsrXsA3Esg37id3PXCR+MWbdimvPuTb3xT9P3JFvuAndWNesTL
        6s6rt3p6snq5C6686PWSZdQEPjDhasbqbCdxnfnx9aTiSHDhyTIMfORTR8Mbe7P8bQdcA8
        akUkH7nRqCuKWqGttjAUVlldFw1+HqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-7ch9CEn0OyKnJBAN6QPK1Q-1; Wed, 24 Jun 2020 04:09:15 -0400
X-MC-Unique: 7ch9CEn0OyKnJBAN6QPK1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3356C464;
        Wed, 24 Jun 2020 08:09:14 +0000 (UTC)
Received: from carbon (unknown [10.40.208.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9441DC;
        Wed, 24 Jun 2020 08:09:00 +0000 (UTC)
Date:   Wed, 24 Jun 2020 10:08:58 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, toke@redhat.com,
        lorenzo.bianconi@redhat.com, dsahern@kernel.org,
        andrii.nakryiko@gmail.com, brouer@redhat.com
Subject: Re: [PATCH v3 bpf-next 4/9] cpumap: formalize map value as a named
 struct
Message-ID: <20200624100858.69f8f749@carbon>
In-Reply-To: <c1eadbcdef365c5d52e01f4a442390bb20950618.1592947694.git.lorenzo@kernel.org>
References: <cover.1592947694.git.lorenzo@kernel.org>
        <c1eadbcdef365c5d52e01f4a442390bb20950618.1592947694.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Jun 2020 23:39:29 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> As it has been already done for devmap, introduce 'struct bpf_cpumap_val'
> to formalize the expected values that can be passed in for a CPUMAP.
> Update cpumap code to use the struct.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

