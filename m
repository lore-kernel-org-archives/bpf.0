Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B964C433F5
	for <bpf@archiver.kernel.org>; Thu, 18 Nov 2021 21:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51DF661248
	for <bpf@archiver.kernel.org>; Thu, 18 Nov 2021 21:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhKRWBS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:01:18 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36338 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhKRWBM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 17:01:12 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:46794)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnpQ2-00115C-O4; Thu, 18 Nov 2021 14:58:10 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:52636 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnpQ1-0048Wm-LN; Thu, 18 Nov 2021 14:58:10 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
        <202111171049.3F9C5F1@keescook>
        <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
        <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
        <87k0h6334w.fsf@email.froward.int.ebiederm.org>
        <202111171341.41053845C3@keescook>
        <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
        <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
        <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
        <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
        <202111171728.D85A4E2571@keescook>
Date:   Thu, 18 Nov 2021 15:58:02 -0600
In-Reply-To: <202111171728.D85A4E2571@keescook> (Kees Cook's message of "Wed,
        17 Nov 2021 17:32:20 -0800")
Message-ID: <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnpQ1-0048Wm-LN;;;mid=<87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX188U8Ali6pt3gI0MiWxDnFXisSnqx50bZA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 0/2] SA_IMMUTABLE fixes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


SA_IMMUTABLE fixed issues with force_sig_seccomp and the introduction
for force_sig_fatal where the exit previously could not be interrupted
but now it can.  Unfortunately it added that behavior to all force_sig
functions under the right conditions which debuggers usage of SIG_TRAP
and debuggers handling of SIGSEGV.

Solve that by limiting SA_IMMUTABLE to just the cases that historically
debuggers have not been able to intercept.

The first patch changes force_sig_info_to_task to take a flag
that requests which behavior is desired.

The second patch adds force_exit_sig which replaces force_fatal_sig
in the cases where historically userspace would only find out about
the ``signal'' after the process has exited.

The first one with the hunk changing force_fatal_sig removed should be
suitable for backporting to v5.15. v5.15 does not implement
force_fatal_sig.

This should be enough to fix the regressions.

Kyle if you can double check me that I have properly fixed these issues
that would be appreciated.

Any other review or suggestions to improve the names would be
appreciated.  I think I have named things reasonably well but I am very
close to the code so it is easy for me to miss things.

Eric W. Biederman (2):
      signal: Don't always set SA_IMMUTABLE for forced signals
      signal: Replace force_fatal_sig with force_exit_sig when in doubt

 arch/m68k/kernel/traps.c              |  2 +-
 arch/powerpc/kernel/signal_32.c       |  2 +-
 arch/powerpc/kernel/signal_64.c       |  4 ++--
 arch/s390/kernel/traps.c              |  2 +-
 arch/sparc/kernel/signal_32.c         |  4 ++--
 arch/sparc/kernel/windows.c           |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/kernel/vm86_32.c             |  2 +-
 include/linux/sched/signal.h          |  1 +
 kernel/entry/syscall_user_dispatch.c  |  4 ++--
 kernel/signal.c                       | 36 ++++++++++++++++++++++++++++-------
 11 files changed, 42 insertions(+), 19 deletions(-)

Eric
