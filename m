Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB437C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 20:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB3C218A1
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 20:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FimJ0chd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfCOUmb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:42:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40297 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfCOUmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 16:42:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id y124so7119194pfy.7;
        Fri, 15 Mar 2019 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iYzneapCudGCOM2LZy0zwEHTigO3tLSKzbW7H/sTMX8=;
        b=FimJ0chdstPZWjXNWsM983M8qpynYCTrS59V2JuG5LeflJcvAKJXClXcGByuw/6qVM
         UE1zMcOspUmNwFMCobeR0aANLkXLerU6BZ3KOsp3yxwMkSIelSnfaa98+dR64rO2+Qgi
         uP9L3/kc4rvabN5WI63sTvkVvyn0DXUa3LOuCQCX5C5EjyNjezfuMs6uBm4NOnsWceIO
         AO5E+FdhHcjZ88AXm+gHOa3sJO48QiMBJQpJyPYPz9zzelXF7IMyd2IReKLi5yj8yKLQ
         JezQ5yD96GoBpjXNHRHw2nb28RKlE629HKdHV0c4hfOiHhONwjHqe4ZDYt2J1PqUQ0gu
         c4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iYzneapCudGCOM2LZy0zwEHTigO3tLSKzbW7H/sTMX8=;
        b=eDEsV0KLkRWE0DfKSRZbuxBsh3QLtaLygzRB13/I+IRxHvPleGMJVRv688mCLrfgez
         XO5nEiPKzeoFv8eo0fU8wbKkUbr8VqPGjJ3R9In6PT6H4il0Z/aS+hKksYv//reX2M5J
         4jQd99jVfVeucZzkD7iLAqmFwu7Af73AHFXTRiNSaEktip1hWmMkgQ3m29oVJcFm7pND
         504TV6mphdXPH+P9sJSHxUZVxaqfcF8LZzSr42L9XTnWODKzrRglgk+3qosnV2Est60h
         BSKXVAtgp8twUB+Fan5pSSuYtLHX3jHqmr7Ei2OLYl1yp81JSNkVViOyaC/kaplxbJXU
         lpYw==
X-Gm-Message-State: APjAAAWyn/nbxgJ/y8D+88G1LO0PEggq8zVc6jVNiXgp6OEboP/sGR8p
        X9qdibvmsCkwYIKPTcpy/NE=
X-Google-Smtp-Source: APXvYqwXUJrhXN7GkR4sHta1GWBFaukmKsYBgG3g38C+4lnusKxlq0NTs5bSnzzRXuMG/hi4hGkjog==
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr4970534plb.22.1552682550406;
        Fri, 15 Mar 2019 13:42:30 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::846b])
        by smtp.gmail.com with ESMTPSA id v15sm6700853pfa.75.2019.03.15.13.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 13:42:29 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:42:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lawrence Brakmo <brakmo@fb.com>,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH bpf] bpf: make bpf_skb_ecn_set_ce callable from
 BPF_PROG_TYPE_SCHED_ACT
Message-ID: <20190315204226.fyobzdxnacw3q32t@ast-mbp.dhcp.thefacebook.com>
References: <20190315002858.228416-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315002858.228416-1-posk@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 14, 2019 at 05:28:58PM -0700, Peter Oskolkov wrote:
> This helper is useful if a bpf tc filter sets skb->tstamp.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>

pls resubmit when bpf-next reopens.

