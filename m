Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145564;
	b=F6OV7NwpZJgqNQygijBpDhZDz3F0Qo8QORCLAFrjSsFkiM+2nk5BfM8OV2C8lvo6+9V8
	 DY3aITLGJ/uKyyq75hp0IxdZjrxdIWFXzct+EfIyQ313adNkb8LQ/uoKhtTBFLHhnXB7s
	 WaJ1U8plwpj7PMEsPLuhF15v/ZkSA60E79opiGaST5scX+NCg6zFARkJRPw2rHoRvHTsB
	 AOun+Y1PIMyuYNiYF9wdfO27VJHKJ+vbjQ7ogGHikFmQ5geddhB09eKJCtYZA9zdPFN3M
	 aIPCym0bmVK12Jta+z1dD9iP72B01Us7fG9Dp7JLt4Qka6U4svglT+0RTRsuDQHdH5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145564;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0fECNG54n/Lw7Y7dKtGt1E6g844G0gDaHuevu60/s64=;
	b=wfE9WLAt+o6sMJUs9HuUQvZzVbiNmWGfDpTZZmVB6PSvOrIsY2GRax7FbEWD4QTQqNz8
	 GHcY2BmzPaNtvGChXYBPjtrDNGuv1wYC963bo6EUfEph1ipvGwiOLbh9DL4K45JzF9Vyg
	 QWwOPbX74zMvR4gxni9Yr+RSJlPMNdG/JD1LkcEsFCw3bfNtmgj6xM1tzu396TI2GUz3V
	 dP+X/Sg5KW+N8j7sQbe4r/x45hEX19PUaX3embt7j6omrYo0KmRB9k9Uz3USIzcGYag39
	 3RPuGGev2iXp5JO+IkDqbE8HM3WYHIibOrMhL1KpVSSwvAK506H4wdNAmkSt0RWVjtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oVjHzxeU;
	arc=none smtp.remote-ip=91.218.175.63
Received: from mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C9D606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 03:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C9D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oVjHzxeU
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RTGjO70kQTAFrOBvzmLzPFg5yur4DkRsk7Mr2E4IJY8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795145562; v=1; x=1795750362;
 b=oVjHzxeUOhijSoKCcpGwgWqE1sh9YF4ITYoeyLU/ZzN1xstGeIb0mTPO6oivPtxAWLt/gWj+
 7jfWxenUykAQeh1vN8EE62mAqjtrUjAsSEa2ClNMAfJ2mN5gnL1nOcnQSlHojVM340rCh/M1jqt
 OnSyxmIbr5Whhq8CoiwxnC54=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d9dbb3b872ea00c7;
	Fri, 20 Nov 2026 03:32:41 +0000
X-Mizu-Trace-ID: d9dbb3b872ea00c7
X-Migadu-Flow: FLOW_OUT
Message-ID: <8c25083c-dfbe-4fdb-80b8-bb42f0394de4@linux.dev>
Date: Thu, 19 Nov 2026 20:32:37 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 0/4] libbpf: Support kernel-side kfunc flavors
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/26 12:21 PM, Ihor Solodrai wrote:
> An incompatible change to a kfunc's prototype, such as an added
> parameter, breaks BPF programs built against the old one. libbpf
> ignores the ___<flavor> suffix of a kfunc declared in a BPF program,
> but makes an exact name look up on the kernel side, so the kernel
> can't keep the old prototype available under the kfunc's name.
> 
> sched_ext ran into this. cded46d97159 ("sched_ext: Make
> scx_bpf_dsq_insert*() return bool") kept the old prototype as
> scx_bpf_dsq_insert___compat, expecting libbpf to bind old binaries to
> it, and broke them. 2dbbdeda77a6 ("sched_ext: Fix scx_bpf_dsq_insert()
> backward binary compatibility") reversed the naming. A ___v2 kfunc
> declared as vmlinux.h spells it doesn't bind: 56bbc91219c0
> ("sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection")
> fixed a compat macro that silently dropped enq_flags because of this.
> 
> With this series, if the kernel's bpf_foo kfunc is missing or its
> prototype is incompatible with the declaration, libbpf binds the
> bpf_foo___<flavor> that has a compatible prototype. So a changed kfunc
> can keep its name, and the old prototype stays available as foo___v1.
> 
> resolve_btfids fails the build if two of bpf_foo and its flavors have
> compatible prototypes, unless both have foo's exact prototype
> (aliases), so the fallback finds at most one match.  This ensures at
> kernel / module build time that no ambigous kfunc flavors exist.
> Documentation/bpf/kfuncs.rst describes the rules.
> 
> Compatibility is determined by bpf_core_types_are_compat(), the check
> libbpf already applies to kfuncs. Of the 70 same-name kfunc prototype
> changes between v6.6 and bpf-next, it finds 8 incompatible (arity,
> return kind, callback prototype). The other 62 (const, typedefs,
> parameter names, integer widths, pointee struct names, annotation
> suffixes) were made in place without breaking old callers.
> 
> The flavors feature is backwards compatible: declarations that resolve
> today bind the same kernel function. The exact name lookup is
> attempted first. Declarations rejected today for an incompatible
> prototype, or left unresolved if __weak, may now bind to a flavor, for
> example scx_bpf_dsq_insert___v2 as vmlinux.h declares it. Older libbpf
> and light skeletons don't get the fallback.

We had an off-list discussion with Eduard and Andrii today.  We agreed
on the implementation as described below, which I plan to submit as v2
of this series (soon).

Writing from memory, please correct me if I forgot or misremembered
anything.

A single kfunc selection mechanism in libbpf:

   1. Find all functions in kernel BTF with the essential name (the
      name before the first ___ separator) that matches target kfunc's
      essential name. "bpf_kfunc" decl tag is ignored.
      This gives a candidate list.

   2. From the candidate list, find the one with a compatible
      prototype. Error on ambiguity.

No exceptions for "exact name" match (as in v1) or anything like that.

A function prototype compatibility check here will be a little
stricter than bpf_core_types_are_compat(). But it's also not going to
be a type traversal as done by bpf_core_types_match(). It will be a
new check specifically for func prototype comparison.

In particular, for pointers to structs, unions or typedefs *the name*
of the type will also be checked. And the typedefs won't "skipped"
anymore, but shallowly compared. For example:

    void kfunc(struct foo *arg);
vs
    void kfunc(struct bar *arg);

become incompatible now. And

    typedef struct foo {...} foo_t;
    void kfunc(foo_t *arg);
vs
    void kfunc(struct foo *arg);

become incompatible now.

However:

    typedef struct foo_v1 {...} foo_t;
    void kfunc(foo_t *arg);
vs
    typedef struct foo_v2 {...} foo_t;
    void kfunc(foo_t *arg);

are compatible, because the name "foo_t" matches.

resolve_btfids built-time "no ambiguity" enforcement remains.

The consequence of this approach is that a BPF program expecting a
kfunc that changed its prototype in the past in a CO-RE compatible
way, will now get an error if loaded with new libbpf. The fix is
simple: use an up-to-date kfunc prototype in the BPF program.

A notable recent example is bpf_cpumask_populate() change [1].

[1] https://lore.kernel.org/bpf/20260709182800.2037938-2-main.kalliope@gmail.com/


> 
> [...]
