Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2E344DA2
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157746; cv=none; b=D2fYmVvI+BvhEaCBaBBTXdK77WGnVw3ofazTLy5skugo3FFPthSZbUaR4cAZqTrb+URq7bU2c0zvDsaic/jil5IW/M2S9Jq5lXmUYl2mJYZYDSXY/dDEk6Sdaa4fzv/f8IWiPUWLIxqs5EAbYrcU+PTNU5YEJzraHL5NT4t3uXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157746; c=relaxed/simple;
	bh=KHwVwvdW8+/51wnJjG3RP3NUzvq0DnMcvlt8hTAVStw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjniQVp3oNqBqufkBYSkLId6G8EWUGxS+nf8mtwwQ4oVAMScSBlIPwecaI4ZY138rboeU8ZtvTFw84LwBfzPFdH4+Azx0zaRCWXOAh8NqvUokK5MbZkphPGqHkMiOSHS6s3gjSmhoQ33PWYin7IM3RCNaOwe15aCBAVyCb7lKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtcL/LM9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=trukhHo7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtcL/LM9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="trukhHo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776157744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkPnqRGl1gXZbEvB1A+stpFWNQBl4kOwSYgNSHlYul0=;
	b=LtcL/LM9/y4oEdnWu9uHMDGv70kme5rp+4ymYKpa+rD6paGebID8UygZ0PipZOeRRmX9Bn
	wa6WNFK4V1uWlbZRFoasVnwzpCAUPKujz8NgeYFJ2+9NR803Ez/lO7imMXk2p/hVTLQgb+
	9C7YsWNosqCJusQeSF6SPJrpU3tH5Cw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-MLpQdARUOoah9hrvJdSI6w-1; Tue, 14 Apr 2026 05:09:00 -0400
X-MC-Unique: MLpQdARUOoah9hrvJdSI6w-1
X-Mimecast-MFC-AGG-ID: MLpQdARUOoah9hrvJdSI6w_1776157739
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso3807305f8f.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 02:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776157739; x=1776762539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkPnqRGl1gXZbEvB1A+stpFWNQBl4kOwSYgNSHlYul0=;
        b=trukhHo7ToUrLsQlJGHUpMzXkV0j86zm3SP5ZEPi7KRyfNoGLf0NxIIJAbT1a1oBL5
         L/liApKE5PbXS+TepVKrNR6ck9jJZXoEOnRqLcAncP3u3A/2B8LFCWcHxgMo5L1uKUWb
         z3tkVFfSmA+ahZQpD7I/S1dSwRH4MhutbW5TeXWJlYl/79WW/l65mDnneYvOKZT9+E46
         WqTmBZbXfxm4AJalX+yAoq3GWsdL0tUYIW2GKChEj+Y0iZxOYZzn/7zB6la4MWAvadWZ
         Ka1QBTvBHtqTonfZ2Q58ppFf3+yWRPV0s9wjtbiLIsABxMGL+r4asfF8ksAAIstKdm5l
         BuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157739; x=1776762539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkPnqRGl1gXZbEvB1A+stpFWNQBl4kOwSYgNSHlYul0=;
        b=cK16IcyuygddmkrsvXD5qsQvCuXeKhK16/hadoiYYI6oE6h0MUPvSDbebABnuEYsAP
         hviHfWPQk5nHxNJjmCBQIxcL5eeIIUv5hw1GfaZaIFvgaI951TK3N1vzy7psJ8C+c2Ph
         4iIlQe9JN6rP4iBf9qXhqKhm1A78U5jiTsXoj2n+8UDnolfUIm9uN9CTaukUm7gmwkBN
         erGHHhAg8W7NsXQnexFpYv/oeeYF8GomaeOcHGYx+yZgT1YOIimbx5XhTf5RxIZTF2Yk
         2rfKIvBN37Rqg0TJtJ4AFpEudXxizKeeEgrbH7Z7j3LyfOVXU+B5bw5alLWPAWttlWJ5
         AvWA==
