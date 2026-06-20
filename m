Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BBD33F58C
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781961930; cv=none; b=DNHQhm+avajd7ZD7OTfqGAQmsLvNoydE1q1DfAgsxp+z3ww9NtUthtp+UGMvVQBCL/GGSahu7WKIPUEmZ/VnmZgyA1hB/DNzjq/ps4dEB2ez3tIFas5xwdnmpqAm3TEh4bJv25+n6ZB4sUraCr5Mk9raqM7slv2PH2cXVm82S9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781961930; c=relaxed/simple;
	bh=Asuxszf/bAwC9ualoko64JrOS2xrhOR5jGL/gDpMV/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jv2Ata/7iRD4C2YYPHzEfEzseUOGQAxtKtq4gIf97lnPMl3jUKNOn8c20pOXgq1cUAhIiB6bp6PzA/LYUPAwNfmF5yDjcs9zqrBqPx+xaowEiiOzOFM0F//FyPHKgxsCLyEWl4n6QE4FBZUZIraXbEmHoW2wxtPOjLfZdpD90TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jHcV0dZI; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jHcV0dZI"
Message-ID: <6f34efb8-c7e7-490c-bef1-c4c7da9a706e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781961915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afi4i6B2BdOEvMjupBy9U4sefc34AGzac9BLN7m560Q=;
	b=jHcV0dZIrmogmx86GXkj6i17E67BCMvSa6cyRpNc4KlXMAYX27kdbi6PHog1WPauMz7Rdu
	UtwvBrU2Dpc2yPJZcmAnxTJJlSu2cQN4jAh3qgdD/J6lTov9gVmYNVgtIBvQGSBpS5Pon1
	f+/56RKU3j9aFs3d2/DvXynaIjF54gc=
Date: Sat, 20 Jun 2026 21:24:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf, sockmap: disallow update and delete from tc,
 xdp and flow_dissector
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Lorenz Bauer <lmb@cloudflare.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260620034632.2308-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260620034632.2308-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/20/26 11:46 AM, Sechang Lim wrote:
> sock_map_update_common() and __sock_map_delete() hold stab->lock and call
> sock_map_unref() -> sock_map_del_link(), which takes sk_callback_lock for
> write. That gives the order stab->lock -> sk_callback_lock.
>
> The reverse order comes from the SK_SKB stream parser.
> sk_psock_strp_data_ready() holds sk_callback_lock for read, and after the
> verdict tcp_bpf_strp_read_sock() acks the consumed data inline via
> __tcp_cleanup_rbuf(). The ACK goes out egress, where a sched_cls program
> deletes from the sockmap and takes stab->lock:
>
>    WARNING: possible circular locking dependency detected
>    7.1.0-rc6 Not tainted
>    ------------------------------------------------------
>    syz.9.8824 is trying to acquire lock:
>    (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
>    but task is already holding lock:
>    (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173
>
>    -> #1 (clock-AF_INET){++.-}-{3:3}:
>           _raw_write_lock_bh
>           sock_map_del_link net/core/sock_map.c:167
>           sock_map_unref net/core/sock_map.c:184
>           sock_map_update_common net/core/sock_map.c:509
>           sock_map_update_elem_sys net/core/sock_map.c:588
>           map_update_elem kernel/bpf/syscall.c:1805
>
>    -> #0 (&stab->lock){+.-.}-{3:3}:
>           _raw_spin_lock_bh
>           __sock_map_delete net/core/sock_map.c:421
>           sock_map_delete_elem net/core/sock_map.c:452
>           bpf_prog_06044d24140080b6
>           tcx_run net/core/dev.c:4451
>           sch_handle_egress net/core/dev.c:4541
>           __dev_queue_xmit net/core/dev.c:4808
>           ...
>           tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>           strp_data_ready net/strparser/strparser.c:402
>           sk_psock_strp_data_ready net/core/skmsg.c:1174
>           tcp_data_queue net/ipv4/tcp_input.c:5661
>
>    Possible unsafe locking scenario:
>
>           CPU0                    CPU1
>           ----                    ----
>      rlock(clock-AF_INET);
>                                   lock(&stab->lock);
>                                   lock(clock-AF_INET);
>      lock(&stab->lock);
>
>     *** DEADLOCK ***
>
> A tc, xdp or flow_dissector program has no reason to update or delete a
> sockmap, and redirect does not go through here. Drop them from
> may_update_sockmap() so the verifier rejects it. It also closes the
> matching sockhash inversion.
>
> Fixes: 0126240f448d ("bpf: sockmap: Allow update from BPF")
> Suggested-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v2:
>   - reject sockmap update/delete from tc, xdp and flow_dissector (John
>     Fastabend)
>   - fix the changelog (Jiayuan Chen)
>
> v1:
>   - https://lore.kernel.org/all/20260616091153.2966617-1-rhkrqnwk98@gmail.com/
>
>   kernel/bpf/verifier.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4..94d225521b5a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8766,11 +8766,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
>   			return true;
>   		break;
>   	case BPF_PROG_TYPE_SOCKET_FILTER:
> -	case BPF_PROG_TYPE_SCHED_CLS:
> -	case BPF_PROG_TYPE_SCHED_ACT:
> -	case BPF_PROG_TYPE_XDP:
>   	case BPF_PROG_TYPE_SK_REUSEPORT:
> -	case BPF_PROG_TYPE_FLOW_DISSECTOR:
>   	case BPF_PROG_TYPE_SK_LOOKUP:
>   		return true;
>   	default:

CI failed.

https://github.com/kernel-patches/bpf/actions/runs/27859622337/job/82454035306

Please drop or change such trigger.


Also, please drop Fixes tag and target to bpf-next for the same reason 
in you another thread.


Nit:

You can also manually fork and create pull request against

https://github.com/kernel-patches/bpf/ to run full test to run the full

test and make sure all tests pass before you send patch.

