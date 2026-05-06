Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46B42FDC38
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096816; cv=none; b=PosnNW617lq2x2MPBqp4JO4ke6rEskrKwDU/ouzSdZegMXtvQwZhnaWb/v4/a1Ujf4Q7DlI+uiugKXgl7C12jh1KT0T00bhWHRrCWog+5IAxUtjZcyAAU9PcluoCJCpFaiErbK51nxX8PlUJXuFZSMsC0E1PHsOnOEVOI6Fjsro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096816; c=relaxed/simple;
	bh=XBNDL4CJFBw8l9o/x8Dqwpun1LKl1TCA7S89kHjtJsA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uJIMqLTB+ytLv9I3E+FWhc1Ng4tBYmp5rZ/rIoWUW6p9Fme3ZKju7BLS8sE3IxyH3e+yxsOhIiSofq+/ILzPehKMSqO9SqQWLqH5Dijm5kDSoqWa7jM6S3g1cJqsUqemmDdojZDOVhjPiBjCI8nham3lb1N76CGa8VrfhRv+pxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb1MvDYf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb1MvDYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549DFC2BCB0;
	Wed,  6 May 2026 19:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778096816;
	bh=XBNDL4CJFBw8l9o/x8Dqwpun1LKl1TCA7S89kHjtJsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Qb1MvDYfs9jCmnNkp3o/Sju+aQTLFo2gQLi/nhTGMF4DrPw6VeIuidMjO5iGH3ona
	 zGdkg3KXNh4Kc83/RH3+dBw5A1XyGFOWFMlmTyo0JLl+lKTGmSBUcDYTh1E+aos3X5
	 3J0gK12dQjsElGperwCHbLTS7m2NUw8m8woSMaof9R/wyGXkUXN7XdeBrBL5qariYP
	 jejpzMQl87eEl+yUfZHQt+m3MS+dPV4sEm80iCu7HxSfhKvp7W0puO/X2ndLJNXC/t
	 vkiXOFAoPx4S/M6zhVeWCKMkS4SWwaGGs5GHEzVxOkKH6sAmX5z9pol5OGQR25vG6x
	 tGXp+tSBnt2TQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] bpf: render CGROUP_LSM_NUM configurable as a
 KConfig
Reply-To: sashiko@lists.linux.dev
To: "Paul Houssel" <paulhoussel2@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506131257.713895-2-paulhoussel2@gmail.com>
References: <20260506131257.713895-2-paulhoussel2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 19:46:55 +0000
Message-Id: <20260506194656.549DFC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Setting `CONFIG_CGROUP_LSM_NUM` to large values (e.g., 300) causes=
 a stack frame size violation in `cgroup_bpf_inherit()`, breaking the build=
 and risking stack overflows.
- [High] Increasing `CONFIG_CGROUP_LSM_NUM` massively bloats `struct cgroup=
` for every cgroup instance system-wide, causing severe un-reclaimable memo=
ry overhead.
- [Low] Setting `CONFIG_CGROUP_LSM_NUM` to 0 creates a global zero-length a=
rray.
--

commit 51a90971268ad1dbaa85eb0becb17cac4d98af78
Author: Paul Houssel <paulhoussel2@gmail.com>

bpf: render CGROUP_LSM_NUM configurable as a KConfig

This commit introduces the CONFIG_CGROUP_LSM_NUM Kconfig option to allow
configuring the maximum number of simultaneously attachable BPF_PROG_TYPE_L=
SM
programs per cgroup. It replaces the hardcoded limit of 10 with a
configurable range from 0 to 300.

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f09..7f51598aa8fe6 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
[ ... ]
> @@ -101,4 +101,17 @@ config BPF_LSM
> =20
>  	  If you are unsure how to answer this question, answer N.
> =20
> +config CGROUP_LSM_NUM
> +	int "Maximum number of per-cgroup LSM hooks"
> +	depends on BPF_LSM
> +	depends on CGROUP_BPF
> +	range 0 300

Could this large upper bound cause a stack frame size violation?

In kernel/bpf/cgroup.c, cgroup_bpf_inherit() allocates an array of pointers
on the stack:

    struct bpf_prog_array *arrays[ARRAY_SIZE(cgrp->bpf.effective)];

The size of the effective array scales directly with MAX_CGROUP_BPF_ATTACH_=
TYPE.
If CONFIG_CGROUP_LSM_NUM is configured to its maximum of 300,
MAX_CGROUP_BPF_ATTACH_TYPE becomes 329. Allocating 329 pointers on the stack
requires 2,632 bytes, which exceeds the standard kernel stack frame warning
threshold (CONFIG_FRAME_WARN=3D2048).

Does this large upper bound also bloat struct cgroup for every cgroup
instance system-wide?

MAX_CGROUP_BPF_ATTACH_TYPE dictates the size of four arrays embedded direct=
ly
inside struct cgroup_bpf: effective (pointers), progs (hlist_heads),
flags (u8), and revisions (u32).

Increasing the limit from the default 10 to 300 adds over 6KB of memory ove=
rhead
to struct cgroup_bpf. Because struct cgroup_bpf is embedded within
struct cgroup, this results in >6KB of un-reclaimable slab memory bloat for
every single cgroup created system-wide.

Could a minimum value of 0 create a global zero-length array?

If set to 0, the declaration in kernel/bpf/cgroup.c expands to:

    static struct cgroup_lsm_atype cgroup_lsm_atype[0];

While GCC supports zero-length arrays as an extension, declaring a static
global zero-length array is non-standard C and can trigger warnings in
fortified builds or with stricter compiler flags.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506131257.7138=
95-1-paulhoussel2@gmail.com?part=3D1
