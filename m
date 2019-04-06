Return-Path: <SRS0=Rhtb=SI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AADC10F06
	for <bpf@archiver.kernel.org>; Sat,  6 Apr 2019 10:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061E9213A2
	for <bpf@archiver.kernel.org>; Sat,  6 Apr 2019 10:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfDFK62 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 6 Apr 2019 06:58:28 -0400
Received: from www62.your-server.de ([213.133.104.62]:43996 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDFK62 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Apr 2019 06:58:28 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hCj1l-0002jQ-8T; Sat, 06 Apr 2019 12:58:25 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hCj1l-00029I-2R; Sat, 06 Apr 2019 12:58:25 +0200
Subject: Re: [PATCH bpf-next v4 01/16] bpf: implement lookup-free direct value
 access for maps
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        joe@wand.net.nz, yhs@fb.com, andrii.nakryiko@gmail.com,
        kafai@fb.com
References: <cover.1554497408.git.daniel@iogearbox.net>
 <777f5dda5ef99c1a1cb30dec46f64c1bc814552e.1554497408.git.daniel@iogearbox.net>
 <20190406015621.4yrcolqkweg3c2xy@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2389ce8e-55d4-226d-55f3-29190199bb8d@iogearbox.net>
Date:   Sat, 6 Apr 2019 12:58:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190406015621.4yrcolqkweg3c2xy@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25411/Sat Apr  6 09:53:04 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/06/2019 03:56 AM, Alexei Starovoitov wrote:
> On Fri, Apr 05, 2019 at 10:59:27PM +0200, Daniel Borkmann wrote:
>>  
>> -/* when bpf_ldimm64->src_reg == BPF_PSEUDO_MAP_FD, bpf_ldimm64->imm == fd */
>> +/* When BPF ldimm64's insn[0].src_reg != 0 then this can have
>> + * two extensions:
>> + *
>> + * insn[0].src_reg:  BPF_PSEUDO_MAP_FD   BPF_PSEUDO_MAP_VALUE
>> + * insn[0].imm:      map fd              map fd
>> + * insn[1].imm:      0                   offset into value
>> + * insn[0].off:      0                   lower 16 bit of map index
>> + * insn[1].off:      0                   higher 16 bit of map index
>> + * ldimm64 rewrite:  address of map      address of map[index]+offset
>> + * verifier type:    CONST_PTR_TO_MAP    PTR_TO_MAP_VALUE
> ...
>> +	else if (insn->src_reg == BPF_PSEUDO_MAP_VALUE)
>> +		snprintf(dd->scratch_buff, sizeof(dd->scratch_buff),
>> +			 "map[id:%u][%u]+%u", insn->imm,
>> +			 ((__u32)(__u16)insn[0].off) |
>> +			 ((__u32)(__u16)insn[1].off) << 16,
>> +			 (insn + 1)->imm);
> 
> Hopefully one last nit...
> Do we really need to allow this odd split index support?
> Later patches enforce array of 1 element and libbpf only uses that.
> This index feature feels too quirky and not really useful at this moment.
> Can we enforce that insn[0|1].off == 0 instead ?
> Later we can extend it to mean index without breaking anything.

I originally didn't have it in v2 of the series, but I ended up
implementing it after feedback from Andrii back then complaining
that it's too specific and not generic enough. I agreed with him
that the limitation of max_elems = 1 wasn't too nice, so I went
to implement that full 32 bit index can be used thus that it has
the potential of efficient map lookup replacement for array maps in
general which is quite nice since within single insn it allows to
select index and offset into value all as simple 64 bit imm load.

Thanks,
Daniel
