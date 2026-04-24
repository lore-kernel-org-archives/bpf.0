Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C4314D05
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060799; cv=none; b=gT/dG+dN8LCqZ84nr6be1gBJrmcUqOb9ukj6m3CMd9Ay8YE97JppKsuccU3IjbWnSCscuraz4zWPisV2Zzvu0bA08LRS47Ev3YiSYhJtGqdBIASdJ4tfEf6Gs52H+xU7893W+EqgSFkyvRGIlkMuTyuVFdMR+aSSETh8GvSQ1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060799; c=relaxed/simple;
	bh=5TRmimcbL5n1eMj5CGuan6fEUknX6KY8PepSwVFCXdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ChQGqwy61unA+EJnK+EvwKEVbQ2Bmtxx55bMiScfJvj5Vqd7bBt/xDu2oetXbHLtNPMsm07amTtR58enYUKyypjjODN2iJIG4pox/635I639WK/PWtaX4EvpMvv+X2s1MzqUr9vijdqc3m22XdWN7ZCcJdrD3CEYN/fvUHfeK1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTkn1m8g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTkn1m8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED4EC19425;
	Fri, 24 Apr 2026 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777060798;
	bh=5TRmimcbL5n1eMj5CGuan6fEUknX6KY8PepSwVFCXdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uTkn1m8gYzQTfFhgT4PqF3o1m4d7v2K+6o24mat9sV3XMC7ye1aLJX9ruBhgLdYzG
	 RNkuOJxG7Rtt/t3JhCs6gB+Bf1LLD9d2eGBxl9cj3ew5ghqsTGTvO9JvubtIuddRmh
	 dPxWGE/FNil8Oio2NXlO1yNeVqiXbAZmHe0j/B8SRwsjgofvY6KwLnaDugzQVDa98o
	 8NEk18PSJSAisrCqFMYsvLm7a+VcqSp5HMP2GPmsNJnVQrc0DOdyWcHPoNQUL4QiFU
	 6uPj57SxbDghwhGpgf160vxLce4s5qbinWuvQZTg6N797UlvOW0oK5oaetudPFfLdG
	 If+ju/g31kbjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Implement dtor for struct file BTF
 ID
Reply-To: sashiko@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260424192252.695240-2-utilityemal77@gmail.com>
References: <20260424192252.695240-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 19:59:57 +0000
Message-Id: <20260424195958.AED4EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Calling `fput()` directly from `bpf_file_release_dtor` can lead to=
 a hard deadlock when invoked from NMI context.
--

commit 6368f91be1fd91bc9cb38d3498f35d279bad04c9
Author: Justin Suess <utilityemal77@gmail.com>

bpf: Implement dtor for struct file BTF ID

This commit implements a destructor for struct file, allowing it to be
stored in a map as a referenced kptr. The destructor calls fput to
release the reference.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 2bb60200c2665e..ee5ceb82e4f812 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
>  }
>  CFI_NOSEAL(bpf_task_release_dtor);
> =20
> +__bpf_kfunc void bpf_file_release_dtor(void *file)
> +{
> +	fput((struct file *)file);
> +}

Can this cause a deadlock if the destructor is invoked from NMI context?

If an NMI-context BPF program (such as a perf event tracing program)
updates or deletes a map element containing a struct file kptr, the BPF
framework will synchronously invoke this destructor to clean up the old
kptr.

When fput() drops the reference count to zero, it calls
__fput_deferred(). Since in_interrupt() evaluates to true in NMI
context, __fput_deferred() bypasses task_work_add() and instead calls
schedule_delayed_work().

This leads to the following call chain:

bpf_file_release_dtor()
   fput()
      __fput_deferred()
         schedule_delayed_work()
            add_timer()

The add_timer() function attempts to acquire the timer_base->lock raw
spinlock. If the NMI interrupted a thread that was already holding this
lock, the NMI handler will spin indefinitely waiting for it, resulting
in a hard deadlock.

Would it be safer to defer the fput() operation using an explicitly
NMI-safe mechanism like irq_work_queue() to handle arbitrary BPF
contexts?

> +
> +CFI_NOSEAL(bpf_file_release_dtor);
> +
>  #ifdef CONFIG_CGROUPS
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424192252.6952=
40-1-utilityemal77@gmail.com?part=3D1
