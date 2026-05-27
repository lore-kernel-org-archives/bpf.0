Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9011B379981;
	Wed, 27 May 2026 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913234; cv=none; b=J+NcKD5+364WWPR2MwsiAAN2OQGnwl0XJFmg362ijRYGTHSZ7H4tVeL/6Y5BEiVj3+9N4fLZKZIIV71IysqTpX1mvnb0kfbiIIKs5iHM0+1J8Vt7S98R0MehX+4yJ7BiqbLkdzOkYCbJvR4FtCCaUrLQlOUWQA+ld9u3ulICTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913234; c=relaxed/simple;
	bh=RTut6isRGMwpAy52FAidwZ9r8GAJje7lnJ5qFaF7/MM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmoVn1IZn8bD3aqlYilMxCNyoznxlzVjyzztJQAzRrfoPwHCTsee0emHXA+ecpyNrSxy6A9e4fHAioxY5wy4JxVHVNf/BS7PqFFwyoEHPfXLuP40Sl2cDvtXQeOE0ONe+74T/wyzXHVo5wqUooOywNIKssOkK0C1qBHknktN+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmNiH4dZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmNiH4dZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAF01F000E9;
	Wed, 27 May 2026 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779913233;
	bh=bG044lG8uwnuKZ6EhriDC30t1Dn2ecruBKaCCD9TMos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AmNiH4dZhZHJSUUeDAnN/GFh4yDmQuZ1MK+zn5eA/EhtCTJqYEeoVt7/V3TUASaE0
	 3hj1S9zbGhLpPU3TYLurVIRM2UOehIOC6wT8rIqQDDURlNafIaKmzHDAS6zmqxslf6
	 iG1Iy2XeKIi4OcgkfxX0RAJWP54en3/4PTCKuenCghFUhqplDUrArE9LMeaaE4ghCO
	 jSzCznk1HDhvUeLDbejUw8ZbbCmYKytyhs01CTLBOx/BlmKj2kvftFl2V/eZKTExU3
	 2S4/FZVcmvmYq/Tq797gLhoW5e60tElbM5VDs4SEqU76Yrk2SUmY3Y//kwYMYf5eNm
	 o84bFDtnVpQHw==
Date: Wed, 27 May 2026 16:20:27 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, Indu Bhagat
 <ibhagatgnu@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Dylan Hatch
 <dylanbhatch@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Kees Cook <kees@kernel.org>,
 Sam James <sam@gentoo.org>, bpf@vger.kernel.org, linux-mm@kvack.org,
 Namhyung Kim <namhyung@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 "Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave
 <beaub@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, "Carlos
 O'Donell" <codonell@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v16 03/20] unwind_user/sframe: Store .sframe section
 data in per-mm maple tree
Message-ID: <20260527162027.277e744c@fedora>
In-Reply-To: <20260521142546.3908498-4-jremus@linux.ibm.com>
References: <20260521142546.3908498-1-jremus@linux.ibm.com>
	<20260521142546.3908498-4-jremus@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 16:25:29 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

>  int sframe_remove_section(unsigned long sframe_start)
>  {
> -	return -ENOSYS;
> +	struct mm_struct *mm = current->mm;
> +	struct sframe_section *sec;
> +	unsigned long index = 0;
> +	bool found = false;
> +	int ret = 0;
> +
> +	guard(srcu)(&sframe_srcu);
> +
> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
> +		if (sec->sframe_start == sframe_start) {
> +			found = true;
> +			ret |= __sframe_remove_section(mm, sec);

Because this is all internal data, the __sframe_remove_section() should
never fail. Perhaps we should add a WARN_ON() if it does?

		if (sec->sframe_start == sframe_start) {
			ret |= __sframe_remove_section(mm, sec);
			WARN_ON(!found && ret);
			found = true;

-- Steve



> +		}
> +	}
> +
> +	if (!found || ret)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
