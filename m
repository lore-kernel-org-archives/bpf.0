Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795832210;
	b=13c4r9U2Rd/CrDOtfLlWsXmK6YlYPfu0Y0GuffIT75F8jYQh+4zYAEIi0Kl4B/9kVNb/
	 5q9PRj9eAhk1Q6emK0u1FuLA4O9rn7GLgRtZ0F+0WSFLykmKt0ePcx2wd4fBF9ditO/RZ
	 EEGA/oACAgF428N66c8YkTuu0In8JgEQSrsM12Pwas1JJaMkJndcPLop0E9gGngUmcXjh
	 ql69qVBxqM8ZYSl3FjbMC8LkAoF5/ij7/w+JB9IKDoWLhmsVnNB85p78ZbMXI5ng5TXQc
	 ImsIfjN1TRqJso78YRhVh0V6NNDn1Tv17i95wH8v/avfTVd3oQHBI7jdGNZGunpP3qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795832210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=yiliGXm3f+G64tFZg1ZTzyN0pIV3IaS5Gv94kJDg6uc=;
	b=lUvNXm+zAX/niJSSL/7wHFjVriOzu9aI11Ah5rcbrmmpMNJf5OadZDUuvnLtgRIu6XAP
	 k7ysPnXwlg9LEVBqNPl+x0njNS2s7+/N6gSIsOspPgSylcpgdhoMMlP2cq7ayxSKRFI/j
	 o227eU6EdsBusyITruaF5q9n8hj/r62FyBj2koewDAPDgzZMMOhVuSqdSA0iuF+4UkICo
	 X758j0ljd4RX+QufvMGl5duoFuOMfQFQ+nQxlXwngN8BsQuf77F+vs0WfFeqbmaYScynp
	 ooph7n2WFfTxqIEDtsYtpxOVVqhf0ngHMx5yYD8oI8nS+79tAcQJFgiWIyEQUueYVnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FeXVHrlw;
	arc=none smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F657606A69F
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 02:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F657606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FeXVHrlw
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-718facffeffso813189eaf.0
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 18:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795832206; x=1796437006; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yiliGXm3f+G64tFZg1ZTzyN0pIV3IaS5Gv94kJDg6uc=;
        b=FeXVHrlwlU89nBzMm2vEo903Zl+YGQwovls0PjXBvidkAz/jEv3EdQ8T6t/zxzXDIM
         6eu1Tm2B3fg+3Nx4L/eVZY/9m8yQcewvd2c0BUEHgvhpf8S3vhPUK0up8Bg6RUjP/2CE
         JFyMNzKcmESc2/y97mqn3tnDR1tt1IHRr8VzxrLczPjbqAxixvC47c3vwuq8hi4oYUo/
         KoQuE6q4X72VhzVimlMgoGblWoN+oA3HRH2RN+G6ULAZB07o+mse9PiaMxS5Np4IZetQ
         2L9boS6BfoQZU6QE+MYJtfkvnwNZ01EGxmzEnyaZ57ghUIYoCjwSP9b3LDlAqpuFPODn
         N/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795832206; x=1796437006;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yiliGXm3f+G64tFZg1ZTzyN0pIV3IaS5Gv94kJDg6uc=;
        b=mY2Btskn0GFuqXD4T730zFTPTEtu9PhLyEKYQxKpMnN3AiHmBiFYaUR8L4lfvRcKd3
         arxYpxUeEm0fL/CnVW+VRbvLaGEdwyThQsQn2YNUR6WbxCZfbVVY/1J9lxb2N4FMrq59
         eWc64/u9QHXnAmsSQQK11QRkr9q/rJuWuMta8m0Wm3s4WgPzrCJJOcZFAU6xAMQiM4mf
         vBnOyKBmW1clsRkQd1BvojreXp1ZRuO7RktxR6dKPv0rBB5U6NJYD2PdD1gMrRyAzFCl
         /wJN5+NEwRrCxrdRQSzQbGPkrd/znx1WGlEj9/E46agqXTE4G87seAbjHQssYqPc1m5v
         I4Sg==
X-Forwarded-Encrypted: i=1; AL+hErF6RwYHqlVib7szrFIn1lVwd3XB71sbWVAiNqa14E1cjOojp0ea0Iz33CqtYDX0B9rNvvk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kp1ybhZ6Jp9RPDQdeE5BvUBe2qYbIZ8lbAFcA0GzNTauSU4X4
	ff3R4mMLhEIqgfsDLX3j8fbLFACjpZiO8GE0Ihw+vhEXiqWljiRXqndi7J2ZZeBcmOE=
