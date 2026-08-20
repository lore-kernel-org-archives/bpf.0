Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C538E8D0
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251531; cv=none; b=NPzB/pjZ9EruIRU8JsiYk/o2V/j2V6KBcKdyZ6rBnTbs679MERbS7YsXPSP/pdUrigFeWIhNkGEAwk+oa0ArzIgLYKOpmNROlcT3bQ9FXusICkOj9nIv+MGYKJgzid8IJNDJ2Fv/n0naG/JLSkEJX8erEiM/9CYuKdN2L0Tg25I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251531; c=relaxed/simple;
	bh=IjxMcim8HOwP/6WRe0eNco3scu2oMXvxpsDJCD9rlFI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r14JfaQRfX/gvv9EkSAsA8oBUvNmaIFAzBvexmT7yr87hHbiteKY07HSZiU1MxSOqhjH/4kxTZFsgKCriHvppoKLMp5fkawI1o1NUKlsbu3g5mEZqTTuAzP3x42bMaT6HWznHF2+hkBOM/Gm/k0oA+COX8Eq1Lf/3i/bgR+HMKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg2XqjA0; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg2XqjA0"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so52957f8f.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787251528; x=1787856328; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A8tRTZx6tC4oonTDhc/ZkLzvtSgV5Qt1wlSP8VYKMh0=;
        b=Sg2XqjA0eTxGAE8KYDYOKtGXaFwNrI6HEjf4KOSOsRnywyx5t2nuMbdTehT46PHoZB
         pjYGTeL6W3ZdyOkI6LoDF4Us3K8T05Xk0xqXSVnOcW+XquoQ6p/48HYT3WLDB5+J+3kE
         q5SKedmeapbsQiOFOSchsnHadNesyvUIiKa3D7MRKhpPlWcbxZT0bu+Tzzs8tJRFkr6R
         VHRf8IUoe0sop4DcO1Ml611K/6jpQamq+uQrVed92omgt7Vqkhy974QQaG85JpQ27QJA
         nXc/gBqxuKwXNlBP6OxGC2QL8s1+ElyXVcD6AOi0xDmwaDUs1EnWziC8t4fGXvd2Vxc1
         BSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251528; x=1787856328;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8tRTZx6tC4oonTDhc/ZkLzvtSgV5Qt1wlSP8VYKMh0=;
        b=A9w59SIa6PY/VrzF4eRUPQP7iWF6ROwgktAiWoND8nxxpB9zWwmzp7s2Ltx+UM9Bvv
         brI+BZtzhdSfeqOp453ckUmftvf5oWTGg9TkEfqSPXkZhATm6os8ZtEOhbNEOU+yaGYn
         TpU/Ajb8eHM9p5o6vuv30A19ulCsPQCfa6hNr2z448tHfBmuTXaKRxMYppFBc5Ssu/JW
         LWD/idOXDfRp+Bmf+5ObtE0004Rju8d62lg3IwhXIQPy5Bq1SWt+8MjZy3Tcdotrf+cm
         ElMNYmCMvJqlJymDzSH4ryKF5yFl+WEkI61ao53f45aIw980WCzefUp+g6HH3a01dYYa
         dj4w==
X-Forwarded-Encrypted: i=1; AHgh+RodlkjfAcKk7u0tapB3mbkcB42l20PADkhFhYIo9hWrmxnMCwp2yzIn9xHQCxZcZ/KlPpk=@vger.kernel.org
X-Gm-Message-State: AFuF++mc2TOPvzYoPalzObvlJMmb/sonCAOO9MQ2l4z1UrAiFaLJytBJ
	e5YzHMFkwBK1/40+AZq00t5Tiy92J3aABJcVjbicFBB8InSeGdtu1E0w
X-Gm-Gg: AR+sD139dHk1PnQLS0MtAHbAwdigx2qUYig9CdyesnG/6VL9H70y5KsxfKQgqo3Dkj5
	oaMVdDuIsrzgFiZ/1gW0QO5WkvzxgH8rJxFEGSFZ+LlaywDo4dar12DJhQPzFni6+rmM4SobUmR
	CESj0xlk40mrKUh1i9y6XNQquBCwjIxvgb1PTo2ii6ZxgKp33z1WbGpNSk+txC/Zlvkv7TEtIeX
	Cu/LLOm4Jh85vSSOXjyKo1EVYq+V7bS5w2vNLtyucyBfvb7f9jXbEzA/FQVkEUHfEQRCYH1/1dz
	iVEowF0wVLrqrsfD3HvNzsTE0N9obG0kG8lazjdh6hBbishlEg3Ym3uRqmPxey09rqTCkLYvAJ2
	JKJ5zTL/5ods7zroIpJ/pju8s9UE/zA+YEJE0jlx87JVP94PqTBu01nVbYfOKgZVkHIjlXPMozE
	gEnHYE5CpAE8AenGBCZ0O3BJO2NZd9RYFmBBwfBQcgZVJah+2wyAfO72XRLsM8hlQYRM0p2XPql
	DVdvjiP1yn9r6/kSz8nqbIt2VBcH3Vp+zHadF6069+mJM5m9qKeUk4wq5ciQVFKHGt13GVWk2RT
	eo/INGXV1MkPzATHFYxEiGfKs3KemHYqpU4I1w==
X-Received: by 2002:a05:6000:1841:b0:47f:8b2c:3d98 with SMTP id ffacd0b85a97d-482c0b5883amr1210547f8f.4.1787251527954;
        Thu, 20 Aug 2026 11:45:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8038sm13224824f8f.20.2026.08.20.11.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 11:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Aug 2026 20:45:26 +0200
