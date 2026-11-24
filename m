Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546756;
	b=yta6u98wXEHPFWh//NQ/D2JDFHuvk9aiTqeZzBcGdZAKsE2vCRX8uYnDcBCfaz2IyNTX
	 ek2XK3IAD6SbsqBln+SB+ULNQa2rUHsy7FlA7sAgbh7kmFhRrV2NE0fQyVu9+9FpcEsyr
	 Lx1r10R0WF4ham7v+YyvRiIbK10ztn3WMldSsSGQjf9re7+wMpbCjScnRYuDqKuGYtTlG
	 701R9vJXHV5vJVmaagtdrzC2IKFkTRgy3hkhoU6q5oppbnPoVRDdYoG0kop/WiDAsRNW/
	 h4NsDUcBG3XJEPP4vDJo2WvY9Psn5jabL/u5mbvy+a4/+HBxypQpTh8pvtLYOHiD7gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546756;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1NRyrHRc5ALrYxpIJVBBawzLs44TfEtpu7WHQ/Gjwwg=;
	b=34JHGJXOn8EUcypd1IfIa6WC+LLWG4pAkvhQBzyS36xKqkxePxf2tX7Myy+BRpZR6kss
	 hj86dH7dqT63wQU4jo4l2QKXA//XZPko0tqgErrphrgn1e6XNIWSuHxx4SH1Wp6OuEU0W
	 Wyl3p4PL55uTCSE0cbXamcr8qj8XWvpCbP3KfuFWsI5gsVxzhAxVuCvKXQrnEedKevK3H
	 pfPVrtiv8qMKJFMvau6ZKcpnLdU8L5MCLe0Jl/MU3FZ4qrk5EIAnuYV9hRHs0wrGkei+A
	 YNHMs04mhI1lhYBd8XIxbU1mjk1LcxTuQhJPxNEH/ukhFOqxQIxxnYiXRCUjsTCmv7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tYYKc2Zv;
	arc=none smtp.remote-ip=91.218.175.84
Received: from mta0.migadu.com (out-84.mta0.migadu.com [91.218.175.84])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A55606A680
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 18:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82A55606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tYYKc2Zv
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oHE0hkASlUBhA102XRimloT7LRv/m9E1Ay8jSrCzsRU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795546752; v=1; x=1796151552;
 b=tYYKc2Zv6fWQ4kIgfFbW/rDyp+nJ+Yz6dJdBKVouxawcs1rrsfcjquM0h2I1dxklsvzvP+Jf
 YmqQQDHepvoyUdqcU2PVtHfR8FhXYwjWtrD26Gkj9gY1t/Njicx45h5uttolbDwdcE0MbkkdWeG
 esJtDJY72nfVywweh/zfhxcs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 93d802ea5e843d77;
	Tue, 24 Nov 2026 18:59:12 +0000
X-Mizu-Trace-ID: 93d802ea5e843d77
X-Migadu-Flow: FLOW_OUT
Date: Tue, 24 Nov 2026 18:59:12 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: rhkrqnwk98@gmail.com
CC: boqun@kernel.org, bpf@vger.kernel.org, frederic@kernel.org,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
Subject: Re: [PATCH] rcu: Mark rcu_read_unlock_special() notrace
In-Reply-To: <20261124185659.1370644-1-rhkrqnwk98@gmail.com>
Message-ID: <B9936C09-18A8-4C0A-B502-DBDB0B93FDE4@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 24 November 2026 18:56:51 GMT, Sechang Lim <rhkrqnwk98@gmail.com> wrote:
>The BPF trampoline calls rcu_read_unlock() on its exit path. If the
>task was preempted in the RCU read-side critical section, this ends up
>in rcu_read_unlock_special(). When a BPF fentry or fexit program is
>attached to rcu_read_unlock_special() itself, the trampoline runs again
>before ->rcu_read_unlock_special is cleared, calls rcu_read_unlock()
>again, and recurses until the stack overflows:
>
>  BUG: TASK stack guard page was hit at ffffc90001657ff8
>  ...
>   bpf_trampoline_6442575622+0x5e/0xac
>   rcu_read_unlock_special+0x5/0x490
>   __rcu_read_unlock+0x9c/0x120
>   rcu_read_unlock_migrate+0x93/0x220
>   bpf_trampoline_6442575622+0x5e/0xac
>   rcu_read_unlock_special+0x5/0x490
>   ...
>
>Mark rcu_read_unlock_special() notrace.

Hmm.. this seems to be edge case, but no big deal.

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>


>
>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>---
> kernel/rcu/tree_plugin.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>index ae5d21bae7bc..a887ab69f486 100644
>--- a/kernel/rcu/tree_plugin.h
>+++ b/kernel/rcu/tree_plugin.h
>@@ -746,7 +746,7 @@ static bool rcu_unlock_needs_exp_handling(struct task_struct *t,
>  * notify RCU core processing or task having blocked during the RCU
>  * read-side critical section.
>  */
>-static void rcu_read_unlock_special(struct task_struct *t)
>+static notrace void rcu_read_unlock_special(struct task_struct *t)
> {
> 	unsigned long flags;
> 	bool irqs_were_disabled;
>

--- Thanks!
