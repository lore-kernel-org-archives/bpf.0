Return-Path: <SRS0=D5ks=S4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3E9C43219
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 22:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EB6206E0
	for <bpf@archiver.kernel.org>; Fri, 26 Apr 2019 22:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcpYq0FP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfDZWku (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:40:50 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:34037 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfDZWkt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Apr 2019 18:40:49 -0400
Received: by mail-qt1-f177.google.com with SMTP id j6so5987271qtq.1
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2019 15:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y4/+q9dFH2P4indRi/AfhEV7U3/CbSXDwP8xhX77U0Q=;
        b=qcpYq0FP/FMc+F5JC76Vuk0+6fcD6GISwH/oLM5yaoZocM7gur1qCCpAIK1EqeN9LJ
         gWPKvBE7NUaX8YrygEmBKc4qeDNfqiQa79Dpxn66+ZUBvKK7Ba6Uj+Hmi9MLXDh8fsJc
         VBsYtA9VHOcgOm1kPOyG/KGT19/wVPfe9xqDco/CgEFYRmj8fZNSBHBiHGKimhJVs7M9
         7ZHuUzwqmiqvSGGtlTk+EBgpnx1R/nh1wICic/egbGdpIJ/wW/iGlsdH0lAl8V9FY7/h
         v2Y8Qv6J2asK44cgvjtfPb22PL9FY/K31Im9RnXLN3Y9b4lIZxvbuvmr+1p8UezfzBDS
         aWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y4/+q9dFH2P4indRi/AfhEV7U3/CbSXDwP8xhX77U0Q=;
        b=FfK6HHdmEaW1uvbY1oclc/evlhEUvTMJgD0kntlzEBgz36yrb1X81hSWPR6YdkYQ4A
         JpW/iS0wMvTwYbWf6hqhQ6N33gckn+TbWA8I03pDyg63XFdPQs1PJQ8cyas4QzkMhPwm
         JsN7eCIXHb5uudRxj3d27ZBED2JyERx+k5j+d0gD1ghMjmpHVpsB+K0cbkJQmdeAoLlY
         CYbdK/I0Z9njs3RRJlxLsrWEiWvgPUeWDrkLh9JCBFuQn+4xVS7vX0dAHgF06AdHht7E
         jvObGVsUsXLYQqvHd6MG1ChBAkSJF+YI25iy50Wf3rmcnte9W8KijT7+XvymnD1ortQS
         HZNw==
X-Gm-Message-State: APjAAAU6OabCIxn/byoAJi47nqaVIYsjHC5BI95T+vg2ES0tWheieBjf
        LHQIrwGcDDC98x8yF91/eLjtco5w
X-Google-Smtp-Source: APXvYqyF45s9rCyZ+dfGkwtuG7u3iE4RxykwaxQHhZNzytFInuQalN4n44FkNhSmm94J3wmgc1obpA==
X-Received: by 2002:ac8:169b:: with SMTP id r27mr24479270qtj.235.1556318447878;
        Fri, 26 Apr 2019 15:40:47 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id g50sm3452441qtg.83.2019.04.26.15.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 15:40:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 845EF4111F; Fri, 26 Apr 2019 19:40:42 -0300 (-03)
Date:   Fri, 26 Apr 2019 19:40:42 -0300
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: perf BPF annotation output validation
Message-ID: <20190426224042.GA7857@kernel.org>
References: <20190426183707.GE23426@kernel.org>
 <6F8B5202-17A9-48B8-AEC2-FB116EC6F74F@fb.com>
 <20190426192611.GA28586@kernel.org>
 <1e4d3cad-70d1-bcc2-611c-f32d4d299099@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e4d3cad-70d1-bcc2-611c-f32d4d299099@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Apr 26, 2019 at 08:51:09PM +0000, Yonghong Song escreveu:
> On 4/26/19 12:26 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Apr 26, 2019 at 07:11:37PM +0000, Song Liu escreveu:
> >>> On Apr 26, 2019, at 11:37 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >>>
> >>> tldr; more to the end there are some annotation for all sorts of cache level
> >>> misses trying to validate the 'perf annotation' output for disassembled
> >>> BPF programs.
> >>>
> >>> [root@quaco ~]# uname -a
> >>> Linux quaco 5.1.0-rc5+ #4 SMP Wed Apr 17 19:33:00 -03 2019 x86_64 x86_64 x86_64 GNU/Linux
> >>>
> >>> Running perf trace with:
> >>>
> >>> [root@quaco ~]# cat ~/.perfconfig
> >>> [llvm]
> >>> 	dump-obj = true
> >>> 	clang-opt = -g
> >>> [trace]
> >>> 	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c
> >>> 	#add_events = /wb/augmented_raw_syscalls.o
> >>> 	show_zeros = yes
> >>> 	show_duration = no
> >>> 	no_inherit = yes
> >>> 	show_timestamp = no
> >>> 	show_arg_names = no
> >>> 	args_alignment = 40
> >>> 	show_prefix = yes
> >>>
> >>> [annotate]
> >>>
> >>> 	hide_src_code = false
> >>> [root@quaco ~]#
> >>>
> >>> clang/llvm 9:
> >>>
> >>> [root@quaco perf]# eu-readelf -winfo /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o | grep compile_unit
> >>> [     b]  compile_unit         abbrev: 1
> >>> [root@quaco perf]# eu-readelf -winfo /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o | grep compile_unit -B1 -A10
> >>> Version: 4, Abbreviation section offset: 0, Address size: 8, Offset size: 4
> >>> [     b]  compile_unit         abbrev: 1
> >>>            producer             (strp) "clang version 9.0.0 (https://urldefense.proofpoint.com/v2/url?u=https-3A__git.llvm.org_git_clang.git_&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=dR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=8ymLhVNE6vfRn0KCyz7xlPkm7i1H4ttMrMYmeHEP1Cg&s=3_k_sPaZo7mwxQMoYhgd4hBUmCoS3TboKrw15yws6mA&e= 7906282d3afec5dfdc2b27943fd6c0309086c507) (https://urldefense.proofpoint.com/v2/url?u=https-3A__git.llvm.org_git_llvm.git_&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=dR8692q0_uaizy0jkrBJQM5k2hfm4CiFxYT8KaysFrg&m=8ymLhVNE6vfRn0KCyz7xlPkm7i1H4ttMrMYmeHEP1Cg&s=jutQ4xaAa5FePXthz5gHAgdx6kVlrPI64pnpqWWt59Q&e= a1b5de1ff8ae8bc79dc8e86e1f82565229bd0500)"
> >>>            language             (data2) C99 (12)
> >>>            name                 (strp) "/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c"
> >>>            stmt_list            (sec_offset) 0
> >>>            comp_dir             (strp) "/root"
> >>>            low_pc               (addr) raw_syscalls:sys_enter+000000000000000000 <sys_enter>
> >>>            ranges               (sec_offset) range list [     0]
> >>> [    2a]    variable             abbrev: 2
> >>>              name                 (strp) "__augmented_syscalls__"
> >>>              type                 (ref4) [    3f]
> >>> [root@quaco perf]#
> >>>
> >>> I then leave  this running doing system wide syscall tracing using that
> >>> augmented_raw_syscalls.c eBPF program hooked into the syscall enter and
> >>> exit tracepoints, so that I have something to profile and further test
> >>> the BPF support in perf top/annotate/report (slides for LSFMM anyone?
> >>> :-)) then I get:
> >>>
> >>> # perf trace -a sleep 100h
> >>
> >> wow, I never tried to run sleep with "100h". ;-)
> > 
> > This is me dreaming of the long night sleeps I don't have for about 3.3
> > years by now ;-)
> >   
> >>> <SNIP>
> >>> tmux: server/11597 ioctl(8</dev/ptmx>, TIOCLINUX, 0x7ffe1b49abf8) = 0
> >>> tmux: server/11597 readv(8, 0x7ffe1b49ac00, 1)             = 101
> >>> tmux: server/11597 ioctl(8</dev/ptmx>, TIOCSPGRP, 0x7ffe1b49a9f4) = 0
> >>> tmux: server/11597 openat(AT_FDCWD, "/proc/30339/cmdline", O_RDONLY) = 5
> >>> tmux: server/11597 fstat(5, 0x7ffe1b49a8e0)                = 0
> >>> tmux: server/11597 read(5, 0x5571aaeb2c10, 1024)           = 10
> >>> tmux: server/11597 close(5)                                = 0
> >>> gnome-shell/19195  ... [continued]: ioctl())              = 0
> >>> tmux: server/11597 poll(0x5571aad38e50, 6, 11997)       ...
> >>> gnome-shell/19195 ioctl(11</dev/dri/card0>, DRM_MODE_RMFB, 0x7ffc2129c25c) = 0
> >>> gnome-shell/19195 recvmsg(39<socket:[18671390]>, 0x7ffc2129c440, NONE) = -1 EAGAIN (Resource temporarily unavailable)
> >>> <SNIP>
> >>>
> >>> With that running, I do:
> >>>
> >>> [root@quaco perf]# perf record -a sleep 2s
> >>> [ perf record: Woken up 1 times to write data ]
> >>> [ perf record: Captured and wrote 1.647 MB perf.data (3698 samples) ]
> >>> [root@quaco perf]#
> >>>
> >>> I.e. collect 2 seconds worth of CPU cycles samples, system wide.
> >>>
> >>> [root@quaco perf]# perf record -a sleep 2s
> >>> [ perf record: Woken up 1 times to write data ]
> >>> [ perf record: Captured and wrote 2.328 MB perf.data (17764 samples) ]
> >>> [root@quaco perf]# perf report --header-only perf.data | grep -i b[pt]f
> >>> # event : name = cycles, , id = { 266608, 266609, 266610, 266611, 266612, 266613, 266614, 266615 }, size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|CPU|PERIOD, read_format = ID, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
> >>> # bpf_prog_info 13: bpf_prog_7be49e3934a125ba addr 0xffffffffc0437f01 size 229
> >>> # bpf_prog_info 14: bpf_prog_2a142ef67aaad174 addr 0xffffffffc04393cd size 229
> >>> # bpf_prog_info 17: bpf_prog_7be49e3934a125ba addr 0xffffffffc052ca3c size 229
> >>> # bpf_prog_info 18: bpf_prog_2a142ef67aaad174 addr 0xffffffffc0531218 size 229
> >>> # bpf_prog_info 21: bpf_prog_7be49e3934a125ba addr 0xffffffffc0cb8010 size 229
> >>> # bpf_prog_info 22: bpf_prog_2a142ef67aaad174 addr 0xffffffffc0cba8be size 229
> >>> # bpf_prog_info 65: bpf_prog_7be49e3934a125ba addr 0xffffffffc03f6bc2 size 229
> >>> # bpf_prog_info 66: bpf_prog_2a142ef67aaad174 addr 0xffffffffc03f87f6 size 229
> >>> # bpf_prog_info 125: bpf_prog_819967866022f1e1_sys_enter addr 0xffffffffc0c6e5a1 size 381
> >>> # bpf_prog_info 126: bpf_prog_c1bd85c092d6e4aa_sys_exit addr 0xffffffffc0c953a8 size 191
> >>> [root@quaco perf]#
> >>>
> >>> So everything seems in order, but then:
> >>>
> >>> [root@quaco perf]# perf report | grep bpf_prog
> >>>      0.14%  perf             bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
> >>>      0.08%  gnome-terminal-  bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
> >>>      0.06%  perf             bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
> >>>      0.04%  gnome-terminal-  bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
> >>>      0.01%  alsa-sink-ALC25  bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
> >>>      0.01%  Web Content      bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
> >>>      0.01%  lvmetad          bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
> >>>      0.00%  alsa-sink-ALC25  bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
> >>>      0.00%  sssd_kcm         bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
> >>>      0.00%  gnome-shell      bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
> >>>      0.00%  firefox          bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
> >>>      0.00%  weechat          bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
> >>>      0.00%  WebExtensions    bpf_prog_c1bd85c092d6e4aa_sys_exit   [k] bpf_prog_c1bd85c092d6e4aa_sys_exit
> >>>      0.00%  Timer            bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
> >>>      0.00%  Web Content      bpf_prog_819967866022f1e1_sys_enter  [k] bpf_prog_819967866022f1e1_sys_enter
> >>> [root@quaco perf]#
> >>>
> >>> Ok, lets check that bpf_prog_819967866022f1e1_sys_enter symbol, 38% of
> >>> the samples at just at that %rbp, more in a previous run...
> >>>
> >>> [root@quaco perf]# perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter
> >>> Samples: 25  of event 'cycles', 4000 Hz, Event count (approx.): 7248318, [percent: local period]
> >>> bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
> >>> 38.00         push   %rbp
> >>>
> >>>   2.72         mov    %rsp,%rbp
> >>>                sub    $0x170,%rsp
> >>> 13.19         sub    $0x28,%rbp
> >>>   3.30         mov    %rbx,0x0(%rbp)
> >>> 20.33         mov    %r13,0x8(%rbp)
> >>>                mov    %r14,0x10(%rbp)
> >>>                mov    %r15,0x18(%rbp)
> >>>                xor    %eax,%eax
> >>>                mov    %rax,0x20(%rbp)
> >>>                mov    %rdi,%rbx
> >>> 13.34       → callq  *ffffffffd359487f
> >>>                mov    %eax,-0x148(%rbp)
> >>>
> >>> So I ended up trying with a event group to check what could be that:
> >>>
> >>> [root@quaco perf]# perf record -a -e '{cycles,instructions,cache-misses}' sleep 2s
> >>> [ perf record: Woken up 18 times to write data ]
> >>> [ perf record: Captured and wrote 6.619 MB perf.data (91964 samples) ]
> >>> [root@quaco perf]# perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter
> >>> Samples: 314  of events 'anon group { cycles, instructions, cache-misses }', 4000 Hz, Event count (approx.): 118106063, [percent: local period]
> >>> bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
> >>> 20.88  24.58  49.11         push   %rbp
> >>>
> >>> 47.37  31.62  26.71         mov    %rsp,%rbp
> >>>   1.16   0.00   0.00         sub    $0x170,%rsp
> >>>                              sub    $0x28,%rbp
> >>>   0.58   2.48   0.00         mov    %rbx,0x0(%rbp)
> >>>   7.10   5.92   0.00         mov    %r13,0x8(%rbp)
> >>>   0.51   0.96   7.96         mov    %r14,0x10(%rbp)
> >>>   0.00   1.10   0.00         mov    %r15,0x18(%rbp)
> >>>   0.58   0.00   0.00         xor    %eax,%eax
> >>>                              mov    %rax,0x20(%rbp)
> >>>   2.39   0.85   0.00         mov    %rdi,%rbx
> >>>   0.58   1.96   0.00       → callq  *ffffffffd359487f
> >>>                              mov    %eax,-0x148(%rbp)
> >>>   2.88   0.89   3.50         mov    %rbp,%rsi
> >>>                              add    $0xfffffffffffffeb8,%rsi
> >>>
> >>> So seems ok? I.e. that big cost at right the start of the BPF program is
> >>> just cache pressure, probably, right?
> >>>
> >>>
> >>> [root@quaco perf]# perf record -a -e '{L1-icache-load-misses,L1-dcache-load-misses}' sleep 2s
> >>> [ perf record: Woken up 14 times to write data ]
> >>> [ perf record: Captured and wrote 5.557 MB perf.data (72026 samples) ]
> >>> [root@quaco perf]# perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter
> >>> Samples: 376  of events 'anon group { L1-icache-load-misses, L1-dcache-load-misses }', 4000 Hz, Event count (approx.): 3715276, [percent: local p>
> >>> bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
> >>>   1.54  63.01         push   %rbp
> >>>
> >>> 53.09  28.13         mov    %rsp,%rbp
> >>>   0.58   0.00         sub    $0x170,%rsp
> >>>   0.00   0.55         sub    $0x28,%rbp
> >>>   6.96   0.00         mov    %rbx,0x0(%rbp)
> >>> 10.25   0.00         mov    %r13,0x8(%rbp)
> >>>   0.73   0.00         mov    %r14,0x10(%rbp)
> >>>   3.04   0.00         mov    %r15,0x18(%rbp)
> >>>
> >>> Looks like. furthermore:
> >>>
> >>> [root@quaco perf]# perf record -a -e '{L1-icache-load-misses,L1-dcache-load-misses,dTLB-load-misses,iTLB-load-misses}' sleep 2s
> >>> [ perf record: Woken up 21 times to write data ]
> >>> [ perf record: Captured and wrote 7.708 MB perf.data (112323 samples) ]
> >>> [root@quaco perf]# perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter
> >>> Samples: 391  of events 'anon group { L1-icache-load-misses, L1-dcache-load-misses, dTLB-load-misses, iTLB-load-misses }', 4000 Hz, Event count (>
> >>> bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
> >>>   1.98  64.42 100.00  13.66         push   %rbp
> >>>
> >>> 50.79  23.91   0.00  82.23         mov    %rsp,%rbp
> >>>                                     sub    $0x170,%rsp
> >>>   0.24   0.00   0.00   0.00         sub    $0x28,%rbp
> >>>   7.73   0.00   0.00   0.00         mov    %rbx,0x0(%rbp)
> >>> 11.13   0.44   0.00   0.00         mov    %r13,0x8(%rbp)
> >>>                                     mov    %r14,0x10(%rbp)
> >>>   1.64   0.46   0.00   0.00         mov    %r15,0x18(%rbp)
> >>>
> >>> Do these numbers look sane to you guys?
> >>
> >>  From my experiments, mov is often the top time consumer. But
> >>
> >>     mov %rsp,%rbp
> >>
> >> is a little weird. It does not access cache, right?
> > 
> > Right, but its like the code for bpf_prog_819967866022f1e1_sys_enter is
> > being sucked into L1 icache at that point, no?
> 
> do you need to enable pebs (precise event-based sampling)?

So, when you don't specify a event, 'perf record' will use cycles:P,
which is the highest level of (PEBS, on x86) precision available. But
then that has some limitations, I'll try to check this later, to see if
cache events can be counted that way, how many events, etc.

But I think that knowing that is on the first or second instruction is
enough, i.e. it seems that somehow the eBPF program is not staying in
the CPU cache all the time, which ends up making transferring control
to them cause cache misses?

That was the reason for my message, to validate if this is the case or
if the BPF perf annotation or sample address resolution are buggy.

> >>> Song, I also noticed that source code is not being intermixed for the
> >>> --stdio annotation, while it works, to some degree, for '--tui', i.e.
> >>> when you do 'perf top', press '/bpf' to show just symbols with that
> >>> substring and then press enter or 'A' to annotate, we can see the
> >>> original C source code for the BPF program, but it is mangling the
> >>> screen sometimes, I need to try and fix, please take a look if you have
> >>> the time.
> >>
> >> I will take a look at this, most likely after LSFMM.
> > 
> > mmkay
> >   
> >>> Also things like the callq targets need some work to tell what function
> >>> is that, which as I said isn't appearing on the --stdio2 output, but
> >>> appears on the --tui, i.e. we need to resolve that symbol to check how
> >>> to map back to a BPF helper or any othe callq target.
> >   
> >> I am aware of missing callq symbol. I was thinking they are less critical
> >> with source code.
> > 
> > Some people dislikes intermixing C and assembly, Linus is one, IIRC, so
> > if we can augment the assembly resolving those addresses to the helper,
> > that would be best.
> >   
> >>> Also, what about those 'je 0', i.e. the target is being misinterpreted
> >>> or is this some BPF construct I should've know about? :)
> >>
> >> I didn't notice the je 0 before. Let me try reproduce it.
> 
> Did you see these `je 0` when you use bpftool dump jited instructions?
> With dumping source annotated jited/xlated instructions, you can get 
> rough idea where this `je 0` is coming from. Want to give a try?

So, here is a fresh record:

[root@quaco ~]# perf annotate --stdio2 bpf_prog_819967866022f1e1_sys_enter
Samples: 40  of event 'cycles', 4000 Hz, Event count (approx.): 12152834, [percent: local period]
bpf_prog_819967866022f1e1_sys_enter() bpf_prog_819967866022f1e1_sys_enter
 69.13         push   %rbp

               mov    %rsp,%rbp
               sub    $0x170,%rsp
               sub    $0x28,%rbp
 19.07         mov    %rbx,0x0(%rbp)
  2.08         mov    %r13,0x8(%rbp)
               mov    %r14,0x10(%rbp)
               mov    %r15,0x18(%rbp)
               xor    %eax,%eax
               mov    %rax,0x20(%rbp)
               mov    %rdi,%rbx
             → callq  *ffffffffd356dda0
  3.03         mov    %eax,-0x148(%rbp)
               mov    %rbp,%rsi
               add    $0xfffffffffffffeb8,%rsi
               movabs $0xffff9d5b7133a400,%rdi

  1.17       → callq  *ffffffffd356f050
               cmp    $0x0,%rax
             → je     0
               add    $0x38,%rax
               xor    %r13d,%r13d
               cmp    $0x0,%rax
             → jne    0
               mov    %rbp,%rdi
               add    $0xfffffffffffffeb8,%rdi
               mov    $0x40,%esi
               mov    %rbx,%rdx
             → callq  *ffffffffd354e490
               mov    %rbp,%rsi
               add    $0xfffffffffffffec0,%rsi
               movabs $0xffff9d5b6fe1e000,%rdi

[root@quaco ~]#

Plus the bpf prog dump jit, we're probably just parsing 32-bits, the
zeroed part...

[root@quaco ~]# bpftool prog | tail -6
129: tracepoint  name sys_enter  tag 819967866022f1e1  gpl
	loaded_at 2019-04-26T19:31:10-0300  uid 0
	xlated 528B  jited 381B  memlock 4096B  map_ids 119,118,117
130: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
	loaded_at 2019-04-26T19:31:10-0300  uid 0
	xlated 256B  jited 191B  memlock 4096B  map_ids 119,118
[root@quaco ~]# bpftool prog dump jit id 129
0xffffffffc0c95080:
   0:	push   %rbp
   1:	mov    %rsp,%rbp
   4:	sub    $0x170,%rsp
   b:	sub    $0x28,%rbp
   f:	mov    %rbx,0x0(%rbp)
  13:	mov    %r13,0x8(%rbp)
  17:	mov    %r14,0x10(%rbp)
  1b:	mov    %r15,0x18(%rbp)
  1f:	xor    %eax,%eax
  21:	mov    %rax,0x20(%rbp)
  25:	mov    %rdi,%rbx
  28:	callq  0xffffffffd356dda0
  2d:	mov    %eax,-0x148(%rbp)
  33:	mov    %rbp,%rsi
  36:	add    $0xfffffffffffffeb8,%rsi
  3d:	movabs $0xffff9d5b7133a400,%rdi
  47:	callq  0xffffffffd356f050
  4c:	cmp    $0x0,%rax
  50:	je     0x0000000000000056
  52:	add    $0x38,%rax
  56:	xor    %r13d,%r13d
  59:	cmp    $0x0,%rax
  5d:	jne    0x0000000000000164
  63:	mov    %rbp,%rdi
  66:	add    $0xfffffffffffffeb8,%rdi
  6d:	mov    $0x40,%esi
  72:	mov    %rbx,%rdx
  75:	callq  0xffffffffd354e490
  7a:	mov    %rbp,%rsi
  7d:	add    $0xfffffffffffffec0,%rsi
  84:	movabs $0xffff9d5b6fe1e000,%rdi
  8e:	add    $0xd0,%rdi
  95:	mov    0x0(%rsi),%eax
  98:	cmp    $0x200,%rax
  9f:	jae    0x00000000000000aa
  a1:	shl    $0x3,%rax
  a5:	add    %rdi,%rax
  a8:	jmp    0x00000000000000ac
  aa:	xor    %eax,%eax
  ac:	cmp    $0x0,%rax
  b0:	je     0x0000000000000164
  b6:	movzbq 0x0(%rax),%rdi
  bb:	cmp    $0x0,%rdi
  bf:	je     0x0000000000000164
  c5:	mov    $0x40,%r8d
  cb:	mov    -0x140(%rbp),%rdi
  d2:	cmp    $0x2,%rdi
  d6:	je     0x00000000000000e7
  d8:	cmp    $0x101,%rdi
  df:	je     0x00000000000000ed
  e1:	cmp    $0x15,%rdi
  e5:	jne    0x0000000000000140
  e7:	mov    0x10(%rbx),%rdx
  eb:	jmp    0x00000000000000f1
  ed:	mov    0x18(%rbx),%rdx
  f1:	cmp    $0x0,%rdx
  f5:	je     0x0000000000000140
  f7:	xor    %edi,%edi
  f9:	mov    %edi,-0x104(%rbp)
  ff:	mov    %rbp,%rdi
 102:	add    $0xffffffffffffff00,%rdi
 109:	mov    $0x100,%esi
 10e:	callq  0xffffffffd354e520
 113:	mov    $0x148,%r8d
 119:	mov    %eax,-0x108(%rbp)
 11f:	mov    %rax,%rdi
 122:	shl    $0x20,%rdi
 126:	shr    $0x20,%rdi
 12a:	cmp    $0xff,%rdi
 131:	ja     0x0000000000000140
 133:	add    $0x48,%rax
 137:	and    $0xff,%rax
 13d:	mov    %rax,%r8
 140:	mov    %rbp,%rcx
 143:	add    $0xfffffffffffffeb8,%rcx
 14a:	mov    %rbx,%rdi
 14d:	movabs $0xffff9d58126aac00,%rsi
 157:	mov    $0xffffffff,%edx
 15c:	callq  0xffffffffd354eb60
 161:	mov    %rax,%r13
 164:	mov    %r13,%rax
 167:	mov    0x0(%rbp),%rbx
 16b:	mov    0x8(%rbp),%r13
 16f:	mov    0x10(%rbp),%r14
 173:	mov    0x18(%rbp),%r15
 177:	add    $0x28,%rbp
 17b:	leaveq 
 17c:	retq   

[root@quaco ~]# 

 
> > 
> > Ok!
> >   
> >> Thanks,
> >> Song
> >>
> >>>
> >>>   2.68   0.00   0.00   0.00         mov    %rdi,%rbx
> >>>                                   → callq  *ffffffffd359487f
> >>>                                     mov    %eax,-0x148(%rbp)
> >>>   9.61   0.00   0.00   0.00         mov    %rbp,%rsi
> >>>                                     add    $0xfffffffffffffeb8,%rsi
> >>>                                     movabs $0xffff9d556c776c00,%rdi
> >>>
> >>>                                   → callq  *ffffffffd3595b2f
> >>>                                     cmp    $0x0,%rax
> >>>                                   → je     0
> >>>   0.00   1.25   0.00   0.00         add    $0x38,%rax
> >>>   0.80   0.21   0.00   0.00         xor    %r13d,%r13d
> >>>                                     cmp    $0x0,%rax
> >>>                                   → jne    0
> >>>                                     mov    %rbp,%rdi
> >>>                                     add    $0xfffffffffffffeb8,%rdi
> >>>
> >>> - Arnaldo
> >>
> > 

-- 

- Arnaldo
