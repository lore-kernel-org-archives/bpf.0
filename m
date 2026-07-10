Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534925B08E
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704201; cv=none; b=A6qDVaqO0GFmd96oPmIVaLMj0u1XiET8pczFNW15oLne1peOxfIRPW5vA6FvTotZlwEF0u0/zfdD9x9oR33Oau7LMRoni5Wx/1gkvd352JyGACvL9LgzGSnGfetWVcTI1djrh3iTux6MeVJyaadSm257XXUvzjgLtGPfw2Ruwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704201; c=relaxed/simple;
	bh=HPJpattlVsDdRbwLjSNSuhzReWzzEtHwjZF7eIfoz+U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=NGMTVRpCq6yJAmYTSOckkb7jCSlC+3d5Z3YJ3MdIblklY/cGbY77TbgD2sO2HA6sI8eGGSHibMQXzXxOKC/Q5fW3TgInfTMhS1ufQHYMIvs0mudMLRzySOzrsdO74yIGt7TFtbHglAqTIGdTAj7vY4CDFpZIMZyQ5B5pUK0b85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSRqTIhN; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSRqTIhN"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-493b567a019so8851815e9.1
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783704198; x=1784308998; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mbH/pNo5nBIg0m12T3uLhjHL/lK5EzsPyhTCOwhjdSU=;
        b=rSRqTIhNJyZNXq3x5fexdQKyx6NdOesevDb0Df2JAq76GsWxIjS56C8pi5wAuhDpAI
         h5bV42txdSd3V2tdkKFDOku/pCAeFK+b2RP13RtuNQRYdl8l2mQycfhRL3ePbPilacyy
         mNtrbiKBieB7Kg8QvlpF4SqPw49exGbK+Pfr4ZlQNTwwyGHA/0O4/w556E2Xem9Bqc9O
         ASAZmXZfmzV52Arr/yNAvshHehMjuKNYV/nMvJmU6JwSlwiVlDLp1R3WqTnAWNX6wtxg
         sBU3+3SX9vhVQlwwPKv38djn8E4/1C5k6TbvWXk56p6A2xRMowv0441ewmC0BSkZ54LI
         2uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704198; x=1784308998;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbH/pNo5nBIg0m12T3uLhjHL/lK5EzsPyhTCOwhjdSU=;
        b=pokoK5xHUeMfKOciK65XdsbXO1KoOPXBdnTQfXgXtcPqimQAD/wNJBuU4vSYEUw6aI
         R6iS0os9sI0v9gcAcQ74V2E2iuPV+8vieZUFUpvSULtqmJ9Fg94hh/hAWaDNqrx/DeZ7
         meri/8YPD3F8MRAMgoN/Ca2EFKAWsZxK4rNl6ZmAxrQSImFqKIF2mJb6uYjbpsb9vSQW
         s1UiNBnCW8rZuSj5upUErU3ehtUVMUgXIDaNrQxjGq0zahkk0/dG2tN1ltDevj7W3wWR
         JlOZ+U16nNYGE+JUUHv7UFugU/dQmUsiXzxuVyz5nYSQtFm/rGxPxmo3METH1/ST+GUi
         a/tg==
X-Gm-Message-State: AOJu0YwJFYvDs6m7HbVVfn+h9+X7vBgC6UElOenzrsIiEIoGGdoplp5V
	num7Ee6Jr8cptethHzL2TSlxAXQh3RIsiP/SS7HgF671Z5yX0LNr4KoarOkSvidL
X-Gm-Gg: AfdE7ck87uxjjwVXI2dJ8zK2CTJ/G7dsHFPIbfqgjGrLI1q+D6ACnXyMX1Id+sjCtEI
	pHQPdSp4R+0565oCHmz/h2pY14xTYwMiksm3SeGP8lw7B5i5JissHnXznr3U1pL4bTiao1qpJAn
	eQvuowPKfl1sK+ZAOmWM4edVDhA/+8yMvf/BITlyR7RxtmGE6k+lGFTRl17thU2Qe/3n0R4FxUe
	pqBIAtP2YnS3tT0NHJScAjObQHqn3nMXzQgFu/bjDN3xIlUNANLFM9yTD0XidyV+KXVY0SuMl69
	UdPNSRpDO38jPCfwlttgMgRBV8SlkPH8In5mImfjl5KshJXtyk/8TdS71vW5AP+p1dPXgGwshp0
	bR3IeywIUlAjKMHiCTPT2rnK0bM4aWul+rgONyyhQx4zKD5dGFT555Y0vBosgq8uQbpQ+GvSWDj
	s/OAupD0REsWR8hrqQQoxnbszLdV+F/e8FfhKXTI2ZYXNgdtDKruHlZ68r22flEEeo9O0lbAjG4
	KT3Zcx91b0goGSdvQB5inNNI9uoROlN/VQsQg9D1B1ViqdaL2d6MZY=
