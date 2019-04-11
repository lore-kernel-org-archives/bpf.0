Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2DEC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 22:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D342146F
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 22:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDKWXv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:23:51 -0400
Received: from www62.your-server.de ([213.133.104.62]:39870 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKWXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 18:23:51 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEi6l-0008FX-Rs; Fri, 12 Apr 2019 00:23:47 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hEi6l-0004S8-Jk; Fri, 12 Apr 2019 00:23:47 +0200
Subject: Re: [PATCH bpf-next v4 1/3] bpf: support input __sk_buff context in
 BPF_PROG_TEST_RUN
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, Martin Lau <kafai@fb.com>
References: <20190409184911.97485-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3e26d75a-da10-9ae2-12f8-893f334fa1e9@iogearbox.net>
Date:   Fri, 12 Apr 2019 00:23:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190409184911.97485-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25416/Thu Apr 11 09:55:16 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Stanislav,

On 04/09/2019 08:49 PM, Stanislav Fomichev wrote:
> Add new set of arguments to bpf_attr for BPF_PROG_TEST_RUN:
> * ctx_in/ctx_size_in - input context
> * ctx_out/ctx_size_out - output context
> 
> The intended use case is to pass some meta data to the test runs that
> operate on skb (this has being brought up on recent LPC).
> 
> For programs that use bpf_prog_test_run_skb, support __sk_buff input and
> output. Initially, from input __sk_buff, copy _only_ cb and priority into
> skb, all other non-zero fields are prohibited (with EINVAL).
> If the user has set ctx_out/ctx_size_out, copy the potentially modified
> __sk_buff back to the userspace.
> 
> We require all fields of input __sk_buff except the ones we explicitly
> support to be set to zero. The expectation is that in the future we might
> add support for more fields and we want to fail explicitly if the user
> runs the program on the kernel where we don't yet support them.
> 
> The API is intentionally vague (i.e. we don't explicitly add __sk_buff
> to bpf_attr, but ctx_in) to potentially let other test_run types use
> this interface in the future (this can be xdp_md for xdp types for
> example).
> 
> v4:
>   * don't copy more than allowed in bpf_ctx_init [Martin]
> 
> v3:
>   * handle case where ctx_in is NULL, but ctx_out is not [Martin]
>   * convert size==0 checks to ptr==NULL checks and add some extra ptr
>     checks [Martin]
> 
> v2:
>   * Addressed comments from Martin Lau
> 
> Cc: Martin Lau <kafai@fb.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

This still has a bug in that we need to reject !bpf_prog_test_run_skb() cases,
since they are not handled by your set. So for e.g. XDP, flow dissector progs,
we need to error out if ctx is set such that it can be safely extended in future.
Please follow up.

Thanks,
Daniel