Message-Id: <DKTZSGMQL5CC.18BOA9ZNRHQ5J@gmail.com>
Cc: "Hiker Cl" <clhiker365@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "Paul
 Chaignon" <paul.chaignon@gmail.com>, "Amery Hung" <ameryhung@gmail.com>,
 "Shung-Hsi Yu" <shung-hsi.yu@suse.com>, "KaFai Wan" <kafai.wan@linux.dev>,
 "Daniel Wade" <danjwade95@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf: fix REG INVARIANTS VIOLATION on
 speculative pointer arithmetic
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260819125840.286434-1-jiayuan.chen@linux.dev>
 <57a57ed806a954de19774b7c0833dc1742560cd2.camel@gmail.com>
In-Reply-To: <57a57ed806a954de19774b7c0833dc1742560cd2.camel@gmail.com>

On Thu Aug 20, 2026 at 8:25 PM CEST, Eduard Zingerman wrote:
> On Wed, 2026-08-19 at 20:58 +0800, Jiayuan Chen wrote:
>> Take the following unprivileged program as an example:
>>
>> 	r0 =3D bpf_map_lookup_elem(...)	/* PTR_TO_MAP_VALUE, offset 0 */
>> 	...
>> 	14: r0 +=3D r1			/* r1 is a bounded scalar */
>> 	15: r9 =3D r0
>>
>> Loading it triggers a verifier warning from reg_bounds_sanity_check():
>>
>> 	verifier bug: REG INVARIANTS VIOLATION (alu): const subreg tnum out
>> 	of sync with range bounds r64=3D{.base=3D0x0, .size=3D0x0}
>> 	r32=3D{.base=3D0x0, .size=3D0xffffffff} var_off=3D(0x0, 0x0)
>>
>> What happens:
>>
>> 1. Processing insn 14 (r0 +=3D r1) in adjust_ptr_min_max_vals(), the new
>>    offset is computed into dst_reg's var_off and 32/64-bit ranges.
>>
>> 2. Because pointer registers do not track 32-bit subregister bounds,
>>    __mark_reg32_unbounded() first sets r32 to the full range; r32 is
>>    re-derived from the offset at the end of the function by
>>    reg_bounds_sync().
>>
>> 3. On the unprivileged path, sanitize_ptr_alu() is called and, via
>>    sanitize_speculative_path() -> push_stack(), snapshots the current
>>    register state and schedules the next instruction (insn 15) to be
>>    verified directly as a speculative path.
>>
>> 4. That snapshot is taken between step 2 and the final reg_bounds_sync()=
:
>>    at this point dst_reg's var_off still holds the (const) original
>>    offset while r32 has just been blanked to the full range, i.e. the tw=
o
>>    are out of sync. When the speculative path later verifies insn 15
>>    (r9 =3D r0), the inconsistent state reaches reg_bounds_sanity_check()=
 and
>>    trips the warning.
>>
>> var_off and the 32-bit range must always be consistent. There are two
>> ways to keep the snapshot consistent:
>>
>>   1. sync var_off and r32 before the snapshot so they match, or
>>   2. leave r32 at its original (already consistent) value and blank it
>>      only after the snapshot.
>>
>> The whole point of sanitize_ptr_alu() is to insert a harmless masking
>> sequence that keeps the access in bounds under speculation, so the state
>> it snapshots should faithfully represent that. Take approach 2: move
>> __mark_reg32_unbounded() to after sanitize_ptr_alu(), so the speculative
>> snapshot keeps the pointer's original, consistent r32. The non-speculati=
ve
>> path is unchanged: r32 is still blanked before the offset is applied and
>> re-derived by reg_bounds_sync().
>>
>> Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks and sanitiz=
ation")
>> Reported-by: Hiker Cl <clhiker365@gmail.com>
>> Closes: https://lore.kernel.org/bpf/CAGM=3DxGB1fJ9kT8XTitVo74B0WGqgjkoUH=
dLwzytwV0AyqeVApw@mail.gmail.com/
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
>>  kernel/bpf/verifier.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d17f14b35b79..d79038a8da10 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -14558,9 +14558,6 @@ static int adjust_ptr_min_max_vals(struct bpf_ve=
rifier_env *env, struct bpf_insn
>>  		return -EINVAL;
>>  	}
>>
>> -	/* pointer types do not carry 32-bit bounds at the moment. */
>> -	__mark_reg32_unbounded(dst_reg);
>> -
>>  	if (sanitize_needed(opcode)) {
>>  		ret =3D sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
>>  				       &info, false);
>> @@ -14568,6 +14565,14 @@ static int adjust_ptr_min_max_vals(struct bpf_v=
erifier_env *env, struct bpf_insn
>>  			return sanitize_err(env, insn, ret);
>>  	}
>>
>> +	/* Pointer types do not carry 32-bit bounds at the moment. Blank r32
>> +	 * only after sanitize_ptr_alu() may have snapshotted dst_reg into a
>> +	 * speculative path: otherwise that snapshot freezes a const offset
>> +	 * with an unbounded r32, which later trips reg_bounds_sanity_check().
>> +	 * reg_bounds_sync() below re-derives r32 from the updated offset.
>> +	 */
>
> Nit: comment is a bit too verbose. "... otherwise reg_bounds_sanity_check=
()
>      might hit some constraints violations" should have been enough.
>

Fixed style and verbosity while applying.

>> +	__mark_reg32_unbounded(dst_reg);
>> +
>>  	switch (opcode) {
>>  	case BPF_ADD:
>>  		/*

