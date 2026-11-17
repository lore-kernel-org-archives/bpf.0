Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794945917;
	b=jYSH/E2k6rt/aESNff4PHO/Ix578QLVqL0wbYjO93ogjjlp/FtmQZp6R9nbTQQ0tUfKt
	 LzmZ94XeIsyVezAXU9QTqWO54KKlCQkSTIAi8Lkgnt9/ZC2PMG+Z1lOzPEky3ZyvwRqfY
	 AS3stBEn38Mu2Yr4CuNg/uS//+DMLBsL77S/xfHWjdU4J0nqLejj9zJUteNgmrvjqVOMQ
	 K1W95FUIToI/DmACJG/4ZCjJ360Csl+Abr5AOx/wzWHnIOHvTHjyTKsISpXj6uLBov1c+
	 cUaKmwyGTRsEcgvE0pc0vkJ7xeL02a79DDyw8w3z3bzzdPN5qjBdUuNOqympbpldilQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=4cO3UmUBrczuOUy/g6AjUySUkDkEjcfHW9TPAfpdBg0=;
	b=nCqiruTlMRMJEgK7qMuFMoB+VWJSMUluvtvwdrpSolJUIxFSnxB0m29+h2ygpJ6u2NOm
	 SN/aEsyLFHfh4v4I4uAXsToyU5lJU7fZlwjQcWn4xcP6GkC55HxyBzK8qKg2udG7IIVbV
	 3Fw4s64A5SJXh/OWddqbzmqfQeK0M8rfXw/ErH3fMP/cu3BxBogNml/9jrw3BBB7CALPL
	 zD0L7hDvsRhvRm0CqL5iCQgYa4ZA8xo/Z9zKBDeVbM93bGVK1zIlgniqRUx1QfOWGBfjU
	 aNgwbyz5Rz/cEQl4k5dEik2gAN4vY3Fmfe+ekXrws0OcsWwCMdBlmWOIjy52OqN5Uzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=scarletmail.rutgers.edu;
	spf=pass smtp.mailfrom=scarletmail.rutgers.edu;
	dkim=pass header.d=scarletmail.rutgers.edu header.i=@scarletmail.rutgers.edu header.a=rsa-sha256 header.s=google-20180529 header.b=M9VuEphQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223660A6F5E
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 20:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C223660A6F5E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=scarletmail.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scarletmail.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scarletmail.rutgers.edu header.i=@scarletmail.rutgers.edu header.a=rsa-sha256 header.s=google-20180529 header.b=M9VuEphQ
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9210f2622ccso1004556d6.3
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 12:05:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794945916; cv=none;
        d=google.com; s=arc-20260327;
        b=irHes/xr3n/UJqUrsGiRKLZ5ND4hlANjHvLXFXc+S8TE+qhZ1v2hE5Hv8NHke9OKE0
         ePiX7Dk6r7P6QTvh+zMsS3xRpy1RyjmAm72V4VP2YdH+PNvJDiuuHczNIX2hg3rqsted
         z9fz4KbjEHKvQn1UohrRfHThR7p/nH154/C/DwjcOtoDMm5Ns5UDKMqx9V14ZEhH5jls
         kLPIzvxXx7XMJia9IIB7Ts/Y307k0uCsVr9v/BtLUg5T7Bdn1ca2B733TwBCzIsgeR78
         CwUaWD4kGz63gAFoSbFmDQ/GC1jmQdxgBkJxMyqdJHEhYwyMCmxqofYIHLBSQOGLX/CW
         Bt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=4cO3UmUBrczuOUy/g6AjUySUkDkEjcfHW9TPAfpdBg0=;
        fh=DVImKLhcKuounm3K9Xgg4J3osERFJhthSzUJqfpBQU4=;
        b=AC5oHHTQ4Ok7VVWuzqh+fcui+Go+cHVT3+PVPv4Z8sOlYGj2boDDAG7RkK0n+IRUtd
         /Anu0WKeGqUsG6X8hLOf3K080Jla1+bHCZd5U/35YKR866j4e0fsSvm7jX6DxB7XgdEr
         ghbtHBWBpFOerkpVP5LpJSe3d78P7KWEv5YmSEafXqzjXGJXi1fAPUnSURByx+vtiDhO
         kw3MZXM2iecOZLLkSEh4388S0I/aaQyp85zYtCJHJhRgeifI3emdBs12OxXTI705yg1n
         mbWVu0h0EqbXRhK9Mkdo861411/+w6y3R5R+eeJ7Uzdn5JWEE2iO/nNU1TBJS9fPyD7i
         3D/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scarletmail.rutgers.edu; s=google-20180529; t=1794945916; x=1795550716; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4cO3UmUBrczuOUy/g6AjUySUkDkEjcfHW9TPAfpdBg0=;
        b=M9VuEphQoHg7NCBgGpYFsNujWvuZ3AizPlKBL5u9EZV/Hi4i9ojzecbLcA1bB6rJP0
         SPonAsJJQoJvzkElOibgRJDlfvUjpJengqCG4ZSZ4J1w5QAX9QA+pyM2MhlKSPm84akM
         f2ZZcZvB7fvpDEYSR9M8Ne3WgYKATx63pW5dzjlaZ1AvrEX3gHQoVtlxzh2mkXOnfc1l
         oAtXLMfVc4MzeCUOoDfoha9vY9UMxerwRbSuuZseo7wGZbOGrbHZFSkADQ54nzHbIiwj
         NHEzaRQdk8iDtxTV13iw1duMNt+IRKPI7QichNxIKUKC/whdNVBUcrwR3U2JlXPRp8aL
         qKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945916; x=1795550716;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4cO3UmUBrczuOUy/g6AjUySUkDkEjcfHW9TPAfpdBg0=;
        b=xHAm7gh0spsahCRAIOYKftogXXvLOZ57Nh0EcXzenMWNQ9uOOV4ZBf0CVP/FsQXJpT
         D9aqh9Hg1iIBIw3u2MDXjuD8Hm7SuRtfddFRyTSQzvbKM+dlWuttt/XqTxvxLhfacpQL
         UE6CMNuMct8iXg2hQuisPDKcy2ASMHWSGbRY7ByTUOZu7bpyEC66p8yXmqORf9pP73ji
         m6SBYtEUnkZbIWYUEpkxXMwZjNjxRyiZgLmHwleznAkDMxBrhybnInqPe99X2C8KxBnu
         CMcY1OPk8+YaihpMrDer/EieOLGXEheoWZsXVIZx/Om+UjefBwr1jKZM2siAm5pft8HR
         S2Mg==
