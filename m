Return-Path: <SRS0=Yvha=V3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151A3C433FF
	for <bpf@archiver.kernel.org>; Tue, 30 Jul 2019 21:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D340020693
	for <bpf@archiver.kernel.org>; Tue, 30 Jul 2019 21:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="mcws10hD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfG3VA4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:00:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43670 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfG3VA4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jul 2019 17:00:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so21915367qka.10
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2019 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=UZVLH+YJQnTToBfxuUOLKOpxR4PzlV9zcM3XVpn0bZQ=;
        b=mcws10hDVVGHgXmeHOx3+gacFHiyt6qxQmtnMf9VKy9x2aso89EW+Iz5QyvBfsb5k1
         mYAFkhQqw6yWf+1/iIzcSs2OgAr0QWe+wVrEtAFBUilZNASolnS6iRHqCGouKKTxI2pb
         tbupWsSD/Tc8IocksoN9BnMfFPsJswJhUvq0DvlfVplsZKLM0664vDVsqqjchQGU1OnD
         Vmcd0hqOSEzOcAc6AyUEKp+4VSBl+vtPQNYbD9RnLXrL+N397Jh9IxFwt+Y155WBnSZm
         YBsmWTIg7WDc3KKxVG9iLH62A88G7F44bLEDorf4En3SYksZTTcX8R4dfbxSdHLuL6gx
         /7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=UZVLH+YJQnTToBfxuUOLKOpxR4PzlV9zcM3XVpn0bZQ=;
        b=LmznwNkVkiEchbfmRQG6ScKX05q55pLeK3xJVF5ayus6Nw3tP/yKzN/zbDExgr5p0G
         +okWbmrK69oe/pfe25JLmw7YdfLRBoXwjrHEcn1VorAb0vd3wmNMDKkhy03HPjXPiN5j
         t7JOmAik+KwPIK/EaPuetGRnfUdyL4F7vziNXuZuj3IQzqEwS5O4eiPTnuymmjG/Bd7R
         0swcBhpYENMz/vgsYcNb2Lqw2jVSmm4a9vLZyjA9tWBJ7izPt14aGaEq3RbALUPHySb5
         oLXHzbPYGpI8ydz4sscgv3lOYQWG2yuVMdBedKkEsFn1T5YcWwcwVPuX4OCnmFrP+o1s
         hm8w==
X-Gm-Message-State: APjAAAVrDtAHXHukCl5Zdfjn3fmT/zo+rBwu0J0SaeYF/5OtqWib9MHY
        bVCb2tpC1fckOSfcppcj9SR7RQ==
X-Google-Smtp-Source: APXvYqy6uA8j/TiODO9MQFYAXMgFVAJWCFAWDabDRYE1w+HZfeiZDq7OyAAZj3mhuM9beq9rdAK4LQ==
X-Received: by 2002:a37:274a:: with SMTP id n71mr72049172qkn.448.1564520454474;
        Tue, 30 Jul 2019 14:00:54 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id g10sm27564265qkk.91.2019.07.30.14.00.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 14:00:54 -0700 (PDT)
Date:   Tue, 30 Jul 2019 14:00:40 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Takshak Chahande <ctakshak@fb.com>
Cc:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>,
        Kernel Team <Kernel-team@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCH bpf-next] tools: bpftool: add support for reporting the
 effective cgroup progs
Message-ID: <20190730140040.7a357b19@cakuba.netronome.com>
In-Reply-To: <20190730180443.GA48276@ctakshak-mbp.dhcp.thefacebook.com>
References: <20190729213538.8960-1-jakub.kicinski@netronome.com>
        <20190730180443.GA48276@ctakshak-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 30 Jul 2019 18:04:53 +0000, Takshak Chahande wrote:
> Jakub Kicinski <jakub.kicinski@netronome.com> wrote on Mon [2019-Jul-29 14:35:38 -0700]:
> > @@ -158,20 +161,30 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
> >  static int do_show(int argc, char **argv)
> >  {
> >  	enum bpf_attach_type type;
> > +	const char *path;
> >  	int cgroup_fd;
> >  	int ret = -1;
> >  
> > -	if (argc < 1) {
> > -		p_err("too few parameters for cgroup show");
> > -		goto exit;
> > -	} else if (argc > 1) {
> > -		p_err("too many parameters for cgroup show");
> > -		goto exit;
> > +	query_flags = 0;
> > +
> > +	if (!REQ_ARGS(1))
> > +		return -1;
> > +	path = GET_ARG();
> > +
> > +	while (argc) {
> > +		if (is_prefix(*argv, "effective")) {
> > +			query_flags |= BPF_F_QUERY_EFFECTIVE;
> > +			NEXT_ARG();
> > +		} else {
> > +			p_err("expected no more arguments, 'effective', got: '%s'?",
> > +			      *argv);
> > +			return -1;
> > +		}
> >  	}  
> This while loop will allow multiple 'effective' keywords in the argument
> unnecessarily. IMO, we should strictly restrict only for single
> occurance of 'effective' word.

It's kind of the way all bpftool works to date :(

But perhaps not checking is worse than inconsistency? Okay, let's fix
this up.

> > -	cgroup_fd = open(argv[0], O_RDONLY);
> > +	cgroup_fd = open(path, O_RDONLY);
> >  	if (cgroup_fd < 0) {
> > -		p_err("can't open cgroup %s", argv[0]);
> > +		p_err("can't open cgroup %s", path);
> >  		goto exit;
> >  	}
> >  
> > @@ -297,23 +310,29 @@ static int do_show_tree(int argc, char **argv)
> >  	char *cgroup_root;
> >  	int ret;
> >  
> > -	switch (argc) {
> > -	case 0:
> > +	query_flags = 0;
> > +
> > +	if (!argc) {
> >  		cgroup_root = find_cgroup_root();
> >  		if (!cgroup_root) {
> >  			p_err("cgroup v2 isn't mounted");
> >  			return -1;
> >  		}
> > -		break;
> > -	case 1:
> > -		cgroup_root = argv[0];
> > -		break;
> > -	default:
> > -		p_err("too many parameters for cgroup tree");
> > -		return -1;
> > +	} else {
> > +		cgroup_root = GET_ARG();
> > +
> > +		while (argc) {
> > +			if (is_prefix(*argv, "effective")) {
> > +				query_flags |= BPF_F_QUERY_EFFECTIVE;
> > +				NEXT_ARG();  
> 
> NEXT_ARG() does update argc value; that means after this outer if/else we need 
> to know how argc has become 0 (through which path) before freeing up `cgroup_root` allocated
> memory later at the end of this function.

Good catch!

> > +			} else {
> > +				p_err("expected no more arguments, 'effective', got: '%s'?",
> > +				      *argv);
> > +				return -1;
> > +			}
> > +		}
> >  	}  
 
> Thanks for the patch. Apart from above two issues, patch looks good.

Thanks for the review.