X-Forwarded-Encrypted: i=1; AFNElJ/rv8Q4aFA2A0ZYt9OmhYyIQ925kl7WJkUMMq7ItZnjyMfn8Is3sCkezAAy6ppQtNl6EmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6V3p6AYbbgLExebBdRaSCuxoAnJUyhoEa0UIQUDZi4LdOaFGw
	5nQZtenc1rk9kKbJWZrky3DDUOoqXlAU6IpW77vjrsKZZdUzH50n0ajzBHOXxE6x6HAeZvin5IF
	YAQMS9pIEUE5eguxlhvGgfQC2GzHzO21Fz7P/bng6T0Nyu8gNcbM3nw==
X-Gm-Gg: AeBDievdoNbciZSVn5yawOE/NixpptYONvvIiojBrDk1Hp/+rdRvEjdYgpQzMknwXKv
	lQCQs6xKvVwDXfifEk3mamVDC0vkGJiWQXJzBeJOVFFX0cPmvwSIZ+xx8ts9c7eO2FFTrN8Wnuy
	x4KIUZnNxh+qhs5XyOk8WdESpmUk4PR8XMXmWrKPeGkjf7V60Xz7P2B0VxGGk0HCJ8/5D1MIufc
	8anw6DCWWqMe5lEHWb3wYRvPmJ6JM3/9y96Rw5PY9d3V6mIGrLM2QqsSMUdNTLQ5vo7nTfsXnEF
	WkDWd36SwhI/CSyomkTSJmgh9Z6XamVfpm2Ms3uy6AMO8I2acKrbkhIsgRH554hOpV4iyauVFFh
	I6rQZwXubrWGWKXHA/oP7iIslUmi1Y1Naoqpy1L6qMBeP9elRWHMEszao
X-Received: by 2002:a05:6000:24c3:b0:43d:77a8:3bb6 with SMTP id ffacd0b85a97d-43d77a83df5mr11097045f8f.47.1776157739317;
        Tue, 14 Apr 2026 02:08:59 -0700 (PDT)
X-Received: by 2002:a05:6000:24c3:b0:43d:77a8:3bb6 with SMTP id ffacd0b85a97d-43d77a83df5mr11096988f8f.47.1776157738818;
        Tue, 14 Apr 2026 02:08:58 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5061fsm41420908f8f.30.2026.04.14.02.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:08:58 -0700 (PDT)
Message-ID: <6b22a595-cd65-42ec-b332-c835273bc174@redhat.com>
Date: Tue, 14 Apr 2026 11:08:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests/bpf: verify syncookie
 statistics in tcp_custom_syncookie
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
 <20260411013211.225834-2-jiayuan.chen@linux.dev>
 <CAAVpQUCCZVogDUUTfr3k-JxV52kpVvdYzqFC68-J3n6_ugd4Uw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAAVpQUCCZVogDUUTfr3k-JxV52kpVvdYzqFC68-J3n6_ugd4Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/14/26 7:50 AM, Kuniyuki Iwashima wrote:
> On Fri, Apr 10, 2026 at 6:32 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>
>> Add read_tcpext_snmp() helper to network_helpers which reads a
>> TcpExt SNMP counter via nstat, and use it in the tcp_custom_syncookie
>> test to verify that LINUX_MIB_SYNCOOKIESRECV is incremented and
>> LINUX_MIB_SYNCOOKIESFAILED stays unchanged across a successful
>> BPF custom syncookie validation.
>>
>> The delta is captured between start_server() and accept(), which
>> covers the full SYN/ACK/cookie-check path for one connection.
>>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>  tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
>>  tools/testing/selftests/bpf/network_helpers.h |  1 +
>>  .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++
> 
> As you touch bpf selftest helper files, please rebase on bpf-next
> to avoid possible conflicts and tag bpf-next in the Subject.

To hopefully  minimize the conflicts handling I'm going to apply patch
1/2 to net-next. Please resubmit patch 2/2 to bpf-next after the
relevant net core reach there.

/P