X-Received: by 2002:a05:6000:1a8f:b0:47d:eee2:e19f with SMTP id ffacd0b85a97d-47df0797a95mr16683223f8f.33.1783704198257;
        Fri, 10 Jul 2026 10:23:18 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm62113136f8f.27.2026.07.10.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 19:23:17 +0200
Message-Id: <DJV2D826YVRY.WSTQ4Z6CFX1I@gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with implicit
 args
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260710005902.2234832-1-ihor.solodrai@linux.dev>
 <20260710012112.577F31F000E9@smtp.kernel.org>
 <ce047740-79fe-4fc5-a118-40252b169be8@linux.dev>
In-Reply-To: <ce047740-79fe-4fc5-a118-40252b169be8@linux.dev>

On Fri Jul 10, 2026 at 7:08 PM CEST, Ihor Solodrai wrote:
> On 7/9/26 6:21 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>> - [High] Accessing `btf->kfunc_set_tab` without holding a module referen=
ce causes a use-after-free vulnerability.
>> --
>>
>> --- Patch [1]: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with implic=
it args ---
>> commit 13df91bf669b3a55c459c1663fbf726f9f52bc5c
>> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
>>
>> bpf: Fix tracing of kfuncs with implicit args
>>
>> A kfunc marked with KF_IMPLICIT_ARGS flag takes implicit arguments
>> (such as bpf_prog_aux) that the verifier injects at load time.
>> resolve_btfids strips those from the kfunc's BTF-visible prototype and
>> keeps the real kernel ABI in a counterpart _impl prototype.
>>
>> Link: https://github.com/sched-ext/scx/issues/3687#issuecomment-49066941=
06
>>
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 64572f85edc83..20aeca6b4f95c 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>> [ ... ]
>>> @@ -9114,6 +9114,26 @@ u32 *btf_kfunc_flags(const struct btf *btf, u32 =
kfunc_btf_id, const struct bpf_p
>>>  	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>>>  }
>>>
>>> +/*
>>> + * Return the union of a kfunc's flags across all hooks.
>>> + * Unlike btf_kfunc_flags(), not restricted to a calling
>>> + * program's hook. Used when attaching to a kfunc for tracing.
>>> + */
>>> +u32 btf_kfunc_accumulated_flags(const struct btf *btf, u32 kfunc_btf_i=
d)
>>> +{
>>> +	enum btf_kfunc_hook hook;
>>> +	u32 *hook_flags;
>>> +	u32 flags =3D 0;
>>> +
>>> +	for (hook =3D 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
>>> +		hook_flags =3D btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>>> +		if (hook_flags)
>>> +			flags |=3D *hook_flags;
>>> +	}
>>> +
>>> +	return flags;
>>> +}
>>> +
>>>  u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_i=
d,
>>>  				const struct bpf_prog *prog)
>>>  {
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 6515d4d3c0032..fde11a2f6869a 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>> [ ... ]
>>> @@ -19121,8 +19146,8 @@ int bpf_check_attach_target(struct bpf_verifier=
_log *log,
>>>  		if (prog_extension &&
>>>  		    btf_check_type_match(log, prog, btf, t))
>>>  			return -EINVAL;
>>> -		t =3D btf_type_by_id(btf, t->type);
>>> -		if (!btf_type_is_func_proto(t))
>>> +		t =3D btf_attach_func_proto(log, btf, btf_id);
>>> +		if (!t || !btf_type_is_func_proto(t))
>>>  			return -EINVAL;
>>

Also, why not do it for BPF_TRACE_ITER case as well? I just feel keeping it
consistent may outweigh figuring out whether it's necessary in that case or=
 not,
etc.

Please supply a cover letter in the next version too since you're sending
multiple patches.

Thanks
