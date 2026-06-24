Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1753DC4B7
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313325; cv=none; b=KKhm6NukRN/JJK2Hehf/K/erWzvfEdVIbaFaVB8Vw/3tHnkG8pV2fhRyCHAdm6S52sxnTt+AcLm24zVLGPoRHCPbX3t66yJDQh8kpg/GShozTgV3+fRmjidq4a4j1AjLWp2bwrlzkGOgB9UMSecEdff2vw7Bmu/WCKWAuhOfsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313325; c=relaxed/simple;
	bh=HSXAmY4oIpYnDcoRBb2s3gNfFCGqSkdEyp8DyUK6dkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eb5AJWVzDws90C5shOEiJbnmwiBDmUfOyGiW4leJoD3tO653RWq3IDPhdM5jQx3ZpLQk2EyoCC9Z1KF55l4Fu6BdkGC2w7Fw+JO9J+eu24ty3KSZieqDa5ocPta7tYZmmUE501BOm6Q5wwbTT3UyaLIwEuKNttLdyBwSIlswVIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCBAku3U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCBAku3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782313323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wNbTSd/mb1gmqNS1zuu0jD1pu9fNGBd8+dOosPxOpyM=;
	b=OCBAku3UYsyqt5j+6kEMVdicZZ3ARc6wls1cHwt2QHUzrtN72NEGt3L2350Qj6oavMtrt9
	tTFFFcUHj0abOtmrYA+lYhEInJSQvxjnF/rxIk+F1aZ+pwEx20k9nQFqYT6YOG4DLwbTvL
	Ry9W6ctiw2nC0LdBtSrMFIpX3h41zKg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-KikiAJuYNg-rWt5Lfk2piQ-1; Wed,
 24 Jun 2026 11:02:00 -0400
X-MC-Unique: KikiAJuYNg-rWt5Lfk2piQ-1
X-Mimecast-MFC-AGG-ID: KikiAJuYNg-rWt5Lfk2piQ_1782313319
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 022B61955E91;
	Wed, 24 Jun 2026 15:01:59 +0000 (UTC)
Received: from fedora (unknown [10.44.33.191])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 774F8180056E;
	Wed, 24 Jun 2026 15:01:56 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 24 Jun 2026 17:01:58 +0200 (CEST)
Date: Wed, 24 Jun 2026 17:01:55 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 03/13] uprobes/x86: Allow to copy uprobe trampolines on
 fork
Message-ID: <ajvxY1XIJhLEm6u7@redhat.com>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-4-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526205840.173790-4-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 05/26, Jiri Olsa wrote:
>
> When we do fork or clone without CLONE_VM the new process won't
> have uprobe trampoline vma objects and at the same time it will
> have optimized code calling that trampoline and crash.
>
> Fixing this by allowing vma uprobe trampoline objects to be copied
> on fork to the new process.
>
> Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

