Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546448C8AE
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713695; cv=none; b=RLXkz4OSZ1cllR8MY1XW7/Tu5WvuhQ7yBdW9dq8hioPKuHFZcM0uwp4JBPq3FgLHOYr4ynuWmF9bX3bv2Tj+ZEpIY/CiSPWX2ibkdfwLl9RB7JESKa6p3KxVUkS1J2/JoEeyLvF92aTL98dHs7T4PNAneFCe705e4i2R4XkzUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713695; c=relaxed/simple;
	bh=8voPr0oIffGgC9uvzv0fgIlKIWe5zJCfJcNqyOyrtOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epy63RlRaBH2V+XIBaQktFhSXCN1+seqZYcxkHofukLeB6jpflJrZA/vaFsHnzzd2vJ+KSNJAE7HZB6V7aJIr8YKTg9hwyc3jNTHyw+QueEoT5QoTsGVkCMJJ98ZExeWMp2qURKJBSQ41USZMCxZ1xAOv3AWAJB3xgZxHc2KzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro4cB6S+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro4cB6S+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c68190ade4so9119865ad.0
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 09:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781713690; x=1782318490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T67DAtrYPXAXvqAG/FoWpTPJ7cmPiG63oGrG3tLKT7o=;
        b=Ro4cB6S+uZYX7hIQfORSf6HLIohWTSVmWGcbB3upJQHWXEkafwF4E0pL6S/aZ8DzrT
         4A0I2/Zcl9Gw3PoyyMzgiivm9uI6H8LaTq8qkeRo4cp4lzeR4BbD7flw4ZwbRuXntNip
         Gq56nvTVtfxwzJxODcYo6KBf3pWE8CZ4uC15aKGlD8ZIcFRgu4THh/LrnhXPz9jEoJ5U
         bvZKq/J4mJqa7E80FUZUYi9dmkexnY2jYuGSMddMd0en5SHkvwBI2yalm+PevWwx+pAn
         P6upuguwRCVfp54z7ouVCecjHnKnSlQLNBIRnS3gNMdav4m96RRxdmmcnyk57DyqZVsm
         fbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781713690; x=1782318490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T67DAtrYPXAXvqAG/FoWpTPJ7cmPiG63oGrG3tLKT7o=;
        b=mmrDPTRxyMYMJrOqogw5c8+K/1+2gAmElgmvX63YLBqSLuPM9pLD+IVXKTd4ipKEWC
         t77wKTzMvLe5yp7KxIWWtO95OhHM61m9DeIGTCgrVnWJwNmvA4rzmbe6e4+a1ZiRn8JK
         fcmWRPq8hNtD4JcNLmslK7JaqOCQGIkTv4F+lVP2teaSgIIMb/yA1wFxysokxc3QPW0h
         SK3jPmJ3DsPQTW23eimJ8q/PAKy6UVUg4uY7xKJpTW4gY3nZiX428zlqPw3Gyj4yCzk2
         O4MV+V7+RsuTpt2kQIPpolFFl88sUGIcZI5CSbwdltmNrDmKxqUyqslIv9VrW+JsSxve
         tQvw==
X-Gm-Message-State: AOJu0YyK6hFBFUEQcB8XEnAxMgtDXTY4dmtzS/kpIVPp4lDvAMKsfnEY
	VtIfOFbs2JVWHS10rY1GCmtNA+ZneDT/afN0Y03lHxAFxtkPScgwXhf77mI37w==
X-Gm-Gg: AfdE7cmcphIoUYUoPqmmuehZpAwZDEg0Gcdl9/RGuLj+XLa4NxWBEZdz3OkhZ0d+G+q
	8LxbMYiGAR7Uc6sLllyUtrc8ffFg2x03Y5c6+kgO0Hhqt00bJt1CoEyGNf72qC39pSfBXwbj5uI
	NWt0ISF2pSBB/SL66cPrIa/MnDYStmu//bh9FPaqtVXIfB6eHxp0e38FbDEodkFhdF/+MpVQs+6
	aM0IgHbgYOr5KXFq7+L2TlNSHjX6+rjYC7CIqbWEj47RZ9L60wsxm5tG2he0QpCpAJ3vRB3MCS0
	C+eTKGGjFXVzF7QcmNhEfQ5ix2pTtq2iT2oXW4PLNbcrtRIS0WDurWjwE2ynhPPHmbW3lX5k/JP
	B4Lk/jpPOvc6DqKz3gb4DGofazkBEwfSIgT+ez07Ap/ozXZwBq+FIkv0mY2HtwVYxc8KovVR5wS
	MZ4RWEAqcgLVDNy2XdTeJ8
X-Received: by 2002:a17:903:3806:b0:2c6:b3dc:b838 with SMTP id d9443c01a7336-2c6de6673edmr1277045ad.18.1781713689520;
        Wed, 17 Jun 2026 09:28:09 -0700 (PDT)
Received: from john-p8 ([98.97.43.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm167243115ad.36.2026.06.17.09.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 09:28:08 -0700 (PDT)
Date: Wed, 17 Jun 2026 09:28:07 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] bpf, sockmap: reject overflowing copy +
 len in bpf_msg_push_data()
Message-ID: <ajLK-x96A_LaEuTF@john-p8>
References: <20260615021959.140010-1-jiayuan.chen@linux.dev>
 <20260615021959.140010-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260615021959.140010-2-jiayuan.chen@linux.dev>

On Mon, Jun 15, 2026 at 10:19:54AM +0800, Jiayuan Chen wrote:
>From: Weiming Shi <bestswngs@gmail.com>
>
>When the scatterlist ring is full or nearly full, bpf_msg_push_data()
>enters a copy fallback path and computes copy + len for the page
>allocation size. Since len comes from BPF with arg3_type = ARG_ANYTHING
>and both are u32, a crafted len can wrap the sum to a small value,
>causing an undersized allocation followed by an out-of-bounds memcpy.
>
> BUG: unable to handle page fault for address: ffffed104089a402
> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> Call Trace:
>  __asan_memcpy (mm/kasan/shadow.c:105)
>  bpf_msg_push_data (net/core/filter.c:2852 net/core/filter.c:2788)
>  bpf_prog_9ed8b5711920a7d7+0x2e/0x36
>  sk_psock_msg_verdict (net/core/skmsg.c:934)
>  tcp_bpf_sendmsg (net/ipv4/tcp_bpf.c:421 net/ipv4/tcp_bpf.c:584)
>  __sys_sendto (net/socket.c:2206)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>
>Add an overflow check before the allocation.
>
>Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
>Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>Tested-by: Xiang Mei <xmei5@asu.edu>
>Tested-by: Xinyu Ma <mmmxny@gmail.com>
>Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
