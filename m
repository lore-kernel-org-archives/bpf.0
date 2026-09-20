Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2B45A2A2;
	Sun, 20 Sep 2026 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939008; cv=none; b=TTVSUg2aqD1KtYKW2NBgqSF66eBZk1bZHYqOfUbYFLd9TSIs/D/oGeESk56uYpBZ18N04Wv8QaW7JkK9/az5BEJg0yzDbQiI3nTip/klFqKp0Pc85rZmucXzlc4tCJ4tvfJKGs9INZauuq2H3Q8K3md+4yO/tptNnVOSMJKsOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939008; c=relaxed/simple;
	bh=4WdrKt8AKz6G6QYbkTvwcLiL7itkcl3/e4TpzrVv8U8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DN3aX7ScZeY/biYaY4SfTYUSl+mn5YRCTBfn/3f9T0CW6bEtGduhICLyJjVZpwhW3BdAU+mpVNCwM75vgmg1Hjyzi49jZ/2/LZ0rDZaHVA+lkLcQJCnKorEK+Gq3ATJQY3/QATSaFJDC+8Duy+I9nV0xryfMPvYt+XclWVmIhsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMRyOv5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMRyOv5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F5F1F00893;
	Sun, 20 Sep 2026 21:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789939006;
	bh=uH60GIKNKr56csHW3uhTAYrw3Kq784GrIw38oikXzzo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZMRyOv5WCJyTXMSstujmuS4FgW7KsRJOVY9ENQnz1eQvWc82aLCcKHD4gL2EE6e1O
	 rXCrz/0K7m+fdrwVZXdmma28bmWUkxZYitfoXoPUEi9X1jZDfZceaE8YHHND9zPcOp
	 sQgAro6MY2ZUjV1H/rvydGHhTZL4elDHjje7cwWTnFywG2qZ/ev2JOzRwblAU0XsNm
	 hencheMH6yECWmFO3/psSJtRyhd5vlW2nk02Wyod19YVMuMIpNxqxOdi+N9VUAn6//
	 GjzeD7Wbnjdt3ALLpvP3ywgCdOsILVHKVnA+53TJewhripWDEFB4N64XP7OZE7DRpo
	 7+E+Bj6FZYvZw==
Content-Type: multipart/mixed; boundary="===============5629786104314495298=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8c657a1bbe5876b5978f66e8daf807c210af2c89e6a938fc6eaa04cbc6b21e90@mail.kernel.org>
In-Reply-To: <20260920195633.3033620-8-kuniyu@google.com>
References: <20260920195633.3033620-8-kuniyu@google.com>
Subject: Re: [PATCH bpf-next 7/7] selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,cleger@meta.com,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 21:16:44 +0000 (UTC)

--===============5629786104314495298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> new file mode 100644
> index 0000000000000..c5ead4af24f85
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_autolowat.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2026 Google LLC */
> +#include <sys/epoll.h>

Does this file need to include <sched.h> for unshare() and CLONE_NEWNET?
The calls are at tcp_autolowat_setup_cb() but there's no direct include.
Every other bpf prog_test that unshares a netns includes <sched.h>
explicitly (bind_perm.c, setget_sockopt.c, sock_fields.c, tcp_hdr_options.c,
tcp_custom_syncookie.c). It compiles today only because test_progs.h pulls
in <pthread.h>, which brings <sched.h> transitively under _GNU_SOURCE.

> +
> +#include "test_progs.h"
> +#include "cgroup_helpers.h"
> +#include "network_helpers.h"
> +
> +#include "tcp_autolowat.skel.h"

[ ... ]

> +struct rpc_test_case {
> +	char data[4096];
> +	struct rpc_descriptor desc[32];
> +	struct rpc_event event[32];
> +} rpc_test_cases[] = {

Should rpc_test_cases[] be static? It's currently defined with external
linkage, and test_progs links every prog_tests/*.o together. Every
comparable table in neighboring tests is static (test_cases[] in
ctx_rewrite.c, sk_bypass_prot_mem.c, crafted_cases[] in reg_bounds.c,
bond_test_cases[] in xdp_bonding.c). All other file-scope objects in this
file are already static.

> +	{
> +		.desc = {
> +			{ .header_len = 100, .payload_len = 150 },
> +		},
> +		.event = {
> +			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
> +			/* Single full RPC message in skb. */
> +			{ .type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE + 100 + 150},
> +			{ .type = RPC_EVENT_EPOLL,	.nfds = 1},
> +			{ .type = RPC_EVENT_RCVLOWAT,	.rcvlowat = RPC_DESC_SIZE + 100 + 150},
> +		},
> +	},
> +	{
> +		.desc = {
> +			{.header_len = 100, .payload_len = 150},
> +			{.header_len = 100, .payload_len = 150},
> +			{.header_len = 100, .payload_len = 150},
> +		},
> +		.event = {
> +			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
> +			/* Two full RPC messages in skb. */
> +			{.type = RPC_EVENT_SEND,	.len = (RPC_DESC_SIZE + 100 + 150) * 2},
> +			{.type = RPC_EVENT_EPOLL,	.nfds = 1},
> +			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 2},
> +			/* Single full RPC message in skb. */
> +			{ .type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE + 100 + 150},
> +			{ .type = RPC_EVENT_EPOLL,	.nfds = 1},
> +			{ .type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 3},
> +		},
> +	},
> +	{
> +		.desc = {
> +			{.header_len = 100, .payload_len = 150},
> +			{.header_len = 100, .payload_len = 150},
> +			{.header_len = 100, .payload_len = 150},
> +		},
> +		.event = {
> +			{ .type = RPC_EVENT_AUTOLOWAT,	.val = 1},
> +			/* Two full RPC messages in skb. */
> +			{.type = RPC_EVENT_SEND,	.len = (RPC_DESC_SIZE + 100 + 150) * 2},
> +			{.type = RPC_EVENT_EPOLL,	.nfds = 1},
> +			{.type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 2},
> +			/* Single full RPC message in skb. */
> +			{ .type = RPC_EVENT_SEND,	.len = RPC_DESC_SIZE},

Does this comment match the event? The comment says "Single full RPC
message in skb" but the send is only RPC_DESC_SIZE (8 bytes) without the
250-byte header+payload. This is what distinguishes this case from
rpc_test_cases[1] where the identical comment sits above
.len = RPC_DESC_SIZE + 100 + 150. The expected rcvlowat that follows
(unchanged at (RPC_DESC_SIZE + 100 + 150) * 2) confirms the intent: only
the next descriptor arrives, so SO_RCVLOWAT stays at the still-unread
complete frames. Since the comment is the only thing explaining this case's
purpose, does it need to say "Only the next descriptor in skb" instead?

> +			{ .type = RPC_EVENT_EPOLL,	.nfds = 1},
> +			{ .type = RPC_EVENT_RCVLOWAT,	.rcvlowat = (RPC_DESC_SIZE + 100 + 150) * 2},
> +		},
> +	},

