Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9386839A4A0
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210776; cv=none; b=UrZzBRghwevlMNZV35dWTE7wD/S5wWr5BhkxVQtefe9Uf43hILgmzG+BWS2XyJRZuD/5X06Am/myZ+qZ/t9yzuZ3hOinrSKZW2kK/T6WIkwhwATJHC6ExgzQyIcdF60OtJknBSgFVzXK99bJ55qlK38HhbVoCNu9pWoJOBPrh2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210776; c=relaxed/simple;
	bh=DqVyQybPlXg+s2kQKu0tCcmbPDkd24Q8nMn47uMGMhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohWdrVXXM3HlvWQGAGpp38g5K1GpUG41M4Y5zmyuOprAra19Yvi0hqoHZJu/Jq+PHh1GFrOYBUz9OXarBWNMTGTgR9XAwXrxJRUigD8XTXIoOAA4ipPGCalA86UKn1MomwjMVLAaTB+KTkDTzzl0cfRqDSeFQXd7qA+ApogTHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BK5hAmQk; arc=none smtp.client-ip=95.215.58.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BK5hAmQk"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DqVyQybPlXg+s2kQKu0tCcmbPDkd24Q8nMn47uMGMhY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788210772; v=1; x=1788815572;
 b=BK5hAmQkwqXU8WrJ3u4/4aVKHmrO77U/qcCnQR9RiS+oPTbSMiv9YMq3HGiw/bzo8BVI7sS7
 oUXs5oIH/BNwyAhc+g+NxANtDNKy04bG1S0I+J0tVAX5eiWKc50IG20b9P7OsH513qFTqw8UU6M
 i/BXGAe+FdUX1KabiKELbm8A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id df5b3ac7151158ec;
	Mon, 31 Aug 2026 21:12:42 +0000
X-Mizu-Trace-ID: df5b3ac7151158ec
X-Migadu-Flow: FLOW_OUT
Message-ID: <ec3306be-29d3-49e6-8653-0579007774db@linux.dev>
Date: Mon, 31 Aug 2026 14:12:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 4/5] selftests/bpf: Add test for key-less BTF hash
 map
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Mykyta Yatsenko <yatsenko@meta.com>, Alan Maguire <alan.maguire@oracle.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260831110314.150870-1-jiayuan.chen@linux.dev>
 <20260831110314.150870-5-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260831110314.150870-5-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 4:01 AM, Jiayuan Chen wrote:
> Create a hash and an rhash map with btf_key_type_id == 0 and expect
> bpf_map_create() to fail with -EINVAL; a positive control with a real
> key type confirms the rejection is about the key-less BTF. On an unfixed
> kernel the map is created, and the test pins and reads it back to walk
> the bpffs dump path, which reproduces the btf_type_show() NULL-deref - so
> running it on an unfixed kernel oopses the reading task (and panics it
> under panic_on_oops).
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  .../bpf/prog_tests/btf_map_keyless.c          | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
> new file mode 100644
> index 000000000000..a7d037f57a7e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_map_keyless.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +
> +/*
> + * A hash map with a key-less BTF (btf_key_type_id == 0) used to NULL-deref in
> + * btf_type_show() when dumped via bpffs.
> + * A fixed kernel rejects such a map at creation; on an unfixed kernel the
> + * pin-and-read below deliberately walks that bpffs dump path, so it doubles
> + * as a reproducer: it oopses an unfixed kernel (and panics it under
> + * panic_on_oops).
> + */
> +static void check_keyless(int map_type, __u32 map_flags, int btf_fd, int val_id)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts);
> +	const char *path = "/sys/fs/bpf/keyless_map";
> +	__u32 key = 1, val = 0x41424344;
> +	char buf[256];
> +	int map_fd;
> +	FILE *f;
> +
> +	opts.map_flags = map_flags;
> +	opts.btf_fd = btf_fd;
> +	opts.btf_value_type_id = val_id;
> +
> +	/*
> +	 * Positive control: the same map with a real key type must be accepted,
> +	 * so the -EINVAL below is about the key-less BTF and not some unrelated
> +	 * rejection (e.g. an unknown map type).
> +	 */
> +	opts.btf_key_type_id = val_id;
> +	map_fd = bpf_map_create(map_type, "keyed_map", 4, 4, 8, &opts);
> +	if (!ASSERT_GE(map_fd, 0, "keyed create is accepted"))
> +		return;
> +	close(map_fd);
> +
> +	/* A key-less BTF must be rejected. */
> +	opts.btf_key_type_id = 0;
> +	map_fd = bpf_map_create(map_type, "keyless_map", 4, 4, 8, &opts);
> +
> +	if (map_fd >= 0) {
> +		/* Unfixed kernel: reproduce the oops via the bpffs dump path. */
> +		(void)bpf_map_update_elem(map_fd, &key, &val, 0);
> +		if (bpf_obj_pin(map_fd, path) == 0) {
> +			f = fopen(path, "r");
> +			if (f) {
> +				while (fgets(buf, sizeof(buf), f))
> +					;
> +				fclose(f);
> +			}
> +			unlink(path);
> +		}
> +		close(map_fd);
> +	}

The whole `if (map_fd >= 0) { ... }` block can be dropped.

If the map has been accepted (0 instead of -EINVAL), it already catches the bug.
It's unnecessary to reproduce the NULL ptr splat.

pw-bot: cr

Also, I think it would be useful to refactor and extend existing
selftests that were added for the features (for example an old
prog_tests/snprintf_btf.c), instead of adding a new test program for
every regression case. Not a blocker, but an effort in that direction
would be much appreciated.

Thanks!

> +
> +	ASSERT_EQ(map_fd, -EINVAL, "key-less create is rejected");
> +}
> +
> [...]
