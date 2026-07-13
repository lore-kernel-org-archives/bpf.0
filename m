Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183939099A;
	Mon, 13 Jul 2026 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930838; cv=none; b=LVAnLTzXQU/UDB7dZ8mrv6NbP/1W6qaJoJB42rbsDqlUHz2qa/99gbplspikXIJrAun1Eb1zws/oMdF+O68ASBAuUDBLtudbBnKnJH6X2+P92RkP+S2LpFLUxVsoSFdJa1Xi/WuHJBMaCbN6jJ5tYBQz4dXX0Qi2fx1GrfmJaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930838; c=relaxed/simple;
	bh=/i2syicifZJ3USjcLrnHL97T2+UWubEpCuWxspQutOo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=tZ+gI4bTj5ZvYvMIzAt7ARqyD1309RJ2Q9F1bGoHMUKhyv4IR5wnXcQvoRfdS9s076ZAnQE1zHhj5t2XKnnpVXoXT/C/2nZ0A2Qv7i+3Tnj9RK88GaOcrav7a5/wEGvJVqUkFwh2R++d9LOZ/t2utYVk72JpUzof+4wA/ZK1/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/i7JmHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/i7JmHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F210D1F000E9;
	Mon, 13 Jul 2026 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783930837;
	bh=AVaWRHxuOp1xucpt25y4qXpngLUErNt80kcT84Gj6Ec=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=H/i7JmHx+nL/+drkYk9FHiWsCAuDyQ/lPRCv3RvInE9zuSQcynJrwktJsvbx35+ap
	 7xdiCe1oidtsult+mT39XvQW4KYxQ+8Osc4VpdrsvGZJmnuOCI8RonPzzOpzs1+z/r
	 9AWTVcc+C97niunSyfVT6zPHFenfQnBoI+oD1diAvgemGBA+RAofP5Dz19+v21kVuw
	 Wq1dv7fruhvIgzxVcUDpcsJVZHLgQg2AOghsPkd0UUKmMUQDoDAGqHOAMfKvt5keEF
	 ktEC+w2rFmZmbWPccRFgK+9fCpbErPEvtXykxrLMr22psUB7in+u2srp1/DxPqPgZv
	 UHbIVXfIH5NKg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/5] binfmt_misc: bpf-backed binary type handlers
From: Christian Brauner <brauner@kernel.org>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Jann Horn <jannh@google.com>, 
 John Ericson <mail@johnericson.me>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <DJX4IFO55D9S.3IV3K5XICJAEV@gmail.com>
References: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
 <20260712-abluft-brutkasten-aufladen-c8063a4a1a0a@brauner>
 <DJX4IFO55D9S.3IV3K5XICJAEV@gmail.com>
Date: Mon, 13 Jul 2026 10:20:02 +0200
Message-Id: <20260713-unerlaubt-luftkammer-kosmetik-46532d395f9b@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5642; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/i2syicifZJ3USjcLrnHL97T2+UWubEpCuWxspQutOo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSFzN968Y6VOqPC9JsP9qWHs0noxn0/3R4ZH2xSFH5/T
 +jLjDjmjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlEqjL805+XauBhdHPVDt1v
 W60mzUieca+zv+rN4bQrZutUPzxez8HI0O3Kn/RRkL+DZ7vs7TmH/lrt1betv7l9Ti6nlWDRspV
 /2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> > - The single sleepable load op is split into two ops:
> >
> >       struct binfmt_misc_ops {
> >       	bool (*match)(struct linux_binprm *bprm);
> >       	int (*load)(struct linux_binprm *bprm);
> >       	char name[BINFMT_MISC_OPS_NAME_MAX];
> >       };
> >
> >   The non-sleepable match program runs from the RCU entry lookup
> >   walk itself, exactly like magic and extension matching: same
> >   registration order, same first-match-wins semantics, and it can
> >   only rely on the prefetched bprm->buf. It must be free of side
> >   effects since the walk may be restarted.
> >
> 
> Is relying on brpm->buf enough?
> Right now that's only 256 bytes I think, which is not enough to read
> segments we might care about. That worked fine when it was just a magic
> number but the idea with the eBPF program is to make decisions based on
> more data.
> 
> In the selftest I provided, the `PT_INTERP` segment is already at file
> offset 0x318 (792). I was imaginging NixOS having to support
> `PT_INTERP_NIX` in order for the produced binaries to be backwards
> compatible with older kernels.
> 
> The other idea would be to make the `match()` broad and select
> everything but then nearly all ELF64 binaries would match and then pay
> the price to `load()` and ultimately `-ENOEXEC`. Seems like it would
> make multiple BPF binfmt programs less useful.

