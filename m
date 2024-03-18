Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5EF225CF
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740449; cv=none; b=tgAhDRQVKgWjlO7RTm1Bc5xQ7/CSe0qOR04VZvsaS/cM7xM4a4xeonhxyF2XQDb+Zn8YmG+96ny6Dmesw7HHRf6y4gPcDtY30Jzp1iHqtgd1WS4kklSnietNM+fY6zdCvJ+Hvhhyk83xEmEvOWhizGR+IfhxVGpLWfjNDmtYDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740449; c=relaxed/simple;
	bh=vtqKGvlMOKs17Ju73R8kNsVR+f6eo4QDwtrw31G6IAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlghvC9Oo7GnvQmI5xgla83rzArH2CZ/yZLdSAKmvQa2pYM1BEA2D9M++D7LR3uDottKF53QKVSD5fJQC3tQXP7WTQNsGxKjxqQ9TL6am4M7VV0jb0UHQW3dTuMN4y8OTitYf9xscIRY6vKZCu+/4ay97SChlnND9zhdaiAUsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZM3Lmng; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZM3Lmng"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-56b8248e2d8so23577a12.1
        for <bpf@vger.kernel.org>; Sun, 17 Mar 2024 22:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710740446; x=1711345246; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/oZ/rTu3b3lHQTXECHWg2xesajy94W9V9dbmQP4/Amc=;
        b=RZM3LmngNVBFFgKtki9gvKcd/sc2UbG/AKu0Kw1bG8Fq+ws3DGK1dbIl/dirVqTXjQ
         +93GgiGW9Nx4bO2S/TSWnrco2EZ9Y4p+cEGqXJS8PGGjBKQ3sMpPmRKeUDch/mGfu3w+
         ylfRkWARrQNcP4xV7qC5wESwy2Aea77dzyzjZO3Pb3Bm7uI89vsa37OpibMtx/xcplB5
         K8JduIQN6FTRjcU3xci+5yd9f0ZDl851FV7uM7sJVZZylGZqBIFtaXBMZwJ6jfXfyUWI
         VbspbQGG7fphvNJ1QsO/z7gVZ0IudLx/ESClgllu2jMhChq5VM7OhAGGM/TEXDGEZ+t1
         GHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710740446; x=1711345246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oZ/rTu3b3lHQTXECHWg2xesajy94W9V9dbmQP4/Amc=;
        b=UsBkn9XdJWSBHzsZw6ZYbnAvVZ4i3Gmcz9GgRMcpHctBp60WYwA9b2YqYBhv/Rvpci
         PvOr+L5+v0X8cFMbZdSWlHa1YnfDZOQ1GcQxqSpITDKtN+tVGE25UWft8Frg3A80M0L8
         rqTRwPQEpT4feg7CBqfM72uOC3xkszg4H8uqZUbeWD/xQGgERPZ5SKXPmV91Wz/I+bFO
         bI3YnCEuxpWyc5aOosKDXvFOS3EhmTRWcknLIjlKRtrL2Cogbv/zVkj4GywkhCjymer/
         le/UGE654VlDH3sAcRCgswBtjxYDGpT6cmNuio22yESGJeOZn5zmrFApSUqsmSocKxVl
         8Eqg==
X-Gm-Message-State: AOJu0YwsKsHc2sjhb8PQ+yQzAKTiHqA7w3CqzAIdLX00ISITiWZBJQ3i
	2rmDqUZNrIkLUfiUULD3AyN9HgmYpYeWpm5+A79xxvkmipYm7XSHAot7wV4W9xVLN1IFuDfqBCf
	b5ETkRWhIbSpuJKjGFIY0jzih7Xk=
X-Google-Smtp-Source: AGHT+IGbtK5RmkLey6gN2wE+DTUpG3EkS7P8hHMFxGKGpmIbReRwM/OtTIIaxnaFtrkcMxZ/U5UsUFoW3dKdqjQ6YhY=
X-Received: by 2002:a05:6402:2410:b0:567:48a9:cf85 with SMTP id
 t16-20020a056402241000b0056748a9cf85mr9950540eda.37.1710740445498; Sun, 17
 Mar 2024 22:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <94ee37372c90c28980246ab803dffb3d2b63be35.camel@gmail.com>
In-Reply-To: <94ee37372c90c28980246ab803dffb3d2b63be35.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 18 Mar 2024 06:40:09 +0100
Message-ID: <CAP01T74kov3JKJFvpaqz6CjEkzBMbOfDLc6Xjg_n5=g9osApjA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/14] Exceptions - Resource Cleanup
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 12:08, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Hi Kumar,
>

Hello Eduard,

> Sorry for delayed response. Theoretical possibility that frame merge
> might fail because of some e.g. clang version changes bugs me,
> so I thought a bit on what alternatives are there.

