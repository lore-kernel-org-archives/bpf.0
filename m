Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16769C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 21:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC0C2082A
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDIVoO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:44:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:56004 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfDIVoO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 17:44:14 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDyXJ-0002zD-Ob; Tue, 09 Apr 2019 23:44:09 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDyXJ-0003FV-Ct; Tue, 09 Apr 2019 23:44:09 +0200
Subject: Re: [PATCH bpf-next] libbpf: fix crash in XDP socket part with new
 larger BPF_LOG_BUF_SIZE
To:     Magnus Karlsson <magnus.karlsson@intel.com>, bjorn.topel@intel.com,
        ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <1554814174-28765-1-git-send-email-magnus.karlsson@intel.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5efdf57f-7746-edfc-25a2-6f768a493747@iogearbox.net>
Date:   Tue, 9 Apr 2019 23:44:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1554814174-28765-1-git-send-email-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/09/2019 02:49 PM, Magnus Karlsson wrote:
> In commit da11b417583e ("libbpf: teach libbpf about log_level bit 2"),
> the BPF_LOG_BUF_SIZE was increased to 16M. The XDP socket part of
> libbpf allocated the log_buf on the stack, but for the new 16M buffer
> size this is not going to work. Change the code to allocate the
> log_buf using malloc instead. If the allocation fails, we go ahead and
> load the program without a log buffer.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

For these few 17 insn, wouldn't it make more sense to rather shrink the
log buffer size? malloc'ing 16M seems like overkill for the tiny program.
I don't think there is a specific need to stick with BPF_LOG_BUF_SIZE.
Why not simplifying it like the following where we also don't need to
cope will allocation failure, for example:

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 8d0078b..557ef8d 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -259,7 +259,8 @@ int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area, __u64 size,

 static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 {
-       char bpf_log_buf[BPF_LOG_BUF_SIZE];
+       static const int log_buf_size = 16 * 1024;
+       char log_buf[log_buf_size];
        int err, prog_fd;

        /* This is the C-program:
@@ -308,10 +309,10 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
        size_t insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);

        prog_fd = bpf_load_program(BPF_PROG_TYPE_XDP, prog, insns_cnt,
-                                  "LGPL-2.1 or BSD-2-Clause", 0, bpf_log_buf,
-                                  BPF_LOG_BUF_SIZE);
+                                  "LGPL-2.1 or BSD-2-Clause", 0, log_buf,
+                                  log_buf_size);
        if (prog_fd < 0) {
-               pr_warning("BPF log buffer:\n%s", bpf_log_buf);
+               pr_warning("BPF log buffer:\n%s", log_buf);
                return prog_fd;
        }

Thanks,
Daniel
