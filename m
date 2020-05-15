Return-Path: <SRS0=Xcm6=65=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EF0C433DF
	for <bpf@archiver.kernel.org>; Fri, 15 May 2020 12:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C4EB206D4
	for <bpf@archiver.kernel.org>; Fri, 15 May 2020 12:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEspu6gB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOMAm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 May 2020 08:00:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54191 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726062AbgEOMAm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 May 2020 08:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589544041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ge8aDgNBuq0toRC0nplEa2x2MjaYxQfo/469m5JXbDA=;
        b=MEspu6gBCsxBlhGG6S/bOlXasF91UDX6QPIVxN8amM6fdjnGwwHHifnAZMgaCbDOhkH1sT
        EJTcLFHf4PSNQJNFYqC3N6NNwAN5UWOsVFix0F9UB+gVrkmc/Zp7HZnjcl5kMXw6SrmaVr
        hHR9xr6FSqxmtNBOflMYCbAusF7gswI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-keFaM6BIMli2SdYjKyAIMg-1; Fri, 15 May 2020 08:00:37 -0400
X-MC-Unique: keFaM6BIMli2SdYjKyAIMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDE9884B8A7;
        Fri, 15 May 2020 12:00:36 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-113-25.ams2.redhat.com [10.36.113.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A83B61989;
        Fri, 15 May 2020 12:00:29 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 0/3] selftests: lib.mk improvements
Date:   Fri, 15 May 2020 15:00:23 +0300
Message-Id: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Yauheni Kaliuta (3):
  selftests: do not use .ONESHELL
  selftests: fix condition in run_tests
  selftests: simplify run_tests

 tools/testing/selftests/lib.mk | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

-- 
2.26.2

