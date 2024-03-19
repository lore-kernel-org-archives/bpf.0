Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7B8489
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866399; cv=none; b=uTpriktyEKdknYS9HHEP5ksQdfSIQn8yb3+qWGXmACyMMgE6/aAWHooYd2Cy9s+0jT+An/izRLDQVaPAasUmw1+VaWc0osxrTTdXCgru7APVVP42iR15RfT/wEPw743nYN0pYFZHu4Jk37qKOtWZE7CpJEVvkxs+xrXD9sW4OMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866399; c=relaxed/simple;
	bh=6WUhz94+0wyqqe3FiPCsB+Q8ismHCxcSfYZebTOlXqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvFY8CyZakzmmeD80KDH00wBKKPzsIR4cEH40a5NOIjyGtAIS8Uk5feKDswMx90RY+ntp5FqbwqQ3j1YOE9REZ5qsWjvS02DNkMaFXtyMgGDT7r1X83zefZ5nrXucRgj9aN7JeoLcC4kbg0NG3F+qCxmqeE7klPRLogpKVgXxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9jTCXtR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9jTCXtR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710866396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WUhz94+0wyqqe3FiPCsB+Q8ismHCxcSfYZebTOlXqU=;
	b=c9jTCXtRLk1Jc1pKSdmlBvYCT1bYjCGcu1uEcr4ZF3a5HgRyDTzzo7igQX9zv1woSltrE8
	gCm1pKG7OjWTeHL6PQoQEVV/afbJES7+jK9W2Jyx/RfGWzKZePPFZrCKq9R8/w0dnZcOmP
	dihxyvuHzfOPe2GS8z7w+5pohBVsd8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-5jxCytIoNsG8Njw_Zyv--Q-1; Tue, 19 Mar 2024 12:39:51 -0400
X-MC-Unique: 5jxCytIoNsG8Njw_Zyv--Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30692800262;
	Tue, 19 Mar 2024 16:39:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with SMTP id 34625200B3C8;
	Tue, 19 Mar 2024 16:39:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 19 Mar 2024 17:38:28 +0100 (CET)
Date: Tue, 19 Mar 2024 17:38:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH RFC bpf-next 4/3] uprobe: ensure sys_uretprobe uses sysret
Message-ID: <20240319163819.GD20287@redhat.com>
References: <20240318093139.293497-1-jolsa@kernel.org>
 <20240319102523.GC20287@redhat.com>
 <ZflyM5U67c47i4Oo@krava>
 <CAEf4BzZ-cAByJq8FmgxJgMt7WKAsDME6K00hYJpcS6XiwYO=-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ-cAByJq8FmgxJgMt7WKAsDME6K00hYJpcS6XiwYO=-w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 03/19, Andrii Nakryiko wrote:
>
> On Tue, Mar 19, 2024 at 4:08 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> >
> > I'll run the test with this change
> >
>
> I can do some benchmarking on my side as well, given I have everything
> set up for this anyways. Thanks for the help with speeding all this
> up!

Great, thank you both!

but just in case let me repeat, this is just a poc, the patch is obviously
incomplete and needs more discussion even _if_ it actually makes the syscall
faster, and I am not sure it does.

Oleg.

