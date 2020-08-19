Return-Path: <SRS0=4a0o=B5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843B9C433E1
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 16:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516FA2078D
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 16:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDEj26bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgHSQRW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:17:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbgHSQRT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 12:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597853838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+zBRubArM5WyMpabuHxUCqJf/AEfFavfvN79SAcW5A=;
        b=BDEj26bTooi6fz1bSVSF/79Gfd5FcKBzmqAHa2/5+fnxJmOYmY6qcQ4YIHQyTpFkKhBfvT
        87gec38W4yCj7q4ChZ6kux+ihfYU2NZ8duZJCKD3d3mTkFKa/WAx/Zs8uqTb/NTpWBmHmH
        9NwLBVPYXW8xQZ2zk08VVyFFU1Wmnvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-YzTqsISgO5Wl4N7BL9qyJQ-1; Wed, 19 Aug 2020 12:17:14 -0400
X-MC-Unique: YzTqsISgO5Wl4N7BL9qyJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CDC5186A575;
        Wed, 19 Aug 2020 16:17:13 +0000 (UTC)
Received: from carbon (unknown [10.40.208.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63493709DC;
        Wed, 19 Aug 2020 16:17:08 +0000 (UTC)
Date:   Wed, 19 Aug 2020 18:17:06 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     bpf@vger.kernel.org, sdf@google.com, andriin@fb.com,
        skozina@redhat.com, yhs@fb.com, brouer@redhat.com
Subject: Re: [PATCH v2] selftests/bpf: Remove test_align leftovers
Message-ID: <20200819181706.2220bc71@carbon>
In-Reply-To: <20200819160710.1345956-1-vkabatov@redhat.com>
References: <20200819160710.1345956-1-vkabatov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Aug 2020 18:07:10 +0200
Veronika Kabatova <vkabatov@redhat.com> wrote:

> Calling generic selftests "make install" fails as rsync expects all
> files from TEST_GEN_PROGS to be present. The binary is not generated
> anymore (commit 3b09d27cc93d) so we can safely remove it from there
> and also from gitignore.
> 
> Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under test_progs")
> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> ---
>  tools/testing/selftests/bpf/.gitignore | 1 -
>  tools/testing/selftests/bpf/Makefile   | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

