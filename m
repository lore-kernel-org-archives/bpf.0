Return-Path: <SRS0=dHw9=R2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8921C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8390B21925
	for <bpf@archiver.kernel.org>; Sat, 23 Mar 2019 00:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfCWAiY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:38:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:41948 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCWAiX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Mar 2019 20:38:23 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h7Ug1-0002UY-AA; Sat, 23 Mar 2019 01:38:21 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h7Ug1-000MpZ-2l; Sat, 23 Mar 2019 01:38:21 +0100
Subject: Re: [PATCH bpf 1/2] bpf, libbpf: fix version info and add it to
 shared object
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     ast@kernel.org, sdf@google.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190322234755.29306-1-daniel@iogearbox.net>
 <20190322234755.29306-2-daniel@iogearbox.net>
 <20190323000938.GV7431@mini-arch.hsd1.ca.comcast.net>
 <d3d082da-e542-036e-c545-6cde254cda3f@iogearbox.net>
 <20190323002812.GW7431@mini-arch.hsd1.ca.comcast.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <44ec7cbd-43fb-4363-7d8d-2e49ccb926e4@iogearbox.net>
Date:   Sat, 23 Mar 2019 01:38:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190323002812.GW7431@mini-arch.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25396/Fri Mar 22 08:52:29 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/23/2019 01:28 AM, Stanislav Fomichev wrote:
> On 03/23, Daniel Borkmann wrote:
>> On 03/23/2019 01:09 AM, Stanislav Fomichev wrote:
>>> On 03/23, Daniel Borkmann wrote:
>> [...]
>>>> +$(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
>>>> +	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_VERSION) \
>>> Shouldn't it be -soname,libbpf.so.$(VERSION) ?
>>
>> The above is generating libbpf.so.0.0.2, and with the below two we generate
>> symlinks to it. libbpf.so.$(VERSION) would result in libbpf.so.0 otherwise
>> which we want to be a symlink instead. The workflow I've been following is
>> similar to fe316723a810 ("tools lib traceevent: Add version for traceevent
>> shared object").
> Sorry, I was not clear enough, I was talking about -Wl,-soname linker option.
> Shouldn't it contain "major" version?
> 
> $ readelf -d libtraceevent.so.1.1.0 | grep SONAME
>  0x000000000000000e (SONAME)             Library soname: [libtraceevent.so.1]
> 
> With your patch applied:
> $ readelf -d libbpf.so.0.0.2 | grep SONAME
>  0x000000000000000e (SONAME)             Library soname: [libbpf.so.0.0.2]
> 
>                                                           ^^^^^^^^^^^^^
> 							  libbpf.so.0 ?

Heh, agree, good catch indeed. v2 coming.
