Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F933CB2E1
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076688; cv=none; b=uJEr6rM3tn6hyJkkBoMKevDUnMi5kJasDEQE7FaDSWKwTpw66noBR3wnMqAsNxYde3lETYS4aAAgN8Tr7RkAOu/4d26RUgOFcgek28JUWeMlKDxSLDp0AWiPuihy2hVAS5HF0VRlm6CdfkwsiQ/gccpA2x97COsb3YyM1MkgBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076688; c=relaxed/simple;
	bh=9CCY4PzYOrzWqpPuXimhKXwck19MaZ0LfiRjaCIJIzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5SjryvhvY9Qu4UZY/iOq/NLQVvLU7HWzgVcDypQrYiDwW3pJy9Hxw/E7lo1JV+o4E83oegBRkY+uSX9lUmLUC1vmMh0wWZ2T7VDA95nemsQeJuTyeAwJ15EN0zYYkC9+ahDKoxadn+87GyH/H6EQYLvFoIbOfEFz09GfyL05V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCNpJaRB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCNpJaRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773076685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i2rJs6eN4RulDPNhq1NMUOOVSeUcobhvUEjspYXJuM4=;
	b=gCNpJaRBpKcn/9DK6qB3168EIhHvQZSbLbpZFqayMauN3Gqi8TpQ8kCWCBmuhYj3E64fr/
	HHpALPNe1FU64B28miVIaI/g4vchmqwFN+u09FRHJGWhKAZQgzWuV5OTPLth8upcTWCuAL
	0H+pyb+3EdUQpcgXCdnVCZ/OO0cqYB4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-_kpt2FzsOxSO-92QLnQ2BA-1; Mon,
 09 Mar 2026 13:18:02 -0400
X-MC-Unique: _kpt2FzsOxSO-92QLnQ2BA-1
X-Mimecast-MFC-AGG-ID: _kpt2FzsOxSO-92QLnQ2BA_1773076680
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 936EF1956054;
	Mon,  9 Mar 2026 17:18:00 +0000 (UTC)
Received: from fedora (unknown [10.22.81.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E4F2195411D;
	Mon,  9 Mar 2026 17:17:54 +0000 (UTC)
Date: Mon, 9 Mar 2026 14:17:53 -0300
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
Message-ID: <aa8AXqNzcGKffUWZ@fedora>
References: <20260115163650.118910-1-wander@redhat.com>
 <20260115163650.118910-13-wander@redhat.com>
 <CAP4=nvQ6EeecMggeVciOaW_-=sa2QJ2r9DX0Xifzgsv5JBhAAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP4=nvQ6EeecMggeVciOaW_-=sa2QJ2r9DX0Xifzgsv5JBhAAg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Mar 03, 2026 at 03:27:35PM +0100, Tomas Glozar wrote:
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
> >
> 
> Why not use your strncmp_static() helper to protect from overrun?

As I said before, sometime I fail to follow my own rules *facepalm*.
> 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  tools/tracing/rtla/src/utils.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
> > index 486d96e8290fb..b029fe5970c31 100644
> > --- a/tools/tracing/rtla/src/utils.c
> > +++ b/tools/tracing/rtla/src/utils.c
> > @@ -211,15 +211,15 @@ long parse_ns_duration(char *val)
> >         t = strtol(val, &end, 10);
> >
> >         if (end) {
> > -               if (!strncmp(end, "ns", 2)) {
> > +               if (strcmp(end, "ns") == 0) {
> >                         return t;
> > -               } else if (!strncmp(end, "us", 2)) {
> > +               } else if (strcmp(end, "us") == 0) {
> >                         t *= 1000;
> >                         return t;
> > -               } else if (!strncmp(end, "ms", 2)) {
> > +               } else if (strcmp(end, "ms") == 0) {
> >                         t *= 1000 * 1000;
> >                         return t;
> > -               } else if (!strncmp(end, "s", 1)) {
> > +               } else if (strcmp(end, "s") == 0) {
> >                         t *= 1000 * 1000 * 1000;
> >                         return t;
> >                 }
> > --
> > 2.52.0
> >
> 
> Tomas
> 

