Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D58BC43334
	for <bpf@archiver.kernel.org>; Sat,  9 Jul 2022 08:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGIIsM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 9 Jul 2022 04:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGIIsM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 04:48:12 -0400
X-Greylist: delayed 28006 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Jul 2022 01:48:11 PDT
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E084E621;
        Sat,  9 Jul 2022 01:48:11 -0700 (PDT)
Date:   Sat, 9 Jul 2022 16:48:05 +0800
From:   Yixun Lan <dlan@gentoo.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] RISC-V/bpf: Enable bpf_probe_read{, str}()
Message-ID: <YslAxaryvm/MfGbq@ofant>
References: <20220703130924.57240-1-dlan@gentoo.org>
 <YsKAZUJRo5cjtZ3n@infradead.org>
 <CAEf4BzbCswMd6KU7f9SEU6xHBBPu_rTL5f+KE0OkYj63e-h-bA@mail.gmail.com>
 <712c8fac-6784-2acd-66ca-d1fd393aef23@fb.com>
 <YsUzX2IeNb/u9VmN@infradead.org>
 <YsjTVvyqdVGy1uYZ@ofant>
 <YskfMTdnd+IyzCQ0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YskfMTdnd+IyzCQ0@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Christoph:

On 23:24 Fri 08 Jul     , Christoph Hellwig wrote:
> On Sat, Jul 09, 2022 at 09:01:10AM +0800, Yixun Lan wrote:
> > Please check the ongoing discussion [0] in the bcc tools if you're
> > interested in, advice and comments are welcome
> > 
> > [0] https://github.com/iovisor/bcc/pull/4085#issuecomment-1179446738
> 
> I can't find a way to post there, as replying eems to require a login.
> Is there a mailing list discussion somewhere that is broadly accessible?

never mind, I think the logic is quite clear, we can do something in bcc:

1) adopt new _{kernel,user} interface whenever possible, this will
work fine for all arch with new kernel versions

2) for old kernel versions which lack the _{kernel,user} support,
fall back to old bpf_probe_read(), but take care of the Archs which
have overlaping address space - like s390, and just error out for it

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
