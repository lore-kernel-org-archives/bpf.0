Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2D8C636CC
	for <bpf@archiver.kernel.org>; Thu, 16 Feb 2023 03:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBPDPS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 15 Feb 2023 22:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBPDPR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 22:15:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6032FCCD;
        Wed, 15 Feb 2023 19:15:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A931B8238E;
        Thu, 16 Feb 2023 03:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB96BC433D2;
        Thu, 16 Feb 2023 03:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676517314;
        bh=SkTYB1myVSbqy2YH5q5kjvenigagS1i5+u22wEHO37I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ul51m5MwAqXBaV/sRf0ie4VIlmiKstrEtuHlZ85bYxYCd/o1kljzWlbXjgmTMrxQ7
         dhyXFrJlDCfTk4R3f/FC+jHrU86mHpLdyJeCkhvlF4AChQ8U8sgwvCesD8F1V6YptL
         6ioKDO9tPBMlo2gDoi4sXdkuVWn3QdgqnQCCSdXqTkCu4AhgWYNX45VP9I7X1fm1xj
         OTFkmmwzA+ylxgrcVOAbV+Nb/oY+GzjpRap9rS/plullo/2tdA5wseSBxoTzuMcJVV
         wwsI6sI9lhuFUb5mH9W6sFoo6lfIuENaGhDzm5yIceeOGVBqBtbOWGH38mSu4qTspg
         8PI/HI+mm1YQQ==
Date:   Wed, 15 Feb 2023 19:15:12 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tony Nguyen <anthony.l.nguyen@intel.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
        <intel-wired-lan@lists.osuosl.org>, <jesse.brandeburg@intel.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <magnus.karlsson@intel.com>, <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH intel-next v4 8/8] i40e: add support for XDP
 multi-buffer Rx
Message-ID: <20230215191512.569639f3@kernel.org>
In-Reply-To: <c78c5e12-1c5a-5215-812c-b10d4b892a1b@intel.com>
References: <20230215124305.76075-1-tirthendu.sarkar@intel.com>
        <20230215124305.76075-9-tirthendu.sarkar@intel.com>
        <Y+zxY07GZ8aI7LrV@lore-desk>
        <c78c5e12-1c5a-5215-812c-b10d4b892a1b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 15 Feb 2023 16:02:45 -0800 Tony Nguyen wrote:
> I believe you are planning on taking Lorenzo's ice [1] and i40e [2] 
> patch based on the comment of taking follow-ups directly [3]?
> 
> If so, Tirthendu, I'll rebase after this is pulled by netdev, then if 
> you can base on next-queue so everything will apply nicely.

Yup, applied now!
