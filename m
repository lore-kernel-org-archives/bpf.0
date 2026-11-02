Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638397;
	b=QBYxoOdXkub88R4TAkcM9KxemccS6hJbuDCTZqw+Plon3S3CgTnNhGAQEKL5OtJWcOSs
	 uxOFsyMJWA6qP8exz4MMoozl5eBYE7WL/v9XfLvQSEp1kNCtTMwptKkYUi2s8KZQnowr/
	 NONGxLtbK61B5mbxWgZLd6ik88repJS6IqBR6ywDGxKCcvrjerVhUmQxZMQslnbT/qMZW
	 6EUhmTFpe+e6lM0Fi5AlZvxoYFEb9G0UzjRQE2K1e3OH6cuNi37IGjmaCYs6sB0rJkCni
	 LHoA7taARVzzjGnuVTAucpzM9ehhfHxUOOUJzjJuQYp33GRol2x0MNiOEAnbjiTK7cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638397;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0S6zeVQB6JXDivuIwwZkxYqZ6mbJYmib3ujqs9acEWI=;
	b=zWtcDMEVZKthpWInHNM0NlbTyg6ZVwK6yN8rY1ntQr28qIE/faGwXWKq+b32faUjVQsD
	 EsK8LVjdgiEmElMYfdCfpJpNN6mQTFTjfQe5yCdZagxx3MrJOchoV3Bzf47NURpVE8oJW
	 vCQ//EfTXcPMw0fsCOIIkDJvgZ0cQJiwJNxrDuAn7GcTO6MFUwC/gHGO6GdXIrBwwmomv
	 u+Bx/FcEF3nuRSqheYpw0nzSw8SKx3e7TI0HUS2uRiOMKXWETOKw9opszvgvvYD8yAdGX
	 1nhPGoedyoGiB/CQ6W6aR/0daNDY7SwQUAcXxb/p1yLyNe2G26oiA9hd5M/wpxjUUqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="izG/P3oc";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5A6078267
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izG/P3oc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4A91F0180E;
	Mon,  2 Nov 2026 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793638396;
	bh=0S6zeVQB6JXDivuIwwZkxYqZ6mbJYmib3ujqs9acEWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=izG/P3ocmODvrrYJzx5kyn1JwcrWCMRRqFDW0ONajnG/ohNIFWMcHH/4y1uz3N3pm
	 +Tl4tZRzUMyxzMq/gPUTEY8MoVWhfjlf0kZIT1mhAeUvubNBBDOuMZdSy3goHettLS
	 2zJQtoSwlFsWodta0DRXCWmuIYjhUsIvHjdF5D9JkQlzoiHqlLiQ0TLAgFJ45OY6vX
	 w6as/KE5l5ISA619w2UsgpA0mx93y0RD8xiKU3mn2ODI/IJaCT4nf2/6LxQIF6T3jU
	 Ro2NEiJoSZnr9u5UOePfczMbFwgCXIlji5hViRCGTO2EeNi9jE79ow0VC1Yq3Gr5cn
	 y3t0htafvEcuw==
Message-ID: <9744e311-92ff-40a3-9a66-de5654074bb6@kernel.org>
Date: Mon, 2 Nov 2026 17:53:13 +0100
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
Subject: Re: [PATCH bpf-next v3 13/13] bpftool: Document __bpf_relocatable and
 __bpf_static_offset
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 David Faust <david.faust@oss.qualcomm.com>, Ian Rogers <irogers@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Vineet Gupta <vineet.gupta@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
 <20261030233355.1836749-14-ihor.solodrai@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261030233355.1836749-14-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-10-30 16:33 UTC-0700 ~ Ihor Solodrai <ihor.solodrai@linux.dev>
> The C dump annotates record definitions with the __bpf_relocatable and
> __bpf_static_offset macros. Programs control the attributes through
> these macros and BPF_NO_PRESERVE_ACCESS_INDEX, which disables only
> __bpf_relocatable.
> 
> Both macros expand to complete attribute specifiers and can be
> pre-defined by the user.
> 
> Update bpftool documentation to explain both macros, and how to avoid
> the Clang crash on CO-RE field-info builtins over __bpf_static_offset
> types.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  .../bpf/bpftool/Documentation/bpftool-btf.rst | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> index c6dc445cd4a1..6840d5d3c39d 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -70,6 +70,32 @@ bpftool btf dump *BTF_SRC* [format *FORMAT*] [root_id *ROOT_ID*]
>      formatting, the output is sorted by default. Use the **unsorted** option
>      to avoid sorting the output.
>  
> +    C output annotates struct and union definitions individually, with or
> +    without **unsorted**. Most records carry ``__bpf_relocatable``. The
> +    generated header defines it as
> +    ``__attribute__((preserve_access_index))`` where supported, or as empty
> +    when **BPF_NO_PRESERVE_ACCESS_INDEX** is defined or the compiler lacks
> +    the attribute. GCC-BPF can apply CO-RE through these attributes.
> +
> +    Context and socket types whose field accesses the verifier rewrites
> +    carry ``__bpf_static_offset`` instead, and their nested anonymous
> +    records carry no attribute. Where supported (Clang 18 and later),
> +    ``__bpf_static_offset`` expands to
> +    ``__attribute__((preserve_static_offset))``. It is empty otherwise.
> +    The attribute keeps static field offsets in load and store instruction
> +    immediates. **BPF_NO_PRESERVE_ACCESS_INDEX** does not affect
> +    ``__bpf_static_offset``.
> +
> +    Either macro may be pre-defined as a complete annotation, such as
> +    ``__attribute__((preserve_access_index))``, or as empty to override
> +    the policy.
> +
> +    Clang 18 through 23 crash when ``__builtin_preserve_field_info`` is used
> +    on a type marked ``__bpf_static_offset``, including through
> +    ``bpf_core_field_*`` and the CO-RE bitfield helpers. Compile with
> +    ``-D__bpf_static_offset=`` to use these helpers with an affected
> +    compiler.
> +
>      **root_id** option can be used to filter a dump to a single type and all
>      its dependent types. It cannot be used with any other types of filtering
>      (such as the "key", "value", or "kv" arguments when dumping BTF for a map).


Hi Ihor, thanks for this work. I don't have much to say in addition to
what Alexei reported, but when you respin, could you please move these
paragraphs to a dedicated section in the doc? Maybe "GENERATED HEADERS"
between OPTIONS and EXAMPLES (just keep one line here to refer to that
new section).

You could even (but don't have to) add a new EXAMPLES entry, something
like "$ bpftool btf dump file /sys/kernel/btf/vmlinux format c >
vmlinux.h", then "$ cat vmlinux.h" and show some truncated output with
some visible __bpf_relocatable and __bpf_static_offset annotations.

Thanks,
Quentin
