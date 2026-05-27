Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBBF368271
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909366; cv=none; b=cepurKzGyWW3zugkWoZld9ZuR+jqNoJtwpL2nWBONF7MAW0k5vkWMhFlGsW29p05EFDniR0A58C4ax0ffwTZxt3yI3Y9JhL2p7Z+DZ/bbMavhR7h/vmi+m/ffE9GCNyJEhf0ClJVuPIhAJzY7GMdc4CJXoP1o8P8Zmxzu1CS7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909366; c=relaxed/simple;
	bh=W3T4QxdLFfHbdc/KmpcaHHy9IfSTsNZ4bf6F6ZMHiTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epYHrJ++iVSPfgl2aYUgd5kVILp6xFn0tPwRbKbbQxNFOa4yZG73bYs0hRKw/cqISwiQH7ypcUA7L2/tjBhJOeUzOL7K99NL9qr+2Pt8mAbEnBB3+l+8MnbxySRJr0DigXQtFxRJeRccaTQbykC0i18e+OfuthqeDA7LdrgT4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ValWSb2X; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ValWSb2X"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f8b60e485so5183123b3a.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779909364; x=1780514164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jVdozbgHNmRboTjJqPe1n9RlPVUR0qDZvYcaF2yAV8s=;
        b=ValWSb2XLrdf3Bw6PhZo9e+CRjbSLnpGiuOU5m4gAa41n1wUh8H8bFDhf+XAJslB2h
         /448U7HWQ4FjK9XeYxEPgefvubM0bnISKWa4CRNt0kdZhJW9VR8eJ7A4/2z6Zm/BPAGf
         g6as7/kz4YuAY9lGEGPGfeXwks+Jj/7TSoPLrbW/RwJALfQtBo8XlwucBqaWKcOBQLM1
         2nYgOZYX6G9y4RbrYBZYfdvtIJGEs8VsQOZL0pzOdXDwcAwwdy3+n3B2fxv6xsZk+2vM
         EdM5rf0i0mq4LAgb3fqvp63PgK+3fNb1QQoxS1zJs6PpS2hYI52rHrKMfSfmjckYmd9Q
         b4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909364; x=1780514164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVdozbgHNmRboTjJqPe1n9RlPVUR0qDZvYcaF2yAV8s=;
        b=KfaPs9TPYqkk4SBPJ4yh+5nlaVSD9nvB4G3+zCsuyX85CQrhNr9nzUuoPO8LYtRQ4Q
         OVahFD2EcMQvXcQmqyyh4Vkvs4Q86w0l4jMuPceLxOIKXOQ0obYiE8+E+TgItMk1b8dM
         ONvLuiCiken/OLHDHphh7VHg0r3i1uh3IAG1v4r4D/1eAYPp4HTes3A/OyJVZRymWcK8
         uPbQUB03u8epIKoK2Jf7t229LmEGdasoTgE8ugHwrpD/5PfrfRbaDBrdPvP/BvH+ESfn
         c1EjfTH4boIwQOiOcc0s0tNlLeoJZyWpZzJX2xaf9zhrOKi03tKbzJrqjuTw1t3yEOAn
         DsFw==
X-Forwarded-Encrypted: i=1; AFNElJ8ccXexpjOIqjFT2PwAwQg3qkbpO7zx1dX8kDmzZSFK5TjiU2Yo4+Fy5FT6QLHnfpgzgKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOYR1BzUshfr1Us1kTVZW+hmAqZNtTdlLHNmOUNB6HuE5nD3N
	ov7Erbn9988Ybmseix1+iqC8FtT4DpWwycn4OPLd9uPS5eVZVqlePYZZ
X-Gm-Gg: Acq92OFbpZ81Hig8E1v2AIN88nu9jjCN0JPz7u/NtTYyXtnwcku9ZZHrwtPPbHrERHL
	Huu3QgCimZbdpaBbTMGtquP5polplZHn4r1Y5oSjerZAJiiobZ0OUB+lgZYtEZPH29uG1QAQDMw
	JVKkuEtHNw0wNG4d8xQdinY7mHH5gJWTFAJmaFiFzoWwnD4gie1zxuo3eyzfdFf5IQaul73Fhld
	POFAcd/YwRYQO+MYU490q2zVpp+2H6BTh5hFD8JgZFbMEjN5qgpfUIUtWwErKtHKSTympQ1hsJI
	YuQeFqBmbB9z8a2mExHXjViEu013UnOCkxUcCn0LIXhxvr1uspCNgl/d/qgjT+nsUeRnQ99XEVC
	q1WLbTNXm0cOPrik5FmzX7wmy3k8v2LG9uKGzfz5kEPC/AIfiHXP58a8RKty1rtXNs1eaEJ+YAF
	gEoX6b059jWN+JIkFr3maLTcfhZ7si2ZRM
