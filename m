Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE064C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 01:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA83821925
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 01:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+QFe/Td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCWBAy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:00:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41174 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfCWBAy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 21:00:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so2598178pgb.8;
        Fri, 22 Mar 2019 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qvwdtIA+pQCMq9atQt7nUwd1SQz7RGMjmH14hBR6014=;
        b=o+QFe/Td6sLsG4vQ8soFa2llWnW46uLDKyA55EyNUgswTuTtjAgethhJHY3M4Jlpxn
         jOS1d60CdvVs50UFmYc7lq4poEx0xr0qKNy7j8jx8oU4JDL2dRqqBxi0RxU1mWbGBOCr
         M/IBeRB5YjD/vrypkoBYnx7l8bvEteovw7GVvsZHT+A3g9QI1nrByLgoQzgWgkZ3fyL9
         Rl1sF2S2PWppjBiu5J9+JmGDOm1RnydZreo9dRzYaRSZUh6SPjEetuyKk9M4Bleo6LOC
         UE9C86argGpg9lGkVhBTmOCxNFFEDQVYS24fVdnwSbS6k27v9Tv+nj9XKD/mrlVPVjrG
         2k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qvwdtIA+pQCMq9atQt7nUwd1SQz7RGMjmH14hBR6014=;
        b=GPeJwZ0JTVnK0HezzeoUzbtY2jQYud8TRR+L/tE4WJlgaiDRpdEmnyP1vDBYXdito9
         IpxaESly67p4XDSmlW1S2gudSLEW5YTeA+LqOrOLKoY16dtMnXJKYOYj3DptTkcI1wjc
         r7Gj6l6NUTFfN3NIpRbzPwNZgs3TxTRKmnnYcyNUE/52ilV7eCnUhkn90id+oKnJ7yRG
         PpQNicy4Xwsv51e7FZjwpUFsSl+EjT2ftav6fOamo3fhPLsknZ0mvmUw+6PM2UDfyL4Y
         jKp6Lk34mMARExFW/5/o9/+jYLNe4nNOBCS8yOtst/jiouCdFoWqqMDxsrw5FzRKUP8k
         dJTw==
X-Gm-Message-State: APjAAAWHQ1iVl6gBICxFgqTdam9eF69gtm4mVt4ZUNdHm1rf5w2yPoOE
        SYOG5hFtgD1FmqO051ELh0A=
X-Google-Smtp-Source: APXvYqzht0FYyN4xvvfuOFryMCZxhpgC3Vyo2/9OVEcDrN/46UD95tzxZV82YVRvQ3QZEuQ99zAgJA==
X-Received: by 2002:a63:31ce:: with SMTP id x197mr11848962pgx.69.1553302852982;
        Fri, 22 Mar 2019 18:00:52 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::e4e7])
        by smtp.gmail.com with ESMTPSA id h3sm17092638pfb.31.2019.03.22.18.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:00:52 -0700 (PDT)
Date:   Fri, 22 Mar 2019 18:00:50 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
Subject: Re: [RFC bpf-next v3 6/8] flow_dissector: handle no-skb use case
Message-ID: <20190323010049.dbywat3n6kfelwth@ast-mbp.dhcp.thefacebook.com>
References: <20190322195903.162516-1-sdf@google.com>
 <20190322195903.162516-7-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322195903.162516-7-sdf@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 22, 2019 at 12:59:01PM -0700, Stanislav Fomichev wrote:
> When called without skb, gather all required data from the
> __skb_flow_dissect's arguments and use recently introduces
> no-skb mode of bpf flow dissector.
> 
> Note: WARN_ON_ONCE(!net) will now trigger for eth_get_headlen users.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> +			struct bpf_flow_keys flow_keys;
> +			struct bpf_flow_dissector ctx = {
> +				.flow_keys = &flow_keys,
> +				.data = data,
> +				.data_end = data + hlen,
> +				.protocol = proto,
> +			};
> +
> +			if (skb) {
> +				ctx.skb = skb;
> +				ctx.protocol = skb->protocol;
> +				ctx.vlan_tci = skb->vlan_tci;
> +				ctx.vlan_proto = skb->vlan_proto;
> +				ctx.vlan_present = skb->vlan_present;
> +			}

are you suggesting to have vlan* fields that only work properly for skb case?
It means that progs/bpf_flow.c would not work as-is for eth_get_headlen.
And to have unified program that works in both cases the program would need to rely
on above internal implementation detail, like checking that ctx->protocol == 0 ?
imo that is worse than having two different flow dissector program types.

May be remove protocol and vlan* from ctx ?
Then the only thing program can do is look at the packet data which is
eth_get_headlen use case. For skb case the existence of vlan can be retrofitted into
dissector results by the kernel after the program finished.

