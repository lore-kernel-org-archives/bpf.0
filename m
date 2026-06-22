Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8D346E5D
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167576; cv=none; b=E90Ul2YeZ/BTrCQEfwYVePw7yutyZQO3X8gy79B9LXhk7GrX6Q0c8iSzYZb+zQv3HO/YknMQy/Kf/GVwmDq2y+oDfB4z4asM4NJ5HrEYpJC9B46IDnUi8zD9c+uKXK6y0/wt43Wh7mphezArAUWW+USl8doU96Y4TSgAPxcXbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167576; c=relaxed/simple;
	bh=GTrgiK6YZW/87K2ASsSbJjCcOhmlzHAMF/U2Or9B9PE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=cM6hserbipnLbCSdPamhXS6wbzxZIRZQG0493aQU0Zj4nagRyLscAlHGArb/snq0VeySFMcFOYnPg2R5Fo4tnHfIN3c0ec9/6BaZ61G7abqbAXu5RIUaPk1kAB2zpK+tYWigT/Hr++brlc5MGkqVpa3MFniV14qgcrBuIVaBQ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MadtyKnm; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MadtyKnm"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6e9408e30so4342444a34.2
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782167574; x=1782772374; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNMt0SALBc9dR+2Mkf/0/J5cVE9RUiLWYRooeHFSC9w=;
        b=MadtyKnm5uSmIUVx3YRDIVSIL270KLeCsV50TfSxxpfORa0sanjziOsk8oaKmwE0qz
         DjZ2GT/Fm1RtiIf6JyEbGfephpFHeyU8VkGS6MB1KGFLB6sIorGEpekPgJn4Tu74X61G
         Xr7shP2aAjdgvZ1OnaYd+3XP9KXPhA/vHocqFGyOqP51008apj68jzLbVPL6cVtBEvzk
         56DUNGSHg/pE6d0sNrSckfeqKSMtafxg+5+tW6HICxgCjbVvExwZYNX9KTGN39/MSFHf
         MiVmoo12fYu5ZFQg52ohcCTigkAn/R8GO5GZ5Sd2PzAWjonvLwVcS3ej+50Xsa3CTUiM
         hq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167574; x=1782772374;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNMt0SALBc9dR+2Mkf/0/J5cVE9RUiLWYRooeHFSC9w=;
        b=qdy/OFuxeVjgapUgKDkQRHu+s2HFOIteTdmUFi1Tz8QaQSCTvfWWiN0Ht9jxKHZ6GB
         KRIAYjNBorGgr8VlwxaVcAEbqoV3bE44idNuvpuF+7p6k5sduYux/9ooSSaemBS8Lkvw
         1fH4WASOHkna0L24CcIG7T51Lrrh/QLntzqJpnC9YMzaPfbt6CyLBv1WaTqx4on0UeFD
         P3oK4cM15Q/twmxl1jWr9e1u4PhjX1hB9Qoh2qNRPCvXxWw4V5WFV1nPVk8i0N9Srost
         D2vdD1CPMVYu97ksnBixBYDs3X3y7qmXgR8bGD5J5steRS6a1CnZVkmA0gpGmg5KIyVv
         qC2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/mgJl4gZS3176hsCJqHbBTNS8/+k0hOgF8RQzCOpMY4MqhIBoryxTL0Rcy+zyQ1qix/4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQEVr7usvwp+CTTRPP+XIIq1knuJW8PM97BiEKttiVqPEYL7J
	gsuupArG/ORor2+bPQ4l553lchsOiM5h7NHrjY5Pajx0i/JYtpB/u9ne
X-Gm-Gg: AfdE7cm9omYcySvzo67aaLtrPQVFNq+96gq5GYqxILkAHsZGp7b1Um85IMJJ7NqDGu7
	mqpq2cQLcOI7R4pAkyYqFoPlmKBrXBX36y83/GzFK0wjBUzPr3ZLfFqFr6iXxrNxP9WrD9vcuKB
	DDWU+W30Gr4Mj8Dsy84UDdI/2vPxQCFLdRgzocPKqeXM98Q4lf8SkeKBeUQ8H3NGtoXby8wSI3o
	NmH4bIolOoAmFUIfUsgcJTR2JEjEUGCn3g31rZ2DSxebglMp/eRAuSElh5jO3EmejzF7jM7ShPX
	bV2bCJ9WmXgmlLMoThQg1iUWWONaErF8er3G9KNtkSbOh7NYXQVlyjMC3RwSdieYC6HGVwgRQYA
	IsNniGLWH7Zw2k016nQH4hAj5RnQ6ANZw0u9mGNlG0gRSHnpNaa75NquVgH2lOhyPI2j34tJyqy
	OyBemUcQY8c3ClaxzooutQlFivqQuk1xa/20J2rD/ApyKN8tzIbdGN/xWHcTuRqX4/jDkKBh5iI
	9QNsw==
