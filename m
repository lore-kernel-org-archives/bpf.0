Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191925;
	b=iN2foC6YWJE4GmGcEyt1fdJraDTi93J36AyB7tR9ekD7rn/4Uyew7YHPZ2C8FvsFeMdM
	 Nk68rv7RcPXLB/KgDr6akLCU0kp+MIxK+/TX4CFdu4GyjPUUfykODOnw9QFmHfTNDpWKY
	 XV18rOUliL8rL/AE6OusWh2TFhw29fWjXS29m1gr4r21rnw3sSsTpkJFT5FuPtUguQuAW
	 MYlfcEEgMLSpCzw+a2A3NT3+mnXU94mJfBu0b4xfWcyIsh2HAaE7y1Io920+u9E4xE2Px
	 KXNKC5wEcXKZSiI7E+p7yWf6KcSX+/l/wJ6cFUigqc3beEPsumh+hd2XcJZpnH04sfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191925;
	h=DMARC-Filter:DKIM-Signature:Message-Id:Content-Type:Subject:
	 X-Original-From:Cc:Content-Transfer-Encoding:X-Mailer:References:
	 In-Reply-To:Received:To:From:Date:Mime-Version:X-Lms-Return-Path;
	bh=ruJcFMq+T+PYshOYgwUo5k4oqvbhd5wL7JLOkO0njoo=;
	b=TtCuJRfBvKZdT98xjj5r04/DIXOBLhvAL7uYScFFdXPpKXleuNki5uMf+3onEFj6crHY
	 SE9cehBTtHRY1gR2lTdxkWcqWwUkv/2VH1uzoU1NHc6t5BEDYTYvgc+/rgtc9te/8D3gB
	 4+IDS47dgVzZHgC3roXxgwURmmfGpHCoDmbQ1YjhaPOxV66b27wQQI2Tsm09YwIGZwoJz
	 hHXPIOFnXWTHIo1+qevrK4/y6fvI8xLEH/UcNSoIj7vOIPK9Sf/w+Ok+Y4aR0iP+s10bn
	 O49bB11GSh1gC5LmGuj62bsWjJXy/UI82DiHXmFoNqUj89PRCb3UCxMuznTyXzPXh4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=insta360.com;
	spf=pass smtp.mailfrom=insta360.com;
	dkim=pass header.d=insta360.com header.i=@insta360.com header.a=rsa-sha256 header.s=feishu2606151854 header.b=q2WpuNEn;
	arc=none smtp.remote-ip=209.127.231.30
Received: from va-2-30.ptr.blmpb.com (va-2-30.ptr.blmpb.com [209.127.231.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69D606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 12:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F69D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=insta360.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=insta360.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=insta360.com header.i=@insta360.com header.a=rsa-sha256 header.s=feishu2606151854 header.b=q2WpuNEn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2606151854; d=insta360.com; t=1793191917; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ruJcFMq+T+PYshOYgwUo5k4oqvbhd5wL7JLOkO0njoo=;
 b=q2WpuNEnardC3QCL0XlIgUTNG849iFNdxmtXxDCnkbehfuy6pzCMr+l/asWPKvhvdcTN+o
 /2xQOuIcOC+Vkp2bjqVy2OsE/YCKYVBOBDFO0bC5o9zFOPbfnsA4w8OaoS11F3tjW4o6Tw
 otJYc68qhRLqapRdTBYWAFY902QG6nhtZY2fh2xPN7M49yrSUL8hEty2JwdOKV03DRsv3U
 pkDiAg/BRwn8+mJntQstJUX+WOToWsLaOEiL88zBda/KvG4JU1o/9nfwZJPuDtjLzMf29A
 RefFgTFIc6ioaglfhzkI0qyTmihOIjlwPO8kBhls528VNMn1CqrjqcRxiA2aCQ==
Message-Id: <20261028125148.1348-1-yangsongsen@insta360.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH bpf-next] bpf: Fix suspicious RCU usage for sleepable bpf_get_stack()
X-Original-From: Songsen Yang <yangsongsen@insta360.com>
Cc: <song@kernel.org>, <jolsa@kernel.org>, <ihor.solodrai@linux.dev>, 
	<kpsingh@kernel.org>, <matt@bobrowski.net>, <ast@kernel.org>, 
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>, 
	<memxor@gmail.com>, <martin.lau@linux.dev>, <yonghong.song@linux.dev>, 
	<emil@etsalapatis.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>, 
	<mathieu.desnoyers@efficios.com>, <bpf@vger.kernel.org>, 
	<linux-trace-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.53.0.windows.2
References: <20261028093548.790977-1-yangfeng59949@163.com>
In-Reply-To: <20261028093548.790977-1-yangfeng59949@163.com>
Received: from DT-9806 ([61.241.19.90]) by smtp.feishu.cn with ESMTPS; Wed, 28 Oct 2026 20:51:54 +0800
To: "Feng Yang" <yangfeng59949@163.com>
From: "Songsen Yang" <yangsongsen@insta360.com>
Date: Wed, 28 Oct 2026 20:51:47 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26ae1efeb+57b5aa+vger.kernel.org+yangsongsen@insta360.com>

On Wed, Oct 28, 2026 at 05:35:48PM +0800, Feng Yang wrote:
> Sleepable BPF programs run under rcu_read_lock_trace(), not classic RCU.
> bpf_get_stack() relies on the caller holding a classic RCU read lock:
> get_perf_callchain() -> get_callchain_entry() dereferences
> callchain_cpus_entries, and the returned entry is read until
> callchain_store().  __bpf_get_stack() takes that lock only for the
> sleepable variant, i.e. when may_fault is true.

Hi Feng,

I hit the same root cause independently via syzbot and sent a fix a
few hours after yours, without having seen this patch -- sorry for the
overlap:

  https://lore.kernel.org/bpf/20261028121859.994-1-yangsongsen@insta360.com/

It also covers the syzbot report for BPF_PROG_TYPE_SYSCALL programs
(always sleepable, run via bpf_prog_test_run_syscall() under
rcu_read_lock_trace() only), which reach bpf_get_stack_raw_tp() through
tracing_prog_func_proto():

  https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1

The approach is different: instead of routing sleepable programs to new
sleepable protos, it simply takes rcu_read_lock() unconditionally in
__bpf_get_stack() around get_perf_callchain()/callchain_store(), as
Andrii suggested earlier that an extra nested rcu_read_lock() is
harmless:

  https://lore.kernel.org/all/CAEf4BzYN33yQhO-tsF8pUWDMZoiLAXkV+Z1oP6fJkByocYcjpw@mail.gmail.com/

That is a 3+/6- change in kernel/bpf/stackmap.c, it covers every caller
of __bpf_get_stack() (including the tracepoint, raw_tp, iter and syscall
cases listed above), and since no helper gains might_sleep it does not
hold the per-CPU bpf_raw_tp_regs slot across a possible sleep in
callchain_finalize(), which is the issue the Sashiko review raised here.

It does not do what your patch additionally does, i.e. allow
BPF_F_USER_BUILD_ID to fault in build IDs from these program types.

I'm happy to go with whichever the maintainers prefer, or to drop mine.

Thanks,
Songsen
