Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CCF383C8F
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409967; cv=none; b=i0Z7xwnHCA2ktPQTbHhr/P04NzR5NF0oufkq2drEFcU224Axz00LS4tinhxHlXg+Be8UZDy+9l3Voa3zxkhb6OcZOh1hmWTB2S/S+WqaDwiGboBFoWUyzgzJ5sPYf/P+9xUgVjgyyPTF0jmmf+hZ2cpuo7lwIIOp8EfcHDoe784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409967; c=relaxed/simple;
	bh=cSplGNGSwVBrHU+YX9bf9HevhQP+km9ltS37ed8fMK0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZAeZHpS/Je+/M97uxk36PGBliomM5VcTP47hCw5q/oBNH8/ZY88UJQsFG1NLu6fO1hmtZAJVPxVdhv6xetaiInsUQ1QPDtRfFD3LnM5vhsMw4aIraAadNtufjQ8CZunnXmx+qd1rZEUOcbs5CbkHFkzpl1RX6E9PYg3tW5WJIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBllnWGl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBllnWGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657431F000FF;
	Mon, 14 Sep 2026 18:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789409965;
	bh=Rl2yfqw5z2hK4CzdquBVweVync+JYzck9uRaRj+fnTk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MBllnWGlDQYUlA0NnQlwOlLgivmiI1TMTUFO1Nh6nLZsjs/didX9I1wcjlG+W6NM6
	 OxfGHfE0dLizXPXaLRvfrzOE7Lk+emjNXEbtlMtaIQwg/0Sk0oHDcKlxbzrXfc3kt0
	 25IwwbyVbrw0yjfOnV/S1rv2c47OupDOWlkT/5431e1HHJk9Zv7t1c+GNxyWwc6DbJ
	 27dNDg4HMOS26DweDCKLet7R1XMZqeS2knrSeHAyI5GQI6eKYM5IFeVjZFBEJht3wY
	 uRJSAsBwscrZ/NaSldVHwPMvG03MokoWeQVGjR7WRcnGUsxW66GDKJR842JQQ55auv
	 UYblVNLBY/hoQ==
Content-Type: multipart/mixed; boundary="===============6218484638467025812=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e87bfe0e001324e0c1ff10c5c65cc7cf5cc0d786982158516e4bb4fa88bcc460@mail.kernel.org>
In-Reply-To: <20260914170326.249953-9-daniel@iogearbox.net>
References: <20260914170326.249953-9-daniel@iogearbox.net>
Subject: Re: [PATCH bpf v2 08/11] selftests/bpf: Add tests for the indirect jump edge limit
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 18:19:24 +0000 (UTC)

--===============6218484638467025812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index 0222a9a5d0761..08f5d4f3d64fb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> @@ -453,6 +453,263 @@ static void check_bpf_no_lookup(void)
>  	close(map_fd);
>  }
>
> +#define GOTOX_CNT_AT_LIMIT	1000
> +#define GOTOX_LOG_SZ		(256 * 1024)
> +
> +static const char gotox_limit_msg[] =
> +	"number of indirect jump edges in the program exceeds";
> +
> +static int gotox_jt_create(__u32 first_gotox, __u32 gotox_cnt)
> +{
> +	/* the run of gotox itself, plus the insn right after it */
> +	const __u32 jt_cnt = gotox_cnt + 1;
> +	struct bpf_insn_array_value val = {};
> +	int map_fd;
> +	__u32 i;
> +
> +	map_fd = map_create(BPF_MAP_TYPE_INSN_ARRAY, jt_cnt);
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return map_fd;
> +
> +	for (i = 0; i < jt_cnt; i++) {
> +		val.orig_off = first_gotox + i;
> +		if (!ASSERT_EQ(bpf_map_update_elem(map_fd, &i, &val, 0), 0,
> +			       "bpf_map_update_elem"))
> +			goto err;
> +	}
> +
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto err;
> +
> +	return map_fd;
> +err:
> +	close(map_fd);
> +	return -1;
> +}
> +
> +static int gotox_prog_load(struct bpf_insn *insns, __u32 insn_cnt,
> +			   int *fd_array, __u32 fd_array_cnt, char *log)
> +{
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
> +	int prog_fd;
> +
> +	log[0] = 0;
> +	opts.fd_array = fd_array;
> +	opts.fd_array_cnt = fd_array_cnt;
> +	opts.log_buf = log;
> +	opts.log_size = GOTOX_LOG_SZ;
> +	opts.log_level = 1;
> +
> +	prog_fd = bpf_prog_load(BPF_PROG_TYPE_XDP, NULL, "GPL", insns, insn_cnt, &opts);
> +	if (prog_fd >= 0) {
> +		close(prog_fd);
> +		return 0;
> +	}
> +	return prog_fd;
> +}
> +
> +/* Fill in 'r1 = 0; gotox_cnt x gotox r1' at 'insns'. */
> +static void gotox_run_fill(struct bpf_insn *insns, __u32 gotox_cnt)
> +{
> +	__u32 i;
> +
> +	insns[0] = BPF_MOV64_IMM(BPF_REG_1, 0);
> +	for (i = 1; i <= gotox_cnt; i++)
> +		insns[i] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);
> +}
> +
> +static void check_gotox_limit_hit(const char *log, int err)
> +{
> +	ASSERT_EQ(err, -E2BIG, "program should have been rejected");
> +	ASSERT_HAS_SUBSTR(log, gotox_limit_msg, "verifier log");
> +}
> +
> +static bool try_load_gotox_prog(__u32 gotox_cnt, char *log, int *err)
> +{
> +	const __u32 insn_cnt = gotox_cnt + 3;
> +	struct bpf_insn *insns;
> +	bool attempted = false;
> +	int map_fd;
> +
> +	insns = calloc(insn_cnt, sizeof(*insns));
> +	if (!ASSERT_OK_PTR(insns, "calloc insns"))
> +		return false;
> +
> +	gotox_run_fill(insns, gotox_cnt);
> +	insns[gotox_cnt + 1] = BPF_MOV64_IMM(BPF_REG_0, 0);
> +	insns[gotox_cnt + 2] = BPF_EXIT_INSN();
> +
> +	map_fd = gotox_jt_create(1, gotox_cnt);
> +	if (map_fd < 0)
> +		goto free_insns;
> +
> +	*err = gotox_prog_load(insns, insn_cnt, &map_fd, 1, log);
> +	close(map_fd);
> +	attempted = true;
> +free_insns:
> +	free(insns);
> +	return attempted;
> +}

This isn't a bug, but could try_load_gotox_prog() be inlined or simplified?
It has a single caller in check_too_many_gotox_edges(), and the bool
return plus int *err out-parameter split makes that test read differently
from check_gotox_edges_at_limit() and check_gotox_edges_across_subprogs(),
which open-code the identical scaffolding (calloc log, calloc insns, fill
insns, create map, load, close map, free) inline.

> +
> +/*
> + * The extra exit target in the jump table makes for gotox_cnt * (gotox_cnt
> + * + 1) edges, hence the program is over the limit by gotox_cnt edges.
> + */
> +static void check_too_many_gotox_edges(void)
> +{
> +	const __u32 gotox_cnt = GOTOX_CNT_AT_LIMIT;
> +	char *log;
> +	int err;
> +
> +	log = calloc(1, GOTOX_LOG_SZ);
> +	if (!ASSERT_OK_PTR(log, "calloc log"))
> +		return;
> +
> +	if (try_load_gotox_prog(gotox_cnt, log, &err))
> +		check_gotox_limit_hit(log, err);
> +
> +	free(log);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34875126886
--===============6218484638467025812==--