X-Received: by 2002:a05:6a00:2384:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-8415f0f02cbmr22578450b3a.10.1779909364354;
        Wed, 27 May 2026 12:16:04 -0700 (PDT)
Received: from john-p8 ([98.97.42.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb18bsm3595235b3a.34.2026.05.27.12.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:16:03 -0700 (PDT)
Date: Wed, 27 May 2026 12:16:02 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Christopher Lusk <clusk@northecho.dev>, Sabrina Dubroca <sd@queasysnail.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Message-ID: <ahdAboFpUAZ8aaWm@john-p8>
References: <20260526025154.60607-1-clusk@northecho.dev>
 <d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
 <20260526161101.691d4cb7@kernel.org>
 <4626d285-57ab-46c9-b75b-d56efe7417fc@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4626d285-57ab-46c9-b75b-d56efe7417fc@linux.dev>

On Wed, May 27, 2026 at 01:09:44PM +0800, Jiayuan Chen wrote:
>
>On 5/27/26 7:11 AM, Jakub Kicinski wrote:
>>On Tue, 26 May 2026 14:44:24 +0800 Jiayuan Chen wrote:
>>>If async_capable is set to 1, the zerocopy path in tls_sw_sendmsg() is
>>>skipped.
>>>Unfortunately ktls with bpf_msg_pop_data() does not work correctly under
>>>this
>>>copy path.
>>>
>>>tls_clone_plaintext_msg() aliases msg_pl onto msg_en's plaintext area
>>>(in-place encryption).
>>>
>>>BPF runs bpf_msg_pop_data(msg, 0, 2). This shifts msg_pl's SG entry
>>>forward by 2 bytes.
>>>The two SGs now point to the same page at different offsets. Physical
>>>memory overlaps but the start of
>>>address differ.
>>Ugh, do you mean that the memcopy path is broken? There are other
>>conditions under which we may fall into it than just !async_capable :(
>>Small send with MSG_MORE is probably the easiest?
>>
>>So we need to fix that one way or the other.
>
>
>Yes, the memcopy path is broken, but only when combined with sockmap's 
>pop helper.
>
>
>msg_pl and msg_en share the underlying page:
>
>                       msg_pl           msg_pl end
>                         ^                     ^
>                  |------|------------------|-------|
>                  | hdr |   plaintext     |  tag  |
>                  |------|------------------|-------|
>                  ^                                      ^
>                  |                                       |
>              msg_en                         msg_en end
>
>Before encryption, sge->offset += prot->prepend_size is applied
>to msg_en so that the encryption's dst and src point to the same
>block of memory.
>
>But once pop has run — i.e. msg_pl's start advances — the encryption's 
>dst and src
>are no longer the same.
>
>crypto_ctr_crypt():
>When dst and src have the same address, crypto saves the encryption 
>result into a
>temporary buffer and then writes it back to dst.
>
>When dst and src have different addresses, the crypto module treats 
>them as two
>
>separate buffers and stops considering in-place mode.
>
>it's complicated to process pop/push + head/mid/tail...

For our use case (not deployed yet, but deployed in non-kTLS case)
all we do is observe data and possible drop the skb if it has
malicious HTTP headers for example.

All this push/pop/... in the middle of the kTLS stack is painful.

One option we start rejecting these helpers? That would resolve most
the pain I suspect. The original thought was we do have use cases
now for userspace proxy where we insert headers.

>
>>>I think selecting a sync provider via mask = CRYPTO_ALG_ASYNC is
>>>sufficient to
>>>remove the -EINPROGRESS return path.
>>>
>>>May be time to remove skmsg from ktls? (disable by default first,
>>>re-enable via a new ktls module_param?)
>>Yes, we asked John F off-list to get his attention and I think there's
>>only a vague plan to start using kTLS + sockmap, no current user
>>(sorry if I misread / misremembered).

I'm not against a cleaner solution here.

Another idea: We just add a simple sockops BPF hook with the sk_buff?
No updating sg lists, manipulating data packet sizes and so on.

That would solve the vast majority of any future use case if we have
a user that really started running kTLS and wanted the security stack
to keep working. Even openssl usage of kTLS has really ground to a
halt after it was initially added as far as I can tell.

Something like this already on the list for recv side of tcp.

  [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook

>>
>>module params aren't a great API. If we want to deprecate it let's just
>>remove the integration in net-next. You have my vote..
