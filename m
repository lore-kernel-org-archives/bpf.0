Return-Path: <SRS0=QYON=7E=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590DCC433E0
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 15:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEA120671
	for <bpf@archiver.kernel.org>; Fri, 22 May 2020 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590160159;
	bh=QTA3E1jA92zSGe5NaJYapobJCORlYiuebmNUd5lavYg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=m1fKC0Bp1EqwQEXr2bSF+xvFeIlwZbnvm59fMXfJXDZP4+2P+FN2lwxeJXsrHeXjn
	 XKPFihJoHq5IryKoa9Eqf8ciG6eNuJI8QssCeyOUn58Fu4T82paGWxU5/uEX3q3dPZ
	 42rJxOBE+4x8TUfexYrR+7/qPQHPxq5jX2tMWmok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgEVPJS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 May 2020 11:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbgEVPJS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 11:09:18 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66DA4205CB;
        Fri, 22 May 2020 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590160157;
        bh=QTA3E1jA92zSGe5NaJYapobJCORlYiuebmNUd5lavYg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d5EMPOABtnYFFWaxZKcCLjVyQ6VALEbfU0v41m4Eq+aPF5SrDiS+QwekpctWm+JRt
         3FDWc6yM0kL2vvR3stDQI1Cl2bcFDoXt8XgkkiJRUCJ96E06UznhjWBb11WWy8jOdi
         n7RzXWxYwVHRlrfTJIlyufBFu4sQINAKeW8WIyXY=
Subject: Re: [PATCH v2 0/3] selftests: lib.mk improvements
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, shuah <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
 <689fe06a-c781-e6ed-0544-8023c86fc21a@kernel.org>
 <xunyblmknfmy.fsf@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <4e0d1e4e-9ed2-025c-1164-fd52a88c1ed2@kernel.org>
Date:   Fri, 22 May 2020 09:09:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xunyblmknfmy.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/19/20 8:49 AM, Yauheni Kaliuta wrote:
> Hi, shuah!
> 
>>>>>> On Tue, 19 May 2020 07:59:16 -0600, shuah   wrote:
> 
>   > On 5/15/20 6:00 AM, Yauheni Kaliuta wrote:
>   >>
>   >> Yauheni Kaliuta (3):
>   >> selftests: do not use .ONESHELL
>   >> selftests: fix condition in run_tests
>   >> selftests: simplify run_tests
>   >>
>   >> tools/testing/selftests/lib.mk | 19 ++++++-------------
>   >> 1 file changed, 6 insertions(+), 13 deletions(-)
>   >>
> 
>   > Quick note that, I will pull these in for 5.8-rc1.

Patches look okay to me, however, just noticed, this series hasn't
been cc'ed to linux-kselftest. Hence it didn't go through the
necessary reviews.

Please run get_maintainers and resend the series to everybody the
script suggests.

thanks,
-- Shuah

