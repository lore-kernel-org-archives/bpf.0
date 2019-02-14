Return-Path: <SRS0=Lh3l=QV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE6EC10F00
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 00:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F142B2083E
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 00:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1IbAvl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfBNAfa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:35:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43718 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfBNAfa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Feb 2019 19:35:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id f90so2083216plb.10;
        Wed, 13 Feb 2019 16:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7k7kVnoE2QCZm4UrWnXltzZ/MJf5vEDOv/Ljvz4wZPM=;
        b=j1IbAvl6Q1PzjT6GRm3QSSYBJQulpUKuS3peQ/DIH+B8J0UH86Bvz/nTCBiZsnWeIg
         edYeheMiWq42vog3UydJkUKFx/2CN0fQGoLceA4uMkPCY7huw7Sic3S4ba1xqasCJCl9
         NCXtcsxxaD4G0P3iG2IZAsKraZHKOAWZ2uZ5VD9epCIz2m7+7/1h8WsPNVeav53Lq+ZO
         Mwu5VvFT0hqe26ZmAgKsNey9SoXFlFr4wi5zXQ6EaMTbezQesa0ZuP25BtW3XnEp1CFM
         qHL6RUPXRgNjWlZhHXNnpTlb5H2YmCc+8vW5ax79QJXz0X6q+4doP/PQ+VWH7cp/AmqJ
         MOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7k7kVnoE2QCZm4UrWnXltzZ/MJf5vEDOv/Ljvz4wZPM=;
        b=PFqtaPmsQYhkB+AlMm3sX4o4PJ8wCxWBzzgTtBPw67QubIfLy0LpuuyUJn1pI/P0hj
         eSZjTTYUm/pLaPiY4+l535Kqb0zkRPY0L8mASFAGMBpX6s+seWwMGCARSsQRqkCQVIPE
         w4cBQV5k2cvfHGfTUaD7TqnwLqNn7Z0hBtYtO6YoJp0iJmFIBHHvnrY0Ktbq5JwXCrej
         pCa4LmYoMnKYQR8HMqpUKvavalgtBr5QciEDaQHQWbi4JcCm+aDyW1A7MTluK+nfCG4x
         IJmzeRb1jTtKKR6FfqeQdJct83Bs/vFpp+r12cQt7cSVWX+bxmpqhR539huHz0Q+mwi5
         LfAw==
X-Gm-Message-State: AHQUAuazM55LXc8LvOaypU23EbpKtoRClf5bIlbmVl0Xd3LNwQimFSqv
        OqHnIo8FtVGT7IilVGy1dEc=
X-Google-Smtp-Source: AHgI3IZfEQWoN1wG4uh4BKu0mUlSt2fWEKqAhpKIbco5mE7qtXEEyI8M87PnClDDwkXnbc3D7M8Q/A==
X-Received: by 2002:a17:902:c05:: with SMTP id 5mr1051765pls.155.1550104529198;
        Wed, 13 Feb 2019 16:35:29 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::7:963])
        by smtp.gmail.com with ESMTPSA id h128sm577602pgc.15.2019.02.13.16.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 16:35:28 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:35:25 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joe Stringer <joe@wand.net.nz>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Test static data relocation
Message-ID: <20190214003523.zjbiwdgcvy7yrauo@ast-mbp>
References: <20190212004729.535-1-joe@wand.net.nz>
 <20190212004729.535-5-joe@wand.net.nz>
 <20190212050113.qkryxb34vpnst6w6@ast-mbp>
 <CAOftzPjffHZUK=uxiTsuOGLX4A5ag5oqRz6gorhREj6hxMFA4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOftzPjffHZUK=uxiTsuOGLX4A5ag5oqRz6gorhREj6hxMFA4A@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 12, 2019 at 12:43:21PM -0800, Joe Stringer wrote:
> 
> Do you see any value in having incremental support in libbpf that
> could be used as a fallback for older kernels like in patch #2 of this
> series? I could imagine libbpf probing kernel support for
> global/static variables and attempting to handle references to .data
> via some more comprehensive mechanism in-kernel, or falling back to
> this approach if it is not available.

I don't think we have to view it as older vs new kernel and fallback discussion.
I think access to static vars can be implemented in libbpf today without
changing llvm and kernel.

For the following code:
static volatile __u32 static_data = 42;

SEC("anything")
int load_static_data(struct __sk_buff *skb)
{
   __u32 value = static_data;

llvm will generate asm:

  r1 = static_data ll
  r1 = *(u32 *)(r1 + 0)

libbpf can replace first insn with r1 = 0 (or remove it altogether)
and second insn with r1 = 42 _when it is safe_.

If there was no volatile keyword llvm would have optimized
these two instructions into operation with immediate constant.
libbpf can do this opimization instead of llvm.
libbpf can check that 'static_data' is indeed not global in elf file
and there are no store operations in all programs in that elf file.
Then every load from that address can be replaced with rX=imm
of the value from data section.
libbpf would need to do data flow analysis which is substantial
feature addition. I think it's inevitable next step anyway.

The key point that this approach will be compatible with future
global variables and modifiable static variables.
In such case load/store instructions will stay as-is
and kernel support will be needed to replace 'r1 = static_data ll'
with properly marked ld_imm64 insn.


