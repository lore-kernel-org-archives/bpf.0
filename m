Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837E0C10F03
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 00:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5422089F
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 00:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="YOav3eI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfDXANK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:13:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40415 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfDXANJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 20:13:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so8423043pgl.7
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2019 17:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AqPIpRpcEKCIH0WEnk02CXT2h6dyQy2RdEytO8QjT0E=;
        b=YOav3eI4CO6ykE+ezz21EuuI3bARPAifCzjqKvIIVnKlTS7oXQjfyEwypyVXB36q+S
         Rv3K/uty3h8QxTNT7TMHkq7FscaRzHv3e4t/WyoGNjmBBb0YZ5dkm+48NRwPOjovclJc
         2BhgRGf5U5raKAdXhuyuC517D+8+4hsO9S2bSZIzsic3pAsufctX3nRKfjZ1ZQj8SXS9
         7bG2chuZT10CSwBVLeMtNpBEh4Cu5mW61IBr9iScQN9yQ78dtu+reriN9WvXQINGo/Aq
         E5miKk9sxgCGRfAG1pZPtWA/xqqmWypYRMarFPLpb1wJ6fq1OPFo61HD+UePGvW3rMt3
         rn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AqPIpRpcEKCIH0WEnk02CXT2h6dyQy2RdEytO8QjT0E=;
        b=FdmIQTHLTRNq1tEeVTP2SwjfisyCD6ZOj8M1QWa+xnNcjnV0Wh/LaXKHgPANWj0XB5
         a6ESnleuTnCEXIurSfEzS4wt959Oo7hURG3WBI2tIZwUDIb9kd97KLpJEw0LeYwyZpZk
         Hcl37Y46CsDEEzUz2aWZuIRu6SiaZOdgj1XjwG2cVWqORPqZc8FytmZiFybBehrNjFZx
         Hk4SR+VX2+wKSz0/RIsnsMhVjF4kEV8cWUhu+VK1Zcj92wXqMutmQT2p6ZNM/flaaDlG
         Wvw35RbORGGE7JNCTU7wqWvLwHa9X9upos8uasOkpE+XlTF6gxVNmj6POEDWnrSvR3eT
         v8vw==
X-Gm-Message-State: APjAAAVBMbNdAJkkb4tDXxey1AujfdOqao6TzF0L6RJBad5EueQYkJyx
        9mjC1OQBDh71Si/qMMZFjJMq3Q==
X-Google-Smtp-Source: APXvYqyVKTnozSxj5PX0brYGk+L1HfiVqU9hRQLHJi2Sc7pKOEoBVf+lmRmwTgwD4XEb0HYLqICmlg==
X-Received: by 2002:a65:558a:: with SMTP id j10mr27383588pgs.85.1556064789287;
        Tue, 23 Apr 2019 17:13:09 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id u5sm25313737pfa.169.2019.04.23.17.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 17:13:08 -0700 (PDT)
Date:   Tue, 23 Apr 2019 17:13:07 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, quentin.monnet@netronome.com
Subject: Re: [PATCH bpf-next 2/2] bpftool: show flow_dissector attachment
 status
Message-ID: <20190424001307.GB1247@mini-arch>
References: <20190423232200.101627-1-sdf@google.com>
 <20190423232200.101627-2-sdf@google.com>
 <20190423163244.0a665bb0@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423163244.0a665bb0@cakuba.netronome.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/23, Jakub Kicinski wrote:
> On Tue, 23 Apr 2019 16:22:00 -0700, Stanislav Fomichev wrote:
> > +static int query_flow_dissector(struct bpf_attach_info *attach_info)
> > +{
> > +	__u32 prog_ids[1] = {0};
> > +	__u32 prog_cnt = ARRAY_SIZE(prog_ids);
> > +	__u32 attach_flags;
> > +	int fd;
> > +	int err;
> 
> reverse christmas tree, please :)
> 
> Move the init into the code if necessary.
Ack, initialization didn't let me do that. But I think I can drop it, I
don't look prog_cnt in the syscall, maybe I should :-/

> > +	fd = open("/proc/self/ns/net", O_RDONLY);
> > +	if (fd < 0) {
> > +		p_err("can't open /proc/self/ns/net: %d",
> > +		      strerror(errno));
> > +		return -1;
> > +	}
> > +	err = bpf_prog_query(fd, BPF_FLOW_DISSECTOR, 0,
> > +			     &attach_flags, prog_ids, &prog_cnt);
> > +	close(fd);
> > +	if (err) {
> > +		if (errno == EINVAL) {
> > +			/* Older kernel's don't support querying
> > +			 * flow dissector programs.
> > +			 */
> > +			return 0;
> > +		}
> > +		p_err("can't query prog: %s", strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	if (prog_cnt == 1)
> > +		attach_info->flow_dissector_id = prog_ids[0];
> 
> So the count can only be 0 or 1?  Hm.
Yes, its either attached or not; there is nothing like prog_array.

> > +	return 0;
> > +}
