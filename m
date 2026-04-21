Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFED29CB24
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776806417; cv=none; b=YP2DN7QQHR+0+XMx0sTURCmQ8dvCpBy7yyi+3zCTut/nywGs1A4qgKczEhFLHAIC07lk2V5HVxYFCP44kndbiHXc+pkPWETH/BMwV/xPOqeFlEvUnhnqKIyButbDCOsxNFJTHniw/mQp7pBHGKD69mvxsek6k4DVNGjeRuIzzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776806417; c=relaxed/simple;
	bh=GhqZIa2+KTmNMoSA25xe4UFiO+6SrIk9XAAT1UFhndk=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type:Cc:In-Reply-To; b=LhksHu6C7/ZgT/ELMaHdzBm8cCk9tKdC2B6WPzZEae09hEeYhbNICs5JKRYx9IzpPsEFlqQPz6AMD0dWK3AlxianypBHgmHqyFJjHNtOcJHJLWlvjllVmJu0mvfqavPZO6gSYq62eFsQsduJb25zkv8SQdx7MU4f6ol3RuRE5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glkb-bpf@m.gmane-mx.org>)
	id 1wFIQw-0001AZ-02
	for bpf@vger.kernel.org; Tue, 21 Apr 2026 23:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: bpf@vger.kernel.org
From: Vineet Gupta <vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next] selftests/bpf: remove string.h includes in bpf
 progs
Date: Tue, 21 Apr 2026 14:08:58 -0700
Message-ID: <e7f7a048-fdb7-477a-b175-33a254723d9d@linux.dev>
References: <20260421202233.528128-1-david.faust@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Cc: ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev,
 eddyz87@gmail.com, jose.marchesi@oracle.com, cupertino.miranda@oracle.com
Content-Language: en-US
In-Reply-To: <20260421202233.528128-1-david.faust@oracle.com>

On 4/21/26 1:22 PM, David Faust wrote:
> Sources for some BPF test programs currently include string.h, which
> is a glibc header and not a toolchain header.  Since there is no BPF
> glibc, this means it is the native system glibc string.h which gets
> included when building the test programs.
> 
> In all cases the include is only necessary for the prototypes of
> non-builtin versions of memset, memcpy, etc., and in every case both
> clang and gcc already replace these with the compiler built-in versions
> and expand them inline.
> 
> In the case of gcc this replacement happens after initial debuginfo is
> generated, which includes the calls to the glibc routines.  This means a
> BTF record for e.g. 'extern memset' is emitted, resulting in load
> failures like:
> 
>    libbpf: BTF loading error: -22
>    ...
>    [26] FUNC memset type_id=1 Invalid func linkage
> 
> This patch removes the includes of glibc string.h, and replaces the
> calls to memset and friends with the compiler built-in versions.
> There is no functional change other than to slim the compilation units
> and eliminate the BTF extern func records, which enables several
> more tests to pass when compiled with gcc.
> 
> Signed-off-by: David Faust <david.faust@oracle.com>

I think we also discussed the idea to add a header to redirect mem* to 
__builtin_mem* for:
  - avoiding recurrances of this in future, because submitters/reviewes 
will invariably miss this.
  - better UX, keep code more "naturally written"
  - reduces the patch churn

Thx,
-Vineet

