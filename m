Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD8C282E0
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 23:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C752171F
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 23:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfDSXdg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:33:36 -0400
Received: from secvs01.rockwellcollins.com ([205.175.225.240]:24889 "EHLO
        secvs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbfDSXdg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Apr 2019 19:33:36 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 19:33:35 EDT
X-RC-All-From: , 205.175.225.60, No hostname, robert.mccabe@rockwellcollins.com,
 Robert McCabe <robert.mccabe@rockwellcollins.com>, , 
X-RC-Attachments: , ,
X-RC-RemoteIP: 205.175.225.60
X-RC-RemoteHost: No hostname
X-RC-IP-Hostname: secip01.rockwellcollins.com
X-RC-IP-MID: 275806709
X-RC-IP-Group: GOOGLE_RELAYED
X-RC-IP-Policy: $GOOGLE_RELAYED
X-RC-IP-SBRS: None
Received: from unknown (HELO mail-pg1-f198.google.com) ([205.175.225.60])
  by secvs01.rockwellcollins.com with ESMTP/TLS/AES128-GCM-SHA256; 19 Apr 2019 18:24:02 -0500
Received: by mail-pg1-f198.google.com with SMTP id d15so4244998pgt.14
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 16:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWNaluB2LhMx4nKn5MrzthUxn4PbLV1fksbMgA7vo8Q=;
        b=oReR0GX3xZW9iKL+o6oGR/+q8j8wYA+OGbGOeE7NdjeyQQrc6qzhplUyofwYDcCcWO
         /nn/NPfzT81eYZualyzNL4FkbPOz1z920iVpnYZklrqkIZfXukAj9RQobjHYvC8ESRaO
         iKNaHW76wkd5UlRb59MiLr83gITnVI1D/6W+KtBjIxYY838VW3NmRrVS/ikKmWwCpdLz
         SLHOLmN8YpqExhoFqWPSgwWJ71VTJfjcDXEVRyRMkcYdsVX3qAYL8DPmAxMzJzK/YcPY
         QHsFjbim1HQdNNCAoYVKq+nIHrJCE+fYas5KPd+A7O8AfgeQSqYsTb38VmBJDjfu198O
         7LEw==
X-Gm-Message-State: APjAAAV0fKLrYVQvDSWWhHG6HVJ9CNhR09TprFVzyCplhYewELe9TBS7
        7H4xAXVvYgLdYzCy44rtvrQ5I4GMUTwfQLcJQhliQgpcUnEOhEqeuZ3MRm8KjugQNsWxsBHqC1q
        Wvts3dszflS/I3Zy6QL51QlsxW211L/LVgY+85QdrgiwpyeY=
X-Received: by 2002:a63:7885:: with SMTP id t127mr6302556pgc.338.1555716241623;
        Fri, 19 Apr 2019 16:24:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwk8tEcl10gR1Yy0YVGB5WWWjkpPkDJTMGN1mo8839V6jRj8qJQ0L1wFSUPcAzmNyGADUGSnOHiv03DkBXOQ3Q=
X-Received: by 2002:a63:7885:: with SMTP id t127mr6302525pgc.338.1555716241260;
 Fri, 19 Apr 2019 16:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190419164745.3122-1-robert.mccabe@rockwellcollins.com> <20190419193206.gtu4ubv7aiu3xmge@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190419193206.gtu4ubv7aiu3xmge@ast-mbp.dhcp.thefacebook.com>
From:   Robert McCabe <robert.mccabe@rockwellcollins.com>
Date:   Fri, 19 Apr 2019 18:23:50 -0500
Message-ID: <CAA0ESdqg7RRMNxRUTHQM4OzQdDMQomANk5m09k9ev3C2j_cUuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix BPF_LOG_BUF_SIZE off-by-one error
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     netdev@vger.kernel.org, Rob <robertjmccabe@gmail.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> sending one patch was enough. no need to spam 5 times.

Gosh that's embarrassing.  I was having a difficult time sending the
patch (I'm new at patchwork-based development).
I'll submit a a new patch with your suggestion.
