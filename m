Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D60040B6F9
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715599; cv=none; b=XphJXQNDuIrwL/O1w1xfv81fvFcNQoTtCbv60BDEK7MQHyjNujCN9UkVy+Ix1cowVyr3pSsH4QAfqKbH9w54OUQoDMnXtJOtjLLma8wb3jtsv5E+vwQ9eqsBegohkKcrWWfk0xG306EDdi9v2G4Rr9IKiXTBChLnvsqmZqeplCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715599; c=relaxed/simple;
	bh=DfUYYXsYVolkJOBGDsoGOjjsVrZ/w3lSidfgtX590a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci4nZws5mO2SctF19fhn6ZwilTgtboDeR3o8AzzAt6CjKYtuscp0rTV9YrqD0trtLq4meW++aukG5X3/1QLYF+x/8QERHQ4olcqSjjbYKXZC4JsIT5vrB99hLRY6SflugaWh+HblasJTERR17O/UHDaDrciXcWdF9ei5Tjh4APs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xwyo2Y0Q; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xwyo2Y0Q"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6bc87f4d5so197975ad.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781715595; x=1782320395; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ogqM/2AGOpqB9kKy+zSsCvIh6NVF0zsFKZ/hRLV4TB8=;
        b=Xwyo2Y0QSZCzv5rsHBEzxkhgMOR2t/M/S9tpMHe/j29o6SZy7DT+cUD4kTo5IJI8sH
         LI+wNfdn4iP1Xu/fPPAS4TxGOdbLGluJXKiHNPa5Ah6XTUiEjNq4mbURsLg9hVDcYuj3
         dNBz9fDCuAe8uKuqtD9o0+rGY7rgGgiFzqzrjkeeAFUXr+3sJzx/80Uvaeo9XOPcTptS
         zVVHh3rrjsB4HNnJTWCmt+B5r4cgCg1pIZceVrykSQJu9oWGNZfZZOSmlxonmE193bqV
         JOhia3gCSL9B5UTPTXBlqDn6RJzO+XdRkBn81EcPdjkJaqW8inmD7TUfI65pLW4G+Aus
         u8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781715595; x=1782320395;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogqM/2AGOpqB9kKy+zSsCvIh6NVF0zsFKZ/hRLV4TB8=;
        b=OFkd7TWnN/G2ocmFp2uy3GAPE6OvqqctU72VajBJuQk9sxLblJZ/pMMqdoTWkqoEVx
         6gJfyiu9zmB7ihkvREk7HYA9c/Fs2qIZ+3sSwXo346xDN1thTHxepdQEXIEzVeWM6XEo
         YYrHnt9pSYWvhj7uiutuYl2p+tH1Nhi0CicssFjQeE8Ewg40acLRHtuI3NBEK47JN8sF
         vB0GYcayodJkJr4FPJ+h1ft1c+zLQoFDSr//G5L2EEjgn+0WYxVS4CGZzEdA6W3RWBAJ
         PeusuFrfEZ3/QF6wHkigOoBYYR9mKwywmGzQi7xfLC/p7PVKn166TfJ6mjDeEvp3txB7
         Uybg==
X-Forwarded-Encrypted: i=1; AFNElJ9c1pWwUEbWvyzsdOGSKajIxYkTbfMFivLriWk9+I51zGRv3JVXt8n6tKKIr/Po5DCuEVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEOd44WXZKEUjiT5/4m7OwdNeCvjdclozz0UNfee0+dqkR7ec
	vAdaI+V5dECFAn8YaG2rODY9a2Oc1yMXrar0sVejqzKCushIhRkU3PDq
X-Gm-Gg: AfdE7clrmqlmr5zmVlQDtg7fASTNW60iWLJHtKoAaD1ezPwPRf69rebbczZ7v6lf5Fx
	ZV9JB15X/z0/xIpueb7jo+alDAg86zHOLDe9P8RaayVnZwKASsbn66LusvdNQSKHbITZ3EZr4Rg
	iz6QT3QFoEEBtzG0Gdo+XmnpMI1DrkxzV+amBMitLdB9UsIhT0oySSk+wH5ArWS7w8PrU1KydwB
	/2tSErHWCPCLRGYwBtYh4CA0cjjGjqXej3g7cq5XJIs9LHV9hm9gXmr2ci2tfpYOliZ7YzKuPZ4
	e9ZYLwxXrrjXkMQTBz3rfD3VoIP0odDUMDnPBK09kO4AXvYyHWhuaSxjmUWhXJcxrIXtnYh4367
	BC7cswMKqCV8RCtgQfCHVWn/R7cbdSF7hZVYSx/SxCNlR1M2Xv5Qj9+5/T7fZPIQSYnMCkCXx+v
	XYPu/DdjWCmVXBtNMruYQu
X-Received: by 2002:a17:903:1987:b0:2bf:1e37:a2ff with SMTP id d9443c01a7336-2c6bbc9d303mr45282205ad.0.1781715595387;
        Wed, 17 Jun 2026 09:59:55 -0700 (PDT)
