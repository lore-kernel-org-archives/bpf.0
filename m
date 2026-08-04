Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CF3EB802
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836536; cv=none; b=WVZm9JUQM541YyMNTK7+1eT55QJHLxnu0kMWkn8ojwSr9qO4MswKC7UnwebAEcgmmU1wTtYXrbC4TBlaW2Y9KbdRIXICRrXDfy9BMHBiH5FjbzW4VoUMBHFamNbjavVp1Qsr3PRc2eCRWteBA3fnBfKMohTpUYyQPwche/dmw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836536; c=relaxed/simple;
	bh=7SkOPKJoMZNPbOuVzXI9h1sqqNLmnj2x7L1omJhEbHY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kUrCb5eB136WWjZ5NcW6K4SIi9u6fm//6K0YKBzLWsOfIB0DE6S69JWTy/RADPiZzM4mUWlR5vf0kA8np38zDEx/3y236kzCVV8hiAl+kMW72lYQKTnlnEuyw+3cu8J+Kpx+JV04Jb/s/F93zELeP6MfjOIYuxzp2yT4OzL2SEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNBZpj+0; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNBZpj+0"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4994c49f588so2386745e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785836529; x=1786441329; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G8/4wbYHhesN+5YL6FC1+T9l3xb67V/YIK+aTgkCyoI=;
        b=qNBZpj+0QjbUNg50d/KrepTrz2HKD3wPvDVi9krLUHt8G+77LyJKcufZCBN4VZ7Q2Q
         r4cAAcflB71COntPNHZP6185kEiOqqzv9U56QT9K/LkWZdjJW/Bgk+FZTD4H159UFe5f
         l4IGAcMDudmSzPp7fwe6OuNUG+QhoU7W4E1hhYrS2/Fun66cpUux5WslFWkcEIfEbYEn
         Eog2vJ4GgCrgfzTNnBIULIV+I1qA/nU2VnhZ65MVcrJDkivRfbek+KkimRQ9F8AwZk/e
         LFFIP6HwQ9PESqwmPLhfLIpkBoldtOePPDz/M9jcIzdOLTO9ciiBLFLjbdcc74BQF9gB
         ykyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836529; x=1786441329;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8/4wbYHhesN+5YL6FC1+T9l3xb67V/YIK+aTgkCyoI=;
        b=GDGzUQ3aVFb2QV8rZupIaVLpCLgeXhdOSZq7bTcvy5ZaLRg/JPX82n1MhUXder0vrq
         cL0Cys7SHKyHJx8M8XxzzWw7BIBB7s9H2QR6WpXAYIZtnamu+6ElknBnhzsc4F1nkaEa
         gGJD72ClFnJnJVF7JkM3L5sZKohARJ915kEBZ5bjX11hmFAkcTM5g90I6MVovYHDmJPg
         qir9zzsjQ6kwlzxB9juGJxBOrtyr8qahExQbrkD3879pg+oUg9rOyFd5BLN0IxPXsrRh
         kc4bOUH8nOci1Fo84HZY9/6TSlZJuE0hShsfOJ1rbMtsp4zxNHXtQoBzTMxaAV+mS+Kt
         QGeg==
X-Gm-Message-State: AOJu0YzkPW9K1pRNwyX5lYRPdcVkvFvOFEpymgVyhOZH42r9hqn+Tk56
	23JMGoJDstuwDFALwDzJPLvWGhAvJ4tAHpn1Pcet0P0IMVbzDddbB5Ms
X-Gm-Gg: AR+sD10wctKytuoQQKe0tlVjSKDJELhFcMJfUcrIt0nUtXjQpQM3RvJ+BjfyDyfdiF0
	5HRNhz1krsKRV8DkTyqxtj0jI6R6EP3GjWK2FtV72TtPDVA8/uzH/pWlwe0GsYR/tqOtQA8QQTC
	59D0h+z1TSqqd1Wa6doQ3Cv5aF/39kRRjrHkX7NoKwbwMzW+NMlNp8LaqTq6cUTNL4vVtB7xY2k
	ecJ3r5z0JLSWDXLDdCbsZdDQUFQ6O6UGgBGKK5KHF5cMTQ5rivjq0QHSulY+tgmS/xqYCUzD/IL
	Vdjd+nyWeONZrQ/FbhYs7CFg1SgrrJ+JMJid5zTB4oTPIYKwzVuAUs/QZq2so92lWL9KE1zlsjD
	2kqQlb/vaHaWJ1rcGeQgFdONbVAkkPs3DqG8TyzQy7DXXM7d2pZrqJOim93SM8qw6zr61VS6BgX
	FWHrnqI/pUsGpa0QFTLoUKJ652lc9iza5z21ohevqbxTVOPOeynpHSn3+/iLRHJUtLjBBSc1Lcx
	fpCcRoXmce/UYuDE0Z2EP9KgyOEs3WVE54b2NNiB03O7Xyi8ZWHzVWEokU8fdA379i7g8tSCuHn
	YsIbfUVJGkpLXBxhav4aJhMmWbEpRcqfbFzzbg==
X-Received: by 2002:a05:600c:8a09:20b0:495:7aaf:77b with SMTP id 5b1f17b1804b1-49949f86634mr66310915e9.0.1785836529311;
        Tue, 04 Aug 2026 02:42:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91b3sm44759649f8f.14.2026.08.04.02.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 02:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Aug 2026 11:42:08 +0200
