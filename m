Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8218E4596D
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710342997; cv=none; b=dLthmWkPb1NVStT1+389+KBQfa6vJpQSpta/DhD2/vOkIMTnma0qPlhD+QfQFvCsNzC5cnbpjmRzLWQLB0jVYeLCnK4tmva5aru3LfYB690P6gxhmdsfRSdRGBGrwdbAHC/J4iFKUPxxZBCbvA/vrw9ggEDSU6IBXKy83jtuayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710342997; c=relaxed/simple;
	bh=nTWNjiLUgBLi4JWtq8dT/dKeum211ni/Q5IbjhlmfqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf7vkIywYF2z7T3zV6ftxSCgJBs2zz4jSJP9jbvHOX8E5sBWoq/DUhfhzzAvg9O1uNxRcv4jxMYlFGjbEIvGnWePSiiPK1V6Hy5X9tRTM/5TzzZcMqa2vthP9rrxk0wEdQNVKKkhkfT3PkMDFqZB6Ia047txwNJdIqGj20sz5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ig4dInhw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ig4dInhw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710342994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vSsee+SCFbFI/+NyWT4z4JA4fgasuDRXPdyzWyF43gA=;
	b=Ig4dInhw3R4n8hlp/F8JNu/fHuU0XkIJo9N0B8SbiQKdqbM/USfB5F13XuzUpZSMCw1BN/
	PNV16UNuwtwo81cq/zzB6T8Z9PXemYHNFBFUUJ46ioKp5TPHSSbed94zHwe5pQyFTxM4tU
	HBC2FUfryj3fKOaopIDOkFjnEi9sDuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-uxZ5Pz_eMwe3UMj2xWkKuw-1; Wed, 13 Mar 2024 11:16:32 -0400
X-MC-Unique: uxZ5Pz_eMwe3UMj2xWkKuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50171101A523;
	Wed, 13 Mar 2024 15:16:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.233])
	by smtp.corp.redhat.com (Postfix) with SMTP id 74F5C1C060D1;
	Wed, 13 Mar 2024 15:16:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 13 Mar 2024 16:15:10 +0100 (CET)
Date: Wed, 13 Mar 2024 16:15:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] uprobes: encapsulate preparation of uprobe
 args buffer
Message-ID: <20240313151507.GA25452@redhat.com>
References: <20240312210233.1941599-1-andrii@kernel.org>
 <20240312210233.1941599-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312210233.1941599-2-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

LGTM, one nit below.

On 03/12, Andrii Nakryiko wrote:
>
> +static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
> +						       struct pt_regs *regs)
> +{
> +	struct uprobe_cpu_buffer *ucb;
> +	int dsize, esize;
> +
> +	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
> +	dsize = __get_data_size(&tu->tp, regs);
> +
> +	ucb = uprobe_buffer_get();
> +	ucb->dsize = dsize;
> +
> +	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
> +
> +	return ucb;
> +}

OK, but note that every user of ->dsize adds tp.size. So I think you can
simplify this code a bit more if you change prepare_uprobe_buffer() to do

	ucb->dsize = tu->tp.size + dsize;

and update the users.

Oleg.

