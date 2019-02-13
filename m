Return-Path: <SRS0=XKy9=QU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C5EC43381
	for <bpf@archiver.kernel.org>; Wed, 13 Feb 2019 21:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC27321872
	for <bpf@archiver.kernel.org>; Wed, 13 Feb 2019 21:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550094968;
	bh=6O0NJIiZoJeAw5Cpgq9y5kICWhwck93mXemcYcxMPto=;
	h=Date:From:To:Subject:List-ID:From;
	b=OQ8cGOe+BR5XkzIrQ9Cu+0N/cBuvR66+lZE20EnEXn7hhgA5eN7yvqKvyxFFh55g2
	 1/1gss3w8nkmlvVzQ3GXQRJh7UaZgoe/Qzx2J8cRk3nFrrEFd4SqPMX+Ak0a7Es2xs
	 0hmAqMRtHpX469Gg49YLH/zDjX6AePsN6u1FEc5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392295AbfBMV4I (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:56:08 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:51341 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388453AbfBMV4I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Feb 2019 16:56:08 -0500
Received: by mail-it1-f179.google.com with SMTP id y184so9764860itc.1
        for <bpf@vger.kernel.org>; Wed, 13 Feb 2019 13:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6O0NJIiZoJeAw5Cpgq9y5kICWhwck93mXemcYcxMPto=;
        b=AaCxb4fUYyMLLRY6KOkUk2kx5jfDtZKl//Uvy+42x3MiLN9sQ+h4/pLwzsscTtoGlB
         RdwM43zefrIb8tTI6/DG/tiI66ip8Zm5q/0aPr7NPFGKVoWgWRqdPyIQ1jMAJzCwlk7U
         FgmUNlfSldnNgWKonijAZQ1boVz/UfqZ+q6z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6O0NJIiZoJeAw5Cpgq9y5kICWhwck93mXemcYcxMPto=;
        b=SUHyYZBAIyn8ZK3INcUncSlCNg9T82lnqDqv1Wc2hmiFdHsEmI8/2i1AXh48l0yTGg
         l7PD9VXjqm6kMC+A99f0s34m0f7XpgO2geRX7l1NrXMb8LUSv0ySHBAhfPTyOTD9ftw8
         XzwX3jSDA9zibBbeNd1wS1B86vgOQfT1284tFjdEDYwlo2eKffTsSpSZJQs+ze/MDH8C
         J1GXLUjvgI05dN55PINgZtMc5KP9PlMoZa5z/TdnKMZT/iif4IRnlMhSDTtqwP9vL53K
         7QsRZwS/u+P8ajNE/BaL3/M6cWQ194D3DvrHw+5CAQgEKwRdjLCdCirSuBrAh5r6CIuL
         aZqw==
X-Gm-Message-State: AHQUAua7m0yusoU4qZo4tBakiVwZE/wi3p4kQ1i05zpTnSSqsdb27cnA
        zFn7OljytrbR3wbA6y6Grl0xeGh9WzGzkw==
X-Google-Smtp-Source: AHgI3IbKnGdBX6HGasdg+fBuI2msQmgUJ6Tx+IFfD+uX+TuYgIKS3OOhDcU1ZFi1JP0GoREjnKKggA==
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr215816itk.71.1550094967321;
        Wed, 13 Feb 2019 13:56:07 -0800 (PST)
Received: from chatter.qube.local ([184.75.214.131])
        by smtp.gmail.com with ESMTPSA id h14sm204469ior.41.2019.02.13.13.56.06
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:56:06 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:56:04 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     bpf@vger.kernel.org
Subject: Archiver test message, ignore
Message-ID: <20190213215604.GA20543@chatter.qube.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a test message for the lore.kernel.org archiver. Please ignore.

-K
