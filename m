Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4D380FFA
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781222270; cv=none; b=TQ6ep6QPoujsCeV06tqi/OuDrs5jnV29pYBYm8ZNYqF8dDh1ZW8yUYYvGANTQ8HMLl0K3UWXu6o933DiuHnwLySQbTGkxZ8hE+o8mMMU7RRWL89Ytv+d64FtHEQWMGlajUhW2upIO908rEMmeXNR4eFDKAWDnnrZsxm8T5Qilcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781222270; c=relaxed/simple;
	bh=joYtZp1DLMtG5NCrCqbZ2vAMHVbq7PSTkwtqz0mC7Yw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qY0CulToRxp1SafTUKSlx9cWGE/zKV4ZDQMzIAjZVs0X9uwcTLDzOXrNeB37CDzkHwrygOzn4qdeOir5uaH9ywmaiM/mvHQ/KeoAgTEPH9FvippBPhw36njvvJjlgaRct5BXrrREFWXgKONtWKkao99kbcBt+bMmNA8eBl6up0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ky6MpRnD; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ky6MpRnD"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137dd523634so640488c88.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781222267; x=1781827067; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiZfNmRVIlmdVfJ43rwYwpCae7PE+p2DOUyDfQoeSn8=;
        b=ky6MpRnD5hpXkv4C3CBu5cVtKT0pn3BNKjVzVnyXqvb1aumI1dRrgb+zWYaSKTloZz
         WCuSZjrB/zSYRK1fAeYdivKepp1y6gKlcGmxlutxG6E7WxE3o/YeLFJm5lfz4LEhmQQg
         gNSPnLk0xsGRH7mj36jBkVV0FYpjmkmUnBqoBkboL5Tqrij+RAFRDt0Te9FL+qG2aHWB
         eMIr7gcc/8D8wqTxbPv379aK3BZo7DJA9I/u9UJffkJGpRp57t/fUrBFlmV6u2VzZW9N
         7LXWaOtw6VV7Xfi5AU8VU7WhJpi2VGzbkqZ/2MYc5HS69mkidSbQYoWtXzP4ZPwKgmln
         LLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781222267; x=1781827067;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OiZfNmRVIlmdVfJ43rwYwpCae7PE+p2DOUyDfQoeSn8=;
        b=f82JjH+9weMV1DfWg742O8qf0/0xn9AgxucJVleGzjqjW7wT6D9HlzprRQvuYt+S4U
         a8h/rTdihogbvS7gkwzvREb7fsGXKBpKFBV5Fp5FLvqSTOPDmxUaOJy5nOVsv1a1ryah
         op2zq+dpIXFnJ5C5qlULNJ5/jhUoK0PrwEzDZozHOlcwAV1eJkplvaM+V5dojNy1kIX1
         xoFqJfkqMEJY6djqhttKFF3mfkQ3eW1VQQjvpogUhsrID3BldChQD9zQKnE1vdagNe1O
         l3xrGmINVd43+4sZbWZVDNUZLq0bIKToH7BcX+YIktLutOzwJ5hRXo9lJlxKW7aZA/+e
         D8Og==
X-Forwarded-Encrypted: i=1; AFNElJ81pmvzTo2Ih99ZF2/R+dllMgNMbKzGfVjqX3qAblFnPVlfispQSyFmq6PHzYxraJqWHvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3SvphUJdMMlQLeqHujVCjLHqW7zWCl81k0nZ0OfOhNctS2eXl
	kyAy5wZ4wnTWHoBHFeIVTL832cvY9g5KjBsEpvihNfaAJTvvfaF9mEESZTtcIK1WBwg=
