Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214391;
	b=15I3sltQXataUijpXYc6JmYV4puws4lRG+ZicWezW/wIXeemCEPQFhRfApjo1WtI5qWF
	 bdXHNwAnjj4AcaDYMq4tk42nCAjD87ySjBgfQPt7CuwWoIg+Wr5R9y9ci5SOevOlhDfou
	 eygjF2LuBY8UVYXQ9vQRAz+abSUBdWkFMbEROn/jS6p27ifPfyQVqrVmu1D/IzT0zyNgh
	 Ksy4UGPP47hE87H2nCtxIZ/6c5/o8IkV6KiDNYcaZhKtFua3FM2vGKmcc2MfJb9TKBMJF
	 tVmKqVuFGVHDqke16rNseYCblFJPDlUPPj6zwG/rYXaq+mOWhJeWgJAXFbMkSfyy9jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214391;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=gykP9zmriVR3eM/lfPWpOkrW6XmcVWOWs/7SjbNQO2w=;
	b=UL41AlHoi6vByLm6BJgifaK4jv5qhdWmjfqdBZq9aRWVidnUEn6HL4gE9hRiHWKY/oeH
	 hjVol6Ne1besguY8kqqvAf2hxetrQDPdrsJPkdY/OE19B/Pq+6IKfCU/GaI0W09Ew+L2D
	 fvjm8S8FIj95eEnbZiGMlmJFX0asxPtRQ7C4oTNFcLvVhSd2xCmyl8KBhx0AjFtS0iQPd
	 w9JWcwvijeEtX8ZmsFzo1X+fJR1w8CrqPnrUjHAzgNgyrbgTR5h2U359FcUlHtgPNP8dM
	 D/NOnEvwJF5GQSAepUex13go2XlHi4S8pT3WomjXQy/A8e7TgBSf12p2WZDTgtNezjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in129To1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E45606A6A5
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=in129To1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334C31F000C0;
	Fri, 20 Nov 2026 22:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214390;
	bh=gykP9zmriVR3eM/lfPWpOkrW6XmcVWOWs/7SjbNQO2w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=in129To1UmtC88X1g1fW3ho0ZiZNwB9j7PbqLsn6xfWePql2ljW9yxxZmpsq4afM2
	 Zbcog9u7rsuLlW1cBAD+SV8w3ZVC6q7kQdFPZSKgxDiXNn6Blje0fsbKOvQ2IyUJfM
	 QNoYs+dgtn0dIopCLBA7UNwesuRGzrxxyArPpR6p/WAxeqgZ1jDpbt7mzdKub2mCD0
	 zSWXi2SXrLHUb0Pb4VzGPbBliMkuLgSe7onx12RipYM+YaVpZxefcWlVTWqhmYA/iE
	 uYzXumZ17AQgksYv/UEgHL8UklVmO9VLJKx2eO27BvsaCpYn+v3f6+vXsDDxdcSOQ9
	 B4LVCKGzk9AuQ==
Content-Type: multipart/mixed; boundary="===============6947423020384097837=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <21bcff8573207e9277c3d209e6712adb4b6e76712b893cfba2e710443bf546d1@mail.kernel.org>
In-Reply-To: <20261120215012.870499-1-yonghong.song@linux.dev>
References: <20261120215012.870499-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Test CO-RE relocations of signed enum values without kflag
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 22:39:49 +0000 (UTC)

--===============6947423020384097837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test CO-RE relocations of signed enum values without kflag

TL;DR: Test issue: the new signed named_int_enum checks in test_core_enumval()
may fail the enumval and enumval___no_kflag subtests on clang 12-14, which
lack enum signedness kflag; should they be guarded by __clang_major__ >= 15?

> diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
> --- a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
> +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c

[ ... ]

> @@ -85,6 +93,12 @@ int test_core_enumval(void *ctx)
>  		out->uint_val1 = UINT_ENUM_VALUE(UINT_ENUM_VAL1);
>  	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL2))
>  		out->uint_val2 = UINT_ENUM_VALUE(UINT_ENUM_VAL2);
> +
> +	/* enum named_int_enum is optional */
> +	if (bpf_core_enum_value_exists(enum named_int_enum, INT_ENUM_VAL1))
> +		out->int_val1 = bpf_core_enum_value(enum named_int_enum, INT_ENUM_VAL1);
> +	if (bpf_core_enum_value_exists(enum named_int_enum, INT_ENUM_VAL2))
> +		out->int_val2 = bpf_core_enum_value(enum named_int_enum, INT_ENUM_VAL2);
>  #else
>  	data.skip = true;
>  #endif

Is this part of test_core_enumval() safe with clang 12 to 14?

These checks sit under the same guard as the rest of the function,
#if __has_builtin(__builtin_preserve_enum_value), which clang 12 and later
already satisfy.  But clang only records enum signedness in the BTF kflag
starting with LLVM 15 (enum64 support).  Before that, the local
named_int_enum gets kflag 0, and so does the target enum built by the same
compiler.

With the libbpf change in this series, bpf_core_zext_enumval() then does not
return early, and zero-extends the target value:

    if (btf_is_enum(targ_t) && !BTF_INFO_KFLAG(targ_t->info))
        res->new_val = (__u32)res->new_val;

For INT_ENUM_VAL2 the local value is 1, so the GCC-form fixup in
bpf_core_patch_insn() does not apply and the instruction is patched with
0xfffffffd.  out->int_val2 would then be 4294967293 while
run_core_reloc_tests() expects .int_val2 = -3.  That would make both the
existing enumval subtest and the new enumval___no_kflag subtest fail with
clang 12 to 14.

The neighbouring programs guard this compiler dependency, for example
test_core_reloc_enum64val.c uses "#if __clang_major__ >= 15" and
test_core_reloc_type_based.c uses
"__has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15",
both falling back to data.skip = true.  tools/testing/selftests/bpf/README.rst
also says core_reloc sub-tests are skipped if Clang is too old to support
them rather than failing.

Should the named_int_enum part depend on __clang_major__ >= 15 so that it
skips instead of failing, or silently leaving int_val1 and int_val2 at 0
(which would also fail the comparison)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44827034192
--===============6947423020384097837==--