X-Received: by 2002:a05:6830:4488:b0:7d7:570b:6800 with SMTP id 46e09a7af769-7e97999d908mr71007a34.23.1782167574242;
        Mon, 22 Jun 2026 15:32:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94429a5bdsm7867392a34.22.2026.06.22.15.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 15:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 15:32:52 -0700
Message-Id: <DJFXOGFS8DXY.4CDI7LHXGHWN@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gyutae Bae" <gyutae.opensource@navercorp.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Minsu
 Jeon" <minsu.jeon@navercorp.com>, "Siwan Kim" <siwan.kim@navercorp.com>,
 "Jonghyeon Kim" <jong-hyeon.kim@navercorp.com>, "Gyutae Bae"
 <gyutae.bae@navercorp.com>
Subject: Re: [RFC bpf-next 0/3] bpf: compare-and-delete (BPF_F_COMPARE) for
 hash maps
X-Mailer: aerc
References: <20260622071649.31541-1-gyutae.opensource@navercorp.com>
In-Reply-To: <20260622071649.31541-1-gyutae.opensource@navercorp.com>

On Mon Jun 22, 2026 at 12:16 AM PDT, Gyutae Bae wrote:
> From: Gyutae Bae <gyutae.bae@navercorp.com>
>
> This series adds an atomic compare-and-delete primitive to BPF hash
> maps, motivated by a TOCTOU race in Cilium's conntrack GC [1]: the
> batched GC snapshots CT entries, decides which expired, then deletes
> them by key in a later syscall; between snapshot and delete the
> datapath can refresh the same entry, so a live entry is deleted. A
> userspace re-check before delete can't close it (lookup and delete are
> separate, individually bucket-locked calls).
>
> BPF_F_COMPARE lets userspace delete a key only if a chosen value region
> is unchanged, with the compare and the delete done atomically under the
> hash bucket lock:
>
>     attr.flags |=3D BPF_F_COMPARE;
>     attr.compare =3D <expected>;
>     attr.compare_offset =3D <off>;
>     attr.compare_size =3D <len>;
>
> mismatch -> -EBUSY, absent -> -ENOENT, unsupported map -> -EOPNOTSUPP.
> The compare* fields without the flag are rejected (-EINVAL) so a dropped
> flag can't silently become an unconditional delete; maps whose value
> carries BTF-managed fields (spin_lock/timer/kptr/...) are rejected
> (-EOPNOTSUPP) since those bytes are sanitised on lookup.
>
> Atomicity boundary (please scrutinise): the compare is atomic vs every
> bucket-lock holder, but NOT vs a BPF program writing the value in place
> via the pointer from bpf_map_lookup_elem() (no bucket lock). It
> collapses the race window from the whole GC batch to one bucket-locked
> critical section; full closure wants the compared region treated as a
> synchronization variable (e.g. a monotonic revision). The selftest
> models this.
>
> Scope of this RFC: per-element compare-and-delete on BPF_MAP_TYPE_HASH
> only. Deferred (will follow once the approach is agreed): batch delete +
> its attr fields, a libbpf wrapper, LRU-hash and other map types, a
> compare-and-swap *update*.
>
> Open questions:
>   - flag name: BPF_F_COMPARE vs something else?
>   - mismatch errno: -EBUSY vs -EAGAIN?
>   - new ->map_delete_elem_cmp() op vs extending ->map_delete_elem?

Sorry, this is no go.
There is bpf_spin_lock that use can use to synchronize access
between bpf progs and user space.
lookup_and_delete with BPF_F_LOCK uses the same lock.
Or add another syscall program that is triggered from user space
that operates on the same map.
Or convert everything to arena and use whatever algorithm you prefer.