I spent some time this weekend addressing feedback, and prepping the
next version.
As you point out (and as I explained in one of the replies to you),
the possibility of the
same stack slot / register containing a conflicting resource type can
cause merge problems.
I have had a similar thought to what you describe below (emitting
resource hints in such cases) to address this,
but I slept over your idea and have a few thoughts. Please let me know
what you think.

> For the sake of discussion, what do you think about runtime-based
> approach:
> - for each throwing sub-program reserve a stack region where
>   references to currently acquired resources (and their types)
>   would be stored;
> - upon a call to something that acquires resource push pointer/type
>   pair to this region;
> - upon a call to something that releases resource delete pointer/type
>   pair from this region;
> - when bpf_throw() is executed, walk this region for each active frame
>   and execute corresponding destructors.
> - (alternatively, reserve one region for all frames).
>

I went over this option early on but rejected it due to the typical
downsides you observed.
The maximum stack usage due to this will be peak resource acquisition
during the runtime of a subprogram (N) x 16 bytes.
The maximum will be the sum of all subprogs in a call chain.
This seems a bit problematic to me, given this can basically greatly
exceed typical program stack usage. Compared to
extra stack slot usage by bpf_loop inlining, and may_goto instruction,
this appears to be too much.
We can mitigate it by using a more space efficient encoding to
identify resources, but the core problem still remains.
Apart from that, there's the overhead to know zero of this stack
portion on entry every time.

I just think this is all unnecessary especially when most of the time
the exception is not going to be thrown anyway,
so it's all cost incurred for a case that will practically never
happen in a correct program.

> Technically, this could be implemented as follows:
> - during main verification pass:
>   - when verifier processes a call to something that acquires resource,
>     mark call instruction and resource type in insn_aux_data data;
>   - same for processing of a call to something that releases resource;
>   - keep track of a maximal number of simultaneously acquired resources;
> - after main verification pass:
>   - bump stack size for each subprogram by amount, necessary to hold
>     the acquired resource table and assume that this table is at the
>     end of the subprogram stack;
>   - after each acquire call, insert a kfunc call that would add
>     resource reference to the table;
>   - after each release call, insert a kfunc call that would remove
>     resource reference from the table.
>
> On a surface it appears that this approach has a few advantages:
> - seems simpler than frame descriptors tracking and merging
>   (but only implementation would tell if this is so);
> - should be resilient to program compilation changes;
> - abort is possible at any program point, which might be interesting for:
>   - cancelable BPF programs (where abort might be needed in the middle
>     of the e.g. loop);

Let us discuss cancellation in another set that I plan to send in some
time after this one,
but I think aborting arbitrarily at any point of the program is not
the way to go. I have also
reviewed literature on how this happens in other language runtimes,
and the broad consensus
is to have explicit cancellation points in programs, and only allow
cancellation for them.
Synchronous and asynchronous is irrelevant to the mechanism, but
usually it is at explicit program
points.

Not only can you encounter a program executing in the middle of a
loop, you can interrupt it within a kfunc,
in such a case, you cannot really abort it immediately, as that may
not be safe. It is thus better to designate
cancellation points in the program, which are visited even in cases
where the program may possibly be stuck
for a long time (like iterator next kfunc) and only do cancellation
when executing them.

Anyway, let's continue this discussion once I send the RFC out for
cancellation. Will try to also include a PoC
for arena fault aborting.

>   - arenas, where it might be desirable to stop the program after e.g.
>     faulting arena access.
>
> The obvious disadvantage is incurred runtime cost.
> On the other hand, it might be not that big.
>
> What do you think?

Let's go back to the problem we can encounter with frame descriptors.
The case of multiple paths having distinct resource types in a common
stack slot.

What I would do is only force a spill of the specific resource type
(right after the pc acquires it)
only if their stack slots are unmergeable. Since we go over the stack
first, any conflicts in the register
types will be resolved since all states for the ref_obj_id will be
erased. For conflicts in registers, we'd
do something similar. A new 8-byte entry would be reserved for the pc
after max_stack_depth and
all these entries will be zeroed upon entry. A similar thing could be
done by the compiler itself and the
verifier wouldn't have to do all this, but for now let's just do it in
the verifier.

In this way, when we encounter an unlikely case where the same slot
has conflicting entries, we'll erase
state by storing its entry in the stack slot reserved for the pc, and
clear its state from the verifier state,
allowing all respective entries for the same resource to now merge
easily. The same can be repeated
for each resource if all of them conflict.

So far playing around with this series applying it to program
cancellation and sched-ext cases, I haven't
encountered merging issues, so it seems like an edge case that is
unlikely to often occur in practice. But when it does,
it can be resolved by the logic above. This should address all issues
and should be resilient to changes triggered by different clang
versions.

Let me know what you think.

>
> Thanks,
> Eduard