X-Gm-Gg: Acq92OEh0CDjcXbKx74iBSH/V0+T5KeP5hkXek6N/zKTLi1xvt7rC0xncatsogXzmmT
	wpKaNw43M4o8Yhl0mN70Ymq3i24lM8goWbJ4SL4zJLRQMxJaIcLoShMvO2gwb2JUj8QJT6eFTp6
	3cOLFZzFdITiPG4Li3gOO0k3QSWsAUPDOk4AzFkRIxmTEI8Hb0fZRFPl9xzlTktEpdtk4JEJ4nV
	LbQObvYkZ/250xci5DD4uvRaJNYamSesh7GYYgiJRl2FOOlqcFjwnQrym5ovkEcmbSDqutEoZlO
	DxKzIFhgg4cNqU33ADtsz9j9XyPgUN/V8xxpQ7F9xL9wXK/aFEdV6plr8j51JLspQ71jgpAcDPm
	4pPsJiROXkbRZlHRFqqIIYdQEz4LnYqCsZ1F9RhNQ/rGF28sETPyg1dB+8+orcT74XuU6qOJpzt
	qWgXTX
X-Received: by 2002:a05:7022:ec2:b0:130:6c8f:5aae with SMTP id a92af1059eb24-1384bafedf4mr228935c88.14.1781222267098;
        Thu, 11 Jun 2026 16:57:47 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3c95])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm411958c88.13.2026.06.11.16.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 16:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jun 2026 19:57:44 -0400
Message-Id: <DJ6MLFYZRWEC.3N07REXZNM8HA@etsalapatis.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Junyoung Jang" <graypanda.inzag@gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add arena direct-value
 one-past-end reject test
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Woojin Ji" <random6.xyz@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260610-arena-direct-value-v1-v3-1-d5f0d935ee45@gmail.com>
In-Reply-To: <20260610-arena-direct-value-v1-v3-1-d5f0d935ee45@gmail.com>

