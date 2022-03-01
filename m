Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F70C433FE
	for <bpf@archiver.kernel.org>; Tue,  1 Mar 2022 16:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbiCAQeI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 1 Mar 2022 11:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbiCAQeH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 11:34:07 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE765FF3A;
        Tue,  1 Mar 2022 08:33:25 -0800 (PST)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nP5RE-000E24-0k; Tue, 01 Mar 2022 17:33:24 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nP5RD-000TCJ-Qj; Tue, 01 Mar 2022 17:33:23 +0100
Subject: Re: [PATCH bpf-next] bpf: test_run: Fix overflow in xdp frags
 bpf_test_finish
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>
References: <20220228232332.458871-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6a6333da-f282-09d2-fd2d-cb67e33a07a1@iogearbox.net>
Date:   Tue, 1 Mar 2022 17:33:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220228232332.458871-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26468/Tue Mar  1 10:31:38 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/1/22 12:23 AM, Stanislav Fomichev wrote:
> Syzkaller reports another issue:
> WARNING: CPU: 0 PID: 10775 at include/linux/thread_info.h:230
> check_copy_size include/linux/thread_info.h:230 [inline]
> WARNING: CPU: 0 PID: 10775 at include/linux/thread_info.h:230
> copy_to_user include/linux/uaccess.h:199 [inline]
> WARNING: CPU: 0 PID: 10775 at include/linux/thread_info.h:230
> bpf_test_finish.isra.0+0x4b2/0x680 net/bpf/test_run.c:171
> 
> This can happen when the userspace buffer is smaller than head+frags.
> Return ENOSPC in this case.
> 
> Fixes: 7855e0db150a ("bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature")
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Do we have a Reported-by tag for syzkaller so it can match against its report?

Thanks,
Daniel
