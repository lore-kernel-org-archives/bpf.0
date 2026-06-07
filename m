Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFB23BD1B
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820832; cv=none; b=WXsaAHZFR2gM7NDYCOErDY1tN4vzc8+ulaO27MLC9KswsB+D9/b0OZsZ69ncdjo01EVMWFJsniotmefsbdGttuDIg/jvHG2Vq/1hw2Xj5iX5vEIXuNtAJGEEULBxfyg2KZSpBoOWYDZtpGsuV6RXpUGkCD7iaZ97Y0ZE6Gt0qvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820832; c=relaxed/simple;
	bh=KyB+wYt6I7rfybeyjbG2MBRdMUZDQzMBBwp14DabUaE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cOZcfaTACiUN5AvHZkFvrp4v2gEH44X9Mvsltf7/hV0Tn81YRCwixEn87CGXIlR65AeRaPbP5GBmrDv2/fFApbfc8mWsayxc8BjLXcHAmEVEwjuVu6ifWl6WxfuQjjrzllk2rF2cdulOGHi4YFng7wEiUUHio7xckSYpA9IvDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWJTH26D; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWJTH26D"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so21154755e9.0
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780820829; x=1781425629; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lah13J09cjVuua4zz130hD1onolHvEfp60oPG1HBtc=;
        b=kWJTH26DJjTs6uqzqxAyniThlU//HxCUz9LaRRncEDKBYYGyHpegDyFEvKlKhIRI2Q
         NlgzJXTJyLQFVPBn6HgXMOTI80+wIzYGFRewuvKgqvsTP7o7qzujxfxopTpMNumfIU6m
         Dek8tQQKpanonv7AJsplpXFDNW1BWvbeIPsj3MemF8PPkxiaKg8mc1+hNxRtrOuU+3QE
         4U4XzLxGta2SSY/1G/aA8AQ5RDA03B2RneE8yPMwCM4o7tDLIE5VRwSOGLfc8e9bBsHT
         m3zkjNeSb1yOn5O/csYLmojVudaUr5m4Ck0+JojhzTQQXxk1F6Q8M0/RiJfk7I0Bl4/W
         SKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780820829; x=1781425629;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lah13J09cjVuua4zz130hD1onolHvEfp60oPG1HBtc=;
        b=Can9EYwPbW228035Vx1lAxmmgzb7Py+m6WuTVQOO2BSzTau3PrYHpzpC6SHXx0kSjU
         CWrEDwc0TD14D9mJIDzW+aZ47BIbYaWRFwjdBFpvTLpjQa7mn+p+dWz901gEo0zcje6n
         umQeR4057+q+DsZxrREqxjt59ufx/ITCvXDtbrX4eUsEx8eF0V+xTD4yj9JIuDL3+zzv
         Mqxirs3weHnIB4HxZbwZhjDv9Evq1L/38del8luPUNj3UGfDFWrq2B420LnCAYAHAS3D
         7J6mvRv4lu39myvUrS5aPX2AUbM4x4Lc6sU1E5Ui3GEqSMsr28IdMd880KdYx6m5yLZd
         3P2A==
X-Gm-Message-State: AOJu0YxI5iiBldN9rHfnM5BiC+k/lmkrDIMKKvOUd9aJ7UPl35wUZsKz
	lkhVijgM4sEGwvJG4h7wcbjnj7L83abiLfsR9ir0mbrYofgJrR+JvNMR
