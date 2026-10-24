Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792862977;
	b=lQ0FfXkpFNhRM9IQwokDpAJhbj83KWM9YQxKHLoIxTI8JILcciFEMPA2cIBqgl6CkxSs
	 n9nmJUCkglN3Mfqsm57VY6ktLqICODwDKOhjL9ypWO8bV7lhtT2p5giGUo6awjRJM8xFJ
	 2eK3kKlx25rJJOwImrf6bEC76g/eiHuSzCBdswk59UcfluVGHuE0plasbJDyH87o+6aNe
	 8GD6C6P4Xm9tJTIgufaJJb0uQB/jiL0HHc43hoRitfA5ZvRhvz8gUxQ7jDZJTpl+jBKjv
	 SlYiEF5alB4Gjp0M9RTJTyLtwRIzXtcKTTG7Szx2e+XK1Aep8fZrbga3uO+HW0p620A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862977;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type;
	bh=uSwBoXXR0278lCz88tFScOKYUs1WlmzxQUkqwc84UV4=;
	b=K7716Fo6RoGVsvQGS5kG9oizvLlwnvUGqlAlcei1LObTg8dh6GQJ4PGx9s0B4LP0Zx2H
	 x6N8cGxdbnnusQgWLElti5V4VN26rNc6lmzh4C3OhPSIQaI5GiKqyXthgZOVPG0auV90X
	 hxATcthf+f8SH8WPkHt0CsEFltf0aX/s5K+GhK2Vy7W4sMJETHTLHkekYIlUeiTDuzzaz
	 pK7gfIxHvFFcRihvWOyzOHYnpjg9bQ6uyj/Krj0ooE2mSDmnvzvHbRXbjDg54hZSCso/r
	 +ZW9UId2mLoNxKV2UX45j5Wl4Cg8frnGEPe0RP/erluIUhhycmm87ChEp0ZK77Jtc3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="PiI3/OF9";
	arc=none smtp.remote-ip=185.70.43.19
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311F606A31B;
	Sat, 24 Oct 2026 17:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F311F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=PiI3/OF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792862972; x=1793122172;
	bh=uSwBoXXR0278lCz88tFScOKYUs1WlmzxQUkqwc84UV4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PiI3/OF9Ufuyyj3aO8eCO/1tEHvsGaLkYocLXcRHq1ObnRjeSj66aMGBF08+jsIEK
	 OzQuv4WCtGM00qcXbO2vRBBSlDSE04eGBpXs/fPUfogDdbytC1je+yDuhhFYX3vW+n
	 LAb8VumFcqPVAMz9X2yDukd373oPdAXblM8ueo9IsTmV1sBqnvdz7G6P5bPp+uxWyf
	 VDlB08X4w/lMP0+feKvFD2zpXl8YQpkWqx2bppO5tmJKptYZ8WuZC+VVNV79ixDGAO
	 zO8k1tT97FfTqo1Wub00uGJCTekDeEYTaSrXc9LJFxkJJsuo1v4qnBYGdm56tx+FDE
	 XwnJyGBdeaswQ==
Date: Sat, 24 Oct 2026 17:29:26 +0000
To: "brauner@kernel.org" <brauner@kernel.org>, "kees@kernel.org" <kees@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
From: BoxStrikesTeam <BoxStrikesTeam@proton.me>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>, "mhiramat@kernel.org" <mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "jkoolstra@xs4all.nl" <jkoolstra@xs4all.nl>, "farid.m.zakaria@gmail.com" <farid.m.zakaria@gmail.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [RFC] binfmt_misc: add a tracepoint for BPF-selected interpreters
Message-ID: <21bBRWi4dDGR7l5TdmShL09exFRFwQA8c-1U_QlNoY2L7LGzDCNfypM9VECtuwD7mkrG1Cw8uXSLLdHmXsYsMARBbGn-mIl3Mutmeku-2zg=@proton.me>
Feedback-ID: 205449183:user:proton
X-Pm-Message-ID: 9a4226781f6ad8bab2fb7d82922320196d2e2407
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_ypzT8Pl0sSG9XfrFKv1IRmPTSVHPbQ69Wlkmf6LTY"

