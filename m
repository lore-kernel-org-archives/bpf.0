Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC1DC10F03
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 00:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D382089F
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 00:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="s6nhwvfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfDXAMJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:12:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36935 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfDXAMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 20:12:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so8423770pgc.4
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 17:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NAqZicel5yW3F1h3BQXm8xfCpsAdHRvGDjuMUeIa3RA=;
        b=s6nhwvfR1xYwja2NUT13GQfQIpffFA9UCtdCCpvrGfviUioABQacpr3ZXODwp+aHaP
         2PbFoLvkubk1caDkmNQsQ1VzOvNOraDKUOjTNMYt2xnsu0pLgtJE8OyinnDx1ya6YJsR
         ObSOA/gGbtyE2q1kF4zJc5hmk+MXATM0kbgShYwQfxoi6XeLfTrncFGo01ZuZCWntVLY
         sAbwew0ZCqH6DIEMOetdPfZcdb0h21wjiqttdmMTYcBxA28ndtDCL8aQVfvilUiJMH48
         4Dc6SSZ3iS40d5K7VhGbuB1UndzYWMnnkYEmoj7oY+d85exLgZUMnLlszHhWjwBu9TKv
         nHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NAqZicel5yW3F1h3BQXm8xfCpsAdHRvGDjuMUeIa3RA=;
        b=gjwglrFQ0wTkxpEaJKogqU6W0tjDTl6U/W9QItC2AlG+s1FeYsYHAAFQHYwliFt09o
         mT7Lm95aDzQnEMZOP0CWwPfriqEBTV9eJazPtYJ7CzuBKdW25bKovWgXufgvpKu1yVVQ
         x2GGG1wc34vpkaHgVSMURuGaAOLamyMNTMEJHedtHC0G6s+6FG3pr3o3pjtU0qd8dAue
         PgfrFJPzIOtN56yRcbWO0mWhqu37A2zOZRniOpLMU847ZhZPcJqQgs+eRIldO30+PJkk
         X5rFmuei6a7lRZ1SmRfa93OHjH2vly4KA8UHphj+x7yxWok8l5pjT4d9ZLr8fzbXA24W
         Iclw==
X-Gm-Message-State: APjAAAWg4GQxoL4PEtkti3/AxmrAAI8Pgy4O5kqS5Q4eEm8dihc0qm2F
        1zhGkh0l0NcS9+mhdG7kq0D92g==
X-Google-Smtp-Source: APXvYqz0sxphtushKPN/M2VLvo0tabEIwWlQgfSHC9xxk67xxOGnXKTNeczv42u/E3RwM8s+tkPBJA==
X-Received: by 2002:a65:43c8:: with SMTP id n8mr26616337pgp.365.1556064728342;
        Tue, 23 Apr 2019 17:12:08 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id h20sm46077872pfj.40.2019.04.23.17.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 17:12:07 -0700 (PDT)
Date:   Tue, 23 Apr 2019 17:12:06 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, quentin.monnet@netronome.com
Subject: Re: [PATCH bpf-next 1/2] bpf: support BPF_PROG_QUERY for
 BPF_FLOW_DISSECTOR attach_type
Message-ID: <20190424001206.GA1247@mini-arch>
References: <20190423232200.101627-1-sdf@google.com>
 <20190423162855.4580667d@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423162855.4580667d@cakuba.netronome.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/23, Jakub Kicinski wrote:
> On Tue, 23 Apr 2019 16:21:59 -0700, Stanislav Fomichev wrote:
> > +	rcu_read_lock();
> > +	attached = rcu_dereference(net->flow_dissector_prog);
> > +	if (attached) {
> > +		cnt = 1;
> > +		if (prog_ids &&
> > +		    copy_to_user(prog_ids, &attached->aux->id, sizeof(u32))) {
> 
> Not sure you can do copy_to_user inside an RCU section, doesn't it
> sleep?
Good point, I need to copy that aux->id somewhere and exit rcu section.

> > +			rcu_read_unlock();
> > +			return -EFAULT;
> > +		}
> > +	}
> > +	rcu_read_unlock();
> 
