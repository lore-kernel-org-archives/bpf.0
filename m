Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CEA130485
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255236; cv=none; b=HH/GSR5HiLY2M73YBcO1YV6cVlRrxeWS70eGehPcNuLfpsIJhsiuGjshHmC6csEPwyuOL6W0SF8FLQ3i/NcyfeQ8V4cjW+ZrKv6odqsw5XKDVTKAnDXIYPQNg9ZBowuzm0RK8s+05HEoXcMrVDrgEbFZUFOTWPSY5NcBQfeWuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255236; c=relaxed/simple;
	bh=fqjowcnx153YNfDrLfPJo6OP4+8bZ+DarJ9suHW8oqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncbjmaMdR9H7BnJRvRlIWka//Z4HsuXvDkl6R4BgW2jz8+9aM2ooIH1aRpcHGm6ysv1bTixQS13rXZ8LX/oD1+E1UH38kuBxDa7cNlgvej5KYsPJQ7OhVQdr5jLlfC6WeYEdU11vZpp3vEkX4+Yqi+nDyn5HzGqdHGmfWVcMoJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=WTyHV6H7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WTyHV6H7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0fa980d55so10628795ad.3
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1712255234; x=1712860034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4JiPL6I1aAxuHWxuu1AizOquC6OCNRn7bz4WD6eKOs=;
        b=WTyHV6H72cWzy00s9b3JwNu8bRkcOYWb4ujcTtW2fhCwwVZj4LQnm0opAY9X4sqsqo
         DA0P5IzcD96KCe5ltLYrhQE47qlyFnMD9CsouGcEvuvIvAQHM8mywmNBD6YUfWjhA14U
         uhiI5OsiP6jtMKubSCy5eyew1l/bow/zBmw8991mlOFXlm5hijUqX8zFe0ofNida1HgI
         AKGXReN6376uhmk8tcjg849kZR0Jh1tRLUT+5yahtkbdKPYH0NI+RYBSvJrqsAnJ4uV2
         1KGDCkqm5GVCvg1vcogx7vfekbxbZDQfehZZS7oqvgTBt56HVfq7+nkz7lLs89d2hNaD
         pmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255234; x=1712860034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4JiPL6I1aAxuHWxuu1AizOquC6OCNRn7bz4WD6eKOs=;
        b=ZcxnvFCtvvmFvbVODVYFgdwCzfZfF/jCXM7lFIVIS1V3Q2F50QZK7ylDtx9rqLByia
         9WJAmFWmacfQaL75ut7SrXv1E497jbbgJQclXhPb4FZN+6tnBvItvNydB2i3PByxOEfz
         lVDCogwSp1kDHkoBoV7lyhdo2oHF9OGwRnJfwoxlazDcohut2WmK24GICgI9s00c8iIf
         MU/FUU9V+Mfp5qxjyjJiA86Jpl/AYt5k8S0p/NGrRFzDzqJwJTOYdm4i5gHuvxh6N1kS
         ls+R9QVZ4zRvJSbro4NrCBGQCmay17j5xZFmsU0ljQye1pKCMTcsGM2fHz2T0eNvT8aj
         BCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6gnX8C5Kif/mrMyZPsDIhT6uFs/CZqD+u4UNEbQeZ//IhiiKqEgx218nn328aUMITiXxnj3Kxq/ztiXNzdiIbxzQh
X-Gm-Message-State: AOJu0YxzE94thZL4RDlw+Vk0eioNq2tHAmEAIW6oljEqmh0NufOnYvXg
	LgdWaQW3IaYjeIhApGtRGhx4frFyqSTxW+kEJo5ckNkOYq66MNcFBExtdG3lScY=
X-Google-Smtp-Source: AGHT+IGOMuDK+oKihVS/AKKsvvVi0EKz4LNZ6lVKbWSnfhCekLuquPo8IVCkbXMn0mcDfEDNnLXFBQ==
X-Received: by 2002:a17:902:d2c8:b0:1e0:f473:fd8b with SMTP id n8-20020a170902d2c800b001e0f473fd8bmr3559341plc.9.1712255233815;
        Thu, 04 Apr 2024 11:27:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001dc3916853csm15699882plg.73.2024.04.04.11.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:27:13 -0700 (PDT)
Date: Thu, 4 Apr 2024 11:27:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Luca Boccassi <bluca@debian.org>, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 bpf@vger.kernel.org
Subject: Re: vmlinux.h overlap/conflict with network protocol definitions
Message-ID: <20240404112710.25d4e99d@hermes.local>
In-Reply-To: <3ae7e58f-e62f-4d53-8b39-6e3fe1810014@linux.dev>
References: <20240404100901.7d6bc10f@hermes.local>
	<3ae7e58f-e62f-4d53-8b39-6e3fe1810014@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 11:16:32 -0700
