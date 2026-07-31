Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2632FA1B
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535293; cv=none; b=nmePeqmTcI2pkfzFk3lh2BOywKwgVRP6Qgp0Eou5DjKNu269A/cVcuVBuj9R0dOo2tYaMPucDx/QswhFN8nHz0SqiOWDgnYT9ZDhfSweay9FOVPiIKxKfPp3l2KZnbVnG4/+IUV6XwPlll2vDj1pJqOW7l2TyIz5jUn7mDvIMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535293; c=relaxed/simple;
	bh=fsEN3aHTvcdNaNYshTiJkJoF8283TgjYZ3ydNbtaphM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=dEluXO6PeeRd0tSW3bjfmpSCgsImA/ef/9sWV5jRtHHriSpT6JGaLttA4oHRWosQJwOeh5ee0bF6qRvBWiKYR4kPUs7D92YFvFMyg2HKCLBJdybHjfBUtVTgApaUku9Sw0VpV65ASbgcNZkhwlxGoQKEhrN+ClU39WktwaXZaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=i4e6PEIH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="i4e6PEIH"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so1847538b3a.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785535290; x=1786140090; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LInvsh+o7eZdRJnFCjJWIgKTGJuBuiNZTLf/LFOi0bk=;
        b=i4e6PEIHX2IbhWvvBNojunUgeCBy+AL6ofFLt0bJeZa2XwuvgJa+jMR66pZf5mFJT1
         HRX3hYJbM5XN2Uw3qTw9vB3SWofLiNx9w8mpE/K8TjNIkaIL56FZWjX9Th+UTHkX5/XF
         d6+NOlZTIwaMeF7XSm21oTLX9bEb5xGdGrFnibPatmI589/HFUwoG4EFS8Jlt/xITVr/
         TkutAuLICSq8IrKa2ygqSNg0JNiREKonaFdY8VgulNSuLbRClqfIZu5a3/5EFyv5Wb7M
         jim5xcfQIS7X5XK0YOiR12uGldbSv0+YwDfPNGYyQVYvzGM4EDStLTA1yp6lfJ9+M49J
         4R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785535290; x=1786140090;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LInvsh+o7eZdRJnFCjJWIgKTGJuBuiNZTLf/LFOi0bk=;
        b=lE+RGsz01oMIQFFUdhsQ3/973b5lINPhueHyOzdFQgQxrFOiR2IHhsQzsMYphZ0upn
         L+xzGSrxi66Awj4T5p3wpVEaLbG26tRBhB6PyNOEmpcilRS9vTVgHqNu0VlbzWuiChYU
         2eoGyEXZS9rM5zQk4plEXpi71sAD+24vsaXvuVaPrP4wF69hHtTj+EgTtbDNYD+egaCJ
         4pMWQBZ7seJAgDRDTnGwv9tw3rO9X3/5H4rv7V4OfaaOsGQXMUaEu4RA4jN2dhHv+Hxw
         AJOkrgJximxb5mNi+O2QoWyhzFJ6NaUJwYmGIZgE9qXA+JSZctJSHXqE0RuiYJmn3OPA
         cJyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqN2iXg9boeQLxX0eNwi6o5DeYKubfR0pL4fSGm+xvr+Uzjq+9oULv58x2u1EFoh5xEVa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxddV7orQR1IDG08ll3qe2L0SEwDHbVg7kEc++z3jiAGFr7eL0
	awtfsemXReP8SPQcu1wtiPzaSm2GTND1g3TvTnX5MUQ7o/camkc9NvoJw78YcubbYgc=
X-Gm-Gg: AR+sD13yRjWllaMv+aKyZQoLagLS4z6Iu4KWyhpdWdCh3nyToLcEOZTnXvv1mXygM//
	oBvJTqpL8Fefg/KPbCAJPAy6m79G6SUFfdbT4337MW1P7B0NZ5Sxxzf9mn9OoDq94gnhNL+wvjl
	BQO/ql84IbvBO+FL65qBzTW7ppFqXDR00KFY8/5pbHK+7wkreQeYzTJ/loHNt3GbDZRSXBdHF7E
	JSHyRFrEgnCq4+gbfhMicz3g6Vk1/zl7fTUPF9luDMDjt/eftqQ3vxf2bkMTd3BWebPIPegHPcM
	65brraUHZMpg0YW1iSGpJnJighgAlKaZ4Yl1Dk2TtsX5Bnvbsj9ThGqcU8alhRL/OEgDYAvLmSi
	fLZeUKJPA4q7b7HrelDGxffIlQ+voCwqgkY/AZDmYJZB90ntUlfsloJ/I+AnZ0DjCYlKLTYEuTn
	PNfWsXiv/GRlH55/2gOQ+VEeOKVm2UrTyU2/9Ztpk+CGJ6uxvOlmfVaZ/6M6lEIsEm+cBHKpXui
	2eo+zsOBN28EXMgze7XfqvoeAC7
