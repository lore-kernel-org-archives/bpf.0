Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318527;
	b=P2xvtUu9N7ca38Ceq5RuoqrBFs/FdVC9l9y8RIL/IxZLMkYFsviAeiGXYYmx6XvlrH2q
	 CbkId4XMhXLD9970YG3l78J1gtmVGXPdDJN9seT7mIALTHxZa+1S5qEE7QlLk3DUJV5I8
	 3uRHZvN+EBOnX2V8DMWBuFzQJPmgFVAenRn9B73VzUCz8t8VyBecfAQh13S3dM1tFoJ1t
	 FQ87etKf64iQwN2A1nsxFxB7DmdYdPQLhn+SOJf5X3ffl8RgQl1EgekaOYUdh+14YxLT1
	 e1dGvWnkE3A7RjbW7spiIjn1IUFDDItngGaJbyaHUvsSkUhANFXl/6sTbyrOlR+iP0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318527;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=PXOumnW9kApZ0xI+3i5ByuI4hNLQiRrA6Srem/lBkIM=;
	b=TXgqQJBpsAWsRRsHntLbulXT68ZYQXRGdVV76piJXtESQvRD/YrfaicC5/4/7h3OV3FQ
	 36DmmgUpHkBgGhSQaFoPNJoX/nsr+36JtHh24y+22yZKQY9KmawrBAUdUuZcsIsG4DFqm
	 fOXptZsM2jaW+TBppDAhu+vFar7cxOCIjKGzZ3G5R2ImMkpK8sLcCh5DUiIW1mcAzVBDb
	 hy1uSq11eAsRMWUITt5Ol0LWC7WtRRURx0L4jAYAiKYnblor0beU4kJFPDsnHUR/ujW+W
	 IHEwpN1AcdDKiHVa5/UYFviAUdg9L0HqRUtwBbnb5ig1CoPK1Q5bnzoKhlvNe6aLNOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIG4oR31;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D2606A338
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIG4oR31
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F62E1F0089F;
	Tue, 10 Nov 2026 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318526;
	bh=PXOumnW9kApZ0xI+3i5ByuI4hNLQiRrA6Srem/lBkIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nIG4oR31eWPSSEWsnufOIzslusEBCNcrewGGcdwdCb1fnPjFJT8iPkUl5Wt5kf57Z
	 vsyaOTOtcxAdtpd/kFovh/GnGUCWlhjNL5dUEi4F16E0E8PrHvibXGpbbfRDFMIgZK
	 QYpx7uFYv6qi9YNtnlOxVcNZXunTN7YonSz2FuK5TIBfolqHBZHJAtKNFmrrWigylX
	 okcGSxrPW8g5Dk5370nhuIWJKxlTLGap9WZRQCIL1McDVS1abPz2qJJ2zBq+P7eVxS
	 QIW64p3q4vhfCefhyvVz1uYbTlllU7mkNmB5TE4Iu9ZWC6UCdeu5iSFBpOtrX5/LHL
	 Grrpy5LyExO6g==
Message-ID: <6b893c11-b43f-4fc0-9c35-83066fb5dce3@kernel.org>
Date: Tue, 10 Nov 2026 13:48:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Add missing commands to documentation
 synopses
To: Dhanush Arivappagari <arivappa.dvorak@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20261104183018.30052-1-arivappa.dvorak@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261104183018.30052-1-arivappa.dvorak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 18:30, Dhanush Arivappagari wrote:
> Several commands and objects implemented in bpftool are currently missing
> from the SYNOPSIS sections in the man pages, causing documentation drift.
> 
> Update the documentation across bpftool man pages:
> - Add the missing 'token' object and its commands to bpftool.rst.
> - Add missing subcommands to the SYNOPSIS blocks of btf, feature, gen,
>   link, map, net, and prog man pages to reflect existing implementations.


Thanks for this! It looks good, I just have a few minor comments.

Nit: The description is not entirely accurate, there's no change in the
SYNOPSIS blocks for -net and -cgroup pages. You can keep the mention of
the objects you add, but I'd just remove the list of updated pages, we
can look at the diff for that.


