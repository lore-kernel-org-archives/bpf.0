Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE015C282DA
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A707D2073F
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfDPI7E (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:59:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:36752 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPI7D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 04:59:03 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJU8-0006NZ-I5; Tue, 16 Apr 2019 10:30:32 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJU8-000TWh-Bf; Tue, 16 Apr 2019 10:30:32 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: make flow dissector tests more
 extensible
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190412234310.174978-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <20826883-f3ee-9366-a50b-c80d866367d1@iogearbox.net>
Date:   Tue, 16 Apr 2019 10:30:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190412234310.174978-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25420/Mon Apr 15 09:57:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/13/2019 01:43 AM, Stanislav Fomichev wrote:
> Rewrite selftest to iterate over an array with input packet and
> expected flow_keys. This should make it easier to extend this test
> with additional cases without too much boilerplate.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
