Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BEDC433FE
	for <bpf@archiver.kernel.org>; Wed, 26 Oct 2022 10:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJZKDX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 26 Oct 2022 06:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiJZKDQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 06:03:16 -0400
Received: from mx.der-flo.net (mx.der-flo.net [IPv6:2001:67c:26f4:224::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DA0923CC
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 03:03:15 -0700 (PDT)
Received: by mx.der-flo.net (Postfix, from userid 110)
        id 6990A160A58; Wed, 26 Oct 2022 12:03:13 +0200 (CEST)
Received: from localhost (unknown [IPv6:2a02:1210:22e1:1f00:fb89:69cb:433e:eb56])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mx.der-flo.net (Postfix) with ESMTPSA id 0D786160A49
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 12:03:13 +0200 (CEST)
Date:   Wed, 26 Oct 2022 12:03:12 +0200
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: check max_entries before allocating memory
Message-ID: <Y1kF4D4/19DOb/SS@der-flo.net>
References: <20221026085053.76561-1-dev@der-flo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221026085053.76561-1-dev@der-flo.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 26, 2022 at 10:50:53AM +0200, Florian Lehner wrote:
> For maps of type BPF_MAP_TYPE_CPUMAP memory is allocated first before
> checking the max_entries argument. If then max_entries is greater than
> NR_CPUS additional work needs to be done to free allocated memory before
> an error is returned.
> This changes moves the check on max_entries before the allocation
> happens.
> 
> Signed-off-by: Florian Lehner <dev@der-flo.net>

I did have a look at the failing CI tests:

Running bpftool checks...
  Comparing /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h (bpf_map_type)
  and /tmp/work/bpf/bpf/tools/bpf/bpftool/map.c (do_help() TYPE):
  {'cgroup_storage', 'cgroup_storage_deprecated'}
  Comparing /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h (bpf_map_type)
  and /tmp/work/bpf/bpf/tools/bpf/bpftool/Documentation/bpftool-map.rst (TYPE):
  {'cgroup_storage', 'cgroup_storage_deprecated'}
  bpftool checks returned 1.

It looks to me these were introduced with commit
a48b4bf994296a380f9c79620ad4ee7bad4511e1 and are not related to this
proposed change.
