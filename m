Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378113E1222;
	Mon, 31 Aug 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168270; cv=none; b=OY5s1zhfl+yllMjmaMTy6XxwjE78sJ/+6+7U8MN0FVL+PiF9+3wosSpGt5JRiYoSnp+FIHteyA/Oxj5zGkwyf58uhoKub9vMmqducfFI/9MRARzQb8PvjQqXC4eCKAFLqWLt5fLK1tA9+88aJXssAppdm/vjYm+UuqYIwEN4Xyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168270; c=relaxed/simple;
	bh=Rz/DTEMhmqQ5Ky4PtHkLLsNtAPyHlxzNB8nf//Des3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S3X5hpsBZKzIHRw0G2G/CArbIMHWRxZDLP50frhV9+lHHlBF0cIsQG5w9yxPnu239AwPW/U7I8GrdwOSVR+8QNyAeCitGY62GUKD74DF0o4TpAI3fIClR6E1zhtF9aaIq6w38otXsi2gJ7C9qrbawWXxa2FeTTcvtrK1TYZNRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip2lDVRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip2lDVRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554A41F000E9;
	Mon, 31 Aug 2026 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168266;
	bh=HMEVd3HS03tvlS1R/R4wiU2kb/z6XAmK8k07VW4f2Gw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ip2lDVRvH44B1xQWkS7mZKtPTf2Nos4bFyCRyLLyhKMhbt6395Dq9NeVMgP0xZC5W
	 lcv0RbWvLpmggTbR0QFaC8Bd4eKbPmof3aLoTTOtH2HeL9cFosiJE0lvs7zB5DomHU
	 YNP/CRfOZbV91jLynHMjOECiOhYXPvxs/XJsEGwPnI/TCyhDfBFXLo9j4BiOll568h
	 YEHx3Ehu9PRQW8CFf6Sj+hpRrOa76tAq7RLyJiyGiRr6WceQJSvUBAV5tocL/zDk+S
	 /jN88G9gCUwk2OtVyunl+O0Wt2ruPa48UuBb7cERtMz/JrSOU6ulst0zns596Vmr3w
	 TeAJ53lq7ad9g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/20] rv: Handle unregistered monitors safely in
 tracefs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260831090524.106845-10-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <20260831090524.106845-10-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:24:25 +0000
Message-Id: <20260831092426.554A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The validation check `rv_is_monitor_registered` is vulnerable to=
 the ABA problem, allowing operations on a stale file descriptor to imprope=
rly manipulate a newly registered monitor.
--

commit abab0e30c495cd011906fb219545b8b62d268a11
Author: Gabriele Monaco <gmonaco@redhat.com>

rv: Handle unregistered monitors safely in tracefs

This patch adds checks to ensure that a tracefs file descriptor's private_d=
ata
still points to a registered monitor before allowing read or write operatio=
ns.
It aims to prevent use-after-free scenarios when pluggable BPF monitors are
dynamically unregistered while their files are still open.

> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 33919c5fbd6ad..6ddd3b92da1db 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -245,13 +245,31 @@ struct rv_monitor *rv_get_monitor_by_name(const cha=
r *name)
>  /*
>   * This section collects the monitor/ files and folders.
>   */
> +
> +bool rv_is_monitor_registered(struct rv_monitor *mon)
> +{
> +	struct rv_monitor *m;
> +
> +	list_for_each_entry_rcu(m, &rv_monitors_list, list,
> +				lockdep_is_held(&rv_interface_lock)) {
> +		if (m =3D=3D mon)
> +			return true;

[Severity: Medium]
Is it possible for a newly registered monitor to be allocated at the exact
same memory address as a previously unregistered monitor?

If a privileged user opens a monitor's tracefs file, the monitor is then=20
unloaded (freeing its memory), and a subsequently loaded BPF monitor happens
to be allocated at that exact same memory address, it appears this pointer=
=20
equality check would incorrectly evaluate to true for the stale file descri=
ptor.

> +	}
> +	return false;
> +}

[ ... ]

> @@ -384,6 +402,9 @@ static ssize_t monitor_enable_write_data(struct file =
*filp, const char __user *u
> =20
>  	guard(mutex)(&rv_interface_lock);
> =20
> +	if (!rv_is_monitor_registered(mon))
> +		return -ENODEV;
> +
>  	if (val)
>  		retval =3D rv_enable_monitor(mon);

[Severity: Medium]
If the registration check passes due to the reallocation scenario described
above, could a write to a stale file descriptor improperly enable or disable
the newly registered, unrelated monitor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090524.1068=
45-1-gmonaco@redhat.com?part=3D9
