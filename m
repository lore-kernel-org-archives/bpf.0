Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99CE331ECA
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 22:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721963; cv=pass; b=JOtvKLRtepNQ3wAyVzLEWhkJKcfCJLMAxeIC6zNDTIxwOnr5iZmiKfu1shcFFWis85uxdDBMrMTSJJfs8AI2yT5x9PbVHOiGjwmbyzZosBwovaWKtxQLMs44Q4pVQJ8GvUhWuehgUCao3OqkqVd13rYM7EX4VAmwlzIVS8OwNnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721963; c=relaxed/simple;
	bh=6FXDGb/ZFK6OkVHqioT9m8yLHR5vgLW7slXSvGUqJHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWCQ8no1mJH0Xn5IDfMW/+W0l9N9NRyP3kmKFJYTWrjgcE1SJ2d8Rl+ZsJXZV/lhedyougxLHjERyNZgSpS6ClcVIaPLkQVLI9zIot8gNWJszbLUZkWe61Lq/gb8BLmW8iNhuthWW0Hky5zhx5tW+SESY+k4YdHcAfn7Jvj0gZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVgCeKb2; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVgCeKb2"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca80d708489so868144a12.1
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:19:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783721961; cv=none;
        d=google.com; s=arc-20260327;
        b=UeQsKrGj6XDACWNt91iX6vN6kjfKAEj+OF3t613RjLg4xgGH72gicHFykWfBH3AiFj
         XFm5hEq9xIUG7+YGF08/w5lUH1BzbM5cSv48f3zYnVv4xvbuGPjIDobmQ8kheykMfAGJ
         JpAltvYX5t7NTzPnhKY23Kw5jliEmIjeKBUhSnR9C/Z+T/mqo0Tb7j7ALVUsdh3jC3HD
         5vJzexIFzyq1qGACXbr8zB0EJxA8i9EM98fNa2Et+DM/OKRFJN5/3MXH6n/XWQeOn0Qa
         Z++5eJ551+0IStCg2+fAlVd9QZMjak/YpDVPxpel8g1e8SdeTUMncsPx9FLzHsqQ01nS
         ZhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CwbosvBxncLzfdu836WuY8bpWeNSRg6Hv57ZoZV23C8=;
        fh=0wiUBcT4DHouEL828xChSWcQPvMryawpDEkuPVohUN8=;
        b=dUgGe4KpdQwVwBlhSHAz7bd8Y7D4wUl1+N7l5lBI9uSaFv9a/IDkf0MOB8s3RRM8v+
         AnNvq5boCRTG9cuYE6hckgGZ4vKhOLvcRCvOewMGCJjojWxuM5g1CFKzGkbtyHv1fdvy
         7DexM350eaZw4ZVPYwvl7gsQWqFA8MPFU3KpEUzedqWan4U2Lhu2VGa2wj16G9xxptwX
         mE7wYWHdy5gbbxJvQGXd0d0N+kl4NwIQSNL9uMfoQ7eLhBuWgOL/qm5C6rF3tompEaWJ
         /JMuYgYdyuCL4gDHGopg5XUO0ry0UzM+R959PK2n8ne6Uom6nJ9knIHuR0rZEZ81NMVC
         5YNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783721961; x=1784326761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CwbosvBxncLzfdu836WuY8bpWeNSRg6Hv57ZoZV23C8=;
        b=aVgCeKb2xM2Z44+/SGWvNmTbnPKYsf2Sn9tjcOXN0B/xRJkDF69bMUdxjCId0on4tE
         EKneUJSiyALvUxzyhP4G0++wFuHoBdAFtWWNoLnKbFFn3mGPZLY5ccJkSswACVkbQFrj
         E3Qum9SjV5s05iburzm6Pe/v4teVICnh9rA5kzaD4aTdss30bbRteJNt/+XYE37mS2th
         HOkiHbK5MFeNyi4XU0F4FNZPooJlH/conlzY1rWyURYIXpqb/OkXs+KBRe8ChTwGnePy
         PuCliDRD9dAy/0zwq6ZkM/4Hye3JrrXthetRKtvAXRRhM6KBht+p98HT/WYcaot0NEaC
         HxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721961; x=1784326761;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CwbosvBxncLzfdu836WuY8bpWeNSRg6Hv57ZoZV23C8=;
        b=Ic3hak5hZtZ5UcOp+kNK8QEuxmJd061AJGz47TwCzxGSr4+evp5EwLI18BESOZNur2
         bLGmPh6uAS8V8eg0Q+0SQKtvbN4ITpCujTITrSeK2T7MPQZgwM/AQ4cqyqCHHrUGpd9M
         ykdoz6KvmBFn7IOoU1m5dlgV7tUh4GsbG4ezNHOfYNLQL+8Gfr6oxlv+FjRdvo2IwmwF
         4cLG23lIyVwci1Dqm+NXylqK3zkNBQ5T5/c4fz0c6MT6ANCpvAk3iXL0QrBiWO1yIPQ8
         t/4l1aVuuJ9k/iiPhGWlw0Zzj+vnRNPn1sgRlsPMfI2gNXF72Guw2YHmJ7fWvvg44wms
         d88Q==
