Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA830C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 02:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E57E206B7
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 02:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNctdvc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfBWC3m (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 21:29:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40780 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWC3m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 21:29:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id u9so1922155pgo.7;
        Fri, 22 Feb 2019 18:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nUeMa/FlDVQKcxwIJIvHrRSXaAJ1CGk0LF/33V+5veM=;
        b=TNctdvc28JyRv/alsYkb1ct+LCg1Quz+z5q67cLzvE4aw3Br5CySuO6ZlfFQ7zbMzY
         onftg2bgbCZOwWZxyPcW4NBgg0VQ74ittdAKPx/Y5xbH0qNYRIMy1psJQHMu225HTpiq
         xsDls71rqtE4vnoY1wk6tsq7HMZrZa2OXs8aMdswnLr8nmoQDOE/peszFr9LiHZBSM57
         H9kIMV+tnrJd5WSasr1A9JUv8/ZboKp3qkPje2xmerzxFQDPMWUXnb8M0H9xJJvW6Z48
         H2k8jb3MVNzRtKPr1TZBb03Pr+EG2jXUJM9K62ePpiMIU4fR0uoLEC6m/oPwgJv/ru71
         EKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nUeMa/FlDVQKcxwIJIvHrRSXaAJ1CGk0LF/33V+5veM=;
        b=FOpM4302FOg4Kw1hRufFY7bzLUsEK9RHXjXFXWt3DMFafEdTqabEJxhjf0iJpVKavn
         KTzXzcD5KA2KMp7TW6mHDdaJ13CGCdYcTbcWtBt2hIVF/PiBpO+xfcJIXGT017AFdaah
         BtXvogPmghz0q3JSpqVhpWMirSomX6W33B9KnjIL0P4afZ98v+tsSMxFe1BImKlb4kSu
         VTb++uaOlf6vvyUqQIej85UdT2Wz+REQYWwk0QHv+t9hmgqOsKn+CxCpYbf+/kFAy/Fk
         TnAevd0KhVdVcNtxPOPXA1Y/bOLSw9827VbESxDUvqdeMoY7p/vUo8ugIUqIspn9LsMP
         RXaQ==
X-Gm-Message-State: AHQUAubQXWNiheBF8mqhR8ezG1iyW87kFx01/bl7s82t38wmscJMVYXw
        cYrnXz4oJ2fYwCZ5k/8Wa8Y=
X-Google-Smtp-Source: AHgI3IbsX3zZUO4lQV6p9XHp2/FyYumMyOQIW17hDadsH3gQDkc2u73QOXn+CbkOApzk6KDrX5Hhug==
X-Received: by 2002:a63:c0e:: with SMTP id b14mr6974452pgl.236.1550888981244;
        Fri, 22 Feb 2019 18:29:41 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:1d52])
        by smtp.gmail.com with ESMTPSA id f10sm3563512pfn.11.2019.02.22.18.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 18:29:40 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:29:39 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/4] bpf: enable program stats
Message-ID: <20190223022938.hq3jys6as5e5kyjr@ast-mbp.dhcp.thefacebook.com>
References: <20190222233644.1487087-1-ast@kernel.org>
 <20190222233644.1487087-2-ast@kernel.org>
 <adabf404-7d0e-d801-1952-14f6b3ff8ced@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adabf404-7d0e-d801-1952-14f6b3ff8ced@gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 22, 2019 at 04:05:55PM -0800, Eric Dumazet wrote:
> 
> 
> On 02/22/2019 03:36 PM, Alexei Starovoitov wrote:
> 
> >  
> > +static void bpf_prog_get_stats(const struct bpf_prog *prog,
> > +			       struct bpf_prog_stats *stats)
> > +{
> > +	u64 nsecs = 0, cnt = 0;
> > +	int cpu;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		nsecs += per_cpu(prog->aux->stats->nsecs, cpu);
> > +		cnt += per_cpu(prog->aux->stats->cnt, cpu);
> 
> This does not work reliably for 32 bit kernels.

right. my mind was in probe_read thread. will fix.

