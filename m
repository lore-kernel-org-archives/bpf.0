Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989550;
	b=kkXQIwyJ6oleMP+G1qj95KVxiyNzRy7RAafOHhjGLDQOxA4frBXl+ZWmsxTpTgQ8cm2Y
	 k7jtOmJR3k7+iF9XsJEJ7JBAhTTRnResZ1KIkUVV8X1a3R5NCqIaDF80CYIoH8tcjB2GW
	 ufcZVdy13g4a2bWAq9rwV6eiInJ3k0XAZhz/eqRMgdEefwQLTUi7S3YLw3gwyCxb3ednN
	 mvChM3SpvLh+hSjikxorUQbl5YR2rNHK/R1/rCsTjZRGOFzw01KzP6dtSkCfSwLs/ntki
	 VHx37xK2eZYIlTDrfrOQvtu/FjaUldX1rqDgxtngIt6vDnLfxy/nLkHUM/rG6mt1Qvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989550;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=DHRlBKFCjV0BTG2M1ZWOgfuDUoJvakvyGUMeb2Rza7Q=;
	b=V7kTZ5t0cw/UddfyGJc2ij5RhTiG9rQZMRhq5uklLu7WA4TAOYVZwHc6Fh8FCnotSvM3
	 StE1ZyRajEJAbevRre/WBog++KMYa+62DcCF2fL7gp/fZ84J7yI7Mhn29+GVeKaNkw9C1
	 9PuVoOfRkYBXyXOWQ9nNccletdByjg9IfDBbE2f0BnO8AgmAnoTUIzEQt2FHzK8xKsRij
	 0V/zbFsIlQ6AdgpGwRphe+O8RNNWc2AsrEQVROT+ppj2APRWnYOd5+EcWmrMuQfG56zCp
	 hYOCSywS/6Jb03wnuTr3HZDbgZeDHOG3wCqZOGX8E7oNoTHO8DU+rKxD+b9rHMZGqNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfL2Cwii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A35606A31C;
	Wed, 18 Nov 2026 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfL2Cwii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0E11F000C4;
	Wed, 18 Nov 2026 08:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794989550;
	bh=DHRlBKFCjV0BTG2M1ZWOgfuDUoJvakvyGUMeb2Rza7Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cfL2Cwiiesu7N5DX8GO8OsSwK1g9xg1cHl7pTFnjVj9jGq5O2XJBetQBm5Kpx5iIm
	 wvzk2SKwakT8+yZxpqWVVUv8usaEBTPmjhGup6Gm67MTluDOcuBc3s8ZNiIWfWe+PM
	 JdB3K8zqxn/EY0ehnzhsyxUkgIsnoyXNQrpxCrLXO1/zRIpFULOs0DdiFb3mO7+BNn
	 c77Tk9VoGfz12RdzcFsxZ3Lrp+6VlBb9bTT++YRfCiVWq/L9hze8O19uvckI7H1NDn
	 6jyNODgLkeD596B9l1O7tTwGzS1sunRVrUM81721zbYHCgL/8QwK6mWQxFxrSAmE48
	 jbktq6caDJH2g==
Content-Type: multipart/mixed; boundary="===============5068771745032343532=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4dc53ab0f94a58a47fffc6932879ca896452682af07495754691befc12181340@mail.kernel.org>
In-Reply-To: <20261118073309.125424-1-luyun_611@163.com>
References: <20261118073309.125424-1-luyun_611@163.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Run all summarization freplace cases
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 18 Nov 2026 08:12:28 +0000 (UTC)

--===============5068771745032343532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Run all summarization freplace cases

TL;DR: The four newly enabled sleepable freplace selftests will likely fail on
arm64 and s390, because main_might_sleep and main_does_not_sleep lack
__arg_ctx and the extension is rejected; they only work on x86.

> diff --git a/tools/testing/selftests/bpf/prog_tests/summarization.c b/tools/testing/selftests/bpf/prog_tests/summarization.c
> --- a/tools/testing/selftests/bpf/prog_tests/summarization.c
> +++ b/tools/testing/selftests/bpf/prog_tests/summarization.c

[ ... ]

> @@ -116,9 +116,9 @@ void test_summarization_freplace(void)
>  	};
>  	char buf[64];
>  
> -	for (int t = 0; t < 2; t++) {
> -		for (int i = 0; i < ARRAY_SIZE(mains); ++i) {
> -			for (int j = 0; j < ARRAY_SIZE(replacements); ++j) {
> +	for (int t = 0; t < ARRAY_SIZE(mains); t++) {
> +		for (int i = 0; i < ARRAY_SIZE(mains[t]); ++i) {
> +			for (int j = 0; j < ARRAY_SIZE(replacements[t]); ++j) {

The four sleepable cases that now run (main_might_sleep_with_* and
main_does_not_sleep_with_*) look likely to fail on arm64 and s390.

The replaced main programs in progs/summarization.c take an untagged
pt_regs pointer:

    SEC("?uprobe.s")
    int main_might_sleep(struct pt_regs *ctx)

    SEC("?uprobe.s")
    int main_does_not_sleep(struct pt_regs *ctx)

When the target loads, do_check_common() calls btf_prepare_func_args() for
the main function, and the argument is only treated as ARG_PTR_TO_CTX if
btf_is_prog_ctx_type() matches it against bpf_user_pt_regs_t:

- x86: typedef struct pt_regs bpf_user_pt_regs_t, so the name matches.
- arm64: typedef struct user_pt_regs bpf_user_pt_regs_t, which does not
  match "pt_regs".
- s390: typedef user_pt_regs bpf_user_pt_regs_t is an anonymous struct, so
  the tname is empty and the check fails.

On arm64 and s390 the argument then becomes ARG_PTR_TO_MEM | PTR_MAYBE_NULL
and func_info_aux[0].unreliable is set.  libbpf does not rewrite it since
there is no arg:ctx decl tag.

Then bpf_check_attach_target() rejects the extension first:

    conservative = aux->func_info_aux[subprog].unreliable;
    if (prog_extension) {
        if (aux->func_info_aux[subprog].linkage != BTF_FUNC_GLOBAL ||
            conservative) {
            bpf_log(log, "Cannot replace static functions\n");
            return -EINVAL;
        }

test_aux() expects the load to fail with "Cannot extend a function that
runs without RCU read lock", and ASSERT_HAS_SUBSTR() on the log will not
find that string.  All four subtests would fail on aarch64 and s390x, both
of which are in the BPF CI matrix.

The sleepable subprogram variants avoid this by using
"struct pt_regs *ctx __arg_ctx".

Should main_might_sleep() and main_does_not_sleep() get __arg_ctx on their
arguments (or use bpf_user_pt_regs_t *) so the cases work on every
architecture?  As it stands, the claim that the patch "enables four
sleepable-program cases" holds only for x86_64.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44261555055
--===============5068771745032343532==--
