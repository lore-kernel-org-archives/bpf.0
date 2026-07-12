Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B43126B0;
	Sun, 12 Jul 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783859557; cv=none; b=iejbJR13mF5KXgRJQEwGaxo85V3BDglLl0gO3o1qp/a77npuAhi/5B2P4UsViSe0etXv2HeLVIXxAzTkdd9zhy9DDzUV1znACCHS1PV+nRU7K7gs19NVkidmQSH/7N2S6DMEu4/rNn+QGuRpZzYiYD25QtKpA9zVsAO/wXX5xes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783859557; c=relaxed/simple;
	bh=VU5CHIyaoqNRjqMq+N8FVvGRvPUNlYegA5+LAVSgSdo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=EZd9z9xl70ofn07ivkByg8OFQbS/jI6bKzmLdVJ+tHFgic6h6sSaWqedqNFc5LqsWExBC4Hlyqqsr0JkXo01+CZLcAXVCfUcWW8BPESq9+HOgOywKesNsnv25YNq7TEBs7DkgvW4b6UjGgnggKud8KvttRPLsUUX1D8y5JSq8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geJcKo8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geJcKo8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625101F000E9;
	Sun, 12 Jul 2026 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783859553;
	bh=MtkGjiGoIClKqYf6WbMTADgvs1VSC4RCPwgWlBMIBnc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=geJcKo8lmOCwLH8xvS3pjM6MSkf7G28eQyFiSG6nCT2g2bYC/iGbTzTX5BCP6XbKF
	 8Rf5ExjwECx/W8ibPyCuvsaX6aIkGQeiXyzKVftKkSGaYcFpgb74pWSYDni7dIY711
	 YwWiczEPH1l/JKVndl2Wd6OPsX5pkefjuJUQ8pQ58zGRZyM7GKVo50Yg5UJNXFZksh
	 lgbpBhkNVQtqTbIFDCgXAbTjGE8fS3Ko6ejgWF4SOtfEweQ1AuICRDoUYLG8ex795L
	 Ib/03fjU59OzPmCxaypFwa3282e1OH6uu7kpx0M0YeW+mz2cd0LFmQ3Pnx4DR9/8gE
	 qc/wwrqo7bpwA==
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
In-Reply-To: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
References: <20260711-binfmt-misc-bpf-v2-v2-0-d6591ceaf207@gmail.com>
Date: Sun, 12 Jul 2026 14:32:22 +0200
Message-Id: <20260712-abluft-brutkasten-aufladen-c8063a4a1a0a@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4203; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VU5CHIyaoqNRjqMq+N8FVvGRvPUNlYegA5+LAVSgSdo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFd8ZM3PJB2fnw3h2pDk1m9m0T/M/E6025wn7fzfpOW
 d7C5AbXjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkI/GNkeHPQiL3GYesmrc1v
 tSZ2fPxUztu58LPf8We7040t9978e57hr8j8bbGpuRPkD7t/1zq2+011XTWvyL61nwVVJl7m3fb
 NmAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> This is a continuation of Christian's bpf-backed binfmt_misc POC [1], which he offered
> to hand off to me. I am carrying it forward. The kernel design is his and is
> unchanged. This series rebases it onto his binfmt_misc locking/cleanup series [2]
> and adds selftests (+ fixed from the one's shared), and therefore does
> not apply to mainline alone.
> 
> As for motivation for this whole change, Christian did a great VL;MR;
> write-up [1].
> 
> TL;DR: binfmt_misc can match a binary and hand it to a fixed interpreter,
> but it can't match programmatically or compute the interpreter per binary.
> The Nix community would love to support relocatable binaries, where the
> correct loader can only be found relative to the binary itself.
> This adds a 'B' handler type: a binfmt_misc_ops struct_ops program that
> inspects the binary and picks the interpreter with one new kfunc,
> bpf_binprm_set_interp().
> 
>   bpftool struct_ops register nix_origin.bpf.o /sys/fs/bpf
>   echo ':nix-origin:B:nix_origin::::' > /proc/sys/fs/binfmt_misc/register

Thanks! So I've spent some more time working on this because I had some
future ideas that I needed to make sure could be accomodated by this
(currently on vacation but hey...). So the version I have givex this a
better design and has future extensibility in mind:

- The single sleepable load op is split into two ops:

      struct binfmt_misc_ops {
      	bool (*match)(struct linux_binprm *bprm);
      	int (*load)(struct linux_binprm *bprm);
      	char name[BINFMT_MISC_OPS_NAME_MAX];
      };

  The non-sleepable match program runs from the RCU entry lookup
  walk itself, exactly like magic and extension matching: same
  registration order, same first-match-wins semantics, and it can
  only rely on the prefetched bprm->buf. It must be free of side
  effects since the walk may be restarted.

  The sleepable load program runs once the walk has committed to the
  entry and does the file reading and the interpreter selection. Both
  ops are mandatory, the struct_ops plumbing enforces the sleepability
  of each, and since bpf_binprm_set_interp() is KF_SLEEPABLE a match
  program cannot select an interpreter by construction.

- A match is a commitment. A failing load program fails the exec instead
  of falling through to later entries. -ENOEXEC keeps its usual meaning
  and hands the binary to the remaining binary formats, for a handler
  that discovers it cannot serve the binary after all.

  This kills the part of v1 I disliked the most: the skip cursor and the
  leave-and-rescan loop in load_misc_binary() are gone. The walk is
  never left and re-entered, and 'B' entries need no special semantics
  against concurrent (un)registration anymore.

  Your v2 changelog note about keeping the bpf retry loop in the
  __free() style is moot as a consequence. The loop no longer exists.

- The load return convention flipped: 0 now means success after the
  program called bpf_binprm_set_interp(). Returning 0 without having
  selected an interpreter or returning a positive value is treated as
  -ENOEXEC, other negative errnos fail the exec.

  So the "return bpf_binprm_set_interp(...) ?: 1" idiom from the v1-era
  programs becomes plain "return bpf_binprm_set_interp(...)".

- The handler name moved from the offset field to the interpreter field
  that field consistently names whoever supplies the interpreter, a path
  for static entries, a handler for 'B' entries. Offset, magic, and mask
  must be empty:

	echo ':nix-origin:B::::nix_origin:' > register

- 'C' is allowed now, v1 rejected it. It behaves exactly as for a static
   entry. The setuid transition stays gated by vfsuid_has_mapping() in
   the caller's user namespace. Which makes 'B' handlers usable for a
   per-binary loader over setuid binaries. 'F' stays rejected as there
   is no fixed interpreter to pre-open (I have other ideas how we'll do
   something like it later.).

Nothing changed in the exec patch, the fs kfuncs patch, the kfunc
itself, or the registry/namespacing model.

I can send v3 in a bit if that's ok.

-- 
Christian Brauner <brauner@kernel.org>
