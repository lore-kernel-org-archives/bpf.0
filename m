Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D00F3EB81E;
	Mon, 14 Sep 2026 07:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372216; cv=none; b=T3AWLgI27eW1mrqQBcaqd15W61VGtE8U08ikEUe35hQmAO5k4r6siMSzY9MZ9m1e7tDm21lm/P/Sre82kt7N1G+sWJVFyfSzdfAy+8WoaTlymhXEugQAyPnkyQF7QW89kgPTIHpZYOulLOxGHXYnykiDNYU3esEiYOasY777eSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372216; c=relaxed/simple;
	bh=Dz9apUf+u84aOX9At9CtayQ2nOTt9/cxRnAI075CIK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9OCCCymZANLo9HQof0lT/kOX9J7oqjfLUEu3Ljr1o4leeWTKuhIYhJi+P+gTzGH0U+bSuudmO74egBbNWoszfIAJkvHz/8x6+SqOC6OEfedjiw1hviEya4BE6lLSX1Hf1kiCjyfZ4BrKYfCWjOBaLbdGbjdr9dJGtpKQFpQaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b=q6ST5aRZ; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fritz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fritz.com header.i=@fritz.com header.b="q6ST5aRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fritz.com; s=mail;
	t=1789372202; bh=Dz9apUf+u84aOX9At9CtayQ2nOTt9/cxRnAI075CIK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6ST5aRZEJjpDhj7xywJe9leI/SVoCecBMa93qBOib3DJCAo4WdEJNBn8fH4P2F7L
	 Zdj4aDRR1VNFFpQkz37WO+23ZFkbCDEqYeBq+AMV24Qpxo+pUhfePHITOI71oSofSt
	 vEGGmhvuHFvBFuSAj5yhL7AAhE1lrVlvhW7RprnsW/hZ+QaQH7aIfgStTNkTqckfFS
	 p3t68uJj3fLNwuWrEGjZ/fJYLlNmFClPItmb/r0omlwcYM5713AThlaMqV5SKBM+tO
	 4g6mjXp/YpT/WxcPtgqUhR0fvhPHujEGm5Lr9K1nnI5e4yDYdiytXAgD5a0wRJjjmm
	 AqpLQ3Bcyw3GQ==
Received: from [2001:bf0:244:244::78] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <n.schier@fritz.com>)
	id 6aa7a72a-ea3f-7f0000032729-7f000001b804-1
	for <multiple-recipients>; Mon, 14 Sep 2026 09:50:02 +0200
Received: from mail-auth.fritz.com (unknown [IPv6:2001:bf0:244:244::78])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon, 14 Sep 2026 09:50:02 +0200 (CEST)
Date: Mon, 14 Sep 2026 09:50:01 +0200
From: Nicolas Schier <n.schier@fritz.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, jolsa@kernel.org, ihor.solodrai@linux.dev,
	yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	mcgrof@kernel.org, petr.pavlu@suse.com, tj@kernel.org,
	kees@kernel.org, bpf@vger.kernel.org, nathan@kernel.org,
	arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
	atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 13/18] kbuild: Add support for BTF inline
 information
Message-ID: <20260914-axiomatic-meaty-lynx-8a5dc7@l-nschier-aarch64>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-14-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901165757.801449-14-alan.maguire@oracle.com>
Organization: FRITZ! Technology GmbH
x-ms-reactions: disallow
X-purgate-ID: 149429::1789372202-0B4EA720-B279DB67/0/0
X-purgate-type: clean
X-purgate-size: 2754
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-pfmilter: host: postfix-mx-02  mail-id: C6763A0446  external: no

On Tue, Sep 01, 2026 at 05:57:52PM +0100, Alan Maguire wrote:
> Add CONFIG_DEBUG_INFO_BTF_INLINE to generate BTF inline-location
> information with pahole v1.31 and later.
> 
> Enable pahole's inline feature and pass --inline to resolve_btfids.
> This extracts LOC_PARAM, LOC_PROTO, and LOCSEC types into a split BTF
> blob named <output>.BTF.inline while the ordinary BTF remains in .BTF.
> 
> Embed the resulting blob in a .BTF.inline ELF section for vmlinux and
> modules.  Add the vmlinux linker-script output section to avoid it
> being treated as an orphan.
> 
> Use the inline pahole feature unconditionally for both in-tree and
> external modules; the generated split BTF has the same format in both
> cases.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 11 +++++++++++
>  lib/Kconfig.debug                 | 17 +++++++++++++++++
>  scripts/Makefile.btf              |  7 +++++++
>  scripts/gen-btf.sh                | 17 +++++++++++++++--
>  4 files changed, 50 insertions(+), 2 deletions(-)
> 

[...]
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1244dcac2294..dd1b2d9ebe99 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -425,6 +425,12 @@ config PAHOLE_HAS_LANG_EXCLUDE
>  	  otherwise it would emit malformed kernel and module binaries when
>  	  using DEBUG_INFO_BTF_MODULES.
>  
> +config PAHOLE_HAS_INLINE
> +	def_bool PAHOLE_VERSION >= 131
[...]
> +config DEBUG_INFO_BTF_INLINE
> +	bool "Provide information about inline sites in BTF"
> +	default n
> +	depends on DEBUG_INFO_BTF && PAHOLE_HAS_INLINE && SYSFS

[...]
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index a1812985a61a..d42dbc8d7199 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -22,7 +22,14 @@ endif
>  
>  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
>  
> +btf-inline := $(CONFIG_DEBUG_INFO_BTF_INLINE)
> +ifneq ($(btf-inline),)
> +btf-inline-feat := inline
> +pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=$(btf-inline-feat)
> +endif
> +
>  export PAHOLE_FLAGS := $(pahole-flags-y)
> +export BTF_INLINE := $(btf-inline)


As btf-inline and btf-inline-feat are not used anywhere else, and 
CONFIG_DEBUG_INFO_BTF_INLINE can only be set for PAHOLE_VERSION >= 131, 
this looks a bit noisy to me.  I think it would be good to keep that 
change in scripts/Makefile.btf as short as possible, e.g.:

    pahole-flags-$(CONFIG_DEBUG_INFO_BTF_INLINE) += --btf_features=inline

and for scripts/gen-btf.sh something like:

    if is_enabled CONFIG_DEBUG_INFO_BTF_INLINE; then
    	BTF_INLINE=inline
    fi



Kind regards,
Nicolas
