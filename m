Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663303;
	b=RyfffkQCKNGKn+9c8VeqF9rubSEZYb6SGsb8+7kpFSXFX808PYd3zuqw4o0N/c7Xa5Qn
	 EaSUktEsnFXtcb3mLwzBvQepx7vKYziRaYP+E8oqqBh8mRR6WaA4Kt1Kr3yInobOg1PXd
	 7dbIV9yRA3NFDitJ7NXjqjESAgVECCVTFP8mcwguq278KmfjgJSK1LYGI/pNBkOFnAE7+
	 7oF4Mx+4S8NL3joH+fsGBHNVNC/SXP9pkSAlIIbtx+OM78KqEI/GGtrADXm4c6K9pBkpu
	 ryVUDke9RPzR55IHFbogjRzgbWSJypxwFx1ER8YRnJD2Uy5BgEyP+CLkvOhaRLJHrAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AdFl+c9HTfOJHnKVulHF/KABJga7rr2KkdaAezk90/U=;
	b=KViYrPnDKHspkvSIr791hC3qBoyXUXf9w7Tg62fPjh6TTCUVgAqwobjpk4NjG5L+6x6x
	 fm0HG9JQi8gfbXX4xztxHEP+Z+pIn46p+UMHX72ixH3w8pyDaUj4L5WWHUvpY3EGI/kJv
	 oBWFr9h0Z6HbWh2JE1ErEYdxw94+DNoyqlhy7HAiRjLn0jwq1vQeIrB79+kNKlQQ+/KFM
	 i30dCX8q4IKuug2StYZC89U9dSH+HWVGpVNdohKRsxd4HY/5jh8o12g/K19/uQPVSIh7d
	 gPD/+d8EFuKhBbTuiEpKzUJS604inar2t7jkGiam3/yOy6t2IqtPRJKzrnJsISVUQmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6ohaFvw;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD9606A31D
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 10:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FFD9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6ohaFvw
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c34bff61551so211406666b.2
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792663301; x=1793268101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AdFl+c9HTfOJHnKVulHF/KABJga7rr2KkdaAezk90/U=;
        b=C6ohaFvwBXq3n1+WrpazbmGLbZXHZy60WksniPnyv0/fNqqeJc2ArAPv1CA0E3vAAD
         UFehNO6fcMQRNycAOm8AQyoEL008xSbsc90gUFwfKXoG0xYSxGRwnj70jKu96m/OxoQn
         SSFTnKp1uAFXptEyosauGwZ2SyWFiXSNSDxwSNCBiqiw23NELBMP2OC7siYj1jqnWmVt
         xZE+4bXdGFB+XvfVDEzsKUKFnNMGI9lUR2FnWa85Pnn6mHSJBp9s4XHY5HgdBVQzPemW
         TJihuhTHNCarHGh5O9KpXHR7Cy83DyDmN0sOoohXmyq5L6E/8hHgDUN0yuADfu8lyP6p
         512g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663301; x=1793268101;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdFl+c9HTfOJHnKVulHF/KABJga7rr2KkdaAezk90/U=;
        b=GmxBwNhGREJAVWq6ZRcrmuLz5apAG4BfNTs1aZmQ5t8D1eQAuseFbjTSi6Mm2+hcXM
         E7UZsxnc8mKNR+2VcN80LfChtU/BP9hMjtJHlM7B7TnBJuo6vSF6Jk/dzKIwxAquyOGi
         GwvPHvurhtDvXEH8+6OxEXCeTnG25dbw/fbz4u3n87pCYWfHmC3RVbtGPJ/CjIA+uwoM
         AirKVc54lGC7b2Li9hRll72JnfhROrSAmViF2gxEbnl96Nzp9JGZ8rWiCpBq36tEufo2
         SlU2WiN07mQAcZ6jazGnklaeqw7EJ+8xT2oTlmMpGd4szia9qOe1RBC5UKQl2ORsWJ2+
         5g3A==
