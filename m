Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC8374725
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314887; cv=none; b=BrsLclxRTbQuic3hUNGnurIhu2DaJou+W68CF2u2T2TdyzxM/Rp7EFl7Jr1v+NZyMv4i6AdmAnMaKcI1r+87YDeaGJvyLJf4motUoyMN8CdEXJnpJvn/ZePPQoGi4tVjDW6Q/5016KOkCDrTV1Bm0Eddqq1TFuCodByyxWLR7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314887; c=relaxed/simple;
	bh=TJInaTL+I8/+pMcbQ2Obw4yz8CAEc78+I6SrvyhWFeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipQWyUxLuTD1bnEN2c7lRgf+MnuVbsuW40knFYNxcRbiBx55Fo2ao+mQbRHlHoBoc7kBH1ttz1evrQBrUlwLUuVb09zll1uJk5LD+9XmtZ69HyuTFK99Bk9kuMD8wEwQd3CZ4f8tab1LuzbClqUy9CoYahPRxiST010q1apXOk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwUhhrTg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwUhhrTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780314885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9iMi5OP8IuxpDw3nqLpnBbtHMB9Wyt0z2yi1muFCLEY=;
	b=dwUhhrTgdiw/mf8612fPYy+7mohVcSnIga2gyVEUTYaWNNWL3ip1bMNjiJ8HIDr1xDikIM
	QrsLOhl9eeA3La+O3iPTVgNMNqbo5MEN47d3lYMIQ60LKFBR/oab+zxFXMwInC5brQMEsb
	JfmK1zTNSoFDloAQdiLzfozziAoGJ5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-QYzQeQ1SPGq-54Z67sA7cQ-1; Mon,
 01 Jun 2026 07:54:40 -0400
X-MC-Unique: QYzQeQ1SPGq-54Z67sA7cQ-1
X-Mimecast-MFC-AGG-ID: QYzQeQ1SPGq-54Z67sA7cQ_1780314876
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E55541956080;
	Mon,  1 Jun 2026 11:54:34 +0000 (UTC)
Received: from oldenburg3.str.redhat.com (unknown [10.44.49.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E13C1956095;
	Mon,  1 Jun 2026 11:54:24 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>,  bpf@vger.kernel.org,  Masami
 Hiramatsu <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Jens Remus <jremus@linux.ibm.com>,
  Josh Poimboeuf <jpoimboe@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@kernel.org>,  Jiri Olsa
 <jolsa@kernel.org>,  Arnaldo Carvalho de Melo <acme@kernel.org>,  Namhyung
 Kim <namhyung@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,  Andrii
 Nakryiko <andrii@kernel.org>,  Indu Bhagat <ibhagatgnu@gmail.com>,  "Jose
 E. Marchesi" <jemarch@gnu.org>,  Beau Belgrave
 <beaub@linux.microsoft.com>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Kees Cook <kees@kernel.org>,  "Carlos
 O'Donell" <codonell@redhat.com>,  Sam James <sam@gentoo.org>,  Dylan Hatch
 <dylanbhatch@google.com>,  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  David Hildenbrand <david@redhat.com>,  "H.
 Peter Anvin" <hpa@zytor.com>,  "Liam R. Howlett"
 <Liam.Howlett@oracle.com>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
  Michal Hocko <mhocko@suse.com>,  Mike Rapoport <rppt@kernel.org>,  Suren
 Baghdasaryan <surenb@google.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Heiko Carstens <hca@linux.ibm.com>,  Vasily Gorbik <gor@linux.ibm.com>,
  Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: Re: [RESEND][PATCH v2] unwind: Add sframe_(un)register() system calls
In-Reply-To: <20260528151626.4573592d@gandalf.local.home> (Steven Rostedt's
	message of "Thu, 28 May 2026 15:16:26 -0400")
References: <20260528151626.4573592d@gandalf.local.home>
Date: Mon, 01 Jun 2026 13:54:22 +0200
Message-ID: <877boio4r5.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Steven Rostedt:

> From: Steven Rostedt <rostedt@goodmis.org>
>
> Add system calls to register and unregister sframes that can be used by
> dynamic linkers to tell the kernel where the sframe section is in memory
> for libraries it loads.
>
> Both system calls take a pointer to a new structure:
>
>   struct sframe_setup {
> 	__u64			sframe_start;
> 	__u64			sframe_size;
> 	__u64			text_start;
> 	__u64			text_size;
>   };
>
> and a size of the passed in structure. If the system call needs to be
> extended, then the structure could be changed and the size of that
> structure will tell the kernel that it is the new version. If the kernel
> does not recognize the structure size, it will return -EINVAL.
>
>   sframe_start - The virtual address of the sframe section
>   sframe_size  - The length of the sframe section
>   text_start   - the text section the sframe represents
>   test_size    - the length of the section
>
> If other stack tracing functionality is added, it will require a new
> system call.

Would it make sense to have a more general mechanism to attach metadata
to code memory?  For example, a JIT generator might want to provide a
hint how to obtain debuginfo for the code.

Thanks,
Florian

