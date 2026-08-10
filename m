Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17042C517;
	Mon, 10 Aug 2026 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394269; cv=none; b=eGAnJvQnWeEQ7xePsPf/vo/8ab1AGR0n1/4ipF8pGdKGbWdMX3X7UaKEz6sSmGaFWvLkrRocxz9LQ1m0qcREuoMiahUdNBCuYsBlzg6EYaOPlL3LCqqeG91Soa62hg/EAaGk+ORzB3nXFNcq164CeN9e/5dG9ufzOuonwcS6iHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394269; c=relaxed/simple;
	bh=SSEOECfzeUlHZPeyjKJ6/2pL6ifQvQEbRSx7N8yWinQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mThDxdZ6XfukQ67p6BxqCiO70QOuBarOSzJ3a64ljH5PMS01DUwT1Z1SSb971aCNKfzOBRin4gRpCWgjAEWpwv5yVoZO8r5Qn9cEmZ1XSNsnqhVlpZUP+uY0TQNfeMQ8obDoQ4za1cpz4kUZg7eLrd2kGlf+qe8cRVNFE2EGJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLwFaIxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLwFaIxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312DC1F000E9;
	Mon, 10 Aug 2026 20:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786394268;
	bh=in6MBxaXPFo7ck2FE7fT8KctsIkQpoh8TexIzsMSQqA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YLwFaIxCNY5q6SCRrm7yxkzwO4kU2XXXMEe3yvkElP8EbT+dhtj6LECjg3AWYjre4
	 LoEtrm+FT4ufvBP1eGVDyb37vrPkjl6UT5ZxHteHsPH35/gV/+sP5q3i3MNCpherKW
	 vTvVyXT0HVeASl0SXdLdSUHArf1qUCRfAVj0mi1nTzQKGwmPuvbs4QCWxcBkGKBB3M
	 Qg56wG5E965oM41YkwdnhB2R9o3ny9f7C86Q8FN1WuLweqgasYnmValdxpt/ALYDNU
	 YzncK3MAAQZw5nfgU1O/6AShiTz4t2qb3qScggsCJTZuC52YFKGJUvbGB1iQC/X0sP
	 gUjtpSrOGWxjw==
Content-Type: multipart/mixed; boundary="===============0153095071770105731=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <31c1f4967879c62248ab104f137e2eceb2b071a37ffe4f2d48415a169a98c02f@mail.kernel.org>
In-Reply-To: <CAOZ_KyvMmC8Sa1Yiaqe2istdxYrc0fpeF7RHEb_UeGD046nqig@mail.gmail.com>
References: <CAOZ_KyvMmC8Sa1Yiaqe2istdxYrc0fpeF7RHEb_UeGD046nqig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: avoid overflow in BTF.ext bounds check
From: bot+bpf-ci@kernel.org
To: carrerasdarren@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,shuah@kernel.org,jolsa@kernel.org,yonghong.song@linux.dev,song@kernel.org,martin.lau@linux.dev,memxor@gmail.com,daniel@iogearbox.net,ast@kernel.org,ihor.solodrai@linux.dev,eddyz87@gmail.com,andrii@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 20:37:47 +0000 (UTC)

