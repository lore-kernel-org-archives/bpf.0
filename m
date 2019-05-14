Return-Path: <SRS0=CEAn=TO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD1DC04AB4
	for <bpf@archiver.kernel.org>; Tue, 14 May 2019 04:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2763208C3
	for <bpf@archiver.kernel.org>; Tue, 14 May 2019 04:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfENE6k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 May 2019 00:58:40 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:57986 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfENE6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 May 2019 00:58:40 -0400
Subject: Re: bpf VM_FLUSH_RESET_PERMS breaks sparc64 boot
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "namit@vmware.com" <namit@vmware.com>
References: <4401874b-31b9-42a0-31bd-32bef5b36f2a@linux.ee>
 <b8493de00d9973f6f054814ed69d146b29207d3e.camel@intel.com>
 <102313756736cf8b34b36b1025102e2b75d16426.camel@intel.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <a30b1eac-4a98-de52-e381-91a7a59f8042@linux.ee>
Date:   Tue, 14 May 2019 07:58:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <102313756736cf8b34b36b1025102e2b75d16426.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> I'm having trouble getting Debian Buster up and running on qemu-system-
> sparc64 and so haven't been able to reproduce. Is this currently working for
> people?

I just reinstalled the machine from
https://cdimage.debian.org/cdimage/ports/2019-05-09/debian-10.0-sparc64-NETINST-1.iso
and there's a even newer build upe one directory level.

> This patch involves re-setting memory permissions when freeing executable
> memory. It looks like Sparc64 Linux doesn't have support for the set_memory_()
> functions so that part shouldn't be changing anything. The main other thing that
> is changed here is always doing a TLB flush in vfree when the BPF JITs are
> freed. It will already sometimes happen so that shouldn't be too different
> either.

That part I do not know.

> So it doesn't seem extra especially likely to cause a sparc specific problem
> that I can see. Is there any chance this is an intermittent issue?

So far it seemed 100% reproducible, at least in the bisect that led here.
The only variation I saw was if it just sat there for newer git snapshot or spew
out RCU and workqueue lockup warnings soon like I posed.

I can do some tests and boot the same kernel some more times.

-- 
Meelis Roos
