Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A1812AAE7
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250546; cv=none; b=oHbrGprS2thdY9cIEYm1l9bnWwRChXOYXthFcDZhiZRKN8lLAVSmYN+9uVzeC+m6pZeDaku8X2ryXSQhOMXNcjUJs3JQ/UoASGZjVs6uxH27Ub+IIzbEn20bL1/nQtyyn7HUqWkoAnMs+GU3HHHHvwmySi970ZR0Z1YvQxSpn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250546; c=relaxed/simple;
	bh=WaOvUncTjCn8T5oJ6JRCqB8SSpkY4S6OhMdnaT1WRes=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LZX6hEYP84hTcWTcelcmvxQW6NEsY9HcGdTNqidayhEZ3UBrw6GrtZRAA7dJr0miQhVu/499oUoioth5o1jTHuCZH6aGg5mBvyGtA9/Q46c9p+jFqZ09srFMGdlkhiL/jjvyqaAv/JPFZfCytsqJ4KLgqVvQpLkX30vJpYQTIZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=kvp410ai; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="kvp410ai"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1058308a12.3
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1712250543; x=1712855343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DyyWv5I8a4FTIJsGj3htzy5SyG2P3r2f3ShqutFtzk=;
        b=kvp410aiccO3R8OzwwXTtPuSnSeEz6uyiFC5WyZl4rOl1RoupRfohr1p4bEQRePWrN
         DZH9dyVXCtJOeji634pGx7zRk/MwZXT36CgugC7sLPvgcV7oWnmYL6FcacCKODIVXmC+
         b2jlCpmpq+CMXDGqhNyRhBxC+Snq64YxBTZQ3Ti/jZcgv1qbEj3Q1YUZqqGgQa1/qSl9
         aeYMRkHBtMqUM0rhQKwueO8HacxRDbTUXYfAU9HIxGfM/ViBdK4eYf6VSXHfR6rr3XJZ
         7OyAFiROMjkh9Qq326vCUhUiRcagjcijLQP75mrPMoiQmPjT0yAR8a/nJR2B6yqKYGOL
         yy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712250543; x=1712855343;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DyyWv5I8a4FTIJsGj3htzy5SyG2P3r2f3ShqutFtzk=;
        b=WtHVzqDx4UADNBgGBNNk3ujuxWd2VALFQzYXBtL0oKY+zrqI2Lx2RJ2d48I/yfIWsW
         vXlrP1/XrNtKaj+cNIRfEUtmd5zHtHla1ywMvN4KBU9cQu/GOixtvzq3md+Qg+vr8xRE
         pEoh87gZCCpNaqaql8qY9Aj4u6pFt1Rq0CrAAupKjw42YP7/pSYWn5IZ6T+kIGUA5R3E
         oQZn9CFreT1uxuEldsmrm2Zb83v/EvrVPjjaQcJWPaK4N1Ah2liucSvasx2ZxPZplOCe
         tJ/Q6e99sNyUiKBULROfSg0REioKyshypXBUC0XCk3+yUuzr8jv2DGzSbZEzN18scN9J
         ueFg==
X-Gm-Message-State: AOJu0YyygIRziPpZ5iFwD7Z6T16q3TAGRtxP4q9EXCZ2atcK/znuQRrM
	j0b+xFYaPdwp60dbJVUy4xLkXq4FhkEHdwGAsXX0Kzob+Vuan06gbclLiSRFZlc=
X-Google-Smtp-Source: AGHT+IExNcrsP4RuisMnyd6WugSPb4sJeEvCgLW1ylWCIzKoKLmdGMyOX4awk4dgqVMDf3OyWxKpbA==
X-Received: by 2002:a17:90b:1993:b0:2a2:b2e2:da14 with SMTP id mv19-20020a17090b199300b002a2b2e2da14mr3025223pjb.30.1712250543647;
        Thu, 04 Apr 2024 10:09:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id qn3-20020a17090b3d4300b002a0383de8cfsm1778376pjb.38.2024.04.04.10.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 10:09:03 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:09:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Luca Boccassi <bluca@debian.org>, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com
