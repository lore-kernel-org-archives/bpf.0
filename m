Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008633148D0
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776983523; cv=none; b=auzm8anjLWKA6BopXIxgOdKvq9QrYrNw6T7TYobm1I5YAjMiOiZ9uY9oikXfV3vA9+n1llXPK70YEyeuc+yQKij2CJiCGHC8eh+HKoCT0FMupf2poXoNOPZWr2+kCXHk2XVwRPOT+OmiWuNF7uGp1VYchleyIeCzSzAcJBpLESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776983523; c=relaxed/simple;
	bh=iXrar3GvdrqbiM1AKfYYgTp1X+EGzk734CMrqDY0ur0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDZPzo0Ybip6siJQPpv2BLamC+t9ETsbpwflt5Vb5+XuuMedp0UarTjT/KTb84yleDnvAyJeE+cIgZnP5jwVRxJgOwRRoZ+9tDaKhX34eiVjaKrCupgpbn8kKUPLIPlKWFoia+732sTZw+LJ0wpoCjEEyjB7tGXanyQxcT1mJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFmBKoLI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFmBKoLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7237EC2BCAF;
	Thu, 23 Apr 2026 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776983522;
	bh=iXrar3GvdrqbiM1AKfYYgTp1X+EGzk734CMrqDY0ur0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HFmBKoLIsp4x40qSZZinkMCUTZpfOaky3AZ5QRQRtsqwS3miNjBTzs4Ny7MZIRdLe
	 xMeFjBmHp4B+o+A6WY7QP2iOl5I7DpY6QBGMt0ZL3kPvYRlqjPDPHPTU8mc7pn4ZD5
	 bJ8W+6xikwVa80XfS7diF728OvzscAdV+RLKiQEB3/Zr+CM5FMogqKh9A96fTRXGEw
	 eH7zf9+cgwpCcrA2jVjkHlyhT1RwXv9UFFe70cdNOSeSY2logkYaeTigdj5znyCrFp
	 qhKU4E/IL1NwZCG5eK/sqq3iCHolYBxU09p12reD93sllGRInXfLS5dcDBxkp4cPHz
	 UPhXjbdjR0cKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Implement dtor for struct file BTF
 ID
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260423152239.4140627-2-utilityemal77@gmail.com>
References: <20260423152239.4140627-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 22:32:01 +0000
Message-Id: <20260423223202.7237EC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] bpf_file_release_dtor calls fput(), which is not NMI-safe and can =
cause a system deadlock when a struct file kptr is dropped from NMI context.
--

commit 37dfae0a149d4a18858208a4dfafb133d94b8e0d
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Implement dtor for struct file BTF ID

This commit implements a destructor for struct file, allowing it to be
stored in a map as a referenced kptr. The destructor relies on fput() to
release the file reference.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2bb60200c2665..ee5ceb82e4f81 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
>  }
>  CFI_NOSEAL(bpf_task_release_dtor);
> =20
> +__bpf_kfunc void bpf_file_release_dtor(void *file)
> +{
> +	fput((struct file *)file);

Can calling fput() here lead to a system deadlock if the destructor is
invoked from NMI context?

When a map element containing a struct file kptr is replaced or deleted, BPF
synchronously calls the destructor on the old pointer. BPF map updates can
be performed by programs executing in NMI context, such as perf event
programs or fentry programs attached to NMI handlers.

If the file's refcount reaches 0, fput() invokes __fput_deferred(). In NMI
context, __fput_deferred() skips task_work_add() and falls back to calling
schedule_delayed_work().

The schedule_delayed_work() function queues the work using add_timer_global=
()
or add_timer_on(), which acquire the timer_base raw spinlock. If the NMI
preempted code that was already holding this spinlock, the system will
deadlock.

Does dropping file references from BPF map destructors need to be deferred
using an NMI-safe mechanism, such as irq_work?

> +}
> +
> +CFI_NOSEAL(bpf_file_release_dtor);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423152239.4140=
627-1-utilityemal77@gmail.com?part=3D1
