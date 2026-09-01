Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89613F9F44
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228874; cv=none; b=rGpB1vOnjeYfx4Zd7et3x2wgkrlZ7TS0e1DWNyxnjFXW+3grXVv/OQzNFUD8yPjoUxTd/BPqqaWRsSXIH2Nqm8v+ARcWS1MMDUulL+mUMGiLkPBMa9zh1KEOjPsf/oX5V+uaIbiJScjoscszegA4B6Pyu7+V1J1AhxSwPYnrYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228874; c=relaxed/simple;
	bh=ImdXiOhMpkiY6I2lRKAuIk2CnP/Ha16PhrRMPrZ+m4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HJneRlQBw2C4SjMPfhvcFI9ATJbAjK9TtisDe6CpDkL7FvlX80TTbpdMNm4UytJbjRbW7nnSJ6FlejakU+WrUFaLAAZ7wCi2PNhGlK/JQ6gLw9QBPZ/HV0MhRZCsCgM7I2NOKkCsv6k6QDrXOE7Oej1cCvideYidHiDTnLO0N4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W02bij3d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W02bij3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D101F000E9;
	Tue,  1 Sep 2026 02:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788228848;
	bh=8YP3rko65syoeGNZ7xscLywxT+GiLnVXWLudWyqFHEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W02bij3d5TQRYv8lUJXb0dI2NjZPdFkvYe2wxVRh+JlUtIV/UkbWL5tRnifGdndE4
	 S4XZmCvPrB6CZROXew5xkdH+A93vUgWXdBNKo0aKED6p34ZTomAT3iXRPXLHyqtbHZ
	 UyKQDpqNGKZa0Lp3zi0AA8/h5pUcqwfzW1iRzmtaCssZo2eC8AY7w+2ViR17/lQCdl
	 PPRNGg4mgPQudwVUOIeIiaQeTas65IA1yhEK5FntwJ0biAy7pdyFqLUHaRbnlNtLdk
	 mFSOkvA5KSOCCAeOgzayHpSOOBbIJlm/ZsGfL0Dc1o0NahqjwFXB2Juo+YYwR/Teve
	 Bw2At856DwgTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Fix program BTF use-after-free in sleepable
 programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanghyun Park" <sanghyun.park.cnu@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901014829.3504342-2-sanghyun.park.cnu@gmail.com>
References: <20260901014829.3504342-2-sanghyun.park.cnu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 02:14:08 +0000
Message-Id: <20260901021408.94D101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in bpf_prog_get_file_line() due to synchronous free=
ing of line info metadata.
- [High] Premature execution of module_put() allows module unloading while =
sleepable BPF programs are still executing.
--

commit 0ec9f868c2de818dd01ad433f26d1fe0d8574ac5
Author: Sanghyun Park <sanghyun.park.cnu@gmail.com>

bpf: Fix program BTF use-after-free in sleepable programs

Object kfunc calls embed metadata owned by the program BTF. A sleepable
program can remain active under Tasks Trace RCU after its last reference is
dropped, while program teardown releases the BTF through ordinary RCU. The
invocation can then dereference freed metadata in bpf_obj_new(). Move
btf_put() into __bpf_prog_put_rcu() to resolve this.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af0..26b05b454f18d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2451,7 +2452,6 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
>  static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
>  {
>  	bpf_prog_kallsyms_del_all(prog);
> -	btf_put(prog->aux->btf);
>  	module_put(prog->aux->mod);

[Severity: High]
This is a pre-existing issue, but does leaving module_put() here allow the
module to be unloaded while sleepable BPF programs are still executing?

When a sleepable BPF program is attached to a function in a loadable kernel
module and its reference count drops to zero, __bpf_prog_put_noref()
synchronously executes module_put().

The BPF program itself may still be executing or sleeping, protected by the
Tasks Trace RCU grace period.

Dropping the module reference allows a concurrent rmmod to unload the target
module. Because module unloading uses synchronize_rcu() rather than
synchronize_rcu_tasks_trace(), it frees the module memory without waiting
for the sleepable BPF program to finish.

Can this lead to a kernel crash if the program attempts to return to the fr=
eed
module function?

>  	kvfree(prog->aux->jited_linfo);
>  	kvfree(prog->aux->linfo);

[Severity: High]
This is also a pre-existing issue, but can this synchronous freeing of the =
line
info metadata cause a use-after-free during a concurrent stack dump?

If CPU 0 executes a BPF program and triggers a stack dump, obtaining the
prog pointer via bpf_prog_ksym_find(), and CPU 1 concurrently unloads the
program, it will call __bpf_prog_put_noref(). CPU 1 then synchronously
executes kvfree(prog->aux->jited_linfo) and kvfree(prog->aux->linfo).

CPU 0 could then proceed to call bpf_prog_get_file_line() in
kernel/bpf/core.c using the found prog, dereferencing the prematurely freed
pointers:

kernel/bpf/core.c:bpf_prog_get_file_line() {
    ...
    linfo =3D &prog->aux->linfo[prog->aux->linfo_idx];
    jited_linfo =3D &prog->aux->jited_linfo[prog->aux->linfo_idx];
    ...
}

Should these frees also be deferred to the RCU callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901014829.3504=
342-2-sanghyun.park.cnu@gmail.com?part=3D1
