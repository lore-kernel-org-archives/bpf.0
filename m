Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675E3EA953
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467991; cv=none; b=b//0RN22smDei3NGTGYtiavF5T9vFt76MN2A9HDStOmaINoVX8rxi2uZcy6fz74fxZW/LQ9vlhdfIf+TFaC2P1dHy6EdfrLjd59IrDiO4kgpx7OQER/JycF+TahWVhV7TMEkr2GSPkhcsA+Zuxl8cRHwjGsX90co5MvgffjPsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467991; c=relaxed/simple;
	bh=XEUWGZuZLXDbYAn76zs1blSZc8YDqsYiBH54j0Ycdb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HxqiqvsG31r1Tn34EUNpBDO3RCFeAiUvYUZFimzplq4XXE6awXlm90N+3KEqQV39SJF+mkr/e1PxWgRzX2BhM7HbJMJXhRFbpp/Nd+aoGIrMudpnBnGxqo3Iz6AggUJuSThwWW9wSlWtex//pupIzmxqpcrQ1/9J11EgCqjlAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZVYbgLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZVYbgLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88281F000E9;
	Fri, 26 Jun 2026 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782467989;
	bh=Jhm1v/N3GPqQ088Qys+NWB3isWJa7lJ4VevFh+fihkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZVYbgLNDsAqd27NX3n8QdTeQklDbpvXByOq0IYT5poIR/qyBHgxM21sM+xwx5Hod
	 Q+9V4vCm0A66WV73Vs0s/GYevMiZYEgDxbytOT/1EdQ/EolkNX41SNQ0JqMgoMZ63C
	 XGouxhbgzhgNb8xAYUNcpIx8J3xBlCSGo+IAMiaGiYFRT7UvlOKTKFFsgDwoyRqP/f
	 xW1rs1dIV7x93yS1gPuw9cpS0tu4oe5GdrOGRGfqHk7s2RVpGbNWcL6kce5eJ+sMP2
	 T/ZY6m7apXnc9oQONY3dvMchtQvQeIZek3XmSj5/UfFBRXWq3Q8/5UqzprRxJQ+Xzr
	 NqnyDzrFtP3Gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: move security_bpf_prog_free() out of RCU
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626093711.2969648-1-rhkrqnwk98@gmail.com>
References: <20260626093711.2969648-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 09:59:49 +0000
Message-Id: <20260626095949.C88281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to fix the `BUG: sleeping function called from inv=
alid context` because `security_bpf_prog_free()` can still execute synchron=
ously in softirq contexts.
- [High] Use-After-Free on `prog->aux` fields when traversing the `bpf_prog=
` structure in the `bpf_prog_free` LSM hook.
--

commit ce00646a70b27dcf100e6bb9652d3943185fcac5
Author: Sechang Lim <rhkrqnwk98@gmail.com>

bpf: move security_bpf_prog_free() out of RCU callback

This commit moves security_bpf_prog_free() from __bpf_prog_put_rcu() to
__bpf_prog_put_noref() before the RCU deferral. This change is intended
to prevent a BUG caused by sleeping LSM BPF programs executing in atomic
context when attached to the bpf_prog_free hook.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b479..6d9a662241159 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -2457,6 +2456,7 @@ static void __bpf_prog_put_noref(struct bpf_prog *p=
rog, bool deferred)
>  	if (prog->aux->attach_btf)
>  		btf_put(prog->aux->attach_btf);
> =20
> +	security_bpf_prog_free(prog);

[Severity: High]
This is a pre-existing issue, but does moving this hook here expose a
use-after-free read if an attached LSM BPF program traverses the
bpf_prog structure?

The hook is invoked after several dynamically allocated fields in prog->aux
(such as linfo, jited_linfo, and kfunc_tab) have been freed earlier in
__bpf_prog_put_noref() via kvfree() and kfree(). An LSM BPF
program attached to bpf_prog_free could read these dangling pointers.

[Severity: High]
This isn't a bug introduced by this patch, but will this placement actually
resolve the "sleeping function called from invalid context" BUG?

If a program refcount is dropped from an RCU softirq path, such as in
__dev_map_entry_free() in kernel/bpf/devmap.c, it appears we still reach th=
is
hook synchronously in atomic context:

kernel/bpf/syscall.c:__bpf_prog_put() {
    ...
	if (in_hardirq() || irqs_disabled()) {
		INIT_WORK(&aux->work, bpf_prog_put_deferred);
		schedule_work(&aux->work);
	} else {
		bpf_prog_put_deferred(&aux->work);
	}
}

Because in_hardirq() and irqs_disabled() are both false in softirq context,
bpf_prog_put_deferred() and consequently __bpf_prog_put_noref() will execute
synchronously, firing the LSM hook and hitting the same BUG.

>  	if (deferred) {
>  		if (prog->sleepable)
>  			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626093711.2969=
648-1-rhkrqnwk98@gmail.com?part=3D1
