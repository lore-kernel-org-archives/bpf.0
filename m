Return-Path: <SRS0=M8wK=7X=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E476BC433DF
	for <bpf@archiver.kernel.org>; Wed, 10 Jun 2020 21:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C12F22072E
	for <bpf@archiver.kernel.org>; Wed, 10 Jun 2020 21:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFJVQq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:16:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55798 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgFJVQq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jun 2020 17:16:46 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj85Q-0006C2-8t; Wed, 10 Jun 2020 15:16:40 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jj85O-0001y2-Ko; Wed, 10 Jun 2020 15:16:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
        <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
        <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
        <87r1uo2ejt.fsf@x220.int.ebiederm.org>
        <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
Date:   Wed, 10 Jun 2020 16:12:29 -0500
In-Reply-To: <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Tue, 9 Jun 2020 16:56:31 -0700")
Message-ID: <87d066vd4y.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jj85O-0001y2-Ko;;;mid=<87d066vd4y.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/4KB3C4PHGOq6+Z4THQTaTzmVTsH2l44k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Jun 09, 2020 at 03:02:30PM -0500, Eric W. Biederman wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> 
>> > bpf_lsm is that thing that needs to load and start acting early.
>> > It's somewhat chicken and egg. fork_usermode_blob() will start a process
>> > that will load and apply security policy to all further forks and
>> > execs.
>> 
>> What is the timeframe for bpf_lsm patches wanting to use
>> fork_usermode_blob()?
>> 
>> Are we possibly looking at something that will be ready for the next
>> merge window?
>
> In bpf space there are these that want to use usermode_blobs:
> 1. bpfilter itself.
> First of all I think we made a mistake delaying landing the main patches:
> https://lore.kernel.org/patchwork/patch/902785/
> https://lore.kernel.org/patchwork/patch/902783/
> without them bpfilter is indeed dead. That probably was the reason
> no one was brave enough to continue working on it.
> So I think the landed skeleton of bpfilter can be removed.
> I think no user space code will notice that include/uapi/linux/bpfilter.h
> is gone. So it won't be considered as user space breakage.
> Similarly CONFIG_BPFILTER can be nuked too.
> bpftool is checking for it (see tools/bpf/bpftool/feature.c)
> but it's fine to remove it.
> I still think that the approach taken was a correct one, but
> lifting that project off the ground was too much for three of us.
> So when it's staffed appropriately we can re-add that code.
>
> 2. bpf_lsm.
> It's very active at the moment. I'm working on it as well
> (sleepable progs is targeting that), but I'm not sure when folks
> would have to have it during the boot. So far it sounds that
> they're addressing more critical needs first. "bpf_lsm ready at boot"
> came up several times during "bpf office hours" conference calls,
> so it's certainly on the radar. If I to guess I don't think
> bpf_lsm will use usermode_blobs in the next 6 weeks.
> More likely 2-4 month.
>
> 3. bpf iterator.
> It's already capable extension of several things in /proc.
> See https://lore.kernel.org/bpf/20200509175921.2477493-1-yhs@fb.com/
> Cat-ing bpf program as "cat /sys/fs/bpf/my_ipv6_route"
> will produce the same human output as "cat /proc/net/ipv6_route".
> The key difference is that bpf is all tracing based and it's unstable.
> struct fib6_info can change and prog will stop loading.
> There are few FIXME in there. That is being addressed right now.
> After that the next step is to make cat-able progs available
> right after boot via usermode_blobs.
> Unlike cases 1 and 2 here we don't care that they appear before pid 1.
> They can certainly be chef installed and started as services.
> But they are kernel dependent, so deploying them to production
> is much more complicated when they're done as separate rpm.
> Testing is harder and so on. Operational issues pile up when something
> that almost like kernel module is done as a separate package.
> Hence usermode_blob fits the best.
> Of course we were not planning to add a bunch of them to kernel tree.
> The idea was to add only _one_ such cat-able bpf prog and have it as
> a selftest for usermode_blob + bpf_iter. What we want our users to
> see in 'cat my_ipv6_route' is probably different from other companies.
> These patches will likely be using usermode_blob() in the next month.
>
> But we don't need to wait. We can make the progress right now.
> How about we remove bpfilter uapi and rename net/bpfilter/bpfilter_kern.c
> into net/umb/umb_test.c only to exercise Makefile to build elf file
> from simple main.c including .S with incbin trick
> and kernel side that does fork_usermode_blob().
> And that's it.
> net/ipv4/bpfilter/sockopt.c and kconfig can be removed.
> That would be enough base to do use cases 2 and 3 above.
> Having such selftest will be enough to adjust the layering
> for fork_usermode_blob(), right?

If I understand correctly you are asking people to support out of tree
code.  I see some justification for this functionality for in-tree code.
For out of tree code there really is no way to understand support or
maintain the code.

We probably also need to have a conversation about why this
functionality is a better choice that using a compiled in initramfs,
such as can be had by setting CONFIG_INITRAMFS_SOURCE.

Even with this write up and the conversations so far I don't understand
what problem fork_usermode_blob is supposed to be solving.  Is there
anything kernel version dependent about bpf_lsm?  For me the primary
justification of something like fork_usermode_blob is something that is
for all practical purposes a kernel module but it just happens to run in
usermode.

From what little I know about bpf_lsm that isn't the case.  So far all
you have mentioned is that bpf_lsm needs to load early.  That seems like
something that could be solved by a couple of lines init/main.c that
forks and exec's a program before init if it is present.  Maybe that
also needs a bit of protection so the bootloader can't override the
binary.

The entire concept of a loadable lsm has me scratching my head.  Last
time that concept was seriously looked at the races for initializing per
object data were difficult enough to deal with modular support was
removed from all of the existing lsms.

Not to mention there are places where the lsm hooks are a pretty lousy
API and will be refactored to make things better with no thought of any
out of tree code.

> If I understood you correctly you want to replace pid_t
> in 'struct umh_info' with proper 'struct pid' pointer that
> is refcounted, so user process's exit is clean? What else?

No "if (filename)" or "if (file)" on the exec code paths.  No extra case
for the LSM's to have to deal with.  Nothing fork_usermode_blob does is
something that can't be done from userspace as far as execve is
concerned so there is no justification for any special cases in the core
of the exec code.

Getting the deny_write_count and the reference count correct on the file
argument as well as getting BPRM_FLAGS_PATH_INACCESSIBLE set.

Using the proper type for argv and envp.

Those are the things I know of that need to be addressed.


Getting the code refactored so that the do_open_execat can be called
in do_execveat_common instead of __do_execve_file is enough of a
challenge of code motion I really would rather not do that.   Unfortunately that is
the only way I can see right now to have both do_execveat_common and
do_execve_file pass in a struct file.

Calling deny_write_access and get_file in do_execve_file and probably
a bit more is the only way I can see to cleanly isoloate the special
cases fork_usermode_blob brings to the table.


Strictly speaking I am also aware of the issue that the kernel has to
use set_fs(KERNEL_DS) to allow argv and envp to exist in kernel space
instead of userspace.  That needs to be fixed as well, but for all
kernel uses of exec.  So any work fixing fork_usermode_blob can ignore
that issue.

Eric



