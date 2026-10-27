Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122452;
	b=vauRMQj5xXrhbGyjCTg3KPcOhMxy2qI6pstIe4K5UaKBOoD7+jgejYd6qapLHNMiMjSS
	 Ur9i4OCFnzqnSaQ7PgwDchhemtLWDuJhAxi4l2/0rpGpcvzbA+hrCbV46mUXWhedu/u7o
	 9lOr0YaBcMPgrDh7FReSNmTu0QHCp+catonN8uxm19dSfq+IIffnnjrMWlte8/CmrjE7X
	 dyj6sZfmzQb+eoO8qsoo4MjPjQkSaTJkd2fJfQju5KLvdL/U9OGjEnOkqGJDIpO4iW+KT
	 skbDCRaZh9ganYs6iIrvunL/u60oeJWtGidTepGTWvwm7nkrDma9oDhxHTDSerPyx0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xNDyp1upp/wsr8lQ+FwRlQnHTSKRi5xYjt4jiZaQ9Lg=;
	b=OUoG2WlwChHQchsHIRJnGoWDwdBbPMkCYTyseiDytntU328ntDLgQj/e6NtjrSje/uY6
	 AxbPNilZ2xATu5qiuC8n6QwuG7E4Wy7mt8k+cUY2l8V6siKHqeXQIgAV/GBUZblzGrWBY
	 fBwVHjzwrzurx6skP+ZcWrA38QEQCbSniAqgeA6BBUnni4Y/mPnuk4Pabn/suc/xidCD1
	 AKtEhLN/rlVhpAUA3XdSS5XR5R4sJ0TY8oesFU19JxMYscZEiTYCjjc/78HDM9/E6VVN+
	 dUenVO0S4OLHkIuTKqQcMHGnNp1ozeUp8C3V1ZRSVoMqX9AhX1hK3HJzt0/FpZLlM4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TgVxkn8N;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC5606A320
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81AC5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=TgVxkn8N
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so273851a12.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793122451; x=1793727251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xNDyp1upp/wsr8lQ+FwRlQnHTSKRi5xYjt4jiZaQ9Lg=;
        b=TgVxkn8NiUPxuA0PIvqXpajyKAjwQeqEfgOE7ZQLRRiP7zLZkge8/7fFG6d4ChYdCw
         Q1SsEjfACoBX96ETwG88YTHqcxHrLqD1Oq8Woiv2MgByGNs0T928KDVXS/le7XnBKtSp
         GJCdJ6HLKHi/u6+Nvxw1HiQZ0dzBc/Pza4uzp4gdfO8t/+t/eZucKnb/mW2duhdTLX0f
         ubmUzAvs1uforE7rtTrEvRWC9mSymJisdyIlZcAYiRtrbstJu1XZUQkL5a0EqAr3qji0
         iTeuq+SbZzs1N9SZzn866NDZyNnndBTbzwovIOvKMI/w5zRCQ8GQZd+Rpae2oo2Ia5/7
         zAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122451; x=1793727251;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNDyp1upp/wsr8lQ+FwRlQnHTSKRi5xYjt4jiZaQ9Lg=;
        b=S+0a/Sd/ANsz9bxyGFQ0pbfwXTPw+RFs/iKEtd8GDaJwMERwY99v03w9Xd3M4rZ9rJ
         lz19vBKiyqeqeyY+x8VYe3HzkQ0pIUthUcKFHzHudIXcyC3mNnYyi38zPNMQITksD5iQ
         YJ+URJ95s6T+Mev5wVQY96RJ6jzDdLLVPzs/jTMbihEXA55l44iXSTkAVO72Tded9ShP
         0Hki0Sljzu+IkblibxtlGU2PPspmNx9GquVZJ1JJDSKzX6mGpNzyUVgxrpfrgQsWDCUK
         ERSF5gKtIm/sz5MTKDsg+iCvdYVazCos3yn0Enqz3V3V2i78qEU5fue+dtlgaQvukWj9
         5+1w==
