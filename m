Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2709C433EF
	for <bpf@archiver.kernel.org>; Wed,  3 Nov 2021 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6736113B
	for <bpf@archiver.kernel.org>; Wed,  3 Nov 2021 18:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhKCSjF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:39:05 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59636 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhKCSjF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 14:39:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:56630)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1miL7b-00DM2D-Hu; Wed, 03 Nov 2021 12:36:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:53194 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1miL7a-0029m0-8a; Wed, 03 Nov 2021 12:36:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <YXrN+Hnl9pSOsWlA@arighi-desktop> <202110280955.B18CB67@keescook>
        <878rydm56l.fsf@disp2133> <202110281136.5CE65399A7@keescook>
        <8735okls76.fsf@disp2133> <202110290755.451B036CE9@keescook>
        <87y2665sf8.fsf@disp2133> <202111030838.CB201E4@keescook>
Date:   Wed, 03 Nov 2021 13:35:56 -0500
In-Reply-To: <202111030838.CB201E4@keescook> (Kees Cook's message of "Wed, 3
        Nov 2021 09:14:47 -0700")
Message-ID: <87v9193x4j.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1miL7a-0029m0-8a;;;mid=<87v9193x4j.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+0WoLFfWI4hGhEwAzgOXd2H2MNf3iKiEU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: selftests: seccomp_bpf failure on 5.15
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, Nov 02, 2021 at 01:22:19PM -0500, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > On Thu, Oct 28, 2021 at 05:06:53PM -0500, Eric W. Biederman wrote:
>> >> Kees Cook <keescook@chromium.org> writes:
>> >> 
>> >> > On Thu, Oct 28, 2021 at 12:26:26PM -0500, Eric W. Biederman wrote:
>> >> 
>> >> Is it a problem that the debugger can see the signal if the process does
>> >> not?
>> >
>> > Right, I'm trying to understand that too. However, my neighbor just lost
>> > power. :|
>> >
>> > What I was in the middle of checking was what ptrace "sees" going
>> > through a fatal SIGSYS; my initial debugging attempts were weird.
>> 
>> Kees have you regained power and had a chance to see my SA_IMMUTABLE
>> patch?
>
> Apologies; I got busy with other stuff, but I've tested this now. It's
> happy and I see the expected behaviors again. Note that I used the patch
> with this change:
>
> -#define SA_IMMUTABLE           0x008000000
> +#define SA_IMMUTABLE           0x00800000
>
> Tested-by: Kees Cook <keescook@chromium.org>

Thanks.

And I see you have written a test as well that should keep
this kind of bug from happening again.

Eric
