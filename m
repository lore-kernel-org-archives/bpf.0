Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC18C43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749652087C
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 21:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT7d7Bak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCNVIQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:08:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34392 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfCNVIQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 17:08:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so4852475pgq.1;
        Thu, 14 Mar 2019 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r0nNRLTbIrvjPjxEOACPapFks+jomDFz+qfG5C7mOMA=;
        b=PT7d7BaknpJWRyG5LAbfNXtZuq87spcL0bKC8WCsyYw/bHmeoo6amGFqJBXKHDt9ng
         OywpO5YH1x+cRw8kZccEkXQLmI3VJ61MpTt+QOsKEJX8Otxq2ItpRdou6ezUTgDHosfV
         pOhNu9rWh7JLo9x7oNc3E/H1fvulgfSTdLNIznTqjkZjB2C8ujh+lDPDlGvozWJqrMiA
         MzK3J1Ia5x/rJUAhrltYfd5WGZ9V7o6FzsFRv9vG7OhGDMrMCNVb//XmTZO6McTpAeE1
         JBr6UiHI41vkT8eMuw0f9TGWQ0ppntzcVvjU/6+dzN1awo33rPmdBw+RGKKwz7E7PDu6
         PlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r0nNRLTbIrvjPjxEOACPapFks+jomDFz+qfG5C7mOMA=;
        b=ceifkygWa+yMlq/evMCjWAnter/tTdP3rqs6Q3PloyaTDHrg7htuTpGUAauO2QoGor
         r3oyAQ5Vftf5Mfat3lcps9HrM/XDLskTZGniYqTWYXHEQt4f0ZiVJTctl9fTkaz2j0s9
         A0od7e7wNcd74J45kTRpbT64FjbC/09vFMgGbANLEtuNBezJJITrb0U2lP3xd0skyUkJ
         6+bc87yFjsY+2MK1bGPPIb4LdVvJwjuCG5hiXcM5erK/6usIAqesfNTCfcVzAFBzvxUS
         cyyc5/RMzOUuldyu0C/ucqJX7Zec3q7+47BuTzRjjKZPpdWPfk+xtUY4J2Mu8HcNPTT6
         DVcw==
X-Gm-Message-State: APjAAAXs/RvJB3kVKVZrjiT8s2Qfhe+5dtFKTarPaXpVcn1ujKwQ7VEV
        h/83n6gxSCHP4GtDWewpgxccnZ2O
X-Google-Smtp-Source: APXvYqz32ddDBHpFxacutlYL66cdk76GSxDn+rVn/uUaPlQnv17IdGCuZwvSy0O8mmkSvNJT8u9bTA==
X-Received: by 2002:a17:902:20e5:: with SMTP id v34mr342033plg.319.1552597695285;
        Thu, 14 Mar 2019 14:08:15 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::2:b1ed])
        by smtp.gmail.com with ESMTPSA id 10sm14672pft.83.2019.03.14.14.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 14:08:15 -0700 (PDT)
Date:   Thu, 14 Mar 2019 14:08:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH bpf 0/3] fixes and additions for BPF helpers doc
Message-ID: <20190314210812.sbbpxz2k3jhf6g46@ast-mbp>
References: <20190314123841.13092-1-quentin.monnet@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314123841.13092-1-quentin.monnet@netronome.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 14, 2019 at 12:38:38PM +0000, Quentin Monnet wrote:
> Hi,
> This set is an update to the documentation for the BPF helper functions in
> the UAPI header bpf.h, used to generate the bpf-helpers(7) man page.
> 
> First patch contains fixes to the current documentation. The second patch
> adds documentation for the two helpers bpf_spin_lock() and
> bpf_spin_unlock(). The last patch simply reports the changes to the version
> of that header in tools/.

Applied to bpf tree.
Thanks for add bpf_spin_lock doc. Much appreciate it.

