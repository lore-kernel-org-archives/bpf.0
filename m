Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E0EC433EF
	for <bpf@archiver.kernel.org>; Sat,  9 Oct 2021 12:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C1760F5D
	for <bpf@archiver.kernel.org>; Sat,  9 Oct 2021 12:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhJIMJK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 9 Oct 2021 08:09:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28907 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbhJIMJJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Oct 2021 08:09:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HRNwk2PDJzbn2P;
        Sat,  9 Oct 2021 20:02:46 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 9 Oct 2021 20:07:11 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 9 Oct 2021 20:07:10 +0800
Subject: Re: [PATCH bpf-next v5 0/3] add support for writable bare tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>, Hou Tao <hotforest@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Ingo Molnar <mingo@redhat.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>
References: <20211004094857.30868-1-hotforest@gmail.com>
 <20211004104629.668cadeb@gandalf.local.home>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <0147c4ea-773a-5fe9-dea5-edd16ad1db12@huawei.com>
Date:   Sat, 9 Oct 2021 20:07:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20211004104629.668cadeb@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Steven,

On 10/4/2021 10:46 PM, Steven Rostedt wrote:
> On Mon,  4 Oct 2021 17:48:54 +0800
> Hou Tao <hotforest@gmail.com> wrote:
>
>> The main idea comes from patchset "writable contexts for bpf raw
>> tracepoints" [1], but it only supports normal tracepoint with
>> associated trace event under tracefs. Now we have one use case
>> in which we add bare tracepoint in VFS layer, and update
>> file::f_mode for specific files. The reason using bare tracepoint
>> is that it doesn't form a ABI and we can change it freely. So
>> add support for it in BPF.
> Are the VFS maintainers against adding a trace event with just a pointer as
> an interface?
Not tried yet, but considering that VFS maintainer refused to have tracepoint in
VFS layer, I'm not sure it is worth trying.
>
> That is, it only gives you a pointer to what is passed in, but does not
> give you anything else to form any API against it.
> This way, not only does BPF have access to this information, so do the
> other tracers, through the new eprobe interface:
Or in a opposite way can eprobe add support for bare tracepoint ?
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation/trace?id=7491e2c442781a1860181adb5ab472a52075f393
>
> (I just realized we are missing updates to the Documentation directory).
>
> event probes allows one to attach to an existing trace event, and then
> create a new trace event that can read through pointers. It uses the same
> interface that kprobes has.
>
> Just adding trace events to VFS that only have pointers would allow all of
> BPF, perf and ftrace access as eprobes could then get the data you are
> looking for.
>
> -- Steve
> .