Cc: bpf@vger.kernel.org
Subject: vmlinux.h overlap/conflict with network protocol definitions
Message-ID: <20240404100901.7d6bc10f@hermes.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I am fixing the use of TC BPF in DPDK to use libbpf and bpftool.
Luca recommended using vmlinux.h to address possible build and
CO:RE issues. But it won't work.

There are missing pieces such as definitions of IPV6 next header
fields (in linux/ipv6.h) and TC actions.

Without major hack surgery, not possible to use vmlinux.h instead.
Since vmlinux.h defines may things that overlap with other headers.

Using:

$ /usr/sbin/bpftool -V
bpftool v7.3.0
using libbpf v1.3
features:

$ uname -r
6.6.15-amd64

The change to BPF program to use vmlinux is:

diff --git a/drivers/net/tap/bpf/tap_rss.c b/drivers/net/tap/bpf/tap_rss.c
index 888b3bdc24..79f4ee31a1 100644
--- a/drivers/net/tap/bpf/tap_rss.c
+++ b/drivers/net/tap/bpf/tap_rss.c
@@ -2,12 +2,7 @@
  * Copyright 2017 Mellanox Technologies, Ltd
  */
 
-#include <linux/in.h>
-#include <linux/if_ether.h>
-#include <linux/ip.h>
-#include <linux/ipv6.h>
-#include <linux/pkt_cls.h>
-#include <linux/bpf.h>
+#include "vmlinux.h"
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>

Resulting build failure is:


~/DPDK/tap $ ninja -C build
ninja: Entering directory `build'
[1/33] Generating drivers/net/tap/bpf/tap_rss.bpf.o with a custom command
FAILED: drivers/net/tap/bpf/tap_rss.o 
/usr/bin/clang -O2 -Wall -Wextra -DTAP_MAX_QUEUES=16 -target bpf -g -c -idirafter /usr/include -idirafter /usr/include/x86_64-linux-gnu ../drivers/net/tap/bpf/tap_rss.c -o drivers/net/tap/bpf/tap_rss.o
../drivers/net/tap/bpf/tap_rss.c:116:8: error: use of undeclared identifier 'IPPROTO_HOPOPTS'
                case IPPROTO_HOPOPTS:
                     ^
../drivers/net/tap/bpf/tap_rss.c:117:8: error: use of undeclared identifier 'IPPROTO_ROUTING'
                case IPPROTO_ROUTING:
                     ^
../drivers/net/tap/bpf/tap_rss.c:118:8: error: use of undeclared identifier 'IPPROTO_DSTOPTS'
                case IPPROTO_DSTOPTS:
                     ^
../drivers/net/tap/bpf/tap_rss.c:126:8: error: use of undeclared identifier 'IPPROTO_FRAGMENT'
                case IPPROTO_FRAGMENT:
                     ^
../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
        if (skb->protocol == bpf_htons(ETH_P_IP))
                                       ^
../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
../drivers/net/tap/bpf/tap_rss.c:210:33: error: use of undeclared identifier 'ETH_P_IP'
../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
        else if (skb->protocol == bpf_htons(ETH_P_IPV6))
                                            ^
../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
../drivers/net/tap/bpf/tap_rss.c:212:38: error: use of undeclared identifier 'ETH_P_IPV6'
../drivers/net/tap/bpf/tap_rss.c:248:10: error: use of undeclared identifier 'TC_ACT_OK'
                return TC_ACT_OK;
                       ^
../drivers/net/tap/bpf/tap_rss.c:252:10: error: use of undeclared identifier 'TC_ACT_OK'
                return TC_ACT_OK;
                       ^
../drivers/net/tap/bpf/tap_rss.c:256:9: error: use of undeclared identifier 'TC_ACT_PIPE'
        return TC_ACT_PIPE;
               ^
15 errors generated.
ninja: build stopped: subcommand failed.
