Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF55CC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28BA218E2
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfCAABP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:01:15 -0500
Received: from www62.your-server.de ([213.133.104.62]:57250 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfCAABP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 19:01:15 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzVbu-0006r2-Rd; Fri, 01 Mar 2019 01:01:06 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzVbu-000Rru-KZ; Fri, 01 Mar 2019 01:01:06 +0100
Subject: Re: [PATCH v3] tools/libbpf: signedness bug in btf_dedup_ref_type()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190228180647.GF9806@kadam>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <847adb2b-bf4f-1335-b1b6-a960b6c947d5@iogearbox.net>
Date:   Fri, 1 Mar 2019 01:01:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190228180647.GF9806@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/28/2019 07:06 PM, Dan Carpenter wrote:
> The "ref_type_id" variable needs to be signed for the error handling
> to work.
> 
> Fixes: d5caef5b5655 ("btf: add BTF types deduplication algorithm")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
