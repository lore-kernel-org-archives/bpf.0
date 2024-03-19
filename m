Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11939446C8
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 05:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827402; cv=none; b=hTS+UKHL+MYI2DnVn2N7BZ0IcDbzIrC1U4IU8DGocK0+oAqaio3eoggbECr7E2XUw3fsd728iPj7uSbkodm5rGt3VB0RIMUNSRNnxtKvH+B0TqOFCZxRTWQSbYU+jdMekmmvCcU87X7LiHCcQW5lKPe9xi8SdwD7mtI9XyZTcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827402; c=relaxed/simple;
	bh=d1vQtOKcuqHvKy4//qYVKUxTKEg/z7zK/5/AUEV34Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHfsW4lSktFKiv/9idEUgT1wXTC4JFEFKONysl2x0HCYbsbmNs21hmFcNAUWLsZLfr1NteSh+Oeb7FczZINJSMcA5pDZAwawUP4T8OiXLCOlmqrqV1qEcdMlAofmB2k1H3BuSL1s5tc4Aiqz19jw2nuIrDyU0Omxx0ZwK5dX2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5qdngO+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5qdngO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710827399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=905zz3+qAgtGYA95TFFZeQGypKJrD7b7ryqBKkxZsf0=;
	b=b5qdngO+j+M0XRU5K/PYjUrxnq/+2DeP6GILKDfsdwFiXkcGWxIQkoN3WAvp704LxpYlwa
	Pl/euhTWYF2K0MqbQL0PGLNJxiJuTWTttoQ1WNVjLyOJLikwE11BZd5K/IcQ3t5pasb/Ah
	EDnY689LYvzUkDn3oEOTD/H7b8SgCt0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-kmmv7S9POOydRLMIxWd24g-1; Tue,
 19 Mar 2024 01:49:57 -0400
X-MC-Unique: kmmv7S9POOydRLMIxWd24g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A5FC1C06500;
	Tue, 19 Mar 2024 05:49:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with SMTP id 552393C20;
	Tue, 19 Mar 2024 05:49:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 19 Mar 2024 06:48:35 +0100 (CET)
Date: Tue, 19 Mar 2024 06:48:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	jolsa@kernel.org
Subject: Re: [PATCH v2 0/3] uprobes: two common case speed ups
Message-ID: <20240319054811.GA20287@redhat.com>
References: <20240318181728.2795838-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318181728.2795838-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 03/18, Andrii Nakryiko wrote:
>
> Andrii Nakryiko (3):
>   uprobes: encapsulate preparation of uprobe args buffer
>   uprobes: prepare uprobe args buffer lazily
>   uprobes: add speculative lockless system-wide uprobe filter check
>
>  kernel/trace/trace_uprobe.c | 103 +++++++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 44 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

