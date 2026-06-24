Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2E25B092;
	Wed, 24 Jun 2026 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290862; cv=none; b=Ts7qa0D45Jm2CyF01/1arDbd9jc51bW6JUKKOQJl9d3GRLX8ks9h7IpuWWkFwH3y/PkkijyMvv7d5A4kyVvOoAc/eRD9uAu1n2FgkhPp31tz8wADXOA0sg9dGWDrsmtTURCig52khc3dEXKUHy4BI+eOjV+LOl8q+CZSDVTBHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290862; c=relaxed/simple;
	bh=b116FrQSfFgK6uDYvZxPIGTwSn7qgoOY6QcZ7jz/mRQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aZzOllbz9Ih9LuHESLFFmJjXRt2QAWU8lgWihSX6AA7Z0on37q3/RHh3A/h0JjYtbwIVsyJJ1OlDMbldyyacjy5RIQuKJkDnrfHXVBsmJdeqh3AyIhugqpkaMrdsUUfx4SqfJwQmg4So4zIOEkQ5tL9qZUD3Lqu15tGfyWXnKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/jTbya3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/jTbya3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB841F000E9;
	Wed, 24 Jun 2026 08:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782290861;
	bh=kryu94ZiuoJZhJYlAoyQe46C2YsO062c3BH0CTq4xAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S/jTbya37hcllfQ/CxBn33/dgOBxA+WxIvjKnDnL5VrDy3rR4TbPCQS/s+EJC0Pd8
	 3YxRplgdwuSJqtLfUYbQGnbPI2CSumWWF+SQ2bmE9RFfqL8egDaNqH34Ipejrdx+c/
	 xgxXEx4whOK+FbZhHHIkQMsTCkPlv8Y/ER+efHSScdC2bpNybRlUmsXK4Fkd6TBfqS
	 yNYK0Rv3clLc0LnDsiJTEaCjeis1gbt5MvbFRb9ge4CzH+lBvVJMta9xNEKhBKeiM1
	 4R7vXShuMfu/KWCQqDrcUHHC+eF3hkFvvSI0rW4xKh1OxlSYAkuLpI3I/me+4mM4fa
	 w5AR4ihTcPLvg==
Date: Wed, 24 Jun 2026 17:47:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v6 6/8] Documentation: bootconfig: document build-time
 cmdline rendering
Message-Id: <20260624174737.a4862dcd86f3d746b788d197@kernel.org>
In-Reply-To: <20260623-bootconfig_using_tools-v6-6-640c2f587a3c@debian.org>
References: <20260623-bootconfig_using_tools-v6-0-640c2f587a3c@debian.org>
	<20260623-bootconfig_using_tools-v6-6-640c2f587a3c@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 09:15:33 -0700
Breno Leitao <leitao@debian.org> wrote:

> Add a section describing CONFIG_CMDLINE_FROM_BOOTCONFIG: what it
> does (renders the embedded "kernel" subtree to a flat cmdline at
> build time so early_param() handlers see the values), what it
> requires (BOOT_CONFIG_EMBED, a non-empty BOOT_CONFIG_EMBED_FILE,
> and ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG -- currently x86 only),
> the bootconfig opt-in semantics, the initrd-vs-embedded precedence,
> and the soft-error overflow behavior.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  Documentation/admin-guide/bootconfig.rst | 81 ++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index f712758472d5c..349cefbb2bbcd 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -234,6 +234,87 @@ Kconfig option selected.
>  Note that even if you set this option, you can override the embedded
>  bootconfig by another bootconfig which attached to the initrd.
>  
> +Rendering Embedded kernel.* Keys at Build Time
> +----------------------------------------------
> +
> +By default, the embedded bootconfig (``CONFIG_BOOT_CONFIG_EMBED=y``) is
> +parsed at runtime, after ``parse_early_param()`` has already run. Early
> +parameter handlers (``mem=``, ``earlycon=``, ``loglevel=``, ...) therefore
> +cannot see values supplied via the embedded ``kernel`` subtree.
> +
> +``CONFIG_CMDLINE_FROM_BOOTCONFIG`` resolves this by rendering the
> +``kernel`` subtree of ``CONFIG_BOOT_CONFIG_EMBED_FILE`` into a flat cmdline
> +string at kernel build time (via ``tools/bootconfig -C``) and prepending
> +it to ``boot_command_line`` during early architecture setup, so the keys
> +are visible to ``parse_early_param()``.
> +
> +The option requires ``CONFIG_BOOT_CONFIG_EMBED=y``, a non-empty
> +``CONFIG_BOOT_CONFIG_EMBED_FILE``, and an architecture that selects
> +``CONFIG_ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG``. Currently only x86
> +selects it; on other architectures the embedded bootconfig still works,
> +but only through the late runtime parser.

As commented by Sashiko, here we need to mention that this option requires
CONFIG_CMDLINE to be empty. This means user can NOT set both option
at once (This also means user doesn't have to worry about configuration
conflicts.)

Thanks,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
