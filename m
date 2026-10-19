Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438836;
	b=uQ0LbNtF2OrybETStDPXu+GhN5JCUkjIgsrZyfqgCcemcfjNY55ylAaW6Wljfp9wJc8a
	 OY/833Z/NY5j09VYXUhHMwIGMMFp/h74w5lH3e8HSrk68UJojdJt91nDZWuhR7zu5vSZf
	 gOb02glDpBmG8rusG7WE9LoRLFGD9kqD3AzpoGm8lrKBWDObltuWYpaQXiudqFSORtnVh
	 1UUMEZhlYQddkVEmAIRFdtWpUZV34DjTJHDmm7JXtZh2E4g4iGidOqIOZCr9mdu2gb2Gr
	 1NSutVY08wCE+2lUFWy1Sz1w0WurjLpINFyrjEA4IxlbzvTzeepEMD8CKHmA6rgCH1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jCMFezbT/OjEFJBH7XUEU5R0jVHmGVvv13z7WJO3X3E=;
	b=mtNCSxmCU7kHtfQE5sZEXqTiqJR951j8GWiGf7XsbTq9W9qgOW0L05f9r2KMB1qTo1KG
	 SGm4dP4Dtn7lk2lh99Ylopr838bDv8h+wZUDzoRCQT5sguVPAWy4sIPCntWqP62Df/m6i
	 b8Saj+fXatNLemQCC8/qCjUeTRSgFdU0VghXY3iOPBfuC7lOxrQMUojnYLLGjXci3ObsZ
	 2wcentbxf9jehsFukIcuUV0NnUGmUOvcgiJCfAA7Is0djZda7Q12k6qt8QReNUDnvYK+j
	 c5UdtBhnA/ZyGYbaVJ4Ss7MC3xKBs28n+vwG9H5mU/quRjZxPwzpnJhfu0K8RvqfqBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AwKLsCH0;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CCB606A32A
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 19:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25CCB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AwKLsCH0
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1480671a91.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792438835; x=1793043635; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCMFezbT/OjEFJBH7XUEU5R0jVHmGVvv13z7WJO3X3E=;
        b=AwKLsCH0eCBDjV+uPmQSwL4hPhllyt3bz/fVOAvm5/kXUvXjTfvH5ZqqwpMjcpWh7X
         JNTxMbWNTnOOwfXbMPriw8L2OXABTAKygX/SZvHJZ1HUu28hcBLfI3idDkgcBZthXgRY
         0eR+LXFb7SEPUh1Yf59T1npD6SMgsMin2amGbSD84ao89WhG+Ue/0EqTaQfQaqACnz/+
         W8o82Ko0xYys8Vw7SK4rYh768XCtXLQJMz6T5e+Ji3fgRQjW6XAAltPMFl7/V0vapMPw
         M/XEL58w+kM5QEI3wTtJJHMYu1JG/ZgGFaiHo2zb1UPw3+bQKTRzCt16qNpTGAPufCbR
         OLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792438835; x=1793043635;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCMFezbT/OjEFJBH7XUEU5R0jVHmGVvv13z7WJO3X3E=;
        b=oZystsCMLf3qg7vWRGG0VB42sCkQZyEkfPdsr7wqaDSBdT60SVLk55a4YpkdMgHgxl
         QLuSUp7/SaCHEvz3BkTsqEsAQ499AwF26kQkiymG3NZAvG9Aad+y3gz/t/BVoA+lhTOE
         n2yccN/PX2FgNngRmFJh/GjghfpslubxHV5gSMaXF2Ihuy7NNVTFd/kCxEMxqX1PsWid
         v3WNKMjryZtnXG0jSzqO16gxmcHfwOSfn1yqoaaYy9/rMcMrzxyZq7aLlmS86ZOxXb3c
         uVLmkxAl6whishlG6vJrABQWQL8GJ7ceOLW49lyJCLW/v17GC+f0h34qNSEpLKrlY0Gy
         LBpQ==
X-Gm-Message-State: AFq9FYLWZijmpfZQFjjftCxylTTo3W9VGPzUJ8fTM0k5h4VCzJYhJzNx
	8nY9JrDBhPVeZb8gk6z+40I/Px+P1SYLZo9tNZoFBlrtgR+0rgJI9e25
