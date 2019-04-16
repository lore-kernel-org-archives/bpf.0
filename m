Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55D2C10F14
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06952073F
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfDPI6m (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:58:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:36612 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPI6m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 04:58:42 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJRF-00069r-PT; Tue, 16 Apr 2019 10:27:33 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJRF-000Xcb-J4; Tue, 16 Apr 2019 10:27:33 +0200
Subject: Re: [PATCH bpf-next] bpf: fix whitespace for ENCAP_L2 defines in
 bpf.h
To:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        quentin.monnet@netronome.com, john.fastabend@gmail.com,
        rdna@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <1555068454-27894-1-git-send-email-alan.maguire@oracle.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2e9c59bb-edbe-ce00-ffd4-526d7661a29f@iogearbox.net>
Date:   Tue, 16 Apr 2019 10:27:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1555068454-27894-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25420/Mon Apr 15 09:57:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/12/2019 01:27 PM, Alan Maguire wrote:
> replace tab after #define with space in line with rest of definitions
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Applied, thanks!
