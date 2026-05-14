Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B23890E7
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765430; cv=none; b=LBelw7Ryy4eMQEKHBzA9XNGSRJwYbyJANsCil8gUdQiLaShjlqQkjvK4wAmpUclN1ipWqNufPTLj64zIlSwsE/foqj331tB8At+tBH8yhJV3kr9XaBRtU7a2vrGHCfqJ7fBvY8PUgi7r2++ojjz2Bf0mazR7VCWTEkWJ15qwEfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765430; c=relaxed/simple;
	bh=OSSQnzP+VbFFHYyf7XPa+bl2GXKc37S+5CJIFj4HjOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoHtFGKShdFgnAgdsyjKLfFbgubxzb3u8kjXSskzABZlZoC2cz0dlzOf4aJbjvncfI7VpOiH/MFF4ETH2WkLWHZQ4MZqyaNcrWTIyR3IhM+wsINy7+C4KM2hNEx1z1ji03NDwSGborHsV+FRtI9Fdpg77Z5jUZ0ZQqxLPBkoUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kAYFI7EU; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kAYFI7EU"
Message-ID: <505473d8-85ed-434f-a863-8ecad2ab1d6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778765424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqZtNwXyVBaLpKC/JtJjnR4jW2TPPzKHhdilSw+9CJo=;
	b=kAYFI7EUcHuQnHM5k92jlIVMYbIqXaXEYX+nQtssqzO8G08EdLyD0tMOCkvMqxxFy0/gnL
	iBnJSGJX/JpaUwYW/qkGQGq5hvl3CvfpRF8ZC0TYWiTsHeJryDkDtw01egzYwlbijdzfmI
	ZRs4kYjf3d3h2lX2bss7lx3UNG20lzA=
Date: Thu, 14 May 2026 21:29:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs
 over vmlinux kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Chen <chensong_2000@126.com>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Hao Luo <haoluo@google.com>, KP Singh <kpsingh@kernel.org>,
 Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20260510030136.27876-1-chensong_2000@126.com>
 <a439f19e-1a47-46ce-8a2c-c53c9f038b8d@linux.dev>
 <CAADnVQLNLd7kV+pBV1i7YvPoQGMVzJusS71iPs6oc_K0Qpd9fA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <CAADnVQLNLd7kV+pBV1i7YvPoQGMVzJusS71iPs6oc_K0Qpd9fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/5/13 05:41, Alexei Starovoitov 写道:
> On Mon, May 11, 2026 at 8:19 PM Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
>>
>> It seems that there are two problems to solve here:
>>
>> 1. Allowing kernel modules to override vmlinux kfuncs with the same
>>    name.
>>
>>    This should be relatively straightforward to implement by matching
>>    names in kernel modules first, and then falling back to vmlinux.
>>
>> 2. Handling the case where different kernel modules have kfuncs with
>>    the same name.
>>
>>    Could we use a new libbpf API to establish the mapping manually?
>>    for example:
>>        bpf_object__set_ksym_btf(obj, "kfunc_name", "module_name")
>>
>>    Or define a new attribute, for example:
>>        extern void kfunc_name(void) __ksym __module("module_name");
>>
>>    We probably need to hear suggestions from other developers on this.
> 
> I'm not excited about 2.
> Two different modules are not allowed to have two different functions
> with the same name.
> The kernel has only one global namespace.
> Hence I don't think we should be introducing such namespacing concept
> into kfuncs.
> 
> But 1, I feel, is useful for experiments and mitigations,
> but it probably should be done transparently to libbpf.
> 
> register_btf_kfunc_id_set() should be changed to return an error
> when a module attempts to register a kfunc with a name that already
> exists in the kernel.
> We also introduce override_btf_kfunc_set() that would register
> a replacement kfunc.
> override_btf_kfunc_set() would check that all overriding kfuncs
> have the exact same kfunc already in vmlinux BTF: proto and name should match.
> Then the kernel will just remember that the address of that kfunc
> is in the module.
> libbpf doesn't need to be aware of this substitution.
> It will find kfunc in the vmlinux BTF, but the verifier will supply
> implementation from the module to bpf prog.
> 2nd module should be able to override_btf_kfunc_set() from vmlinux
> and from 1st module that replaced some kfuncs.

If multiple modules are allowed to call override_btf_kfunc_id_set()
for the same vmlinux kfunc, the effective implementation becomes
dependent on module load order.

For example, module A overrides a vmlinux kfunc and an A BPF program
is written with the expectation that this kfunc resolves to module A's
implementation. Later, developer B loads module B, which overrides the
same kfunc so that B's BPF program can work. If developer A then reloads
or reruns the A BPF program without knowing about module B's override,
the same kfunc may now resolve to module B's implementation. This can
make the behavior hard to debug and increase the maintenance cost of the
system.

If this is the intended semantics, I think override_btf_kfunc_id_set()
should have clear comments documenting that later overrides replace
earlier ones for future BPF program loads. It may also be useful to
expose some debugging visibility, e.g. through verifier logs, debugfs,
or bpftool, so users can tell whether a given kfunc currently resolves
to vmlinux or to a specific module.

If this is not intended, then we may need a mechanism to reject
overriding an already-overridden kfunc unless the caller explicitly
requests a forced replacement.

> All that only for bpf progs that are loaded after override.
> Already loaded progs don't need to be live patched.
> Thoughts?

-- 
Thanks
Kaitao Cheng

