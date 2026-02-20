Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7E31AA94;
	Fri, 20 Feb 2026 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579748; cv=none; b=MFJzwip/qQ9dffj88AJDm4gPy6gpj0SShicXVc4PKn3VZtVUj4CVFLygdnTzeG8mR7buJBNeatiw6/84hBMEG5oz9ycIKOCnkWQQlWEL4nezS9/YrGoeMotQneRfGYxL18PyxM1vbyfHO4Hej28Y/yp8n+otySzUQkPZQbfVqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579748; c=relaxed/simple;
	bh=emx7audhmD6VTmnSddgjBHkqRzHSRv6FHPvcXwnQqiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzzfjPqW8fU1lQDoPbhGS6sr10fyCZI6/LK82ztPQm2wUYTTIuQh2Zpy9xiCMreCNTQ2irePZ9ng54TTDvU4lAUXc0u4G2/P63+E+8KWLuUBkSoMQUSQjq0Z14nK6XvrYKJB5CjxAr+DMoSYyAo1HCOp2WfzuS92S7uIYW5D6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lQLg+5xw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lQLg+5xw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771579744;
	bh=emx7audhmD6VTmnSddgjBHkqRzHSRv6FHPvcXwnQqiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQLg+5xwF0anpHpPgjatUs2+D2wNj6r3wqHFvilHEJ/Nd3foLUNW1Ste3YiOyrfYK
	 FHF/8wnEaG6XLeAf1LnFBhCoMDl/LC9eyuXY47Sh/YMS/AgRrWDQLJxNznyU/Sojc6
	 LZrDJ+hxtYljfqBLAU2o+yyDzOTHSaOw4TWs7yw8=
Date: Fri, 20 Feb 2026 10:29:04 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH v4 07/17] kbuild: generate module BTF based on
 vmlinux.unstripped
Message-ID: <27a43b85-5a7b-4e53-81c5-a34a3c0d1735@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-7-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-module-hashes-v4-7-0b932db9b56b@weissschuh.net>

Hi BPF/BTF maintainers,

could you take a look at the patch quoted below?
It is part of a patch series which only tangentially touches BTF [0].
If you prefer to receive the full patch series, please let me know and
I'll do that for the next revision.

[0] https://lore.kernel.org/lkml/20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net/

Thomas

On 2026-01-13 13:28:51+0100, Thomas Weißschuh wrote:
> The upcoming module hashes functionality will build the modules in
> between the generation of the BTF data and the final link of vmlinux.
> At this point vmlinux is not yet built and therefore can't be used for
> module BTF generation. vmlinux.unstripped however is usable and
> sufficient for BTF generation.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  scripts/Makefile.modfinal | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index adfef1e002a9..930db0524a0a 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -40,11 +40,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>  
>  quiet_cmd_btf_ko = BTF [M] $@
>        cmd_btf_ko = 							\
> -	if [ ! -f $(objtree)/vmlinux ]; then				\
> -		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
> +	if [ ! -f $(objtree)/vmlinux.unstripped ]; then			\
> +		printf "Skipping BTF generation for %s due to unavailability of vmlinux.unstripped\n" $@ 1>&2; \
>  	else								\
> -		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
> -		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
> +		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux.unstripped $@; \
> +		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux.unstripped $@;	\
>  	fi;
>  
>  # Same as newer-prereqs, but allows to exclude specified extra dependencies
> 
> -- 
> 2.52.0
> 
