Return-Path: <SRS0=joy4=5R=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EE2C43331
	for <bpf@archiver.kernel.org>; Wed,  1 Apr 2020 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D1F2077D
	for <bpf@archiver.kernel.org>; Wed,  1 Apr 2020 14:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbgDAOSI convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 1 Apr 2020 10:18:08 -0400
Received: from postout1.mail.lrz.de ([129.187.255.137]:40505 "EHLO
        postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgDAOSI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 10:18:08 -0400
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
        by postout1.mail.lrz.de (Postfix) with ESMTP id 48spFT0jhJzyVF
        for <bpf@vger.kernel.org>; Wed,  1 Apr 2020 16:18:05 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
Received: from postout1.mail.lrz.de ([127.0.0.1])
        by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id zE6r2xwqR_GC for <bpf@vger.kernel.org>;
        Wed,  1 Apr 2020 16:18:04 +0200 (CEST)
Received: from BADWLRZ-SWMBX05.ads.mwn.de (BADWLRZ-SWMBX05.ads.mwn.de [IPv6:2001:4ca0:0:108::161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "BADWLRZ-SWMBX05", Issuer "BADWLRZ-SWMBX05" (not verified))
        by postout1.mail.lrz.de (Postfix) with ESMTPS id 48spFS6XNkzySb
        for <bpf@vger.kernel.org>; Wed,  1 Apr 2020 16:18:04 +0200 (CEST)
Received: from BADWLRZ-SWMBX03.ads.mwn.de (2001:4ca0:0:108::159) by
 BADWLRZ-SWMBX05.ads.mwn.de (2001:4ca0:0:108::161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 1 Apr 2020 16:18:04 +0200
Received: from BADWLRZ-SWMBX03.ads.mwn.de ([fe80::b83a:fd44:92bb:7e5e]) by
 BADWLRZ-SWMBX03.ads.mwn.de ([fe80::b83a:fd44:92bb:7e5e%13]) with mapi id
 15.01.1913.010; Wed, 1 Apr 2020 16:18:04 +0200
From:   "Gaul, Maximilian" <maximilian.gaul@hm.edu>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Compare *bpf_ktime_get_ns* in userspace
Thread-Topic: Compare *bpf_ktime_get_ns* in userspace
Thread-Index: AQHWCDAD/UOqIiO7PUa5k89z3yfvHQ==
Date:   Wed, 1 Apr 2020 14:18:04 +0000
Message-ID: <847e02c956f249aa8daab85c538e75fe@hm.edu>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 04
X-MS-Exchange-Organization-AuthSource: BADWLRZ-SWMBX03.ads.mwn.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2003:c6:4f25:4b06:a9f2:d944:66d0:c35c]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I was just wondering whether there is a way to make the timestamp received in XDP/BPF via *bpf_ktime_get_ns* comparable with the usual functions in user-space such as *clock_gettime(CLOCK_MONOTONIC, &t);*?

Unfortunately, *ktime_get_ns* is defined as the time since system boot, but as far as I know, there is no way in user-space to determine the time since system boot any finer than in seconds.
