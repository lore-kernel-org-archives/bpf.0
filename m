Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19F5C636D4
	for <bpf@archiver.kernel.org>; Wed, 15 Feb 2023 14:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBOOpO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 Feb 2023 09:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBOOpL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 09:45:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B935539B9C;
        Wed, 15 Feb 2023 06:45:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C2D961C03;
        Wed, 15 Feb 2023 14:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65161C433D2;
        Wed, 15 Feb 2023 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676472309;
        bh=bnWl6GLIuptbwEqTWE8WhV0O9nBtEn5SL4rBx9vtF8A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sOGDwE1w4CBDcGSuFbtLps2hGPxxSPFBXzByncCsgw2aWgVU6Z2WewfglHBiIcAXL
         qiNTt5LN9VpWlXC4gAx4x+OiGq2DBJAZLkQSl3yAtxP3Ro3AS4z/dxSICGv6byBkrL
         r0bT6OksFen8zrzA/jWpUNVKAfx9yQlUX+wWZPhbdgRHYORHWDv1zxSCctzsrIZoJF
         FjOcFhYuFa4MywHf0NSapBbJ9VnEuSiG3P2R9UxpF8CbWhIQbZtODpogU7iv+wziw8
         IJ9wcVH+Mhgc3OFOoNbQXWmAR/LVtezPebB2BLKvcCr2aAGZj5X8nkQhvkdzbU2PLs
         bAO9JG1G62RoA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v1 0/4] Support bpf trampoline for RV64
In-Reply-To: <20230215135205.1411105-1-pulehui@huaweicloud.com>
References: <20230215135205.1411105-1-pulehui@huaweicloud.com>
Date:   Wed, 15 Feb 2023 15:45:06 +0100
Message-ID: <87mt5ft2bx.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Lehui,

Pu Lehui <pulehui@huaweicloud.com> writes:

> BPF trampoline is the critical infrastructure of the bpf
> subsystem, acting as a mediator between kernel functions
> and BPF programs. Numerous important features, such as
> using ebpf program for zero overhead kernel introspection,
> rely on this key component. We can't wait to support bpf
> trampoline on RV64. Since RV64 does not support ftrace
> direct call yet, the current RV64 bpf trampoline is only
> used in bpf context.

Thanks a lot for continuing this work. I agree with you that it's
valuable to have BPF trampoline support, even without proper direct call
support (we'll get there soon). The trampoline enables kfunc calls. On
that note; I don't see that you enable "bpf_jit_supports_kfunc_call()"
anywhere in the series.  With BPF trampoline support, the RISC-V BPF
finally can support kfunc calls!

I'd add the following to bpf_jit_comp64.c:

bool bpf_jit_supports_kfunc_call(void)
{
        return true;
}

:-)

I'll do a review ASAP.


Bj=C3=B6rn
