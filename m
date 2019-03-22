Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B0C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 02:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DBC218FE
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 02:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b128CVsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCVCGw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:06:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36128 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfCVCGw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 22:06:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id p10so411903pff.3;
        Thu, 21 Mar 2019 19:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZRjPd4aDU+RKxbLwDfTQ6cIoFqwS+CnLbDrZEaCcBis=;
        b=b128CVsFbVrPT/tWgnE1GHR5b8PfIhWp5SjuE4+TCIkR+pbWWWJTPabZZSPcqn/Y/F
         DfVoIJy2s8yFcV95bv6/pES3iSyEAE6TkBOYyFDSVu5tlvediPOgSpoaUSwh70Et0fTs
         46bTI7XDu0awkfgJTBJo5SbIGQsLuUCTDTQha3SbVSwh2FCeVNpHOlcVlFE398pD4FXQ
         yD2BOu4WQY+gLlr8tV/HNyGv9+zoNKadF3PGhovwoD1pmwt92Tod5ohfnXzYpP1KYuAY
         BYPvpdo50xU/HvMrOpxvszbfzhSlNWBs/RtYz/icCRH6hhL0JJh/KjnkmAbueT1B8cDQ
         HBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZRjPd4aDU+RKxbLwDfTQ6cIoFqwS+CnLbDrZEaCcBis=;
        b=XvDcB4ZDvCwm0t982E6qXDcVm1JmTkly7x32nqlDjeylzwJBDPYws/4Rz+IxMYmlAD
         i9GYLFwT6IGPf3NxFE+VLrf1caZ1I8FhSGjUEIOBenJeodRIGUn/A4IX2Oyhsmwj5DjJ
         DCmP+MD6G/I+VuJTswaO0d4fkPkbncrWNPY+Q1j3hNMTuURrmM+/eG30f19E1LmW5o5C
         GE7IwFUD2gXPUeEe+dRwZFKP+t4m6PvGP80VQQvb0nTkscsHp5zBdOrI+1TxZZPbxPRn
         BNOtIJwnH68UFceEp4rpsXSuAhSoL6pamSph+S18Rmf6kSetiQj/0GZ7fcz9WUgJpLQG
         epjA==
X-Gm-Message-State: APjAAAX4vAicHDugAojHShyVF0w2yOB6EBdsLZYS5RANTt7YDeeMwhfD
        1/3grclubW2PR8d9grUnd/A=
X-Google-Smtp-Source: APXvYqyqk6Pn/xjJDjXw4V4voSmNK6YF02I9FWPlLwyRQ90T4RSsC5dD8fslhiPJC6RQF2o5G9WEew==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr6824577plt.195.1553220411467;
        Thu, 21 Mar 2019 19:06:51 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::d464])
        by smtp.gmail.com with ESMTPSA id n15sm13190919pgc.92.2019.03.21.19.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 19:06:50 -0700 (PDT)
Date:   Thu, 21 Mar 2019 19:06:48 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kafai@fb.com
Subject: Re: [PATCH bpf-next v3 4/8] bpf: add helper to check for a valid SYN
 cookie
Message-ID: <20190322020646.mnrpce2i2ooe6shi@ast-mbp.dhcp.thefacebook.com>
References: <20190319102103.7380-1-lmb@cloudflare.com>
 <20190322015406.26453-1-lmb@cloudflare.com>
 <20190322015406.26453-5-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322015406.26453-5-lmb@cloudflare.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 22, 2019 at 09:54:02AM +0800, Lorenz Bauer wrote:
> Using bpf_skc_lookup_tcp it's possible to ascertain whether a packet
> belongs to a known connection. However, there is one corner case: no
> sockets are created if SYN cookies are active. This means that the final
> ACK in the 3WHS is misclassified.
> 
> Using the helper, we can look up the listening socket via
> bpf_skc_lookup_tcp and then check whether a packet is a valid SYN
> cookie ACK.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
...
> +static const struct bpf_func_proto bpf_tcp_check_syncookie_proto = {
> +	.func		= bpf_tcp_check_syncookie,
> +	.gpl_only	= true,

you really want your employer to open source the load balancer :)
Fine by me.

The series applied to bpf-next.

