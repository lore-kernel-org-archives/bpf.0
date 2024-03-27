Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E071CAAF
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540039; cv=none; b=FRJR8XkgV9xhZRlvC9N+IAnuLzga2iCpoY2+OWG83m4jFhIFpa7KZpZ3u4bYUZPTgwccWm1fo1sIRhf9kXEKI1hNhc3yqqe6yWlhz5ccoxuFcehffzOkxzWzoCBt8DqudLUf94Gn2b5CQJ5TlFCj+rW3S4yHfNK3vXGnk6L2VdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540039; c=relaxed/simple;
	bh=bR0Y9MPxEKos8gbJe2Wfol3VDdsY1MLLBChzsH2cZBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT4zkiu+KJx5Pdh/Z5c3r+wf8sehP/m1ecrgNugtW3jVEh65onB6eBiJayFCz/JJjATetTd+IPvTgkThB3AhXxt7Ykd3z8S1+wsqSpsEjCCdBK2aa+rKru1FKQapj4V3EYpyhxjgx7nuQZYaha1crK6feTiivrbkNEcf9tAh6Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFk81TeO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFk81TeO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711540037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVmgwIKJN1ru/dayL4eQoR5SU5vVYZpG5XATnKIZSgc=;
	b=DFk81TeOfuecKojkGDJHaVOnI3+7jgsjoapfI2I0wfHEJoyiHFkVCdJgu3Oq2FhTy+n6Sc
	gr605KGGE+6Yswfe6bwXXmlrJQKZvkp+XX3qFcpI07cV3B+GOA0ksjo6AlgjsPmnjJdjzU
	/gh4OEu3uVE0/hqc7JKPDbG95nvQJ14=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-h_eURUJPNcS48U_ei9bb4A-1; Wed, 27 Mar 2024 07:47:13 -0400
X-MC-Unique: h_eURUJPNcS48U_ei9bb4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81951101A58D;
	Wed, 27 Mar 2024 11:47:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.227])
	by smtp.corp.redhat.com (Postfix) with SMTP id 88CDF3C20;
	Wed, 27 Mar 2024 11:47:09 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 27 Mar 2024 12:45:48 +0100 (CET)
Date: Wed, 27 Mar 2024 12:45:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH bpf-next 1/3] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <20240327114524.GA20596@redhat.com>
References: <20240327102036.543283-1-jolsa@kernel.org>
 <20240327102036.543283-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327102036.543283-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 03/27, Jiri Olsa wrote:
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  arch/x86/kernel/uprobes.c              | 83 ++++++++++++++++++++++++++
>  include/linux/syscalls.h               |  2 +
>  include/linux/uprobes.h                |  2 +
>  include/uapi/asm-generic/unistd.h      |  5 +-
>  kernel/events/uprobes.c                | 18 ++++--
>  kernel/sys_ni.c                        |  2 +
>  7 files changed, 108 insertions(+), 5 deletions(-)

Just in case,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

