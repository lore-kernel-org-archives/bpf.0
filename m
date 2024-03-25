Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3856FE19
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374737; cv=none; b=oFY1GzNlNySYqoOr44mo7NnuMfdaZPAyTnpx1u8n7+gHWK7D6Nuu+4tlpjjG9hStz7Q33KKExmviHC1Yx5iOjpWAvVjxXnZPoPe3egVzOORIvqZYVMXFaJAaQaDUv/i3/0BbAp7qWK2N2sZnJLjKc+nuSMcLprOsVriUsbuYs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374737; c=relaxed/simple;
	bh=svPkrUsWc31u5PxOeTcURerKjA9TBu7K7e3w1kgsNqo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ce+i+75ISuJwS56ZyluR418HoTSoXRqKF+Nxk+xItqjG4v4DQoH5GdHR9VWTLZfNHpENKAFnNJgRMkGmMYvZ9VDvINOtUfphc0TgF/4SZKsZ5oSM6vMN5AYVLAbJIkn7GUOEhfp3KngJf+7GC0aQcB1GNCkK4zo0pvtOKN5URyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ItB557KN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ItB557KN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4749eecff7so188290266b.2
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 06:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711374734; x=1711979534; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=svPkrUsWc31u5PxOeTcURerKjA9TBu7K7e3w1kgsNqo=;
        b=ItB557KNcARm08KdTuyx10BNBt5q+1kn7Rn2lWbeemwIQBzkaWDPLCPNzm/cCgAaaj
         IAGr0TS7y7XYQvcDUpk9Znl0/ez4l4ZNLjKX3J0tALTQ4UAO1Mtf2RCuPoDNgKLrTPUF
         5E5JnAVLaLlF+MzdAVTzwZ4UtI6xfPUI+qZdM/ymwbvQe8h6OvrpkNXZY2gLH0NrxWkf
         23tV+yUqmwOSKbGJEfSj2CxR6ETP0FIU5eLTRzT5jhM7CEQpBK9csY65hmramFPP7Hp1
         iWb6KoK4x1sgEdJhV45B5HVjmbZ2Rzug6hrnJpQ+L5k1srqWKlqv1prrLhVzFC8zcJfR
         PEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374734; x=1711979534;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svPkrUsWc31u5PxOeTcURerKjA9TBu7K7e3w1kgsNqo=;
        b=HbiLl0WtHKuF6q8/50/iHvbWACUyCu9wQgbb486nuaRyQCYEk3+6VmgMzzdog5y/Lq
         cpRpTQEEJ6GUNdN4UZNuNNgwYGnsryvRUhCzdvnTqBS6gq6Mwlm/bO9yC7pq+1bIgac9
         W9d5RG1sBHbVfmAVZqDQGIz8RjnjsXxf49+Ymd7DhsdMBfcARUmMPYFryzMVvrkaSoi/
         62IM/grRSFfZVA2TIl377CVafBu92qvpMIlkhT0bCMHeOLJftxBqHJIFidz8KYVj35uh
         4knXrorOhtTVfdv08sKKw5FqeX7xBtCkC6DRBD7SWNFg5Gp+TijaVQNRQWfp3LE/3D+1
         O1YA==
X-Forwarded-Encrypted: i=1; AJvYcCWORQtd8BfPhbZhRtP+3WhDTmNoUUiGvjcD7S+t3mmA3Y8ixS5hz/L6XFlPrtypOWNj9Nev70qxhHeaNbxpuhPE0MnJ
X-Gm-Message-State: AOJu0Yx+AZZlZa2hANMG8UsAJA4foAzTuwvjGhy+TUEvGWiCG0Q5i1IT
	Ye05PF01d8SHdFaCZzcziKCvYImOmA7e+5YcCVCW4DjYycGd5WL+76mPJbUDbvs=
X-Google-Smtp-Source: AGHT+IGmFzRBxjkHf31z6d3Lq36FFy7Enc6jBbimLiq65p2x3hU5JphLJecADC001IRmMLuW5xDSbw==
X-Received: by 2002:a17:906:3b09:b0:a46:ba19:2e99 with SMTP id g9-20020a1709063b0900b00a46ba192e99mr4763483ejf.26.1711374733929;
        Mon, 25 Mar 2024 06:52:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a6])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906090f00b00a46d9966ff8sm3114614ejd.147.2024.03.25.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:52:13 -0700 (PDT)
References: <000000000000dc9aca0613ec855c@google.com>
 <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
 <CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com>
 <87y1a6biie.fsf@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Edward Adam Davis
 <eadavis@qq.com>, John Fastabend <john.fastabend@gmail.com>
Cc: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com,
 42.hyeyoo@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, namhyung@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, peterz@infradead.org, songliubraving@fb.com,
 syzkaller-bugs@googlegroups.com, yhs@fb.com
Subject: Re: [PATCH] bpf, sockmap: fix deadlock in rcu_report_exp_cpu_mult
Date: Mon, 25 Mar 2024 14:49:19 +0100
In-reply-to: <87y1a6biie.fsf@cloudflare.com>
Message-ID: <87ttkuber7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 25, 2024 at 01:23 PM +01, Jakub Sitnicki wrote:

[...]

> But we also need to cover sock_map_unref->sock_sock_map_del_link called
> from sock_hash_delete_elem. It also grabs a spin lock.

On second look, no need to disable interrupts in
sock_map_unref->sock_sock_map_del_link. Call is enclosed in the critical
section in sock_hash_delete_elem that has been updated.

I have a question, though, why are we patching sock_hash_free? It
doesn't get called unless there are no more existing users of the BPF
map. So nothing can mutate it from interrupt context.

[...]
