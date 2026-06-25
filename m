Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02272882BE
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386374; cv=none; b=ckVkVlhjmdCf27t6YDr28VGmOyzLn4zPv7d8h+lwJ3uLLn7jWTS0xn8XCMkUCYV1uGXnxGT+gZ9zBQrfuHTlQ4mUTJt9J+iajPNEsuBXkEbAhTGsDMWRv6I02I6KJ3+hCrAsce1pLWlN2aF8lBAqdLJR6n7/TFq8lAvOQ8QSMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386374; c=relaxed/simple;
	bh=9GnjKZAAwWOJ6iOjqWFv8xkXbcwkJumenPFelkLST9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up7ghjC+k8+KEebCgv+VA0IqMBmZfieug0jPHk/GSVMZTERmHCx9vWNr1mlWDxa9hv5Pp/B3pP2XpVcLD7t44X+x0MRrjyHAEzOmu9UsBe97VTLlXkW8nG5iwin+P84cXQhQEpAPjyyKo7Q6qvGlGXbWdVc85AUTWNetjodf4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axDN3n54; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axDN3n54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782386372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=52ni/i+jk3KpB5D9iOoetAdp8/OomJTmilYdSF0nb8k=;
	b=axDN3n54i0K0kIcNIkGqHlD5OlGVacuXYZssGABlUs+pBfrdysOLW+jhXXo0CoHZcD596J
	BcA02SDFJ0tWTKJcAZUHsEb3d/sfsqndSmCP7NE1OXKHUKrCM9xQT6TcwGr6ZgumYWl9So
	vLvEh5LjeBCBDnuC0xOz7+E6eK/+z74=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-Nl7xn4FrNpmOfoP9vGStmg-1; Thu,
 25 Jun 2026 07:19:25 -0400
X-MC-Unique: Nl7xn4FrNpmOfoP9vGStmg-1
X-Mimecast-MFC-AGG-ID: Nl7xn4FrNpmOfoP9vGStmg_1782386364
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 658DF180897A;
	Thu, 25 Jun 2026 11:19:24 +0000 (UTC)
Received: from fedora (unknown [10.44.33.191])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0425330A8;
	Thu, 25 Jun 2026 11:19:20 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Jun 2026 13:19:23 +0200 (CEST)
Date: Thu, 25 Jun 2026 13:19:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/13] uprobes/x86: Remove struct uprobe_trampoline
 object
Message-ID: <aj0Ot99QdU6luuGy@redhat.com>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-3-jolsa@kernel.org>
 <ajvrZ_mMXnKrWf7h@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvrZ_mMXnKrWf7h@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 06/24, Oleg Nesterov wrote:
>
> Perhaps we can later optimize this code a bit? I mean something like
>
> 	start_reachable = ...;
> 	end_reachable = ...;
>
> 	VMA_ITERATOR(vmi, mm, start_reachable);
>
> 	for_each_vma(vmi, vma) {
> 		if (!vma_is_special_mapping(...))
> 			continue;
> 		if (vma->vm_start > end_reachable)
> 			break;
> 		return vma;
> 	}

I have looked into include/linux/mm.h, we have for_each_vma_range(). So I guess

	for_each_vma_range(vmi, vma, end_reachable) {
		if (vma_is_special_mapping(...))
			return vma;
	}

should work.

Oleg.