--===============0153095071770105731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8417de92d028..744f33e2aec9 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3364,7 +3364,7 @@ static int btf_ext_parse_sec_info(struct btf_ext *btf_ext,
>  {
>  	const struct btf_ext_info_sec *sinfo;
>  	struct btf_ext_info *ext_info;
> -	__u32 info_left, record_size;
> +	__u32 data_left, info_left, record_size;
>  	size_t sec_cnt = 0;
>  	void *info;
>
> @@ -3377,16 +3377,17 @@ static int btf_ext_parse_sec_info(struct btf_ext *btf_ext,
>  		return -EINVAL;
>  	}
>
> -	/* The start of the info sec (including the __u32 record_size). */
> -	info = btf_ext->data + btf_ext->hdr->hdr_len + ext_sec->off;
> -	info_left = ext_sec->len;
> -
> -	if (btf_ext->data + btf_ext->data_size < info + ext_sec->len) {
> +	data_left = btf_ext->data_size - btf_ext->hdr->hdr_len;
> +	if (ext_sec->off > data_left || ext_sec->len > data_left - ext_sec->off) {
>  		pr_debug("%s section (off:%u len:%u) is beyond the end of the ELF section .BTF.ext\n",
>  			 ext_sec->desc, ext_sec->off, ext_sec->len);
>  		return -EINVAL;
>  	}
>
> +	/* The start of the info sec (including the __u32 record_size). */
> +	info = btf_ext->data + btf_ext->hdr->hdr_len + ext_sec->off;
> +	info_left = ext_sec->len;
> +
>  	/* At least a record size */
>  	if (info_left < sizeof(__u32)) {
>  		pr_debug(".BTF.ext %s record size not found\n", ext_sec->desc);

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
> index 7d1b478c99a0..77db87dabb03 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
> @@ -1,9 +1,31 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2025 Meta Platforms Inc. */
>  #include <test_progs.h>
> +#include "bpf/libbpf_internal.h"
>  #include "test_btf_ext.skel.h"
>  #include "btf_helpers.h"
>
> +static void subtest_invalid_info_len(void)
> +{
> +	struct {
> +		struct btf_ext_header hdr;
> +		__u32 record_size;
> +	} raw = {
> +		.hdr = {
> +			.magic = BTF_MAGIC,
> +			.version = BTF_VERSION,
> +			.hdr_len = sizeof(raw.hdr),
> +			.func_info_len = UINT32_MAX - 7,
> +		},
> +		.record_size = sizeof(struct bpf_func_info_min),
> +	};
> +	struct btf_ext *btf_ext;
> +
> +	btf_ext = btf_ext__new((void *)&raw, sizeof(raw));
> +	if (!ASSERT_ERR_PTR(btf_ext, "invalid_info_len"))
> +		btf_ext__free(btf_ext);
> +}
> +

Does this new test actually fail on the unfixed code when running on
64-bit architectures?

With sizeof(struct btf_ext_header) == 32 and sizeof(raw) == 36, the
test supplies hdr_len=32, func_info_off=0, func_info_len=0xFFFFFFF8,
giving data_left = 36 - 32 = 4.

With the fixed check, 0xFFFFFFF8 > 4 - 0 yields -EINVAL and ASSERT_ERR_PTR
succeeds as expected.

Without the fixed check, in btf_ext_parse_sec_info():

  info = data + 32 + 0
  btf_ext->data + 36 < info + 0xFFFFFFF8

On LP64, the __u32 len is promoted to a 64-bit offset, so info + 0xFFFFFFF8
becomes data + 4294967320, which is greater than data + 36, and the unfixed
code also returns -EINVAL.

The divergence only appears where the pointer addition wraps, that is on
32-bit builds. Since BPF CI runs on x86_64/arm64, ASSERT_ERR_PTR passes
whether or not the bounds check is fixed, so the test doesn't actually
guard the overflow behavior on the builds where it runs.


> @@ -59,6 +81,8 @@ static void subtest_line_func_info(void)
>
>  void test_btf_ext(void)
>  {
> +	if (test__start_subtest("invalid_info_len"))
> +		subtest_invalid_info_len();
>  	if (test__start_subtest("line_func_info"))
>  		subtest_line_func_info();
>  }

Commit message issue:

>     libbpf: avoid overflow in BTF.ext bounds check
>
>     An invalid BTF.ext subsection length can wrap the pointer addition used by
>     btf_ext_parse_sec_info() on 32-bit builds. The wrapped pointer passes the
>     bounds check and parsing then reads beyond the copied BTF.ext data.
>
>     Validate the offset and length with subtraction before forming the section
>     pointer. Add a selftest using an overflowing func_info_len.
>
>     Fixes: cf579164e9ea ("libbpf: Support BTF.ext loading and output in either endianness")

Does the Fixes: tag point at the commit that introduced the overflow?

cf579164e9ea only renamed the function (btf_ext_setup_info ->
btf_ext_parse_sec_info) and added endianness handling. The overflowing
expression itself is unchanged by that commit. Checking its parent:

  $ git show f896b4a5399e:tools/lib/bpf/btf.c | grep -n 'data_size < info'
  2918:  if (btf_ext->data + btf_ext->data_size < info + ext_sec->len) {

The same pointer-based check is present in the earlier ancestors 769ad3a61e33
and e8957c0dde3c. It was absent only in the original 2993e0515bb4 (which used
`last_func_info_pos > data_size`). The 32-bit wrap dates from the commit that
introduced btf_ext_setup_info() and its pointer-based bound check, well before
cf579164e9ea (v6.12).

Because cf579164e9ea landed in v6.12, the current tag excludes every stable
kernel between the real origin and v6.12, even though they contain the
identical wrapping comparison. Should the tag reference the commit that
added the pointer-based check in btf_ext_setup_info()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31426491597
--===============0153095071770105731==--
