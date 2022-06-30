Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123D3C433EF
	for <bpf@archiver.kernel.org>; Thu, 30 Jun 2022 13:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiF3Nwz convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 30 Jun 2022 09:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiF3Nwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 09:52:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F873152F
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 06:49:40 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYfjT6Krhz67RS4
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 21:45:33 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 15:49:38 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Thu, 30 Jun 2022 15:49:38 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: libbfd feature autodetection
Thread-Topic: libbfd feature autodetection
Thread-Index: AdiMh7mzfuc144+UTkqQSD6Zj1VxZg==
Date:   Thu, 30 Jun 2022 13:49:37 +0000
Message-ID: <aa98e9e1a7f440779d509046021d0c1c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone

I'm testing a modified version of bpftool with the CI.

Unfortunately, it does not work due to autodetection
of libbfd in the build environment, but not in the virtual
machine that actually executes the tests.

What the proper solution should be?

Thanks

Roberto
