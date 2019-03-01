Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78A5C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 19:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C112070B
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 19:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EypW/xee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfCATfc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:35:32 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41283 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfCATfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 14:35:31 -0500
Received: by mail-oi1-f194.google.com with SMTP id e7so20435356oia.8;
        Fri, 01 Mar 2019 11:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDxuHfRSkvtIHaNn65KvVjFuUjBr3TgVjDkGVCDw4Rc=;
        b=EypW/xeeKe4o9236jKuM/c+nvassSaXLsd/NuUNwenMWMCKhsbO5mNi/aUM3amSvAU
         une0EuU6py3L/1zRuPHBQI6dYUgKIzIDbReopK9WNr587AUA6zh1tTRKSO9F5/zZ+msZ
         PULkCFUOWRwmVwFOqQLw/ei4lF7TWfMqbAbphEJbV195/kBzicnP36g0UdiAu6wajfXM
         h3LOis6saHBDKlMSD9ZqMdZzj1Tqu2IbSO863rRKqTkEUXH7M4ko1PXyboFrA4MVh2bF
         ezlxN6gWUJvbcWiTMvTjzK8q5XvKx8qr3nFkzAieyeb1vwgCy+CV7/6nk+yL0T/UHi/l
         D8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDxuHfRSkvtIHaNn65KvVjFuUjBr3TgVjDkGVCDw4Rc=;
        b=OgESuoXqo6pNiU04/ws+/YU4sN1wgnBk+3V1vgOqJXe1oHBPOXaGQ+V7Sb2P0FYoOd
         ajP7plEbih7Yf/LnGHWtGhePeuYQOXCawn7u4c970Ta7mX/2pxzy0ZQtAGvuQhBN3ROc
         QVqecjm07A+fhH7+mDKpZKeCByLgnVPUwCCDU9CAymaLlv1PoLqIPez/M2ih7gx55QoL
         nGpb9ET0a3fxt9sdBFnNw2j9LDmfL1JImVbn31LsZfUsSFFiCeXgMzYd6QJtJ24mnhZH
         pLQdLRYEg+kiC519wxW3Hhs/JuUuWX4FTGr62c1hfuNsljxMfW571zCe15uvJFdLaVwd
         OPSQ==
X-Gm-Message-State: AHQUAuZfiVSr1SIPT/FuU297DGdQGcUwRxmun4opB1hvib8X/ilioh2/
        yEAOsW6kYfvQ3EJlhzX8173saIuq21cvp23wLiA=
X-Google-Smtp-Source: AHgI3IZCMD3g61KftDnAmJFBLAqrKze86o8KgJIL3SUmmWyo9J6ElfQ3z9HJH15uWIqaP/x+3i4IB9XO9MDaF9TRW8I=
X-Received: by 2002:aca:3e54:: with SMTP id l81mr4166946oia.10.1551468930084;
 Fri, 01 Mar 2019 11:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20190228231829.11993-1-daniel@iogearbox.net> <20190228231829.11993-2-daniel@iogearbox.net>
 <CAEf4BzYCFw861q-S=7VH3B7d9wQha5WYbNnbi+YU6XEya1ZE_w@mail.gmail.com> <93040e2a-cf74-0dfe-276f-0a91598011c5@iogearbox.net>
In-Reply-To: <93040e2a-cf74-0dfe-276f-0a91598011c5@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 1 Mar 2019 11:35:17 -0800
Message-ID: <CAEf4BzYeuBQn6GT7GAQooAsxevBXP2RJjGJV4QBUghAmewrJDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: implement lookup-free direct value access
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        john fastabend <john.fastabend@gmail.com>, tgraf@suug.ch,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        lmb@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 1:49 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 03/01/2019 06:46 AM, Andrii Nakryiko wrote:
> > On Thu, Feb 28, 2019 at 3:31 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>
> >> This generic extension to BPF maps allows for directly loading an
> >> address residing inside a BPF map value as a single BPF ldimm64
> >> instruction.
> >
> > This is great! I'm going to review code more thoroughly tomorrow, but
> > I also have few questions/suggestions I'd like to discuss, if you
> > don't mind.
>
> Awesome, thanks!
>
> >> The idea is similar to what BPF_PSEUDO_MAP_FD does today, which
> >> is a special src_reg flag for ldimm64 instruction that indicates
> >> that inside the first part of the double insns's imm field is a
> >> file descriptor which the verifier then replaces as a full 64bit
> >> address of the map into both imm parts.
> >>
> >> For the newly added BPF_PSEUDO_MAP_VALUE src_reg flag, the idea
> >> is similar: the first part of the double insns's imm field is
> >> again a file descriptor corresponding to the map, and the second
> >> part of the imm field is an offset. The verifier will then replace
> >> both imm parts with an address that points into the BPF map value
> >> for maps that support this operation. BPF_PSEUDO_MAP_VALUE is a
> >> distinct flag as otherwise with BPF_PSEUDO_MAP_FD we could not
> >> differ offset 0 between load of map pointer versus load of map's
> >> value at offset 0.
> >
> > Is having both BPF_PSEUDO_MAP_FD and BPF_PSEUDO_MAP_VALUE a desirable
> > thing? I'm asking because it's seems like it would be really simple to
> > stick to using just BPF_PSEUDO_MAP_FD and then interpret imm
> > differently depending on whether it's 0 or not. E.g., we can say that
> > imm=0 is old BPF_PSEUDO_MAP_FD behavior (loading map addr), but any
> > other imm value X is really just (X-1) offset into map's value? Or,
> > given that valid offset is limited to 1<<29, we can set highest-order
> > bit to 1 and lower bits would be offset? In other words, if we just
> > need too carve out zero as a special case, then it's easy to do and we
> > can avoid adding new BPF_PSEUDO_MAP_VALUE.
>
> Was thinking about reusing BPF_PSEUDO_MAP_FD initially as mentioned in
> here, but went for BPF_PSEUDO_MAP_VALUE eventually to have a straight
> forward mapping. Your suggestion could be done, but it feels more
> complex than necessary, imho, meaning it might confuse users trying to
> make sense of a insn dump or verifier output wondering whether the off
> by one is a bug or not, which won't happen if the offset is exactly the
> same value as LLVM emits. There is also one more unfortunate reason
> which I noticed while implementing: in replace_map_fd_with_map_ptr()
> we never enforced that for BPF_PSEUDO_MAP_FD insns the second imm part
> must be 0, meaning it could also have a garbage value which would then
> break loaders in the wild; with the code today this is ignored and then
> overridden by the map address. We could try to push a patch to stable
> to reject anything non-zero in the second imm for BPF_PSEUDO_MAP_FD
> and see if anyone actually notices, and then use some higher-order bit
> as a selector, but that still would need some extra handling to make
> the offset clear for users wrt dumps; I can give it a try though to
> check how much more complex it gets. Worst case if something should
> really break somewhere, we might need to revert the imm==0 rejection
> though. Overall, BPF_PSEUDO_MAP_VALUE felt slightly more suitable to me.