--b1=_ypzT8Pl0sSG9XfrFKv1IRmPTSVHPbQ69Wlkmf6LTY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,
The 'B' (BPF struct_ops) binfmt_misc handlers added in v7.3 can
select an interpreter per exec. =C2=A0In transparent mode the selected
interpreter is not visible through the usual interfaces:
/proc/PID/exe, /proc/PID/cmdline and sched_process_exec all describe
the binary, not the interpreter that actually runs. =C2=A0That is useful
for concealment, and it also leaves tracing and security monitoring
blind to the dispatch.

I built a small PoC to understand the mechanism and measure the gap.
It registers three struct_ops handlers (classic, transparent, loader)
and runs each target twice: once without a handler, once with the
handler and entry active. =C2=A0In the transparent case the process sees
/tmp/target_trans as its exe and keeps its argv, while the code that
runs is /tmp/poc_interp, reached through AT_EXECFD. =C2=A0In the loader
case the binary runs natively and only the PT_INTERP loader changes;
/proc/self/maps and AT_BASE show the substitution. =C2=A0The match program
checks the ELF magic and marker bytes in the e_ident padding; it does
not check the machine type, so the PoC is architecture-independent
and does not target a specific real binary format.

The official binfmt_misc_bpf selftest passes 16/16 on the same
kernel (v7.3-rc7). =C2=A0The test needed a small arm64 adaptation because
it assumes an x86_64 host: the foreign-architecture constants and the
interp_bind match rule were adjusted, while the assertions and
coverage are unchanged.

The gap is not a bug in the feature; it is a missing observation
point. =C2=A0I would like to propose a tracepoint after the entry has
selected its interpreter and the invocation flags are final:

=C2=A0 binfmt_misc_select(struct linux_binprm *bprm, const char *interp,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0const char *handler, unsigned long flags)

The event would record filename, interp, handler, flags and pid.
handler is the struct_ops name for a 'B' entry and empty for a static
entry; flags is masked with MISC_FMT_INVOCATION_FLAGS so only the
P/C/O/F/T/L bits are reported. =C2=A0The event is disabled by default and
costs a static key check when off. =C2=A0It does not change dispatch
behaviour.

I tested a patch on v7.3-rc7-32-g0fcb05b72344 (2 files, 60
insertions). =C2=A0In an A/B run the event does not fire without a
matching entry; with a classic handler it reports flags=3D0x0, and
with a transparent handler it reports:

=C2=A0 binfmt_misc_select: pid=3D96 filename=3D/tmp/target_trans \
=C2=A0 =C2=A0 =C2=A0 interp=3D/tmp/poc_interp handler=3Dpoc_transparent fla=
gs=3D0x48000000

while the process itself still sees /tmp/target_trans as its exe.
The selftest stays at 16/16 with the patch applied.

Before sending the patch, I would like to ask:

- Is a tracepoint the right primitive here, or would you prefer
=C2=A0 another interface (audit, a /proc file, a BPF iterator)?
- Is the event name and placement acceptable? =C2=A0I put it in
=C2=A0 fs/binfmt_misc.c and the header in include/trace/events/.
- Should this go through the VFS tree or the tracing tree?
- Is the flags mask the right ABI, or should the event report the raw
=C2=A0 entry flags and the resolved BPF flags separately?
- Would you want this at all?

The tracepoint is observability, not enforcement. =C2=A0tracefs is
normally root-only, and a root-capable attacker can turn the event
off; I am not claiming it stops a rootkit. =C2=A0If the approach is
acceptable, I can send the patch as an RFC PATCH or a formal PATCH,
rebased on whichever tree you prefer. =C2=A0If not, I would rather hear
that now than send code that is not wanted.

The PoC is attached as binfmt-poc-upstream.tar.gz (source and logs,
about 70K). =C2=A0It includes an English README.upstream.md; some of the
original notes are in Turkish. =C2=A0It needs v7.3+ with
CONFIG_BINFMT_MISC_BPF=3Dy and root inside the VM. =C2=A0The patch is not
attached yet; I can send it inline on request. =C2=A0If the list strips the
PoC attachment, I can send it directly.

I prepared this email and the PoC with an LLM assistant; I reviewed
the code and ran the tests above.

Thanks,
Eneshan Erdo=C4=9Fan Karaca
--b1=_ypzT8Pl0sSG9XfrFKv1IRmPTSVHPbQ69Wlkmf6LTY
Content-Type: application/gzip; name="binfmt-poc (1).tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="binfmt-poc (1).tar.gz"

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
geCF8BP2ykhBAKAAAA==

--b1=_ypzT8Pl0sSG9XfrFKv1IRmPTSVHPbQ69Wlkmf6LTY--

