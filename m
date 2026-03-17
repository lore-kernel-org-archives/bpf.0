Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A13A9018
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743689; cv=none; b=GeCrvmDsexg+bJBo6s5U+1YnzPDQKNFiJUM5CZ+JuCqOQPUkH8Q41DIszqjN2Pm8oH2RFbILCHKToNdiIGWbD6ZihedFvJiDiylv/FCfF+4enNfjQJXI6ex1sw/cBHDcZXEZaP7Yb6BHdJeVnnCOni9ZCO/HLNoyNdRTr78FzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743689; c=relaxed/simple;
	bh=cOJ0pqLB05cW7l8D0d5y/xnlGOGTKB72z83QuCFoWlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gH2TPAeATayO8CUeJdbDnS4FTmqlAAaxbPyL1aKO7zd5huHG4j892jS2EUjx4+4W7JG0eNR3T5sVYtKTx8qRtj/EOmHm571NJNUJcwg1GYLtRtNWzA0x8HYT1zyZiUZO3L72j37HYWx2jVxtSX2MqPoMB6Tc1FCGCX6iCAUswdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMzgLbpY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jhU5lRmo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMzgLbpY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jhU5lRmo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773743687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ny0IuTqhujPnnvktMKwVQKRIYww+FI37mlIAqoGoFS8=;
	b=SMzgLbpYgqFjaZNVfrbSfUFEV/JDsNzeaAJjV3db+fqIQqrBwnCCi4xG8GXXP8LigYXma4
	SdhkuNUxDGi6WOYxlFy6T/UthhtEq854htQ10p7haIUh+D1wiIFwIwsXE+QBV1G+kumyOJ
	8m3CJG79Y3h4Yl6jKwKFmi0J3VXwkAM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-_4x1zb_IN76WvOdVdSjg4A-1; Tue, 17 Mar 2026 06:34:44 -0400
X-MC-Unique: _4x1zb_IN76WvOdVdSjg4A-1
X-Mimecast-MFC-AGG-ID: _4x1zb_IN76WvOdVdSjg4A_1773743683
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b42eee946so392775f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 03:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773743683; x=1774348483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ny0IuTqhujPnnvktMKwVQKRIYww+FI37mlIAqoGoFS8=;
        b=jhU5lRmoFBsvE9mcPAHRQtqhz+tZgTxj6HqNeh47C2/ltxxWR2vWB7ck4X4SlGru0D
         c5rYqONkzbGUPKlbFAYIVRt1sOuBV6yyQeCJErqIf0vpp172ZYpMgvHxzcmLQ25KVPo6
         tNIzSurYa9nHVyWF5RlptqzbmavlzWGl425840CVOqbf6oxzQKeXjGTvMtZT4KF55HMF
         2MwVVDRxtbat5H8XKwkko91NHVhQBsfPv/dzLeqTtCV6BZzQiXeROJWYbho6DAPU+Vco
         QkEO+UBETXqW/2mEe4ooZ1wt8wgqU0SLbrWM1ynZsDklfWf3UjSLx+yiK0+Zkpl3p60y
         eNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773743683; x=1774348483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny0IuTqhujPnnvktMKwVQKRIYww+FI37mlIAqoGoFS8=;
        b=JipiOE9iFai0gvR04pxqSc6crcqHHVs3EGmUsQt81n+xj19iVLkQYqBP8/zXnOpdIC
         DP/zNpFK9u10UqgJRH9+fyxGMmoK6PcqaPlqn4o24Ey05j3pWlVnywKqWw7TBt3aHYuf
         evLhIFt6rpVnMa+qwcoVNL4Cbhp72tBWhl9TUDtTZkRfRpiOO+vpMouMdxWxBSDV+t1J
         loMhAE6tzFbxJRASsII+Elybn1nqqTJKB8xBaVFlgziPK5is45D4Omv8L5vzT62uuI46
         1Pe9hI2lNhqTPOue+/DtaYiX0WXO0AJsnFUfUzAoiD8xO4UmFDZHZw9Wx8zbVckdIdUS
         YqSw==
X-Forwarded-Encrypted: i=1; AJvYcCXrHxBClEnqp1Uv/RbR5QTVmQk8+7CnGDgYXEs5ZIIje5e83FuUGl4Yg6QrWSoSU4+fvTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykAMo0voCERUDQuVwmtwyNEO8x83ZRYihbI45T1lG8DiWsoEDI
	9pjFyTDnwFpuP4f3gd3kIILMQqTl7tAP6r9LHnwEyiIHMS7Pv6bOTjMmt67n6YTeQZyih02RWB1
	g2XraoEbNFfBPclViquMuFcL6wfJvXqHENvmaqQwEnQOldiZ/MNH3tg==
X-Gm-Gg: ATEYQzyxE9aSDNjhD946afSK8ag6/0jFXqtPSEgNIeDFLmyrMQ0HMsarxB97gNFYPiR
	SWCTIg+ioBA6HGmXmM6FYyXbjjVx+ql1lLNqOn0eXC6tooSRtPYo7BYpDM1KGpYHX1e5OOvPPaQ
	+wPTmuG7tRtMWggfadVQ1tt30VRYQPypCd1+ZkLlh4pQMCKDITx/VtEQLKeTppYUFD5WdQ6ewi/
	ZmQ/pTeanpwQ9pwGMmLBUsA5wcmIgc0gttHUbwvoN95AUK/tKjzri13U7JVeA2ZG05KRcb1gtKz
	AJa0uyKd3SraPwN8sNdM3CVt7RbqrDm9hLU8cwDb5rKMpde5gOzQ4gAy3jM9a5u8dgBcPf6v6dq
	+dHtrOdMjNBS/k/8rM0qOPCkAxx5+OCDWWksHQ0YtLxv12AqWNldTc70=
X-Received: by 2002:a5d:5d06:0:b0:439:9812:35ea with SMTP id ffacd0b85a97d-43b498127a9mr5655188f8f.3.1773743682857;
        Tue, 17 Mar 2026 03:34:42 -0700 (PDT)
X-Received: by 2002:a5d:5d06:0:b0:439:9812:35ea with SMTP id ffacd0b85a97d-43b498127a9mr5655135f8f.3.1773743682342;
        Tue, 17 Mar 2026 03:34:42 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3e9a4fcdsm22271699f8f.8.2026.03.17.03.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 03:34:41 -0700 (PDT)
Message-ID: <19078c41-5ee8-402a-9b60-fc4ab0fb8ece@redhat.com>
Date: Tue, 17 Mar 2026 11:34:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] net: Use trace_invoke_##name() at guarded
 tracepoint call sites
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 dev@openvswitch.org, linux-sctp@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-5-vineeth@bitbyteword.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260312150523.2054552-5-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/26 4:04 PM, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_invoke_foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_invoke_foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

Side question: which is the merge plan here? since this patch depends on
1/15 I guess it's via the trace tree, am I correct?

/P

