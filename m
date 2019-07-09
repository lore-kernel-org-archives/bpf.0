Return-Path: <SRS0=RD1g=VG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAA8C606B0
	for <bpf@archiver.kernel.org>; Tue,  9 Jul 2019 00:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F167121707
	for <bpf@archiver.kernel.org>; Tue,  9 Jul 2019 00:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfGIAMz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:12:55 -0400
Received: from www62.your-server.de ([213.133.104.62]:50112 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfGIAMz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 20:12:55 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hkdkb-0007XH-OO; Tue, 09 Jul 2019 02:12:53 +0200
Received: from [178.193.45.231] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hkdkb-0001D7-BG; Tue, 09 Jul 2019 02:12:53 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: fix test_reuseport_array on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190703115034.53984-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7b93483d-8ba2-6c87-5f16-29586f3cb2c8@iogearbox.net>
Date:   Tue, 9 Jul 2019 02:12:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190703115034.53984-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25504/Mon Jul  8 10:05:57 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/03/2019 01:50 PM, Ilya Leoshkevich wrote:
> Fix endianness issue: passing a pointer to 64-bit fd as a 32-bit key
> does not work on big-endian architectures. So cast fd to 32-bits when
> necessary.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!
