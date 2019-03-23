Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54198C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 01:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BDC218E2
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 01:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7i/Uy+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfCWBnR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:43:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43450 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfCWBnR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 21:43:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so2648397pfd.10;
        Fri, 22 Mar 2019 18:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qfpZCm3Om/rD/BQzatelRWHywmUzfgqFbu1Eq+SmEjE=;
        b=D7i/Uy+fW6d9PZACCY5Nlg4apf/JHYJGSCOPa+kHOi8Y0IT2fUlvyHYlPQeL3E3Os1
         un1/tI7kAPqz2XaoDeuSwNeBVBIepmUtJ3seWhIJtvdtJCi9SNAiIxgYbm4bCP2eLRO/
         7xl3kC8s/L/6AABqvDHNBejKv7y5Wsmz6unlnBjEKgm7YZMpE/E/pazHvB1aMmdVil3U
         S0IqofXFFs3yZUczsAzPl2vtSNNm1NgY3saIGVDXXLoI5/eOIMMrb+Q8z/QVCrgCXPX0
         FjOokkAi68LqgDyImGWmng7GjpKIjukpjEE/5nDnzOVve3xfK4IESLP/gnRcZQh1UDE1
         4JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qfpZCm3Om/rD/BQzatelRWHywmUzfgqFbu1Eq+SmEjE=;
        b=pGQguIlMaezhhpaQDv5Z6JVnmKSHVyTLM0NeuJnqkYkyi1xavFLn7IkIygDa9RhOxq
         XH+9Z1+hIrn3NRdc7XKY+iKvYp5n8PsyqF1Vgwmedbbtokwk+1PlTFmPScj0BNgflAKd
         /VkV3kDQ1uSkz8V25rBpekoAOy2LZRQhFZgI7KhlDTncCFkhHH/yGVyDgvu+MahBAZR5
         R4mZS03h8J5BoUGyFmjvI1B1XYdYodUYHzauKFg80wlntlObN80ABe8N83akCw/hiONH
         JFXQk9i9JqeduZ2gy5BKshJIsOoqTTQd+MHBDAQ/gi+x+bMW1ySqguMEtfb54BmRGfs8
         RIsQ==
X-Gm-Message-State: APjAAAWKIiz5hB9puiWKCV96LdV+zIxrle1pjHEKgvewi8ZgM0m2Sa9S
        ClPc64H6jfhE+/p9JenqFESy+I9B
X-Google-Smtp-Source: APXvYqzGYjr5G0xs3Opjf6u6kLc0Y+KA9RrJ54yHUzY4ydleADrh3PPhITkCUTIUWXyzr0qZbYgm2A==
X-Received: by 2002:a65:4bcc:: with SMTP id p12mr11950489pgr.187.1553305397025;
        Fri, 22 Mar 2019 18:43:17 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::e4e7])
        by smtp.gmail.com with ESMTPSA id v4sm10569048pgh.53.2019.03.22.18.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:43:16 -0700 (PDT)
Date:   Fri, 22 Mar 2019 18:43:15 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH bpf-next 2/2] selftests: bpf: tc-bpf flow shaping with EDT
Message-ID: <20190323014313.ggcgnaq4fbsudxaw@ast-mbp.dhcp.thefacebook.com>
References: <20190322234019.229181-1-posk@google.com>
 <20190322234019.229181-2-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322234019.229181-2-posk@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 22, 2019 at 04:40:19PM -0700, Peter Oskolkov wrote:
> Add a small test that shows how to shape a TCP flow in tc-bpf
> with EDT and ECN.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
...
> +ip netns exec ${NS_SRC} bash -c "timeout ${TIMEOUT} dd if=/dev/zero \
> +	bs=1000 count=1000000 > /dev/tcp/${IP_DST}/9000 2>/dev/null"

just noticed this trick here and in lwt. Didn't know bash can do it. Nice!

Applied to bpf-next. thanks!

