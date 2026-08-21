Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC64D47606E
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322943; cv=none; b=Jjg3NRd8BjUBAJxpuEl/PxhJtFtxaLM1jostc2cgDjIr+L16S5E0ia0qKVT7Z5CH4Vrg4njo/xs/oQOwd3GzCE8CC6FzCQirOxdCi2vreLJOVxtIJj3JrISrHbyL6HR+b70Dg0ArhV2HQMaz4TWUP/VKrpVE1IXl0DzfxKrJkdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322943; c=relaxed/simple;
	bh=PDdqbyTYDnI6F2JI6t2go8vBhCAE1oCm9u6gpLxjUKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0y8RcMUgF1XMVQh8wD8y1QFStKUnPr9xGJ1lT2VY7uUJ4xRNvDAU/5vsP66NjxdEpVa/syIjQeZgg4KrMJ1iCCwYulRUDujkd3YcGItPkE27WcVUEStMoRf5WdNJv9Ca5zeoLEIWRWvpiaKqsWOcpppHFKcwQ3mdCLEu3M2W10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7XSbwGf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7XSbwGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787322941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11dPx6bGB018UBDYzKEYfI8AnpdGEAinmo2rW1PteIc=;
	b=N7XSbwGfAVd93GWW12YpuGUw+Kl3ilO+Xymz3YX79fqpAEIkJEeSAlIgTSydaEcnUiGAJ3
	0j/0EthTYf8zXbKGQk6eABp3ACxcyo/zZHJPOoqIXuhixzofP09oRdS68BaobplGlQ6jHE
	5QPbXA9SAWVJjztQqlbynADV2qMFQ+Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-62cyuJzCPGGsO1KE7j6-FA-1; Fri,
 21 Aug 2026 10:35:32 -0400
X-MC-Unique: 62cyuJzCPGGsO1KE7j6-FA-1
X-Mimecast-MFC-AGG-ID: 62cyuJzCPGGsO1KE7j6-FA_1787322929
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D7921954B20;
	Fri, 21 Aug 2026 14:35:28 +0000 (UTC)
Received: from fedora (unknown [10.44.49.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 08EAD3002D30;
	Fri, 21 Aug 2026 14:35:23 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 21 Aug 2026 16:35:27 +0200 (CEST)
Date: Fri, 21 Aug 2026 16:35:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org, linux-cifs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] signal: allow taks to temporarily block
 TIF_NOTIFY_SIGNAL
Message-ID: <aohiKmI6IBpX7mvS@redhat.com>
References: <20260818-work-tif_notify_signal-v1-0-1ee1fcc5b3ff@kernel.org>
 <20260818-work-tif_notify_signal-v1-1-1ee1fcc5b3ff@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-work-tif_notify_signal-v1-1-1ee1fcc5b3ff@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christian, sorry for late reply.

This series looks very good to me. Just one nit...

On 08/18, Christian Brauner wrote:
>
> +/* Prevent TIF_NOTIFY_SIGNAL from interrupting this task. */
> +static inline unsigned int no_notify_signal_save(void)
> +{
> +	unsigned int flags = current->flags & PF_NO_NOTIFY_SIGNAL;

I think that

	unsigned int flags = current->flags;

should equally work?

Oleg.

