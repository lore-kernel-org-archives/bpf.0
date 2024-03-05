Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A057E774
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623017; cv=none; b=aRj/GxpDtt53tbOhqwEE8eutaHwv6d9TCC/O/5PcIy05UF8kreg2s85vy4VQmDIAm9gxJaSrzcHdUrTsKOuWNQ9gIIGsdOq1Z3VDgeQJHIoO3jwU2QDsc9Ek/kHqnWqvdk4OMWSLCT9GB5ffvEBHhvOVRX3lFkeqO7P/G7uU88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623017; c=relaxed/simple;
	bh=+U3wbTm1fr0u7B7uauZt02Yd7hkkHWSl3gey4+61HxA=;
	h=From:In-Reply-To:References:To:cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QArmIykB8GG2EnjJmMI62rAothZWeRk2tlVe1xujJV2ANrfCXp0qfD1N85L5gEhRQGthPRFscPQc9RQSJx4GDDc5awBX2UvX7f/7S0w9pSTkKl+RwwQNC0430UNklI2MjcOxP0RI3fIa3v5L1LaIl6tAUfFFyZuo/W1N43vZpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEx/W9eR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEx/W9eR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709623014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+U3wbTm1fr0u7B7uauZt02Yd7hkkHWSl3gey4+61HxA=;
	b=BEx/W9eREypy9/ytEof5guSmqC4iuHFweFGeZd9TF3FugxlHBvdbfSbXliz7SN3ORS0kh1
	E4URlPe0pGd73/HeJZlwT61S8pwt1dLXHksCIstlGJJyFaUEdu+asLMyz03p7X65Vn8gtx
	7GkojeagQAoUJhEQhzcD+XhCqPoktcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-k7KSPzfEPbS1pINrH7INNw-1; Tue, 05 Mar 2024 02:16:49 -0500
X-MC-Unique: k7KSPzfEPbS1pINrH7INNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E26E185A784;
	Tue,  5 Mar 2024 07:16:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ED1FB1C060A4;
	Tue,  5 Mar 2024 07:16:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240305020153.2787423-8-almasrymina@google.com>
References: <20240305020153.2787423-8-almasrymina@google.com> <20240305020153.2787423-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
    linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
    sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
    linux-arch@vger.kernel.org, bpf@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
    dri-devel@lists.freedesktop.org,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
    Richard Henderson <richard.henderson@linaro.org>,
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
    Matt Turner <mattst88@gmail.com>,
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
    Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
    Jesper Dangaard Brouer <hawk@kernel.org>,
    Ilias Apalodimas <ilias.apalodimas@linaro.org>,
    Steven Rostedt <rostedt@goodmis.org>,
    Masami Hiramatsu <mhiramat@kernel.org>,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Andrii Nakryiko <andrii@kernel.org>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
    Yonghong Song <yonghong.song@linux.dev>,
    John Fastabend <john.fastabend@gmail.com>,
    KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
    Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
    David Ahern <dsahern@kernel.org>,
    Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
    Shuah Khan <shuah@kernel.org>,
    Sumit Semwal <sumit.semwal@linaro.org>,
    =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
    Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
    Jason Gunthorpe <jgg@ziepe.ca>,
    Yunsheng Lin <linyunsheng@huawei.com>,
    Shailend Chand <shailend@google.com>,
    Harshitha Ramamurthy <hramamurthy@google.com>,
    Shakeel Butt <shakeelb@google.com>,
    Jeroen de Borst <jeroendb@google.com>,
    Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v6 07/15] page_pool: convert to use netmem
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Date: Tue, 05 Mar 2024 07:16:37 +0000
Message-ID: <950858.1709622997@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7


Hi Mina,

I recommend you cc linux-mm and Matthew Wilcox on these two patches also.

David

