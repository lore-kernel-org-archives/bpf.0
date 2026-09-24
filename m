Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D74456E14
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243802; cv=none; b=GK+sSjd8xF3GSy+Mv33apAbI8/dKU/xkWz4lekpazZo5iX/SYtkonFj2exaDHCmYWRSJH33kKVxqhdFxiBymzDgnyhT7wd0RZh6MIadyk9Jv5u6o4AQlg4/P5v/dXX5rohMzQizq7RGrhy1eUiAZcZOxMkEK4PXI0sQYls/GkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243802; c=relaxed/simple;
	bh=1fwJpUZyuAlum0e26ECZkGYzgsT1Jq8xi6Z+PjwLyMY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QPwiPiGYyut6jINBR2X3Pwqdfp423GVJtAh6F5xPHA5u8uMY7O/Jkbd2S33j1MhXXbt7hK7OkpA4hQFQNvNRfKyyf+b8M3Do8XvPvk32YBeaHOsCmO7fHWZH5xQ7pCpgF/SOWPfhDjppmrQB+crdOV5RyTZTPxQU2QDoe1nifow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI6yH2+a; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI6yH2+a"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6bbf77e8so2961565e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243790; x=1790848590; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X81ExZ24uv6kUpZw8Nsp1jb4V1Rl70Ka/Us45MU2YTQ=;
        b=bI6yH2+aOAHu5bYodZYh1ZpOjHThqQzIFguhue4sKCvvbdIH5N0CXOto2Ze7a/xTr0
         ILNKNe49V8BarCj9sq0QykzJaLlbzmsRp3HDgd0xNdeFdbbTndkOBnw0ehF39jnl4I0M
         IFJC4fR3UP6/mByv3NEv2v6k8wFGSwNP0lGLa+AugWxyvbePcG8h+mpmtETuCvgL+7Hq
         SV/OoQ+A6S+yARVyYqxYwgQRDkTlwvms9vhqfHqaLs4mz2L2qxDQ94UMtwH7L9sSo6ED
         0E+gIldYLt64q5J5J5VihC/lDqYgFGR9bJ0sP8nhsR2MxjNCkEb3QfV0BDfBpzEg+NvG
         dWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243790; x=1790848590;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X81ExZ24uv6kUpZw8Nsp1jb4V1Rl70Ka/Us45MU2YTQ=;
        b=byZwxHBSylh8hriPH7yjDOT40US5tyqMEXkUXq/2drNiqEaJomtVCZHRoYItK7oRmB
         2VSPUfxCnlryXRKTG6GUQexSlkfld5uCMauUkrcKZXgCJoKmtgXzppz6j+eQe6t43TiE
         VpqCEitjVmfBWBn9dcMN3U/jR4BxzAqQ6yg6o/dJ0s1WiFwtFcqSYXebpOyHkMAQJL/6
         sTM2iNnZ5ZqYSBbKzu34ulK8QjNH46pau/5lbiUDoohhPtcQNtoG7g8oaOuYPvLTV7xG
         ebhI4zdtZ5ksFjzQ9bi/ztTkc9xjld4ltcfST5HdgFefFIId7z3IwDVrKmLXrU4kNrSB
         P0vg==
X-Forwarded-Encrypted: i=1; AKwUvBw/gEXwYS4xMvcsoWC+em5EfaBPb7Y0hgt1SSQqbs0rq6yDT9/TmVHDbKQ0P0WrDbGtOYA=@vger.kernel.org
X-Gm-Message-State: AFuF++lvnIapZX6caHn5VF9uR+Zj2UalIj8Sf7o7opGP7m9W1V7m08ro
	llLg1LgE3B7JqlezGQoGBZldzlgp9bcs6gyHkc26BlvIjCniQM/29uHu
X-Gm-Gg: AYBFou3T/m+Uh1uPjCcGG/H1+NtbDsZ4s4UdPZnjf44MCA0nBg0B/oP30USaqiUbwVf
	MVoAABVp9F3bYfmfbiJyxj8VSyAXiVEQASdvwhLgBUa2ZhW4kZx/pUu64vMWs3dwA3h4HC37qq2
	y1HW7WbwLTfmJWe621k396ETTAyS/aQ2q3YTzDZEY5aaDURxtJJqadVQmotDl7LuxzJCFA69FZG
	wkfkKj67+uMsT816qd6rWWSyLttLEggSWgyr6G2tlTVbwZsdpNRmX2a79/zsr+cu6ahzLHvuJl0
	95Fh/sHvmVID31d5HpRE2zDDFSALi48xtU4A5B4HZGVKSHS5gHypq9Ad8ZWHMJSR0hexzpUvlAG
	lMxz815944DQ3AbjcCc5t6kUkvmBY9WkCMSyFyS3WqBX+1l5i4oILb7n26ZDl+QZLl5ov+pit16
	9Ecn/YAwrn1lP1eTIBxpEcnEKVznmPNRkzGFAzXjYWWQdpSv9rn2GK+omql8cGbCU86zJSC9qev
	FvdfseOAa+yle6Wa+GR15GpbT+E7glgc/6B3Qg9QXk4Z7+tDybfixr8LtxcmWBM97nyzog4UB2r
	qGHn059jqJEsH6y0siYAqQEQzHqaaB8S6d61uw==