> ---
>   .../testing/selftests/bpf/progs/bind4_prog.c  |  1 -
>   .../testing/selftests/bpf/progs/bind6_prog.c  |  1 -
>   tools/testing/selftests/bpf/progs/bpf_flow.c  |  5 +--
>   .../selftests/bpf/progs/connect4_dropper.c    |  1 -
>   .../selftests/bpf/progs/connect4_prog.c       |  5 +--
>   .../selftests/bpf/progs/connect6_prog.c       |  7 ++--
>   .../selftests/bpf/progs/connect_force_port4.c |  1 -
>   .../selftests/bpf/progs/connect_force_port6.c |  1 -
>   .../selftests/bpf/progs/connect_unix_prog.c   |  5 +--
>   .../testing/selftests/bpf/progs/dynptr_fail.c | 11 +++---
>   .../selftests/bpf/progs/dynptr_success.c      |  1 -
>   .../testing/selftests/bpf/progs/file_reader.c |  1 -
>   .../selftests/bpf/progs/file_reader_fail.c    |  1 -
>   .../selftests/bpf/progs/getpeername4_prog.c   |  1 -
>   .../selftests/bpf/progs/getpeername6_prog.c   |  1 -
>   .../bpf/progs/getpeername_unix_prog.c         |  5 +--
>   .../selftests/bpf/progs/getsockname4_prog.c   |  1 -
>   .../selftests/bpf/progs/getsockname6_prog.c   |  1 -
>   .../bpf/progs/getsockname_unix_prog.c         |  3 +-
>   .../selftests/bpf/progs/iters_looping.c       |  1 -
>   .../selftests/bpf/progs/iters_state_safety.c  |  1 -
>   .../selftests/bpf/progs/recvmsg_unix_prog.c   |  5 +--
>   .../selftests/bpf/progs/sendmsg_unix_prog.c   |  5 +--
>   .../testing/selftests/bpf/progs/sockopt_sk.c  |  3 +-
>   tools/testing/selftests/bpf/progs/syscall.c   |  9 ++---
>   tools/testing/selftests/bpf/progs/task_work.c |  1 -
>   .../selftests/bpf/progs/task_work_fail.c      |  1 -
>   .../selftests/bpf/progs/task_work_stress.c    |  1 -
>   .../selftests/bpf/progs/test_cls_redirect.c   | 19 +++++-----
>   .../selftests/bpf/progs/test_cls_redirect.h   |  1 -
>   .../bpf/progs/test_cls_redirect_dynptr.c      | 21 +++++------
>   .../selftests/bpf/progs/test_global_data.c    |  1 -
>   tools/testing/selftests/bpf/progs/test_l4lb.c | 13 +++----
>   .../selftests/bpf/progs/test_l4lb_noinline.c  | 13 +++----
>   .../bpf/progs/test_l4lb_noinline_dynptr.c     | 13 +++----
>   .../selftests/bpf/progs/test_lwt_ip_encap.c   |  5 +--
>   .../bpf/progs/test_migrate_reuseport.c        |  1 -
>   .../selftests/bpf/progs/test_pkt_access.c     |  1 -
>   .../selftests/bpf/progs/test_pkt_md_access.c  |  1 -
>   .../bpf/progs/test_queue_stack_map.h          |  1 -
>   .../selftests/bpf/progs/test_sk_assign.c      |  1 -
>   .../selftests/bpf/progs/test_sk_lookup_kern.c |  1 -
>   .../selftests/bpf/progs/test_sockmap_kern.h   |  3 +-
>   .../selftests/bpf/progs/test_sysctl_loop1.c   |  3 +-
>   .../selftests/bpf/progs/test_sysctl_loop2.c   |  3 +-
>   .../selftests/bpf/progs/test_sysctl_prog.c    |  3 +-
>   .../selftests/bpf/progs/test_tcp_estats.c     |  3 +-
>   .../selftests/bpf/progs/test_tcpnotify_kern.c |  1 -
>   tools/testing/selftests/bpf/progs/test_xdp.c  | 13 +++----
>   .../selftests/bpf/progs/test_xdp_dynptr.c     | 13 +++----
>   .../selftests/bpf/progs/test_xdp_loop.c       | 13 +++----
>   .../selftests/bpf/progs/test_xdp_noinline.c   | 37 +++++++++----------
>   .../selftests/bpf/progs/test_xdp_vlan.c       |  1 -
>   .../selftests/bpf/progs/uprobe_syscall.c      |  1 -
>   .../bpf/progs/uprobe_syscall_executed.c       |  1 -
>   .../bpf/progs/verifier_subprog_precision.c    |  1 -
>   .../bpf/progs/xdp_redirect_multi_kern.c       |  1 -
>   .../testing/selftests/bpf/progs/xdping_kern.c |  1 -
>   58 files changed, 106 insertions(+), 164 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> index b7ddf8ec4ee8..556846fe05c1 100644
> --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <string.h>
>   
>   #include <linux/stddef.h>
>   #include <linux/bpf.h>
> diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
> index 501c3fc11d35..1ed793e5dc68 100644
> --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <string.h>
>   
>   #include <linux/stddef.h>
>   #include <linux/bpf.h>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
> index b04e092fac94..74b714ae36ee 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_flow.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
> @@ -2,7 +2,6 @@
>   #include <limits.h>
>   #include <stddef.h>
>   #include <stdbool.h>
> -#include <string.h>
>   #include <linux/pkt_cls.h>
>   #include <linux/bpf.h>
>   #include <linux/in.h>
> @@ -78,7 +77,7 @@ static __always_inline int export_flow_keys(struct bpf_flow_keys *keys,
>   	__u32 key = (__u32)(keys->sport) << 16 | keys->dport;
>   	struct bpf_flow_keys val;
>   
> -	memcpy(&val, keys, sizeof(val));
> +	__builtin_memcpy(&val, keys, sizeof(val));
>   	bpf_map_update_elem(&last_dissection, &key, &val, BPF_ANY);
>   	return ret;
>   }
> @@ -331,7 +330,7 @@ PROG(IPV6)(struct __sk_buff *skb)
>   		return export_flow_keys(keys, BPF_DROP);
>   
>   	keys->addr_proto = ETH_P_IPV6;
> -	memcpy(&keys->ipv6_src, &ip6h->saddr, 2*sizeof(ip6h->saddr));
> +	__builtin_memcpy(&keys->ipv6_src, &ip6h->saddr, 2*sizeof(ip6h->saddr));
>   
>   	keys->thoff += sizeof(struct ipv6hdr);
>   	keys->ip_proto = ip6h->nexthdr;
> diff --git a/tools/testing/selftests/bpf/progs/connect4_dropper.c b/tools/testing/selftests/bpf/progs/connect4_dropper.c
> index a3819a5d09c8..fe483fb389f6 100644
> --- a/tools/testing/selftests/bpf/progs/connect4_dropper.c
> +++ b/tools/testing/selftests/bpf/progs/connect4_dropper.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> -#include <string.h>
>   
>   #include <linux/stddef.h>
>   #include <linux/bpf.h>
> diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
> index 9d158cfad981..15f0ce5032bf 100644
> --- a/tools/testing/selftests/bpf/progs/connect4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (c) 2018 Facebook
>   
> -#include <string.h>
>   
>   #include <linux/stddef.h>
>   #include <linux/bpf.h>
> @@ -147,8 +146,8 @@ int connect_v4_prog(struct bpf_sock_addr *ctx)
>   	struct bpf_sock *sk;
>   
>   	/* Verify that new destination is available. */
> -	memset(&tuple.ipv4.saddr, 0, sizeof(tuple.ipv4.saddr));
> -	memset(&tuple.ipv4.sport, 0, sizeof(tuple.ipv4.sport));
> +	__builtin_memset(&tuple.ipv4.saddr, 0, sizeof(tuple.ipv4.saddr));
> +	__builtin_memset(&tuple.ipv4.sport, 0, sizeof(tuple.ipv4.sport));
>   
>   	tuple.ipv4.daddr = bpf_htonl(DST_REWRITE_IP4);
>   	tuple.ipv4.dport = bpf_htons(DST_REWRITE_PORT4);
> diff --git a/tools/testing/selftests/bpf/progs/connect6_prog.c b/tools/testing/selftests/bpf/progs/connect6_prog.c
> index e98573b00ddb..cdda6abeae19 100644
> --- a/tools/testing/selftests/bpf/progs/connect6_prog.c
> +++ b/tools/testing/selftests/bpf/progs/connect6_prog.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (c) 2018 Facebook
>   
> -#include <string.h>
>   
>   #include <linux/stddef.h>
>   #include <linux/bpf.h>
> @@ -32,8 +31,8 @@ int connect_v6_prog(struct bpf_sock_addr *ctx)
>   	struct bpf_sock *sk;
>   
>   	/* Verify that new destination is available. */
> -	memset(&tuple.ipv6.saddr, 0, sizeof(tuple.ipv6.saddr));
> -	memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
> +	__builtin_memset(&tuple.ipv6.saddr, 0, sizeof(tuple.ipv6.saddr));
> +	__builtin_memset(&tuple.ipv6.sport, 0, sizeof(tuple.ipv6.sport));
>   
>   	tuple.ipv6.daddr[0] = bpf_htonl(DST_REWRITE_IP6_0);
>   	tuple.ipv6.daddr[1] = bpf_htonl(DST_REWRITE_IP6_1);
> @@ -74,7 +73,7 @@ int connect_v6_prog(struct bpf_sock_addr *ctx)
>   	ctx->user_port = bpf_htons(DST_REWRITE_PORT6);
>   
>   	/* Rewrite source. */
> -	memset(&sa, 0, sizeof(sa));
> +	__builtin_memset(&sa, 0, sizeof(sa));
>   
>   	sa.sin6_family = AF_INET6;
>   	sa.sin6_port = bpf_htons(0);
> diff --git a/tools/testing/selftests/bpf/progs/connect_force_port4.c b/tools/testing/selftests/bpf/progs/connect_force_port4.c
> index d5be6a559d6a..0f60c4789237 100644
> --- a/tools/testing/selftests/bpf/progs/connect_force_port4.c
> +++ b/tools/testing/selftests/bpf/progs/connect_force_port4.c
> @@ -1,5 +1,4 @@
>   // SPDX-License-Identifier: GPL-2.0
> -#include <string.h>
>   #include <stdbool.h>
>   
>   #include <linux/bpf.h>
> diff --git a/tools/testing/selftests/bpf/progs/connect_force_port6.c b/tools/testing/selftests/bpf/progs/connect_force_port6.c
> index a1a671b39083..047a2462abef 100644
> --- a/tools/testing/selftests/bpf/progs/connect_force_port6.c
> +++ b/tools/testing/selftests/bpf/progs/connect_force_port6.c
> @@ -1,5 +1,4 @@
>   // SPDX-License-Identifier: GPL-2.0
> -#include <string.h>
>   
>   #include <linux/bpf.h>
>   #include <linux/in.h>
> diff --git a/tools/testing/selftests/bpf/progs/connect_unix_prog.c b/tools/testing/selftests/bpf/progs/connect_unix_prog.c
> index ba60adadb335..baf9189ca863 100644
> --- a/tools/testing/selftests/bpf/progs/connect_unix_prog.c
> +++ b/tools/testing/selftests/bpf/progs/connect_unix_prog.c
> @@ -3,7 +3,6 @@
>   
>   #include "vmlinux.h"
>   
> -#include <string.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_core_read.h>
>   #include "bpf_kfuncs.h"
> @@ -29,8 +28,8 @@ int connect_unix_prog(struct bpf_sock_addr *ctx)
>   		return 0;
>   
>   	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
> -	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
> -			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
> +	if (__builtin_memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
> +			     sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
>   		return 0;
>   
>   	return 1;
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> index b62773ce5219..75c8a949ebbd 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2022 Facebook */
>   
>   #include <errno.h>
> -#include <string.h>
>   #include <stdbool.h>
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
> @@ -457,7 +456,7 @@ int invalid_write1(void *ctx)
>   
>   	get_map_val_dynptr(&ptr);
>   
> -	memcpy(&ptr, &x, sizeof(x));
> +	__builtin_memcpy(&ptr, &x, sizeof(x));
>   
>   	/* this should fail */
>   	data = bpf_dynptr_data(&ptr, 0, 1);
> @@ -480,7 +479,7 @@ int invalid_write2(void *ctx)
>   
>   	bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr);
>   
> -	memcpy((void *)&ptr + 8, &x, sizeof(x));
> +	__builtin_memcpy((void *)&ptr + 8, &x, sizeof(x));
>   
>   	/* this should fail */
>   	bpf_dynptr_read(read_data, sizeof(read_data), &ptr, 0, 0);
> @@ -505,10 +504,10 @@ int invalid_write3(void *ctx)
>   
>   	bpf_ringbuf_reserve_dynptr(&ringbuf, 8, 0, &ptr);
>   
> -	memcpy(stack_buf, &val, sizeof(val));
> +	__builtin_memcpy(stack_buf, &val, sizeof(val));
>   	len = stack_buf[0] & 0xf;
>   
> -	memcpy((void *)&ptr + len, &x, sizeof(x));
> +	__builtin_memcpy((void *)&ptr + len, &x, sizeof(x));
>   
>   	/* this should fail */
>   	bpf_ringbuf_submit_dynptr(&ptr, 0);
> @@ -601,7 +600,7 @@ int invalid_read3(void *ctx)
>   	bpf_ringbuf_reserve_dynptr(&ringbuf, 16, 0, &ptr2);
>   
>   	/* this should fail */
> -	memcpy(&val, (void *)&ptr1 + 8, sizeof(val));
> +	__builtin_memcpy(&val, (void *)&ptr1 + 8, sizeof(val));
>   
>   	bpf_ringbuf_discard_dynptr(&ptr1, 0);
>   	bpf_ringbuf_discard_dynptr(&ptr2, 0);
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
> index e0745b6e467e..e48152da6b87 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2022 Facebook */
>   
>   #include <vmlinux.h>
> -#include <string.h>
>   #include <stdbool.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
> diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
> index 462712ff3b8a..fe07ac37eacf 100644
> --- a/tools/testing/selftests/bpf/progs/file_reader.c
> +++ b/tools/testing/selftests/bpf/progs/file_reader.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>   
>   #include <vmlinux.h>
> -#include <string.h>
>   #include <stdbool.h>
>   #include <bpf/bpf_tracing.h>
>   #include "bpf_misc.h"
> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> index 32fe28ed2439..2367cdc01fc2 100644
> --- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>   
>   #include <vmlinux.h>
> -#include <string.h>
>   #include <stdbool.h>
>   #include <bpf/bpf_tracing.h>
>   #include "bpf_misc.h"
> diff --git a/tools/testing/selftests/bpf/progs/getpeername4_prog.c b/tools/testing/selftests/bpf/progs/getpeername4_prog.c
> index 4c97208cd25d..937a874edded 100644
> --- a/tools/testing/selftests/bpf/progs/getpeername4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/getpeername4_prog.c
> @@ -3,7 +3,6 @@
>   
>   #include "vmlinux.h"
>   
> -#include <string.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
>   #include <bpf/bpf_core_read.h>
> diff --git a/tools/testing/selftests/bpf/progs/getpeername6_prog.c b/tools/testing/selftests/bpf/progs/getpeername6_prog.c
> index 070e4d7f636c..1aac19724ed1 100644
> --- a/tools/testing/selftests/bpf/progs/getpeername6_prog.c
> +++ b/tools/testing/selftests/bpf/progs/getpeername6_prog.c
> @@ -3,7 +3,6 @@
>   
>   #include "vmlinux.h"
>   
> -#include <string.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
>   #include <bpf/bpf_core_read.h>
> diff --git a/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c b/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
> index 5a76754f846b..237633664af3 100644
> --- a/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
> +++ b/tools/testing/selftests/bpf/progs/getpeername_unix_prog.c
> @@ -3,7 +3,6 @@
>   
>   #include "vmlinux.h"
>   
> -#include <string.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_core_read.h>
>   #include "bpf_kfuncs.h"
> @@ -28,8 +27,8 @@ int getpeername_unix_prog(struct bpf_sock_addr *ctx)
>   		return 1;
>   
>   	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
> -	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
> -			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
> +	if (__builtin_memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
> +			     sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
>   		return 1;
>   
>   	return 1;
> diff --git a/tools/testing/selftests/bpf/progs/getsockname4_prog.c b/tools/testing/selftests/bpf/progs/getsockname4_prog.c
> index e298487c6347..34ecf2e492c4 100644
> --- a/tools/testing/selftests/bpf/progs/getsockname4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/getsockname4_prog.c
> @@ -3,7 +3,6 @@
>   
>   #include "vmlinux.h"
>   
> -#include <string.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
>   #include <bpf/bpf_core_read.h>
> diff --git a/tools/testing/selftests/bpf/progs/getsockname6_prog.c b/tools/testing/selftests/bpf/progs/getsockname6_prog.c
> index 811d10cd5525..9cb0962cbd18 100644
> --- a/tools/testing/selftests/bpf/progs/getsockname6_prog.c
> +++ b/tools/testing/selftests/bpf/progs/getsockname6_prog.c
> @@ -3,7 +3,6 @@
>   
>   #include "vmlinux.h"
>   
> -#include <string.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
>   #include <bpf/bpf_core_read.h>
> diff --git a/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c b/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
> index 7867113c696f..5edf4866304f 100644
> --- a/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
> +++ b/tools/testing/selftests/bpf/progs/getsockname_unix_prog.c
> @@ -3,7 +3,6 @@
>   
>   #include "vmlinux.h"
>   
> -#include <string.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_core_read.h>
>   #include "bpf_kfuncs.h"
> @@ -28,7 +27,7 @@ int getsockname_unix_prog(struct bpf_sock_addr *ctx)
>   		return 1;
>   
>   	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
> -	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
> +	if (__builtin_memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
>   			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
>   		return 1;
>   
> diff --git a/tools/testing/selftests/bpf/progs/iters_looping.c b/tools/testing/selftests/bpf/progs/iters_looping.c
> index d00fd570255a..7b6b7f8ae163 100644
> --- a/tools/testing/selftests/bpf/progs/iters_looping.c
> +++ b/tools/testing/selftests/bpf/progs/iters_looping.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>   
>   #include <errno.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
>   #include "bpf_misc.h"
> diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
> index d273b46dfc7c..4925958a33f5 100644
> --- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
> +++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2022 Facebook */
>   
>   #include <errno.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
>   #include "bpf_misc.h"
> diff --git a/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c b/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
> index 1c7ab44bccfa..2af74b3213a8 100644
> --- a/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
> +++ b/tools/testing/selftests/bpf/progs/recvmsg_unix_prog.c
> @@ -3,7 +3,6 @@
>   
>   #include "vmlinux.h"
>   
> -#include <string.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_core_read.h>
>   #include "bpf_kfuncs.h"
> @@ -28,8 +27,8 @@ int recvmsg_unix_prog(struct bpf_sock_addr *ctx)
>   		return 1;
>   
>   	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
> -	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_ADDRESS,
> -			sizeof(SERVUN_ADDRESS) - 1) != 0)
> +	if (__builtin_memcmp(sa_kern_unaddr->sun_path, SERVUN_ADDRESS,
> +			     sizeof(SERVUN_ADDRESS) - 1) != 0)
>   		return 1;
>   
>   	return 1;
> diff --git a/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c b/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
> index 332d0eb1116f..4d23cc2079f7 100644
> --- a/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
> +++ b/tools/testing/selftests/bpf/progs/sendmsg_unix_prog.c
> @@ -3,7 +3,6 @@
>   
>   #include "vmlinux.h"
>   
> -#include <string.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_core_read.h>
>   #include "bpf_kfuncs.h"
> @@ -29,8 +28,8 @@ int sendmsg_unix_prog(struct bpf_sock_addr *ctx)
>   		return 0;
>   
>   	sa_kern_unaddr = bpf_core_cast(sa_kern->uaddr, struct sockaddr_un);
> -	if (memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
> -			sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
> +	if (__builtin_memcmp(sa_kern_unaddr->sun_path, SERVUN_REWRITE_ADDRESS,
> +			     sizeof(SERVUN_REWRITE_ADDRESS) - 1) != 0)
>   		return 0;
>   
>   	return 1;
> diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> index cb990a7d3d45..236b58c724f6 100644
> --- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> @@ -1,5 +1,4 @@
>   // SPDX-License-Identifier: GPL-2.0
> -#include <string.h>
>   #include <linux/tcp.h>
>   #include <linux/bpf.h>
>   #include <netinet/in.h>
> @@ -184,7 +183,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
>   		if (optval + 5 > optval_end)
>   			return 0; /* bounds check */
>   
> -		memcpy(optval, "cubic", 5);
> +		__builtin_memcpy(optval, "cubic", 5);
>   		ctx->optlen = 5;
>   
>   		return 1;
> diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
> index b698cc62a371..da070b40cde6 100644
> --- a/tools/testing/selftests/bpf/progs/syscall.c
> +++ b/tools/testing/selftests/bpf/progs/syscall.c
> @@ -6,7 +6,6 @@
>   #include <bpf/bpf_tracing.h>
>   #include <../../../tools/include/linux/filter.h>
>   #include <linux/btf.h>
> -#include <string.h>
>   #include <errno.h>
>   #include "bpf_misc.h"
>   
> @@ -169,13 +168,13 @@ int update_outer_map(void *ctx)
>   	if (!attr)
>   		goto out;
>   
> -	memset(attr, 0, attr_sz);
> +	__builtin_memset(attr, 0, attr_sz);
>   	attr->map_id = ((struct bpf_map *)&outer_array_map)->id;
>   	outer_fd = bpf_sys_bpf(BPF_MAP_GET_FD_BY_ID, attr, attr_sz);
>   	if (outer_fd < 0)
>   		goto out;
>   
> -	memset(attr, 0, attr_sz);
> +	__builtin_memset(attr, 0, attr_sz);
>   	attr->map_type = BPF_MAP_TYPE_ARRAY;
>   	attr->key_size = 4;
>   	attr->value_size = 4;
> @@ -184,7 +183,7 @@ int update_outer_map(void *ctx)
>   	if (inner_fd < 0)
>   		goto out;
>   
> -	memset(attr, 0, attr_sz);
> +	__builtin_memset(attr, 0, attr_sz);
>   	attr->map_fd = outer_fd;
>   	attr->key = ptr_to_u64(&zero);
>   	attr->value = ptr_to_u64(&inner_fd);
> @@ -192,7 +191,7 @@ int update_outer_map(void *ctx)
>   	if (err)
>   		goto out;
>   
> -	memset(attr, 0, attr_sz);
> +	__builtin_memset(attr, 0, attr_sz);
>   	attr->map_fd = outer_fd;
>   	attr->key = ptr_to_u64(&zero);
>   	err = bpf_sys_bpf(BPF_MAP_DELETE_ELEM, attr, attr_sz);
> diff --git a/tools/testing/selftests/bpf/progs/task_work.c b/tools/testing/selftests/bpf/progs/task_work.c
> index a6009d105158..78bf283f7168 100644
> --- a/tools/testing/selftests/bpf/progs/task_work.c
> +++ b/tools/testing/selftests/bpf/progs/task_work.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>   
>   #include <vmlinux.h>
> -#include <string.h>
>   #include <stdbool.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
> diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/testing/selftests/bpf/progs/task_work_fail.c
> index 82e4b8913333..85f0b7b0b2c1 100644
> --- a/tools/testing/selftests/bpf/progs/task_work_fail.c
> +++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>   
>   #include <vmlinux.h>
> -#include <string.h>
>   #include <stdbool.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
> diff --git a/tools/testing/selftests/bpf/progs/task_work_stress.c b/tools/testing/selftests/bpf/progs/task_work_stress.c
> index 1d4378f351ef..af853e9eaa4c 100644
> --- a/tools/testing/selftests/bpf/progs/task_work_stress.c
> +++ b/tools/testing/selftests/bpf/progs/task_work_stress.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>   
>   #include <vmlinux.h>
> -#include <string.h>
>   #include <stdbool.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> index 26a53e54b8fa..2f98c0cf9821 100644
> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> @@ -4,7 +4,6 @@
>   #include <stdbool.h>
>   #include <stddef.h>
>   #include <stdint.h>
> -#include <string.h>
>   
>   #include <linux/bpf.h>
>   #include <linux/icmp.h>
> @@ -533,10 +532,10 @@ static INLINING ret_t forward_to_next_hop(struct __sk_buff *skb, encap_headers_t
>   	 * the router, which will send it to the appropriate machine.
>   	 */
>   	unsigned char temp[ETH_ALEN];
> -	memcpy(temp, encap->eth.h_dest, sizeof(temp));
> -	memcpy(encap->eth.h_dest, encap->eth.h_source,
> +	__builtin_memcpy(temp, encap->eth.h_dest, sizeof(temp));
> +	__builtin_memcpy(encap->eth.h_dest, encap->eth.h_source,
>   	       sizeof(encap->eth.h_dest));
> -	memcpy(encap->eth.h_source, temp, sizeof(encap->eth.h_source));
> +	__builtin_memcpy(encap->eth.h_source, temp, sizeof(encap->eth.h_source));
>   
>   	if (encap->unigue.next_hop == encap->unigue.hop_count - 1 &&
>   	    encap->unigue.last_hop_gre) {
> @@ -631,10 +630,10 @@ static INLINING uint64_t fill_tuple(struct bpf_sock_tuple *tuple, void *iph,
>   
>   	case sizeof(struct ipv6hdr): {
>   		struct ipv6hdr *ipv6 = (struct ipv6hdr *)iph;
> -		memcpy(&tuple->ipv6.daddr, &ipv6->daddr,
> -		       sizeof(tuple->ipv6.daddr));
> -		memcpy(&tuple->ipv6.saddr, &ipv6->saddr,
> -		       sizeof(tuple->ipv6.saddr));
> +		__builtin_memcpy(&tuple->ipv6.daddr, &ipv6->daddr,
> +				 sizeof(tuple->ipv6.daddr));
> +		__builtin_memcpy(&tuple->ipv6.saddr, &ipv6->saddr,
> +				 sizeof(tuple->ipv6.saddr));
>   		tuple->ipv6.sport = sport;
>   		tuple->ipv6.dport = dport;
>   		return sizeof(tuple->ipv6);
> @@ -800,8 +799,8 @@ static INLINING verdict_t process_icmpv6(buf_t *pkt, metrics_t *metrics)
>   
>   	/* Swap source and dest addresses. */
>   	struct bpf_sock_tuple tuple;
> -	memcpy(&tuple.ipv6.saddr, &ipv6->daddr, sizeof(tuple.ipv6.saddr));
> -	memcpy(&tuple.ipv6.daddr, &ipv6->saddr, sizeof(tuple.ipv6.daddr));
> +	__builtin_memcpy(&tuple.ipv6.saddr, &ipv6->daddr, sizeof(tuple.ipv6.saddr));
> +	__builtin_memcpy(&tuple.ipv6.daddr, &ipv6->saddr, sizeof(tuple.ipv6.daddr));
>   
>   	if (!pkt_parse_icmp_l4_ports(pkt, (flow_ports_t *)&tuple.ipv6.sport)) {
>   		metrics->errors_total_malformed_icmp_pkt_too_big++;
> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.h b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
> index eb55cb8a3dbd..b0a521ec9578 100644
> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
> @@ -4,7 +4,6 @@
>   #include <stdbool.h>
>   #include <stddef.h>
>   #include <stdint.h>
> -#include <string.h>
>   
>   #include <linux/if_ether.h>
>   #include <linux/in.h>
> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
> index dfd4a2710391..cb9355a05441 100644
> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
> @@ -4,7 +4,6 @@
>   #include <stdbool.h>
>   #include <stddef.h>
>   #include <stdint.h>
> -#include <string.h>
>   
>   #include <linux/bpf.h>
>   #include <linux/icmp.h>
> @@ -427,10 +426,10 @@ static ret_t forward_to_next_hop(struct __sk_buff *skb, struct bpf_dynptr *dynpt
>   	 * the router, which will send it to the appropriate machine.
>   	 */
>   	unsigned char temp[ETH_ALEN];
> -	memcpy(temp, encap->eth.h_dest, sizeof(temp));
> -	memcpy(encap->eth.h_dest, encap->eth.h_source,
> -	       sizeof(encap->eth.h_dest));
> -	memcpy(encap->eth.h_source, temp, sizeof(encap->eth.h_source));
> +	__builtin_memcpy(temp, encap->eth.h_dest, sizeof(temp));
> +	__builtin_memcpy(encap->eth.h_dest, encap->eth.h_source,
> +			 sizeof(encap->eth.h_dest));
> +	__builtin_memcpy(encap->eth.h_source, temp, sizeof(encap->eth.h_source));
>   
>   	if (encap->unigue.next_hop == encap->unigue.hop_count - 1 &&
>   	    encap->unigue.last_hop_gre) {
> @@ -523,10 +522,10 @@ static uint64_t fill_tuple(struct bpf_sock_tuple *tuple, void *iph,
>   
>   	case sizeof(struct ipv6hdr): {
>   		struct ipv6hdr *ipv6 = (struct ipv6hdr *)iph;
> -		memcpy(&tuple->ipv6.daddr, &ipv6->daddr,
> -		       sizeof(tuple->ipv6.daddr));
> -		memcpy(&tuple->ipv6.saddr, &ipv6->saddr,
> -		       sizeof(tuple->ipv6.saddr));
> +		__builtin_memcpy(&tuple->ipv6.daddr, &ipv6->daddr,
> +				 sizeof(tuple->ipv6.daddr));
> +		__builtin_memcpy(&tuple->ipv6.saddr, &ipv6->saddr,
> +				 sizeof(tuple->ipv6.saddr));
>   		tuple->ipv6.sport = sport;
>   		tuple->ipv6.dport = dport;
>   		return sizeof(tuple->ipv6);
> @@ -691,8 +690,8 @@ static verdict_t process_icmpv6(struct bpf_dynptr *dynptr, __u64 *offset, struct
>   	}
>   
>   	/* Swap source and dest addresses. */
> -	memcpy(&tuple.ipv6.saddr, &ipv6.daddr, sizeof(tuple.ipv6.saddr));
> -	memcpy(&tuple.ipv6.daddr, &ipv6.saddr, sizeof(tuple.ipv6.daddr));
> +	__builtin_memcpy(&tuple.ipv6.saddr, &ipv6.daddr, sizeof(tuple.ipv6.saddr));
> +	__builtin_memcpy(&tuple.ipv6.daddr, &ipv6.saddr, sizeof(tuple.ipv6.daddr));
>   
>   	if (!pkt_parse_icmp_l4_ports(dynptr, offset, (flow_ports_t *)&tuple.ipv6.sport)) {
>   		metrics->errors_total_malformed_icmp_pkt_too_big++;
> diff --git a/tools/testing/selftests/bpf/progs/test_global_data.c b/tools/testing/selftests/bpf/progs/test_global_data.c
> index 719e314ef3e4..c9d6c247194d 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_data.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_data.c
> @@ -3,7 +3,6 @@
>   
>   #include <linux/bpf.h>
>   #include <linux/pkt_cls.h>
> -#include <string.h>
>   
>   #include <bpf/bpf_helpers.h>
>   
> diff --git a/tools/testing/selftests/bpf/progs/test_l4lb.c b/tools/testing/selftests/bpf/progs/test_l4lb.c
> index c26057ec46dc..6132df5a16ad 100644
> --- a/tools/testing/selftests/bpf/progs/test_l4lb.c
> +++ b/tools/testing/selftests/bpf/progs/test_l4lb.c
> @@ -6,7 +6,6 @@
>    */
>   #include <stddef.h>
>   #include <stdbool.h>
> -#include <string.h>
>   #include <linux/pkt_cls.h>
>   #include <linux/bpf.h>
>   #include <linux/in.h>
> @@ -248,8 +247,8 @@ static __always_inline int parse_icmpv6(void *data, void *data_end, __u64 off,
>   		return TC_ACT_SHOT;
>   	pckt->proto = ip6h->nexthdr;
>   	pckt->flags |= F_ICMP;
> -	memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
> -	memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
> +	__builtin_memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
> +	__builtin_memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
>   	return TC_ACT_UNSPEC;
>   }
>   
> @@ -362,8 +361,8 @@ static __always_inline int process_packet(void *data, __u64 off, void *data_end,
>   				return action;
>   			off += IPV6_PLUS_ICMP_HDR;
>   		} else {
> -			memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
> -			memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
> +			__builtin_memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
> +			__builtin_memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
>   		}
>   	} else {
>   		iph = data + off;
> @@ -402,7 +401,7 @@ static __always_inline int process_packet(void *data, __u64 off, void *data_end,
>   	}
>   
>   	if (is_ipv6)
> -		memcpy(vip.daddr.v6, pckt.dstv6, 16);
> +		__builtin_memcpy(vip.daddr.v6, pckt.dstv6, 16);
>   	else
>   		vip.daddr.v4 = pckt.dst;
>   
> @@ -428,7 +427,7 @@ static __always_inline int process_packet(void *data, __u64 off, void *data_end,
>   		if (!cval)
>   			return TC_ACT_SHOT;
>   		ifindex = cval->ifindex;
> -		memcpy(tkey.remote_ipv6, dst->dstv6, 16);
> +		__builtin_memcpy(tkey.remote_ipv6, dst->dstv6, 16);
>   		tun_flag = BPF_F_TUNINFO_IPV6;
>   	} else {
>   		cval = bpf_map_lookup_elem(&ctl_array, &v4_intf_pos);
> diff --git a/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c b/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
> index c8bc0c6947aa..141ef5fbd560 100644
> --- a/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
> +++ b/tools/testing/selftests/bpf/progs/test_l4lb_noinline.c
> @@ -2,7 +2,6 @@
>   // Copyright (c) 2017 Facebook
>   #include <stddef.h>
>   #include <stdbool.h>
> -#include <string.h>
>   #include <linux/pkt_cls.h>
>   #include <linux/bpf.h>
>   #include <linux/in.h>
> @@ -247,8 +246,8 @@ static __noinline int parse_icmpv6(void *data, void *data_end, __u64 off,
>   		return TC_ACT_SHOT;
>   	pckt->proto = ip6h->nexthdr;
>   	pckt->flags |= F_ICMP;
> -	memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
> -	memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
> +	__builtin_memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
> +	__builtin_memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
>   	return TC_ACT_UNSPEC;
>   }
>   
> @@ -361,8 +360,8 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
>   				return action;
>   			off += IPV6_PLUS_ICMP_HDR;
>   		} else {
> -			memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
> -			memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
> +			__builtin_memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
> +			__builtin_memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
>   		}
>   	} else {
>   		iph = data + off;
> @@ -401,7 +400,7 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
>   	}
>   
>   	if (is_ipv6)
> -		memcpy(vip.daddr.v6, pckt.dstv6, 16);
> +		__builtin_memcpy(vip.daddr.v6, pckt.dstv6, 16);
>   	else
>   		vip.daddr.v4 = pckt.dst;
>   
> @@ -427,7 +426,7 @@ static __noinline int process_packet(void *data, __u64 off, void *data_end,
>   		if (!cval)
>   			return TC_ACT_SHOT;
>   		ifindex = cval->ifindex;
> -		memcpy(tkey.remote_ipv6, dst->dstv6, 16);
> +		__builtin_memcpy(tkey.remote_ipv6, dst->dstv6, 16);
>   		tun_flag = BPF_F_TUNINFO_IPV6;
>   	} else {
>   		cval = bpf_map_lookup_elem(&ctl_array, &v4_intf_pos);
> diff --git a/tools/testing/selftests/bpf/progs/test_l4lb_noinline_dynptr.c b/tools/testing/selftests/bpf/progs/test_l4lb_noinline_dynptr.c
> index f997f5080748..5c068da63a8d 100644
> --- a/tools/testing/selftests/bpf/progs/test_l4lb_noinline_dynptr.c
> +++ b/tools/testing/selftests/bpf/progs/test_l4lb_noinline_dynptr.c
> @@ -2,7 +2,6 @@
>   // Copyright (c) 2017 Facebook
>   #include <stddef.h>
>   #include <stdbool.h>
> -#include <string.h>
>   #include <linux/pkt_cls.h>
>   #include <linux/bpf.h>
>   #include <linux/in.h>
> @@ -251,8 +250,8 @@ static __noinline int parse_icmpv6(struct bpf_dynptr *skb_ptr, __u64 off,
>   		return TC_ACT_SHOT;
>   	pckt->proto = ip6h->nexthdr;
>   	pckt->flags |= F_ICMP;
> -	memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
> -	memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
> +	__builtin_memcpy(pckt->srcv6, ip6h->daddr.s6_addr32, 16);
> +	__builtin_memcpy(pckt->dstv6, ip6h->saddr.s6_addr32, 16);
>   	return TC_ACT_UNSPEC;
>   }
>   
> @@ -368,8 +367,8 @@ static __noinline int process_packet(struct bpf_dynptr *skb_ptr,
>   				return action;
>   			off += IPV6_PLUS_ICMP_HDR;
>   		} else {
> -			memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
> -			memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
> +			__builtin_memcpy(pckt.srcv6, ip6h->saddr.s6_addr32, 16);
> +			__builtin_memcpy(pckt.dstv6, ip6h->daddr.s6_addr32, 16);
>   		}
>   	} else {
>   		__u8 buffer[sizeof(struct iphdr)] = {};
> @@ -408,7 +407,7 @@ static __noinline int process_packet(struct bpf_dynptr *skb_ptr,
>   	}
>   
>   	if (is_ipv6)
> -		memcpy(vip.daddr.v6, pckt.dstv6, 16);
> +		__builtin_memcpy(vip.daddr.v6, pckt.dstv6, 16);
>   	else
>   		vip.daddr.v4 = pckt.dst;
>   
> @@ -434,7 +433,7 @@ static __noinline int process_packet(struct bpf_dynptr *skb_ptr,
>   		if (!cval)
>   			return TC_ACT_SHOT;
>   		ifindex = cval->ifindex;
> -		memcpy(tkey.remote_ipv6, dst->dstv6, 16);
> +		__builtin_memcpy(tkey.remote_ipv6, dst->dstv6, 16);
>   		tun_flag = BPF_F_TUNINFO_IPV6;
>   	} else {
>   		cval = bpf_map_lookup_elem(&ctl_array, &v4_intf_pos);
> diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
> index d6cb986e7533..c29db7866e80 100644
> --- a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
> +++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <stddef.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/ip.h>
>   #include <linux/ipv6.h>
> @@ -21,7 +20,7 @@ int bpf_lwt_encap_gre(struct __sk_buff *skb)
>   	} hdr;
>   	int err;
>   
> -	memset(&hdr, 0, sizeof(struct encap_hdr));
> +	__builtin_memset(&hdr, 0, sizeof(struct encap_hdr));
>   
>   	hdr.iph.ihl = 5;
>   	hdr.iph.version = 4;
> @@ -57,7 +56,7 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
>   	} hdr;
>   	int err;
>   
> -	memset(&hdr, 0, sizeof(struct encap_hdr));
> +	__builtin_memset(&hdr, 0, sizeof(struct encap_hdr));
>   
>   	hdr.ip6hdr.version = 6;
>   	hdr.ip6hdr.payload_len = bpf_htons(skb->len + sizeof(struct grehdr));
> diff --git a/tools/testing/selftests/bpf/progs/test_migrate_reuseport.c b/tools/testing/selftests/bpf/progs/test_migrate_reuseport.c
> index 27df571abf5b..b351b3d91d1d 100644
> --- a/tools/testing/selftests/bpf/progs/test_migrate_reuseport.c
> +++ b/tools/testing/selftests/bpf/progs/test_migrate_reuseport.c
> @@ -11,7 +11,6 @@
>    */
>   
>   #include <stddef.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
>   #include <linux/ip.h>
> diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> index bce7173152c6..ed87887a5cea 100644
> --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2017 Facebook
>    */
>   #include <stddef.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_packet.h>
> diff --git a/tools/testing/selftests/bpf/progs/test_pkt_md_access.c b/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
> index d1839366f3e1..2d279b5fb69b 100644
> --- a/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
> +++ b/tools/testing/selftests/bpf/progs/test_pkt_md_access.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2017 Facebook
>    */
>   #include <stddef.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/pkt_cls.h>
>   #include <bpf/bpf_helpers.h>
> diff --git a/tools/testing/selftests/bpf/progs/test_queue_stack_map.h b/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
> index 648e8cab7a23..011adc80f2a4 100644
> --- a/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
> +++ b/tools/testing/selftests/bpf/progs/test_queue_stack_map.h
> @@ -1,7 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   // Copyright (c) 2018 Politecnico di Torino
>   #include <stddef.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
>   #include <linux/ip.h>
> diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
> index 3079244c7f96..d82b57d981de 100644
> --- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
> +++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
> @@ -4,7 +4,6 @@
>   
>   #include <stddef.h>
>   #include <stdbool.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
>   #include <linux/in.h>
> diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
> index e9efc3263022..94b2a02cc539 100644
> --- a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
> @@ -3,7 +3,6 @@
>   
>   #include <stddef.h>
>   #include <stdbool.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
>   #include <linux/in.h>
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
> index f48f85f1bd70..804ad5399efc 100644
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_kern.h
> @@ -1,7 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /* Copyright (c) 2017-2018 Covalent IO, Inc. http://covalent.io */
>   #include <stddef.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_packet.h>
> @@ -148,7 +147,7 @@ static inline void bpf_write_pass(struct __sk_buff *skb, int offset)
>   	data_end = (void *)(long)skb->data_end;
>   
>   	if (c + 5 + offset < data_end)
> -		memcpy(c + offset, "PASS", 4);
> +		__builtin_memcpy(c + offset, "PASS", 4);
>   }
>   
>   SEC("sk_skb/stream_verdict")
> diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
> index 548660e299a5..03ba4eb0aa21 100644
> --- a/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
> +++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop1.c
> @@ -2,7 +2,6 @@
>   // Copyright (c) 2019 Facebook
>   
>   #include <stdint.h>
> -#include <string.h>
>   
>   #include <linux/stddef.h>
>   #include <linux/bpf.h>
> @@ -24,7 +23,7 @@ static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
>   	char name[sizeof(tcp_mem_name)];
>   	int ret;
>   
> -	memset(name, 0, sizeof(name));
> +	__builtin_memset(name, 0, sizeof(name));
>   	ret = bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
>   	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
>   		return 0;
> diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
> index 81249d119a8b..f421468d893d 100644
> --- a/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
> +++ b/tools/testing/selftests/bpf/progs/test_sysctl_loop2.c
> @@ -2,7 +2,6 @@
>   // Copyright (c) 2019 Facebook
>   
>   #include <stdint.h>
> -#include <string.h>
>   
>   #include <linux/stddef.h>
>   #include <linux/bpf.h>
> @@ -24,7 +23,7 @@ static __attribute__((noinline)) int is_tcp_mem(struct bpf_sysctl *ctx)
>   	char name[sizeof(tcp_mem_name)];
>   	int ret;
>   
> -	memset(name, 0, sizeof(name));
> +	__builtin_memset(name, 0, sizeof(name));
>   	ret = bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
>   	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
>   		return 0;
> diff --git a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
> index bbdd08764789..b434d6231e79 100644
> --- a/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
> +++ b/tools/testing/selftests/bpf/progs/test_sysctl_prog.c
> @@ -2,7 +2,6 @@
>   // Copyright (c) 2019 Facebook
>   
>   #include <stdint.h>
> -#include <string.h>
>   
>   #include <linux/stddef.h>
>   #include <linux/bpf.h>
> @@ -25,7 +24,7 @@ static __always_inline int is_tcp_mem(struct bpf_sysctl *ctx)
>   	char name[sizeof(tcp_mem_name)];
>   	int ret;
>   
> -	memset(name, 0, sizeof(name));
> +	__builtin_memset(name, 0, sizeof(name));
>   	ret = bpf_sysctl_get_name(ctx, name, sizeof(name), 0);
>   	if (ret < 0 || ret != sizeof(tcp_mem_name) - 1)
>   		return 0;
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_estats.c b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
> index e2ae049c2f85..25b60731af50 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcp_estats.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
> @@ -31,7 +31,6 @@
>    * blocks "_tcp_send_active_reset" and "LBB0_3", and used in "LBB0_4".
>    * The verifier should be able to handle such code patterns.
>    */
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/ipv6.h>
>   #include <linux/version.h>
> @@ -239,7 +238,7 @@ static __always_inline void send_basic_event(struct sock *sk,
>   	struct tcp_estats_basic_event ev;
>   	__u32 key = bpf_get_prandom_u32();
>   
> -	memset(&ev, 0, sizeof(ev));
> +	__builtin_memset(&ev, 0, sizeof(ev));
>   	tcp_estats_init(sk, &ev.event, &ev.conn_id, type);
>   	bpf_map_update_elem(&ev_record_map, &key, &ev, BPF_ANY);
>   }
> diff --git a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
> index ef00d38b0a8d..495dec0d68e6 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <stddef.h>
> -#include <string.h>
>   #include <netinet/in.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing/selftests/bpf/progs/test_xdp.c
> index 8caf58be5818..dfa74aa5a1d6 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp.c
> @@ -5,7 +5,6 @@
>    * License as published by the Free Software Foundation.
>    */
>   #include <stddef.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_packet.h>
> @@ -71,8 +70,8 @@ static __always_inline void set_ethhdr(struct ethhdr *new_eth,
>   				       const struct iptnl_info *tnl,
>   				       __be16 h_proto)
>   {
> -	memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
> -	memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
> +	__builtin_memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
> +	__builtin_memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
>   	new_eth->h_proto = h_proto;
>   }
>   
> @@ -170,7 +169,7 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
>   
>   	vip.protocol = ip6h->nexthdr;
>   	vip.family = AF_INET6;
> -	memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
> +	__builtin_memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
>   	vip.dport = dport;
>   	payload_len = ip6h->payload_len;
>   
> @@ -197,12 +196,12 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
>   
>   	ip6h->version = 6;
>   	ip6h->priority = 0;
> -	memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
> +	__builtin_memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
>   	ip6h->payload_len = bpf_htons(bpf_ntohs(payload_len) + sizeof(*ip6h));
>   	ip6h->nexthdr = IPPROTO_IPV6;
>   	ip6h->hop_limit = 8;
> -	memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
> -	memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
> +	__builtin_memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
> +	__builtin_memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
>   
>   	count_tx(vip.protocol);
>   
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> index 67a77944ef29..9c08e76eab33 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2022 Meta */
>   #include <stddef.h>
> -#include <string.h>
>   #include <stdbool.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
> @@ -69,8 +68,8 @@ static __always_inline void set_ethhdr(struct ethhdr *new_eth,
>   				       const struct iptnl_info *tnl,
>   				       __be16 h_proto)
>   {
> -	memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
> -	memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
> +	__builtin_memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
> +	__builtin_memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
>   	new_eth->h_proto = h_proto;
>   }
>   
> @@ -188,7 +187,7 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_dynptr *xd
>   
>   	vip.protocol = ip6h->nexthdr;
>   	vip.family = AF_INET6;
> -	memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
> +	__builtin_memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
>   	vip.dport = dport;
>   	payload_len = ip6h->payload_len;
>   
> @@ -215,12 +214,12 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_dynptr *xd
>   
>   	ip6h->version = 6;
>   	ip6h->priority = 0;
> -	memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
> +	__builtin_memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
>   	ip6h->payload_len = bpf_htons(bpf_ntohs(payload_len) + ipv6hdr_sz);
>   	ip6h->nexthdr = IPPROTO_IPV6;
>   	ip6h->hop_limit = 8;
> -	memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
> -	memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
> +	__builtin_memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
> +	__builtin_memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
>   
>   	count_tx(vip.protocol);
>   
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> index 93267a68825b..e1e867ee280f 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   // Copyright (c) 2019 Facebook
>   #include <stddef.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_packet.h>
> @@ -67,8 +66,8 @@ static __always_inline void set_ethhdr(struct ethhdr *new_eth,
>   				       const struct iptnl_info *tnl,
>   				       __be16 h_proto)
>   {
> -	memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
> -	memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
> +	__builtin_memcpy(new_eth->h_source, old_eth->h_dest, sizeof(new_eth->h_source));
> +	__builtin_memcpy(new_eth->h_dest, tnl->dmac, sizeof(new_eth->h_dest));
>   	new_eth->h_proto = h_proto;
>   }
>   
> @@ -166,7 +165,7 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
>   
>   	vip.protocol = ip6h->nexthdr;
>   	vip.family = AF_INET6;
> -	memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
> +	__builtin_memcpy(vip.daddr.v6, ip6h->daddr.s6_addr32, sizeof(vip.daddr));
>   	vip.dport = dport;
>   	payload_len = ip6h->payload_len;
>   
> @@ -193,12 +192,12 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
>   
>   	ip6h->version = 6;
>   	ip6h->priority = 0;
> -	memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
> +	__builtin_memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
>   	ip6h->payload_len = bpf_htons(bpf_ntohs(payload_len) + sizeof(*ip6h));
>   	ip6h->nexthdr = IPPROTO_IPV6;
>   	ip6h->hop_limit = 8;
> -	memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
> -	memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
> +	__builtin_memcpy(ip6h->saddr.s6_addr32, tnl->saddr.v6, sizeof(tnl->saddr.v6));
> +	__builtin_memcpy(ip6h->daddr.s6_addr32, tnl->daddr.v6, sizeof(tnl->daddr.v6));
>   
>   	count_tx(vip.protocol);
>   
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> index fad94e41cef9..d022100ed08b 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> @@ -2,7 +2,6 @@
>   // Copyright (c) 2017 Facebook
>   #include <stddef.h>
>   #include <stdbool.h>
> -#include <string.h>
>   #include <linux/pkt_cls.h>
>   #include <linux/bpf.h>
>   #include <linux/in.h>
> @@ -297,12 +296,12 @@ bool encap_v6(struct xdp_md *xdp, struct ctl_value *cval,
>   	if (new_eth + 1 > data_end ||
>   	    old_eth + 1 > data_end || ip6h + 1 > data_end)
>   		return false;
> -	memcpy(new_eth->eth_dest, cval->mac, 6);
> -	memcpy(new_eth->eth_source, old_eth->eth_dest, 6);
> +	__builtin_memcpy(new_eth->eth_dest, cval->mac, 6);
> +	__builtin_memcpy(new_eth->eth_source, old_eth->eth_dest, 6);
>   	new_eth->eth_proto = 56710;
>   	ip6h->version = 6;
>   	ip6h->priority = 0;
> -	memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
> +	__builtin_memset(ip6h->flow_lbl, 0, sizeof(ip6h->flow_lbl));
>   
>   	ip6h->nexthdr = IPPROTO_IPV6;
>   	ip_suffix = pckt->flow.srcv6[3] ^ pckt->flow.port16[0];
> @@ -314,7 +313,7 @@ bool encap_v6(struct xdp_md *xdp, struct ctl_value *cval,
>   	ip6h->saddr.in6_u.u6_addr32[1] = 2;
>   	ip6h->saddr.in6_u.u6_addr32[2] = 3;
>   	ip6h->saddr.in6_u.u6_addr32[3] = ip_suffix;
> -	memcpy(ip6h->daddr.in6_u.u6_addr32, dst->dstv6, 16);
> +	__builtin_memcpy(ip6h->daddr.in6_u.u6_addr32, dst->dstv6, 16);
>   	return true;
>   }
>   
> @@ -353,8 +352,8 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
>   	if (new_eth + 1 > data_end ||
>   	    old_eth + 1 > data_end || iph + 1 > data_end)
>   		return false;
> -	memcpy(new_eth->eth_dest, cval->mac, 6);
> -	memcpy(new_eth->eth_source, old_eth->eth_dest, 6);
> +	__builtin_memcpy(new_eth->eth_dest, cval->mac, 6);
> +	__builtin_memcpy(new_eth->eth_source, old_eth->eth_dest, 6);
>   	new_eth->eth_proto = 8;
>   	iph->version = 4;
>   	iph->ihl = 5;
> @@ -391,9 +390,9 @@ int swap_mac_and_send(void *data, void *data_end)
>   	struct eth_hdr *eth;
>   
>   	eth = data;
> -	memcpy(tmp_mac, eth->eth_source, 6);
> -	memcpy(eth->eth_source, eth->eth_dest, 6);
> -	memcpy(eth->eth_dest, tmp_mac, 6);
> +	__builtin_memcpy(tmp_mac, eth->eth_source, 6);
> +	__builtin_memcpy(eth->eth_source, eth->eth_dest, 6);
> +	__builtin_memcpy(eth->eth_dest, tmp_mac, 6);
>   	return XDP_TX;
>   }
>   
> @@ -447,9 +446,9 @@ int send_icmp6_reply(void *data, void *data_end)
>   	icmp_hdr->icmp6_type = 129;
>   	icmp_hdr->icmp6_cksum -= 0x0001;
>   	ip6h->hop_limit = 4;
> -	memcpy(tmp_addr, ip6h->saddr.in6_u.u6_addr32, 16);
> -	memcpy(ip6h->saddr.in6_u.u6_addr32, ip6h->daddr.in6_u.u6_addr32, 16);
> -	memcpy(ip6h->daddr.in6_u.u6_addr32, tmp_addr, 16);
> +	__builtin_memcpy(tmp_addr, ip6h->saddr.in6_u.u6_addr32, 16);
> +	__builtin_memcpy(ip6h->saddr.in6_u.u6_addr32, ip6h->daddr.in6_u.u6_addr32, 16);
> +	__builtin_memcpy(ip6h->daddr.in6_u.u6_addr32, tmp_addr, 16);
>   	return swap_mac_and_send(data, data_end);
>   }
>   
> @@ -473,8 +472,8 @@ int parse_icmpv6(void *data, void *data_end, __u64 off,
>   		return XDP_DROP;
>   	pckt->flow.proto = ip6h->nexthdr;
>   	pckt->flags |= (1 << 0);
> -	memcpy(pckt->flow.srcv6, ip6h->daddr.in6_u.u6_addr32, 16);
> -	memcpy(pckt->flow.dstv6, ip6h->saddr.in6_u.u6_addr32, 16);
> +	__builtin_memcpy(pckt->flow.srcv6, ip6h->daddr.in6_u.u6_addr32, 16);
> +	__builtin_memcpy(pckt->flow.dstv6, ip6h->saddr.in6_u.u6_addr32, 16);
>   	return -1;
>   }
>   
> @@ -532,7 +531,7 @@ static bool get_packet_dst(struct real_definition **real,
>   		hash_16bytes = 1;
>   	if (vip_info->flags & (1 << 3)) {
>   		pckt->flow.port16[0] = pckt->flow.port16[1];
> -		memset(pckt->flow.srcv6, 0, 16);
> +		__builtin_memset(pckt->flow.srcv6, 0, 16);
>   	}
>   	hash = get_packet_hash(pckt, hash_16bytes);
>   	if (hash != 0x358459b7 /* jhash of ipv4 packet */  &&
> @@ -623,8 +622,8 @@ static int process_l3_headers_v6(struct packet_description *pckt,
>   		if (action >= 0)
>   			return action;
>   	} else {
> -		memcpy(pckt->flow.srcv6, ip6h->saddr.in6_u.u6_addr32, 16);
> -		memcpy(pckt->flow.dstv6, ip6h->daddr.in6_u.u6_addr32, 16);
> +		__builtin_memcpy(pckt->flow.srcv6, ip6h->saddr.in6_u.u6_addr32, 16);
> +		__builtin_memcpy(pckt->flow.dstv6, ip6h->daddr.in6_u.u6_addr32, 16);
>   	}
>   	return -1;
>   }
> @@ -702,7 +701,7 @@ static int process_packet(void *data, __u64 off, void *data_end,
>   	}
>   
>   	if (is_ipv6)
> -		memcpy(vip.vipv6, pckt.flow.dstv6, 16);
> +		__builtin_memcpy(vip.vipv6, pckt.flow.dstv6, 16);
>   	else
>   		vip.vip = pckt.flow.dst;
>   	vip.port = pckt.flow.port16[1];
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
> index a80cc5f2f4f2..4df385738d2c 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
> @@ -15,7 +15,6 @@
>    */
>   #include <stddef.h>
>   #include <stdbool.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_vlan.h>
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall.c b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
> index e08c31669e5a..623bc177f716 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
> @@ -1,7 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include "vmlinux.h"
>   #include <bpf/bpf_helpers.h>
> -#include <string.h>
>   
>   struct pt_regs regs;
>   
> diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> index 915d38591bf6..6692b13de6ab 100644
> --- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> @@ -3,7 +3,6 @@
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_tracing.h>
>   #include <bpf/usdt.bpf.h>
> -#include <string.h>
>   
>   struct pt_regs regs;
>   
> diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> index d21d32f6a676..e69d3deb6e56 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subprog_precision.c
> @@ -2,7 +2,6 @@
>   /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>   
>   #include <errno.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <bpf/bpf_helpers.h>
>   #include "bpf_misc.h"
> diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
> index bc2945ed8a80..d6c91fc201e9 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #define KBUILD_MODNAME "foo"
> -#include <string.h>
>   #include <linux/in.h>
>   #include <linux/if_ether.h>
>   #include <linux/if_packet.h>
> diff --git a/tools/testing/selftests/bpf/progs/xdping_kern.c b/tools/testing/selftests/bpf/progs/xdping_kern.c
> index 44e2b0ef23ae..394998bdb8c4 100644
> --- a/tools/testing/selftests/bpf/progs/xdping_kern.c
> +++ b/tools/testing/selftests/bpf/progs/xdping_kern.c
> @@ -3,7 +3,6 @@
>   
>   #define KBUILD_MODNAME "foo"
>   #include <stddef.h>
> -#include <string.h>
>   #include <linux/bpf.h>
>   #include <linux/icmp.h>
>   #include <linux/in.h>


