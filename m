Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5D202C48
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084273; cv=none; b=IyWLK1Pi506xZ02QeZBfXnwoXIt7YdCxcpL/xKK+Lqltih23UzHwJoTNcnNvAWd3ZkWvkEjYjCuZCKNhYJo9oos99zq0wPNAy4Y8FHXosf4lpY6QFsN2TqM3zUF0jlWmYDoyVz5bdcQKrpX7W7J4m9jtb5gFDMvFx7UDLvC2TJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084273; c=relaxed/simple;
	bh=2PH8DwnVhBn0N5l25yCK4kjF0hHScCgi3X5B6+H3j5I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LNvYt+YfAIB8UZ4qIZoxffM+f2/OCH1+TumC3nolD6H4x7kRclAOknLkT82Ah8j/m+VBtvChDPGzSIAfY15fZGU8KO69ixsrxOFbemHqYbF1xK1qWGgd54+ml/t0fXejkMmA39jnbjd1ULy02lfXUS6hralGSwRgXQdDcrA3QDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=CR81TZGw; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="CR81TZGw"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c07bc2ad13so386607385a.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 18:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770084270; x=1770689070; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbEBx635SR9k3YtuPgIJgSH902bQQCi/UAKy8PsFrl0=;
        b=CR81TZGwFI+upakhi3uohRQMFn5RygpzeXmx96K15400NkHp+yX39z5g1KjH6VYky6
         IawZFEQe46h57wl0PfWvY39GZxdI+oVYXvPTOgH+A3vEmn0SE9cAnogtC72IqApAi0Iv
         Chxnthg7Uwxm90RJnbsCWe1HOn2lXPQzF1mCgLZ+W7h5LDaZjsr+ZHymN+CThov4mbXO
         A4UC+Ow/nQRnwc5IMhpqYzBldnm2DAjLJ114Q/g9i1F7L5sHJwkRSTgMP8/m1r/LxwLq
         vJwI6jF2a0RDD+UzruC03SETnUVWN4ovpv1hWYnY/yEfxYERKjdgG4F0T1Fe6pdN1EoG
         3m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770084270; x=1770689070;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbEBx635SR9k3YtuPgIJgSH902bQQCi/UAKy8PsFrl0=;
        b=Hq2VJexbDUw0ChpiVsxIlndS+32R5QcVIhqkqfAO1KYb6HKOkB2o0CGhNr9H+UqxaG
         lt4QShJeR9kXd3mXGNgKvpAb7s40AuEhAetgO+meFUev1eWUMViCb/kFVU6hVTWQolB0
         bODwZ7COQdrLdgUadH9VxN1I/lesVJGjqmWZ3kzydOHz1bboUpRU3TIC3i0iTxzff4TM
         fyPX4w3xKqF+tmtOYONU8KgLrZMEGGftVy1ETnfvaldIUz0aN7LGC36NhWO7ZwR5nuXn
         6SHen1DY9hRA1vzEB1ube/gARIoqcQysuzAtV1xs6TE1cph7OjHqdxodRfz6C0V+pvJb
         o8yA==
X-Forwarded-Encrypted: i=1; AJvYcCXwZdSCS/dsmBIjN2LotNDYyifd5zGQ8oa5UsU07FIFSbsyGxAw8fFtIBiELq+gjX5eXvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4jBlGtpp57ftXSAK2TwuvqL9V88m/tQnXOsIdeCIvz3Yz4K/5
	vkYNU0625BnJwTBU1uSOxZZdmZgMcSJroIyDO1SmvARfQvPX3kSCVEjreiQNSexbdNk=
X-Gm-Gg: AZuq6aIxPokaPAE/Ua13CJasCZHShOsZfu2wviA1aD8PhQvVOWLlrZBhAmdtmA06Uve
	sep7q0DukB8+3L63razGTc8B4nOddfNEgwo8rnrnjB9mLJHZfl/nAc8izaNdBvVkzeR7eKozVsZ
	4srziL1gz4CVRmUC1r7B7hY5DOkDxAdIhPwVY0CFQXLQASwXZdAndoM2yA4A+0sFvZHg7NCcj4Y
	K7ODLPO/8RmfADTjmLBsgPquuEQODrx+qLwcQ6PDQnF+0LVX7bLevSybn556gGBcNdrPmkSmtPc
	HzJLgTyQnyag4wQaVyTXc+9Wz0DgvwdwfkC+gen5DWefSUF4tBE+boynHKPkLf6jtDXglGLTmot
	X6e9ZNhWV+hHLUy/copL8PehfpVHrdHqgvEando4a0S0yp+YSwYHS0F2X5nnqoMaabYXaNUwKKq
	yIQghmGQJcyzA=
