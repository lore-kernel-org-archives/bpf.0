Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1DBC10F0B
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884B020643
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDCSeQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:34:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDCSeP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 14:34:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BF813164699;
        Wed,  3 Apr 2019 18:34:10 +0000 (UTC)
Received: from carbon (ovpn-200-46.brq.redhat.com [10.40.200.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B54566B2C9;
        Wed,  3 Apr 2019 18:34:04 +0000 (UTC)
Date:   Wed, 3 Apr 2019 20:34:03 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     brouer@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        simon.horman@netronome.com, willemb@google.com,
        peterpenkov96@gmail.com
Subject: Re: [PATCH bpf 5/5] flow_dissector: document BPF flow dissector
 environment
Message-ID: <20190403203403.4b6d135d@carbon>
In-Reply-To: <20190401205734.4400-6-sdf@google.com>
References: <20190401205734.4400-1-sdf@google.com>
        <20190401205734.4400-6-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 03 Apr 2019 18:34:15 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon,  1 Apr 2019 13:57:34 -0700
Stanislav Fomichev <sdf@google.com> wrote:

> diff --git a/Documentation/networking/bpf_flow_dissector.txt b/Documentation/networking/bpf_flow_dissector.txt
> new file mode 100644
> index 000000000000..513be8e20afb
> --- /dev/null
> +++ b/Documentation/networking/bpf_flow_dissector.txt

It looks like you use the RST format, but you use suffix .txt and not .rst.

If you don't know, these files get rendered on:
 https://www.kernel.org/doc/html/latest/bpf/index.html

And GitHub also render this stuff e.g.
 https://github.com/torvalds/linux/blob/master/Documentation/bpf/bpf_devel_QA.rst
 

> @@ -0,0 +1,115 @@
> +==================
> +BPF Flow Dissector
> +==================
> +
> +Overview
> +========
> +
> +Flow dissector is a routine that parses metadata out of the packets. It's
> +used in the various places in the networking subsystem (RFS, flow hash, etc).
> +
> +BPF flow dissector is an attempt to reimplement C-based flow dissector logic
> +in BPF to gain all the benefits of BPF verifier (namely, limits on the
> +number of instructions and tail calls).
> +
> +API
> +===
> +


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