Yonghong Song <yonghong.song@linux.dev> wrote:

> On 4/4/24 10:09 AM, Stephen Hemminger wrote:
> > I am fixing the use of TC BPF in DPDK to use libbpf and bpftool.
> > Luca recommended using vmlinux.h to address possible build and
> > CO:RE issues. But it won't work.
> >
> > There are missing pieces such as definitions of IPV6 next header
> > fields (in linux/ipv6.h) and TC actions.
> >
> > Without major hack surgery, not possible to use vmlinux.h instead.
> > Since vmlinux.h defines may things that overlap with other headers.
> >
> > Using:
> >
> > $ /usr/sbin/bpftool -V
> > bpftool v7.3.0
> > using libbpf v1.3
> > features:
> >
> > $ uname -r
> > 6.6.15-amd64
> >
> > The change to BPF program to use vmlinux is:
> >
> > diff --git a/drivers/net/tap/bpf/tap_rss.c b/drivers/net/tap/bpf/tap_rss.c
> > index 888b3bdc24..79f4ee31a1 100644
> > --- a/drivers/net/tap/bpf/tap_rss.c
> > +++ b/drivers/net/tap/bpf/tap_rss.c
> > @@ -2,12 +2,7 @@
> >    * Copyright 2017 Mellanox Technologies, Ltd
> >    */
> >   
> > -#include <linux/in.h>
> > -#include <linux/if_ether.h>
> > -#include <linux/ip.h>
> > -#include <linux/ipv6.h>
> > -#include <linux/pkt_cls.h>
> > -#include <linux/bpf.h>
> > +#include "vmlinux.h"
> >   
> >   #include <bpf/bpf_helpers.h>
> >   #include <bpf/bpf_endian.h>
> >
> > Resulting build failure is:
> >
> >
> > ~/DPDK/tap $ ninja -C build
> > ninja: Entering directory `build'
> > [1/33] Generating drivers/net/tap/bpf/tap_rss.bpf.o with a custom command
> > FAILED: drivers/net/tap/bpf/tap_rss.o
> > /usr/bin/clang -O2 -Wall -Wextra -DTAP_MAX_QUEUES=16 -target bpf -g -c -idirafter /usr/include -idirafter /usr/include/x86_64-linux-gnu ../drivers/net/tap/bpf/tap_rss.c -o drivers/net/tap/bpf/tap_rss.o
> > ../drivers/net/tap/bpf/tap_rss.c:116:8: error: use of undeclared identifier 'IPPROTO_HOPOPTS'
> >                  case IPPROTO_HOPOPTS:
> >                       ^
> > ../drivers/net/tap/bpf/tap_rss.c:117:8: error: use of undeclared identifier 'IPPROTO_ROUTING'
> >                  case IPPROTO_ROUTING:
> >                       ^
> > ../drivers/net/tap/bpf/tap_rss.c:118:8: error: use of undeclared identifier 'IPPROTO_DSTOPTS'
> >                  case IPPROTO_DSTOPTS:
> >                       ^
> > ../drivers/net/tap/bpf/tap_rss.c:126:8: error: use of undeclared identifier 'IPPROTO_FRAGMENT'
> >                  case IPPROTO_FRAGMENT:
> >                       ^
> > ../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
> >          if (skb->protocol == bpf_htons(ETH_P_IP))
> >                                         ^
> > ../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
> > ../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
> > ../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
> > ../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
> >          else if (skb->protocol == bpf_htons(ETH_P_IPV6))
> >                                              ^
> > ../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
> > ../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
> > ../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
> > ../drivers/net/tap/bpf/tap_rss.c:248:10: error: use of undeclared identifier 'TC_ACT_OK'
> >                  return TC_ACT_OK;
> >                         ^
> > ../drivers/net/tap/bpf/tap_rss.c:252:10: error: use of undeclared identifier 'TC_ACT_OK'
> >                  return TC_ACT_OK;
> >                         ^
> > ../drivers/net/tap/bpf/tap_rss.c:256:9: error: use of undeclared identifier 'TC_ACT_PIPE'
> >          return TC_ACT_PIPE;
> >                 ^
> > 15 errors generated.
> > ninja: build stopped: subcommand failed.  
> 
> This is a known issue as currently vmlinux.h does not support macros. 
> There are some efforts by Edward Zingerman to support this but this has 
> not done yet. At the same time, you could have a trivial header file 
> like 
> https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/progs/bpf_tracing_net.h 
> to be used for bpf program and then your bpf program with vmlinux.h can 
> have much easier CORE support.


That is an example of header surgery which I would rather avoid having to carry
as long term technical debt baggage.


