Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912D579815
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195301; cv=none; b=N+djgLJn3CRSmu4Z/4fcindFkjCBf9WFii6sbXS1Bm3FBj37JyhPeXtDzLzCaPQOHt4QD/o2PDtDfD1EXlUQooKIGuW3de9lEvk/XaKj3jRdkIJ5xeAv0NCo0Vauvl+uKJPbjEMeKO6fr89r+GhUS9ACQatipZXgeLsJn3tgUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195301; c=relaxed/simple;
	bh=kamJf6kRsXs/22tSdxgB7j6K3XANdrtU0MCkc8UrCL8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZLcYv9lShyf8OD0GuN1PCZ0PJfbw940NhLUr+q5QmhyDgC0mnPE/ksKvVbcXb4GAwVLSoAMtzk47sj8cOMfzh1hEW3hSv8y48XkMRqxZWQsb0+3C5dUcTF7wnve3dhbeJ5aYboHg2I5sPPKBf6+obXXLxfKG3Pdd2MpwCNbk7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7JjmftY; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7JjmftY"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-486e4e15deaso394913f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790195291; x=1790800091; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8oVCE69k8FlUVvF1aZC0PkA/8inDzFl0Lrvg5vymbGc=;
        b=e7JjmftYxgQcMbHg1zmyvkIV9rXkcuVmcYZ6a6Gl59SPrtKMzS9eTNPpJUC0yMnKXJ
         StgQjdPliRumiP0ie6pzpdW6Day51uT3e/NhRrl+fo3Wgqx99u/tRUyqNjwJvEmGRWh8
         V0fW4BeY6A4GbJmo45Hyz5W+Sfkn8oUoiYGFBgWayCYqVXvkBhmlJ0cKBHF3PPtuB/qr
         O6gf1sqFn08txk0Tg6bZ6U9wONn8lJ7y1QGiB/5bEC04hYLnV9gD+1Qf7bJgLb7CnIZI
         W4oY0HbFHJkFS01/ELd3E1RXurZe7KQ28QEFAbH6A3HLDpgcZof0rV/QqfBX7rwz1mUF
         Mf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195291; x=1790800091;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8oVCE69k8FlUVvF1aZC0PkA/8inDzFl0Lrvg5vymbGc=;
        b=NvnnyF58sqwGYDhtZWGL3tNQ02QUe7yhbr8sJ/XFbXER0asyjq5cqAmDNaWzhK94dG
         BQIf73Y/sX/WbhtX9cbhovvPUOfVKT1mPwYZePgatd2Cm4PGwRVjL/VMb8rYpaecBNZz
         VDIr00dP9nL1RrtP1rRHeoeqgn7DbtTA59iY6RziqfjSpDE5k5u2U3o6tqg7+fhczv/8
         rz89rW+6pefzQ1vHPiwLPv8tFr07m9Ul3aMva4dQuZ0Tfn5T050yoRtI+wu/Lfi/t4fz
         fC/bbH+J/eZJVsa4LZnBnvQGl/TYTn8PPu1n4lnnHY2WbKcKNZhE3ScFIJm5dABL97oj
         A36A==
X-Forwarded-Encrypted: i=1; AKwUvByZf21xXs2xUTXoKAS8pSo5wcIzC3XB0h9Kg17iAwbRXq8kIyZRzaxYOiU2W383ZoN5aD4=@vger.kernel.org
X-Gm-Message-State: AFuF++nkyWj+ORuA58vxFlb3Cs6On68IqcrEv77Usq+OhFQOyeVepyyn
	mEnTdUaviU4UZLTqJOxj6NMn1cuRFxtX0Yc/57cKrwBTetSDgDVaoRhAaJ9twtr4
X-Gm-Gg: AYBFou0mjvW/73jp60AAJwgJ2O+/XXNCffbKHjn1JmV2eXueOaeQ/K+uBZ9x/bWb3/u
	379buUyjkL0M3AlTqeqvaej0rJI9/oQYtnMGYkyrohl6JwOsLqxIh0LFRn3JEl/84mytKniI1/c
	xhhKWYAJNy7TLSIoNOd4V6jXHKHA13ad5m92fxOaPpFATqrsSo7e8XtxamkOqB7p49qPLrkgWjE
	QoY34EeJsQB5bHUOfSXp64Z6K8lhvdG6uh5Lyw7e8+Fi3V2WqupSXP+jS2uEMQljM87Stn8R6CO
	//6ubTa5qvT1d2ZyhFu9epc2kE+gQsIHysfdm5H/4aqeg2CncrKeWNphRDTs9hxlCe/3zdozvP1
	xIGdMqL3E4UkCIbxpq0Fi6ReXb6Ba4efRbZCplHQ5GwpUmgYzAppaD3wPbH5YHxfSJ6WlD3qmKP
	RW9aFBsDsjVA41JdVz2UyyycK+HntFYXDwUqNf8y8fEYgkz1CmCB0EyhR2nkmRjSlx7IJ3HWwjp
	D6N+LUvxDVH2b+emAplmYWuNVSyDZrOxNzEcaI6Oyh5rQQ+bXyg76CnfvaW5StsDsJ509lVnTRW
	djVDrUNeNXdPcmZ9ctdCAJ+VBKwWy1GqPIgzDw==
