Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B3C4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1035C2133D
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="E+QnPBDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDCSuN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:50:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38121 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDCSuN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 14:50:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so8767038pgl.5
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2019 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pewuKiHMgiYRaKpN7bbpYqCsyC/yX/JfLOoYQwDYfVo=;
        b=E+QnPBDEz/1GL6Dx7iQEJ2vpSNWxicuidNBqcvDqMqNKYPP68ffHakoCtAlBvmRaqH
         FprgDpaMwOyjWc7GaKjoXLrr49wJ3Hv3tGgXNjjzNvj1l1mn+LJCj8MAo3lD/xU7lMqd
         GJoiyfbfmJ6q+vT/xvgi9wlD6vYUQ1FPfO6RI3XhbB2zmVgsWeQgFX0jGduPqhUSL+pb
         vsc3Ibo7TccGiHc/BCgS0ghqJZXA+RMerHbGhfvAufhk0dZ6CDlE9NHR2XK3rBLvrm6J
         koxXRSMlgP5uBwx/l7ZOAxX0NomruAZFpIfr/UwCMn7+2gAcFeYaQOcFVzBaw+dY6Ufh
         mCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pewuKiHMgiYRaKpN7bbpYqCsyC/yX/JfLOoYQwDYfVo=;
        b=G6G83RO5trxQ9lNEmMiQBVWFQiHdiIE16g2Kil72gN2N4nccuNxrTwqBY/6jPcqzny
         bYy4mKfA/c0OZtXaQBy9JtX476MMT+mPDsXoDBky7t75LC22xgHQ70yMp1rnfqJtGkWH
         7mImOuvlXbBXnmIbcYC7zLrkf2BPeLNpuIyO+A5yf5edcGMWQyN9lPO0ygUIUEntIAuC
         ee+nAUG3lNBfToCokSDkrsEBBZyXwkK21WiJ0SdaJN7vhn16eniZ3Nniw2zNK5d2t40T
         Mzdq5lcx7LHunX0CWDcmFPW6TwdD73vIsyVfDs05YWjFWruoW20YFM5eYYGMtAahy1DP
         zcZw==
X-Gm-Message-State: APjAAAUZkZBtPjCnfK0wl5APafceNyq7+sy8Bctodu+A+H2DmE/7SLg8
        dLH7AHg7pg79TbJf4WuSDAJzZg==
X-Google-Smtp-Source: APXvYqxKugz4G2CjgQ29IY3HJ9OtM8IwvfgkxYoEA3NfXo/eLHkSs9qxUGvmQucwE+wDeWuoanUuoQ==
X-Received: by 2002:a62:6587:: with SMTP id z129mr1110003pfb.88.1554317412369;
        Wed, 03 Apr 2019 11:50:12 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id c1sm21178984pgk.44.2019.04.03.11.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 11:50:11 -0700 (PDT)
Date:   Wed, 3 Apr 2019 11:50:10 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
Subject: Re: [PATCH bpf 5/5] flow_dissector: document BPF flow dissector
 environment
Message-ID: <20190403185010.GJ7431@mini-arch.hsd1.ca.comcast.net>
References: <20190401205734.4400-1-sdf@google.com>
 <20190401205734.4400-6-sdf@google.com>
 <20190403203403.4b6d135d@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403203403.4b6d135d@carbon>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/03, Jesper Dangaard Brouer wrote:
> On Mon,  1 Apr 2019 13:57:34 -0700
> Stanislav Fomichev <sdf@google.com> wrote:
> 
> > diff --git a/Documentation/networking/bpf_flow_dissector.txt b/Documentation/networking/bpf_flow_dissector.txt
> > new file mode 100644
> > index 000000000000..513be8e20afb
> > --- /dev/null
> > +++ b/Documentation/networking/bpf_flow_dissector.txt
> 
> It looks like you use the RST format, but you use suffix .txt and not .rst.
Thanks for the suggestion, let me try to rename it to .rst and build local
htmldocs to make sure it renders correctly (I'm not sure about the ascii art).
If that looks good, I'll follow up with a rename patch.

> 
> If you don't know, these files get rendered on:
>  https://www.kernel.org/doc/html/latest/bpf/index.html
> 
> And GitHub also render this stuff e.g.
>  https://github.com/torvalds/linux/blob/master/Documentation/bpf/bpf_devel_QA.rst
>  
> 
> > @@ -0,0 +1,115 @@
> > +==================
> > +BPF Flow Dissector
> > +==================
> > +
> > +Overview
> > +========
> > +
> > +Flow dissector is a routine that parses metadata out of the packets. It's
> > +used in the various places in the networking subsystem (RFS, flow hash, etc).
> > +
> > +BPF flow dissector is an attempt to reimplement C-based flow dissector logic
> > +in BPF to gain all the benefits of BPF verifier (namely, limits on the
> > +number of instructions and tail calls).
> > +
> > +API
> > +===
> > +
> 
> 
> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
