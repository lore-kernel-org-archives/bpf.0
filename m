Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F05492E28
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086624; cv=pass; b=fDxObDRtBmZ9U1DTUugxcT+x2QHLY6oSpgHfYKXW2f4RZR+yIzaI2pFpPSs2GDUQRxb5JcGgYM5QZoeLTDLK9TOW/bU35V3avfd8B8jEGHgaOc3VGU6Y5DNBufWah9MyzT8vTgAr+ZOVjtqDUgeeJZPqR1tUtCWBD4CPTPJdsmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086624; c=relaxed/simple;
	bh=7YFXKS/Ovq5nmb87+5GgKF45XBX6llfelH6aYSrZ1Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfKwYrwUth9pqRb34e/CVdf0pHetNJdtWZn4SWNFWfX19z26EfdAECGxEBWzJPZ0ZFl5piZLeyyTtIXGKdsw5Mtv1GE8tTlw4yvYzGgCRqaVgonM65d6XgDuBKWRwPrq/PeGv+QhdOs3IremNkMK8WgGCeyRY8yT/D9LfBvA3j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0pT6s6T; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0pT6s6T"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ba429b64c5so534e87.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 10:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792086616; cv=none;
        d=google.com; s=arc-20260327;
        b=IgnBbjmpVcThoOKNh/6m+sFbxjR5HG0Jb0/GDH/0zPnI6/IOm2VWOytqSTeL8r475M
         R7FpqeJFPuNuIX4IIhrqV8kwovoBxsTJa40xKUNqcawCItU7gotcAqrLvgzBlJuBwJxK
         Tpr9h/YR+1shMclHGBseDFX3i+CZsaXEuY7RRhkbq4X0+R0k4k/AK/O4KL71mu6biWMc
         bq2HAUuFsRof3tnIXezCbGavAtKk3k8rIHjWZQCFP86LZIKwhl15Hu/2RYUPAUaulYgc
         7Yj8GCXAgQbU8h1UP/jJMPsCcAcNBIS4kdNpyVV9gYhSIZm2Yk1HqonQx407xlGA4p2Z
         VeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yx75TLD9o3QgT7N/FNciO3xo0DqIeTswE4S8o7myHzk=;
        fh=sksbbmV9wCA2eMb2eTVr8CUXlb43s3HJM9kxHbr5A6M=;
        b=QwFL6PW9VTgTk0CM+aqBn1WzjND9IRlpYNzOTHeXGRJ9vWVooMXKNxHXLJ6Wp7k3gj
         sZZrHYOHKmRAFXYIi2xd7uqC06uL+Y76WHvqWE6VU46mL8iLqr/0ibtZA4N7Ub6WOmgg
         jQ+r6B6RcUF0zbp0eqh4HUCQgRaW0oHxNat4pulw/UkBt/B6ZQ/E7ZCatuqWk8rtWH34
         bl8gBjI9eEPohS2cObp2TUEYXw6bKFrTlUZl8WnXeGvXSdlLfkItGM8TgckCL8Eb1Qtq
         y3i2jC7czZ8wuXOWbMcxmiPwo6ioBvoMTwS0RBxHj4xQVH/VOOKsGvy6WUq6s5452/qg
         Ympw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792086616; x=1792691416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yx75TLD9o3QgT7N/FNciO3xo0DqIeTswE4S8o7myHzk=;
        b=H0pT6s6TJcjMa5xN5lPyy2nzM6ufCFcUF5FgzmU7TjBkz3PRRYRe3HQPWuxWMVWmhg
         aWk14jc2GewPHK22ylxqCHHSYYC1kML8UwZ2bk2lV7ruDG7llWJ/twVhXrfrGQiSyiIU
         v/2mNLCb2uTG+cx1V7fMbmYxiwZbj4f5s+iBBe0kVPLGdo1grhRdR04foIlfVBo5ljA9
         ZhQAUKcnkhXfOBcmWp96khyhEOrDAvOdc+j5BqRhDCdHHxncvTG+TtRJ6yA/phDqG3NN
         3LDO5QopnHevJma7KTgpIi8XKXy2Bc+7c/Ynb2a/U9+4GNocU+iLsU87AW+gMk7/ov95
         FW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792086616; x=1792691416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yx75TLD9o3QgT7N/FNciO3xo0DqIeTswE4S8o7myHzk=;
        b=NxWiK9hN+y0Z61HVRexl2iFMybI3dDBWdAMxNqbT7lxu3zNYQ07PBBh1MTYvdEOPa1
         cdFIscTTJA+L6OULRpC2ZZsCN3GK3pmbI8HlTrx1hzEQqBuhkpztehzkL6316wbNA6wn
         zQZ+aacY8IZk5GurLWElM/I7Xvuzd9HqGG8qdxEZ5uyqk2U6vEH59kzyshjHnOGGs/Nt
         F1MN1kS32q6ci2C4DY7PhZASFevmOr8DW+GL8I4tFy/wP+tjkSn1f+wgYjT1yj7vDPSU
         pK89yrwO/S1s+cZrDpcUEcJvooYqBvzlLVRjHlTVavgIAkNYXudc6Kh1HVHUJDDxWudg
         Jupg==