X-Received: by 2002:a05:600c:8b22:b0:49f:ce78:3566 with SMTP id 5b1f17b1804b1-49fe66fa413mr30593735e9.23.1790243790338;
        Thu, 24 Sep 2026 02:56:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe43fc27csm52591785e9.2.2026.09.24.02.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 11:56:28 +0200
Message-Id: <DLNGGISVWINA.35D1HVUJZDY10@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <emil@etsalapatis.com>, <tj@kernel.org>,
 <kkd@meta.com>, <kernel-team@meta.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 13/18] bpf: Bound program stack use by a
 per-program limit
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260924082607.2695649-14-memxor@gmail.com>
 <52c1223353ad134a1dae657457cd39cb67c3e3d8caeaef0b07d4498f92bb653a@mail.kernel.org>
In-Reply-To: <52c1223353ad134a1dae657457cd39cb67c3e3d8caeaef0b07d4498f92bb653a@mail.kernel.org>

On Thu Sep 24, 2026 at 11:13 AM CEST, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
>> index 2f52315d8bdd..de83736509a8 100644
>> --- a/kernel/bpf/liveness.c
>> +++ b/kernel/bpf/liveness.c
>> @@ -36,9 +36,9 @@ enum {
>>   * relative index @i is at &bits[(i * FM_MASK_CNT + kind) * words]. A
>>   * half-slot at or past @words * BITS_PER_LONG is never read by this fr=
ame,
>>   * hence never live. An instruction that may read the whole frame, such=
 as a
>> - * call passing a frame pointer to another subprog, widens the array to
>> - * FRAME_MAX_WORDS, so that the read cannot lose half-slots to a later
>> - * widening.
>> + * call passing a frame pointer to another subprog, widens the array to=
 the
>> + * program's stack budget, the deepest an accepted program can reach, s=
o
>> + * that the read cannot lose half-slots to a later widening.
>>   */
>>  struct frame_masks {
>>  	u32 words;
>> @@ -264,12 +264,16 @@ static int mark_stack_write(struct func_instance *=
instance, u32 frame, u32 insn_
>>
>>  /*
>>   * Mark every half-slot of @frame as possibly read by @insn_idx. This w=
idens
>> - * the masks to the maximum width: a full read recorded at a narrower w=
idth
>> - * would leave the bits added by a later widening clear and lose part o=
f it.
>> + * the masks to the program's stack budget: a full read recorded at a n=
arrower
>> + * width would leave the bits added by a later widening clear and lose =
part of
>> + * it, and an access past the budget is rejected by the main pass later=
, so no
>> + * widening of an accepted program goes further.
>>   */
>> -static int mark_stack_read_all(struct func_instance *instance, u32 fram=
e, u32 insn_idx)
>> +static int mark_stack_read_all(struct bpf_verifier_env *env, struct fun=
c_instance *instance,
>> +			       u32 frame, u32 insn_idx)
>>  {
>> -	return mark_stack_read(instance, frame, insn_idx, 0, FRAME_HALF_SPIS -=
 1);
>> +	return mark_stack_read(instance, frame, insn_idx, 0,
>> +			       env->stack_limit / BPF_HALF_REG_SIZE - 1);
>>  }
>
> The new comment on mark_stack_read_all() says "an access past the budget
> is rejected by the main pass later, so no widening of an accepted program
> goes further." Can that claim hold in all cases?
>
> bpf_compute_subprog_arg_access() records accesses on every instruction
> the CFG can reach, but do_check() only explores feasible paths. In
> check_cond_jmp_op(), when is_branch_taken() returns 0 or 1, the other
> branch is pushed only if !env->bypass_spec_v1.
>
> For a privileged load, a branch that is provably dead but not
> constant-folded is never verified. Looking at something like this:
>
>     call bpf_get_prandom_u32
>     r0 &=3D 15
>     if r0 > 20 goto L
>     r0 =3D 0
>     exit
>   L:
>     *(u64 *)(r10 - 1024) =3D r0
>
> The program is accepted with stack_limit =3D=3D 512. The liveness pass
> still calls mark_stack_write() for half-slots 254..255, and
> widen_frame_masks() grows that frame past the budget, to 4 words.
>
> There is no functional impact. widen_frame_masks() keeps all old bits,
> and liveness is only queried from __clean_func_state() for half-slots
> below 2 * allocated_stack / BPF_REG_SIZE. allocated_stack only grows
> through grow_stack_state() after check_stack_access_within_bounds() has
> enforced -env->stack_limit. So bits past the budget are never read,
> and a read-all up to stack_limit / BPF_HALF_REG_SIZE - 1 covers every
> half-slot the verifier can query.
>
> Could the comments state that invariant (verifier states never hold slots
> past env->stack_limit), rather than claiming that accepted programs never
> record accesses past the budget? As written, a later change could rely on
> masks never being wider than the budget, for example to size a buffer fro=
m
> stack_limit instead of FRAME_MAX_WORDS, and that would be unsafe.
>

Reworded for v3: the comment now states the invariant that verifier states =
never
hold slots past the budget, and notes that unreachable code may still widen=
 the
masks harmlessly.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/359763=
22553