X-Forwarded-Encrypted: i=1; AKwUvBxRELJJVyxZ16t4QCIueerVCnAp97oyd70jeljjCF8TrCOneaHhldBEa6t7ewomEdonV0Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPU6EmWgS+QUJZG6t+FHfvLydAZqgquzzbfYj4Fs+q56F22LS/
	ED/ChMx6QRqAdQcJqb1SOEN7gCa713+4VI+7CIHKjBVMO7vXzc05qeHqtGpeF6Vvj2k=
X-Gm-Gg: AYBFou3ETbDz/U1zGoc+OBSJp9Ru6ojrVb783sHrEzT52qeilKX3ioRdtMp1dhkFz5A
	hUhEfqlX74dViVBhPHtN6ATFDfVLhkmdGKQo6+elA1sx0pOvQOxe7N8z0bNBnqLvrZv0tji1fj5
	Iq4q11mwMb6qtrDK3qTn/W/ctnqwb+y8AAcFYCp/ED7Cmn5FlvWAebhe7PIMeJpqILqdJB2VwnO
	JNWWuHURjXei/JJtUHK2CD8V+70f7T8UmhMPs0rG/wsMkNlgrEOiHtQhwdE16HVOUP8PjOqu4Lh
	wuvc7ZU+0Q+6l9VK2AIuHXyFSEqknzKD+IUPdfKJeJJN8SawiF9ArSGod9XwiX5/tjmbdtwyGRO
	Hrob6bC3iOKpFFTzjz7nkDQTYBAvFc0/hiae/HIjLbB7KiVTqDLMxT4ThcF/qtMsXcf/L5yMgt6
	x7+LdvmAgD7Et+4vaLF4E/t9j8h3GJkUXhqnlL8R9nj7P8UEzT/t7dIAfqeGKVh+VRtoaSV9Hom
	SktUknhQTJplMFQnWJOrxx+ezJwI4NqzU2xC5WjvWxOug==
X-Received: by 2002:aa7:c4f8:0:b0:6b1:c6fa:c45c with SMTP id 4fb4d7f45d1cf-6b442ff7c46mr7973700a12.38.1793122450667;
        Tue, 27 Oct 2026 10:34:10 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:2dc::49:1e9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964601f2sm323930a12.37.2026.10.27.10.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 10:34:09 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "phx" <phx0fer@gmail.com>,  "John Fastabend" <john.fastabend@gmail.com>,
  "Jiayuan Chen" <jiayuan.chen@linux.dev>,  "Network Development"
 <netdev@vger.kernel.org>,  "bpf" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
In-Reply-To: <DMFRU74YCDSH.1WJJT7VL3MEYE@gmail.com> (Alexei Starovoitov's
	message of "Tue, 27 Oct 2026 16:46:11 +0000")
References: <20261021155629.68813-1-phx0fer@gmail.com>
	<20261022054811.35008-1-phx0fer@gmail.com>
	<DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
	<CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
	<87v76o63qv.fsf@cloudflare.com>
	<CAKvCo-zf6=ABrMEn_8r7rJFFvaaXQrz8GAUQ9Uz4h0Ze9gY68w@mail.gmail.com>
	<87pkwv5cj8.fsf@cloudflare.com> <DMFRU74YCDSH.1WJJT7VL3MEYE@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 27 Oct 2026 18:34:08 +0100
Message-ID: <87jyn359pr.fsf@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 04:46 PM GMT, Alexei Starovoitov wrote:
> On Tue Oct 27, 2026 at 4:33 PM UTC, Jakub Sitnicki wrote:
>> On Tue, Oct 27, 2026 at 01:10 PM +08, phx wrote:
>>> Sorry for the long silence =E2=80=94 my laptop died right after v2 and =
took the
>>> local mail and the working tree with it. Agreed that the ordering fix is
>>> the right one; please go ahead with the commandeer, Jakub.
>>>
>>> I do still have the reproducer (a KCSAN selftest for this race, verified
>>> in QEMU). Say the word and I will post it, or send it to you to fold in=
to
>>> your respin.
>>
>> Feel free to iterate on the patch once you get your dev env restored.
>
> I very much prefer if you Jakub will take it over.
> 'phx' is a clueless bot that sends spam across all subsystem.

Got me fooled. Thanks. I will respin it myself.