Yeah, make sense, BPF_PSEUDO_MAP_VALUE is more explicit.

>
> >> This allows for efficiently retrieving an address to a map value
> >> memory area without having to issue a helper call which needs to
> >> prepare registers according to calling convention, etc, without
> >> needing the extra NULL test, and without having to add the offset
> >> in an additional instruction to the value base pointer.
> >
> > It seems like we allow this only for arrays of size 1 right now. We
> > can easily generalize this to support not just offset into map's
> > value, but also specifying integer key (i.e., array index) by
> > utilizing off fields (16-bit + 16-bit). This would allow to eliminate
> > any bpf_map_update_elem calls to array maps altogether by allowing to
> > provide both array index and offset into value in one BPF instruction.
> > Do you think it's a good addition?
>
> Yeah, I've been thinking about this as well that for array-like maps
> it's easy to support and at the same time lifts the restriction, too.
> I think it would be useful and straight forward to implement, I can
> include it into v3.
>
> >> The verifier then treats the destination register as PTR_TO_MAP_VALUE
> >> with constant reg->off from the user passed offset from the second
> >> imm field, and guarantees that this is within bounds of the map
> >> value. Any subsequent operations are normally treated as typical
> >> map value handling without anything else needed for verification.
> >>
> >> The two map operations for direct value access have been added to
> >> array map for now. In future other types could be supported as
> >> well depending on the use case. The main use case for this commit
> >> is to allow for BPF loader support for global variables that
> >> reside in .data/.rodata/.bss sections such that we can directly
> >> load the address of them with minimal additional infrastructure
> >> required. Loader support has been added in subsequent commits for
> >> libbpf library.
> >
> > I was considering adding a new kind of map representing contiguous
> > block of memory (e.g., how about BPF_MAP_TYPE_HEAP or
> > BPF_MAP_TYPE_BLOB?). It's keys would be offset into that memory
> > region. Value size is size of the memory region, but it would allow
> > reading smaller chunks of memory as values. This would provide
> > convenient interface for poking at global variables from userland,
> > given offset.
> >
> > Libbpf itself would provide higher-level API as well, if there is
> > corresponding BTF type information describing layout of
> > .data/.bss/.rodata, so that applications can fetch variables by name
> > and/or offset, whichever is more convenient. Together with
> > bpf_spinlock this would allow easy way to customize subsets of global
> > variables in atomic fashion.
> >
> > Do you think that would work? Using array is a bit limiting, because
> > it doesn't allow to do partial reads/updates, while BPF_MAP_TYPE_HEAP
> > would be single big value that allows partial reading/updating.
>
> If I understand it correctly, the main difference this would have is
> to be able to use spin_locks in a more fine-grained fashion, right?

spin_lock is just a nice bonus, if there is any manipulation that
isn't <= 8 byte long that needs to be done atomically.

The reason for this new type of map is actually ability to update
global variables from outside BPF program in granular fashion. E.g.,
turning on some extra debug output temporarily, tuning parameters,
changing PID to trace, etc, without stopping and reloading BPF
program. With array, it's all-or-nothing: to update anything you have
to overwrite entire .data section. As I mentioned, if we can get BTF
type information for entirety of .data, it would allow to manipulate
those variables by name even with generic tools like bpftool.

> Meaning, partial reads/updates of the memory area under spin_lock as
> opposed to having to lock over the full area? Yeah, sounds like a
> reasonable extension to me that could be done on top of the series,
> presumably most of the array map logic could also be reused for this
> which is nice.
>
> Thanks a lot,
> Daniel
