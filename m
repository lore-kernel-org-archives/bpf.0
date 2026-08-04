Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD28456E1E
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838944; cv=none; b=TttCm6uWfb1gucuYV5UOsPbygXhsqXfgGtYkHJHl+9dCxWAAzkLKqVJPOVVPFRCtVVVhlAI0kj0A7BR8coI2ulYBstmBkMk2YXnU5GCu8dtsDG3DhGW6HLtPx79fLfNkSk25B4upzILtdU/IG4jtIw+k3SrrBSKICki82CApDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838944; c=relaxed/simple;
	bh=Gie/5Rlotc4DekWDFusEonFkIzpbYAn7IIsMWV5MOTw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=QZVQPAdB0OdMUnkM9wlWcO3fThSw5fciF/bNjU7E5K3NtDJCMTt1c3iNSvw2wzNP0ZE12+2TPTkVWoq6qbL8ttXhUr78qkW8bYvagM+JJmfkKNC6L/4eUPpGgm9S3D8liu9Pe20bnoakEGyZIfqC+UjnbR07Itfzl78vaDJhbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTZPf7KJ; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTZPf7KJ"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49557073245so11356805e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785838940; x=1786443740; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J/xMXMy7XvY7P4BbKEWncuZkeHnJLWMW3Ji7y1Rt9Cs=;
        b=mTZPf7KJ3I3+CfsT6Ffl6IrFCHgjaYB7WCPRAM07TEkCtAi77rVPkqEPjjVJ5qOyO5
         ZZ6nOoXg5UDCxtZFlJVrrhGKjBFAEVkBkb55U5U8A2QejN1OUtAjexsbzZ3poPblGeDz
         6yQAHOzI3c/lngxdxFuDA+EIH+p595ko8JnYixJvjokERGtn9WpaWrgF7y8XTQ56JeyD
         MrKP//r0knWX0FC/WRkrzE1EBLoV5rKytumHy+7N65gvGfiB+6b/neQ1aFERWDR4C8La
         nP2cxEbxTLfMBuorgV04wpT0moTpVY2HGUwrkFx1Fn4GMA6/S8MB+BkoUcXpaJozfEuE
         Blpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838940; x=1786443740;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/xMXMy7XvY7P4BbKEWncuZkeHnJLWMW3Ji7y1Rt9Cs=;
        b=LPDczQ+bAcEzN48TCTm/z4tkWd34fNFFmdAsY+mUzgBucnEY7v0Sc+KpZM8RSeYXw4
         o4kWXz4l4ggYjmbcCz3HIBbL5dM1t8Igp3YBGBkW2yHRYe4CyvUncVAwCJUeWJcCwFoh
         xeFnc/vhFv6EoVhwHF8yNUYVScfgsHCXxCU0ke/ejMoicb09D2amcHrN8yBVsB59hWjq
         eJYqn1IgtMgkvnM6AM2Y03NrGo8hoNGeHKj8tlUujLm4wvOQOnOBP+LP+7ShIRUBuPZs
         C/+HoZTijfd8ujf9nwXLrktEGoA4dFjTpja28o9t5SJUzPFbi1n62oiPfRpLBh7crtiY
         IwWg==
X-Gm-Message-State: AOJu0YyQ4ZQ4EjjwrZubn3ieAaHqloQhTgTejaN3S8q0wR8xLQS9hTye
	iaCk66vM3HMEC3GCt+FzG9DYUVtbLq5SZDOojfgni4JvmPAUci/slD5S
