Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93A1C28E
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135402; cv=pass; b=F57svcWn27IzxhAooxFvDWfdx3zCBehoLgNlxAFgZmqRL6/N++Tvt45FoBi8krNKaW5Ql8/xh/DVNp3SMYgw2c0WETRZAo7cPBfVcsoesGM3oAcfzHOknNx0dgQo55zp95SXpvtJUYHH/ZQAFwCeiZxcwI9PhJiiRiDJQpedgfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135402; c=relaxed/simple;
	bh=8YorV9Prculxq+57WG+yLLycVgDTjWoi534EC/6doG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cU2tjl+jwJTGmCPtI6/0fAEsrawkB7kk0F0Zj/slb4obzI6nEkqrmOeUzGbczXCwoWzQeNmVKpBEqAMshr0Xvc8tncHe+x5B/hsXMxxg3NTBgdkkvZTCTV6tzgVI5jCSC/X9n/3kc8Fh7bffLe2XyIcP0WJkqM3lcXg5jbKbvww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqGdGsZY; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqGdGsZY"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43596062728so659416f8f.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 08:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770135399; cv=none;
        d=google.com; s=arc-20240605;
        b=cga8ABOiTqUrjgmk83g8HstTM5XgKTRW/QlWCclf/C5MaYVH2hc+0zdxZv99Lj3noy
         V+BeymaNpwZJVSWaLXvcc8My+DfayyTlcoAh/mJRbvxA0ZJ3ckJPKz4JBC2x3YX4yTkb
         9vIIrXmYqjFlmdxMrrJDrbRR3BS4RdNIoZRPDAHOwwKaKMtvnYtJJyf40iSm/2zVsuL1
         CJeGmUPELk5MIllAc80uDgnb15ijGQN2x99Uqz1/iXvlblA2DOnxMLz8DUYTHWAjWxvd
         zdKkArkXBap9+9eBvN9k+6kv64eQ7NR7lof3sQtQuvKoXIS9zIEY6n2/4Tw+FZ/VrRir
         cN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g7au5IqnsgjlAxWkbXvg0J5WnO2ROAkqVkXUtb/b3VY=;
        fh=eWvt/84dv8gmoSBLGziAOnKgz0jBtwgGZiZYG1EQXXA=;
        b=I4K3MQW+enPSgGJEI9NyVHQlQTfi4vRn8YeB4iXjT2eBjN7b2aqnX6OSGhnLPDsgzj
         JakDFDIQLXHZc/wKD/+teuCqwoXtWC0ReSDxAUQgwGltKfIquXLYDAS4QGc+dA84bMfh
         lVROy1MPsiRwotlecc9COyV+I4gDITl4IJCXJXJ7JbjfalUqi0iQwQzPUGLS5cdF2zU2
         C0oQDuFYNsqk6gUCDnND3eiI55/4XkzLoG8Ml95sP1W+L+x6Qq9coPMLrmYqzMHAnzJw
         zOC0C8Rur2vt6vOUJ7v6dHkPRnO/EBFi7cjcywmGfQgwKbdI+PZFH9fdGTOEMpaIT2R+
         8d6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770135399; x=1770740199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g7au5IqnsgjlAxWkbXvg0J5WnO2ROAkqVkXUtb/b3VY=;
        b=NqGdGsZYFS8LNIEsoXqFChG5sdT5Q20gsmqQ8cbTMozAX9sa7Hv0y61D6IJUFVkOzb
         aublGKSTJl5HPYI6PC1tWU+8OoqQiR5Po7LXhbhIU745ffZ5DnF6YAUNvLTnKeocCycz
         q5YTj1fZonaKV6YAoK/IC4mIb4QnSqrrfGKmGLBaNg2RP8WHt/iM8YUuN97kT5o5JMXo
         bdschb2jyqrU4y0G5SkJ4Up5UhWXbhKae03PLXlcTgYg4kJwCgLtq8rHgGece+ZIG5IK
         VCR2c+zJgu+QzxuHPlccZm41SRXoLtIegdG3omRcaw1ZFfRY02t374wMbEBnSP0jvjMF
         x1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770135399; x=1770740199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7au5IqnsgjlAxWkbXvg0J5WnO2ROAkqVkXUtb/b3VY=;
        b=LD7oJtu8IUfkUwDjPUTdWeqOqFg+BiS03idb7y41c/kcyULIO7dDXiNuZnZrM66kdl
         5vcchPOn35V3pYpixCecF4aILSDjrsrekA6aB24NsX0PKRpoq9COQbnbWqdNTLY9ixhN
         f8STJ006usvd+ADICABT8SURjFC/TrkIYiRiOtz7OtTyR21PKQY9fTYTnl9xz74KMGId
         q7VzEefJTYmXvNO+z6rEn8SHfTWXaZm/aUuX51a3WE7tZaZ5iyia5wHCOVdf6+6LwxQb
         1O5Sf2Wnv2NFHoMa6Y/4/liVFOH0YprRKPQY4BWxAW5stCijgrGApgeOqDDbR51YxtQh
         UJmg==