X-Forwarded-Encrypted: i=1; AHgh+RqofHO//bBDdisyeXxngVYcqN2R74AJT9w6qHd8IzexCixWUT5QMC+7T0dqkiqpArKgBQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBvzubzWJxkKSTob2um8ZWdb6QgPcv4vhgdTM614PnO4j6vNnH
	C0KJbtTajkgzUidx1tcrwl9WurKwCx7xFOczRrkODXNEwHGgP9pfPp8PfpcUaM//Pl8QS5ZQSik
	VTttnzcsi4Yv3F5j5akomKopSL2czqSr6OND4
X-Gm-Gg: AfdE7cmapsD2zL46UKFWngk4URWp806ux1VdO0QugpM12kVuMioHRUVILdRXTDS3ZKZ
	uB6v3AJ0g9h6vhao21HfZLnhbjsI6hWbSPr4eVLj44pweVe9edfmX3ssH71fUJkDmkF3d2Isnp4
	EwUxDFeoraJq9lTUsLgtOTWvJopiJSMRSzuhb/xtvfgaNUe0FqeKOqRO+B9x1k75qVPlN9pxfTG
	GnYEMr0jKbxbt2Mc7wc//vKhI39S0Jc/kX0nfTZM9/GZNyLAmjcZ5jIjdB4jHaY+mkhWmGOS5CL
	hoR6TzHN8hh6S+QzZuk7o0aZzyvXCDJof+aOWqrPqYTFuKNe83O2wQ==
X-Received: by 2002:a05:6a21:6daa:b0:3b3:dd0:a624 with SMTP id
 adf61e73a8af0-3c112d8b659mr534981637.23.1783721960905; Fri, 10 Jul 2026
 15:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com> <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
 <CAEf4BzYbUhpwP3nq=M4Ph12LwRYO+mYSQB8SJjsw0AzZAFqyVQ@mail.gmail.com>
 <CAOu3gNgv_nJ6tjZOZ-FnJNYntbnpKn+nRnO4G6j0fkBmeeu=GQ@mail.gmail.com> <CAOu3gNjg5vQ=t0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia+rdNw@mail.gmail.com>