X-Forwarded-Encrypted: i=1; AKwUvBx9IPEv5gfPfEiscpyljBLT/geVFwFMx8CxaCjg8pTeRGg1pnQP8sjHtSA4RnaIdne3WOI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK29E9ZsbVhON2/KMgRfLEyFasSBQHUd3y7eN80fKkDQ2be9dq+
	E+eGmTeMoyT7+UhsnRXs2zgoiETVbqoGBEP47IDowKWmZH/06jgfVcCxibzc79CniENYXwNXxAl
	RPi56OOUAoBl4Ep+AMHqQQJ0H2B4g5n4GMZE3dmir
X-Gm-Gg: AYBFou1TYpzt3VGp+fFV7JLFV6xlRGxtHYoKls13F56/YYUi/rwHSqlqcufCoP3tgAC
	kTNEyyylgJQJy0/zNNhTFzQ4JyrMc0EX8SwUnzLzeiKzQbgOOYX6bAhYxVADcZJSY/P+qPmnVZv
	liTwEOO+bg6++Ac/8nDdmE62LAhUohzmu0ToGlSpf+XAwiBqPjn11eceYNV4CS+au5KkCopaweH
	1zia/AZ8ZD7qa6RdPblJFTk1eKniLp86gW3A0/E5pdBH0fBHs0AkIHjn/KjCSHS685LzPtKq5OT
	w0AOM8vcHUD/UBxD3P8Zb6vnid29IoXR/HIPc+F3NRB1QQaaLUtDH29DmnfK0JRH/6utyZaRZrz
	gCkaZlgtM7Pie
X-Received: by 2002:a05:6512:15a5:b0:5b8:d04b:a1be with SMTP id
 2adb3069b0e04-5be49062033mr12408e87.2.1792086615838; Thu, 15 Oct 2026
 10:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010224902.1232178-1-arighi@nvidia.com>
In-Reply-To: <20261010224902.1232178-1-arighi@nvidia.com>
From: Josh Don <joshdon@google.com>
Date: Thu, 15 Oct 2026 10:50:02 -0700
X-Gm-Features: AclHuK9lirj1gDypxoTAo704_sbQDLhEJ7aMOCxHqLEYPUpC9luru9DQF83Mh7g
Message-ID: <CABk29NuGMO+HUQzegh6mvy2zjQRD=-rOkiroeCwyTEAeTTsEZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs files
To: Andrea Righi <arighi@nvidia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Vineeth Pillai <vineethrp@google.com>, 
	Balbir Singh <balbirs@nvidia.com>, Shameer Kolothum <skolothumtho@nvidia.com>, 
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>, NchangRoy <royfru44@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peilin Ye <yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

Thanks for sending this out, I'd really like to converge on a shared
memory model that will work for both the goals of phantom tracker and
for pvsched :) Been thinking about the tradeoffs of this vs the
current structure of shared memory that we have in pvsched v3. I think
this definitely brings some nice properties, but I have some
questions/suggestions inline below.

On Sat, Oct 10, 2026 at 3:49=E2=80=AFPM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> As discussed in the BPF track and the sched_ext microconference at Linux
> Plumbers 2026 [1][2], shared BPF arenas can provide a generic channel
> for bidirectional zero-copy communication between BPF programs running
> on a host and its guests. One potential use is to exchange scheduling
> hints between host and guest sched_ext schedulers through shared memory.
>
> The goal is to let both schedulers access the same underlying pages as
> BPF arena memory. Exchanging hints then requires no copies between
> separate host and guest buffers. With the arena file interface proposed
> here, the setup uses existing QEMU/KVM memory backends and guest NUMA
> interfaces, without further kernel or hypervisor changes to implement
> the communication channel.

Seems this relies on QEMU support for supplying offset+size for a
virtual NUMA node; looking quickly this would seem to need additional
work to support on other VMMs like CHV (and especially crosvm). Not a
showstopper but just a comment that I think the PCI device model is
easier to integrate in other VMMs.

> A host scheduler's userspace component can create and pin an arena map,
> then use an arena allocator to partition it into per-guest chunks.
> Userspace passes each chunk to QEMU as a shared file-backed memory
> backend, using a bounded offset and length in the sized bpffs file.
> QEMU exposes only that chunk as a NUMA node inside the corresponding
> guest; the rest of the host arena is not mapped into guest RAM.

So this is the host allocates, guest uses model. Contrasted with
pvsched v3's guest allocate, host pins.