X-Gm-Message-State: AOJu0YzgrnTMDqt4L9ivz3QWN4bIp/8C/uhP2c+GFJmVCHrZrj9Nrffw
	vNtq3NdVvyYsdOW40f/qvHUsRnxN9S+sPZ000RIIOxjXHm3SKTNA63HmIkjyY5KyMb7y8TJk59T
	gJ/2V6nWQtxXJpV4+f+5YkskjBaCSkQ0=
X-Gm-Gg: AZuq6aIHtjmxxy+G9fQWv0SSaOxg8aoydCuypGuovAM+mnol77MxI4f5q0qjduW5TKl
	zIyZgxbX2hjGL7WTrE65oLqv30Mx/gD6HIYCuHL5x+8tS+PIhCMKyljUXxzIr28Jxz1RQkqPDw+
	ryY1rwZb2cFW95bUoSUBJNBuBgK1d59aNBw7TWPxPc47MPXAIBrXID68gvC2j7sVA3gIQ0VMlKe
	Tm8+0S24t4LaI7O5WcqGW0AgYexDeYgYJqzXLoy+2vWoCY49vc2p5Vlv228vAkEP6M+7/btgHRZ
	o0BBpSIgU/JdpWwsEYwI1qpN60TZyCvPi1F9oY9qikqUw8hcZ8zR1rENmdJo
X-Received: by 2002:a05:6000:288e:b0:432:dcb1:68bc with SMTP id
 ffacd0b85a97d-43611447896mr5420016f8f.23.1770135399039; Tue, 03 Feb 2026
 08:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202193311.446717-1-emil@etsalapatis.com>
In-Reply-To: <20260202193311.446717-1-emil@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 3 Feb 2026 17:16:02 +0100
X-Gm-Features: AZwV_QjN8ktHcnGQzMoHxGpu4KgAph0opjHf1zL_D8mqfwsRK8MIqrvJj81scrk
Message-ID: <CAP01T76PxFyyidspFgB907TR8rX6o9EvVNHFhJcuJpPYyqD-LA@mail.gmail.com>
Subject: Re: [PATCH 0/4] bpf: Add bpf_stream_print_stack kfunc
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Feb 2026 at 20:33, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> Add a new bpf_stream_print_stack kfunc for printing a BPF program stack
> into a BPF stream. Update the verifier to allow the new kfunc to be
> called with BPF spinlocks held, along with bpf_stream_vprintk.
>
> Patchset spun out of the larger libarena + ASAN patchset.
> (https://lore.kernel.org/bpf/20260127181610.86376-1-emil@etsalapatis.com/)
>
> Changeset:
>         - Update bpf_stream_print_stack to take stream_id arg (Kumar)
>         - Added selftest for the bpf_stream_print_stack
>         - Add selftest for calling the streams kfuncs under lock
>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
>
> Emil Tsalapatis (4):
>   bpf: Add bpf_stream_print_stack stack dumping kfunc
>   selftests/bpf: Add selftests for bpf_stream_print_stack
>   bpf: Allow BPF stream kfuncs while holding a lock
>   selftests/bpf: Add selftests for stream functions under lock
>

For the set:
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/helpers.c                       |  1 +
>  kernel/bpf/stream.c                        | 19 ++++++++
>  kernel/bpf/verifier.c                      | 13 +++++-
>  tools/testing/selftests/bpf/progs/stream.c | 53 ++++++++++++++++++++++
>  4 files changed, 85 insertions(+), 1 deletion(-)
>
> --
> 2.49.0
>