On Wed Jun 10, 2026 at 3:13 AM EDT, Woojin Ji wrote:
> BPF_MAP_TYPE_ARENA supports direct-value pseudo loads, but unlike array
> maps its map value_size is zero and the valid direct-value range is the
> arena mmap size, max_entries * PAGE_SIZE.
>
> Commit 3ac1a467e376 ("bpf: Fix off-by-one boundary validation in arena
> direct-value access") fixed arena_map_direct_value_addr() to reject an
> offset exactly at the end of the arena mapping. Add a regression test
> that loads a BPF_PSEUDO_MAP_VALUE with off =3D=3D arena_size and verifies
> that the verifier rejects it with the expected offset in the log.
>
> This is intentionally kept as a userspace raw-instruction test. I tried
> expressing the same BPF_PSEUDO_MAP_VALUE + off =3D=3D arena_size case in
> verifier_arena.c with inline assembly. The only form that produces the
> desired instruction bytes uses __imm_addr(arena), but that emits
> R_BPF_64_NODYLD32, which the libbpf/bpftool link step rejects. Other
> register, immediate, and memory constraints either fail in the BPF
> backend or lower to a normal R_BPF_64_64 load followed by an ALU add,
> which does not exercise arena_map_direct_value_addr() with the boundary
> offset in the second ldimm64 slot.
>
> A legacy test_verifier fixture can express the raw instruction directly,
> but it needs arena map creation, mmap, and fixup plumbing in the legacy
> runner. That is more intrusive than the small prog_tests raw-instruction
> test.
>
> Use the userspace raw-instruction test, following the existing selftests
> pattern used for direct map-value pseudo loads, so insns[1].imm can be
> set to arena_size precisely.
>
> Assisted-by: ChatGPT:gpt-5.5
> Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
> Cc: Emil Tsalapatis <emil@etsalapatis.com>
> Cc: Junyoung Jang <graypanda.inzag@gmail.com>

Nits below, after addressing them feel free to add:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> Changes in v3:
> - Document why verifier_arena.c inline assembly cannot express this case:
>   __imm_addr emits R_BPF_64_NODYLD32, while other constraints either fail
>   in the BPF backend or miss the pseudo-load boundary path.
> - Mention that natural C forms lower to a normal load plus ALU add, so th=
ey
>   do not exercise arena_map_direct_value_addr() with off =3D=3D arena_siz=
e.
> - Keep the userspace raw-instruction test as the least intrusive option;
>   test_verifier was checked but would require legacy runner arena plumbin=
g.
> - Link to v2: https://patch.msgid.link/20260605-arena-direct-value-v1-v2-=
1-a92cb281e376@gmail.com
>
> Changes in v2:
> - Explain why this uses a userspace raw-instruction test rather than a
>   verifier_arena.c failure program: the test must set the second
>   BPF_PSEUDO_MAP_VALUE ldimm64 immediate to arena_size exactly. For
>   arena globals, libbpf derives that immediate from the arena-relative
>   symbol offset, so the boundary value cannot be represented directly as
>   a verifier_arena.c C-level failure program.
> - Link to v1: https://patch.msgid.link/20260603-arena-direct-value-v1-v1-=
1-7b31cc0a8cac@gmail.com
>
> Tested on x86_64 with tools/testing/selftests/bpf/vmtest.sh:
>   $ ./test_progs -t arena_direct_value
>   #2/1     arena_direct_value/one_past_end:OK
>   #2       arena_direct_value:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> ---
>  .../selftests/bpf/prog_tests/arena_direct_value.c  | 73 ++++++++++++++++=
++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c =
b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
> new file mode 100644
> index 000000000000..b7760b021670
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_direct_value.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include <bpf/bpf.h>
> +#include <errno.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +#define ARENA_PAGES 32
> +
> +static void test_arena_direct_value_one_past_end(void)
> +{
> +	char log_buf[16384] =3D {}, expected[128];

Since the log_buf is huge, and the file has a simple test,
just move it to the BSS.

> +	__u32 arena_sz =3D ARENA_PAGES * getpagesize();
> +	struct bpf_insn insns[] =3D {
> +		BPF_LD_IMM64_RAW(BPF_REG_1, BPF_PSEUDO_MAP_VALUE, 0),
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	LIBBPF_OPTS(bpf_map_create_opts, map_opts);
> +	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts);
> +	void *arena =3D MAP_FAILED;

No need to initialize this, we have not code paths where we read the
variable before it gets assigned by mmap().

> +	int map_fd, prog_fd;
> +
> +	map_opts.map_flags =3D BPF_F_MMAPABLE;
> +	prog_opts.log_buf =3D log_buf;
> +	prog_opts.log_size =3D sizeof(log_buf);
> +	prog_opts.log_level =3D 1;
> +
> +	map_fd =3D bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_direct_value",
> +				0, 0, ARENA_PAGES, &map_opts);
> +	if (map_fd < 0) {
> +		if (errno =3D=3D EOPNOTSUPP || errno =3D=3D EINVAL) {

Question: Why is an EINVAL on map creation a skippable event? What failure =
mode
does it correspond to?

> +			test__skip();
> +			return;
> +		}
> +		ASSERT_GE(map_fd, 0, "bpf_map_create");
> +		return;
> +	}
> +
> +	arena =3D mmap(NULL, arena_sz, PROT_READ | PROT_WRITE, MAP_SHARED, map_=
fd, 0);
> +	if (!ASSERT_NEQ(arena, MAP_FAILED, "arena_mmap"))
> +		goto cleanup;
> +
> +	insns[0].imm =3D map_fd;
> +	insns[1].imm =3D arena_sz;
> +
> +	prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT,
> +				"arena_direct_value", "GPL", insns,
> +				ARRAY_SIZE(insns), &prog_opts);
> +	if (!ASSERT_LT(prog_fd, 0, "prog_load")) {
> +		if (prog_fd >=3D 0)

If we only take this path if prog_fd >=3D 0, why the extra check
internally?

> +			close(prog_fd);
> +		prog_fd =3D -1;

No need to set this, we never use it after this.

> +		goto cleanup;
> +	}
> +
> +	snprintf(expected, sizeof(expected),
> +		 "invalid access to map value pointer, value_size=3D0 off=3D%u",
> +		 arena_sz);
> +	ASSERT_HAS_SUBSTR(log_buf, expected, "verifier_log");
> +
> +cleanup:
> +	if (arena !=3D MAP_FAILED)
> +		munmap(arena, arena_sz);
> +	close(map_fd);
> +}
> +
> +void test_arena_direct_value(void)
> +{
> +	if (test__start_subtest("one_past_end"))
> +		test_arena_direct_value_one_past_end();
> +}
>
> ---
> base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
> change-id: 20260603-arena-direct-value-v1-ef4df857b98b
>
> Best regards,
> -- =20
> Woojin Ji <random6.xyz@gmail.com>

