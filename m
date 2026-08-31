Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC03DAAB1;
	Mon, 31 Aug 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169442; cv=none; b=kCw8taG0yapsa5xRgr/625fMv3SOGAmzEVQE/lcLLGRCNKN6tpGTMgNjNn5JJPHG6ROW9aam/AzNBzD9Z/4oA80hyDwRywnhu0XstlrdKj8hDAMx/AeUCoHvQKjyPOm7np+JXHjCOR4CyQJu/RhyCxDVwsGH3U+eAkdc1yiUV4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169442; c=relaxed/simple;
	bh=vRuIoghT0mruPhZScNVjR6AqsdQgjGXTidnqjZtE4tI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=evd3kJP3lNXGytfnldHa5Ij4/1UqKXqW0sodMkFa0uV8c82DfnpD6hDqO/oNlpzzazQD/isf7qGci7/PS6kjVjunebFf2CwtGmaFeugbxIugdb5j/FBlNi+H6T/+NgwgYbG37/fEmYbKBW6Lmr13/q2O9QGL+RvrmnQmtJgCr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExIXGdAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExIXGdAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DD51F000E9;
	Mon, 31 Aug 2026 09:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788169441;
	bh=KamKTf6SLaH3ogkny6EVPx1QTF2YUhFtZl7AUyal9Mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ExIXGdAokcHEeBjSVaHv0mwyhlOuUpTyado/cApYk+XjJJf5GjTitIVLZpMn+8ejr
	 AHr9aOro6gXvjB97vLtrKpgEI9ZGhXv74MEK02rGLo6w/c/1MD3Gq3NN7I/bil7+Sz
	 rUKW/FplNb+RWjc7fjWQbQBfyp3+a6lr7CFQl2xXfuB9LL9IHLJnvTtGvdrWIT8qBB
	 PKDWs9dRj1XpVkgyvp3gGoNKg8nRI9TOEGpNa1tnRaA4oR8CseqV9WDn0FyJNbyOrp
	 GYxd0i3DS3bgVJ1tdqJn5IBtBIhXPfsxXuo2+syorSMeewmhQaZMOZ5xPBe5tJRlmZ
	 0B7P8unZ7R/eA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 19/20] tools/rv: Add selftest for rv bpf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260831090524.106845-20-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <20260831090524.106845-20-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:44:00 +0000
Message-Id: <20260831094400.D1DD51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ABA vulnerability in tracefs UAF mitigation due to pointer reuse.
--

commit d6f30a79c0307745af03ca13f0fdeb754d0c04a9
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Add selftest for rv bpf
   =20
Add selftest cases for the rv userspace tool BPF commands and monitors,
test BPF monitors registration, unregistration and functionality,
including traces and reactors.

> diff --git a/tools/verification/rv/tests/rv_bpf.t b/tools/verification/rv=
/tests/rv_bpf.t
> new file mode 100644
> index 0000000000000..902343f0d3f10
> --- /dev/null
> +++ b/tools/verification/rv/tests/rv_bpf.t
[ ... ]
> +check "already enabled monitor returns error" \
> +	"echo 1 > $RVDIR/monitors/nohz/enable; $RV mon nohz" 1 \
> +	"monitor nohz (BPF) is already enabled"
> +[ -n "$TEST_COUNT" ] && echo 0 > $RVDIR/monitors/nohz/enable
> +
> +check "already enabled monitor prevents unregistration" \
> +	"echo 1 > $RVDIR/monitors/nohz/enable; $RV bpf unregister" 1 \
> +	"monitor nohz is enabled, cannot unregister" \
> +	"unregistered [0-9]\+ BPF monitor(s)"
> +[ -n "$TEST_COUNT" ] && echo 0 > $RVDIR/monitors/nohz/enable
> +
> +check "unregister BPF monitors" \
> +	"$RV bpf unregister" 0 "unregistered [0-9]\+ BPF monitor(s)"

[Severity: Medium]
Could this sequence of registration and unregistration expose an ABA
vulnerability in the tracefs use-after-free mitigation?

When a monitor is unregistered here, its struct rv_monitor inside the
bpf_struct_ops map can be freed. If a user still holds a tracefs file
(such as enable or reactors) open for this monitor, filp->private_data
becomes a dangling pointer.

If a new monitor is then loaded and allocated at the exact same memory
address, the pointer check in monitor_enable_write_data() might pass
incorrectly:

kernel/trace/rv/rv.c:monitor_enable_write_data() {
	...
	guard(mutex)(&rv_interface_lock);

	if (!rv_is_monitor_registered(mon))
		return -ENODEV;

	if (val)
		retval =3D rv_enable_monitor(mon);
	...
}

Since rv_is_monitor_registered() simply checks if the raw pointer mon
exists in rv_monitors_list, it would return true for the new monitor.
This would allow a privileged user to accidentally or intentionally
alter the state of the newly registered monitor using the old file
descriptor.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831090524.1068=
45-1-gmonaco@redhat.com?part=3D19
