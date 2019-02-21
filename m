Return-Path: <SRS0=c+SL=Q4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B6EC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 21:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5EC20818
	for <bpf@archiver.kernel.org>; Thu, 21 Feb 2019 21:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfBUVf2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:35:28 -0500
Received: from www62.your-server.de ([213.133.104.62]:39576 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBUVf2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Feb 2019 16:35:28 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gww06-0002xw-4C; Thu, 21 Feb 2019 22:35:26 +0100
Received: from [178.197.248.36] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gww05-000LNT-Uh; Thu, 21 Feb 2019 22:35:25 +0100
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org, ast@kernel.org
From:   Daniel Borkmann <daniel@iogearbox.net>
Subject: [LSF/MM TOPIC] BPF: various core topics
Message-ID: <0809ca3b-8a11-bf52-6578-0c0574d284ca@iogearbox.net>
Date:   Thu, 21 Feb 2019 22:35:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25367/Thu Feb 21 14:02:13 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF, various core topics:

I'd like to propose a discussion on a variety of BPF core topics that
I think would be valuable to further elaborate on with the crowd of
BPF kernel developers present at LSF/MM. Most of the mentioned below
are also related to how we use BPF in Cilium today and some of the
challenges that we'd like to tackle on kernel/loader side going forward:

- Support for tail calls in combination with BPF-to-BPF calls: the
  latter was also partially added back then with the thought that
  they would potentially supersede the former. In Cilium tail calls
  are used in various elaborate ways e.g. to jump into another local
  container's specific BPF policy program or to have it as an entry
  point in Cilium container's BPF fs to manage programs running in
  other application container/pods on the same node without switching
  namespaces. However, currently BPF-to-BPF calls are not supported
  in such setup and therefore all program code needs to be inlined
  preventing optimizing attached BPF programs to make them more
  icache friendly.

- Avoidance of expensive indirect calls by turning them into direct
  calls: in the face of retpolines, it would be desirable to further
  optimize indirect calls from BPF entry point and from tail calls
  by turning them into direct calls instead by borrowing idea of
  branch funnel into BPF, as one example. In particular XDP, but
  also tc BPF or other type of programs in the critical path could
  potentially benefit from this.

- Support for global data: at LPC'18 we performed initial experiments
  with global data variables and wrote an initial prototype as proof
  of concept. Main goal in context of Cilium is to avoid recompilation
  by putting configuration data into .data resp. .bss sections which
  can then be rewritten in the ELF file upon reconfiguration events,
  and to have the loader handle these relocations in i) user-space
  only for older kernels, ii) kernel- and user space. Discussion is
  revisited here and presents current progress in this area.

- Today there are several BPF ELF loaders in the wild. Most notably
  libbpf and the one in iproute2. While historically the former had
  focused on tracing use-cases, the latter was implemented for BPF
  networking programs (tc, XDP) and to allow quick adoption given
  libbpf was not widely distributed. In case of Cilium we rely on
  the object parsing from the latter. While today both support more
  recent BPF features like BPF-to-BPF calls or loading BTF etc, they
  differ in behavior in various other aspects, for example, ELF map
  representation, tail call loading, map pinning. Given the rapid
  feature growth in BPF kernel land and wider availability of
  libbpf, it would be desirable to revisit and have vast majority of
  loaders rely on libbpf in order to consolidate efforts and
  standardize on common format / conventions of the BPF ELF file.
  Additionally, it would also be desirable to add bindings for
  other languages such as golang.

- State of unprivileged BPF: currently most of the feature set of
  BPF in the kernel is available to privileged users only, basically
  resulting in a bigger feature split of BPF architecture. Discussion
  here presents current use-cases for unprivileged, lock-downs and
  mitigations (e.g. in terms of Spectre) as well as potential options
  for future work to allow more fine-grained use of otherwise only
  privileged features.

Thanks,
Daniel