[ ... ]

> +static int tcp_autolowat_setup_cb(struct tcp_autolowat_test_cb *cb, int family)
> +{
> +	struct epoll_event ev = {};
> +	int err;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cb->fd); i++)
> +		cb->fd[i] = -1;
> +
> +	cb->saved_netns = open("/proc/self/ns/net", O_RDONLY);
> +	if (!ASSERT_OK_FD(cb->saved_netns, "save netns"))
> +		goto err;
> +
> +	err = unshare(CLONE_NEWNET);
> +	if (!ASSERT_OK(err, "unshare"))
> +		goto err;
> +
> +	err = system("ip link set dev lo up");
> +	if (!ASSERT_OK(err, "set up lo"))
> +		goto err;

A subsystem pattern flags this as potentially concerning: network-namespace
setup is open-coded here with open("/proc/self/ns/net") + unshare() +
system("ip link ..."), and tcp_autolowat_teardown_cb() does the matching
setns()+close(). The BPF selftest tree has a SYS() wrapper in
test_progs.h that is exactly ASSERT_OK(system(cmd), cmd) plus a goto
label, so the system() call could use that. Nine other bpf prog_tests
already do the unshare(CLONE_NEWNET)+saved-fd idiom the same way this does
(bind_perm.c, bpf_iter_setsockopt.c, flow_dissector_reattach.c,
setget_sockopt.c, sk_lookup.c, sock_fields.c, sk_assign.c,
tcp_custom_syncookie.c, tcp_hdr_options.c), and network_helpers'
open_netns()/close_netns() operate on a named netns (ip netns add), not an
anonymous unshare. Is the current pattern acceptable here, or would using
SYS() for the ip command be an improvement?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
> new file mode 100644
> index 0000000000000..bb96e19e7589d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2026 Google LLC */
> +#include "vmlinux.h"
> +
> +#include <string.h>
> +#include <limits.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +#include "bpf_kfuncs.h"
> +#include "bpf_tracing_net.h"

[ ... ]

> +static void tcp_set_autolowat(struct tcp_autolowat_cb *cb,
> +			      struct sock *sk)
> +{
> +	struct tcp_sock *tp = (struct tcp_sock *)sk;
> +	u32 val; /* To handle wraparound. */
> +
> +	LOG("Setting rcvlowat: tp->copied_seq: %u, rpc_desc_seq: %u, rpc_end_seq: %u, rpc_desc_buff_len: %u",
> +	    TP_SEQ(copied_seq), CB_SEQ(rpc_desc_seq),
> +	    CB_SEQ(rpc_end_seq), cb->rpc_desc_buff_len);
> +
> +	if (before(tp->copied_seq, cb->rpc_desc_seq))
> +		val = cb->rpc_desc_seq - tp->copied_seq;
> +	else if (cb->rpc_desc_buff_len != RPC_DESC_SIZE)
> +		val = RPC_DESC_SIZE;
> +	else
> +		val = cb->rpc_end_seq - tp->copied_seq;
> +
> +	if (val != tp->inet_conn.icsk_inet.sk.sk_rcvlowat) {
> +		bpf_tcp_ops_set_rcvlowat(sk, val);

Does this compile? The call to bpf_tcp_ops_set_rcvlowat() has no
declaration anywhere in the translation unit. Checking:

- vmlinux.h is generated by bpftool btf dump, which never emits function
  prototypes (libbpf's BTF dumper marks BTF_KIND_FUNC as ORDERED and emits
  nothing for it).

- bpf_helpers.h/bpf_helper_defs.h only declare BPF helpers, not kfuncs.

- bpf_kfuncs.h declares each kfunc explicitly with __ksym, but has no
  entry for bpf_tcp_ops_set_rcvlowat.

- Grep over tools/ finds the identifier only at the two call sites in this
  file (here and tcp_disable_autolowat()).

All of progs/*.c are built with -Wall -Werror -std=gnu11 (Makefile:463-472),
and a call to an undeclared function in C99+/gnu11 is an error. Even if the
diagnostic were suppressed, an implicitly declared function carries no
__ksym attribute, so libbpf would not emit a kfunc relocation and the
program could not be loaded. The call itself looks correct: the kernel
kfunc is int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
const struct bpf_prog_aux *aux) registered with KF_IMPLICIT_ARGS, and
resolve_btfids drops the implicit argument from the BPF-visible signature.
Doesn't this just need the declaration, like:

  extern int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat) __ksym;

in this file or in bpf_kfuncs.h?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35535082194
--===============5629786104314495298==--
