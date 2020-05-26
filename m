Return-Path: <SRS0=LuT0=7I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C2C433DF
	for <bpf@archiver.kernel.org>; Tue, 26 May 2020 21:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A33820870
	for <bpf@archiver.kernel.org>; Tue, 26 May 2020 21:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404366AbgEZVXZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 May 2020 17:23:25 -0400
Received: from www62.your-server.de ([213.133.104.62]:45872 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404259AbgEZVXZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 17:23:25 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jdh2h-0000tZ-9j; Tue, 26 May 2020 23:23:23 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jdh2h-000Fd5-2A; Tue, 26 May 2020 23:23:23 +0200
Subject: Re: [PATCH RESEND] libbpf: use .so dynamic symbols for abi check
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>
References: <20200525061846.16524-1-yauheni.kaliuta@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fc1cee19-4315-8ba8-e21b-67734995121b@iogearbox.net>
Date:   Tue, 26 May 2020 23:23:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200525061846.16524-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25824/Tue May 26 14:27:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/25/20 8:18 AM, Yauheni Kaliuta wrote:
> Since dynamic symbols are used for dynamic linking it makes sense to
> use them (readelf --dyn-syms) for abi check.
> 
> Found with some configuration on powerpc where linker puts
> local *.plt_call.* symbols into .so.
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
