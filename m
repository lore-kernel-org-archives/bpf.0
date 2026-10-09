Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2D43DEC7
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559400; cv=none; b=JBKLQLIkTVua/6eQn169eXrDgaAjVWh+LyHzs26GC1nyOQ9W/oGT/cbdXP4RzDaMR9hQs+XehYTO9iFynVOevySCLSZQTKaoSoUEYFqZfw/Oo75DO1vgGI36gaxFKhXKCoZm8xx7/KKvVemQp+n1vrs379S+720l6rX7jKDVOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559400; c=relaxed/simple;
	bh=YhV1uq9nrtu3FgHNColy615Fa91X+6p1ywpKcSE46dw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=fM1dNxPUbljxv5gNDc3MMVmxw6d7/Tbb1AS1tKKtCqjRE5wKXXoEt596MDBTpm1JEySPm7BtSc7U5kdAIVTxQjBmtFZdtCTm204hZ/YKi2c/tL7EihnaE4jOjfxNi9ARG0NbPUc5uTBbjVa2kA09jMlraMNZHJqShvfrI2EmlXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NK6kbblG; arc=none smtp.client-ip=74.125.231.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NK6kbblG"
Received: by mail-oo2-f5.google.com with SMTP id 006d021491bc7-6df36d0b4e1so1282081eaf.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791559396; x=1792164196; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9bsEAb7rdjvTKyrPBq/ClQt9ly/O/oO1ux+7iMSVRPI=;
        b=NK6kbblG/EGTO570MZlBoxn+LZDSD3gt0UbIRsEo3uySL9Y3CHMOOZQGDqkTJQy5V1
         oKI0aJ33+B2BBPhy4pt2FwUTJ/L5izjz9+vEmoSCb8ngMbNnw5ZED8wlyGjDsaNtQF72
         +2mQUlv0tgH8VNnjgavnmoSDoFIxFspXvpXKDhno1JqzdIUanUji2En4ktJ+FVfOTlBT
         MUFk5qP3HVQjGDV7g+SksCpz32HtgDEMjx8+HhpoOSI2wVjN+bZl14dKlpRGof0DO6di
         ykoRRCXglueoQfUK8Unqq8lKwm7OXf6JCbREmUj4kPmijzzUvHX7Pr4QFJ6g47Uak/hv
         wi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791559396; x=1792164196;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bsEAb7rdjvTKyrPBq/ClQt9ly/O/oO1ux+7iMSVRPI=;
        b=P/K6VzFHfN3vXLVBAuW60XIiD1VWXhMJU3u9BICIYJW1I3arebIaRJsqrF7MU+KsY5
         CVeKKRjFAakipyOxKh88CbYvAP27p2yXNMTVioR4EsH518YL/EdHxTh1iBSb6yFHIXVG
         QIfKXTpCZDW1Wdb4Y54IFsPI1Fp66SoNQfYe1uXBEO8B+V0lWz22VZxjX1l3vPbup5cf
         MdiUcDSa7ZPWJEXleBSMQB70pFsH3bc55rQY5PF/LSO1bYQTt6NCAn83R7yNxHDOKaMr
         B+lilpxgatYjWDyL5e0Ll/QnwjIqfdOMa7bUXEahmmLeoi/38okT+vSn+aMvlotaS+8t
         wjDg==
X-Gm-Message-State: AFuF++nLFFMOPwFJepks14EGT18FcQGZfZpnVwARDq1IrpfCJc3d55Y5
	Lsw2b93CQu2XM4ubuy+yS6ySuDWK/cgsIFibbNYtgBV49VDAoejSd/MB
X-Gm-Gg: AYBFou3kFZxn4zVjf/ThNM6jI3ffBYp6X2EPz5jr4oKeylr8iwzkVtmx0oAVN+lLwbe
	BftZSgpJ6J3t3c7+M/7Rr3UmOxLqQh/IaRX4jEksmNy5gF2MBrqAJv+kCvRstynt7eKKQ+uI5kZ
	F1phzir0BCnJJyAIoTCCn6ttTTMH6LaeQa8vr7kw1dbxhKq4pd7kFo5qqthFAfhqv0PbLPGRxXp
	sSHmQpqLeNQgf2vfu4WxuJzl2ZN6IfopggLf4PoCfJxE1mHiBtlKzH4uz1ZYXFQByy4Uuyutv24
	Sh7o0ggaTvk2NotbGoGDghJNaa7AY4xXTRv3S3+z/F/JcA2gcaicAp+KbTd+H+jnTgt4+J3Q1Uz
	b4uo72egMMdFNxvzUqpkVqFMw8R8OvA2snxGwO03PEaNCLm28i+IUTT8AxVB6E0Up7bILO/O1/v
	4zm71aTz51uoZOoHgW5TZiwmJGxbH+AlBrVcrJYOwuvcchQ4g9F5JidYdw/JN0/4yL+OYQIsp5M
	xSdzsa8kOp4Tlu6/6xn5BFiVVua/ZTRI6LfvISfvfVmnNRrdfqz/0XsRMufjGodniERvsPkO5E8
	0o6JvL5N5G00GJw=