X-Gm-Gg: AZFdTZcEeCrdSQO0oJVA1L+saUaMcnSglnmG6Doe23zZ6EDsvWbCBHXgcpKT8ReQNhN
	apce0oFJjq6zj1rmuX/f6FOx9/sA/Pdue6VlmdC5Q60eCqCCxQZslPxqT566dIDjit6cg6qf49D
	PjoUwGRmDLpDmhoFYPCzvDLRjTHqViJjQQrb5TUX5dFCY0PbCKKty91xjyA9WIxEbLbXNdA102m
	tVdGeYDG4OyjqPb5bhhdMosCbUbWWPQtKOB586YO8DjCuZ50d+Kx5rvNXroMeegPRXG/m8ESzAh
	j27ZfQ9l2fX3JDynJafImwRyvFZBSbGD6kxSGQPlJ+j1QWMBj4aVIfLcjL7Ce1yHy/lrJuL4A6e
	wh71vJ3PCOHmlF9mGNJUA+wlUnFI555j7jfmf2/WGHjSMCoXfBUzNr/K4DzN3INWfDVKIcbHEnc
	otzwuFt43c1VOZBGVgogDs/5dgt37kpWsKuk5GrX0mxjNAzZjwCmrlgbcpE9IVIbjDFWyBNTbix
	ZLXsE25EA8D0+1VbkRlFCf5/2uNJE2wX2niEmWMWj3J59uGEzQMjY3s03QoV0vA2PB7zt+ECs3P
	TpJ/sK1VwlMqWRiz4orltVudWBGFUgrcT2CbL0bz8WVHCRAe2jFD6V1pkvC+aT6yfkaAd0Y+ZAL
	4IqkTzexxbQQbFmrktIvF95D5QhXD3XFjIngM2w==
X-Received: by 2002:a05:6820:c5c6:20b0:71a:fb34:af74 with SMTP id 006d021491bc7-71b39438914mr13911055eaf.27.1795832206071;
        Fri, 27 Nov 2026 18:16:46 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60891cf6sm24863163fac.13.2026.11.27.18.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 18:16:44 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 03:16:43 +0100
Message-Id: <DN6HDX0GXICR.JK53Y1GEJOTT@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf, x86: Skip the PROBE_MEM address
 range check under SMAP
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <cover.1795829324.git.memxor@gmail.com>
 <f2beca95aa1eb81f00c6baf408c681063e13ce83.1795829324.git.memxor@gmail.com>
 <sashiko-outbox-238410@kernel.org>
In-Reply-To: <sashiko-outbox-238410@kernel.org>

On Sat Nov 28, 2026 at 2:41 AM CET, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] bpf, x86: skipping PROBE_MEM range check breaks
>   flex_array_far_join() test
> --
>
> commit 519a06c0e9f33f01690a25837946e3048111ee57
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf, x86: Skip the PROBE_MEM address range check under SMAP
>
> This commit omits the x86-64 JIT runtime address range check before
> BPF_PROBE_MEM and BPF_PROBE_MEMSX loads when SMAP is enabled and the
> program was loaded with CAP_BPF, relying on SMAP and the page fault
> handler's exception table lookup instead.
>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index d51ae52fef719..019e5da72136d 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
> [ ... ]
>> @@ -4862,6 +4870,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_v=
erifier_env *env, struct bpf_pr
>>  		addrs[i] =3D proglen;
>>  	}
>>  	ctx.cleanup_addr =3D proglen;
>> +	/*
>> +	 * With SMAP enabled, a PROBE_MEM load of a user address faults (#PF, =
or
>> +	 * #GP with LASS) and the fault handler resolves the exception table
>> +	 * entry of the program, as for an unmapped kernel address. That looku=
p
>> +	 * only finds programs in the BPF ksym tree, so programs loaded withou=
t
>> +	 * CAP_BPF keep the address range check, as do kernels without SMAP.
>> +	 */
>> +	ctx.probe_mem_check =3D !cpu_feature_enabled(X86_FEATURE_SMAP) ||
>> +			      !bpf_prog_kallsyms_allowed(prog);
>>  skip_init_addrs:
>
> [Severity: Medium]
> Does skipping the range check break the flex_array_far_join() BPF selftes=
t
> on x86-64 systems with SMAP enabled?
>
> tools/testing/selftests/bpf/progs/verifier_btf_array_access.c:flex_array_=
far_join() {
> 	SEC("tp_btf/exit_mmap")
> 	__success __arch_x86_64
> 	__jited("	leaq	0xa00000(%rbx), %r11")
> 	__naked void flex_array_far_join(void)
> }
>
> That test is loaded with CAP_BPF and matches the "leaq 0xa00000(%rbx), %r=
11"
> instruction from the PROBE_MEM range check to verify that the load was
> converted to BPF_PROBE_MEM, so its __jited() check fails when
> ctx.probe_mem_check is false.

Yes, this was an oversight on my part. Will fix in v3 respin (after some ti=
me).
