Return-Path: <SRS0=rM0N=7W=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9DBC433DF
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 19:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B7C020734
	for <bpf@archiver.kernel.org>; Tue,  9 Jun 2020 19:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgFITzh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:55:37 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:55096 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbgFITzg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 15:55:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jikLI-0002de-Rp; Tue, 09 Jun 2020 13:55:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jikLH-0007mn-Qj; Tue, 09 Jun 2020 13:55:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
        <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
        <202006051903.C44988B@keescook>
        <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
        <20200606201956.rvfanoqkevjcptfl@ast-mbp>
        <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
        <20200607014935.vhd3scr4qmawq7no@ast-mbp>
        <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
        <20200608162027.iyaqtnhrjtp3vos5@ast-mbp.dhcp.thefacebook.com>
Date:   Tue, 09 Jun 2020 14:51:21 -0500
In-Reply-To: <20200608162027.iyaqtnhrjtp3vos5@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Mon, 8 Jun 2020 09:20:27 -0700")
Message-ID: <87zh9c2f2e.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jikLH-0007mn-Qj;;;mid=<87zh9c2f2e.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//a/XeTChYq2lFoREiqWGvWVA/Kef20IM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Jun 06, 2020 at 07:19:56PM -0700, Linus Torvalds wrote:
>> On Sat, Jun 6, 2020 at 6:49 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>> >>
>> > I'm not aware of execve issues. I don't remember being cc-ed on them.
>> > To me this 'lets remove everything' patch comes out of nowhere with
>> > a link to three month old patch as a justification.
>> 
>> Well, it's out of nowhere as far as bpf is concerned, but we've had a
>> fair amount of discussions about execve cleanups (and a fair amount of
>> work too, not just discussion) lately
>> 
>> So it comes out of "execve is rather grotty", and trying to make it
>> simpler have fewer special cases.
>> 
>> > So far we had two attempts at converting netfilter rules to bpf. Both ended up
>> > with user space implementation and short cuts.
>> 
>> So I have a question: are we convinced that doing this "netfilter
>> conversion" in user space is required at all?
>> 
>> I realize that yes, running clang is not something we'd want to do in
>> kernel space, that's not what I'm asking.
>> 
>> But how much might be doable at kernel compile time (run clang to
>> generate bpf statically when building the kernel) together with some
>> simplistic run-time parameterized JITting for the table details that
>> the kernel could do on its own without a real compiler?
>
> Right. There is no room for large user space application like clang
> in vmlinux. The idea for umh was to stay small and self contained.
> Its advantage vs kernel module is to execute with user privs
> and use normal syscalls to drive kernel instead of export_symbol apis.
>
> There are two things in this discussion. bpfilter that intercepting
> netfilter sockopt and elf file embedded into vmlinux that executes
> as user process.
> The pro/con of bpfilter approach is hard to argue now because
> bpfilter itself didn't materialize yet. I'm fine with removal of that part
> from the kernel, but I'm still arguing that 'embed elf into vmlinux'
> is necessary, useful and there is no alternative.
> There are builtin kernel modules. 'elf in vmlinux' is similar to that.
> The primary use case is bpf driven features like bpf_lsm.
> bpf_lsm needs to load many different bpf programs, create bpf maps, populate
> them, attach to lsm hooks to make the whole thing ready. That initialization of
> bpf_lsm is currently done after everything booted, but folks want it to be
> active much early. Like other LSMs.
> Take android for example. It can certify vmlinux, but not boot fs image.
> vmlinux needs to apply security policy via bpf_lsm during the boot.
> In such case 'embedded elf in vmlinux' would start early, do its thing
> via bpf syscall and exit. Unlike bpfilter approach it won't stay running.
> Its job is to setup all bpf things and quit.
> Theoretically we can do it as proper kernel module, but then it would mean huge
> refactoring of all bpf syscall commands to be accessible from the kernel module.
> It's simpler to embed elf into vmlinux and run it as user process doing normal
> syscalls. I can imagine that in other cases this elf executable would keep
> running after setup.
> It doesn't have to be bpf related. Folks thought they can do usb drivers
> running in user space and ready at boot. 'elf in vmlinux' would work as well.

To be 100% clear.  This is not a rejection of the concept of behind
fork_usermode_blob.

I see nothing fundamentally wrong with the concept and I have no problem
sorting out the details and remerging that code when it is ready.

If there is a user of fork_usermode_blob that it should be ready for the
next merge window let's keep the code, and let's come up with some clean
fixes to waiting for a process and for passing a struct file to exec.

If it is simply coming one of these days like moving usb drivers into
userspace let's come back to the concept when we have a user ready to
use it.  What exists today will still be in the git history for people
to find.

Eric

