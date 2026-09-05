Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF52264DB
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788648283; cv=none; b=IwiHgr3xDLq1qWf744AC2pevvmJWv+yzmdQmXLM5eGdRE1BxOe4nqCMRF5D7lBMsVl3JpxC7sPp6uvDbMpNT+JTCIxy77vYKeVlh8oTg63K3iwV0KHqlP9b14qBHaR/8wiZ8dECIFFFvkxnFUx3PiN1RqdoXqyPNqb/IX6VH6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788648283; c=relaxed/simple;
	bh=vH1jFTXdDwvwK1Cq3cdtKHrfjlClw3AMsKEWfkA/RXo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=at00L6LNZzRcHfbRwM0NCYGYX9hDYz7fKVbMG6tJDoNNRb3rrLtqU9dPF+QZGj/yjc3Z0Qn5N1o5V3OjGDBJ9x26aAqAUMXT4N2Q9SSyeReUWg4bvAGJRibuy5icAVi0JeENQL2wxITcLyS1GQyCyHAOWgpsLyqzrP+0F3+GPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvaMyZpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvaMyZpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE54B1F00A3A;
	Sat,  5 Sep 2026 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788648281;
	bh=rdhFao6J0z5X163zamdOEz2dZ8HwSbyO75/RfUM9RzM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZvaMyZpPaJvhe27F7tIN4PE8qXjSBqixCK6xxGOSi7pCGf9gbfLdCE6amCUTKVU0Y
	 94A8VJCz2P8vNoTHgaGpYrPnf0IZUpMSWDv1ZmxaaIUHUK7mVtm5pmXNXLgRQIJrHQ
	 eB8GPAVomBgQQd53q8I8xzYUisH4J8qBdDVljDSa70h0zXUtpnukDZrkNYRgj0sobM
	 /l/+GbhYxmKThxGKBY0g7gc/LxAf3xSeZwfBjrsfFFbAxZSNNhHlFYtu0bbaG5pqUo
	 n/otpm8t1GjKYa7L7Jzi5y0zeaeG53ooZIQMs98b7WCYtxS7RUBcBtb5jnEqGXApUd
	 m2WNDA8JmwEHg==
Content-Type: multipart/mixed; boundary="===============7163078914324861484=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <44341c2c66e3c9d2256dfdfbe10c7164152ea6ba3d45ef3aec833ddb7f468f8d@mail.kernel.org>
In-Reply-To: <20260905220117.922028-20-ameryhung@gmail.com>
References: <20260905220117.922028-20-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 19/22] selftests/bpf: Test kfunc packet memory direct writes
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 22:44:40 +0000 (UTC)

--===============7163078914324861484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c
> new file mode 100644
> index 000000000000..9ae63c9eab02
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +struct nf_conn *bpf_skb_ct_lookup(struct __sk_buff *skb_ctx,
> +				  struct bpf_sock_tuple *bpf_tuple,
> +				  u32 tuple__sz, struct bpf_ct_opts *opts,
> +				  u32 opts__sz) __ksym;
> +void bpf_ct_release(struct nf_conn *nfct) __ksym;
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("tc")
> +__description("kfunc packet write requests writable skb")
> +__success
> +/* bpf_unclone_prologue() */
> +__xlated("r6 = *(u8 *)(r1 +{{[0-9]+}})")
> +__xlated("...")
> +__xlated("w6 &= {{1|128}}")

Is this test expected to pass at this commit? Looking at the verifier
code at this commit, the kfunc memory-argument path goes through
check_helper_mem_access() for PTR_TO_PACKET, which calls
check_packet_access() directly:

kernel/bpf/verifier.c:check_helper_mem_access():
    case PTR_TO_PACKET:
    case PTR_TO_PACKET_META:
            return check_packet_access(env, reg, argno, 0, access_size,
                                       zero_size_allowed);

This path never calls may_access_direct_pkt_data(), so
env->seen_direct_write remains false. Without seen_direct_write set,
net/core/filter.c:tc_cls_act_prologue() -> bpf_unclone_prologue()
returns 0:

net/core/filter.c:bpf_unclone_prologue():
    if (!direct_write)
            return 0;

The kfunc_packet_write() program performs no direct packet store, so
it won't trigger the may_access_direct_pkt_data() call that would set
env->seen_direct_write. This means no prologue instructions are emitted
and the __xlated() patterns from here to the end would fail to match.

This appears to be fixed by a later commit in the series that moves the
check into check_helper_mem_access(). Should this test be reordered to
appear after that commit to avoid breaking bisection?

> +__xlated("...")
> +__xlated("if r6 == 0x0 goto")
> +__xlated("r6 = r1")
> +__xlated("r2 ^= r2")
> +__xlated("call")
> +__xlated("if r0 == 0x0 goto")
> +__xlated("w0 = 2")
> +__xlated("...")
> +__xlated("exit")
> +__xlated("r1 = r6")
> +int kfunc_packet_write(struct __sk_buff *skb)
> +{
> +	void *data_end = (void *)(long)skb->data_end;
> +	void *data = (void *)(long)skb->data;
> +	struct bpf_sock_tuple tuple = {};
> +	struct nf_conn *nfct;
> +
> +	if (data + sizeof(struct bpf_ct_opts) > data_end)
> +		return 0;
> +
> +	/* An invalid tuple size makes bpf_skb_ct_lookup() write opts->error. */
> +	nfct = bpf_skb_ct_lookup(skb, &tuple, 1, data, sizeof(struct bpf_ct_opts));
> +	if (nfct)
> +		bpf_ct_release(nfct);
> +	return 0;
> +}

Going back to the alternation pattern above:

> +__xlated("w6 &= {{1|128}}")

This isn't a bug, but does the regex match what the commit message
describes? The pattern text "w6 &= {{1|128}}" compiles to the POSIX ERE
"w6 &= 1|128" since tools/testing/selftests/bpf/test_loader.c only
escapes metacharacters outside {{ }}. Without grouping, this is
(w6 &= 1)|(128) due to '|' having lowest precedence, so the second
alternative matches a bare "128" anywhere in the xlated dump rather than
constraining the cloned-bit mask value. Should this be "w6 &= {{(1|128)}}"
to properly match the endian-specific mask?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33995442755
--===============7163078914324861484==--
