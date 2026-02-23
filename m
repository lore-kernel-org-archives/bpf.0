Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010411713;
	Mon, 23 Feb 2026 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832449; cv=none; b=OubrZFCzBbpn80ESeQerXXp3ifmMXvOzIOXbUn5JCv8mbFi5zQt1db3tWHDrPhPwq5OoavbnuNN2nVBZ3llN67/uxI8FrXQoYudO8txcvZGAtp5/mUWty+khWzbKBuI1sNgFHwDFbiJ57Tz6cb0mmifmLu7QUEB0VfKJXUonsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832449; c=relaxed/simple;
	bh=CxaDwbig37h5hpH+C7Wh0Qr4UZNcEoBhOPLK6pD3b5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEewRLvKDXl7UX7RqEIp2DCEfTpYg0TClKix+yZ4+1iDoEWld0Lq8qCoYDgTqGPbyRE4jnuKqjniDCO/O/fkVboqxBd1rIxMCxorBF15nppwFKN7C6LBXu1TX8qVtS+4+f1WuxLxWLvHsVolLJJI6rk/DCGGfzuVT31AzfGv4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Pve0eBlX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Pve0eBlX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771832439;
	bh=CxaDwbig37h5hpH+C7Wh0Qr4UZNcEoBhOPLK6pD3b5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pve0eBlX22YVcmLtyNIH9Lbu1SjN9E8m875a8Bnw6wnrqIXZ4svJsBZKhm4MO+8xD
	 zt+zcEDNR3xOp6159rwA0P0i/yoWbL1/nW2DgxK4fOgB6X/LPPmdy2eWzf2Egz6kxI
	 TwBj634NJLqYN12iSD/57wrpnhMA0Pgo6mviRnnM=
Date: Mon, 23 Feb 2026 08:40:38 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Fwd: [PATCH v4 07/17] kbuild: generate module BTF based on
 vmlinux.unstripped
Message-ID: <ce1268e0-9479-4502-8f65-f6f9c0cef576@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-7-0b932db9b56b@weissschuh.net>
 <27a43b85-5a7b-4e53-81c5-a34a3c0d1735@t-8ch.de>
 <3602c85a-8680-4074-9632-9be849dd414f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3602c85a-8680-4074-9632-9be849dd414f@linux.dev>

On 2026-02-20 08:55:45-0800, Ihor Solodrai wrote:
> On 2/20/26 1:29 AM, Thomas WeiÃschuh wrote:
> > could you take a look at the patch quoted below?
> > It is part of a patch series which only tangentially touches BTF [0].
> > If you prefer to receive the full patch series, please let me know and
> > I'll do that for the next revision.
> > 
> > [0] https://lore.kernel.org/lkml/20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net/
> 
> Hi Thomas, thank you for the ping.
> 
> The BTF generation process has significantly changed recently:
> https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@linux.dev/
> 
> I suggest you rebase the integrity checking series on top of that
> (it's already been merged into Linus' tree).
>
> Adding a .stamp is a small and simple change, so maybe it's worth
> landing separately through BPF tree?

On its own this stamp files doesn't make much sense in my opinion.
With the new BTF generation (and general changes to my series) it may
also not be necessary anymore. So I'd like to keep this patch as part
of the series.

The important point to get feedback on, is less the stamp file but the
usage of vmlinux.unstripped as base for module BTF generation as shown
in the patch below.
Looking at that again, I'll need to validate it with out-of-tree
modules.


Thomas

> > On 2026-01-13 13:28:51+0100, Thomas Weißschuh wrote:
> >> The upcoming module hashes functionality will build the modules in
> >> between the generation of the BTF data and the final link of vmlinux.
> >> At this point vmlinux is not yet built and therefore can't be used for
> >> module BTF generation. vmlinux.unstripped however is usable and
> >> sufficient for BTF generation.
> >>
> >> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> >> ---
> >>  scripts/Makefile.modfinal | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> >> index adfef1e002a9..930db0524a0a 100644
> >> --- a/scripts/Makefile.modfinal
> >> +++ b/scripts/Makefile.modfinal
> >> @@ -40,11 +40,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
> >>  
> >>  quiet_cmd_btf_ko = BTF [M] $@
> >>        cmd_btf_ko = 							\
> >> -	if [ ! -f $(objtree)/vmlinux ]; then				\
> >> -		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
> >> +	if [ ! -f $(objtree)/vmlinux.unstripped ]; then			\
> >> +		printf "Skipping BTF generation for %s due to unavailability of vmlinux.unstripped\n" $@ 1>&2; \
> >>  	else								\
> >> -		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
> >> -		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
> >> +		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux.unstripped $@; \
> >> +		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux.unstripped $@;	\
> >>  	fi;
> >>  
> >>  # Same as newer-prereqs, but allows to exclude specified extra dependencies
> >>
> >> -- 
> >> 2.52.0
> >>
> 
