Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C044F560
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725380; cv=none; b=QmbUNB2Y3+jLWH2JFOtQkYJaTQxpKao/GbdYtlyd1fFT64sm6WyVWfkbGkRRR4uFAKi01hnY4yQoqcfC6R7gRoz2m4yXF8TCtqXAtJXtFBYgYY3XC7FmhBvFZwA4fb02gFALzy7LYfsOc54upumJLGJh3uVwFXDRuss0QITKfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725380; c=relaxed/simple;
	bh=PpzUVmnb0RHTTlK5nGUqIJUL2D/0Yz9Gl8OEPsGQNzI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=RWCxADrPMRYKQm90UW768g5L09wTF13P/v8briR69tQzJCgIft2mUYupHzWXS1qu/OPnBHpCS2j1gWYVPEj9/SwX5zKpG2xYZVQaNrtsPFTEatjzQwl5z+WI2CX4bGW6u4voMesAlk+aUUDJOWE6fJBpiBGRU/FTfX/WE/FsGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey9BBdcf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey9BBdcf"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8899a204034so421495b3a.2
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791725378; x=1792330178; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6l42TM+dhfrW90rQTlCjlU8QAkJdzjjCoOY+TvZrI8=;
        b=Ey9BBdcfC4mlpEyc2LEcCFDIkQqOLi/bhXbbPPcaZG3Z1+r2GUt/8u0SZPqXotCknQ
         KvIW9pm3uUKyvVFbFzwTNKqP6jj/0NiNmscpSHH3qr5bGpsnjF/OsMTKQQ6QGyqnD4/W
         lTq6K3fGNr2CSqi9vcZ/dMae6m1N1B4EW9gjljfrRnSKGkUNgOUmsamkgVewGOvuYckg
         CYt9l/Ni4IoJzJfcv4wYlDMMZv0B6UsP5BcJ8e/7QyBfxeOKb2TQ3TavTx8JaLMVl0kd
         IhEVZBYe8ASr0iBA7RQod9lQs3XkJXQgnvhXcpiGJADp5KwayGAYjghHZPWWdYDXfPUe
         EZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791725378; x=1792330178;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6l42TM+dhfrW90rQTlCjlU8QAkJdzjjCoOY+TvZrI8=;
        b=tSVw8127pogEDMZiM+KWhAsgBVS9U8XoEgOepCtZrVMOZiqCTKXAgflLsuo+I7I5+W
         aGV7Cq2rLij7Ll9cR0NMrTUVWXzvBq8bldidzEmODzKR4dXwQjDhBE5fpMwP3i6zZF6/
         tsd400ZaIxwnZa5H+E9+OZFdxJwtu5R6UIHt6AiJUdnToz+6DF5yzNZrD7y37jOQ2x0w
         FX0CTgv5PnRW9sFTA7StrcgWBgpdvTp9qvpW4iqMAjAwoAQGNg0YiweHMxq9WMeH/0rH
         IAsPtg7crlvcBXkeh15MCqp5aU6qV8muGdk1SECNhxnKGDnulo7Vfj/t5qdnbeak9Mo9
         EmPw==
X-Forwarded-Encrypted: i=1; AKwUvBwe/gX75eF9t0HEfJPhpnxFIv1x3ez7tXZtQ8TsZNelfQJfPBwrRcg9y7NHG9eNX/lN3Kw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzDEl/TdnzqckwQVWDjPMdxXlvpMYXE2jWoieV5SlFxWiJfLT9
	U8NCgCnG1Z/DvENU0dvRyMOhjr4yurUN6A3HY/RK7EsNytw9KWn+4PmL