X-Gm-Gg: Acq92OG/pyEdrkZceL41P7ahNoDMromv8/FvRjTyXzApbDGZ8VUzXwKF6I4XesF/EIL
	vz0sKZQvinksZ08laGZ1kSS4Lm7xVUpZdZlzOpotjkT/Pa1QseO48J57k6VpGNVVKaRbTEfCSgI
	Hz0BC7fTqU4pGvc+HUm5itKEIMGOqfWULlvGGEcxImWdC2WUgbe6ZpeuGIcvLpMOpri8WrDWUCg
	68XN8BdL1yUtPtwCg6OJu+pKrR5pyLfT6fIbIvwn2ekoNHi6h37yAiBtvEb3tgqfDB88IuFqhUl
	MhY8AmF6P3dBHPR1kDyRWDFribN8saZ4NX055j087mKKzjvTBh8jW7SkDsoc91BqRyMBRrzOm2r
	RG4K2dpIF6yXVs0XNRBwjFP0NWt8QogcZCtvPaLwNqQWoPTtY0SHXq2S9rMrvaSpO+0ujnFo7oU
	TujFoHrhcjpOziOwisSx3lrseeDK43YvFWU9efOXZkQfoEJiGEii3YSnTChO6IpMvtbekZ03ghJ
	WrwGXBX+aNL9xhhe5CX0uXF6+XbyrwgLNTqAKRI+GjCleZGpNeBbU2kFr49qtCqOutwLNVz6Eyo
	DrmCdnTmv0w=
X-Received: by 2002:a05:600c:8b85:b0:490:9d5b:d721 with SMTP id 5b1f17b1804b1-490c25f166fmr181795525e9.16.1780820829198;
        Sun, 07 Jun 2026 01:27:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm32485831f8f.14.2026.06.07.01.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 10:27:07 +0200
Message-Id: <DJ2OAQE4L6G9.PX5YMVK1D2HU@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: reject sleepable BPF_LSM_CGROUP programs
 at load time
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Song Liu" <song@kernel.org>, "David Windsor" <dwindsor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260605145707.608579-1-dwindsor@gmail.com>
 <CAPhsuW7jSxHF1sH2jMYf9Px0iuMadt0bX13ABF4D=og-hQuq_g@mail.gmail.com>
In-Reply-To: <CAPhsuW7jSxHF1sH2jMYf9Px0iuMadt0bX13ABF4D=og-hQuq_g@mail.gmail.com>

On Fri Jun 5, 2026 at 11:40 PM CEST, Song Liu wrote:
> On Fri, Jun 5, 2026 at 7:57=E2=80=AFAM David Windsor <dwindsor@gmail.com>=
 wrote:
>>
>> The cgroup shim runs under rcu_read_lock_dont_migrate(), so we should
>> not attach any sleepable BPF programs there. Add support to the verifier
>> to explicitly reject attempts to load sleepable BPF programs destined
>> for LSM cgroup attachment.
>>
>> Without this, we get the following splat from a BPF_LSM_CGROUP
>> program marked BPF_F_SLEEPABLE attached to file_open when it calls
>> bpf_get_dentry_xattr():
>>
>>   BUG: sleeping function called from invalid context at kernel/locking/r=
wsem.c:1567
>>   in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 34317, name: lo=
ad
>>   preempt_count: 0, expected: 0
>>   RCU nest depth: 2, expected: 0
>>   Call Trace:
>>    down_read+0x76/0x480
>>    ext4_xattr_get+0x11f/0x700
>>    __vfs_getxattr+0xf0/0x150
>>    bpf_get_dentry_xattr+0xbb/0xf0
>>    bpf_prog_e76a298dac9218c6_test_open+0x6a/0x85
>>    __cgroup_bpf_run_lsm_current+0x326/0x840
>>    bpf_trampoline_6442534646+0x62/0x14d
>>    security_file_open+0x34/0x60
>>    do_dentry_open+0x340/0x1260
>>    vfs_open+0x7a/0x440
>>    path_openat+0x1bac/0x30a0
>>
>> libbpf provides a .s named section variant for every sleepable
>> program type except lsm_cgroup, reflecting that per-cgroup LSM programs
>> are intended to only run in a non-sleepable context.
>>
>> The above splat was obtained by bypassing libbpf by using bpf(2)
>> directly.
>>
>> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
>> Signed-off-by: David Windsor <dwindsor@gmail.com>
>
> We should add a "__failure __msg(...)" selftest for the reject case.
>

David,
Please follow up with selftest for the fix.
