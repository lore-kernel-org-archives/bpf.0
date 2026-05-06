Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29323368A9;
	Wed,  6 May 2026 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079835; cv=none; b=GNVmVh0Rv+i+H5McfQnIJkru9U69bsTIoW1jewstMsEkADgY+Jj8N4nXndCHkFx8ElwnNnYNO091d17IlVxGEacT7mYYZhkK+F1KMFlTtb5c5xYd7Bqo/eCcaEhoccFtKhNfavKbXgjJGJVX+E9kwzaFeIEXNmEL+BWZhuC41gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079835; c=relaxed/simple;
	bh=bRfHF+S2MFMHyJOxRLpu7TMI5KDisXUMXlQNlpCTENA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rddlH5XeCwoEmb3iimvR5peqIQaJFoRVX0D9FLAxGUX1fzluBa5M823scDMDEprk0zX48yTFLe/7AIZD/E4b4F7xpS2BKg508h3YHVSS2lYSt5Am6fl0ZPOt4XFda2ybXxiRO4AzRHSbgZgqdlB8Ve76AfNbiZgb+aCmWkM0qy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb5Png8B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb5Png8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EA7C2BCB0;
	Wed,  6 May 2026 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778079834;
	bh=bRfHF+S2MFMHyJOxRLpu7TMI5KDisXUMXlQNlpCTENA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fb5Png8BWp8LnifQPwtX8hdl67jcuQjxo//X1qRsR/B45J40W1yXe+Djpf7E4UmXo
	 fJjQ7StKMp7ICOvQ730YyKYLQJyUjeQYf57DvTuzG6bfOHxwBALz/R1mWZqz8FpkUc
	 76ry+dNxcSVgnYHxxcp4TEYDWOyT/ynf5idEDeK1hkvc9SmN1Y0p2XV1J/lStv0QWt
	 sMhgBc9f3ZTbutDvhmlHkgx6Ck7WlvkaPxutyOzyYmb9pxvr+jzHSo/vkxJ+CVqFBa
	 Y9giq+678EGDTTlwOYd5GcQ1sxZxSH0Fh9Nm4opLRUqcw6xBOMNNRZA9IZOpbCFFmE
	 MszqTGy6GXWng==
Date: Wed, 6 May 2026 11:03:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, Namhyung Kim
 <namhyung@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, "Jose E.
 Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Florian Weimer <fweimer@redhat.com>, "Carlos O'Donell"
 <codonell@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>, Indu Bhagat <ibhagatgnu@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Dylan Hatch <dylanbhatch@google.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Kees
 Cook <kees@kernel.org>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v14 04/19] x86/uaccess: Add unsafe_copy_from_user()
 implementation
Message-ID: <20260506110342.25f38f3f@fedora>
In-Reply-To: <9f85f092-c376-4350-9a12-479d7b70399a@linux.ibm.com>
References: <20260505121718.3572346-1-jremus@linux.ibm.com>
	<20260505121718.3572346-5-jremus@linux.ibm.com>
	<9f85f092-c376-4350-9a12-479d7b70399a@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 16:09:16 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> > +#define unsafe_copy_from_user(_dst, _src, _len, label)				\
> > +do {										\
> > +	void *__dst = (_dst);							\
> > +	void __user *__src = (_src);						\  
> 
> 	const void __user *__src = (_src);					\
> 
> This was suggested by Sashiko AI review.  Any objections?

I have no problems with that.

-- Steve