Ok, so your idea is to have multiple bpf programs that look for
different interpreters. Yeah, then you have to be able to sleep because
you need to be able to fault. It makes the code uglier but I can see how
that's useful. I'll see how nice I can make that.

> >   The sleepable load program runs once the walk has committed to the
> >   entry and does the file reading and the interpreter selection. Both
> >   ops are mandatory, the struct_ops plumbing enforces the sleepability
> >   of each, and since bpf_binprm_set_interp() is KF_SLEEPABLE a match
> >   program cannot select an interpreter by construction.
> >
> > - A match is a commitment. A failing load program fails the exec instead
> >   of falling through to later entries. -ENOEXEC keeps its usual meaning
> >   and hands the binary to the remaining binary formats, for a handler
> >   that discovers it cannot serve the binary after all.
> >
> >   This kills the part of v1 I disliked the most: the skip cursor and the
> >   leave-and-rescan loop in load_misc_binary() are gone. The walk is
> >   never left and re-entered, and 'B' entries need no special semantics
> >   against concurrent (un)registration anymore.
> >
> >   Your v2 changelog note about keeping the bpf retry loop in the
> >   __free() style is moot as a consequence. The loop no longer exists.
> >
> > - The load return convention flipped: 0 now means success after the
> >   program called bpf_binprm_set_interp(). Returning 0 without having
> >   selected an interpreter or returning a positive value is treated as
> >   -ENOEXEC, other negative errnos fail the exec.
> >
> >   So the "return bpf_binprm_set_interp(...) ?: 1" idiom from the v1-era
> >   programs becomes plain "return bpf_binprm_set_interp(...)".
> >
> > - The handler name moved from the offset field to the interpreter field
> >   that field consistently names whoever supplies the interpreter, a path
> >   for static entries, a handler for 'B' entries. Offset, magic, and mask
> >   must be empty:
> >
> > 	echo ':nix-origin:B::::nix_origin:' > register
> >
> > - 'C' is allowed now, v1 rejected it. It behaves exactly as for a static
> >    entry. The setuid transition stays gated by vfsuid_has_mapping() in
> >    the caller's user namespace. Which makes 'B' handlers usable for a
> >    per-binary loader over setuid binaries. 'F' stays rejected as there
> >    is no fixed interpreter to pre-open (I have other ideas how we'll do
> >    something like it later.).
> >
> > Nothing changed in the exec patch, the fs kfuncs patch, the kfunc
> > itself, or the registry/namespacing model.
> >
> > I can send v3 in a bit if that's ok.
> 
> I don't mind at all you sending v3 and in fact I've been enjoying your
> involvement. I didn't know what to expect when I offered this idea up to
> the community. 
> 
> I'm happy to keep co-developing this with you within a design you feel
> acceptable with. Please let me know how I can remain engaged and
> helpful.
> 
> One last thing I was thinking about is that we will also need to support
> $ORIGIN in the shebang path, however I just tested it and this current broad
> BPF solution can largely handle it [1], with a small wrinkle.
> 
>   $ printf '#!$ORIGIN/interp\n' > /opt/app/greet
>   $ cp ./interp /opt/app/interp     # any interpreter/loader
>   $ chmod +x /opt/app/greet /opt/app/interp
> 
>   # stock kernel: binfmt_script opens the literal "$ORIGIN/interp"
>   $ /opt/app/greet
>   bash: /opt/app/greet: $ORIGIN/interp: bad interpreter: No such file or directory
> 
>   # with the handler registered, $ORIGIN resolves to the script's dir
>   $ bpftool struct_ops register shebang_origin.bpf.o /sys/fs/bpf
>   $ echo ':shebang-origin:B:shebang_origin::::' > /proc/sys/fs/binfmt_misc/register
>   $ /opt/app/greet
>   <runs /opt/app/interp, the loader found next to the script>
> 
> The wrinkle is that it can't express today is the single optional argument.
> (i.e. `#!interp arg" -> argv[1]=arg`). We might ned a way to express
> that in the load.

Ah, fun. binfmt_misc wasn't able to express this at all. It's good to
close that gap. This can just be done by adding
bpf_binprm_set_interp_arg().

