Return-Path: <SRS0=xPz+=SK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FB2C10F13
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA7920857
	for <bpf@archiver.kernel.org>; Mon,  8 Apr 2019 16:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ofu7aiGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDHQLA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:11:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57264 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfDHQLA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Apr 2019 12:11:00 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38G9EwJ009438;
        Mon, 8 Apr 2019 16:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=F4QG1s8Kx7ws0XV1EK389cHsed8N1K97YCQiXWZC7Z0=;
 b=Ofu7aiGXiZl7SkmWjmADOpNTwMybmPYJfjxzrj7eXmTU+lwC+5edUgfAfBMU/LuiMait
 0SH2eVbVWWki/fbOcFU39M0dH3gE52EUYawIvBo1OMuIP6wQKbx+n4gkmzajHfudVltU
 CbJYWYMu5qrqssIjifQAzkzm8hxRH3ASIjO8DYA6dUmOHn8vXCYbeL/Td6Jsm/XcZPtX
 yNHzYD5HLuTfS3UU5qoTbHBi0kyCPI5VHqNTn3GqjUV9O5ZsfkfIS/d9snJLZCYAGzX5
 KjHTAfWH36H2QPBSyGPMlijnaMpR+pdeeKhJPVcy4Qwx6bn0JcGkeCNgwjNf4ZcT4m/b rA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rphme7q58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 16:10:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x38GAPBm093443;
        Mon, 8 Apr 2019 16:10:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rph7s3exf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Apr 2019 16:10:55 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x38GAsgI006394;
        Mon, 8 Apr 2019 16:10:54 GMT
Received: from localhost (/10.159.211.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 09:10:54 -0700
Date:   Mon, 8 Apr 2019 12:10:52 -0400
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Cc:     Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [LSF/MM TOPIC] BPF: Extending eBPF as a generic tracing engine
Message-ID: <20190408161052.GC11622@oracle.com>
References: <20190223042412.GV25582@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223042412.GV25582@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904080131
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904080131
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I have not heard any reply to the topic I proosed for the BPF track?  Could
you please let me know by when notification can be expected on whether the
proposal is accepted or not?

	Cheers,
	Kris

On Fri, Feb 22, 2019 at 11:24:12PM -0500, Kris Van Hees wrote:
> Topic: Extending eBPF as a generic tracing engine
> 
> My presentation covers a few new features to the eBPF implementation in
> support of tracing tools.  The main goal is to allow tracing tools the
> ability to encode actions with probes/events, beyond the context of what
> the current probes/events provide.
> 
> The features to discuss are:
> 
>     - Allowing BPF-to-BPF tail-calling between BPF programs of different
>       program types (ussing a context conversion/casting mechanism that
>       BPF program types can provide.  This patch is being posted to the
>       netdev group this weekend, along with an example on how to use it.
>     - Using the context conversion mechanism to associate task info with
>       probe/event context, and have a BPF program operate on that, which
>       reduces the dependency (or need) for helper functions.
>     - Consider the option of having BPF program sub-types (for some program
>       types), which could even provide for loadable modules to implement
>       some specific extensions to a more generic BPF program type.
>     - Extending the context handling code and access checking to allow
>       for pointer references to auxilliary structs (to an arbitrary depth).
>       This makes it possible to do a lot more with contexts, such as
>       having it store a pointer to a trace output buffer so you can have
>       BPF instructions store to it directly.
> 
> The talk will focus on why this will help tracing a lot, and how it will
> advance BPF as a tracing facility.  I want to solicit feedback on these
> features so there can be common road forward to enhancing tracing based on
> BPF.
