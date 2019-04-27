Return-Path: <SRS0=xnNa=S5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FED6C43218
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E004A206BB
	for <bpf@archiver.kernel.org>; Sat, 27 Apr 2019 18:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZwQgviwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfD0Sjp (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:39:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45824 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0Sjp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Apr 2019 14:39:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so3271437pfi.12
        for <bpf@vger.kernel.org>; Sat, 27 Apr 2019 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=nEhuJO1Ynor4weZ/NdgsrjcDQwLHIYNiPIAmRLX4GUE=;
        b=ZwQgviwGd+jrVmG8JFn7bjaIAV2TsrvxU4gwqb0RDG2b2a6/tuGS1bjSPD5zFcQiMZ
         OmpdIgRQkfd1VLQyOhHZ2sy7TIKkdUPmLR3gYx0vHzrPUF+3LdpG+0aUq9NHLigzxuLt
         w9kpljzekW+UpvNnGxUjjZ2Bx9bD32Ndbifx8VInBOuMS2iEobHHMQQB1VrB954vWtp/
         Nrbgy+r1/XJ21U/lWl3YVsMz6ktPb/ZCQWFwdDqE83Lw5y4t5RaboQA97rx1/hGYeULm
         0flpaFH/sFdnlp0awKpTr8eaMC9B/zZoDGubX6yyGIu3JxLfg5bVwVWhTSIakRG3jRCC
         zEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=nEhuJO1Ynor4weZ/NdgsrjcDQwLHIYNiPIAmRLX4GUE=;
        b=eMOIvvsTqwCb1BCJyBSY7+7lnlRmsp1/z+htQE6JgtoTSjnqxopLj9gtsAA+9oq/WB
         R4R1l4Wang7vcJno1NjpaQUmhHoXFemwcmGkro3K/lbcXyo1BmFHCph7Xg5aRMFNxlkW
         uRLuRWLRuoeHow5sE47LlcO06S6rAd9v6Aj1nwftm/QAgf9U6Fis8bGF4aHZSDG0AWTL
         /KYSM772ggZg45QDiW1vtvoOBRPJJJuwCehiLTEgdbbBVS/IXFFa4KIJKDuwVg6gDcIR
         3x9078ZVi8GCfxk7wiozOhHv1TBbeVsd2h3F2fS/aswfTauflJgYnD1WZ4xP8iFwGzDV
         9PbA==
X-Gm-Message-State: APjAAAVSSbUV4Rd1KgmNBcmt9SPagtmR86csF2EjhuEZOwAjpjchvl/x
        eYs2PEygxGINFFEtIpG/078mOA==
X-Google-Smtp-Source: APXvYqyZ/4SJ6b3JR9/ZurrOnqflqzaXFZbRf5gCuPX1ZCzXs5PbtTx1IfO1JJabzZ+xsr5JsHuApQ==
X-Received: by 2002:a62:6807:: with SMTP id d7mr52800695pfc.75.1556390384509;
        Sat, 27 Apr 2019 11:39:44 -0700 (PDT)
Received: from cakuba.netronome.com ([2601:646:8e00:4a0b::2])
        by smtp.gmail.com with ESMTPSA id r11sm36708305pga.87.2019.04.27.11.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 11:39:44 -0700 (PDT)
Date:   Sat, 27 Apr 2019 11:39:40 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alban Crequy <alban@kinvolk.io>
Cc:     Alban Crequy <alban.crequy@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Iago =?UTF-8?B?TMOzcGV6?= Galeiras <iago@kinvolk.io>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: sock ops: add netns ino and dev in
 bpf context
Message-ID: <20190427113940.223fd4d1@cakuba.netronome.com>
In-Reply-To: <CADZs7q7O9TL5wXFBq_SgAdNCkzO=3tyLnF1_chthX3jao=PKqA@mail.gmail.com>
References: <20190426154848.23490-1-alban@kinvolk.io>
        <20190426140323.4edf1127@cakuba.netronome.com>
        <CADZs7q7O9TL5wXFBq_SgAdNCkzO=3tyLnF1_chthX3jao=PKqA@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 27 Apr 2019 12:48:25 +0200, Alban Crequy wrote:
> On Fri, Apr 26, 2019 at 11:03 PM Jakub Kicinski
> <jakub.kicinski@netronome.com> wrote:
> >
> > On Fri, 26 Apr 2019 17:48:45 +0200, Alban Crequy wrote:  
> > > In the unlikely case where network namespaces are not compiled in
> > > (CONFIG_NET_NS=n), the verifier will not allow access to ->netns_*.  
> >
> > Naive question - why return an error?  init_net should always be there,
> > no?  
> 
> True for netns_dev. However, without CONFIG_NET_NS, we cannot access netns_ino:
> 
> (struct sock_common).possible_net_t.(struct net *):
> 
> typedef struct {
> #ifdef CONFIG_NET_NS
>         struct net *net;
> #endif
> } possible_net_t;
> 
> And I don't think it would make much sense to allow access to
> netns_dev but not netns_ino.

Right, if CONFIG_NET_NS=n we could just take the pointer to init_net
directly, and not worry about the field.  IMHO it'd be preferable to
changing the UAPI based on kernel config, but I don't feel super
strongly.
