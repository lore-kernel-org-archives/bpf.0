Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232D82899
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158267; cv=none; b=Kxu6vqhXvA9rOL7bI++l6Mduu8M6FnQZNywK78Y90YEiZY9PqDGPAU3kIdBy9cOVotIU3KTYFXBFzw8/wPIKaYJrKxptr05udFy/CuaUqG0/ifOwMS6H5FxWNmwrVOgqtjgu07vGrkbzyaM25D2E5+lRIYBYSo4Cc/zqSYIUbZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158267; c=relaxed/simple;
	bh=y9RBwNlL7JFhRplM8GzxiuHZYoF1Od4tFFoLb5d65OE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P7KN4ISH5vXettraE3Abp43aYhAYvT/rhoZ4pWtRKxmygG+hDGMvA//izWWDJUytqRfR85Gj3koG5y/+HZVTO74iJUpafivwVd1H/hEWExKYJqGyuBTp4M5TgyQTjt6euKAG6acm9l+fn/WrrkyKJxD5HG14l9tsUKS5dgV54yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXb9T8Pj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwvkhqBo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXb9T8Pj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwvkhqBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776158265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8o+jTcPee9ytS2fBNgNkDGXbrpoLlX9QLHbrMcVIiqY=;
	b=PXb9T8PjQrlpvT93q8c0B6rv2otrPLefXYMTDpmW8vMLFnZ1gHmm/9QoJ8058bqFMdUe//
	XURhNqAJBzmA9DnQYNrBq1lNmtAihkzqNUxqT6CE37izcvpxihJ2amF1sy94E/Jwj9GPuV
	oja0Or83mVb4H7ncyQxD5rD27INGU68=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-xTjCX2ZaNauH30_iZg_qjQ-1; Tue, 14 Apr 2026 05:17:43 -0400
X-MC-Unique: xTjCX2ZaNauH30_iZg_qjQ-1
X-Mimecast-MFC-AGG-ID: xTjCX2ZaNauH30_iZg_qjQ_1776158263
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d77286244so1433680f8f.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776158262; x=1776763062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8o+jTcPee9ytS2fBNgNkDGXbrpoLlX9QLHbrMcVIiqY=;
        b=QwvkhqBocpRUN3Z3uFUBBkMcOb0r89fhAUb646TnrDrZth+UeQmuw5UMofKTJlH91X
         cNv5ESVBbs6v7JphaOvQXXD81RJnk9qXDCMD4hfWtyJ6NZD3Z43irt1C4Q9wD5bTHg9+
         9uYhRYdfWDwmCoVcW9BJLez4m7dizBojugOUFpt26amZ0PlB6tsQbIwlQMNyqGuR+ouC
         TJLq+E6+P1fbjvmpKxrwY9fMc6NIvO8mTQ0sdeRWggwhidXJV8yUxY1ydPBVatowsM8h
         /R7hFe6lwAtGo048Sl3gz6YxS4ExCD0+UtxugVv9P/uPNPAoOxaYvUDTrNQ2I4pkt/d6
         BaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158262; x=1776763062;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8o+jTcPee9ytS2fBNgNkDGXbrpoLlX9QLHbrMcVIiqY=;
        b=jfn9mkIuHiyxoPlQHHqrUijSm4N5PQ+O/PyuXiOnJigiNtn9JCCJhyKDf4qxHqA8iN
         G47TqVEAUFlXvlzRXu5WC7lQXxU7AJAWJhUUnjaqcNVtWYWEyj1pzvLnzqaE/nBI7s0O
         2M3ty+PySSCfKy450Cio9ElWtmXYGGogGVCiDWT6OC+w9Jb6SlrRNDIZEmAP0yDV3goJ
         y3BfQtgm92sj6dvIonfz2FbXsobO/SEGJeQONT/UlIl++yT2gSllSN1ejakfUtesAqOg
         o3SVRsKeovQ+G5M3BddyOaJkUo+X3jfdMO7+rMg+azDW6rYPuQDZm6hTHJj5NEetaB+T
         d/mA==
