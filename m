Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B57C433F5
	for <bpf@archiver.kernel.org>; Mon, 14 Mar 2022 22:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbiCNWMk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Mar 2022 18:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbiCNWMj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 18:12:39 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8D3C72D
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 15:11:29 -0700 (PDT)
Received: from [78.46.152.42] (helo=sslproxy04.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nTsuV-00079U-3Y; Mon, 14 Mar 2022 23:11:27 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nTsuU-000TqL-L1; Mon, 14 Mar 2022 23:11:26 +0100
Subject: Re: [PATCH bpf-next v2] bpf, arm64: Optimize BPF store/load using
 str/ldr with immediate offset
To:     Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hou Tao <houtao1@huawei.com>, Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>
References: <20220314084850.1329209-1-xukuohai@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fe0af43b-b675-18bd-dede-3d79baa94f06@iogearbox.net>
Date:   Mon, 14 Mar 2022 23:11:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220314084850.1329209-1-xukuohai@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26481/Mon Mar 14 09:39:13 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/14/22 9:48 AM, Xu Kuohai wrote:
> The current BPF store/load instruction is translated by the JIT into two
> instructions. The first instruction moves the immediate offset into a
> temporary register. The second instruction uses this temporary register
> to do the real store/load.
> 
> In fact, arm64 supports addressing with immediate offsets. So This patch
> introduces optimization that uses arm64 str/ldr instruction with immediate
> offset when the offset fits.
> 
> Example of generated instuction for r2 = *(u64 *)(r1 + 0):
> 
> without optimization:
> mov x10, 0
> ldr x1, [x0, x10]
> 
> with optimization:
> ldr x1, [x0, 0]
> 
> If the offset is negative, or is not aligned correctly, or exceeds max
> value, rollback to the use of temporary register.
> 
> Result for test_bpf:
>   # dmesg -D
>   # insmod test_bpf.ko
>   # dmesg | grep Summary
>   test_bpf: Summary: 1009 PASSED, 0 FAILED, [997/997 JIT'ed]
>   test_bpf: test_tail_calls: Summary: 8 PASSED, 0 FAILED, [8/8 JIT'ed]
>   test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
[...]

Thanks for working on this and also including the result for test_bpf! Does it
also contain corner cases where the rollback to the temporary register is
triggered? (If not, lets add more test cases to it.)

Could you split this into two patches, one that touches arch/arm64/lib/insn.c
and arch/arm64/include/asm/insn.h for the instruction encoder, and then the
other part for the JIT-only bits?

Will, would you be okay if we route this via bpf-next with your Ack, or do we
need to pull feature branch again?

Thanks,
Daniel
