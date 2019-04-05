Return-Path: <SRS0=rZCH=SH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDEAC4360F
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 02:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CA4206DF
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 02:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POtEVwma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfDECcH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 22:32:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33590 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfDECcH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 22:32:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id i19so2411394pfd.0;
        Thu, 04 Apr 2019 19:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X/RcvfeihAEHnIX0rMeXDaPhJrQo03KNmi5ZbNwVdbA=;
        b=POtEVwmaVecUba8V9ey5x91K7O6wg977B+dsAlU6/2+QDzVPnlOcG0gDQ71aWMFIff
         DPObPy65O2g1Ij6DwUkr98nPq+mU5MLj2VL9G8rWpmCTF2uQiZWUmZADZxPyA9dtgK+X
         0lgVW629wyi0i/sPk3qxBfALtnxDMdlMeCptDv3v9CdIYIuwaACpNkTO3nktm05BWAOS
         mXBXRvZ9xeB9pCxxeGXFGZ5htIyzed7baVfqA0g9BwCWnoZz87ajkzeuWalGFLTGZq2g
         xxPgEp0HjimalyiBZ6zS/CEc6TClCWIISITZ/7L4uDHGcpY953zCRCpWER1ZvQXSzW9v
         fIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X/RcvfeihAEHnIX0rMeXDaPhJrQo03KNmi5ZbNwVdbA=;
        b=uE56hjc8aJGDDmN8/sdNkZy6IRFvST4kR65C8Bcgx/EUmb8emTk0IGrHfuKwuv6S8a
         MBy2ayHIm58mKUKUlVNKcnjtPuTtql+BOYafEcaTFI/xD2ikyQlBcIXnytltf5VXvBo+
         XP+VI3lsAvlm99wOJdGAEk1143v78JWnbAY8/PDh2fT30ONnRiSWk5feeJjNED/RJm3E
         8Jg2uq/XL2W+6oOUFhKzYkS4uMoakfsFvt8ynt3hVxBXYsB1ofJIjW7lC2X4zM/120Zl
         5KlcLCayPSbAROVj0RJ6/T14+eLIefkXnz68ea0b/tUfo8nCQ07CrIpFihvt2var6MuC
         bLAw==
X-Gm-Message-State: APjAAAWxR2HJCO6g1BzMSEnZNOiVvSZ3sMA/nDXcvI5JtD0NNhoEKeSg
        Jm7S3/3tlyjfQQzESjDaLvU=
X-Google-Smtp-Source: APXvYqxTRU/oABZSPd2wweTa49DY0OSTuvFSwH/EkUocXOWE/eIjjaP/TVKS/YzPeFXld+t6D0NxEQ==
X-Received: by 2002:a65:64cf:: with SMTP id t15mr9136594pgv.322.1554431526498;
        Thu, 04 Apr 2019 19:32:06 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:c5a1:6d6:d92c:c7c1? ([2601:282:800:fd80:c5a1:6d6:d92c:c7c1])
        by smtp.googlemail.com with ESMTPSA id d15sm30266849pfo.34.2019.04.04.19.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 19:32:05 -0700 (PDT)
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
To:     Peter Oskolkov <posk@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Peter Oskolkov <posk@posk.io>
References: <20190403154338.29990-1-posk@google.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <89f72dd4-a3d8-3788-482b-578e18b7078d@gmail.com>
Date:   Thu, 4 Apr 2019 20:32:03 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190403154338.29990-1-posk@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/3/19 9:43 AM, Peter Oskolkov wrote:
> This patch adds tests validating that VRF and BPF-LWT
> encap work together well, as requested by David Ahern.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
>  .../selftests/bpf/test_lwt_ip_encap.sh        | 134 +++++++++++-------
>  1 file changed, 86 insertions(+), 48 deletions(-)
> 

I hit a wall with running this script. One problem is the different
versions of nc for debian (stretch to be specific), and another problem
is commands failing it is hard to figure out why (e.g., connect failures
which seem like route lookup problems). I have been adding run_cmd and
PAUSE_ON_FAIL options similar to what is in fib_tests.sh and the change
I sent for pmtu.sh, but I have not finished.

I am traveling tomorrow and not sure how much time I'll get this weekend
to come back to this. Might be early next week.