X-Gm-Gg: AR+sD13+9zTgcFlTD8n4XjnY4aNhtjKfMcgyz7ay1/FHiOtUTdzC1OKYkBrortqZAll
	o05+zrGc4+OsUo7xtWZgiHbxq4WVZO4E9oo+vvnzsNhTEcgaagIBEMv8VVCFb72GGYe7f2go9VO
	nFc4B99nwZRGjQ6CJlBqM9fh0dMoVePKwUe3tzGYBYM4w5hG6j0pmuDRtGgGtC+leycGrm6+feW
	n0a4bk525UhJ9MMrUQE9SlRbNyJkAbJFUQQc74+Yc715YdvvBEg8J2qvBBPO5JEZchJ6yhjr9/g
	GsVDyXmew2I9q18knwzyjpDEEnFvS1WrwP9oH6bsMUlzp4AEocSkVCfwZODGsgehQljA8kxbYrq
	49T3Zv45LIiCjmJ1EpDygv3JBGIhigbPlxmwcBKdXJefjzsIl1hdrKDM5rnp2kdowVmM98x5SB8
	9jmfJihmV3L+KHRc1KdUt6K6bR9R2qU0HlV8R+17mN5nIlKI7yB5DuHN7z09SUI0y+i8WZpGjVx
	YsfCc+TnVxFQxvtMJ8E2tl0VKEB3Lbv1G1ZaJeu6IyLFvWy7dK+QaUVeMCP8Kc6Ssinr5bDxKhs
	xqGSylHMCTB88CHyqDiM2qHyKZk=
X-Received: by 2002:a05:600c:1d8c:b0:499:4d50:7230 with SMTP id 5b1f17b1804b1-4994d5073fcmr14885645e9.18.1785838940306;
        Tue, 04 Aug 2026 03:22:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d17f2sm46038529f8f.2.2026.08.04.03.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 12:22:19 +0200
Message-Id: <DKG32J18PN0J.OP1J3RRHOU13@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Kaitao Cheng"
 <chengkaitao@kylinos.cn>
Subject: Re: [PATCH] bpf: add KF_SPIN_LOCK flag for kfuncs under
 bpf_spin_lock
X-Mailer: aerc 0.21.0
References: <20260804083212.79271-1-kaitao.cheng@linux.dev>
 <DKG0YUDSTBUY.1X220287HT9V3@gmail.com>
 <4aa061ed-6640-42b4-9f12-e33edb8ba1b2@linux.dev>
 <DKG27RH0P7OV.36PQRQ6C74UR0@gmail.com>
 <dd8e114a-7aa0-4657-ba28-2929ebca0973@linux.dev>
In-Reply-To: <dd8e114a-7aa0-4657-ba28-2929ebca0973@linux.dev>

On Tue Aug 4, 2026 at 12:09 PM CEST, Kaitao Cheng wrote:
> =E5=9C=A8 2026/8/4 17:42, Kumar Kartikeya Dwivedi =E5=86=99=E9=81=93:
>> On Tue Aug 4, 2026 at 11:37 AM CEST, Kaitao Cheng wrote:
>>> =E5=9C=A8 2026/8/4 16:43, Kumar Kartikeya Dwivedi =E5=86=99=E9=81=93:
>>>> On Tue Aug 4, 2026 at 10:32 AM CEST, Kaitao Cheng wrote:
>>>>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>>>
>>>>> Introduce the KF_SPIN_LOCK kfunc metadata flag in BTF so kfuncs may b=
e
>>>>> explicitly marked as safe to call while holding bpf_spin_lock.
>>>>>
>>>>> Allow kfuncs defined in kernel modules to be marked with KF_SPIN_LOCK=
.
>>>>>
>>>>> Example: BTF_ID_FLAGS(func, $kfunc_name, KF_SPIN_LOCK)
>>>>>
>>>>> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>>> ---
>>>>>  include/linux/btf.h   |  1 +
>>>>>  kernel/bpf/verifier.c | 20 +++++++++++++++-----
>>>>>  2 files changed, 16 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>>>> index c09b7994de4e..380dc10b6750 100644
>>>>> --- a/include/linux/btf.h
>>>>> +++ b/include/linux/btf.h
>>>>> @@ -79,6 +79,7 @@
>>>>>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as=
 its first argument */
>>>>>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as=
 its second argument */
