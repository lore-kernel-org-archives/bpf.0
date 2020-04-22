Return-Path: <SRS0=w90l=6G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580E4C55185
	for <bpf@archiver.kernel.org>; Wed, 22 Apr 2020 12:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3837020857
	for <bpf@archiver.kernel.org>; Wed, 22 Apr 2020 12:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDVMgV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:36:21 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44814 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVMgV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Apr 2020 08:36:21 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jREbz-0000ox-TI; Wed, 22 Apr 2020 06:36:19 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jREbz-0006MT-03; Wed, 22 Apr 2020 06:36:19 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20200417064146.1086644-1-hch@lst.de>
        <20200417064146.1086644-5-hch@lst.de>
Date:   Wed, 22 Apr 2020 07:33:11 -0500
In-Reply-To: <20200417064146.1086644-5-hch@lst.de> (Christoph Hellwig's
        message of "Fri, 17 Apr 2020 08:41:44 +0200")
Message-ID: <87d07z4s54.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jREbz-0006MT-03;;;mid=<87d07z4s54.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/34tuHHASgF60MVP0xOvnRF+fIQ45pLt8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 4/6] sysctl: remove all extern declaration from sysctl.c
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Extern declarations in .c files are a bad style and can lead to
> mismatches.  Use existing definitions in headers where they exist,
> and otherwise move the external declarations to suitable header
> files.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/coredump.h |  6 ++++++
>  include/linux/file.h     |  2 ++
>  include/linux/mm.h       |  2 ++
>  include/linux/mmzone.h   |  2 ++
>  include/linux/sysctl.h   |  8 +++++++
>  kernel/sysctl.c          | 45 +++-------------------------------------
>  6 files changed, 23 insertions(+), 42 deletions(-)
>
> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> index abf4b4e65dbb..0fe8f3131e97 100644
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -22,4 +22,10 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
>  static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
>  #endif
>  
> +extern int core_uses_pid;
> +extern char core_pattern[];
> +extern unsigned int core_pipe_limit;
> +extern int pid_max;
> +extern int pid_max_min, pid_max_max;

These last two pid_max, pid_max_mind and pid_max_max would make more
sense in pid.h as they have nothing to do with coredumps.

> +
>  #endif /* _LINUX_COREDUMP_H */