Message-Id: <DKG27RH0P7OV.36PQRQ6C74UR0@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Kaitao Cheng"
 <chengkaitao@kylinos.cn>
Subject: Re: [PATCH] bpf: add KF_SPIN_LOCK flag for kfuncs under
 bpf_spin_lock
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Kaitao Cheng" <kaitao.cheng@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260804083212.79271-1-kaitao.cheng@linux.dev>
 <DKG0YUDSTBUY.1X220287HT9V3@gmail.com>
 <4aa061ed-6640-42b4-9f12-e33edb8ba1b2@linux.dev>
In-Reply-To: <4aa061ed-6640-42b4-9f12-e33edb8ba1b2@linux.dev>

On Tue Aug 4, 2026 at 11:37 AM CEST, Kaitao Cheng wrote:
> =E5=9C=A8 2026/8/4 16:43, Kumar Kartikeya Dwivedi =E5=86=99=E9=81=93:
>> On Tue Aug 4, 2026 at 10:32 AM CEST, Kaitao Cheng wrote:
>>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>>
>>> Introduce the KF_SPIN_LOCK kfunc metadata flag in BTF so kfuncs may be
>>> explicitly marked as safe to call while holding bpf_spin_lock.
>>>
>>> Allow kfuncs defined in kernel modules to be marked with KF_SPIN_LOCK.
>>>
>>> Example: BTF_ID_FLAGS(func, $kfunc_name, KF_SPIN_LOCK)
>>>
>>> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
>>> ---
>>>  include/linux/btf.h   |  1 +
>>>  kernel/bpf/verifier.c | 20 +++++++++++++++-----
>>>  2 files changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>>> index c09b7994de4e..380dc10b6750 100644
>>> --- a/include/linux/btf.h
>>> +++ b/include/linux/btf.h
>>> @@ -79,6 +79,7 @@
>>>  #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as i=
ts first argument */
>>>  #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as i=
ts second argument */
>>>  #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments sup=
plied by the verifier */
>>> +#define KF_SPIN_LOCK    (1 << 17) /* kfunc is allowed inside bpf_spin_=
lock-ed region */
>>>
>>>  /*
>>>   * Tag marking a kernel function as a kfunc. This is meant to minimize=
 the
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 7aa47342dc65..9f3feba3c2fe 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -11657,11 +11657,21 @@ static bool is_bpf_stream_kfunc(u32 btf_id)
>>>  	       btf_id =3D=3D special_kfunc_list[KF_bpf_stream_print_stack];
>>>  }
>>>
>>> -static bool kfunc_spin_allowed(u32 btf_id)
>>> +static bool kfunc_spin_allowed(struct bpf_verifier_env *env, s32 func_=
id, s16 offset)
>>>  {
>>> -	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(bt=
f_id) ||
>>> -	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_i=
d) ||
>>> -	       is_bpf_stream_kfunc(btf_id);
>>> +	struct bpf_kfunc_meta kfunc;
>>> +	int err;
>>> +
>>> +	if (is_bpf_graph_api_kfunc(func_id) || is_bpf_iter_num_api_kfunc(func=
_id) ||
>>> +	    is_bpf_res_spin_lock_kfunc(func_id) || is_bpf_arena_kfunc(func_id=
) ||
>>> +	    is_bpf_stream_kfunc(func_id))
>>> +		return true;
>>> +
>>> +	err =3D fetch_kfunc_meta(env, func_id, offset, &kfunc);
>>> +	if (err || !kfunc.flags)
>>> +		return false;
>>> +
>>> +	return *kfunc.flags & KF_SPIN_LOCK;
>>>  }
>>>
>>>  static bool is_sync_callback_calling_kfunc(u32 btf_id)
>>> @@ -17289,7 +17299,7 @@ static int do_check_insn(struct bpf_verifier_en=
v *env, bool *do_print_state)
>>>  				     insn->imm !=3D BPF_FUNC_spin_unlock &&
>>>  				     insn->imm !=3D BPF_FUNC_kptr_xchg) ||
>>>  				    (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
>>> -				     (insn->off !=3D 0 || !kfunc_spin_allowed(insn->imm)))) {
>>> +				     !kfunc_spin_allowed(env, insn->imm, insn->off))) {
>>>  					verbose(env,
>>>  						"function calls are not allowed while holding a lock\n");
>>>  					return -EINVAL;
>>
>> Why not apply it to all of the existing kfuncs? Also, use [PATCH bpf-nex=
t] subject.
>
> I do not think all kfuncs are suitable for the KF_SPIN_LOCK context.
> Kfuncs marked with KF_SLEEPABLE are an obvious example. Developers
> should add KF_SPIN_LOCK with great care and ensure that the kfunc
> does not sleep and is safe to call in atomic context; otherwise, it
> could easily introduce deadlocks.
>
> However, the kfuncs explicitly allowed by kfunc_spin_allowed(), such
> as those covered by is_bpf_graph_api_kfunc, is_bpf_iter_num_api_kfunc,
> is_bpf_res_spin_lock_kfunc, is_bpf_arena_kfunc and is_bpf_stream_kfunc,
> can be marked with KF_SPIN_LOCK. We can then simplify kfunc_spin_allowed(=
)
> to rely solely on the flag.

Yes, of course. I meant those that we maintain as a list in the verifier.
KF_SPIN_LOCK is not a very optimal name. Should we do KF_ALLOWED_IN_LOCK_CS=
?
A bit verbose but better captures the intended meaning.
