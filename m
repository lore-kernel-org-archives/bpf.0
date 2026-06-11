Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C82D73A6
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 06:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160207; cv=none; b=GS5SKSAFXzFbAtCC/34/A6zR9EsNDKTO5WyDlEBDOOTQDI1St7VlkPasRGB+c84Iw5aKjk+rgOghAaSC60cx8YHDnu+sME4VUJe6zjT26GkCQUsU87Ybhdjb4syfTAu4UVLnCelpQyKCEGwgb7YWIys/vu5onU0Y6ZLFT67IDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160207; c=relaxed/simple;
	bh=K/M8coSFnq6IsTOuqp4zuktQLAgl5ei8ih3qN6roLE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFWy4bIB+ZK3M8rg+PBXBA5/DFCGwxXD0+mUHsIcIyfrDi2xbYQ294HeJ67GTxJoQaqIEZO5P7BUVVgc+diY3IlKslTjlSiBWO90BmMvKmbVicXOh5Q6NX5s7GoJ1e+ZYzp2Vc4ph2HFjLi8L8phFKwI7MvJg5ZdWKfhqxjXthM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck/M3nVb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck/M3nVb"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c3546924so50943905ad.3
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781160206; x=1781765006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JjDQiQ3ktWIaKvOvujnBDVWDyaYYudokO5mTxz5o6xs=;
        b=Ck/M3nVb4WBIfZ7VS0zlbZj/4ugA0ud/3l2us/u12bU7qd7NCEC5xOthvWgC3oYezQ
         wshbEryvIkk/7A+QHnGF3F2OgxndYp86MGe+BMuxd1rQvhWoVgfUSu0+lTT17tZLx+Ct
         VYKnNZDAJ1UCnAxPUftD8g1iswPmhheMISeOV4m/x+J19Fl2VTqMTFubMhu5AnScy8N9
         cqH/7FfIvDOQUuXSk2JdQpxX4JSDnguwplnVoxMJn7gujehRoIbgEB8xpNyajRqrBP/y
         cZ345mIqnV9w01F6rOR3aVNey9eg2643sSKWGeEShL4mrc00yNInSegKHf4G5wCm3+XU
         8P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781160206; x=1781765006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjDQiQ3ktWIaKvOvujnBDVWDyaYYudokO5mTxz5o6xs=;
        b=Fn3RrIe+x1ffGiPBA/O1NhzoG5+IfYG/wZa4S8g2TQCYp/1xvf5GSWAg6ozluPBE3Q
         dVEc2/xT0fD+5ULilj2WCiVa0HiAXTkldPzQ2yx999NfcWUm7J4iExhvaKuE2kdRW/2K
         FWHeXQ4mOIhGQQXa3ZI5NuUgE7t+TparbY962jiScYCPvCSsc3n3M+VPVS5yDufU4E7T
         2ge9Dsi60b2KMI+2hVFD5dWqiqwrnyVmAaJfDC1R+nGJoxYPHlNKqHBOmKPVxpifFwA8
         FU3acuvR4VrYosKS8nmPje5xX3LRs3eMGHvhnMLwmLT+wsEsRZUdE8rAIl2SowVfr0iQ
         spLA==
X-Forwarded-Encrypted: i=1; AFNElJ/3x5DiymJxiMV0Alkm2ywKBn4Vqsj/Xh5asxhK1BrU9OBhxXBDuHAIwwDWwYZKBNHy2b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnVSnovzs9Hp2htvfN71qSEnsz1CWUTFJNLJ6vFQuA4wugIhn
	VvZCKae/uFPzCN6HrHorB4XMgmJP0syqeGGa2+5cguuCO981y/kdnULq
