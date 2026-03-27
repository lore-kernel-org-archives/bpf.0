Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED30376BDE
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631184; cv=none; b=JNe1ngIBX7wihFo5XLg9M1yRf3sg3Vk1kQqz6NkNyve7DpJHnElG7wuOXAAfqtpkmmrpI4eCy2jhZ80ekeWrRa29y5RYyQ2Uihm+21RGNrzmVh3IiUMrgK85mZFNqSCe7u9ity41pm3ZeMKqZZv0ArGHcwk9Sfhpz+N002oXak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631184; c=relaxed/simple;
	bh=3jo43mXBHor6+04Q4c8vxRS30AyIcBH9QNkSlxvLJrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuetiIKE43KcLd757oIRDCcYNmdhaacsgskpCwDIVc8pFBSMttD3eIEDIP/jmuHJkxTKmIe03vQf3/LUzUGu3+V0tWfrjYx25KJkyJS8tVe3Kp1vaG7uKf2ndlXkHzGYD94vjixkowKqI/pfd7ybP+6TIz44RERaHNHvvf92Ng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eLGHWA1I; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eLGHWA1I"
Message-ID: <aadee104-16b2-46e7-82b6-2ddd9f7e3676@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774631176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uGUgYCY9dXP6ZWhmO4zApFTPQbFndxCCQZoVE7bQBqg=;
	b=eLGHWA1I3k/vucMZ2zymF5IKiGAEMBqLhS95hyPAlvntxp4pXlH/gEkUtaJE57YcTu0BIP
	s55FcFyQBH7v+kYGNHmkiWgwTOsiNuXEY9mWHdGH8obV98uroGEvXv4fmqKG4e5GuaThHr
	s39C2kXTOTFaTH+7V7DOuXcuLx4Jdzw=
Date: Fri, 27 Mar 2026 10:06:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20260327002759.4033863-1-ihor.solodrai@linux.dev>
 <CAP01T77azUtPrOeUWWj=Y-VfvwWA9yma=+n2sJ-6Q2mRE1mLmQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAP01T77azUtPrOeUWWj=Y-VfvwWA9yma=+n2sJ-6Q2mRE1mLmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/26/26 8:45 PM, Kumar Kartikeya Dwivedi wrote:
> On Fri, 27 Mar 2026 at 01:28, Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> The following kfuncs currently accept void *meta__ign argument:
>>   * bpf_obj_new_impl
>>   * bpf_obj_drop_impl
>>   * bpf_percpu_obj_new_impl
>>   * bpf_percpu_obj_drop_impl
>>   * bpf_refcount_acquire_impl
>>   * bpf_list_push_front_impl
>>   * bpf_rbtree_add_impl
>>
>> The __ign suffix is an indicator for the verifier to skip the argument
>> in check_kfunc_args(). Then, in fixup_kfunc_call() the verifier may
>> set the value of this argument to struct btf_struct_meta *
>> kptr_struct_meta from insn_aux_data.
>>
>> BPF programs must pass a dummy NULL value when calling these kfuncs.
>>
>> Additionally, the list and rbtree _impl kfuncs also accept an implicit
>> u64 argument, which doesn't require __ign suffix because it's a
>> scalar, and BPF programs explicitly pass 0.
>>
>> Add new kfuncs with KF_IMPLICIT_ARGS [1], that correspond to each
>> _impl kfunc accepting meta__ign. The existing _impl kfuncs remain
>> unchanged for backwards compatibility.
> 
> Just a drive-by idle thought, but is there a way we could drop these
> _impl variants too eventually?

I think we *could*, since we don't promise stable API for kfuncs.

But practically speaking, turning this off abruptly will make many
people sad:

  $ git log -1 --oneline  958cf2e273f0 
  958cf2e273f0 bpf: Introduce bpf_obj_new

  $ git tag --contains 958cf2e273f0 --sort=creatordate | grep -v rc | head -n3
  v6.2
  v6.3
  v6.4

> 
> I think the existing macros in selftests can be updated to use either
> version by detecting the presence of the kfuncs, and maybe we can emit
> a warning to the stderr stream of the program during verification when
> we see these being used that they're going to go away in N releases,
> and then just drop them after that?

Selftests can just be moved to new API exclusively, since they are in
tree. Although we probably want to know that "legacy" is working for now.

More difficult problem is how to properly warn the users if we decide
to drop old _impl kunfcs, and for how long do we want to support both.
Do we already have some kind of "warning: deprecated" mechanism in the
verifier? I'm not aware.


> 
>>
>> [...]

