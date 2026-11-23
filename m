Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449884;
	b=t8FshaiL82Igrzm5D3/7fhYqEdfnQwVIVunNAW2759LhzBtxj+8GXcNLX1mMha8aTH54
	 AlmgVuyVUBnOZVBNH8UUrdcMi/QvhBCKqDYbHoa8wxt++eS7qZNUcu6PF+vycq8T40S7T
	 3p/kU6Dyc+1/78KL/gyDt/R51P4DkrJBFtGc4RYFeKcSKpqh0CqJmgJhaCUgCseenST+P
	 C3/1vu/vvCQ/8Z5pjqEL08Mya/RX2TRd5VtEkciAaXI42cqyRnFAVSXZlAutYaWd47EJ9
	 vWaxoiGsgNu2aUjFiZm6cLpClm5QpDXrzWtHoUTb7f5Wsx8ewUfu0032rgeFjyZZPFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449884;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=JXF19oCv45/26B2URve3iHY/PwWZHPECRP1mP/rGn9s=;
	b=qmOq/20F8FI4Y5GR+wpitRzkSbxEni3Ts7BS2wb7DyUYT06RCv7ZtvDGpzzRJHPeb/HN
	 JhAguNqj+BqmnwLBcFgBNg0c0vPHsCmTx6yskhv6lJ6E+/HBeyLGk/w+irIjujV2byscV
	 v4hJcZ7il+TIUmEiHXSKr+heVs3/q03QLm85yUEKgMZSxOeJFfw13nkNe7QHoUzFTWr/B
	 BgU5V5zA2cXTULXcB9mhkTupVJ2v6hyMAeoRHM7WdUYwb4fKcMzC8VnNfNLEPesXBSqOB
	 mKrxchxDMDh7K/F4kpjh+M6KlxG5UtJAZsXiIM7ijgSkidvuNnFoD7gnEmgAKTewaqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoRNsUdI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2F5606A31F;
	Mon, 23 Nov 2026 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aoRNsUdI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA2C1F000D0;
	Mon, 23 Nov 2026 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449884;
	bh=JXF19oCv45/26B2URve3iHY/PwWZHPECRP1mP/rGn9s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aoRNsUdIaNfcVa236VVofCAmbV8oEgvab3Jsb7vFzHtwQ3PPnDEO64CS60tu2+8Bs
	 89LpNdymL0WBHszAHakvjT/Awt3onzNFZhMxjSqTunnDIBZ0xQcdHy3a/njIVWNru8
	 LtuPQjPBcOZ231b504Han7ThKxpnR5/zbC0UHJmjWr693bwNo2hRPwC8oQiETKY2Nv
	 2ldihjBzwjX8KE5f9AG5r8NIGmG+SGVPnwE+C6MXJf/GAvBshDbgBqHz6SiQ+LnJ3o
	 XBNtu5d6tZh2bK9A82RYPvSgKO+6SpxQnsV27YeF45K3VINnntis53I2LoJEkoGl5T
	 Y+CjNYONrRqww==
Content-Type: multipart/mixed; boundary="===============7834733793104834582=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d3920bd7ae0cc6a941895e00534e8f8818402a673351894d0bf98639272f7d7e@mail.kernel.org>
In-Reply-To: <20261123152743.19629-8-leon.hwang@linux.dev>
References: <20261123152743.19629-8-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v3 7/9] selftests/bpf: Test tracing_multi link_create logs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,kpsingh@kernel.org,matt@bobrowski.net,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 23 Nov 2026 16:04:41 +0000 (UTC)

--===============7834733793104834582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test tracing_multi link_create logs

TL;DR: Test issue: the migrate_disable denylist subtest's skip may not trigger
on !CONFIG_SMP kernels, since the function still exists in BTF, so it could
fail instead of skipping.

> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_link.c b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_link.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_link.c
[ ... ]
> +static void test_multi_log_denylist(void)
> +{
> +	const char *msg = "Cannot attach to denylist btf id %u.\n";
> +	const char *target = "migrate_disable";
> +	struct btf *btf;
> +
> +	btf = btf__load_vmlinux_btf();
> +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> +		return;
> +
> +	/* migrate_disable is only in the denylist on SMP kernels. */
> +	if (btf__find_by_name_kind(btf, target, BTF_KIND_FUNC) == -ENOENT)
> +		test__skip();
> +	else
> +		test_multi_log_target(btf, "fentry", target, -EINVAL, msg);

Is this skip reachable on a !CONFIG_SMP kernel?

kernel/sched/core.c always builds an out-of-line, exported
migrate_disable() with no CONFIG_SMP guard:

    void migrate_disable(void)
    {
            __migrate_disable();
    }
    EXPORT_SYMBOL_GPL(migrate_disable);

while the denylist in kernel/bpf/verifier.c adds it only under
CONFIG_SMP:

    BTF_SET_START(btf_id_deny)
    BTF_ID_UNUSED
    #ifdef CONFIG_SMP
    BTF_ID(func, ___migrate_enable)
    BTF_ID(func, migrate_disable)
    BTF_ID(func, migrate_enable)
    #endif

So btf__find_by_name_kind() should find migrate_disable even when
CONFIG_SMP=n, and test__skip() would never run.

On such an x86_64 kernel, bpf_check_attach_btf_id_multi() would not deny
the id, the link would be created, and the subtest would fail at
ASSERT_LT(fd, 0, "bpf_link_create") instead of skipping.

Should the skip check the kernel's SMP configuration directly, for
example through a __kconfig extern, or should the comment and skip be
dropped?

> +
> +	btf__free(btf);
> +}
[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45209424655
--===============7834733793104834582==--
