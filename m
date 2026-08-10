Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03943847B
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386955; cv=none; b=cc1HtkyhSRRRq61w0f4gV7MmJCUST3i8JkV8vO0691YVAWUS3f8eVVvuML6qCC/HORIT37KS9QC6swvKpzXEYmTIhRnW9BR7cimxCmV2F9o8JdDyTZ7v0k+5j9zUgSJ3rjcL7CosktoLtDPgQ29+uEgSsFBLPiz0iD3cqypXgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386955; c=relaxed/simple;
	bh=VFvhje9ONwo8tsHkXIxD0CE/7U5QDcliaCcHtzqjCsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5HPSSRwYVJrdh6TVSwIDqj7A5azQJpCNyy/fgf3uTc0VuZsZ6KDFrPLhSXdGh9UOVAoEsR/UK4Rggfakj3odOPM0q8XAkCVHlWbGlzR3unV59W8xlTLuL+CHJ5wp4CgwTmKKXivVGCZ2R5un7/h9ftJLzH4I7j3ebuKY/vx2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6hKWiO8; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6hKWiO8"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-380f4166f80so2023969a91.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386954; x=1786991754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jtr2BaGwELh4jAzhl4BDW4Dq7f/B62WrbZTY8vzy1rY=;
        b=W6hKWiO8YqJIS//wX9NQCnL2vIY8hj8qrmd63YjIYsn/zidQwHAUeyzrBsCZ2VvR0a
         r0E+1InjlmJYqHTZz1ZFCnpFD6E4YjrvpVYxo/M61iMn2RGSW8HIcoMtyiL3M0Mag99L
         g/lVjWNgdVEPDruG93iGXENa0eGLIwC202gVnOdu2vO4Y59GVOzLanbVcZXBYNfRoKQe
         LtY6wQeuFl0pwBfJta9+/G/H8kXDQMbd7XZtdV5QEMJ02WWsJwCceghjYp78wMweYNe/
         TA8MJl+yz3vWBIorAE/vnHBMUUTsp1j9jLkqRGbepdjTghJC67k2WQsru452B/U3LTT4
         ETdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386954; x=1786991754;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jtr2BaGwELh4jAzhl4BDW4Dq7f/B62WrbZTY8vzy1rY=;
        b=b5wjk4C2nzAT94mkEfbp/hMLFHiRok1/KNH4OupkwhAQlOhqDjrWC9+cykgpDpxU2G
         lmxT0PZ3lojAZNLE4BY6Qrfk6qycEs122S7qaIURSufVJ5D2ndsGMJp365SCiy5Cz3U8
         gNhuys0fNOB6ta5Dr1NBdAExQ2bqZH/622iSCe7L8a3JmL+XY83XmgO04sG4hzUTvDTO
         d/cGrmMEVMQu9OAMUw8OcLDR+CHZHYKYdjgJrDSwGLtrrcrtokTnA2z9mYCoJSm+oR8M
         ch5M0sTcjghWnKYTRnQ4OtzrRIXgxPeM/neOYnUenmS7rMP3vJa9ZHAhosmV9obvWPHb
         RbLQ==
X-Gm-Message-State: AOJu0YxoqFu0NemABATfnmE8kCA0WqrLBOu77foxVSj1bO6+6Os3YklE
	7B86fup5blsK3/XhrhVMGVCETtmXiqLclc0H26D97F0mCLf4RgzaF6Xo
X-Gm-Gg: AR+sD11BjNzuyWEsQcMHD7/MCoR3SMWA91iTMgbtHqmJtYDeTRwb3BkXhj0u1e9yf1m
	jRCgL+uDwLp2WIaSST2N8aFWRT850Q081lFaLJWXEMP0Wap9vuAK7t4XluHQdH++4vsSe1GdjR1
	q6DaV0DJ7O3qBmmxx7h5/u4ufHQewaboCv1ESioBZRXEkyTFDjx11nJbxPHmorrDXwi0c+X3FnY
	gvbSMmeufBPYPHD5dWCA6F27zUbEWXrIF/6HCuPSarf/meaFirR81if2pkcd6SrBWsj60tWu83R
	xNR8mhubCKv1sHAZIpFVGZZeDRPxqVTudroXvOeCD6XQNqDGyenPUG/8U6x5Qd8xBPiOH7AFnvb
	VDzZX8Q/jKV3svsRYs4XuKIqlbq12fVDPYEa8xXr/6V7m68vkC5dXdGAS0qZmO0knXTOMIGHLR0
	2P4MgyxgjB2fuoPdVmhqiDn/Qm3MD7EL0DrOFfYGLroj/lO38hj0ePIw==
X-Received: by 2002:a17:90b:2dc7:b0:380:fead:448d with SMTP id 98e67ed59e1d1-392620e6e25mr29135359a91.13.1786386953837;
        Mon, 10 Aug 2026 11:35:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5190ad0sm600581a91.2.2026.08.10.11.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:35:53 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:35:02 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add ksock kfuncs
Message-ID: <anoZycesG-0xFh6o@devvm7509.cco0.facebook.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807171532.125149-3-mahe.tardy@gmail.com>

On 08/07, Mahe Tardy wrote:
> Add BPF kfuncs that allow BPF LSM programs to create and use sockets for
> sending data. This provides a mechanism for BPF programs to emit
> telemetry. For this first patch set, it's restricted to SOCK_DGRAM
> socket types with IPPROTO_UDP protocol but could be easily extended to
> SOCK_STREAM and IPPROTO_TCP in the future.
> 
> The API consists of five kfuncs:
> 
>   bpf_ksock_create()   - Create a socket (sleepable)
>   bpf_ksock_connect()  - Connect socket to remote address (sleepable)
>   bpf_ksock_send()     - Send data through the socket (sleepable)
>   bpf_ksock_acquire()  - Acquire a reference to a socket context
>   bpf_ksock_release()  - Release a reference (cleanup via
>                          queue_rcu_work since sock_release sleeps)
> 
> The setup kfuncs bpf_ksock_create, bpf_ksock_connect, can be called from
> SYSCALL programs only. While bpf_ksock_acquire, bpf_ksock_release and
> bpf_ksock_send can be called from SYSCALL and LSM programs.
> 
> The implementation follows the established kfunc lifecycle pattern
> (create/acquire/release with refcounting, kptr map storage, dtor
> registration). The kernel socket is wrapped in a refcounted bpf_ksock
> struct. Cleanup is deferred via queue_rcu_work() because sock_release()
> may sleep.
> 
> The kfuncs are only compiled when CONFIG_INET is enabled, as they
> specifically support AF_INET and AF_INET6 sockets.
> 
> The socket operations go through the expected LSM hooks instead of
> by-passing them like many kernel sockets since those are created by BPF
> programs and thus system users. Thus, the bpf_ksock_send() kfunc, which
> is exposed to LSM progs has a verifier filter protection to avoid
> recursion so that the whole bpf_kfunc_set kfunc set cannot be called in
> a program attached to security_socket_sendmsg(). Also, because of the
> LSM checks, we prevent the use of the kfuncs from asynchronous workqueue
> as the current value would then be invalid.
> 
> In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
> since the kfunc can sleep and the arg values could be stored in a map
> that could be re-written by BPF progs or even userspace programs if the
> map is mmaped.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
