Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB3BC433EF
	for <bpf@archiver.kernel.org>; Mon, 21 Mar 2022 15:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349583AbiCUPVv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 21 Mar 2022 11:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350248AbiCUPVg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 11:21:36 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86F4C415;
        Mon, 21 Mar 2022 08:19:28 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nWJob-0000YE-NC; Mon, 21 Mar 2022 16:19:25 +0100
Received: from [2a02:168:f656:0:d16a:7287:ccf0:4fff] (helo=localhost.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nWJob-0006bq-DU; Mon, 21 Mar 2022 16:19:25 +0100
Subject: Re: [PATCH] docs/bpf: Fix most/least significant bit typos
To:     Mahmoud Abumandour <ma.mandourr@gmail.com>,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, bpf@vger.kernel.org
References: <20220319164337.1272312-1-ma.mandourr@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c40b0d55-e3c9-2027-765b-a4868ae16795@iogearbox.net>
Date:   Mon, 21 Mar 2022 16:19:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220319164337.1272312-1-ma.mandourr@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26488/Mon Mar 21 09:28:19 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/19/22 5:43 PM, Mahmoud Abumandour wrote:
> The LSB and MSB acronyms should not be followed by the word "bits". This
> fixes this issue and uses the full phrases "most/least significant bits"
> for better readibility.
> 
> Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>

What "issue" is being fixed here? Why would you not use the acronyms? It's fine
as-is, not applying it.

Thanks,
Daniel
