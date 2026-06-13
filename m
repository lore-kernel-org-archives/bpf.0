Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475C13B58C
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309893; cv=none; b=r09/VCWzmw5L2MmRuFSC+fWdLdVXFM7DPv6hYKXS1W2ifO/9+Fsf10PUzzHU3B5lCImO2Ivz5YFW96WFN2j0FUiO4PWKqKN0yWtdKI1H/McSVOkVRHnFeGBRJHRWae3nkg3BSYPsvC0jElJgnTnyHiM2Vsk81cZAwZG2cjELxSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309893; c=relaxed/simple;
	bh=fO5bIS7T32qmhvQPtoFme1D+CA70Mblzls9B5czEnB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BH+Uv7gXrTTLVeS4u8ufNxAYYpLxMPeW2ThS4uFULIP7HFmXaoKoriNuV3So53wcNzIRgpcYYuw+MAxGHcGzDJASmtY5TXYhNZ5OHOpvIFw8aEr3BV8UL/7NeY4A6GslED8ZQbRn6C0sohdK8pHenLAK26CRkvhpahqDDvS053c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUMA3xMg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUMA3xMg"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0c272e532so15412565ad.1
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309892; x=1781914692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+VMYc+z8VkDSiefkxwsG30lb919a3RxfPEsLaGriGM=;
        b=HUMA3xMgkumL6cNTwk5zanGzQRdzJRFNCtoKC+Lvi9ASztgpD97SXm3HPlqeDLI/Ro
         7fhtQWno8kMTG29nHFypfEeCSK2/01CEEV9rqkL8xqmO/vfr2b5v71d3qH2HmRJOzGdR
         qkumvnvpVZ19aVVMQ1MtMY8gENOKfi20Nxik5QQd3MqzfbCbwbHAT99nx6nQKJgdTcVO
         B4SZUTBJ/2Y2LaumaMtb1Y7OVn1C0YDr3RMiCCiJ/feOz6rsdZ5vm+myjFIRYQZacNv6
         ocvtPMR39ewo6IqX4BzyxFGrFXxGU5P0vqGsMF5U0sDBU4VpFckpm825EB+hB8rA2g7g
         Atbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309892; x=1781914692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+VMYc+z8VkDSiefkxwsG30lb919a3RxfPEsLaGriGM=;
        b=KwHifaI5lxNaqCavUkaRvp6BcV9Wdwi9ZPeUaS+cwLLm+xRemHq3tnDBPpXdEVbp+T
         8Sb9ZIcA0ojWXl7M5lDC3w6lkuV0l7Fry9j4FwtvaW/HqwiyxrkMrKJhCNtA3j9Bgc00
         5FODbVEbH7X8TbOx0YlONzv0WjRRLxba244rHvyewbmQKr3IDv/sy9VdB2hlV5enrccX
         XPdkVDK2GR0ViabXiskEpgPQCAkalWWEln2+zj+8VVBusHTHv4vpAe9j0z7eTQyQ1G+L
         /mtpZKK6LOfLfCxPCGecvcf0Jecvdmtibxti3MHjY/9wUUDs2MY9VAIEpi6qI7d1QvnF
         b6RA==
X-Forwarded-Encrypted: i=1; AFNElJ8RTyelIUVHpiXD0YE82257OL9CdONPnp9zphmUkSj32OSc8gtpUb+gEareb5xvI/66WAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7LBpNImgfbuA29ejQ20knGPdPR3dwHAtAVq0OXxKKs5q5o5x
	45Z1FotDpykfTFUxpMC3UnpoDbmkEXERbNgNspX2zuq4ER4EBQPADoTBhuEUq0ngp8Pg2MELpLo
	e4sRtKw==
X-Received: from plhz24.prod.google.com ([2002:a17:902:d9d8:b0:2be:bf91:ff92])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2351:b0:2c0:c3ac:4af3
 with SMTP id d9443c01a7336-2c66416ac4amr20227845ad.15.1781309891366; Fri, 12
 Jun 2026 17:18:11 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:17:31 +0000
In-Reply-To: <20260612130919.299124-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612130919.299124-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613001809.1329995-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jiayuan.chen@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bestswngs@gmail.com, 
	bpf@vger.kernel.org, cong.wang@bytedance.com, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	emil@etsalapatis.com, hawk@kernel.org, horms@kernel.org, 
	ihor.solodrai@linux.dev, jakub@cloudflare.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, rhkrqnwk98@gmail.com, 
	sdf@fomichev.me, shuah@kernel.org, song@kernel.org, xmei5@asu.edu, 
	yonghong.song@linux.dev, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Fri, 12 Jun 2026 21:07:46 +0800
> From: Weiming Shi <bestswngs@gmail.com>
> 
> When bpf_msg_push_data() splits a scatterlist element into head and
> tail, the tail's page offset is advanced by `start` (absolute message
> byte offset) instead of `start - offset` (byte position within the
> element). This makes rsge.offset overshoot by `offset` bytes, pointing
> to the wrong location within the page or beyond its boundary. Consumers
> of the corrupted entry either silently read wrong data or trigger an
> out-of-bounds access.
> 
>  BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:2728)
>  Read of size 32752 at addr ffff8881042f0010 by task poc/130
>  Call Trace:
>   __asan_memcpy (mm/kasan/shadow.c:105)
>   bpf_msg_pull_data (net/core/filter.c:2728)
>   bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
>   sk_psock_msg_verdict (net/core/skmsg.c:934)
>   tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
>   sock_sendmsg_nosec (net/socket.c:727)
> 
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
