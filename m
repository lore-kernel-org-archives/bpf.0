Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D310175A69;
	Sun, 28 Jun 2026 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782667593; cv=none; b=OE81pHLCtR9RXQ/4Uxc1PtJtAEw614XQAiEtph5MwOR9Sq/+k0jwbQ4xLbc1e7LAO1nGrgFxMtbgGe7M8GJB+thHnyZkGyIRrPVLh3sj9J2OwXaPZMJ/i/7xmCtW1fpnx3N2oI3VtO3a35DojZjJJdfXlcZL8tFpPwt+Bdk+4YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782667593; c=relaxed/simple;
	bh=j/DYa4mXtUpW23C3OexHGz3Ub90PfRa5h9OjniRkxhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JlQguO+jtX7Ur4ql6GpxHWYH9iAdNU4/sPO3oLYB+jeXpQKRANYJ0P/y3G1NP2LMYtqTU6AtEkQOHJVnIU/6LZMXvW1nlwsgVM6ZAshV2e5V8203aEpCx3kFFoQdKeiH4qj3+0qePMyAqcUYB85guf+5UxfNk4w7T+cywRyiBr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcUnvRAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcUnvRAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264821F000E9;
	Sun, 28 Jun 2026 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782667591;
	bh=5X+nFlRn3ahrs8bSxEJpS+nHnqWlIe2VEb5G9WNWcrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HcUnvRAlS64bbx2Vkp0YYkzuZcoEjFJiIiF1iZQsaPMNJZC0dZB1L9C/dRLKXVvm4
	 K9JAgm3OVavnloRE56RvZeX54eyL+lnzzKBt4gE6AAm6edARSuYBPAJWoUxvV5BscG
	 3kdG0y8SvAKCAr8Q+fBblCBJdnU/7h4ZXMSbmaw1wPKRXwpUDCszeUGi3TLOYDfCsh
	 cycoJHcQfYgpMjBK1hkYvb4hqm/Wym0GTp1sBcr3BzDFzh5zfl9rx5qNk1G1S8ul4a
	 VI0iNyIGiaEShlmiuky6wpG8+bAD56q95rV9rmLr1UAkAXoi75k0WjjmE3IvZjzPWB
	 0WNutq4TFBf2A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Varun R Mallya <varunrmallya@gmail.com>, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, pulehui@huawei.com
Cc: alex@ghiti.fr, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 puranjay@kernel.org, shuah@kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, varunrmallya@gmail.com
Subject: Re: [PATCH bpf-next v2 1/3] riscv: stacktrace: Implement
 arch_bpf_stack_walk() for BPF
In-Reply-To: <20260628081710.113333-2-varunrmallya@gmail.com>
References: <20260628081710.113333-1-varunrmallya@gmail.com>
 <20260628081710.113333-2-varunrmallya@gmail.com>
Date: Sun, 28 Jun 2026 10:26:28 -0700
Message-ID: <87ik72y3sr.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Varun!

Thanks for spending time on getting RV eBPF more feature complete! Sorry
for the slow replies.

Varun R Mallya <varunrmallya@gmail.com> writes:

> This will be used by bpf_throw() to unwind till the program marked as
> exception boundary and run the callback with the stack of the main
> program.
> This is required for supporting BPF exceptions on RISC-V.
> This depends on the frame pointer unwinder, so it is only built under
> CONFIG_FRAME_POINTER, else falls back to the weak no-op.
>
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> Reviewed-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/kernel/stacktrace.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index c7555447149b..64929381bb30 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -5,6 +5,7 @@
>   */
>=20=20
>  #include <linux/export.h>
> +#include <linux/filter.h>
>  #include <linux/kallsyms.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
> @@ -102,6 +103,36 @@ void notrace walk_stackframe(struct task_struct *tas=
k, struct pt_regs *regs,
>  	}
>  }
>=20=20
> +void notrace arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip=
, u64 sp, u64 bp),
> +				 void *cookie)
> +{
> +	unsigned long fp, sp, pc;
> +	int graph_idx =3D 0;
> +
> +	fp =3D (unsigned long)__builtin_frame_address(0);
> +	sp =3D current_stack_pointer;
> +	pc =3D (unsigned long)arch_bpf_stack_walk;
> +
> +	for (;;) {
> +		struct stackframe *frame;
> +
> +		if (unlikely(!__kernel_text_address(pc)))
> +			break;
> +		/* pc belongs to the function whose frame pointer is fp */
> +		if (!consume_fn(cookie, pc, sp, fp))
> +			break;
> +		if (unlikely(!fp_is_valid(fp, sp)))
> +			break;
> +
> +		frame =3D (struct stackframe *)fp - 1;
> +		sp =3D fp;
> +		fp =3D READ_ONCE_TASK_STACK(current, frame->fp);
> +		pc =3D READ_ONCE_TASK_STACK(current, frame->ra);
> +		pc =3D ftrace_graph_ret_addr(current, &graph_idx, pc,
> +					   &frame->ra);
> +	}
> +}

We don't need more stack unwinders. Can you see if you can extend
walk_stackframe() with "cookie" to match BPF's needs? Have a look at
what arm64 does.

Sashiko had a good point about ftrace_graph_ret_addr() -- now what about
kretprobe? Do we need to take that in consideration as well?


Thanks,
Bj=C3=B6rn
