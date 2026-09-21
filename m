Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397AC36212C;
	Mon, 21 Sep 2026 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980538; cv=none; b=QWzqUncjGxuXzCxo+pucOI0VYnf99R4YBzyR7Vvxly16RN0t92+A0hR6W18lJGzV6BPbdkmV24pvVUGQ9QJ2B7/nMQiLnIxoqUC1+6xBvBfAMpAo0evz0eKAaqhikqe0kwDbdgYuZQOx+Mf1GbMYqjwE5ZDL+Uggz85Kbjz9xew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980538; c=relaxed/simple;
	bh=DFfUg5ClLOrHOBWMepX5Gfv15mhM9ZIC8XDYX/pP9vA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F7lRaArNlN0uebpLtc7je6ApBYTM7gT3GjGZBsumrVuidUUTayP/eb5Quex2wCZzY3AUegsG7nefDR9jYt0tlJbqguSkEfEgqyCwmGuCxoThkWe94znsLXp1CBVmf4WKTqNNTdapTkOwgVOUC6+0puY8n0sLVF0Lq95+Tb901OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A91t5ADl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A91t5ADl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844171F000FF;
	Mon, 21 Sep 2026 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980536;
	bh=4dZhAV8+yhhcI9qC/sQXXTWMzu1JCx4YJ9XM8Ibesb8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=A91t5ADlK/naCCsxTVeJrW52uFai25wGuZF4z6Ob7w4vwSmaK4AZYjsjaAjdMcowo
	 9bBwilsWgp9nz5mMSfyLwmdKrFMLzzAMBuBwFbA4dn2mYQAdd3SOFjaBnMvqZCF3XY
	 /HxHoQsGXhzt0vxarPgwpozHL/Zb12cHKJ1fx9+mhylkYijbEwzp6nJplCa7IprwFi
	 pauV5bhZoQETeaIk+KW5t4/ACJgb/h96B8tRSEkGUbchIafKWqjw0WqRsJ5DICEssO
	 +VQ9OoMbaCxXcT60G3ote17FlP/O7cgIP1XQJfEe059OEj016xvGTeK0+yie0WnoSl
	 ckaQKtdzROD5Q==
Content-Type: multipart/mixed; boundary="===============4176070162520392566=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d216266f755dc04f2b45f60a66dca340b26b610777a7609acff04f9e256a4793@mail.kernel.org>
In-Reply-To: <20260921073556.99421-3-hi@tychen.cc>
References: <20260921073556.99421-3-hi@tychen.cc>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Cover bpftool ring buffer event_pipe
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: qmo@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 21 Sep 2026 08:48:55 +0000 (UTC)

--===============4176070162520392566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testing/selftests/bpf/bpftool_helpers.c
> index c49fdd90eb033..9380b24bbf52b 100644
> --- a/tools/testing/selftests/bpf/bpftool_helpers.c
> +++ b/tools/testing/selftests/bpf/bpftool_helpers.c
> @@ -11,7 +11,7 @@
>
>  #define BPFTOOL_DEFAULT_PATH		"tools/sbin/bpftool"
>
> -static int detect_bpftool_path(char *buffer, size_t size)
> +int detect_bpftool_path(char *buffer, size_t size)
>  {
>  	char tmp[PATH_MAX];
>  	const char *env_path;
> diff --git a/tools/testing/selftests/bpf/bpftool_helpers.h b/tools/testing/selftests/bpf/bpftool_helpers.h
> index dec1ba201410f..17e3be8e70730 100644
> --- a/tools/testing/selftests/bpf/bpftool_helpers.h
> +++ b/tools/testing/selftests/bpf/bpftool_helpers.h
> @@ -7,5 +7,6 @@
>
>  #define MAX_BPFTOOL_CMD_LEN	(256)
>
> +int detect_bpftool_path(char *buffer, size_t size);
>  int run_bpftool_command(char *args);
>  int get_bpftool_command_output(char *args, char *output_buf, size_t output_max_len);
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
> new file mode 100644
> index 0000000000000..e9724c55d1dc6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c

[ ... ]

> +static bool emit_record(struct bpftool_ringbuf *skel, int record)
> +{
> +	char packet[64] = {};
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		    .data_in = packet,
> +		    .data_size_in = sizeof(packet),
> +	);
> +
> +	skel->bss->record = record;
> +	return ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.produce),
> +					      &opts), "produce record") &&
> +	       ASSERT_OK(skel->bss->output_err, "ringbuf output");
> +}

This isn't a bug, but since emit_record() also drives the
bpf_perf_event_output() path for record 3, would a buffer-neutral tag
like "record output" read better here than "ringbuf output"?

[ ... ]

> +static void test_consumer(const char *format, bool idle, int signo, bool pinned)
> +{

[ ... ]

> +	if (!idle) {
> +		/* Both prefilled records occupy 16 bytes including their headers. */
> +		if (!consumed(position, 32))
> +			goto out;

This isn't a bug, but would it read more clearly as something like "each
prefilled record occupies 16 bytes including its header", so the 32 below
follows directly from the comment?

[ ... ]

> +static void test_perf_consumer(void)
> +{

[ ... ]

> +	if (!ASSERT_OK(bpftool_ringbuf__load(skel), "load") ||
> +	    !consumer_start(&child, bpf_map__fd(skel->maps.perfbuf), NULL,
> +			    NULL, NULL, false, false) || !consumer_ready(&child) ||
> +	    !emit_record(skel, 3))
> +		goto out;
> +	/* One large record flushes the existing buffered perf output callback. */
> +	pfd = (struct pollfd) { .fd = child.fd, .events = POLLIN };
> +	if (!ASSERT_GT(poll(&pfd, 1, WAIT_STEPS * WAIT_US / 1000), 0,
> +		       "perf record output") ||

This isn't a bug, but could this comment spell out that the perf callback
does not fflush() and the payload is sized so its hex output overflows
stdio's pipe buffer, so the poll() below has something to see?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/bpftool_ringbuf.c b/tools/testing/selftests/bpf/progs/bpftool_ringbuf.c
> new file mode 100644
> index 0000000000000..bbbc93c30a833
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpftool_ringbuf.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +} ringbuf SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +	__uint(max_entries, 1);
> +} perfbuf SEC(".maps");

This isn't a bug, but since produce() emits with BPF_F_CURRENT_CPU and
test_perf_consumer() already resizes perfbuf to libbpf_num_possible_cpus(),
would it read better to drop `__uint(max_entries, 1)` and let libbpf size
the perf event array itself, the way progs/test_perf_buffer.c and
progs/perfbuf_bench.c do?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35575071830
--===============4176070162520392566==--