X-Gm-Message-State: APuU4Z8P82T5DHBZTNJ6F96FYrpjtjR+Zjck3BhYPAaX2npVY20UzT4g
	x9/yBNL/h9hGqvBhjjXHYCk+NVr3wSX0tGe6OMk7K5wIw+9SLdTONUKMKXa3HVcH25ZzmcPGfpR
	ZOWhbuU05G+9Lq3HEBVv++GXbmbabMytOBTJJXmjgxAy26arf8wm32JE=
X-Gm-Gg: AZFdTZeRQQNM0z73ZWnsWQh/h3A92mBySXJ6/Zzh4eF+Oc3b1JDbvIinQhGdreuaEtJ
	gjJsUAIwrXZvP6maOeAXemlPY+7p5cW+NSLnpc/ngV59nx5pS/3jn2VGAxNrksk7dB7IJ5g8M13
	kWZ3C8vJJ2mjRGwfDfkSu9eaAPBEZ7cziZF3xr1uXMyrb9Lq4fBDPdXHjg+kYmOPrN9CgwcZ3V1
	6EFK8Le1eZdPzVXpMljEKUG9IFgEp/+VvROHAfl0CP587gKWgl0VTc5VEPmnr24q/7jYv8c0iqN
	qUVrv18MdeMDK2GQiRnEJAyrpseDmXBunTsXr1VdP5NGJdCD5qc34ZNbNvS+T1oTxbPM05hXKjD
	EkfCw455yzPjAqckVgZY4goHo3YfJML6Yj4sfZ3sWqNp7KAw0pIUKwBLT3njG1R3pVWpNB+9rT/
	fitj+SYqYh9bx5Unr6
X-Received: by 2002:a05:6214:3206:b0:91e:8baa:f132 with SMTP id
 6a1803df08f44-92114dec61emr4461246d6.14.1794945915221; Tue, 17 Nov 2026
 12:05:15 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yalu Cai <yc1795@scarletmail.rutgers.edu>
Date: Tue, 17 Nov 2026 15:05:03 -0500
X-Gm-Features: Aa3M54qMvzIoY7GaqYaF3gjZPDyT3jXqYuMzlpOmCUiE5uV2zQJP3ykp7i9uOzk
Message-ID: <CAPUfTJOnoX7NXhtiEW=5k+rCCi=C4=GDk6x0PHRjGkgQbN4RhQ@mail.gmail.com>
Subject: btf_ctx_access() treats a struct_ops prog's member index as an attach type
To: bpf@vger.kernel.org
Cc: santosh.nagarakatte@cs.rutgers.edu
Content-Type: multipart/mixed; boundary="000000000000abed4406607e6949"

--000000000000abed4406607e6949
Content-Type: text/plain; charset="UTF-8"

Hi,

btf_ctx_access() treats prog->expected_attach_type as an attach type without
checking the program type. For struct_ops, the field is the member index.
When that index matches BPF_TRACE_FEXIT (25), BPF_LSM_MAC (27),
BPF_LSM_CGROUP (43), or BPF_TRACE_FSESSION (58), the verifier allows a read
past the last context argument. That slot is the trampoline's return slot,
which has not been written when the struct_ops program runs. Reproduced on
7.4-rc3 and bpf-next (ea80d2afd285).