In-Reply-To: <CAOu3gNjg5vQ=t0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia+rdNw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jul 2026 15:19:08 -0700
X-Gm-Features: AVVi8CdP-TO_JP5O0eE_rtMEdK3ycpGnGBSYfIOp1UzvjP6x0JSeBRwi3mWSpW4
Message-ID: <CAEf4BzY2ucQUsNbbaKcOyLhXNbMBS4ouoJknAqNJ6CN8rPG92Q@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, kernel-team@meta.com, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 1:58=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Mon, Mar 16, 2026 at 10:23=E2=80=AFAM Andrey Grodzovsky
> <andrey.grodzovsky@crowdstrike.com> wrote:
> >
> > On Wed, Mar 11, 2026 at 6:52=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Mar 6, 2026 at 9:22=E2=80=AFAM Andrey Grodzovsky
> > > <andrey.grodzovsky@crowdstrike.com> wrote:
> > > >
> > > > Mykyta and Andrii Hi!
> > > >
> > > > We're evaluating the bpf_object__prepare() +
> > > > bpf_program__clone() API for use in a production BPF
> > > > application that manages hundreds of BPF programs with
> > > > selective (dynamic) loading =E2=80=94 some programs are loaded at
> > > > startup, others loaded/unloaded at runtime based on feature
> > > > configuration.
> > > >
> > > > We have a few questions about the intended usage and
> > > > potential extensions of this API:
> > > >
> > > > 1. Compatibility with bpf_object__load() and object state
> > > >
> > > > After bpf_object__prepare(), the object is in OBJ_PREPARED
> > > > state. Several libbpf APIs (e.g., bpf_program__set_type())
> > > > gate on OBJ_LOADED state.
> > > >
> > > > Is there a recommended way to transition the object to
> > > > OBJ_LOADED after cloning all desired programs? For example,
> > > > would a bpf_object__finalize() or similar API that runs
> > > > post_load_cleanup() and sets OBJ_LOADED be in scope? This
> > > > would allow users to benefit from prepare() + clone() for
> > > > selective loading while keeping the object in a state that
> > > > the rest of libbpf expects. Or, is the new API not intended
> > > > to work with bpf_object in the first place ?
> > >
> > > exactly, it's not. It's an escape hatch out of bpf_object into
> > > low-level FD, it was never designed to produce something that should
> > > be put back into bpf_object. This clone stuff if for generic low-leve=
l
> > > tooling like veristat and/or maybe bpftool's generic program loading.
> > > And another one is cloning the same fentry program to be attached int=
o
> > > multiple uniform targets (I do a similar hack in retsnoop, for
> > > instance).
> > >
> > > In none of those cases cloned FDs are meant to be interoperable with
> > > bpf_object/bpf_program abstractions.
> > >
> > > >
> > > > 2. Storing the clone FD back on struct bpf_program
> > > >
> > > > bpf_program__clone() returns a caller-owned FD, but APIs
> > > > like bpf_program__attach() read prog->fd internally.
> > > > Without a way to set the FD back on the program struct, the
> > > > caller must reimplement attach logic (section-type dispatch
> > > > for kprobe, fentry, raw_tp, etc.).
> > > >
> > > > Would a bpf_program__set_fd() setter (similar to the
> > > > existing btf__set_fd()) be acceptable to store the clone FD
> > > > back, making bpf_program__attach() and related APIs usable
> > > > with cloned programs?
> > >
> > > technically this could be done, probably, but it just feels too dirty=
,
> > > tbh... there is so much program-specific information that libbpf
> > > internally preserves (and gives access to most of it through
> > > bpf_program's getter) that would need to be invalidated and/or
> > > re-fetched with this set_fd() approach, that I don't really even want
> > > to consider this too seriously... but see below
> > >
> > > >
> > > > 3. Use case: selective program loading from a single BPF
> > > >  object
> > > >
> > > > Our use case involves a single large BPF object (skeleton)
> > > > with hundreds of programs where a subset is loaded at
> > > > startup and others are loaded/unloaded dynamically based on
> > > > runtime configuration. The current approach requires either:
> > > > - Loading all programs upfront (wasteful), or
> > > > - Maintaining out-of-tree patches to libbpf for selective
> > > > loading
> > > >
> > > > Last year we made an attempt to upstream our solution to
> > > > this use case to libbpf[1] but Andrii pointed out how our
> > > > approach was problematic for upstream. He then proposed
> > > > splitting bpf_object__load() into two steps:
> > > > bpf_object__prepare() (creates maps, loads BTF, does
> > > > relocations, produces final program instructions) and then
> > > > bpf_object__load().  We are trying to follow up on his
> > > > input and become more upstream compliant.
> > > >
> > > > The prepare() + clone() API seems similiar to this,
> > > > but the questions above about object state and FD ownership
> > > > are the main gaps for production adoption. Are there plans
> > > > to address these in future revisions, or is this
> > > > intentionally scoped to testing/tooling use cases only?
> > >
> > > I remember your use case. I don't think clone is really a great fit
> > > *if* you still want to stay at bpf_object/bpf skeleton high-level of
> > > API (i.e., if you want to use bpf_program__attach() APIs and BPF
> > > links).
> > >
> > > While definitely a complication, I think we can add support for
> > > loading BPF program after bpf_object__load() happened. You'd have to
> > > keep your optional programs as non-autoloaded (or
> > > bpf_program__set_autoload(false) explicitly), and I'm thinking we
> > > might want to make this behavior opt-in explicitly through
> > > bpf_object_open_opts(), as there are various points in bpf_object
> > > lifetime where we make some decisions with the assumption that
> > > programs will never be loaded, so we'll need to explicitly indicate
> > > that *all* programs would need to be considered loadable, but maybe
> > > much later.
> > >
> > > Another thing that won't (or rather might not) work is declarative
> > > prog_array initialization and struct_ops. Those two steps happen in
> > > bpf_object__load() after all programs are loaded. I don't think that
> > > is the problem for you, but I just want to point out that program
> > > loading is not always the last step.
> > >
> > > But other than that, despite added complications, it's probably bette=
r
> > > to just allow to load programs lazily after bpf_object__load(), after
> > > all.
> >
> > Thanks for the detailed info! We can start working on this ourselves
> > once we have some available time, we hope for your guidance during the =
process.
> >
> > Andrey
>
> Hey Andrii, getting back to this important topic -
>
> I reviewed the proposed solution and the code . An object-wide
> bpf_object_open_opts flag that means "all programs must be
> considered loadable, but maybe later" collapses two things that need
> to stay separate: a program that is not currently loaded but may load
> later (feature gated, config-driven), and a program that is
> permanently not going to load on this object instance (e.g. it
> targets a kernel symbol/struct field that doesn't exist on the running
> kernel, or it lost out to an equivalent alternative implementation and
> will never be used). Today those are distinguished by the autoload
> bool: false + never load =3D the second case. If the semantics of "not
> autoloaded" change object-wide to "loadable later," we lose the
> ability to express the second case at all -- every non-autoloaded
> program in the object now implicitly carries the cost and risk of
> being treated as eventually loadable, even the ones that never will
> be. So, every non-autoloaded program is implicitly pulled into
> relocation resolution and map creation, since nothing can rule out
> that it might load. For a program that  never will, that's
> wasted preprocessing, and if its relocations fail against this
> kernel's BTF, that failure is no longer isolated to just that program.
>
> Given this I wonder if it's reasonable to re-evaluate the approach of
> per-program enum from the original patch series we prosposed , rather tha=
n a
> boolean plus an object-wide opt-in flag. Keeping disabled as its own
> per-program state (excluded from relocation and map-creation, failures
> isolated) alongside auto and the new dynamic case state gets us
> the capabilities we want without forcing every already-
> disabled program in an object to be reclassified as "maybe loadable.
>

Goodness, 4 month since that discussion... I don't remember all the
details, we can start a new conversation and go over details, but I'm
just about to leave for vacation and Mykyta is still out on vacation,
so I'd suggest to restart this conversation with all the details anew
in about a month of so, if that's ok?

Explicit tri-state per program vs implicit tri-state (if not
explicitly disabled -> maybe enabled, if per-object setting is set) is
probably not the most blocking part of this. But again, let's come
back to this with fresh heads :)


> Thanks!
> Andrey
> >
> >

[...]