X-Gm-Gg: Acq92OFtnbWkhUVZwaImkNcPihcKXOLFSltx8ZQzRSpgiGWYYOCDiWZGf15HQf85Pfl
	t4gWygjnwcjg0HxUX80RSYsH24GMCv3N9SaUL9/5QSuYLn0crrewKTc0x9zfSoNjJu9ERdenesG
	8cNAN07WZaRgHNUzPuy0MI8lRiNTaDO+eA6GgLoFNHdMR9UnOfyiZFRoF0MzOfTCFLgtoApgBNB
	8Mzo8u3FOc32Ny100iKuiI4lXnsk9EZnrrs2N/12XHZiu1KkTfXBtyKClXgllIPYC/L4Hzqabpk
	iI6VO2vc4bOFe83JcwJP1VOzFhIRqURrE8C7jFLrYD6YQl99AhV4y7BWUq0qmS9eYwZQtCB+PEQ
	5qe+CMI87MdkoMA6dYhFt4K/fsWr2fP8RReHfLF6et0eX+XYIYcFRm79e3bDLnCBs1Nw0egEjbH
	wTj72NJ+LMK9Q+iV5DiflMGm+fQtgCeH2obgJYSmN4YxdnYKeWfxzO9b1hZxORVF02t59fMfBul
	0KyJozu
X-Received: by 2002:a17:903:acd:b0:2c1:f29a:b554 with SMTP id d9443c01a7336-2c2f21a11f5mr16600215ad.21.1781160205915;
        Wed, 10 Jun 2026 23:43:25 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edc8ad7sm144553485ad.42.2026.06.10.23.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:43:25 -0700 (PDT)
Date: Thu, 11 Jun 2026 06:43:17 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH net v2] tcp: clear sock_ops cb flags before force-closing
 a child socket
Message-ID: <xidpdd43jvuzb3ifbsnjjr7puxc6cmh4abp566rv2twollkn6s@eplmy3mtfksj>
References: <20260610155946.894878-1-rhkrqnwk98@gmail.com>
 <CAAVpQUC-ibCY8-xSc4RL5M9Zvbm6owpethgBK3-W8GmqbPVTTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUC-ibCY8-xSc4RL5M9Zvbm6owpethgBK3-W8GmqbPVTTQ@mail.gmail.com>

On Wed, Jun 10, 2026 at 11:11:49PM -0700, Kuniyuki Iwashima wrote:
>On Wed, Jun 10, 2026 at 9:00 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
>>
>> A child socket inherits the listener's bpf_sock_ops_cb_flags via
>> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
>> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
>> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
>> without it.
>>
>> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
>> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():
>>
>>   WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
>>   RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
>>   Call Trace:
>>    <IRQ>
>>    tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
>>    tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
>>    tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
>>    tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
>>    </IRQ>
>>
>> The child is freed before it is ever established, so it should run no
>> sock_ops callback. Clear its cb flags in inet_csk_prepare_forced_close(),
>> which covers all forced-close callers.
>>
>> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>> ---
>> v2:
>>  - move the clearing into inet_csk_prepare_forced_close() (Jiayuan Chen,
>>    Simon Horman)
>>
>> v1:
>>  - https://lore.kernel.org/all/20260605094954.1374489-1-rhkrqnwk98@gmail.com/
>>
>>  include/net/tcp.h               | 7 +++++++
>>  net/ipv4/inet_connection_sock.c | 1 +
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 98848db62894..97eac5fa341c 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
>>         return tcp_call_bpf(sk, op, 3, args);
>>  }
>>
>> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
>> +{
>> +       tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
>> +}
>> +
>>  #else
>>  static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
>>  {
>> @@ -2959,6 +2964,8 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
>>         return -EPERM;
>>  }
>>
>> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk) {}
>
>nit: I think prefered style is
>
>static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
>{
>}
>

Will fix in v3.

>> +
>>  #endif
>>
>>  static inline u32 tcp_timeout_init(struct sock *sk)
>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>> index dbcd37dfdc15..209f73a61a1d 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c
>> @@ -1290,6 +1290,7 @@ void inet_csk_prepare_forced_close(struct sock *sk)
>>         __releases(&sk->sk_lock.slock)
>>  {
>>         /* sk_clone_lock locked the socket and set refcnt to 2 */
>> +       tcp_clear_sock_ops_cb_flags(sk);
>
>mptcp's ->syn_recv_sock() will trigger the hook in the failure path.
>
>inet_csk_prepare_for_destroy_sock() is a better fit.  We don't
>care if the child socket is locked in this path.
>
>

Makes sense, I missed the mptcp failure path. Moving it there in v3.

Thanks,
Sechang
