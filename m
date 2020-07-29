Return-Path: <SRS0=9mof=BI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DF6C433E0
	for <bpf@archiver.kernel.org>; Wed, 29 Jul 2020 06:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E871F20809
	for <bpf@archiver.kernel.org>; Wed, 29 Jul 2020 06:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596003085;
	bh=stk43FDtAGS8zEOHBNUSRu3UH6vCG//TdaojAFbM7eI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1lAvMobje9vuSgXJjfTxP3dY03IFFoFmh+BHxUGwzQXdA6gLBfh7jtYXsJBG/MSzR
	 H0cPV7JU+OLXBJqOiyIos9m2I4uLruDFDTydfUZxfeQB+5/Eks+74tCK7EiiuTNqkv
	 1oYVkpoaaBlOF+nu2ZK7ITFuzamadEeXWtaFywpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgG2GLY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbgG2GLY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 02:11:24 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BFE2070B;
        Wed, 29 Jul 2020 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596003084;
        bh=stk43FDtAGS8zEOHBNUSRu3UH6vCG//TdaojAFbM7eI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dursUmKq68//WXnt7Z1yJ9yOQ5IBg5eMHnEIN0MC99ZuA4IvUjVPtZQytTR/GDqHb
         GB+m4+GSXF4FI+P8GkcZZ/YmZZdC4GDJ1lhr6ieEDdtU2gdTimCvuOPz2zBj6cyHLT
         fP7UHWbW8POX6HoFZ6gASDAdr0ET7e9XQPRAzg9Y=
Received: by mail-lj1-f171.google.com with SMTP id q6so23726785ljp.4;
        Tue, 28 Jul 2020 23:11:23 -0700 (PDT)
X-Gm-Message-State: AOAM5330Ce38wY1Un/jSnoMfTdRjMwcOcy7Xz1kqyqzx1LkFzdDkwMH8
        lQjMRrSnaU/0iovu2xV04qBfwggd8TGavu2kigY=
X-Google-Smtp-Source: ABdhPJyabpJ5QUkl6gc2IAoGZaAL8rrDy9z7hcUTalL0D+WgXCn6FtMjrUzeRqseTw/JJHZRBxy2Y7NWXX8Y7xqGD7A=
X-Received: by 2002:a2e:9996:: with SMTP id w22mr15433055lji.446.1596003082155;
 Tue, 28 Jul 2020 23:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200729003104.1280813-1-sdf@google.com>
In-Reply-To: <20200729003104.1280813-1-sdf@google.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Jul 2020 23:11:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6pdJKPCFEpOP-91wyDf4DLB_DCavZaTUo70_2=WC0oeQ@mail.gmail.com>
Message-ID: <CAPhsuW6pdJKPCFEpOP-91wyDf4DLB_DCavZaTUo70_2=WC0oeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: expose socket storage to BPF_PROG_TYPE_CGROUP_SOCK
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 28, 2020 at 5:31 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> This lets us use socket storage from the following hooks:
> * BPF_CGROUP_INET_SOCK_CREATE
> * BPF_CGROUP_INET_SOCK_RELEASE
> * BPF_CGROUP_INET4_POST_BIND
> * BPF_CGROUP_INET6_POST_BIND
>
> Using existing 'bpf_sk_storage_get_proto' doesn't work because
> second argument is ARG_PTR_TO_SOCKET. Even though
> BPF_PROG_TYPE_CGROUP_SOCK hooks operate on 'struct bpf_sock',
> the verifier still considers it as a PTR_TO_CTX.
> That's why I'm adding another 'bpf_sk_storage_get_cg_sock_proto'
> definition strictly for BPF_PROG_TYPE_CGROUP_SOCK which accepts
> ARG_PTR_TO_CTX which is really 'struct sock' for this program type.
>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Song Liu <songliubraving@fb.com>
