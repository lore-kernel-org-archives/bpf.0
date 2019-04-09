Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533A0C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E30C20883
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 18:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bmag5W+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDISqx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:46:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38658 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfDISqx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 14:46:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id a6so14486233oie.5
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2019 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQcuJ+8o1GDAy8xkl7Xc9cLO35Ofnjcm1AwMgqO0ONs=;
        b=bmag5W+Q1aQXY0t4+daFcuuj2B+p8EhxeMuamRkN+V+EHa9eQzwVeW53w3eF1DHbv2
         wkCswyVrIYE6H2cK0oqatjMOaMjo3PbU4hPYglzAz1rtJAcTPipSMXoAYKuPeNUtLjEG
         KDPS8Fb2GKG4xYEK7JjoNau53Rp8GlWYyBlNcgULxVf/ejkKokifj1qx67S0IuHjDH+2
         ydCrrmIGciz8ChYpxnbKyoX7Cxi+sIJJTtHWcQ6mGEBDe8v6gzppnl3kqRNOaGdCu5vr
         3v2aokgWT02z2vG5xF1AD7YKs29QrQXtWk9PSy33HKVYc+F1NFI3TmAMKpS09s0v18eP
         Gu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQcuJ+8o1GDAy8xkl7Xc9cLO35Ofnjcm1AwMgqO0ONs=;
        b=rwTTaWk0gJRzaH2Ppsz7/38AgOnmnK78bWjjwDHLzWHpqewnNjZREXBwZ8sCAIBSJ5
         ZHyaDZrtcK5LpI1tLv1K9wdGf3LhIBp6Cch3BHvt5M4sUyfn0xh6bgi/I/VdcpNma6zr
         PNTQmPN/NHhExrnVCND4Y76khbjciISdY20hzbge3OxPD/ZooOqYVkTHvASVEbo6KHKv
         ANqmhOgvENX+NjCbGYJe6wq5oEnhWVBVt+n25GKUYIXQYMqmPEZwBBm+IZ+H7ZzoZFFk
         YNMk3A6BzuO5sD/ReTfkT8uGAxzPpfGqPlmDn5bEecLGyXqcmEeDotq6cO6t35fNIfgC
         XpUA==
X-Gm-Message-State: APjAAAUvZOqKVWrm+y3Cew0pw8zItIdUpFhIqWMo0jR7+VEcghxPBsK8
        OJs2lZoXGn/vICHDchOPHXwVwpp8vWwcPEz3bHC29g==
X-Google-Smtp-Source: APXvYqzdJ8syEpmck6faoMswaGF+TzcbS84j0qDg5wiuhloDkBV2qV2lR1KXDnIvdiU+ZW1mjC+MJZ7IJJ7g4r1Hz0M=
X-Received: by 2002:aca:bf83:: with SMTP id p125mr11470311oif.47.1554835612409;
 Tue, 09 Apr 2019 11:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554731339.git.daniel@iogearbox.net> <02cc454f12646ae96647457d64d41ba3577e3ae5.1554731339.git.daniel@iogearbox.net>
In-Reply-To: <02cc454f12646ae96647457d64d41ba3577e3ae5.1554731339.git.daniel@iogearbox.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 9 Apr 2019 20:46:26 +0200
Message-ID: <CAG48ez0V5L610YsJQde_r=BZgK1ghc-AuWTn1gF0oyLNNz4ctQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 04/16] bpf: add syscall side map freeze support
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, joe@wand.net.nz,
        yhs@fb.com, andrii.nakryiko@gmail.com, kafai@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 8, 2019 at 3:54 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> This patch adds a new BPF_MAP_FREEZE command which allows to
> "freeze" the map globally as read-only / immutable from syscall
> side.
>
> Map permission handling has been refactored into map_get_sys_perms()
> and drops FMODE_CAN_WRITE in case of locked map. Main use case is
> to allow for setting up .rodata sections from the BPF ELF which
> are loaded into the kernel, meaning BPF loader first allocates
> map, sets up map value by copying .rodata section into it and once
> complete, it calls BPF_MAP_FREEZE on the map fd to prevent further
> modifications.
>
> Right now BPF_MAP_FREEZE only takes map fd as argument while remaining
> bpf_attr members are required to be zero. I didn't add write-only
> locking here as counterpart since I don't have a concrete use-case
> for it on my side, and I think it makes probably more sense to wait
> once there is actually one. In that case bpf_attr can be extended
> as usual with a flag field and/or others where flag 0 means that
> we lock the map read-only hence this doesn't prevent to add further
> extensions to BPF_MAP_FREEZE upon need.
>
> A map creation flag like BPF_F_WRONCE was not considered for couple
> of reasons: i) in case of a generic implementation, a map can consist
> of more than just one element, thus there could be multiple map
> updates needed to set the map into a state where it can then be
> made immutable, ii) WRONCE indicates exact one-time write before
> it is then set immutable. A generic implementation would set a bit
> atomically on map update entry (if unset), indicating that every
> subsequent update from then onwards will need to bail out there.
> However, map updates can fail, so upon failure that flag would need
> to be unset again and the update attempt would need to be repeated
> for it to be eventually made immutable. While this can be made
> race-free, this approach feels less clean and in combination with
> reason i), it's not generic enough. A dedicated BPF_MAP_FREEZE
> command directly sets the flag, allows all pending operations to
> finish and caller has the guarantee that map is immutable from
> syscall side upon successful return, which is also more intuitive
> from an API point of view. A command name such as BPF_MAP_LOCK has
> been avoided as it's too close with BPF map spin locks (which already
> has BPF_F_LOCK flag). BPF_MAP_FREEZE is so far only enabled for
> privileged users.
[...]
> @@ -857,8 +870,7 @@ static int map_update_elem(union bpf_attr *attr)
>         map = __bpf_map_get(f);
>         if (IS_ERR(map))
>                 return PTR_ERR(map);
> -
> -       if (!(f.file->f_mode & FMODE_CAN_WRITE)) {
> +       if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
>                 err = -EPERM;
>                 goto err_put;
>         }
[...]
> +static int map_freeze(const union bpf_attr *attr)
> +{
> +       int err = 0, ufd = attr->map_fd;
> +       struct bpf_map *map;
> +       struct fd f;
> +
> +       if (CHECK_ATTR(BPF_MAP_FREEZE))
> +               return -EINVAL;
> +
> +       f = fdget(ufd);
> +       map = __bpf_map_get(f);
> +       if (IS_ERR(map))
> +               return PTR_ERR(map);
> +       if (READ_ONCE(map->frozen)) {
> +               err = -EBUSY;
> +               goto err_put;
> +       }
> +       if (!capable(CAP_SYS_ADMIN)) {
> +               err = -EPERM;
> +               goto err_put;
> +       }
> +
> +       WRITE_ONCE(map->frozen, true);
> +       synchronize_rcu();

What is this synchronize_rcu() doing? It seems like your intent might
be to ensure that all pending writes from the syscall side have
finished by the time this returns, but functions like
map_update_elem() aren't in an RCU read-side critical section when
they check for ->frozen, so that doesn't work, right?

> +err_put:
> +       fdput(f);
> +       return err;
> +}
