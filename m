Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD542433035
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766788; cv=none; b=JPm2a5bDZRGW/9g9tmJi0TK0nEZEe6EfvLz4j0n10zKvhPSvRdYNKPEPKE9uaSX2ncH+J4j+R+upDHQ8HcRYtz21GdA+EFrm5ly8ljP2OXxnDCHdWxcDzm++JQrAcNwZzjatjkFbx5PfhOSHZzuFhcPxvxCg4D6W18wOXCkpMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766788; c=relaxed/simple;
	bh=3mjQ9i+tTjH2YAGZB4t5u7Z/4MOspw8X0qO/YdFJc8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jyaDk+Xff7Pq7R+lmQryzDXX7S+sEnJCcNGCjwttSfwEBLWzUAoElM287dE/KlH0L2azVfzyX1Vo8sclY8gE7M55GVIhihb0Wlz+2Oo7cY4IbBgEjvuGYtnaY7AgvKw6Hf1hr1Knw0+2BSV1p53jtgqZGKlyd5DQZZ1Lh8fCsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGNXa7UJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGNXa7UJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB561F000E9;
	Mon,  3 Aug 2026 14:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766786;
	bh=3mjQ9i+tTjH2YAGZB4t5u7Z/4MOspw8X0qO/YdFJc8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EGNXa7UJ4Wd/loHmsocJRXXs0JPIoTQVKTi0qzOQ0cud5XO0ZUqpBbZM844kJb+3E
	 79IT85GAGQapq/8Ud/DtAqRZ1nXPZ/uX1+lEsiHSNv0/E3ddccuULF8Br7wsmwt4L0
	 wW1FAOEKKlC7ETsbEJYQ5kinbxAGKhfa7MEIjjsymIV7TZZkQknPcqfSV1AMw+hWWR
	 OtUci5C5H6d+CzxtTi4TvUrL5/w1+0nhLckROV8gVzNiLZfvEvmiFL1NYfkrxx9pUN
	 zlc968S2f4diyl7UAX49RgCwqFUcAmoKVgRlGvH+ZnHJix7hkLF4TYGWH2KzskbbSd
	 Jjl+RQ2MV+yCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/9] bpf: Support __arena and
 __arena_nullable on struct_ops arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803125115.2264733-3-memxor@gmail.com>
References: <20260803125115.2264733-1-memxor@gmail.com>
 <20260803125115.2264733-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:19:45 +0000
Message-Id: <20260803141946.5DB561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `__arena_nullable` BTF parameter suffix is erroneously process=
ed as `__nullable` due to substring matching, breaking `PTR_TO_ARENA` seman=
tics.
- [High] Attaching tracing programs (fentry/fexit) to struct_ops programs w=
ith arena arguments causes them to receive 32-bit user-space offsets typed =
as valid kernel pointers, leading to SMAP violations and kernel panics.
- [Low] Modified multi-line comments do not conform to the required BPF sub=
system comment style.
--

--- Patch [2]: [PATCH bpf-next v3 2/9] bpf: Support __arena and __arena_nul=
lable on struct_ops arguments ---
Note: The format of this review has been altered due to system restrictions=
 on
reciting original code. Instead of inline diff quotes, this report provides=
 a
free-form summary of the findings.

commit 0582d11e29a7b343a06709e7d3f0cdcc15655dcc
Author: Tejun Heo <tj@kernel.org>
Subject: bpf: Support __arena and __arena_nullable on struct_ops arguments

This patch adds support for the __arena and __arena_nullable suffixes on
struct_ops arguments. This allows callbacks to declare parameters as arena
pointers, while the kernel caller passes the kernel arena address and the
trampoline handles the conversion.

[Severity: High]
In kernel/bpf/bpf_struct_ops.c within prepare_arg_info(), does the if/else
chain incorrectly prioritize the shorter suffix? Because
btf_param_match_suffix() matches the end of the parameter name, a parameter
ending in __arena_nullable also matches the shorter __nullable suffix.

Since the code checks for the nullable condition first, will this cause
__arena_nullable parameters to be incorrectly typed as PTR_MAYBE_NULL and
PTR_TO_BTF_ID rather than PTR_TO_ARENA? This seems like it could cause the
trampoline to skip the arena pointer conversion, passing a raw kernel
pointer instead, and potentially leading to verifier errors if used with a
non-struct pointer.

[Severity: Low]
This isn't a bug, but in kernel/bpf/bpf_struct_ops.c within
prepare_arg_info(), the modified multi-line comments appear to retain the
older kernel comment style where text follows the opening delimiter on the
same line.

Does the BPF subsystem require multi-line comments to have the opening
delimiter on its own line, even when modifying existing comments in a file
that previously used the old style?

[Severity: High]
In kernel/bpf/trampoline.c within bpf_trampoline_update(), does the
defensive check evaluate the wrong program's context arguments? The code
appears to check the attached tracing program (fentry/fexit) for arena
arguments rather than the target struct_ops program.

Since tracing programs do not have their ctx_arg_info initialized, could
this allow them to successfully attach to struct_ops programs that have
arena arguments?

If so, during verification in kernel/bpf/btf.c at btf_ctx_access(), the
tracing program's context argument would be typed as a standard
PTR_TO_BTF_ID because its ctx_arg_info_size is zero. At runtime, the
struct_ops trampoline would convert the kernel pointer to a 32-bit arena
offset, which the tracing program would receive and potentially dereference
as a standard kernel pointer. Could this sequence lead to SMAP violations
and kernel panics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803125115.2264=
733-1-memxor@gmail.com?part=3D2