X-Forwarded-Encrypted: i=1; AKwUvBx2KbSHIISz4NeOYI0nRT0f9nQq/aYsHuFIaykSowRiaAmvczH4CuchBdJFguSZcsNPxWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKD5vwg40mkyQdu6Qiqz08ZBu5Ezn7aUpWofC0p2s4TbVfgpPcU
	pZNK+cKWYdDPDLdqQApycThPkG2xX7nWTM1dk7Q4ODSlWibMyD/Rjno1
X-Gm-Gg: AYBFou0ORlHeGy9FWKhshaH6mkYUk7cNnKBe3OoiSlqThG4WalQjJvK7LOsTc8py0gr
	9GrFmGL2N8dtnV1Lv0tvWTxrqY7OWsGNpA1awo3Wvy9dEiPPocPJbOmv7DnjDpO+XhEWizxGzrT
	zuYt3vlIAVQk9dfKJe7FMEalEpjWjdjmoynBOYgbejXD9Tj29Mqry87ciToJuyxp3dhEH2fExyE
	yYKce/4SmBVi/9qIr2sy2ooIyl202LhU4Gn/wgFpqfrMMqYJsylegNCtulJRb0KGhsnCYTe6RjX
	Ed4kuaj9Hf/Utak1SPBN2o5bkb4LxU8vXE3St8ZXJ/Q8CjP81zFhfQpW1dNDe58DE4SeZz84a+F
	5rz0FQmAXL+sn6owY2vPBIk0+iBRdP++W0bmp0K8DJT7TlEcjzzlcFdwKsr8bDa9Fj0BUF/1kJp
	bxyo9MpQfrfb0HE8UivskXeqmFr8m7EoT8e9tVS4nwAtc5vBjQL9i/OzNLgpsSb3YrSRB6yhb1j
	u4ilSg7AZU9r85Vt6DpqpO4NNCTYJHMrvb+QOkCl64=
X-Received: by 2002:a17:906:dc89:b0:c40:f9ea:7387 with SMTP id a640c23a62f3a-c46791a979emr451363266b.6.1792663301007;
        Thu, 22 Oct 2026 03:01:41 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2a034fc2sm7287470f8f.5.2026.10.22.03.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:01:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 22 Oct 2026 12:01:37 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC bpf-next 0/9] bpf: Add support to allocate user page
Message-ID: <atnfAUWzdsoWQKe8@krava>
References: <20261021195759.119421-1-jolsa@kernel.org>
 <DMAUMG9WL4X6.12UEJJMJSW54Z@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMAUMG9WL4X6.12UEJJMJSW54Z@gmail.com>

On Wed, Oct 21, 2026 at 09:53:47PM +0000, Alexei Starovoitov wrote:
> On Wed, Oct 21, 2026 at 12:57 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > hi,
> > we have few use cases where having the ability to allocate normal
> > or executable user space memory would help (like to replace function
> > in live process or change environment variables)
> 
> I think it's better to do what debuggers do:
> vm_mmap() with the final prot and
> access_process_vm(FOLL_FORCE | FOLL_WRITE), like PTRACE_POKETEXT,
> to fill it. It faults the pages in, writes into r-x private mapping
> and copy_to_user_page() takes care of icache.
> Then no need for bpf_user_page_exec(), do_mprotect_pkey_locked(),
> the marker, READ_IMPLIES_EXEC special case, get_user_pages(), etc.
> No mm changes.

great, much better, will use it in next version, thanks

