Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CFE2DF6E9;
	Sun, 17 May 2026 06:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999723; cv=none; b=qfY724jylhmXW2Y+nD/k/YhZYh6Oy1V8ASQdSmLZhT2Kkd4/zkTFYn6H3F0Zn1/m1xZSYDyxWmo2Jwavde0NPTnAUegZzd/xHKfq2ZxCjtulr4Ve4o7mIbCY2AvX6cFbPEh4F/edW1hUD7lJJxAKDyoMH0GIYy2TUH89H8LnBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999723; c=relaxed/simple;
	bh=I21rNWjin96HevVQisiMEI3T3zD9FQLrnU8mk63XvBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6qbUUKCpgM+B9tNYy14BE/GHKefJLyI4lCa0GOK4mDm8zk37NUmmlp9vHK+b4CUsaxxB0Tski0dahTFIfWDoJJY0gO4EvN+k+wA/GK/soOjGrfkyCPjzC/basXf7TXiOBdwT6cLiOUA5FSJtsegz7G3cnSb1n1W7knuI2G6Gus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=PkZtOzK+; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="PkZtOzK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=qwfJNNHG81AGndjMImExCj7ny5I3QmSn7fTn4DH1KFI=;
	b=PkZtOzK+JJfstgKuG6PV6bNUM0kSHrpU18ZhzGvuw68O4oWCFaxzDxJz43c6d9
	YG52Ld3R/nllmjndoaPN3FjXA+HjV91xiKblJ0kaqr7g1F0vEBRav+1BH8oJZQdk
	5E+K8/YBUyUscd4fztstmNFElV+33FQmjoF6XN+7czyl4=
Received: from [IPV6:2408:8210:480a:2590:3d7a:37cb:950b:975a] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3_2anYAlqn0fABA--.16722S2;
	Sun, 17 May 2026 14:31:04 +0800 (CST)
Message-ID: <419f6871-d66b-421d-ba81-804e162309f8@126.com>
Date: Sun, 17 May 2026 14:31:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs
 over vmlinux kfuncs
To: Kaitao Cheng <kaitao.cheng@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>,
 KP Singh <kpsingh@kernel.org>, Song Liu <song@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>
References: <20260510030136.27876-1-chensong_2000@126.com>
 <a439f19e-1a47-46ce-8a2c-c53c9f038b8d@linux.dev>
 <CAADnVQLNLd7kV+pBV1i7YvPoQGMVzJusS71iPs6oc_K0Qpd9fA@mail.gmail.com>
 <505473d8-85ed-434f-a863-8ecad2ab1d6a@linux.dev>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <505473d8-85ed-434f-a863-8ecad2ab1d6a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3_2anYAlqn0fABA--.16722S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr15tr1xuFyfJw4fGF45Jrb_yoWruFyrpF
	W8GF1YkF4ktwn7Xa1vqr1UZF1I9rWfJa1YqFn5J34xArn0qr1IvFZYyw4Y9as8Jr48t3WI
	qF4avasrXa4UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKPfQUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpAgfnmoJYKhHjQAA3M

Hi,

On 5/14/26 21:29, Kaitao Cheng wrote:
> 
> 
> 在 2026/5/13 05:41, Alexei Starovoitov 写道:
>> On Mon, May 11, 2026 at 8:19 PM Kaitao Cheng <kaitao.cheng@linux.dev> wrote:
>>>
>>> It seems that there are two problems to solve here:
>>>
>>> 1. Allowing kernel modules to override vmlinux kfuncs with the same
>>>     name.
>>>
>>>     This should be relatively straightforward to implement by matching
>>>     names in kernel modules first, and then falling back to vmlinux.
>>>
>>> 2. Handling the case where different kernel modules have kfuncs with
>>>     the same name.
>>>
>>>     Could we use a new libbpf API to establish the mapping manually?
>>>     for example:
>>>         bpf_object__set_ksym_btf(obj, "kfunc_name", "module_name")
>>>
>>>     Or define a new attribute, for example:
>>>         extern void kfunc_name(void) __ksym __module("module_name");
>>>
>>>     We probably need to hear suggestions from other developers on this.
>>
>> I'm not excited about 2.
>> Two different modules are not allowed to have two different functions
>> with the same name.
>> The kernel has only one global namespace.
>> Hence I don't think we should be introducing such namespacing concept
>> into kfuncs.
>>
>> But 1, I feel, is useful for experiments and mitigations,
>> but it probably should be done transparently to libbpf.
>>
>> register_btf_kfunc_id_set() should be changed to return an error
>> when a module attempts to register a kfunc with a name that already
>> exists in the kernel.
>> We also introduce override_btf_kfunc_set() that would register
>> a replacement kfunc.
>> override_btf_kfunc_set() would check that all overriding kfuncs
>> have the exact same kfunc already in vmlinux BTF: proto and name should match.
>> Then the kernel will just remember that the address of that kfunc
>> is in the module.
>> libbpf doesn't need to be aware of this substitution.
>> It will find kfunc in the vmlinux BTF, but the verifier will supply
>> implementation from the module to bpf prog.
>> 2nd module should be able to override_btf_kfunc_set() from vmlinux
>> and from 1st module that replaced some kfuncs.
> 
> If multiple modules are allowed to call override_btf_kfunc_id_set()
> for the same vmlinux kfunc, the effective implementation becomes
> dependent on module load order.
> 
> For example, module A overrides a vmlinux kfunc and an A BPF program
> is written with the expectation that this kfunc resolves to module A's
> implementation. Later, developer B loads module B, which overrides the
> same kfunc so that B's BPF program can work. If developer A then reloads
> or reruns the A BPF program without knowing about module B's override,
> the same kfunc may now resolve to module B's implementation. This can
> make the behavior hard to debug and increase the maintenance cost of the
> system.
> 
> If this is the intended semantics, I think override_btf_kfunc_id_set()
> should have clear comments documenting that later overrides replace
> earlier ones for future BPF program loads. It may also be useful to
> expose some debugging visibility, e.g. through verifier logs, debugfs,
> or bpftool, so users can tell whether a given kfunc currently resolves
> to vmlinux or to a specific module.

I agree with you. I have already had a solution for this proposal:
define a new attribute, for example:
        extern void kfunc_name(void) __ksym __module("module_name");

1) introduce a tag in bpf_helpers.h
#define __kmod(name) __attribute__((btf_decl_tag("kmod:" name)))

2) add module_name in struct extern_desc
struct extern_desc {
     enum extern_type type;
....
                 const char *module_name;
    } ksym;
3) read tag in bpf_object__collect_externs:
   tag = btf__name_by_offset(btf, t->name_off);
   ext->ksym.module_name = tag + strlen("kmod:");
4) search kfunc in modules in find_ksym_btf_id if ext->ksym.module_name 
is valid, otherwise, search it in vmlinux.

This proposal solves the kfunc priority gracefully, if ebpf program 
declares the kfunc module explicitly like this:

extern int foo(const char *str, const char *substr) __ksym __kmod("hello");

then use foo in module hello, if no __kmod after declaration, 
ext->ksym.module_name is NULL, the behavior of find_ksym_btf_id remains 
same, no impact to its original logic.

/Song

> 
> If this is not intended, then we may need a mechanism to reject
> overriding an already-overridden kfunc unless the caller explicitly
> requests a forced replacement.
> 
>> All that only for bpf progs that are loaded after override.
>> Already loaded progs don't need to be live patched.
>> Thoughts?
> 

