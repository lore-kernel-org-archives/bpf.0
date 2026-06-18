Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5A29405;
	Thu, 18 Jun 2026 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781743646; cv=none; b=Ntr9jRNbnTrYVMlurGQh/acmCG+vHxwd0IgViDfKkV0voxw67+r32Vo7PJZKzhYWXv/pgKQu6H20Y4BHtOx49+u2BCM5aYCDxtN0kFCpqaASN6/7ta/1EfP1reRsFcLVYFMCyHPosPWAvPPnEd67hrLDbrxPihojCvp7EqWHrrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781743646; c=relaxed/simple;
	bh=F4gRYMlMxsy0+7Wx0VzxOwmwc0PB6Yh5GZ4Q0UAxf78=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KqPwETe+lApM5lizUL18BFq8cClfL57wXRfFJ3y5wc0o0s1Jjq0swGBzVhsaxYWoUjkqT1UEIQ9s277+qzBnbZkHsi2qVn0FBGbq/8BwGG35hkklxxqEcWWheeJ06u5gnYSYNsXiBzu5ZJTLTD3jNWjdrufFANBJ0/8X5IS3XTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQSSOjUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQSSOjUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19B91F000E9;
	Thu, 18 Jun 2026 00:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781743645;
	bh=D4NrgH69WQfJXDd+cI1xHQfObRCCi25E5s09HMh6n+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RQSSOjUvD+yKml31cpJlWhXt73t4M7WsT/mecNere55eTpb1Gyf4gaE0dqQGXvzan
	 qeSmjM2Ls13O0IcxbndFQ0/8nCKqhnUTDuRxul+0nSq90HEKmVC0ViOJv1QCQv9513
	 C9P6p35qvpxvF/+O7hKBrT1PzrRM17F0aVLAAd7L/qqWL783/43Uqiw3nRFtuZ5N9A
	 9N7oyXsq2hMGzT0kqO2JQWD0YLRqImpEz+8VvQGmMO0GyMZV3kqDpfj+HdTW6Q0yAf
	 gcAUl4gzeXsQHgAd/z3c8jDIQ8YQZghMCOzWLG/EIGOI4bBP7BggG3qTJh20sGOB8b
	 kS8wxpQ9zgD/w==
Date: Thu, 18 Jun 2026 09:47:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 6/7] Documentation: bootconfig: document build-time
 cmdline rendering
Message-Id: <20260618094719.17bf5448351adc2e56c267fb@kernel.org>
In-Reply-To: <ajJu2KlfVyuUH-VA@gmail.com>
References: <20260609-bootconfig_using_tools-v4-0-73c463f03a97@debian.org>
	<20260609-bootconfig_using_tools-v4-6-73c463f03a97@debian.org>
	<20260610233720.82fe59cf42aa57659c2e5697@kernel.org>
	<ail6rQnRYKsXPxyF@gmail.com>
	<ajJu2KlfVyuUH-VA@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 02:56:23 -0700
Breno Leitao <leitao@debian.org> wrote:

> On Wed, Jun 10, 2026 at 07:58:10AM -0700, Breno Leitao wrote:
> > On Wed, Jun 10, 2026 at 11:37:20PM +0900, Masami Hiramatsu wrote:
> > > To avoid confusion, when this option is used, shouldn't we treat it
> > > the same way as if embedded command lines were enabled, and either
> > > not display it in /proc/bootconfig (or always display it, by merging
> > > the rendered string)?
> > 
> > You're right that EMBED_CMDLINE breaks it: the embedded kernel.* keys
> > are already in boot_command_line before setup_boot_config() ever sees
> > the initrd bconf, so a user reading /proc/bootconfig would see only
> > the initrd keys while parse_early_param() acted on the embedded ones.
> > That's exactly the split-state Sashiko was circling around.
> > 
> > Both options you suggest work for me, but they pull in opposite
> > directions and I'd rather not guess wrong on the user-facing
> > contract.  Which do you prefer for v5?
> > 
> >   (a) Don't display embedded in /proc/bootconfig -- keep the current
> >       "file shows the active bootconfig source" behavior and document
> >       that with EMBED_CMDLINE=y, the kernel.* subtree may have been
> >       applied separately via the cmdline.
> > 
> >   (b) Always display embedded by merging the rendered string into
> >       /proc/bootconfig when EMBED_CMDLINE=y, so the file reflects
> >       what was actually applied.
> > 
> > Happy to go either way
> 
> Following up on my own mail rather than leaving it fully open: after
> looking at the code more, I'd like to recommend (a).

