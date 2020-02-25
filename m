Return-Path: <SRS0=/C52=4N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F49C35DF2
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 05:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B73321556
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 05:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582610073;
	bh=MDhvxbw7okjY6cPHuB7G5Qycw39UR4W+p2o1RS12XL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2iuEEAgCHetk3IejiGzYf+cXlbGEdIpKNCn/KnvRZuEKGTR10ES0oIIuKS25LTzG9
	 dUeg43ZbvKX+BFW/Hn4ruiz4A7QbLjWzXw/Wt/4u9Mh2rZ6t7MAR2WyLRZqt0W4IPS
	 BI3jdcMF7sJO141ynYFqUiC6ua2MGoz4yl0+ts0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgBYFyd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgBYFyc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 00:54:32 -0500
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D00A921556;
        Tue, 25 Feb 2020 05:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582610072;
        bh=MDhvxbw7okjY6cPHuB7G5Qycw39UR4W+p2o1RS12XL4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=obvf5ghaeQ5q/WQ5Er2ab6iwSrATLYw2Z4P5LU4J5/iMGPKoi3Tu1J2NMEIrIq+5Y
         +F5CIcQNyDBX4L2B+dNhPqS5AWxdJB6fyTd2FPyiT5et3N/nPOL7ceTLyPOszQ2W9B
         UHYoU2v9sK5FfuZ0lnyARhPtAmPa4xNaVPRRHgfs=
Received: by mail-lf1-f44.google.com with SMTP id z5so8697480lfd.12;
        Mon, 24 Feb 2020 21:54:31 -0800 (PST)
X-Gm-Message-State: APjAAAXljhAgxtUXI7ApB+0GQumQYfIYDWti+Ol/KualGfgQWO0sDETv
        SG0cFe3ZUNVI4/H16Sc+xiqG8tfsPUn8Z7g/fwU=
X-Google-Smtp-Source: APXvYqwcQGuOah9h9jzkKzkZcYraLsTCE+Ha+Q6ABwSBqWvywUayh82kZqIOabqZ3f61Ii8zweKIX3Am6ROBiD91vC0=
X-Received: by 2002:a19:9155:: with SMTP id y21mr15375201lfj.28.1582610070046;
 Mon, 24 Feb 2020 21:54:30 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW6QkQ8-pXamQVzTXLPzyb4-FCeF_6To7sa_=gd7Ea5VpA@mail.gmail.com>
 <20200225044538.61889-1-forrest0579@gmail.com> <20200225044538.61889-2-forrest0579@gmail.com>
In-Reply-To: <20200225044538.61889-2-forrest0579@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 24 Feb 2020 21:54:19 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7TWV0=ed0tk2OkX5cERb-kKJukfZ+mkd1Ddh2kPBwnyg@mail.gmail.com>
Message-ID: <CAPhsuW7TWV0=ed0tk2OkX5cERb-kKJukfZ+mkd1Ddh2kPBwnyg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/3] bpf: Add get_netns_id helper function for sock_ops
To:     Lingpeng Chen <forrest0579@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Petar Penkov <ppenkov.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 24, 2020 at 8:46 PM Lingpeng Chen <forrest0579@gmail.com> wrote:
>
> Currently 5-tuple(sip+dip+sport+dport+proto) can't identify a
> uniq connection because there may be multi net namespace.
> For example, there may be a chance that netns a and netns b all
> listen on 127.0.0.1:8080 and the client with same port 40782
> connect to them. Without netns number, sock ops program
> can't distinguish them.
> Using bpf_get_netns_id helper to get current connection
> netns id to distinguish connections.
>
> Signed-off-by: Lingpeng Chen <forrest0579@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
