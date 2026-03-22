Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8EE366062;
	Sun, 22 Mar 2026 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774145666; cv=none; b=T/eyDt7m2pocapY4gK3UJwBeqw7O447uhe5vjOIxwSIgbd8+6ILSLm0UHlEoD0dLArAIKJo/WP8GYZN/AfCNZrjlNMLOOXUp3x0pyw6Hxt19CyNWAXtxK90SBh7EBDEidOY9DYuheUky6VIGXM7jCCCvYKZqTJihWwtzlJLsCI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774145666; c=relaxed/simple;
	bh=P5/QZdALceOOATbjA4yiwqZ9aFKguus/sia2zG/8cqA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HZg/OfXV9gsbN41gf6U3jvu3MxaPjREs9JjzseOvrgCeP5oMXge3k84DcUcYDJMTiNpFzus/X3qPPBcvvSOewrPWTEk2uq7/f++LlNMPzLE3EL2RfZldwy41HFnykpiNliGGyt7Kk0n82dMwoknQ1jV73kySk7iyLUmLPKjujvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPSzfeel; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPSzfeel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D354BC19421;
	Sun, 22 Mar 2026 02:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774145666;
	bh=P5/QZdALceOOATbjA4yiwqZ9aFKguus/sia2zG/8cqA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GPSzfeelF6hYSQ5+WCm7GMpOo+k7RWdYJOESMvhg6LWooNur6Lgo0QRrV/ez9pUNb
	 xyDDK8OM7wWtPyfKUhZJbGliyk8e10C9jE2z81zceZG0go2J9/asucjKVpEEvL2ooX
	 FqX6wlAzNbUuzcrPEl/+nEwWzfnARd/5dKJLZGiEFKQooaVNhErbUw+z9WkY7kU/Q0
	 kor4hf14Y6qhKFOVWZnJ9RGbGOK3AMQjVdljLYQw8Bylv/7s7IpkNukpB3yesxPJJ2
	 evv4zUAT7Bh+3q5CyGcVj4SXAxwMCDSx2YCHKCYrBI8Il+xTYfpdc69lnKm8iPdJpb
	 GxglQ/e+JaKwQ==
Content-Type: multipart/mixed; boundary="===============6815891717645210221=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <08db54a539782f034e10f598cd46bd2ff7f7404922d78689c4628110164e77de@mail.kernel.org>
In-Reply-To: <20260322014402.8815-2-piliu@redhat.com>
References: <20260322014402.8815-2-piliu@redhat.com>
Subject: Re: [PATCHv7 01/13] bpf: Introduce kfuncs to parser buffer content
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,bpf@vger.kernel.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,kexec@lists.infradead.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 02:14:25 +0000 (UTC)

--===============6815891717645210221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_buffer_parser.c b/kernel/bpf/bpf_buffer_parser.c
> new file mode 100644
> index 000000000000..5d5c06833079
> --- /dev/null
> +++ b/kernel/bpf/bpf_buffer_parser.c

[ ... ]

> +static void release_bpf_parser_context(struct kref *kref)
> +{
> +	struct bpf_parser_context *ctx = container_of(kref, struct bpf_parser_context, ref);
> +
> +	if (ctx->buf) {
> +		vfree(ctx->buf->buf);
> +		kfree(ctx->buf);
> +	}

If release_bpf_parser_context() runs while bpf_buffer_parser() has
stored the sentinel (void *)1 in ctx->buf via:

    old_val = cmpxchg(&context->buf, NULL, (void *)1);

then ctx->buf is non-NULL but not a valid struct bpf_parser_buf
pointer, and vfree(ctx->buf->buf) will dereference address 1.

The BPF verifier prevents this today by holding the acquired reference
across the kfunc call, but release_bpf_parser_context() has no
awareness of the sentinel value.  Would it be worth adding a check
here to handle the sentinel, or using a separate flag/mutex instead
of overloading ctx->buf?

[ ... ]

> +__bpf_kfunc int bpf_buffer_parser(char *buf, int buf_sz,
> +		struct bpf_parser_context *context)
> +{

[ ... ]

> +	ret = copy_from_kernel_nofault(b, buf, buf_sz);
> +	if (!!ret) {

The !!ret is equivalent to just testing ret here.  Was the double
negation intentional?

> +		context->buf = NULL;
> +		vfree(b);
> +		return ret;
> +	}

[ ... ]

> +static const struct btf_kfunc_id_set buffer_parser_kfunc_set = {
> +        .owner = THIS_MODULE,
> +        .set   = &buffer_parser_ids,
> +};

These two lines use spaces for indentation instead of tabs.

> +
> +

There is a double blank line here.

> +BTF_ID_LIST(buffer_parser_dtor_ids)

[ ... ]

> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &buffer_parser_kfunc_set);
> +	return  ret ?: register_btf_id_dtor_kfuncs(buffer_parser_dtors,

There is a double space before ret.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23393379437
--===============6815891717645210221==--
