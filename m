Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC845C001B5
	for <bpf@archiver.kernel.org>; Fri,  2 Sep 2022 15:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiIBPaW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Sep 2022 11:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiIBPaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 11:30:03 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748151DA49;
        Fri,  2 Sep 2022 08:08:11 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU8HB-00011S-MS; Fri, 02 Sep 2022 17:08:09 +0200
Received: from [85.1.206.226] (helo=linux-4.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oU8HB-000Sv5-GY; Fri, 02 Sep 2022 17:08:09 +0200
Subject: Re: [PATCH bpf-next v3 1/2] Add subdir support to Documentation
 makefile
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20220829091500.24115-1-donald.hunter@gmail.com>
 <20220829091500.24115-2-donald.hunter@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3d08894c-b3d1-37e8-664e-48e66dc664ac@iogearbox.net>
Date:   Fri, 2 Sep 2022 17:08:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220829091500.24115-2-donald.hunter@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26646/Fri Sep  2 09:55:25 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/29/22 11:14 AM, Donald Hunter wrote:
> Run make in list of subdirs to build generated sources and migrate
> userspace-api/media to use this instead of being a special case.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Jonathan, given this touches Documentation/Makefile, could you ACK if
it looks good to you? Noticed both patches don't have doc: $subj prefix,
but that's something we could fix up.

Maybe one small request, would be nice to build Documentation/bpf/libbpf/
also with every BPF CI run to avoid breakage of program_types.csv. Donald
could you check if feasible? Follow-up might be ok too, but up to Andrii.

Thanks,
Daniel
