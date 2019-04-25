Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7634AC43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878BB206BF
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfDYVEm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:04:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:49764 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfDYVEm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 17:04:42 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJlXr-0003Da-6L; Thu, 25 Apr 2019 23:04:39 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hJlXr-0008zP-0C; Thu, 25 Apr 2019 23:04:39 +0200
Subject: Re: [PATCH bpf v3 0/2] bpf: mark registers in all frames after
 pkt/null checks
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Paul Chaignon <paul.chaignon@orange.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Xiao Han <xiao.han@orange.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
References: <cover.1556127905.git.paul.chaignon@orange.com>
 <20190425204601.wbymvydzahiti4id@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e1cb783a-efd5-f972-5f8a-4db84a8a617b@iogearbox.net>
Date:   Thu, 25 Apr 2019 23:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190425204601.wbymvydzahiti4id@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25430/Thu Apr 25 09:58:44 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/25/2019 10:46 PM, Alexei Starovoitov wrote:
> On Wed, Apr 24, 2019 at 09:49:58PM +0200, Paul Chaignon wrote:
>> In case of a null check on a pointer inside a subprog, we should mark all
>> registers with this pointer as either safe or unknown, in both the current
>> and previous frames.  Currently, only spilled registers and registers in
>> the current frame are marked.  Packet bound checks in subprogs have the
>> same issue.  The first patch fixes it to mark registers in previous frames
>> as well.
[...]
>>
>> Changelogs:
>>   Changes in v3:
>>     - Fix same issue in find_good_pkt_pointers().
>>     - Add test case for find_good_pkt_pointers() issue.
>>     - Change title to account for the above change. Old title was
>>       "bpf: mark registers as safe or unknown in all frames".
>>     - Refactor find_good_pkt_pointers and mark_ptr_or_null_regs.

Sorry for the delay, looks good to me, thanks!

>>     - I did not keep Yonghong's ack because of the above changes.
>>   Changes in v2:
>>     - Fix example codes in commit message.
> 
> Applied to bpf tree, thanks!
> 

