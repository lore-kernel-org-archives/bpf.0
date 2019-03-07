Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15922C43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D843320840
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 16:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRQz6q5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCGQue (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:50:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41158 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGQue (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Mar 2019 11:50:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id k11so10725193pgb.8;
        Thu, 07 Mar 2019 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L2F4+RYdoryZ5brNolabiwSf19mo9HcWW6J/EvM7buU=;
        b=SRQz6q5EkcEnZV3D+24RExvZphBFxfEwHi3sA/OL/MqbPxIazmZGDkmuOYd7JOaxGk
         RFiDzQ0IPve7afzN/VIE8F65gpfyDZNKhxjlutIvCT7DGqZCEVIUvfQ6QHnSEJ4Cl93d
         2H4Nax+vKYX/GYitzJ/EWh2vdv3JF3LFc0nYLzi+30H8n1yAtZofLABBJiRp4rx8oAjd
         +T+mp7oWY2Dq6kc44cl8IJvhX9wqb9LOYsei1poLiixGiu9praIMYkg27rgbffd1BCMM
         r6TI8sZ8dGm4U4FChumsRmckYmVbwpO8oAuS0l81aanBdZbS/W68XAuMmvsL/kzGVg87
         v7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L2F4+RYdoryZ5brNolabiwSf19mo9HcWW6J/EvM7buU=;
        b=kI6ZUZXEpQCjWjsph88m+okQH04fmi9QlucnuEyYoERd42YWLi86QGAbaJyL5gxWck
         kh4IO3m1ukUnIxNCg+p6STM/dUcTLcu1AilRWDUyabusLOSstEW0VivfKi6gdWOhr3RB
         3gB9cqRxnY+krZeuWI0sdE5wF7zOMiQMa/2yNJBD6DhE8Xqvm82yz8Ij504jl8sNCvUb
         vlH1qFTL+jUlUt9Dl75+1DZlrurVBOg10rusxu+T40CU2IBR4vAzd8a55q5csjq+SJH4
         6qN95QYXGal5SNTZ1Oi2mBUyVKcfyq86Z/YqWvRcmadPccUGyUeufUVZO4cJ5ahBdMBd
         XBoA==
X-Gm-Message-State: APjAAAXHHhM+s/mW3/Vs/Uhq6JoazW/RMV/6h3QVT0M5naF7bPE04Uh6
        076evMUWenYvyw+oNERQhJg=
X-Google-Smtp-Source: APXvYqyOFSxHbfz3FU0jMQ/Y3S03Wf8BNgBR7gNCo33X+WXBRsRekPCOjvvutnWLTLdQlgp84Cs04w==
X-Received: by 2002:a63:8042:: with SMTP id j63mr11756335pgd.36.1551977433440;
        Thu, 07 Mar 2019 08:50:33 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::db0e])
        by smtp.gmail.com with ESMTPSA id 23sm7155978pfn.2.2019.03.07.08.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:50:32 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:50:30 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix replace_map_fd_with_map_ptr's ldimm64
 second imm field
Message-ID: <20190307165028.wytl2rozrlakdyqg@ast-mbp.dhcp.thefacebook.com>
References: <20190304200853.22558-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304200853.22558-1-daniel@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 04, 2019 at 09:08:53PM +0100, Daniel Borkmann wrote:
> Non-zero imm value in the second part of the ldimm64 instruction for
> BPF_PSEUDO_MAP_FD is invalid, and thus must be rejected. The map fd
> only ever sits in the first instructions' imm field. None of the BPF
> loaders known to us are using it, so risk of regression is minimal.
> For clarity and consistency, the few insn->{src_reg,imm} occurrences
> are rewritten into insn[0].{src_reg,imm}. Add a test case to the BPF
> selftest suite as well.
> 
> Fixes: 0246e64d9a5f ("bpf: handle pseudo BPF_LD_IMM64 insn")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Applied, Thanks