> - Update help command headings in the cgroup and token documentation
>   to reference their respective objects instead of prog.
> 
> Signed-off-by: Dhanush Arivappagari <arivappa.dvorak@gmail.com>
> ---
>  tools/bpf/bpftool/Documentation/bpftool-btf.rst |  2 +-
>  .../bpftool/Documentation/bpftool-cgroup.rst    |  2 +-
>  .../bpftool/Documentation/bpftool-feature.rst   |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-gen.rst |  2 +-
>  .../bpf/bpftool/Documentation/bpftool-link.rst  |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-map.rst |  3 ++-
>  .../bpf/bpftool/Documentation/bpftool-prog.rst  |  2 +-
>  .../bpf/bpftool/Documentation/bpftool-token.rst |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool.rst     | 17 ++++++++++-------
>  9 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index c6dc445cd4a1..e25277260ceb 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -18,7 +18,7 @@ SYNOPSIS
>  
>  *OPTIONS* := { |COMMON_OPTIONS| | [{ **-B** | **--base-btf**} *FILE*]...  }
>  
> -*COMMANDS* := { **dump** | **help** }
> +*COMMANDS* := { **show** | **list** | **dump** | **help** }
>  
>  BTF COMMANDS
>  =============
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> index d1b8193dc576..7633a42b54b0 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> @@ -131,7 +131,7 @@ bpftool cgroup attach *CGROUP* *ATTACH_TYPE* *PROG* [*ATTACH_FLAGS*]
>  bpftool cgroup detach *CGROUP* *ATTACH_TYPE* *PROG*
>      Detach *PROG* from the cgroup *CGROUP* and attach type *ATTACH_TYPE*.
>  
> -bpftool prog help
> +bpftool cgroup help
>      Print short help message.
>  
>  OPTIONS
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
> index c7f837898bc7..9ed5ff93ebdb 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
> @@ -18,7 +18,7 @@ SYNOPSIS
>  
>  *OPTIONS* := { |COMMON_OPTIONS| }
>  
> -*COMMANDS* := { **probe** | **help** }
> +*COMMANDS* := { **probe** | **list_builtins** | **help** }
>  
>  FEATURE COMMANDS
>  ================
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> index d0a36f442db7..0c0f9616f676 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> @@ -18,7 +18,7 @@ SYNOPSIS
>  
>  *OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ { **-S** | **--sign** } {**-k** <private_key.pem>} **-i** <certificate.x509> ] }
>  
> -*COMMAND* := { **object** | **skeleton** | **help** }
> +*COMMAND* := { **object** | **skeleton** | **subskeleton** | **min_core_btf** | **help** }


Since you're touching this line, can we please fix the first word to
make it "COMMANDS" (plural) instead of "COMMAND", for consistency?


>  
>  GEN COMMANDS
>  =============
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-link.rst b/tools/bpf/bpftool/Documentation/bpftool-link.rst
> index 6f09d4405ed8..21b22aa70fdc 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-link.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-link.rst
> @@ -18,7 +18,7 @@ SYNOPSIS
>  
>  *OPTIONS* := { |COMMON_OPTIONS| | { **-f** | **--bpffs** } | { **-n** | **--nomount** } }
>  
> -*COMMANDS* := { **show** | **list** | **pin** | **help** }
> +*COMMANDS* := { **show** | **list** | **pin** | **detach** | **help** }
>  
>  LINK COMMANDS
>  =============
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index e4ed7e701c9e..391b0c6c0c6a 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -20,7 +20,8 @@ SYNOPSIS
>  
>  *COMMANDS* :=
>  { **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
> -**delete** | **pin** | **help** }
> +**delete** | **pin** | **event_pipe** | **peek** | **push** | **pop** | **enqueue** | **dequeue** |
> +**freeze** | **help** }
>  
>  MAP COMMANDS
>  =============
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index 8dbd34ef3d8b..c239cb506c38 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -23,7 +23,7 @@ SYNOPSIS
>  
>  *COMMANDS* :=
>  { **show** | **list** | **dump xlated** | **dump jited** | **pin** | **load** |
> -**loadall** | **help** }
> +**loadall** | **attach** | **detach** | **tracelog** | **run** | **profile** | **help** }


Another nit: In bpftool.rst's PROG-COMMANDS you add tracelog at the end
of the list (like in do_help() in prog.c); but here, and in the command
description in the same bpftool-prog.rst page, it's before run/profile.
Could you please make it consistent in all four locations ("tracelog" at
the end, to avoid changing do_help())?


>  
>  PROG COMMANDS
>  =============
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-token.rst b/tools/bpf/bpftool/Documentation/bpftool-token.rst
> index d082c499cfe3..1f4e6f4f64b0 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-token.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-token.rst
> @@ -35,7 +35,7 @@ bpftool token { show | list }
>      **bpf**\ () system call commands, maps, programs, and attach types for the
>      token.
>  
> -bpftool prog help
> +bpftool token help
>      Print short help message.
>  
>  OPTIONS
> diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
> index f38ae5c40439..a213f7032d8d 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool.rst
> @@ -21,35 +21,38 @@ SYNOPSIS
>  **bpftool** **version**
>  
>  *OBJECT* := { **map** | **prog** | **link** | **cgroup** | **perf** | **net** | **feature** |
> -**btf** | **gen** | **struct_ops** | **iter** }
> +**btf** | **gen** | **struct_ops** | **iter** | **token** }
>  
>  *OPTIONS* := { { **-V** | **--version** } | |COMMON_OPTIONS| }
>  
>  *MAP-COMMANDS* :=
>  { **show** | **list** | **create** | **dump** | **update** | **lookup** | **getnext** |
> -**delete** | **pin** | **event_pipe** | **help** }
> +**delete** | **pin** | **event_pipe** | **peek** | **push** | **pop** | **enqueue** | **dequeue** |
> +**freeze** | **help** }
>  
>  *PROG-COMMANDS* := { **show** | **list** | **dump jited** | **dump xlated** | **pin** |
> -**load** | **attach** | **detach** | **help** }
> +**load** | **loadall** | **attach** | **detach** | **run** | **profile** | **tracelog** | **help** }


(This is what I was referring to earlier: run/profile/tracelog)

pw-bot: cr

Thanks,
Quentin
