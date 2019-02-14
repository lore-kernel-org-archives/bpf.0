Return-Path: <SRS0=Lh3l=QV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC2FC43381
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 14:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8742229F
	for <bpf@archiver.kernel.org>; Thu, 14 Feb 2019 14:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550153306;
	bh=SANrmqaZIkvaEurcmazZUakydLRUw8HzZD4wuC6cS2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W5jLNgpfZ8f2PrAcveMivaen6amp+N1VdiTf6IYJWB8iRqr6Q7CMN4d9rK/q6N+bY
	 aNd5hKUBOW7VOjTGGz0HuXXdNE3Zpz9Zhz1jHY8pZpRTS5LAdbyAV+Jyc1WlvDipt3
	 h1WvdXPy14TbBwV+hh1ucyG9/3/Ui3ScXKjEOY+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390710AbfBNOIZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:08:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:57544 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389847AbfBNOIZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Feb 2019 09:08:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5329BACE3;
        Thu, 14 Feb 2019 14:08:23 +0000 (UTC)
Date:   Thu, 14 Feb 2019 15:08:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        bpf@vger.kernel.org,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ast@kernel.org
Subject: Re: [Lsf-pc] LSF/MM 2019: Call for Proposals (UPDATED!)
Message-ID: <20190214140822.GA7251@dhcp22.suse.cz>
References: <4f5a15c1-4f9e-acae-5094-2f38c8eebd96@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5a15c1-4f9e-acae-5094-2f38c8eebd96@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu 07-02-19 08:35:06, Jens Axboe wrote:
[...]
> 2) Requests to attend the summit for those that are not proposing a
> topic should be sent to:
> 
> 	lsf-pc@lists.linux-foundation.org
> 
> Please summarize what expertise you will bring to the meeting, and
> what you would like to discuss. Please also tag your email with
> [LSF/MM ATTEND] and send it as a new thread so there is less chance of
> it getting lost.

Just a reminder. Please do not forget to send the ATTEND request and
make it clear which track you would like to participate in the most.
It is quite common that people only send topic proposals without and
expclicit ATTEND request or they do not mention the track.

Thanks!
-- 
Michal Hocko
SUSE Labs