>>>>>  #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments s=
upplied by the verifier */
>>>>> +#define KF_SPIN_LOCK    (1 << 17) /* kfunc is allowed inside bpf_spi=
n_lock-ed region */
>>>>>
>>>>>  /*
>>>>>   * Tag marking a kernel function as a kfunc. This is meant to minimi=
ze the
>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>> index 7aa47342dc65..9f3feba3c2fe 100644
>>>>> --- a/kernel/bpf/verifier.c
>>>>> +++ b/kernel/bpf/verifier.c
>>>>> @@ -11657,11 +11657,21 @@ static bool is_bpf_stream_kfunc(u32 btf_id)
>>>>>  	       btf_id =3D=3D special_kfunc_list[KF_bpf_stream_print_stack];
>>>>>  }
>>>>>
>>>>> -static bool kfunc_spin_allowed(u32 btf_id)
>>>>> +static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 fun=
c_id, s16 offset)
>>>>>  {
>>>>> -	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(=
btf_id) ||
>>>>> -	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf=
_id) ||
>>>>> -	       is_bpf_stream_kfunc(btf_id);
>>>>> +	struct bpf_kfunc_meta kfunc;
>>>>> +	int err;
>>>>> +
>>>>> +	if (is_bpf_graph_api_kfunc(func_id) || is_bpf_iter_num_api_kfunc(fu=
nc_id) ||
>>>>> +	    is_bpf_res_spin_lock_kfunc(func_id) || is_bpf_arena_kfunc(func_=
id) ||
>>>>> +	    is_bpf_stream_kfunc(func_id))
>>>>> +		return true;
>>>>> +
>>>>> +	err =3D fetch_kfunc_meta(env, func_id, offset, &kfunc);
>>>>> +	if (err || !kfunc.flags)
>>>>> +		return false;
>>>>> +
>>>>> +	return *kfunc.flags & KF_SPIN_LOCK;
>>>>>  }
>>>>>
>>>>>  static bool is_sync_callback_calling_kfunc(u32 btf_id)
>>>>> @@ -17289,7 +17299,7 @@ static int do_check_insn(struct bpf_verifier_=
env *env, bool *do_print_state)
>>>>>  				     insn->imm !=3D BPF_FUNC_spin_unlock &&
>>>>>  				     insn->imm !=3D BPF_FUNC_kptr_xchg) ||
>>>>>  				    (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
>>>>> -				     (insn->off !=3D 0 || !kfunc_spin_allowed(insn->imm)))) {
>>>>> +				     !kfunc_spin_allowed(env, insn->imm, insn->off))) {
>>>>>  					verbose(env,
>>>>>  						"function calls are not allowed while holding a lock\n");
>>>>>  					return -EINVAL;
>>>>
>>>> Why not apply it to all of the existing kfuncs? Also, use [PATCH bpf-n=
ext] subject.
>>>
>>> I do not think all kfuncs are suitable for the KF_SPIN_LOCK context.
>>> Kfuncs marked with KF_SLEEPABLE are an obvious example. Developers
>>> should add KF_SPIN_LOCK with great care and ensure that the kfunc
>>> does not sleep and is safe to call in atomic context; otherwise, it
>>> could easily introduce deadlocks.
>>>
>>> However, the kfuncs explicitly allowed by kfunc_spin_allowed(), such
>>> as those covered by is_bpf_graph_api_kfunc, is_bpf_iter_num_api_kfunc,
>>> is_bpf_res_spin_lock_kfunc, is_bpf_arena_kfunc and is_bpf_stream_kfunc,
>>> can be marked with KF_SPIN_LOCK. We can then simplify kfunc_spin_allowe=
d()
>>> to rely solely on the flag.
>>
>> Yes, of course. I meant those that we maintain as a list in the verifier=
.
>> KF_SPIN_LOCK is not a very optimal name. Should we do KF_ALLOWED_IN_LOCK=
_CS?
>> A bit verbose but better captures the intended meaning.
>
> The existing KF_* flag names are generally concise, so a much longer name
> feels somewhat out of place. I would also prefer the name to preserve the
> full spin_lock semantics, since "lock" can refer to many different lock
> types, such as mutex.
>
> Alternatively, following the naming of GFP_ATOMIC, could we call it KF_AT=
OMIC?

I think that is also confusing, every kfunc is allowed in atomic context in
general. E.g. bpf_map_update_elem() in spin lock critical section would be
problematic (due to embedded bpf_spin_lock in map value surfacing a deadloc=
k
opportunity). KF_OK_IN_SPIN_LOCK_CS is another option, but slightly longer =
than
the previous proposal.

In any case, let's choose this or the former one, and not fret too much abo=
ut
the naming. We can also choose a better name later on.
