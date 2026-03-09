Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305B3ECBC4
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076544; cv=none; b=YCyVTy/8S8oWR5rIjw0jzWe2eaICIARSVhR+s5Gd0u+T0VQJtwJTR8cBYEWeaz1XrESPtjbtdhEXL/AZ69WX7Jt9Gum3pU5cDAlwdCMEo/vPQfwUti8sU8Ea20vDJslseJF7DleLUw3aGF5XzN5gfgxAPlJYMKMKXgEyS0rjJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076544; c=relaxed/simple;
	bh=PCNDBkuk47hWM1BU08okt9A/P3f7nbKjVUe+Ep8EK6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqfHnvDbxho143yonUaKID8JPaXo0Hs/XtdzvBDKJ80A7UbMRdWP5M2eg60R3lViKRpdr2k+M2BbOFsWR/i/7TDPSU5lQQusu+j3xpPgVEsdPiVJWIbT4WfZNRmxO7d5t9rKEGxHBKSJfsGioo2OsxxXyiZh+5/lzZdd4y7RXyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+nHSkRO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+nHSkRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773076542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIiC+2A1nmWiuz2kfPAvzA8yI3UW09Vvl9VLP0EuHYM=;
	b=Y+nHSkRONQofKRTOYPn4IjPhc6UBEgg4ytIHr/pc0iXdyi4obYGSHSI1qlf037ysEqk2qc
	5b/LF7xgNn7NAbYEnVK8jgLkC+7pWdzMESktWUpYLzHdavbm2lEosFXA3OeAKnNvj7R76y
	SaZ54m39uqc+gqo8rcZ580NxhoYcBCI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-xPLDBa6yM9GShaFy1dHHNA-1; Mon,
 09 Mar 2026 13:15:38 -0400
X-MC-Unique: xPLDBa6yM9GShaFy1dHHNA-1
X-Mimecast-MFC-AGG-ID: xPLDBa6yM9GShaFy1dHHNA_1773076536
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64AC51956050;
	Mon,  9 Mar 2026 17:15:36 +0000 (UTC)
Received: from fedora (unknown [10.22.81.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DF041955F2D;
	Mon,  9 Mar 2026 17:15:30 +0000 (UTC)
Date: Mon, 9 Mar 2026 14:15:29 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Wagner <dwagner@suse.de>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 12/18] rtla: Enforce exact match for time unit suffixes
Message-ID: <aa8ADHUJPyPqM2z2@fedora>
References: <20260115163650.118910-1-wander@redhat.com>
 <20260115163650.118910-13-wander@redhat.com>
 <CAP4=nvTZ-k0QGsr_oyGmsr+gy6vbjmKv6TDVnUzQw=Av8YkEUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP4=nvTZ-k0QGsr_oyGmsr+gy6vbjmKv6TDVnUzQw=Av8YkEUQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Mar 04, 2026 at 02:57:26PM +0100, Tomas Glozar wrote:
> čt 15. 1. 2026 v 18:28 odesílatel Wander Lairson Costa
> <wander@redhat.com> napsal:
> >
> > The parse_ns_duration() function currently uses prefix matching for
> > detecting time units. This approach is problematic as it silently
> > accepts malformed strings such as "100nsx" or "100us_invalid" by
> > ignoring the trailing characters, leading to potential configuration
> > errors.
> >
> > Switch to using strcmp() for suffix comparison to enforce exact matches.
> > This ensures that the parser strictly validates the time unit and
> > rejects any input containing invalid trailing characters, thereby
> > improving the robustness of the configuration parsing.
> 
> This solution is incorrect. We need to be able to parse deadline
> priority correctly, whose format includes two suffixes:
> 
> d:runtime[us|ms|s]:period[us|ms|s]
> (see manpages)
> 
> and is parsed like this:
> 
> int parse_prio(char *arg, struct sched_attr *sched_param)
> {
> ...
>     switch (arg[0]) {
>     case 'd':
>     case 'D':
>         /* d:runtime:period */
>         if (strlen(arg) < 4)
>             return -1;
> 
>         runtime = get_long_ns_after_colon(arg);
>         if (runtime == INVALID_VAL)
>             return -1;
> 
>         period = get_long_ns_after_colon(&arg[2]);
>         if (period == INVALID_VAL)
>             return -1;
> ...
> 
> Your commit breaks that:
> 
> $ rtla timerlat -P d:10ms:100ms
> Invalid -P priority

You're right, I will fix the bug.

> 
> Tomas
> 