X-Received: by 2002:a05:620a:290f:b0:8c6:edca:1905 with SMTP id af79cd13be357-8c9eb224f5bmr1601519185a.12.1770084270236;
        Mon, 02 Feb 2026 18:04:30 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca02eedf76sm624692685a.55.2026.02.02.18.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 18:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 21:04:28 -0500
Message-Id: <DG4YI75AFYJQ.FMENV4LELNM4@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: Bump maximum call stack depth to 16
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260202233716.835638-1-emil@etsalapatis.com>
 <e3472b618ca3f4c00a78556992af9c819c3a6c93215358ab2e8d8264a7901e7f@mail.kernel.org>
In-Reply-To: <e3472b618ca3f4c00a78556992af9c819c3a6c93215358ab2e8d8264a7901e7f@mail.kernel.org>

On Mon Feb 2, 2026 at 7:19 PM EST, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 8355b585cd..9f7fc990f3 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -317,25 +317,25 @@ struct bpf_func_state {
>>  	int allocated_stack;
>>  };
>>
>> -#define MAX_CALL_FRAMES 8
>> +#define MAX_CALL_FRAMES 16
>
> [ ... ]
>
>> @@ -346,7 +346,7 @@ struct bpf_jmp_history_entry {
>>  	/* insn idx can't be bigger than 1 million */
>>  	u32 prev_idx : 20;
>>  	/* special INSN_F_xxx flags */
>> -	u32 flags : 12;
>> +	u32 flags : 13;
>>  	/* additional registers that need precision tracking when this
>>  	 * jump is backtracked, vector of six 10-bit records
>>  	 */
>
> Was LR_FRAMENO_BITS in kernel/bpf/verifier.c intended to remain at 3 bits=
?
>
> The linked_regs packing uses LR_FRAMENO_BITS to encode frame numbers:
>
>     #define LR_FRAMENO_BITS    3
>     #define LR_FRAMENO_MASK    ((1ull << LR_FRAMENO_BITS) - 1)
>
> With MAX_CALL_FRAMES now at 16, frame numbers can be 0-15, but the 3-bit
> mask (0x7) will truncate frames 8-15:
>
>     collect_linked_regs():
>         for (i =3D vstate->curframe; i >=3D 0; i--)
>             __collect_linked_regs(linked_regs, reg, id, i, j, true);
>                                                        ^
>                                                 frameno can be 0-15
>
>     linked_regs_unpack():
>         e->frameno =3D val & LR_FRAMENO_MASK;
>                           ^^^^^^^^^^^^^^^^^
>                           mask is 0x7, truncates 8-15
>
> This means frame 8 becomes 0, frame 9 becomes 1, etc., causing
> sync_linked_regs() to update registers in the wrong stack frame during
> precision backtracking.
>
> The comment at linked_regs_pack() still documents "3-bits frameno" which
> now conflicts with the 16-frame limit.
>
>

The AI is right, we must also adjust the packed linked register masks.

This complicates things, we now need 66 bits instead of 60 for the linked
registers and cannot typecast the struct linked_reg into a u64 anymore.
We need one more byte for this for the linked registers.

An option is making a new struct to replace the u64 for linked registers
with a buffer of 7 bytes, like so:

/* A buffer of 72 bytes to store linked registers in a packed representatio=
n. */
struct linked_regs_packed {
	u8 data[9];
}

struct bpf_jmp_history_entry {
	u32 idx;
	/* insn idx can't be bigger than 1 million */
	u32 prev_idx : 20;
	/* special INSN_F_xxx flags */
	u32 flags : 13;
	/* additional registers that need precision tracking when this
	 * jump is backtracked, vector of six 11-bit records (66 bits).
	 */
	struct linked_regs_packed linked_regs;
};

This actually brings down the struct's total size down from 24 to 20 bytes=
=20
(tested with gcc 14.2) as the struct does not need to be aligned to an 8-by=
te
boundary. It would complicate packing and unpacking the linked registers
though, and we'd need to see how the new code affects verification speed.


> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/216107=
11856
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit follows standard kernel conventions=
 with concise technical language; the oversight of LR_FRAMENO_BITS is chara=
cteristic of human error rather than AI-generated code which would typicall=
y catch all related constants.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: LR_FRAMENO_BITS remaining at 3 bits causes fr=
ame number truncation for frames 8-15, leading to incorrect precision track=
ing in the verifier which could cause incorrect program acceptance or rejec=
tion.

