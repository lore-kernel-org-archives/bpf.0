Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E0A32D7FF
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774186842; cv=none; b=CdUXJoW/4LM3Lhhorus5/O9FEN8Yfi4LNyroEPmfBEY2U7SRuduVrFtoOK5hRQY8W9xHP8FqpuWiDgAU1hU4lCWbm9tb1wCARp2Ow0M/sHvBRCxClpWeWe0roZA//P88/i+wKoTm4mCuWM6xA4fK82PIteURk35peMTDTS5y9s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774186842; c=relaxed/simple;
	bh=dEJvhEgAf7/vbRDH3Mrp+luEPp5DEfvju0U799MNZ8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqC4G/fdM831sE89ffhH6/bJrqJFa+UERZzVMRIDV5t63XH+9/I4yaw6XjAbjwKPxBDu2zW+/D8JjbG5SJWaT5zUDFGnKP0pwjJ2A3omryvTV2J5bDIidAPkhUZ8YoiUrHdIwy1SrprwJ0dGB46fJHwvGwE0uXL3g6V09Oqp/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gf/9CkHf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gf/9CkHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774186840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEJvhEgAf7/vbRDH3Mrp+luEPp5DEfvju0U799MNZ8E=;
	b=Gf/9CkHff1xdkcXY0yYnXJHjlbN0RJQY/fBzyOMMDqJv/VUB1yycpHFZhFYu+7ttC8Hdhg
	HXEGyncWguUqXnyCy83gaJ+h/zMUTpUkASgPbO3nzdEQB8mx8SMfZ3pHraysaxC7b+jHkW
	fVpkQpfpen8ZCU2CdPFSdsSDqS8/NA8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-GaDPW5X4MdyghfGEUgEYRw-1; Sun,
 22 Mar 2026 09:40:36 -0400
X-MC-Unique: GaDPW5X4MdyghfGEUgEYRw-1
X-Mimecast-MFC-AGG-ID: GaDPW5X4MdyghfGEUgEYRw_1774186835
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA9B7180047F;
	Sun, 22 Mar 2026 13:40:34 +0000 (UTC)
Received: from fedora (unknown [10.44.32.25])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1228B1800351;
	Sun, 22 Mar 2026 13:40:31 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 22 Mar 2026 14:40:34 +0100 (CET)
Date: Sun, 22 Mar 2026 14:40:30 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Max Ver <dudududumaxver@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>, Kees Cook <kees@kernel.org>,
	Dmitry Levin <ldv@strace.io>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	Will Drewry <wad@chromium.org>
Subject: Re: Process killed by seccomp looks live by tracer
Message-ID: <ab_xTq5MHu1yq3Sd@redhat.com>
References: <CABjJbFJO+p3jA1r0gjUZrCepQb1Fab3kqxYhc_PSfoqo21ypeQ@mail.gmail.com>
 <DEEAE764-41EA-4760-9606-341317E9FDC2@kernel.org>
 <CABjJbFJSYjQ+spicPrTnxkpcLWqSZ3aF-+b5DMKMXqcVU3mKwQ@mail.gmail.com>
 <aamX8uw8UN23rkc_@redhat.com>
 <aanBUeT2kQKpDWxZ@redhat.com>
 <CABjJbF+vEwEr4fQo7zZwFtgPSJGM1veFnaaLrupOzaVDoi3hJg@mail.gmail.com>
 <aa103dEXEqU4QlgZ@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa103dEXEqU4QlgZ@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/08, Oleg Nesterov wrote:

> Perhaps you are right, but this is a question for seccomp experts...
>
> Kees, Andy, what do you think?

no comments ;)

Kees, Andy, I think that Max has a point. I'll send the RFC patch in
a minute.

Please review.

Oleg.

