Return-Path: <SRS0=+JL0=CK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FA9C433E2
	for <bpf@archiver.kernel.org>; Tue,  1 Sep 2020 09:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A915E20866
	for <bpf@archiver.kernel.org>; Tue,  1 Sep 2020 09:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6qg2Q2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgIAJQ0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:16:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31239 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725989AbgIAJQZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 05:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598951784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfvUpudqPE92RBdY4a6diCPfsoK9WJPNulBTm931Ydc=;
        b=b6qg2Q2YmezELynbTZCeA2xB56dTckREsLcioolfcORlx2ij/FjiS2TYjQ+oUUjPmzcCmw
        t1rL5U6px4CQ+jWSOqH2B75lSB2zuItFWpfk3BG5jjsH6oXUG5buoDKhzLgcyjclxCTSyN
        ol8j28K1JBf5Sz0QcFrUzmgrQQ6FN5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-sP9fe0ZBMSaarQctuigN1g-1; Tue, 01 Sep 2020 05:16:20 -0400
X-MC-Unique: sP9fe0ZBMSaarQctuigN1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6D72800467;
        Tue,  1 Sep 2020 09:16:18 +0000 (UTC)
Received: from carbon (unknown [10.40.208.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E656D78B40;
        Tue,  1 Sep 2020 09:16:09 +0000 (UTC)
Date:   Tue, 1 Sep 2020 11:16:08 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, netdev@vger.kernel.org, toke@redhat.com,
        dsahern@gmail.com, brouer@redhat.com
Subject: Re: [PATCH bpf-next v2] bpf: {cpu,dev}map: change various functions
 return type from int to void
Message-ID: <20200901111608.5f56264d@carbon>
In-Reply-To: <20200901083928.6199-1-bjorn.topel@gmail.com>
References: <20200901083928.6199-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue,  1 Sep 2020 10:39:28 +0200
Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> wrote:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>=20
> The functions bq_enqueue(), bq_flush_to_queue(), and bq_xmit_all() in
> {cpu,dev}map.c always return zero. Changing the return type from int
> to void makes the code easier to follow.
>=20
> Suggested-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> ---
>  kernel/bpf/cpumap.c | 11 +++--------
>  kernel/bpf/devmap.c | 15 +++++++--------
>  2 files changed, 10 insertions(+), 16 deletions(-)

Thanks for the cleanup! :-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

--=20
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

