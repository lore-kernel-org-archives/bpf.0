Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A83D34B3
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673256; cv=none; b=Hqu74VINNEmxqim5vI5n5ZIW+XVE+glIJYzBuyz0RL0pjWiXUEehSWXwCjwAUpMnNlcQH1v6ywtzQKtPBPrGHCHsdQ0egzUOwIU5a4zSYqP1hLWOERJ2JG7H6VQVtBC+kvzPb2AAjGMugPwH0FM0vsjzA83RizKCTcpg3MJSJ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673256; c=relaxed/simple;
	bh=VVEkbKwiBsYRD3iZyme183Vq4Bpw4Atk8uxtGQMx8Fs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UqpeU33DPhLXmMdZ7yfdJT1KDz97nZKfAYVqIDaRZirMRB893MpOzavkqvV9YUikI0+AtLRUBxAIsHJcPbKyifwZQiETK6pSH9ghLlWWiRAkHSyTgPjym0Iu4d6i1uVXYHygIuQGdqOhEWYsTYQuwUS3R+fEtkZd+A087ocbNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7QC7UFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7QC7UFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC721F00893;
	Sat, 10 Oct 2026 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791673243;
	bh=lX8Cz6quQi404J9wRU5A73B2+FHjCIKZhUPOjUWndKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b7QC7UFYSV3zVafQX5NM8iVYwS3ik/2s9RW+EDGW3KlA4Fdiij3sflUFXMUSduvGh
	 mvxgLA9UVK9M5WRMlCAGvAoYOYgg2NJfvc0LS+jWjf7yVxzeXApyrv8kiB4pozdOra
	 4BQMcWAZi2YR24Pu0NkffY/DTWKNKvOFDk50sNBaOfW4grcwxii+3L/PsQVYalCaV8
	 lEYwByUTVTuBbxMf1ThKO7+kWlDRz/HWZfPDLhgmLcit9h+aj71o+t1yczupqClOus
	 e5lek0iAaA1FMn1zigH7irdUVoiUkBEO+YLeGv0Do7yvQ0pqjo25KtK5btgnaOLirM
	 rZpMmq4WiLTCQ==
Message-ID: <sashiko-outbox-166917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] selftests/bpf: Test two-way arena access with two
 guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261010224902.1232178-6-arighi@nvidia.com>
References: <20261010224902.1232178-1-arighi@nvidia.com>
 <20261010224902.1232178-6-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 23:00:42 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/bpf: unaligned cmsghdr buffer causes undefined behavio=
r and SIGBUS
- [Medium] bpf: virtme-ng --numa argument risks unit mismatch in QEMU memor=
y allocation
--

commit f89b47f73364f408524cec1a644bd3003fa751ab
Author: Andrea Righi <arighi@nvidia.com>

selftests/bpf: Test two-way arena access with two guests

This patch adds a selftest to verify two-way memory access between
two simultaneous virtme-ng guests using a shared pinned host arena.
It establishes mutual memory exchanges using direct BPF loads and stores.

> diff --git a/tools/testing/selftests/bpf/arena_kvm.py b/tools/testing/sel=
ftests/bpf/arena_kvm.py
> --- a/tools/testing/selftests/bpf/arena_kvm.py
> +++ b/tools/testing/selftests/bpf/arena_kvm.py
[ ... ]
> +def start_guest(pin, build, kernel, index, vng, env, guests):
> +    node0_size =3D GUEST_MEMORY - SLICE_SIZE
> +    base =3D GUEST_RAM_BASES[os.uname().machine] + node0_size
> +    progress(f"Starting guest {index}: {SLICE_SIZE // (1024 * 1024)} MiB=
 "
> +             f"slice at file offset {index * SLICE_SIZE:#x}, "
> +             f"NUMA node 1 physical base {base:#x}")
> +    qemu_opts =3D (
> +        f"-object memory-backend-file,id=3Dsignal,size=3D{SLICE_SIZE},sh=
are=3Don,"
> +        f"offset=3D{index * SLICE_SIZE},mem-path=3D{pin} "
> +        "-numa node,nodeid=3D1,memdev=3Dsignal"
> +    )
> +    guest_command =3D [str(build / "arena_kvm_guest-init"),
> +                     str(build / "arena_kvm_guest.bpf.o")]
> +    command =3D [
> +        vng, "--verbose", "--run", str(kernel), "--cpus", "2",
> +        "--memory", f"{GUEST_MEMORY // (1024 * 1024)}M",
> +        "--numa", str(node0_size),

[Severity: Medium]
Will this --numa argument cause a unit mismatch in QEMU's memory allocation?

The --numa argument is passed a raw byte count (node0_size), while --memory
is explicitly passed in megabytes with an M suffix. Since QEMU's legacy
-numa node,mem=3D option defaults to megabytes if no unit is specified,
passing a large byte count could be interpreted as terabytes. This could
potentially cause the virtme-ng VM launch to fail immediately.

[ ... ]
> diff --git a/tools/testing/selftests/bpf/arena_kvm_host.c b/tools/testing=
/selftests/bpf/arena_kvm_host.c
> --- a/tools/testing/selftests/bpf/arena_kvm_host.c
> +++ b/tools/testing/selftests/bpf/arena_kvm_host.c
[ ... ]
> +static int create_arena(const char *pin, int socket_fd, unsigned int pag=
es)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts,
> +		.map_flags =3D BPF_F_MMAPABLE | BPF_F_ARENA_NO_FREE |
> +			     BPF_F_ARENA_EXPORT);
> +	char control[CMSG_SPACE(sizeof(int))] =3D {};
> +	char byte =3D 0;
> +	struct iovec iov =3D { .iov_base =3D &byte, .iov_len =3D 1 };
> +	struct msghdr msg =3D {
> +		.msg_iov =3D &iov,
> +		.msg_iovlen =3D 1,
> +		.msg_control =3D control,
> +		.msg_controllen =3D sizeof(control),
> +	};
> +	struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(&msg);

[Severity: Medium]
Does declaring the control buffer as a plain char array risk alignment faul=
ts?

The control array defaults to 1-byte alignment, but CMSG_FIRSTHDR casts it
to a struct cmsghdr pointer. Accessing its members (such as cmsg_level and
cmsg_type) requires the pointer to be aligned to the architecture's word
boundary.

If the compiler places the char array at an unaligned address, this could
invoke undefined behavior and cause a SIGBUS on architectures with strict
alignment requirements. Using a union or proper alignment attributes would
satisfy POSIX and C standards here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010224902.1232=
178-1-arighi@nvidia.com?part=3D5