X-Received: by 2002:a05:6a00:2e89:b0:84e:89a:b8f7 with SMTP id d2e1a72fcca58-84ee479034bmr1080128b3a.11.1785535289828;
        Fri, 31 Jul 2026 15:01:29 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc2a8223sm951614b3a.28.2026.07.31.15.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 15:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 18:01:28 -0400
Message-Id: <DKD3FNK5CT7H.3CCFT5539KE2F@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 15/15] selftests/bpf: Add test for
 bpf_tcp_ops header option hooks
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-16-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-16-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> Add a test exercising the bpf_tcp_ops parse_hdr, hdr_opt_len and
> write_hdr_opt members together with the header option helpers.
>
> The struct_ops program (progs/bpf_tcp_ops_hdr.c) reserves space in
> hdr_opt_len via bpf_reserve_hdr_opt(), writes an experimental option in
> write_hdr_opt via bpf_store_hdr_opt(), and recovers it in parse_hdr via
> bpf_load_hdr_opt() on the incoming skb. Each hook bumps a counter and the
> parse hook records the option payload, so the three callbacks and all
> three overloaded helpers are covered.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Since the struct_ops methods are wrapping the existing sockops code I
don't think we need more extensive tests (e.g., trying to exhaust=20
all available space with reserve).

>  .../bpf/prog_tests/bpf_tcp_ops_hdr.c          | 77 +++++++++++++++++
>  .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     | 83 +++++++++++++++++++
>  2 files changed, 160 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hd=
r.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c b/t=
ools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
> new file mode 100644
> index 000000000000..244605e69e40
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <test_progs.h>
> +#include <network_helpers.h>
> +#include "cgroup_helpers.h"
> +#include "bpf_tcp_ops_hdr.skel.h"
> +
> +#define CGROUP_PATH	"/bpf_tcp_ops_hdr"
> +#define TEST_NETNS	"bpf_tcp_ops_hdr"
> +
> +#define TEST_OPT_D0	0xAB
> +#define TEST_OPT_D1	0xCD
> +
> +static void run_hdr_opt(void)
> +{
> +	struct bpf_tcp_ops_hdr *skel =3D NULL;
> +	struct bpf_link *link =3D NULL;
> +	struct netns_obj *ns =3D NULL;
> +	int cgroup_fd, lfd =3D -1, fd =3D -1;
> +
> +	cgroup_fd =3D test__join_cgroup(CGROUP_PATH);
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		return;
> +
> +	ns =3D netns_new(TEST_NETNS, true);
> +	if (!ASSERT_OK_PTR(ns, "netns_new"))
> +		goto done;
> +
> +	skel =3D bpf_tcp_ops_hdr__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		goto done;
> +
> +	link =3D bpf_map__attach_cgroup_opts(skel->maps.test_hdr_ops, cgroup_fd=
, NULL);
> +	if (!ASSERT_OK_PTR(link, "attach_cgroup"))
> +		goto done;
> +
> +	/*
> +	 * One direction of data is enough to exercise all hooks: both peers
> +	 * share the cgroup struct_ops, so the sender runs hdr_opt_len/write
> +	 * and the receiver runs parse.
> +	 */
> +	lfd =3D start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
> +	if (!ASSERT_GE(lfd, 0, "start_server"))
> +		goto done;
> +
> +	fd =3D connect_to_fd(lfd, 0);
> +	if (!ASSERT_OK_FD(fd, "connect_to_fd"))
> +		goto done;
> +
> +	if (!ASSERT_OK(send_recv_data(lfd, fd, 64), "send_recv_data"))
> +		goto done;
> +
> +	/* Reserve + write hooks ran while sending. */
> +	ASSERT_GT(skel->bss->hdr_opt_len_cnt, 0, "hdr_opt_len_cnt");
> +	ASSERT_GT(skel->bss->write_cnt, 0, "write_cnt");
> +	/* Parse hook ran and recovered our option on the receive side. */
> +	ASSERT_GT(skel->bss->parse_cnt, 0, "parse_cnt");
> +	ASSERT_GT(skel->bss->found_cnt, 0, "found_cnt");
> +	ASSERT_EQ(skel->bss->found_d0, TEST_OPT_D0, "found_d0");
> +	ASSERT_EQ(skel->bss->found_d1, TEST_OPT_D1, "found_d1");
> +
> +done:
> +	if (fd >=3D 0)
> +		close(fd);
> +	if (lfd >=3D 0)
> +		close(lfd);
> +	bpf_link__destroy(link);
> +	bpf_tcp_ops_hdr__destroy(skel);
> +	netns_free(ns);
> +	close(cgroup_fd);
> +}
> +
> +void test_bpf_tcp_ops_hdr(void)
> +{
> +	run_hdr_opt();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c b/tools/=
testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
> new file mode 100644
> index 000000000000..46618a604d96
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +/* Experimental option kind and payload written/parsed by this test. */
> +#define TEST_OPT_KIND	0xFD
> +#define TEST_OPT_LEN	4
> +#define TEST_OPT_D0	0xAB
> +#define TEST_OPT_D1	0xCD
> +
> +int hdr_opt_len_cnt;
> +int write_cnt;
> +int parse_cnt;
> +int found_cnt;
> +__u8 found_d0;
> +__u8 found_d1;
> +
> +SEC("struct_ops")
> +void BPF_PROG(test_hdr_opt_len, struct sock *sk, struct sk_buff *skb,
> +	      struct request_sock *req, struct sk_buff *syn_skb,
> +	      enum tcp_synack_type synack_type, unsigned int *remaining)
> +{
> +	hdr_opt_len_cnt++;
> +
> +	/* Reserve TEST_OPT_LEN bytes; the helper decrements *remaining. Stacks
> +	 * with other progs in the cgroup hierarchy.
> +	 */
> +	bpf_reserve_hdr_opt(ctx, TEST_OPT_LEN, 0);
> +}
> +
> +SEC("struct_ops")
> +void BPF_PROG(test_write_hdr_opt, struct sock *sk, struct sk_buff *skb,
> +	      struct request_sock *req, struct sk_buff *syn_skb,
> +	      enum tcp_synack_type synack_type, __u32 opt_off)
> +{
> +	__u8 opt[TEST_OPT_LEN] =3D {
> +		TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
> +	};
> +
> +	/* bpf_store_hdr_opt() takes the program ctx (the kernel reads the
> +	 * outgoing skb from it); it appends after any options already written
> +	 * in the reserved window, rejects duplicates, and confines the write t=
o
> +	 * the header option scratch. Stacks across progs in the cgroup hierarc=
hy.
> +	 */
> +	if (bpf_store_hdr_opt(ctx, opt, sizeof(opt), 0))
> +		return;
> +
> +	write_cnt++;
> +}
> +
> +SEC("struct_ops")
> +void BPF_PROG(test_parse_hdr, struct sock *sk, struct sk_buff *skb)
> +{
> +	__u8 opt[TEST_OPT_LEN] =3D {
> +		TEST_OPT_KIND, TEST_OPT_LEN, TEST_OPT_D0, TEST_OPT_D1,
> +	};
> +
> +	parse_cnt++;
> +
> +	/* Look up the experimental option written by test_write_hdr_opt() in
> +	 * the incoming skb. For an experimental kind the search matches on the
> +	 * 2-byte magic in opt[2..3]; on a match the found option is copied bac=
k
> +	 * into opt[].
> +	 */
> +	if (bpf_load_hdr_opt(ctx, opt, sizeof(opt), 0) < 0)
> +		return;
> +
> +	found_d0 =3D opt[2];
> +	found_d1 =3D opt[3];
> +	found_cnt++;
> +}
> +
> +SEC(".struct_ops.link")
> +struct bpf_tcp_ops test_hdr_ops =3D {
> +	.hdr_opt_len	=3D (void *)test_hdr_opt_len,
> +	.write_hdr_opt	=3D (void *)test_write_hdr_opt,
> +	.parse_hdr	=3D (void *)test_parse_hdr,
> +};
> +
> +char _license[] SEC("license") =3D "GPL";