X-Received: by 2002:a05:6820:198a:b0:6df:10cb:2195 with SMTP id 006d021491bc7-6ef0eada12dmr1555534eaf.49.1791559395333;
        Fri, 09 Oct 2026 08:23:15 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef03e39840sm1848867eaf.15.2026.10.09.08.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 08:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 17:23:13 +0200
Message-Id: <DM0ESVBT9553.2S1RWK1W7M8WW@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Borislav Petkov" <bp@alien8.de>
Cc: <bpf@vger.kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Andy Lutomirski" <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, <kkd@meta.com>, <kernel-team@meta.com>,
 <x86@kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
 <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local>
In-Reply-To: <20261009041346.GHashp-hYpLl-o-l3M@fat_crate.local>

On Fri Oct 9, 2026 at 6:13 AM CEST, Borislav Petkov wrote:
> On Fri, Oct 09, 2026 at 04:49:21AM +0200, Kumar Kartikeya Dwivedi wrote:
>> With SMAP enabled, do_user_addr_fault() treats a kernel-mode fault on a
>> user address with EFLAGS.AC clear as a kernel bug: it does not consult t=
he
>> exception table and oopses right away. That is correct for ordinary kern=
el
>> code, where get_kernel_nofault() and the other nofault accessors never l=
et
>> a user address reach a faulting instruction.
>>
>> JITed BPF programs are different. A privileged program may dereference a
>> pointer the verifier cannot prove valid, and the verifier marks such loa=
ds
>> PROBE_MEM. The JIT attaches an exception table entry to each PROBE_MEM
>> load, so that a fault on an unmapped kernel address zeroes the destinati=
on
>> register and the program continues. Since a user address would oops
>> instead, the x86 JIT also emits an address range check in front of every
>> PROBE_MEM load, which keeps user addresses, the guard page above
>> TASK_SIZE_MAX and the vsyscall page away from the load. The check
>> duplicates the fault handler's knowledge of the address space layout, go=
t
>> the vsyscall page wrong until commit b599d7d26d6a ("bpf, x86: Fix PROBE_=
MEM
>> runtime load check"), and costs nine instructions and 32 to 39 bytes of
>> code per load.
>
> I can't parse that. Why do bpf memory accesses need to be handled differe=
ntly
> than any other memory accesses when SMAP is enabled?
>

It requires the same handling as get_kernel_nofault() as if that were inlin=
ed.
The point of the patch is to be able to avoid bounds checking in the JITed =
code.
We can probably extend this to other nofault accessors as well, but I wante=
d to
keep the scope limited to BPF for now, because the cost of the bounds check=
ing
is significant in BPF programs.

For background: Privileged programs are allowed to trace kernel code and
dereference pointers where establishing whether the pointer is pointing to =
a
valid object is not possible during verification. Program authors know abou=
t
this behavior, most of the use cases for this are reading data, collecting
statistics, and so on.

It is a more convenient and efficient way to walk a chain of pointers than =
to
use the equivalent of copy_from_kernel_nofault() in a loop.

get_kernel_nofault() does user address checks in software, in
copy_from_kernel_nofault_allowed(), because the SMAP branch in
do_user_addr_fault() treats any kernel-mode fault on a user address as a mi=
ssing
STAC and oopses without looking at the extable. The x86 JIT does the same t=
oday,
inlined, in front of every such load in a BPF program.

> Perhaps you should give a concrete example.

Consider this example:

  SEC("fentry/tcp_retransmit_skb") <- attaches to the entry of tcp_retransm=
it_skb()
  int BPF_PROG(retrans, struct sock *sk)
  {
          struct file *f =3D sk->sk_socket->file;

This program was written for doing a TCP related investigation. The first l=
oad
of sk is fine, but sk_socket can be NULL (orphaned socket) or stale, so the
second load becomes a mov with an extable entry. Below is the JITed sequenc=
e.

  movq    $-10485760, %r10
  movq    %rax, %r11
  addq    $2200, %r11
  subq    %r10, %r11
  movabsq $72057594048413696, %r10
  cmpq    %r10, %r11
  ja      load
  xorl    %edi, %edi
  jmp     done
load:
  movq    2200(%rax), %rdi
done:

Nine instructions and 32 to 39 bytes to guard a every load instruction agai=
nst
an access that SMAP, when enabled, will block for us, and which we could fi=
xup,
if we had exception handling in its fault path.

So the overall idea proposal is to eliminate this sequence and invoke the
fixup_exception() handler for the faulting instruction instead, which will =
zero
the destination register and continue execution, just like it does for faul=
ts on
kernel addresses already.

>
> And why can't all that gunk be resolved at program load instead of going =
all
> the way in the #PF handler?
>

This is what we do now, but it is a significant amount of code preceding ea=
ch
load instruction. If you look at some examples in the cover letter, we can =
shave
the text size of programs by more than half in extreme cases.

Do note that we already do fixup_exception() for kernel address faults, so =
this
is mostly trying to mirror that behavior for the rest and eliminate the bou=
nds
checking.

>> When the faulting instruction belongs to a BPF program, resolve its
>> exception table entry instead of oopsing, exactly as is done for faults =
on
>> kernel addresses. The is_bpf_text_address() lookup sits inside the
>> unlikely() SMAP branch that currently ends in page_fault_oops(), so no p=
ath
>> that does not oops today executes any additional code, and the oops itse=
lf
>> is unchanged when no entry matches. Non-BPF code keeps the existing
>> behaviour: a kernel-mode user access without STAC still oopses, extable
>> entry or not.
>>
>> The next patch uses this to drop the range check from the JIT when SMAP =
is
>
> There's no next patch and previous patch in git history.

Yeah, I will reword this bit in the commit log for v2.

>
>> enabled. Nothing changes about which addresses a BPF program may read: a
>> user address never becomes readable, since SMAP forbids the access, and =
a
>> PROBE_MEM load of a kernel address is handled as before. Without SMAP th=
e
>> JIT keeps its range check and this path is never reached.
>>
>> Acked-by: Puranjay Mohan <puranjay@kernel.org>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>>  arch/x86/mm/fault.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index aa88370ce739..2060e5f35d77 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/mm_types.h>
>>  #include <linux/mm.h>			/* find_and_lock_vma() */
>>  #include <linux/vmalloc.h>
>> +#include <linux/filter.h>		/* is_bpf_text_address()	*/
>>
>>  #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
>>  #include <asm/traps.h>			/* dotraplinkage, ...		*/
>> @@ -1262,6 +1263,16 @@ void do_user_addr_fault(struct pt_regs *regs,
>>  	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
>>  		     !(error_code & X86_PF_USER) &&
>>  		     !(regs->flags & X86_EFLAGS_AC))) {
>> +		/*
>> +		 * JITed BPF programs dereference untrusted pointers with loads
>> +		 * that carry an exception table entry (PROBE_MEM). SMAP makes
>> +		 * sure such a load cannot read user memory, so resolve the
>> +		 * fault through the exception table, as for an unmapped kernel
>> +		 * address, instead of oopsing.
>> +		 */
>> +		if (is_bpf_text_address(regs->ip) &&
>> +		    fixup_exception(regs, X86_TRAP_PF, error_code, address))
>> +			return;
>
> I'm not at all amused from this adding bpf-specific handling to the #PF
> handler, TBH...

I understand, and perhaps this can be adjusted to be a little different, bu=
t on
the flip side, at this point, the kernel is about to print an OOPS. I made =
it
BPF specific because we really don't expect to fixup exceptions for anythin=
g
else here. We already invoke fixup_exception() for kernel address faults.

The advantage is losing significant amount of code size in JITed programs a=
nd
the associated runtime overhead (you can see the numbers in the cover lette=
r).

Do note that we can make it more generic, we can follow up and optimize
copy_from_kernel_nofault() with cpu_feature_enabled(X86_FEATURE_SMAP) as we=
ll.
But I didn't want to go there just yet. I am happy to work on a follow up i=
f so
desired.