> 
> Like:
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 648abe1..ca1d88d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -29,6 +29,7 @@
>  #include <linux/task_work.h>
>  #include <linux/irq_work.h>
>  #include <linux/buildid.h>
> +#include <linux/mman.h>
> 
>  #include "../../lib/kstrtox.h"
> 
> @@ -3834,6 +3835,60 @@ __bpf_kfunc int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
>  	return ret;
>  }
> 
> +/**
> + * bpf_copy_to_user_task() - Copy data to a task's address space
> + * @unsafe_ptr__ign: Destination address in the task's address space
> + * @src:             Source address, in kernel space
> + * @src__sz:         Number of bytes to copy
> + * @tsk:             The task whose address space will be used
> + * @flags:           Reserved for future use; must be zero
> + *
> + * Faults in the destination and writes the way ptrace(PTRACE_POKETEXT) does:
> + * a private mapping doesn't have to be writable.
> + *
> + * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if the copy
> + * fails or is partial.
> + */
> +__bpf_kfunc int bpf_copy_to_user_task(void __user *unsafe_ptr__ign, const void *src,
> +				      u32 src__sz, struct task_struct *tsk, u64 flags)
> +{
> +	int ret;
> +
> +	if (unlikely(flags))
> +		return -EINVAL;
> +
> +	if (unlikely(!src__sz))
> +		return 0;
> +
> +	ret = access_process_vm(tsk, (unsigned long)unsafe_ptr__ign, (void *)src,
> +				src__sz, FOLL_FORCE | FOLL_WRITE);
> +	return ret == src__sz ? 0 : -EFAULT;
> +}
> +
> +/**
> + * bpf_user_mmap() - Map private anonymous memory into the current process
> + * @len:  Length of the mapping
> + * @prot: PROT_* flags of mmap(2)
> + *
> + * Return: The address of the mapping on success, or a negative error code.
> + */
> +__bpf_kfunc long bpf_user_mmap(unsigned long len, unsigned long prot)
> +{
> +	return vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0);
> +}
> +
> +/**
> + * bpf_user_munmap() - Unmap a range of addresses of the current process
> + * @addr: Start of the range
> + * @len:  Length of the range
> + *
> + * Return: 0 on success, or a negative error code.
> + */
> +__bpf_kfunc int bpf_user_munmap(unsigned long addr, unsigned long len)
> +{
> +	return vm_munmap(addr, len);
> +}
> +
>  /* Keep unsigned long in prototype so that kfunc is usable when emitted to
>   * vmlinux.h in BPF programs directly, but note that while in BPF prog, the
>   * unsigned long always points to 8-byte region on stack, the kernel may only
> @@ -5139,6 +5194,25 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
>  	.set   = &generic_btf_ids,
>  };
> 
> +BTF_KFUNCS_START(user_mem_btf_ids)
> +BTF_ID_FLAGS(func, bpf_copy_to_user_task, KF_SLEEPABLE | KF_PERFMON)
> +BTF_ID_FLAGS(func, bpf_user_mmap, KF_SLEEPABLE | KF_PERFMON)
> +BTF_ID_FLAGS(func, bpf_user_munmap, KF_SLEEPABLE | KF_PERFMON)
> +BTF_KFUNCS_END(user_mem_btf_ids)
> +
> +static int user_mem_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	if (!btf_id_set8_contains(&user_mem_btf_ids, kfunc_id))
> +		return 0;
> +	return security_locked_down(LOCKDOWN_BPF_WRITE_USER);

ah right.. all of those kfuncs should be behing write_user lockdown

> +}
> +
> +static const struct btf_kfunc_id_set user_mem_kfunc_set = {
> +	.owner  = THIS_MODULE,
> +	.set    = &user_mem_btf_ids,
> +	.filter = user_mem_kfunc_filter,
> +};
> +
>  BTF_ID_LIST(generic_dtor_ids)
>  BTF_ID(struct, task_struct)
>  BTF_ID(func, bpf_task_release_dtor)
> @@ -5266,6 +5340,8 @@ static int __init kfunc_init(void)
>  	};
> 
>  	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &generic_kfunc_set);
> +	/* Sleepable kprobe prog can only be attached to uprobe */
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &user_mem_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &generic_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
> 
> But I'm not at all sure that it's a good idea
> to inject code into a process.

well FWIW it's still guarded with the LOCKDOWN_BPF_WRITE_USER same as
bpf_probe_write_user helper

at the moment we have fragile way of live patching a userspace process,
this would give us a more direct and reliable way for that

thanks,
jirka