Guest still needs some way of communicating back to the host which
pages correspond to which data. Ie. a mapping of VCPU -> address
within this arena memory that the host can then use to lookup per-VCPU
info written by the guest. This comes for free with the guest
allocation model in pvsched. I see you allude to this requirement
below.

Another thing missing here is a doorbell, so this approach doesn't
obviate the need for at least one guest BAR. If we have that, it's not
a stretch to use an additional BAR for communicating the mappings (as
pvsched does in v3).

> The guest scheduler can create its own arena and allocate pages from
> that NUMA node. Those guest physical pages are backed by the host arena,
> so host and guest BPF programs can access the same memory through their
> respective arenas.

Two nice things here that we don't currently have with pvsched. One is
that the host BPF programs can directly read/write the arena memory
without needing an additional special kfunc to grab the right pointer
(for pvsched specific BPF hooks in the host we intend to pass the
pointer in the BPF context, but for sched_ext programs we intended to
add a kfunc to e.g. lookup the pointer by VCPU).  Second, the memory
here is arena memory, which is quite nice. Currently pvsched just
interprets it as a struct with a large data blob. Ideally we'd like to
convert the pvsched model to use an arena.

Some additional drawbacks of the guest arena allocation you describe here:
- The extra NUMA node can presumably be used for unrelated
allocations; there's no way to isolate it for just the purposes of our
arena? Guest kernel and other guest userspace could allocate on that
node.
- Memory allocations targeting that NUMA node (for the arena) could
fail to find free space and fall back to another NUMA node; that at
least seems solvable by forcing allocations to only come from the
targetted node though
- This removes flexiblity of the guest to allocate memory how it
likes. For example, with pvsched the guest can allocate the per-VCPU
pages from the guest virtual nodes where those VCPUs reside.
- I don't think this works for confidential VMs? You'd end up needing
the guest to share the pages back with the host, which is essentially
what the guest-allocates model already does

I would definitely like to have the memory come to BPF via an arena
for the flexibility of use, but I'm still a bit hung up on the host
allocation part. I had been thinking about how to make the arena work
using guest allocations, but nothing super concrete. Essentially the
guest would create an arena and allocate pages, and stash the GPAs in
the pvsched BAR. The host would need to pull those pages into its
arena and deterministically allow access to them.

> After identifying the corresponding arena offsets,
> both sides exchange data through direct BPF loads and stores. Arena
> pointers are not relocated between mappings; a shared protocol can use
> validated slice-relative offsets instead.
>
> QEMU is one potential consumer. The interface is generic: it exposes a
> pinned BPF arena as a sized bpffs file that ordinary userspace consumers
> can open and mmap, including consumers that require a file size when
> setting up shared memory.
>
> The series separates page retention from file export:
>
> * BPF_F_ARENA_NO_FREE makes BPF page-free operations no-ops, retaining
>   allocated pages until the map is destroyed. This flag alone preserves
>   ordinary arena pin behavior.

Does this imply that the arena remains allocated at its highest
watermark, regardless if we have VMs leave the system (and thus the
host attempt to free the arena pages that corresponded to the departed
VMs)?

Smaller note: we probably want to at least make the free operation
zero out the page so that no data is leftover when we reuse that page
(ie. for a new VM).

> * BPF_F_ARENA_EXPORT exposes the pin as a sized file and requires
>   BPF_F_ARENA_NO_FREE, so BPF programs cannot remove backing pages while
>   external consumers may still use them.
>
> The map FD retains the canonical BPF address range. Exported mappings
> can select different virtual addresses and map disjoint slices. Faults
> resolve by file offset, and page zaps cover only the overlapping range
> in each exported VMA. Consumers establish the canonical range through
> map_extra or a full-capacity map FD mapping before mapping the pin.
> For exported arenas, the canonical range matches the fixed file size;
> ordinary and retention-only arenas still allow shorter mappings.
>
> Pin permissions distinguish readers from writers. O_RDONLY consumers
> can create read-only shared mappings, but cannot request writable
> mappings or acquire write permission through mprotect(). Private
> mappings and file size changes are rejected. Open files and mappings
> retain the arena after unpinning until the last reference is released.
> The capacity is initialized before inode publication and can be queried
> with fstat() or lseek(fd, 0, SEEK_END).
>
> Exported mappings retain the arena's lifecycle restrictions: they are
> not inherited across fork and cannot be split, expanded, or relocated.
> The documentation describes these limits and native tests exercise them.
>
> Access through open() and mmap() intentionally uses filesystem
> permissions and the applicable file, mmap, and BPF map LSM checks.
> olicies specific to the bpf() syscall, including seccomp filters on that
> syscall, do not govern this file interface.
>
> [1] https://lpc.events/event/20/contributions/2429/
> [2] https://lpc.events/event/20/contributions/2482/
>
> Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git =
bpf-pinned-arena

Best,
Josh
