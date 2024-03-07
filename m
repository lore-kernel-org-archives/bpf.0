Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504371E863
	for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096048; cv=none; b=Z1n6VJx+gMwO182o6IHENEJwSYtZZhxBFew/O9TD1a1Hg+eZH1IrhM83tmf5v7PevPW3v9O7Jt+0QnZ8SUmSpfnkYNIWBp25EzZ0ZHSpyeRpedfdSn4rfhxZ4fSMh5A2cC+T0CEUNFSPjmbZCr+aYjoi14awUv5YOcM6jSUqWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096048; c=relaxed/simple;
	bh=ygRR0Del03h6JLPzJzNQCY0A8xY4KgyDpwAqNnhbwsI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=k1ni35QFuTkoq0AMaPr4G5UTs3b4tmqzZMBBwAms0ffmZytGoPb1zpTGtUJYKdw/it5ClBvXYSvCccmrqnfZtlcfuoy3Y3pLzegIyJJHjRJhAPM1MCHFPDbM5qCZj6MtRveOfeeHaJGWAeTDCI4PYymp+grjD4POeReyhnpec2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=djA13dGK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="djA13dGK"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56845954fffso1159502a12.3
        for <bpf@vger.kernel.org>; Sun, 10 Mar 2024 11:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710096044; x=1710700844; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=BGXBZR4M5Hf2bGx2FubnlyZXvesqTiZYLbVSADloLzM=;
        b=djA13dGK/LR0KcI02cl+qZeI14FaVrD5JwjRxvtquTGN85dQQAJuzBSjaYW1rMOuTD
         uikVXinP21TrGfWos86q/fWeqZGMOQt27iKAybn+/E/YLZ36bUrbkxbS/FdXwUVWnoL/
         y8A30MigbKohyrX+DiK/5SmoF8QxrD719nkHNRKCXhzRJpTN/CmQIqS0P5c0GOKidFXh
         4Q8qUnzevsCRI07oA39KduH3KzUbnM4hxE+Kqs8XMyRmdOG2aX/GBv5J2M2Mu8cGlaWm
         Gc6W6TkiZqpmu+Mtb60utsfsq+FJmmP7wHhVcyEM6STnzCRd+pRaAlAzWKZ8wTSmqzKZ
         kpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096044; x=1710700844;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGXBZR4M5Hf2bGx2FubnlyZXvesqTiZYLbVSADloLzM=;
        b=diprzpPkla/aXyjbDp3xbiIsQqtQAoIWhJq4p8wXY/yzfp5JrObyWSlrYgh9J7R9vs
         BrCQXg/aQfpGZAxV1/l6JUq+Ykmx6yNosiYNzqa6fgGnFdBd6KIM6pavLPZKVXK3+fj3
         V+LLa12lzXbN5MPGXODifV8L9cGQyN4qGC6uqHhf8n1DoraOBHoVoyaV0h80z3f450Rq
         SQq8aYP28IATwqRlb9+8Risg5PeOyqSDynzwk6H7X2MZ8vGzB8CcmHLYPv91rAnQeGQG
         ZtQXcJ0J36sudA3eiLTddX0If4UpAykmCns13Ku+pSefO9EKcyj+emXme+C90MAnGU5F
         fagQ==
X-Gm-Message-State: AOJu0Yy8fNUGwrNsPYDJqBJjZvqNYlEEmKPMvY5FqcMMZQ36egPOqjTR
	009vglEYR+44ukURSUr/k74YUF0DmFtGo7JP6dlft2q9pYoQQQnbG0IGCvCEgn4=
X-Google-Smtp-Source: AGHT+IFwY0iIO0/nuK4U57r7Lme6AZd00P5h99JTaJroT5lH7Di/U1Me+g3ulv6tMYDAb1Z00Mqmnw==
X-Received: by 2002:a50:aad2:0:b0:565:af1d:7416 with SMTP id r18-20020a50aad2000000b00565af1d7416mr3061162edc.5.1710096044473;
        Sun, 10 Mar 2024 11:40:44 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:8f])
        by smtp.gmail.com with ESMTPSA id y89-20020a50bb62000000b005651ae4ac91sm2243006ede.41.2024.03.10.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:40:43 -0700 (PDT)
References: <20240305202155.3890667-1-yonghong.song@linux.dev>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com, Martin KaFai Lau
 <martin.lau@kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/5] Add bpf_link support for sk_msg prog
Date: Thu, 07 Mar 2024 13:01:09 +0000
In-reply-to: <20240305202155.3890667-1-yonghong.song@linux.dev>
Message-ID: <87jzmarkut.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 05, 2024 at 12:21 PM -08, Yonghong Song wrote:
> One of our internal services started to use sk_msg program and currently
> it used existing prog attach/detach2 as demonstrated in selftests.
> But attach/detach of all other bpf programs are based on bpf_link.
> Consistent attach/detach APIs for all programs will make things easy to
> undersand and less error prone. So this patch added bpf_link
> support for BPF_PROG_TYPE_SK_MSG.
>
> I marked the patch as RFC as not all functionality are covered
> by tests yet, e.g. update_prog(). Maybe somebody can suggest
> an existing test which I can look into.
> Or maybe some other tests need to be added as well.

I have a general remark, not specific to this work.

We can't attach with links from CLI, apart from when auto-attach is
supported.  `bpftool prog attach` doesn't use bpf links. For instance:

bpftool prog attach \
        pinned /sys/fs/bpf/test/sk_msg_prog \
        sk_msg_verdict \
        pinned /sys/fs/bpf/test/sock_map

Is there a plan for the CLI tooling to support it?
