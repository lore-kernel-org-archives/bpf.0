Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51614F93A8
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903645; cv=none; b=QLo//eeRh2TIBil+uLWyoQK9ydA0I+ZLA6VyVz6J6RxK1ioGx6LqdDqy56HdszUQUYge1wZs+/+LYCFD/y2OeZLENRp19RWTW1P03xwmHfqgGgrJNfcXRlzVdARsLH8BRLrPIKtxbywCh3wDdAP4i3HYVk8FgOdf8E/jIiMkEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903645; c=relaxed/simple;
	bh=szBgCACLeSSGHqL8QXGr2Q1RAZZiPFg4hSdwlSmucMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl1YuMOmBwrqVoGsCxZzNQcJXaWAiykL4aC0g5jMF5yqwaPvor1LBj3HSjqL6YI988nsXa9+Bzj8Lw9D9iRWZQXKIqJmMCdZs+MB9farxklXQoGphND+uuWKT4pSXSYVSe07bp/0kTrgCWxnn4PnajBpuw9H5lzR5MvfoiS7y6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j3yFM0ldBzMlhM;
	Tue, 13 Oct 2026 17:00:39 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=listout@listout.xyz
Date: Tue, 13 Oct 2026 20:30:34 +0530
From: Brahmajit Das <listout@listout.xyz>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Add tests for memcg kfuncs
Message-ID: <as5HRMoJYBdchYN-@neptune>
References: <20261013143853.1379307-1-listout@listout.xyz>
 <sashiko-outbox-169941@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-169941@kernel.org>
X-Rspamd-Queue-Id: 4j3yFM0ldBzMlhM

On 13.10.2026 14:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: missing negative bounds checks in memcg event kfuncs allow OOB reads
> --
> 
> commit fbb677e1e6cb5f158ac286d23535b8f06e966597
> Author: Brahmajit Das <bdas@suse.de>
> 
> selftests/bpf: Add tests for memcg kfuncs
> 
> The existing cgroup_iter_memcg test covers bpf_get_mem_cgroup(),
> bpf_put_mem_cgroup(), bpf_mem_cgroup_flush_stats(),
> bpf_mem_cgroup_page_state() and bpf_mem_cgroup_vm_events(), but
> bpf_get_root_mem_cgroup(), bpf_mem_cgroup_usage(),
> bpf_mem_cgroup_memory_events() and bpf_proactive_reclaim() have no
> selftest coverage.
> 
> Add a memcg_kfuncs test that drives them from syscall programs against
> a test cgroup.
> 
> > diff --git a/tools/testing/selftests/bpf/progs/memcg_kfuncs.c b/tools/testing/selftests/bpf/progs/memcg_kfuncs.c
> > new file mode 100644
> > index 0000000000000..3c7866730aa0c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/memcg_kfuncs.c
> > @@ -0,0 +1,101 @@
> 
> [ ... ]
> 
> > +SEC("syscall")
> > +int memcg_query(void *ctx)
> > +{
> > +	struct mem_cgroup *memcg;
> > +
> > +	memcg = memcg_from_cgid();
> > +	if (!memcg)
> > +		return 1;
> 
> [ ... ]
> 
> > +	/* Out-of-range indices must be rejected with (unsigned long)-1. */
> > +	bad_memory_event = bpf_mem_cgroup_memory_events(memcg,
> > +		bpf_core_enum_value(enum memcg_memory_event, MEMCG_NR_MEMORY_EVENTS));
> > +	bad_vm_event = bpf_mem_cgroup_vm_events(memcg,
> > +		bpf_core_enum_value(enum vm_event_item, NR_VM_EVENT_ITEMS));
> > +	bad_page_state = bpf_mem_cgroup_page_state(memcg, -1);
> 
> [Severity: High]
> Does this test expose an incomplete bounds check in the underlying kfuncs?
> 
> The BPF verifier treats enum arguments as signed scalars and does not
> restrict them to valid enum ranges, so BPF programs can pass negative values.
> 
> In mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events(), the signed check
> event >= MEMCG_NR_MEMORY_EVENTS is bypassed by negative values like -1.
> The function then indexes memcg->memory_events[event], leading to an
> out-of-bounds kernel memory read.
> 
> Similarly, bpf_mem_cgroup_vm_events() delegates to memcg_vm_event_item_valid()
> in mm/memcontrol.c, which checks idx >= NR_VM_EVENT_ITEMS. A negative index
> bypasses this and accesses mem_cgroup_events_index[idx] out of bounds.
> 
> Could malicious or unprivileged BPF programs exploit this to read
> out-of-bounds kernel memory?
> 
> > +
> > +	bpf_put_mem_cgroup(memcg);
> > +	return 0;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261013143853.1379307-1-listout@listout.xyz?part=1

I believe this is a false positive. enum memcg_memory_event and enum
vm_event_item have no negative enumerators, so their underlying type is
unsigned int and both bounds checks are unsigned comparisons. A negative
value passed from BPF is seen as a large unsigned index and rejected
with (unsigned long)-1.

The generated code (x86_64, bpf-next) confirms it:

  bpf_mem_cgroup_memory_events:
      cmp    $0x9,%esi
      ja     <return -1>

  memcg_vm_event_item_valid:
      cmp    $0x67,%edi
      ja     <return false>

Both use ja (unsigned), not jg. bpf_mem_cgroup_page_state() already
casts to u32 explicitly, and the test passes it -1.

That said, it is a cheap case to cover, so v2 will also pass -1 to
bpf_mem_cgroup_memory_events() and bpf_mem_cgroup_vm_events() and check
that both return (unsigned long)-1. 

-- 
Regards,
listout
