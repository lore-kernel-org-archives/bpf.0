Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7452397350;
	Wed, 17 Jun 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690213; cv=none; b=jHGGHuqGTePwO0MeJFDjXP2QxRIS6QQyHOY9C6zVGS6CMixbR5FGEdF7XOmHDm38vJa2z48cAJnGTpDQm+XhwemNNAgcLP2VWDZXm1m0l7EOGLV4/QKvgfWaKMQtLPMigm/pc8Ve/Bkv6baIcu9ZID2X7NtiFkIEIZ4FbP8Gcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690213; c=relaxed/simple;
	bh=TMrxxp+guFwn7mx2uuBTxRYwnDhlyn6YX+jNWTXrEZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqQC5jORwR+mtnRl3s/G7+Y9HD4DdEAvP9W2wC7ui7PbboXJvgM8xtl2GQq2IJLtXGKT5jXW8Sd/dMPQv2I0sGaZeliUNdWhOwINWIA+TBJirLGKcaSk5t1bG8sy/X1lVUNfzf+lgvAVuBBQ2kA2UYU3x5zRZuC/IltaCmXRsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Qd8S+ZKg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Qd8S+ZKg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oLxX7ht6PGsl2o0YP4hYtKgmC02cD+LgWZ1kDpuKHFM=; b=Qd8S+ZKgSOE8XHU0beH2cFuhrM
	eSEUO1ONcVtDiitZrZ+MR08/5LIZLMfrZ+5FNuLYkr6wnIPo0m/sTQVC5d+X4eydBGoZXYayixDpj
	3NWmME1/vlazZpoHcxoAlqm92lYVtYbfdxZg0oWRP8Rciln+AZ6YMrw1EuwiZAkxkAEgfHn2nKUjc
	9puLaWCmzkm3CaZ5/SW6EtsLyFhgjEDCf6nFYLXwsvi/j/06Vmel1dI76CZEcL1KKywYCpvm0Kd1p
	y76vC+/KMRcxT3QAdFtOFeqwhFmUymz18EZTJVbw7OI3NpujYkR7kyoNm0N+O5h8yqNB/0gGI+05X
	udD30Ifg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZn0W-00EXAK-1v;
	Wed, 17 Jun 2026 09:56:28 +0000
Date: Wed, 17 Jun 2026 02:56:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 6/7] Documentation: bootconfig: document build-time
 cmdline rendering
Message-ID: <ajJu2KlfVyuUH-VA@gmail.com>
References: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
 <20260609-bootconfig_using_tools-v4-6-73c463f03a97@debian.org>
 <20260610233720.82fe59cf42aa57659c2e5697@kernel.org>
 <ail6rQnRYKsXPxyF@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ail6rQnRYKsXPxyF@gmail.com>
X-Debian-User: leitao

On Wed, Jun 10, 2026 at 07:58:10AM -0700, Breno Leitao wrote:
> On Wed, Jun 10, 2026 at 11:37:20PM +0900, Masami Hiramatsu wrote:
> > To avoid confusion, when this option is used, shouldn't we treat it
> > the same way as if embedded command lines were enabled, and either
> > not display it in /proc/bootconfig (or always display it, by merging
> > the rendered string)?
> 
> You're right that EMBED_CMDLINE breaks it: the embedded kernel.* keys
> are already in boot_command_line before setup_boot_config() ever sees
> the initrd bconf, so a user reading /proc/bootconfig would see only
> the initrd keys while parse_early_param() acted on the embedded ones.
> That's exactly the split-state Sashiko was circling around.
> 
> Both options you suggest work for me, but they pull in opposite
> directions and I'd rather not guess wrong on the user-facing
> contract.  Which do you prefer for v5?
> 
>   (a) Don't display embedded in /proc/bootconfig -- keep the current
>       "file shows the active bootconfig source" behavior and document
>       that with EMBED_CMDLINE=y, the kernel.* subtree may have been
>       applied separately via the cmdline.
> 
>   (b) Always display embedded by merging the rendered string into
>       /proc/bootconfig when EMBED_CMDLINE=y, so the file reflects
>       what was actually applied.
> 
> Happy to go either way

Following up on my own mail rather than leaving it fully open: after
looking at the code more, I'd like to recommend (a).

The deciding factor is ordering. EMBED_CMDLINE only works because the
embedded "kernel" keys are folded into boot_command_line in
setup_arch(), before parse_early_param() -- which is long before
setup_boot_config() looks at the initrd.

So for early params the embedded values are necessarily applied first, and an
initrd bootconfig cannot override them no matter how we present
/proc/bootconfig. That makes the embedded cmdline behave like a build-time
CONFIG_CMDLINE rather than a bootconfig source, and (a) is the option that
describes it honestly: it shows in /proc/cmdline, and /proc/bootconfig keeps
meaning "the bootconfig tree that was parsed".

(a) is also what the tree already does -- saved_boot_config is built
only from the XBC tree, the rendered string never enters it -- so it is
no new code on the /proc side and keeps the series small.

(b) would pull the flattened cmdline string back into the structured
tree view and need dedup against the initrd keys, which muddies what
/proc/bootconfig means for little gain.

So unless you'd rather have (b), I'll take (a) for v5 and extend
bootconfig.rst to cover the four sources (bootloader cmdline, embedded
cmdline, initrd bootconfig, embedded bootconfig).

I'll also document the sharp edge -- with both an embedded cmdline and an
initrd bootconfig, early params reflect the embedded values because the initrd
is not parsed yet.

Thanks,
--breno
