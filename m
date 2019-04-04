Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B944C4360F
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3314E206B7
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 13:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfDDN1L (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:27:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:51946 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDN1L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 09:27:11 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hC2Oa-0003q5-EH; Thu, 04 Apr 2019 15:27:08 +0200
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hC2Oa-0004x4-8j; Thu, 04 Apr 2019 15:27:08 +0200
Subject: Re: [PATCH bpf] flow_dissector: rst'ify documentation
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190403205318.123125-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d7101fea-8235-5f3d-ebb8-edffce41c161@iogearbox.net>
Date:   Thu, 4 Apr 2019 15:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190403205318.123125-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25409/Thu Apr  4 09:53:59 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/03/2019 10:53 PM, Stanislav Fomichev wrote:
> Rename bpf_flow_dissector.txt to bpf_flow_dissector.rst and fix
> formatting. Also, link it from the Documentation/networking/index.rst.
> 
> Tested with 'make htmldocs' to make sure it looks reasonable.
> 
> Fixes: ae82899bbe92 ("flow_dissector: document BPF flow dissector environment")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