X-Gm-Gg: AYBFou1zS81iRjl5RScGg25ZThmGD5svfpKDWEIPYg206KhFMUWNOQV1kkcrtg+n1Iq
	gUYdmkRm1LifjBNYk+OBS3wz4PQUOV7qKZNa7QPz5UMKi6O2efU4lGetB7zW/GYsKuWZYwy7Y5W
	e0427WcRDsp1hFNeG9g72sf5x5W4f77CMt/A3m1/+ZTq3MJhvQLcgC5RphuL9eiPO5Zz4uxG/6c
	tXNKjBf7D8PBDh6LOxXZB6QS9DJQKJDKqAnWZ1qYmYahwlBVvR/051ls9KLY9o/ARS7xWA1DS3K
	fUqRzfucW7v4KN6M1XLXPiSEZzAVp7joIlxQNulDt8yfoKGY54ddCOHuCGoDCDiUD4o15u1LZ2i
	2j32Nk23A8smYpeNIf+IO9aM5EM3VdDoDEsg77cSohaR8m4WSSCp4V3zqAHWOYOU8r3PcES9Eh8
	YGoHMbC9YmMrobowlAf5evJp+dpesFwL8kbd7vgoJnfYNppiyGEKe33YOW4RRaLTcPMlcirOhY1
	y2giPcc1BGrCAZGKbmpGze+1Ic6mQc3H25U7cUxGvybRo99yilMIHVgMT0l0ESacxrEJeL0fqC/
	wADM
X-Received: by 2002:a05:6a21:468a:b0:3dd:ff70:1426 with SMTP id adf61e73a8af0-3e16bb09ae2mr5494250637.3.1791725378161;
        Sun, 11 Oct 2026 06:29:38 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9d4df08sm3293677a12.3.2026.10.11.06.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 06:29:35 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 13:29:34 +0000
Message-Id: <DM21MY4LE3MC.RAS8LM9O12RE@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/9] bpf: static subprogram arguments liveness
 should use BTF type info
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-1-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com> <20261010-scev-minimal-v3-followups-v1-1-6000e95ef993@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 10, 2026 at 11:21 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> @@ -8829,10 +8828,13 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>  		return -EINVAL;
>  	}
>
> -	err = btf_check_arg_slots(log, tname, is_global, slots_used, sub);
> +	if (verifier_bug_if(slots_used != sub->arg_slot_cnt, env,
> +			    "func#%d argument slot count mismatch: %u != %u",
> +			    subprog, slots_used, sub->arg_slot_cnt))
> +		return -EFAULT;
> +	err = btf_check_arg_slots(log, tname, is_global, sub->arg_slot_cnt, sub);
>  	if (err)
>  		return err;
> -	sub->arg_slot_cnt = slots_used;

[...]

> +		/* BTF validation guarantees FUNC -> FUNC_PROTO. */
> +		t = btf_type_by_id(aux->btf, aux->func_info[i].type_id);
> +		t = btf_type_by_id(aux->btf, t->type);
> +		env->subprog_info[i].arg_slot_cnt = min_t(u32, btf_proto_slots(aux->btf, t),
> +							  MAX_BPF_FUNC_ARGS);

Consider the following...

arg_slot_cnt is not only for liveness.
bpf_in_stack_arg_cnt() is derived from it and it has to be in sync
with sub->stack_arg_cnt, which is still set by btf_check_arg_slots() only.
For example:

  struct with_ptr { void *p; u64 x; };
  static u64 f(int a, int b, int c, int d, struct with_ptr s)

nargs == 5, so the first btf_check_arg_slots() does nothing.
Then btf_prepare_func_args() returns -EINVAL on 's' and
the second btf_check_arg_slots() is not reached.
Before this patch arg_slot_cnt was 5 and r11 + 8 load in f()
was rejected.
Now arg_slot_cnt == 6 and stack_arg_cnt == 0.
The load is accepted, bpf_jit_supports_stack_args() is not checked,
and bpf_out_stack_arg_cnt() returns (u16)(0 - 1).
x86 JIT emits 'sub rsp, 65520' in the prologue of f().

This scenario looks bad enough.

Also btf_arg_slots() returns (size + 7) / 8 for a struct of any size.
BTF has the source signature. The compiler passes 48 byte struct by
reference or promotes its fields, but here it's 6 slots, so
check_outgoing_stack_args() returns -EFAULT and the prog is rejected.
It was loading fine with this subprog marked as unreliable.

Why is this rewrite needed?
prepare_subprog_args() was calling btf_prepare_func_args() for static
subprogs already. When it succeeds arg_slot_cnt is exact.
When it fails the first call marks the subprog as unreliable
regardless of what is in the registers.
So the liveness.c hunk alone should be enough?

The other patches look good.

pw-bot: cr