X-Forwarded-Encrypted: i=1; AFNElJ9UrNFm0Te6lDVdGuxRE1QvRlQcE7SYaCRj0bUfGtgs2ieG/HhEvnJS9owA+b5/itRHHkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZO5BseDbeRzJvkAWxr/5sS8I/oqyDm7cEyz5YQmuaEUmYS/Y
	vsg88DT1CNsR/QFiww8sRTUD1olHPnIcY/p7UhriD8syechO9SgULN4Zw7rPwoalAc4OU9poHkw
	iZaM3Bp1rforSosQXy35bFw2GCkn/dVl0TIm0rR4pUVEd9pshA6S9Ug==
X-Gm-Gg: AeBDiesej+H2/bzi+05bj0XRK5YllCe0Tn9sEghgKpczS5na9oXAcwIJF2kHfBJtC17
	emeFw66oTVEpA0BZKlcRQsv4l0Hnd/fZmpzytKBnfvYEFhe06E0AF1486VZVj+u8tjQazaZc0Fr
	BeCh2+3/VADmFtvCjbt1Np90AVoBxjEjAOhwKuDJO5Z9A33cbSS5d3vTgVp2FOAhSC8U7Kdn1C/
	vEvShgW3Ja3ziC5NbsCGAUJyhnLvyNPdirLNJXwW8wHVpCwE6V97Z8MnGZPIGUefnHKue1PKcIm
	GQ2vGKYNY/6Syv88pKgGrCgRhz4HzP2dIB0b9vKWb9+KEtFJSqlv8umesRcavoOmPFvgcaSCizK
	v/MtS9dDpgmdaqUZwIvAoWZRmT2tOJ5ap0ue4iWaITek6DydgQN8apFDk
X-Received: by 2002:a05:600c:a404:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-488d67b8d97mr197779185e9.2.1776158262593;
        Tue, 14 Apr 2026 02:17:42 -0700 (PDT)
X-Received: by 2002:a05:600c:a404:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-488d67b8d97mr197778675e9.2.1776158262108;
        Tue, 14 Apr 2026 02:17:42 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede2ba5asm32868935e9.12.2026.04.14.02.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:17:41 -0700 (PDT)
Message-ID: <04cafd50-7af5-4835-b0df-67393d9f5a51@redhat.com>
Date: Tue, 14 Apr 2026 11:17:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests/bpf: verify syncookie
 statistics in tcp_custom_syncookie
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet <edumazet@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
 <20260411013211.225834-2-jiayuan.chen@linux.dev>
 <CAAVpQUCCZVogDUUTfr3k-JxV52kpVvdYzqFC68-J3n6_ugd4Uw@mail.gmail.com>
 <6b22a595-cd65-42ec-b332-c835273bc174@redhat.com>
Content-Language: en-US
In-Reply-To: <6b22a595-cd65-42ec-b332-c835273bc174@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/14/26 11:08 AM, Paolo Abeni wrote:
> On 4/14/26 7:50 AM, Kuniyuki Iwashima wrote:
>> On Fri, Apr 10, 2026 at 6:32 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>>
>>> Add read_tcpext_snmp() helper to network_helpers which reads a
>>> TcpExt SNMP counter via nstat, and use it in the tcp_custom_syncookie
>>> test to verify that LINUX_MIB_SYNCOOKIESRECV is incremented and
>>> LINUX_MIB_SYNCOOKIESFAILED stays unchanged across a successful
>>> BPF custom syncookie validation.
>>>
>>> The delta is captured between start_server() and accept(), which
>>> covers the full SYN/ACK/cookie-check path for one connection.
>>>
>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>> ---
>>>  tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
>>>  tools/testing/selftests/bpf/network_helpers.h |  1 +
>>>  .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
>>
>> As you touch bpf selftest helper files, please rebase on bpf-next
>> to avoid possible conflicts and tag bpf-next in the Subject.
> 
> To hopefully  minimize the conflicts handling I'm going to apply patch
> 1/2 to net-next. Please resubmit patch 2/2 to bpf-next after the
> relevant net core reach there.

Uhmm... the original feature went through the bpf tree, so I guess both
patches could/should via bpf-next. Hopefully conflict into the tcp code
should be minimal.

@Eric, @Daniel: please LMK if you prefer otherwise.
/P