Agreed. Sorry for replying late.

> 
> The deciding factor is ordering. EMBED_CMDLINE only works because the
> embedded "kernel" keys are folded into boot_command_line in
> setup_arch(), before parse_early_param() -- which is long before
> setup_boot_config() looks at the initrd.

Yes. Unless doing setup_arch() we can not get initrd image, this means
we don't know whether there is bootconfig or not at that point.

> 
> So for early params the embedded values are necessarily applied first, and an
> initrd bootconfig cannot override them no matter how we present
> /proc/bootconfig. That makes the embedded cmdline behave like a build-time
> CONFIG_CMDLINE rather than a bootconfig source, and (a) is the option that
> describes it honestly: it shows in /proc/cmdline, and /proc/bootconfig keeps
> meaning "the bootconfig tree that was parsed".

Indeed. So I think this EMBED_CMDLINE is more like CMDLINE set by bootconfig
file, instead of embedded string. That is useful for reusing the boot options.
We need to change the explanation and clarify it.

Thus we should those configs mutual exclusive. If user already sets the
CONFIG_CMDLINE, EMBED_CMDLINE should not be enabled.

But actually, there is another options we need to mention:

- CONFIG_CMDLINE: default cmdline, could be ignored if bootloader passes
   a cmdline string.
- CONFIG_CMDLINE_FORCE: ignore the other cmdline. (but bootconfig can
  overwrite it, hmm)
- CONFIG_CMDLINE_EXTEND: append the embedded cmdline string to bootloader
  cmdline. (similar to bootconfig current behavior)

- CONFIG_BOOT_CONFIG_EMBED: just an embedded bootconfig. extends the
  existing cmdline, but does not support early parameters. This is ignored
  if user passed bootconfig via initrd.

- CONFIG_BOOT_CONFIG_EMBED_CMDLINE: replacing CONFIG_CMDLINE with bootconfig
  but it will not shown in /proc/bootconfig.

So you can see CONFIG_BOOT_CONFIG_EMBED_CMDLINE is a bit special.
I think it maybe natual that we call it CONFIG_CMDLINE_BOOT_CONFIG.
In this case, we render the cmdline string from bootconfig build-time
and set CONFIG_CMDLINE with the rendered cmdline string.

> 
> (a) is also what the tree already does -- saved_boot_config is built
> only from the XBC tree, the rendered string never enters it -- so it is
> no new code on the /proc side and keeps the series small.

Agreed.

> 
> (b) would pull the flattened cmdline string back into the structured
> tree view and need dedup against the initrd keys, which muddies what
> /proc/bootconfig means for little gain.

I would like to avoid such complexity, just keep it simple as possible.

> 
> So unless you'd rather have (b), I'll take (a) for v5 and extend
> bootconfig.rst to cover the four sources (bootloader cmdline, embedded
> cmdline, initrd bootconfig, embedded bootconfig).

Yes, I agree with you.

> 
> I'll also document the sharp edge -- with both an embedded cmdline and an
> initrd bootconfig, early params reflect the embedded values because the initrd
> is not parsed yet.

My recommendation is to give simpler mind model to users. If it is simply
extend the CONFIG_CMDLINE which can be described by bootconfig file,
that is more managable outside of kernel configuration.

Or, you would like to access cmdline setting via /proc/bootconfig?
In this case, the problem is a bit more limitation of bootconfig side.

Since the kernel cmdline accepts any contradictory settings, if "foo=A foo=B"
are passed, bootconfig will make an error because foo has 2 different
settings.
Typically, this is represented as an array in bootconfig.

 foo = A, B;

But if cmdline bootconfig says:

 foo = A;

and initrd bootconfig says:

 foo := B;

":=" means overriding the previous settings. Thus a contradiction
arises between these two, when rendering /proc/bootconfig. It can not
show 2 different settings for the same key. (it is possible if we
render it twice, but /proc/bootconfig user may not expect it.)

I think it's fine to represent it as an array (foo = A, B) if this
ENBED_CMDLINE is set, but it still seems risky if early parameters
aren't detected. If `early_param = A` is set in the embedded
bootconfig, and accidentally initrd bootconfig sets `early_param = B`
we should ignore latter one (with warning). But maybe it is another
story.

I think we can proceed it without rendering it in /proc/bootconfig
at this point. And later we find the way to detect early parameters
correctly, we can fix it.

(BTW, early parameter problem is a bit complicated. It is not hard
to distinguish early parameters, but kernel accepts the same key
for early parameter and normal parameter. e.g. "console=")

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