In kernel/bpf/btf.c, where arg == nr_args, the code is

switch (prog->expected_attach_type) {
case BPF_LSM_MAC:
info->is_retval = true;
fallthrough;
case BPF_LSM_CGROUP:
case BPF_TRACE_FEXIT:
case BPF_TRACE_FSESSION:
...
/* allow access to the slot after the last arg */

For fexit, this slot contains the traced function's return value. A
struct_ops program runs before its member returns, so its return slot has not
been written yet. On x86-64, the slot is at [rbp - 8], above the saved
arguments. The accepted access therefore reads 8 bytes of uninitialised
trampoline stack.

Here is a program the verifier accepts. It uses bpf_testmod_ops.tramp_15, an
int (*)(int), which is member index 25 in bpf-next's bpf_testmod.

SEC("struct_ops/tramp_15")
r2 = *(u64 *)(r1 + 8)   /* past the one arg */
r0 = 0
exit

tramp_14 (index 24, not in the switch) is rejected with "func 'tramp_14'
doesn't have 2-th argument" and "invalid bpf_context access off=8 size=8".
tramp_15 (index 25) loads.

I want to note that there isn't an in-tree struct_ops that triggers
this bug. bpf_testmod
never calls its tramp_* stubs, and no in-tree struct_ops type has a
value-returning member at one of these indices. The matching sched_ext_ops
members return void. This is a verifier soundness bug that admits an
out-of-bounds context read, but I have not found a live in-tree path.
An out-of-tree or future struct_ops type with a
value-returning member at one of these indices could reach it. Loading a
struct_ops program needs CAP_PERFMON.

The expected_attach_type switch should not apply to
BPF_PROG_TYPE_STRUCT_OPS, where the field is a member index. The check
should account for prog->type (or skip this switch for struct_ops).

Thanks,
Yalu Cai

--000000000000abed4406607e6949
Content-Type: application/octet-stream; name="prog.c"
Content-Disposition: attachment; filename="prog.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mwl468wa0>
X-Attachment-Id: f_mwl468wa0

Ly8gQSBzdHJ1Y3Rfb3BzIHByb2dyYW0gb24gYnBmX3Rlc3Rtb2Rfb3BzLnRyYW1wXzE1IChpbnQg
KCopKGludCkpLCBtZW1iZXIKLy8gaW5kZXggMjUgb24gYnBmLW5leHQgZWE4MGQyYWZkMjg1LCBy
ZWFkcyB0aGUgc2xvdCBhZnRlciBpdHMgb25lIGFyZ3VtZW50LgovLyBidGZfY3R4X2FjY2VzcyB0
ZXN0cyBhIHN0cnVjdF9vcHMgcHJvZ3JhbSdzIGV4cGVjdGVkX2F0dGFjaF90eXBlICh0aGUKLy8g
bWVtYmVyJ3MgaW5kZXgpIGFzIGFuIGF0dGFjaCB0eXBlOiAyNSBpcyBCUEZfVFJBQ0VfRkVYSVQs
IHNvIHRoZSBzbG90Ci8vIGFmdGVyIHRoZSBsYXN0IGFyZ3VtZW50IGlzIHR5cGVkIGFzIHRoZSBt
ZW1iZXIncyByZXN1bHQgYW5kIHRoZSByZWFkCi8vIGlzIGFkbWl0dGVkLiBBdCBydW4gdGltZSB0
aGF0IHNsb3QgaXMgdGhlIHRyYW1wb2xpbmUncyByZXR1cm4gc2xvdCwKLy8gdW53cml0dGVuIHdo
aWxlIHRoZSBwcm9ncmFtIHJ1bnMuCiNpbmNsdWRlICJwb2MuaCIKCnN0cnVjdCBicGZfdGVzdG1v
ZF9vcHMgewoJaW50ICgqdHJhbXBfMTUpKGludCB2YWx1ZSk7Cn07CgpTRUMoInN0cnVjdF9vcHMv
dHJhbXBfMTUiKQpfX25ha2VkIGludCByZWFkX2FmdGVyX2FyZ3Modm9pZCkKewoJYXNtIHZvbGF0
aWxlICgKCSJyMiA9ICoodTY0ICopKHIxICsgOCk7IiAgICAgLyogY3R4WzFdOiBwYXN0IHRoZSBv
bmUgYXJndW1lbnQgKi8KCSJyMCA9IDA7IgoJImV4aXQ7IgoJOjo6IF9fY2xvYmJlcl9hbGwpOwp9
CgpTRUMoIi5zdHJ1Y3Rfb3BzIikKc3RydWN0IGJwZl90ZXN0bW9kX29wcyBvcHMgPSB7CgkudHJh
bXBfMTUgPSAodm9pZCAqKXJlYWRfYWZ0ZXJfYXJncywKfTsK
--000000000000abed4406607e6949--