Received: from john-p8 ([98.97.43.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8c1f9sm173853505ad.59.2026.06.17.09.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 09:59:54 -0700 (PDT)
Date: Wed, 17 Jun 2026 09:59:52 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix lock inversion between stab->lock
 and sk_callback_lock
Message-ID: <ajLR9CRn6O27Ound@john-p8>
References: <20260616091153.2966617-1-rhkrqnwk98@gmail.com>
 <575a878e-6d37-4337-a821-4883d3dd3a63@linux.dev>
 <jxrrwhfd5igwnlo6v5y3l3grqhqqpiedfnsqzg62cmwxwaa7xd@qzthhuahjm5f>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jxrrwhfd5igwnlo6v5y3l3grqhqqpiedfnsqzg62cmwxwaa7xd@qzthhuahjm5f>

On Tue, Jun 16, 2026 at 06:40:09PM +0000, Sechang Lim wrote:
>On Tue, Jun 16, 2026 at 06:17:48PM +0800, Jiayuan Chen wrote:
>>
>>On 6/16/26 5:11 PM, Sechang Lim wrote:
>>>sock_map_update_common() and __sock_map_delete() hold stab->lock and call
>>>sock_map_unref() -> sock_map_del_link() under it. sock_map_del_link() takes
>>>sk_callback_lock for write to stop the strparser and verdict, giving the
>>>lock order stab->lock -> sk_callback_lock.
>>>
>>>The opposite order comes from an SK_SKB stream parser. On RX,
>>>sk_psock_strp_data_ready() holds sk_callback_lock for read while running
>>>the parser. The verdict redirects the skb to egress, where a sched_cls
>>
>>
>>The commit message is wrong. A verdict does not redirect to egress
>>synchronously — sk_psock_skb_redirect() only queues the skb and
>>schedule_delayed_work()s sk_psock_backlog, so egress runs in workqueue
>>context, not under sk_callback_lock.
>>
>
>Thanks, you're right. it's the inline ACK, not the redirect. Sorry for
>the misleading changelog, I'll fix it in v2.
>
>>
>>>program calls bpf_map_delete_elem() on a sockmap, which takes stab->lock:
>>>
>>>  WARNING: possible circular locking dependency detected
>>>  7.1.0-rc6 Not tainted
>>>  ------------------------------------------------------
>>>  syz.9.8824 is trying to acquire lock:
>>>  (&stab->lock){+.-.}-{3:3}, at: __sock_map_delete net/core/sock_map.c:421
>>>  but task is already holding lock:
>>>  (clock-AF_INET){++.-}-{3:3}, at: sk_psock_strp_data_ready net/core/skmsg.c:1173
>>>
>>>  -> #1 (clock-AF_INET){++.-}-{3:3}:
>>>         _raw_write_lock_bh
>>>         sock_map_del_link net/core/sock_map.c:167
>>>         sock_map_unref net/core/sock_map.c:184
>>>         sock_map_update_common net/core/sock_map.c:509
>>>         sock_map_update_elem_sys net/core/sock_map.c:588
>>>         map_update_elem kernel/bpf/syscall.c:1805
>>>
>>>  -> #0 (&stab->lock){+.-.}-{3:3}:
>>>         _raw_spin_lock_bh
>>>         __sock_map_delete net/core/sock_map.c:421
>>>         sock_map_delete_elem net/core/sock_map.c:452
>>>         bpf_prog_06044d24140080b6
>>>         tcx_run net/core/dev.c:4451
>>>         sch_handle_egress net/core/dev.c:4541
>>>         __dev_queue_xmit net/core/dev.c:4808
>>>         ...
>>>         tcp_bpf_strp_read_sock net/ipv4/tcp_bpf.c:701
>>
>>
>>I guess it is an ACK. What is the actual purpose of a sched_cls 
>>program calling
>>
>>sockmap delete on the TX path of an ACK? If there is no real use 
>>case for it, this is
>>
>>just broken BPF usage, not a kernel bug worth this change.
>>
>>
>
>I don't have a real use case for that exact program. But the verifier
>allows sockmap delete from tc, and it deadlocks when the strparser's
>socket is concurrently removed from the same map. The fix only moves
>sock_map_unref() out from under stab->lock.
>
>Best,
>Sechang

The bot also thinks it found another locking issue. I'm not sure
supporting 'tc' is really needed here. sockmap is much more easy
to reason about from socket layer. What about just blocking sockmap
manipulations from these prog types.

My current thinking on sockmap at the moment is its has sprawled
across so many layers the locking is overly tricky to reason about.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d9bdc3b32c05..5e08d3e03453 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8567,11 +8567,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
                         return true;
                 break;
         case BPF_PROG_TYPE_SOCKET_FILTER:
-       case BPF_PROG_TYPE_SCHED_CLS:
-       case BPF_PROG_TYPE_SCHED_ACT:
-       case BPF_PROG_TYPE_XDP:
         case BPF_PROG_TYPE_SK_REUSEPORT:
-       case BPF_PROG_TYPE_FLOW_DISSECTOR:
         case BPF_PROG_TYPE_SK_LOOKUP:
                 return true;
	default:
