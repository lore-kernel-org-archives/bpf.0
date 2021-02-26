Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA2EC433DB
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 14:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BFF964F1B
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 14:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBZObi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Feb 2021 09:31:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229571AbhBZObf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 09:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614349809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CyTg0368UZeS5/GRq2/kgJVeph2AhDxVSQ3XORSmgf4=;
        b=fG5JhXkPczmBkaqtLEuYr+u9u7HR0z7FR7klmRQtRpVHygrNKNqE5fBoK1a3/KZVPr7J81
        yOro02lgEkOQ73rE1dKmLImufbl0mA6okVBuvw0lE+sHoOsSDMQXkJSFIfkV1IAQQx4Jj/
        rSLIAWjGI7ZVVXvlEgxsKUWNnDhDXuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-KlCJkgYqN_Ksu67P4YgAUg-1; Fri, 26 Feb 2021 09:30:06 -0500
X-MC-Unique: KlCJkgYqN_Ksu67P4YgAUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87A931005501;
        Fri, 26 Feb 2021 14:30:04 +0000 (UTC)
Received: from carbon (unknown [10.36.110.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46BC4341E9;
        Fri, 26 Feb 2021 14:29:55 +0000 (UTC)
Date:   Fri, 26 Feb 2021 15:29:54 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     brouer@redhat.com,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBl?= =?UTF-8?B?bA==?= 
        <bjorn.topel@intel.com>, maciej.fijalkowski@intel.com,
        hawk@kernel.org, magnus.karlsson@intel.com,
        john.fastabend@gmail.com, kuba@kernel.org, davem@davemloft.net
Subject: Re: [PATCH bpf-next v4 1/2] bpf, xdp: make bpf_redirect_map() a map
 operation
Message-ID: <20210226152954.1dc8e19d@carbon>
In-Reply-To: <87sg5jys8r.fsf@toke.dk>
References: <20210226112322.144927-1-bjorn.topel@gmail.com>
        <20210226112322.144927-2-bjorn.topel@gmail.com>
        <87sg5jys8r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 26 Feb 2021 12:37:40 +0100
Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:

> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>=20
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> >
> > Currently the bpf_redirect_map() implementation dispatches to the
> > correct map-lookup function via a switch-statement. To avoid the
> > dispatching, this change adds bpf_redirect_map() as a map
> > operation. Each map provides its bpf_redirect_map() version, and
> > correct function is automatically selected by the BPF verifier.
> >
> > A nice side-effect of the code movement is that the map lookup
> > functions are now local to the map implementation files, which removes
> > one additional function call.
> >
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> =20
>=20
> Nice! I agree that this is a much nicer approach! :)

I agree :-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