X-Received: by 2002:a05:6000:40e1:b0:487:62d:37d9 with SMTP id ffacd0b85a97d-488716a5e3amr437443f8f.27.1790195291068;
        Wed, 23 Sep 2026 13:28:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488688893a0sm9563252f8f.32.2026.09.23.13.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 13:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:28:09 +0200
Message-Id: <DLMZ9MMDZU1Y.2MHD1XVK8OTAB@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 16/18] bpf, x86: Allow programs 2 KiB of
 stack
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260923191139.2816206-17-memxor@gmail.com>
 <da4e6f7d608df34719ae1c05ec5da4da9f53e42adfde8e80d653ef0017c3bf47@mail.kernel.org>
In-Reply-To: <da4e6f7d608df34719ae1c05ec5da4da9f53e42adfde8e80d653ef0017c3bf47@mail.kernel.org>

On Wed Sep 23, 2026 at 10:12 PM CEST, bot+bpf-ci wrote:
>> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf=
_design_QA.rst
>> index eb19c945f4d5..be5fc4ac00d6 100644
>> --- a/Documentation/bpf/bpf_design_QA.rst
>> +++ b/Documentation/bpf/bpf_design_QA.rst
>> @@ -221,9 +221,13 @@ newer kernels. BPF programs need to change accordin=
gly when this happens.
>>
>>  Q: How much stack space a BPF program uses?
>>  -------------------------------------------
>> -A: Currently all program types are limited to 512 bytes of stack
>> -space, but the verifier computes the actual amount of stack used
>> -and both interpreter and most JITed code consume necessary amount.
>> +A: A program may use up to 2 KiB of stack, combined over its call
>> +chain, when the JIT of the architecture reports support for large
>> +stacks (currently x86-64); a single function may use all of it, and
>> +every frame of a program running on a private stack gets the whole
>> +amount. Elsewhere, and whenever the interpreter is used, the limit is
>> +512 bytes. The verifier computes the actual amount of stack used and
>> +both interpreter and most JITed code consume necessary amount.
>
> Is the interpreter limit stated correctly here? The text says "whenever
> the interpreter is used, the limit is 512 bytes" in a paragraph where
> 2 KiB is defined as combined over the call chain.
>
> When bpf_jit_supports_large_stack() returns true, a program with
> jit_requested set is verified against MAX_BPF_STACK_JIT (2048) in
> bpf_check() via env->stack_limit =3D bpf_prog_stack_limit(env->prog), and
> check_max_stack_depth_subprog() bounds the combined depth of the call cha=
in
> by that limit.
>
> If JIT compilation then fails with anything other than -EFAULT (for examp=
le,
> a subprogram not being jited returns -ENOTSUPP in bpf_jit_subprogs(), or =
an
> allocation failure during blinding occurs) and CONFIG_BPF_JIT_ALWAYS_ON i=
s
> not set, bpf_jit_subprogs() restores the instructions, clears
> prog->jit_requested, and bpf_fixup_call_args() falls back to the
> interpreter. The interpreter checks on that path are per frame in
> bpf_patch_call_args():
>
>     int bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>     {
>         stack_depth =3D max_t(u32, stack_depth, 1);
>         /* Prevent out-of-bounds read to interpreters_args */
>         if (stack_depth > MAX_BPF_STACK)
>             return -EINVAL;
>
> and bpf_prog_select_interpreter() for the main frame.
>
> A chain of four subprograms each using 512 bytes (2048 combined) would be
> accepted by the verifier and run in the interpreter, whereas before this
> patch the combined chain was capped at 512. Each interpreter frame has it=
s
> own stack array, so this is not an out-of-bounds access. Should the text
> clarify that the interpreter's 512 byte limit applies per function, or
> should the fallback path reject a chain whose combined depth exceeds
> MAX_BPF_STACK?
>

It is indeed slightly confusnig, will reword.

> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359098=
53278

