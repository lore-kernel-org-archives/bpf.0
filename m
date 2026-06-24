Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAC2745E
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310171; cv=none; b=WgwL1PAYAyYznYYzZoyOApnfFsTGoZ6lRtBtX+5vMVdeLMNfrnytqzXFOLJaqFHBOSUsNfGxJVqJG5mc2Fdq7lvXUg49RMF45Rcq3Kesb131N2N9k2qOe0cJia1PATOHg/dpuJe5Si31x3fUAs+EnG4x2lgqGrmNV1rcBj3RZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310171; c=relaxed/simple;
	bh=jsp0sFwKr3h7Lff26TOFAm04U3kGyYh/1UJtmjGNF2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcqNsMZEEIYyCcVjMKAI7kWU1m5QJzttLbr8AoatR5kMY7FhFIcYLb2I1MqfvGJMwThLJvdGzNhwkDLb/4Pwit0qNum7RLs+tCqoVs00P4p/TiEn34khkjquRv8Du0Os5Uh24xxIk29JqJ65paA8zCvGBGTHDFSC8/1tr6RLqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDcHdMbG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDcHdMbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782310168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jsp0sFwKr3h7Lff26TOFAm04U3kGyYh/1UJtmjGNF2o=;
	b=EDcHdMbGl29igPGWru/190a6fCs0xddSRfyhzT1x8leO0UonXSfdbK/J6hh/5vtX5VlY0t
	06vEfgyazuwrriMvyGOMhWz3mvT+GWJz+05m2nlKEBIERRR9oQbdn1M3hu1n1j+hoM7GvK
	a8c1QQ12JuuVw+8shsCqyqU6FfyzMEI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-xnpgZknjOYGyfqzaULc2bQ-1; Wed,
 24 Jun 2026 10:09:24 -0400
X-MC-Unique: xnpgZknjOYGyfqzaULc2bQ-1
X-Mimecast-MFC-AGG-ID: xnpgZknjOYGyfqzaULc2bQ_1782310163
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31C06190A08D;
	Wed, 24 Jun 2026 14:08:41 +0000 (UTC)
Received: from fedora (unknown [10.44.33.191])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4D637180058F;
	Wed, 24 Jun 2026 14:08:38 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 24 Jun 2026 16:08:41 +0200 (CEST)
Date: Wed, 24 Jun 2026 16:08:37 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 01/13] uprobes/x86: Use proper mm_struct in
 __in_uprobe_trampoline
Message-ID: <ajvk5aQZV13DeMis@redhat.com>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526205840.173790-2-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 05/26, Jiri Olsa wrote:
>
> In the unregister path we use __in_uprobe_trampoline check with
> current->mm for the VMA lookup, which is wrong, because we are
> in the tracer context, not the traced process.
>
> Add mm_struct pointer argument to __in_uprobe_trampoline and
> changing related callers to pass proper mm_struct pointer.
>
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

