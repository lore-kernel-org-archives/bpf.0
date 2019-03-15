Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D814C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 20:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2EC218AC
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 20:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i813GJ/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfCOUmJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:42:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40263 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfCOUmJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 16:42:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id y124so7118632pfy.7;
        Fri, 15 Mar 2019 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MRbztOwG43h3pOKBN5Fe07fo8ZcGMZSqKVXsJzAmFAw=;
        b=i813GJ/kgtLcgHWZ8YQAt9JZh9aBC60SFgPa0ivx5XeG75UPnC1DUSnH9C66urNG1h
         48NQtwtJfno5eSFvAt/cxdPjUNsA41VFnhH6UQEFL3QYjIJA0QF6h+hcupjFGifUUZ7L
         siH8B03ttn4sVQdgCGNplp1xVRSxeFReUvC0BPvGlm/IFU+jLgDYrKYCQMm9Z+lMMPzp
         V1T6R+KoRMOhkGoOpwcg90USbuUc7O3Xb/7DQGq9qR88yYirWaSqELzSq79hEDr0UPKr
         vOWrwGApaP5kR6JT5otyc0jDh5WCH2pzba80uanp1s9D/qyIJV4nfcH4sqfwJc/0bKna
         DZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MRbztOwG43h3pOKBN5Fe07fo8ZcGMZSqKVXsJzAmFAw=;
        b=mDum8JGOBvihajXSC0d/Pf77eCWFVT064mc7tXcrrkRqWumVBVHb6Tn6GDDXHr8Po1
         DnAqeb8HKiVFO2g3yRjmMBWh2SE1hEleROWNvtZdu4RIUDzLErDZDFGvpv5gIqrWxHrH
         Z4noVZoebMwMdk8GT/DbBJ8yde62wj76ro9HRHUzfuYsPRlermX1VqyNPoq5W0FJjkXz
         fmyVoPx55+gGcnio3dxp5xBmK7nxDtC9i7rzkpja68R6vrSEVhdFFlRkiByHAL9n9ZjM
         7J1iryA6L9npA2I5RrSWdnwueAHOPiiVCngY9NZaRbAljDUikHSs3hFXzmICmulzPzZ2
         sh6w==
X-Gm-Message-State: APjAAAVwYlnC97y4uzaZ78eUW6KtvJs+GyCkec2AkLpyH/VxdFEfzLOM
        W7v5jIdgD87ni3C0iDyyE5I=
X-Google-Smtp-Source: APXvYqwP5K21scYbGBZhuGjoOEwv9ArgD/khSotASW9l5mkT4q1Iq+2xJ1E2d3rlQNv1LdkBXFGHZA==
X-Received: by 2002:a62:1c94:: with SMTP id c142mr6208395pfc.54.1552682528800;
        Fri, 15 Mar 2019 13:42:08 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::846b])
        by smtp.gmail.com with ESMTPSA id 15sm6950289pfn.53.2019.03.15.13.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 13:42:07 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:42:06 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, theojulienne@github.com
Subject: Re: [PATCH v2 0/8] Allow checking SYN cookies from XDP and tc cls act
Message-ID: <20190315204205.utescu2qm6wv2ncr@ast-mbp.dhcp.thefacebook.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190314113954.10210-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314113954.10210-1-lmb@cloudflare.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 14, 2019 at 11:39:46AM +0000, Lorenz Bauer wrote:
> This series adds the necessary helpers to determine wheter a given
> (encapsulated) TCP packet belongs to a connection known to the network stack.
> 
> * bpf_skc_lookup_tcp gives access to request and timewait sockets
> * bpf_tcp_check_syncookie identifies the final 3WHS ACK when syncookies
>   are enabled
> 
> The goal is to be able to implement load-balancing approaches like
> glb-director [1] or Beamer [2] in pure eBPF. Specifically, we'd like to replace
> the functionality of the glb-redirect kernel module [3] by an XDP program or
> tc classifier.
> 
> Thanks to Martin KaFai Lau for his review!
> 
> Changes in v2:
> * Rename bpf_sk_check_syncookie to bpf_tcp_check_syncookie.
> * Add bpf_skc_lookup_tcp. Without it bpf_tcp_check_syncookie doesn't make sense.
> * Check tcp_synq_no_recent_overflow() in bpf_tcp_check_syncookie.
> * Check th->syn in bpf_tcp_check_syncookie.
> * Require CONFIG_IPV6 to be a built in.

pls resubmit when bpf-next reopens.

