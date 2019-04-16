Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FE9C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC812075B
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 21:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQF1ESB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfDPVZj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:25:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37105 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPVZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 17:25:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id c1so13135153qkk.4;
        Tue, 16 Apr 2019 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ril1Ikn9iEMJusma0+6hcwjoRaPTnOn2A9hfQqO15Rg=;
        b=LQF1ESB3NpTMIQVkujX0hO5LW2nTqieQb8WV+sr4JOLxwiVlcqtKWhOFkuiDFfjavy
         ZkDDXnJQZps50zBLVjZh1i4IL8NW+KxpD3au0ZjibtNJFH2bV8KSKibBxCW4zCNXigCU
         Si+cmlGSjBxBUEvVm0e48TguSulLy5Anu8l1LSpzm7PJEHPtFkAxIWsXRaIRotJ3L6qm
         Osc16mUzGj3Kk1Px4uyN3UFJ0fQuJm12qtrEESPy1DjM3mm9H3EZOllfBUPUCp7zopuB
         p5/0mfKy47VeQDafzCotXlkD3K5p/LRrBTgzdKPR48VfIOY9pL64Ne0tTie2FFmp5oxj
         L0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ril1Ikn9iEMJusma0+6hcwjoRaPTnOn2A9hfQqO15Rg=;
        b=pJj75Oq30RYBekOuKyg/NJKm8EIt6xDqlmq1Lq6ouJpHSwj2ZI/k2VOjJDUVfm6Uus
         /An1KQLgZ0Dgl7yFI0LsEMN6DFwf+awi3D/FfRK8HDHa0thAmhx812yO9YVklEh7qxjK
         Hgl9rAwV3K+JCHEdYpFrBxjEovVKoXu5k0TSphTKYu8CqQoF8cHXyUzsVinLTBnRnVoP
         oteXZf5QBhDqQ4I29FZPwCRSS6mptJbIbjOGv5gXdXurYYk0Mb1vpcehKVkm0XDme23A
         JG6wlQOTpcskFg0UublpIZpfUOEOZBfxLGeazC5FyMX3bQpJOV07ntKaISGJ+5KvXbyY
         uw0Q==
X-Gm-Message-State: APjAAAVGhXL01o03KSFTZxmMYp5tBJ9Smf5V1gGXFCKAkh9SCSU136gR
        TsPmufLxgwUsaZhmSATCpTcVdd5VchmB7mClHBpR48jE
X-Google-Smtp-Source: APXvYqyjMyGz8dP9xyIhYvqV+h0CFfISQWQyuHMNmmWChE1qABTBME7VQZc1UpI2DYf1I/nl4BuMO0Z7SvHIHdznwTE=
X-Received: by 2002:a05:620a:16c5:: with SMTP id a5mr66459184qkn.212.1555449938528;
 Tue, 16 Apr 2019 14:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
In-Reply-To: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 16 Apr 2019 14:25:27 -0700
Message-ID: <CAPhsuW4C58jOwVN+pdOZa7O0m+RM8NDQfkaotkwxwL375Of4ug@mail.gmail.com>
Subject: Re: [PATCH bpf v3 0/5] libbpf: remove two dependencies on Linux
To:     Magnus Karlsson <magnus.karlsson@intel.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        bruce.richardson@intel.com, ciara.loftus@intel.com,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        xiaolong.ye@intel.com, ferruh.yigit@intel.com,
        qi.z.zhang@intel.com, georgmueller@gmx.net
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 16, 2019 at 5:58 AM Magnus Karlsson
<magnus.karlsson@intel.com> wrote:
>
> This patch set fixes one bug and removes two dependencies on Linux
> kernel headers from the XDP socket code in libbpf. A number of people
> have pointed out that these two dependencies make it hard to build the
> XDP socket part of libbpf without any kernel header dependencies. The
> two removed dependecies are:
>
> * Remove the usage of likely and unlikely (compiler.h) in xsk.h. It
>   has been reported that the use of these actually decreases the
>   performance of the ring access code due to an increase in
>   instruction cache misses, so let us just remove these.
>
> * Remove the dependency on barrier.h as it brings in a lot of kernel
>   headers. As the XDP socket code only uses two simple functions from
>   it, we can reimplement these. As a bonus, the new implementation is
>   faster as it uses the same barrier primitives as the kernel does
>   when the same code is compiled there. Without this patch, the user
>   land code uses lfence and sfence on x86, which are unnecessarily
>   harsh/thorough.
>
> In the process of removing these dependencies a missing barrier
> function for at least PPC64 was discovered. For a full explanation on
> the missing barrier, please refer to patch 1. So the patch set now
> starts with two patches fixing this. I have also added a patch at the
> end removing this full memory barrier for x86 only, as it is not
> needed there.
>
> Structure of the patch set:
> Patch 1-2: Adds the missing barrier function in kernel and user space.
> Patch 3-4: Removes the dependencies
> Patch 5: Optimizes the added barrier from patch 2 so that it does not
>          do unnecessary work on x86.
>
> v2 -> v3:
> * Added missing memory barrier in ring code
> * Added an explanation on the three barriers we use in the code
> * Moved barrier functions from xsk.h to libbpf_util.h
> * Added comment on why we have these functions in libbpf_util.h
> * Added a new barrier function in user space that makes it possible to
>   remove the full memory barrier on x86.
>
> v1 -> v2:
> * Added comment about validity of ARM 32-bit barriers.
>   Only armv7 and above.
>
> /Magnus
>
> Magnus Karlsson (5):
>   xsk: fix XDP socket ring buffer memory ordering
>   libbpf: fix XDP socket ring buffer memory ordering
>   libbpf: remove likely/unlikely in xsk.h
>   libbpf: remove dependency on barrier.h in xsk.h
>   libbpf: optimize barrier for XDP socket rings

For the set:

Acked-by: Song Liu <songliubraving@fb.com>

>
>  net/xdp/xsk_queue.h         | 56 +++++++++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf_util.h | 30 ++++++++++++++++++++++++
>  tools/lib/bpf/xsk.h         | 22 +++++++++++++-----
>  3 files changed, 98 insertions(+), 10 deletions(-)
>
> --
> 2.7.4