X-Gm-Gg: AYBFou3vq2EYHgWjbOeqJ77pPsUYkSj1iVLNbwzrR//loH/1cc1PWJZUNX45zUVccla
	CKEpTz6t9ebf6qIyRsx80G3b3bOKOXZwXQCtjT6jyWnSjAmb7FJBjHgfR3ghSqNb9cQbEXv6Gxo
	MiMgS8ZlDOuxWl1tdi4yK2yOv05tea0ka8CXVnxV2/vNhzPnz91xf6ZCSu1OxsOOh8ZKchXqDg9
	HsIVCjaeLi417JSAfL4l9SwKRR1DNHDlGqL1dTDPoUs90wXsdVb/wij4X5VbWGAckOX8xFUcXoI
	QYUPAAxbys6XoYj9KCCzITcYAYpP5odcS3hwa5PRufoe/g54CcifNp9zHmLh9HrPYU3/fo9zylG
	jmFFyMs2agJz44SUaHIaH/gkfMd/slvUo/w2lvqC3AVN3PTzt/YzRghivaFAbp2oP/Qvx/qn6qJ
	3FdUevdSgHHHR3B6bRwxa7a96rReiShfeUmK+v1Ud14GXjUiGgBs/kzvYMo66ZjpklXADsXvj0Z
	AIhS0irafrWlpAF7TN9Y9QzA+Bsw2YOORvu5lBatMVRbUsXhfjzpsGcaBOHkkHRW3KrSq5ArTRs
	v44frKvoKlHXoQ==
X-Received: by 2002:a17:90b:4a03:b0:3ac:6e91:3f14 with SMTP id 98e67ed59e1d1-3acef134d44mr8271080a91.22.1792438835344;
        Mon, 19 Oct 2026 12:40:35 -0700 (PDT)
Received: from localhost ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc9942956sm7478188a91.1.2026.10.19.12.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 12:40:34 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 19:40:33 +0000
Message-Id: <DM92JCFA4X4U.30MTDH0KCPTJ@gmail.com>
To: "Michal Luczaj" <mhal@rbox.co>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Lorenz Bauer" <lmb@cloudflare.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>, "Jakub
 Sitnicki" <jakub@cloudflare.com>
Subject: Re: [PATCH bpf-next 2/3] bpf, sockmap: Restrict iter-context
 sockmap updates to iter/sockmap
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <a9ba4549-4bae-4516-85ef-ee38f13551cd@rbox.co>
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co> <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co> <DM6O08VBRY20.1PFUYACCZ38JL@gmail.com> <a9ba4549-4bae-4516-85ef-ee38f13551cd@rbox.co>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Oct 19, 2026 at 08:20 AM Michal Luczaj <mhal@rbox.co> wrote:
> On 10/17/26 01:52, Alexei Starovoitov wrote:
>> unix_state_lock() in bpf_iter_unix_seq_show() was added only for
>> unix_stream_bpf_update_proto() called from the iter prog.
>> iter/unix cannot get there anymore.
>> can we drop it ? can be a follow up...
>
> So we don't care about having a stable socket state while iterating? Which
> is the case for iter/sockmap, but is unlike iter/{tcp,udp}.

Not sure. Is there a value?

> I'm not sure I see the (stream sock) issue above. psock->sk_pair holds the
> peer, so peer pointer remains valid during proto update. iter/sockmap is
> safe, because sk is held by RCU. And for iter/unix we currently take
> unix_state_lock().

got it. you're right.

>> Should we restrict it to ctx->sk somehow?
>
> I recall a discussion about having BPF helpers accept only trusted
> pointers:
> https://lore.kernel.org/bpf/CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com/
> Restricting only iter/unix seems better?

we just discussed at bpf sync meeting that it's time to
finally remove plain PTR_TO_BTF_ID.
Otherwise we keep hitting this bug everywhere.

in the meantime can we do it for this one arg ?
Mark ctx->sk as PTR_TRUSTED in sock_map_iter_reg
like iter/tcp and iter/udp do ?
