Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDF34751B
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132293; cv=none; b=egciUGNYHLHXt7dmGCXipB4/2CcDy6Klv+BXfYy2I/9YZILOY4zue6AiPrJhBH3HH6I65YrMM7krn7Rxf5UIzG927XRK4wZaLOXm7x8n4rFcGrKG3BicFFWBPD6m7op+3fJUG++bORl6b77TrBl/pAu6G2lweH9u1zgSxO58hTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132293; c=relaxed/simple;
	bh=wZxy+hJcU7MOVjwhO/q7BaISLo7QmjKenTNxBmZ3eMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q29cgzkRFW51XHcBlnMRgOBhffA3szZQapIWqpUZ7tVQ9CNBRKt3ldJzRTziivNt+biluYrfRlmP1wtma4/KlACG0CEFL6cP0OPmRiqZPLFlxd5hKOs5s+I77+Qi2k0bTemhAmmWdKkvWfhZO48Fzn4IT4amnfNCJf2rJrKM+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVL93weG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVL93weG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DB11F000E9;
	Fri,  7 Aug 2026 19:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786132292;
	bh=wZxy+hJcU7MOVjwhO/q7BaISLo7QmjKenTNxBmZ3eMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EVL93weGEFNbYnfK2uPOikVhH8HaTA5m2TtjtDsNxJoiLw5YcHwa2HVtb1kLxS2y4
	 QwRK4750G2RjIp7IxeWL4qxQwH5Iof6Fga1MOtMobZoITSiDlE3nnD/RfjypyWphM+
	 UvOXlA3ALyVjaQEWOC/6EWDEi1VPDpEtueRdjBvhymyiFJVY0wFUIr5wqleu3sDPqD
	 kODrG3GTGWvAO6t1KKAG4RdPGxT1GvR6+9xw37qR6L6B43jl5DmkFk6DtmzyfNFbJG
	 /7VPe1Wa5g6eBcW6fc47Ljf3sqC3ZvFZx9UvHUFFVmxxbVER3Cj4QbBasiK6UbRnEs
	 t7erEyxbnbU7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/bpf: add test for blkcg io.stat BPF
 kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziyang Men" <ziyang.meme@gmail.com>
Cc: bpf@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, tj@kernel.org
In-Reply-To: <20260807193732.4073299-3-ziyang.meme@gmail.com>
References: <20260807193732.4073299-1-ziyang.meme@gmail.com>
 <20260807193732.4073299-3-ziyang.meme@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 19:51:31 +0000
Message-Id: <20260807195132.13DB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment violates the BPF subsystem comment style guideli=
nes.
--

--- Patch [2]: [PATCH 2/2] selftests/bpf: add test for blkcg io.stat BPF kf=
uncs ---
commit 0012ecaba2bee2bf79e38a8039b4f591d01a624b
Author: Ziyang Men <ziyang.meme@gmail.com>

selftests/bpf: add test for blkcg io.stat BPF kfuncs

This commit adds a cgroup_iter_io selftest for the block I/O controller
BPF kfuncs. It uses a BPF iterator program to flush stats and read io.stat
counters for a target device, comparing the results against the cgroup's
io.stat file. It also validates the root cgroup's block stats.

> diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter_io.c b/tools/t=
esting/selftests/bpf/progs/cgroup_iter_io.c
> new file mode 100644
> index 0000000000000..b839def945086
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cgroup_iter_io.c

[ ... ]

> +/* Set to 1 by cgroup_root_blkcg_query when bpf_get_root_blkcg() succeed=
s. */
> +__u64 got_root_blkcg SEC(".data.query");
> +
> +/* Device to read, set by userspace (kernel dev_t). Pinning the device k=
eeps
> + * the read deterministic and lets the value be compared to io.stat exac=
tly.
> + */
> +__u64 target_dev SEC(".data.query");

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred
BPF subsystem formatting rules?

The guidelines for files under the BPF subsystem require the opening /*
to be placed on its own line before the text begins for multi-line comments.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807193732.4073=
299-1-ziyang.meme@gmail.com?part=3D2
