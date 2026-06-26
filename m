Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E030BB9B
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467012; cv=none; b=HPbpLtiQ9/Y2A4kw+kELdzlHvO/CCusnY64ueqxGWx9v8j8Ekjn7fnReU1oyDRGLlkVSArG9WjygeKFbHJGG/lw4IfO0xqQKuu6y/jKUIUssdeefFw994SVxjq3rj1W/HLfedwxO80qsK8sPIoQhW+2fzfQKrP1vUSKoZj8rytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467012; c=relaxed/simple;
	bh=e3Jz6bzrGgsvPdNYBZd1bmHaSP2o6lWN6RuOfpLQ3w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkrUHW3pfkJFHbIlcma8Q4CRRoZtIClzNq8wXCwyQFPWjZk6Xs1ANQxf++/Ohu+5dbTdJZfHZaEQ+fiwZWNwa4aCbiJOe8Baw6KGB2C4jm5qFFpnz6RYDDlsqnj8bu4r1gvVmgEMBWHIDJJnmzhFFQRHrppMX0xLbMgeXzf1QKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2+i2mvH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2+i2mvH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782467010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jUw4pQtoHlo8dsSFitcZ7VE4SXE623RtWl2ctOayd9s=;
	b=J2+i2mvH1i5HLcKxF3QZD9c9TLa1FylvnDH4rSECxo2VV8jG1Ct4HtkafcDo+d6Rzo+78D
	LdT50OTzA0ve5GZdd2otriTTT8pqzow8rWNR+Fad+CfaPNHhD7AKzao2UY36/3nHqOfeTP
	pX2y5HJCSyx48BmxNEM1ataSHZKg8nQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-rUhmtskUM5u2M0S8Qr4ivQ-1; Fri,
 26 Jun 2026 05:43:26 -0400
X-MC-Unique: rUhmtskUM5u2M0S8Qr4ivQ-1
X-Mimecast-MFC-AGG-ID: rUhmtskUM5u2M0S8Qr4ivQ_1782467005
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81FB11802668;
	Fri, 26 Jun 2026 09:43:24 +0000 (UTC)
Received: from fedora (unknown [10.44.33.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F231118005A4;
	Fri, 26 Jun 2026 09:43:20 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 26 Jun 2026 11:43:25 +0200 (CEST)
Date: Fri, 26 Jun 2026 11:43:20 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <aj5JuH6AtjDtWIVU@redhat.com>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-6-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526205840.173790-6-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 05/26, Jiri Olsa wrote:
>
> which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> attribute in is_prefix_bad function.

...

> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -266,7 +266,6 @@ static bool is_prefix_bad(struct insn *insn)
>  		attr = inat_get_opcode_attribute(p);
>  		switch (attr) {
>  		case INAT_MAKE_PREFIX(INAT_PFX_ES):
> -		case INAT_MAKE_PREFIX(INAT_PFX_CS):

I know nothing about how x86 CPU works, so let me ask...

What if insn->x86_64 is false? Is it safe to allow the CS prefix in
this case?

Oleg.

