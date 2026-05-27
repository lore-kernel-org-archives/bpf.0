Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8311632E7;
	Wed, 27 May 2026 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912604; cv=none; b=CS0kcwavPRJv6DZ/8yvH/rRL1TUM+Hx9H9XRVILFSatv3oa/Uhq4w/vcXxH+MZLM65KQQYFR0hicC2e2WlQmlbjItzF/gTv513JOxUuLXOoZ4LY+0UXhVmCEA/7KstWR5MLWZtph84jorkGMv5XcirbLtPy+A7DCssSlcrrgtXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912604; c=relaxed/simple;
	bh=z3v5geP4eAKTBlJkF++zavVX2Gcyuvmfdpk74NxFxho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITQdk9nzDg2ZD0z4KTyzszMij56ksQoI9Ht2Mq2mcdA5lhuSbk0+tag4TrPCcl+OQ8A55ha2YbIJ56hgFQ6mJZFFAGel5hF/zdkKgopHD7kF2P2Nb9bYSzvpEQai3CMJVsGEEy+1m+5qaExBBLOL6bMxclc09/OOZveVLiyRFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlG7Bzvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlG7Bzvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448A31F000E9;
	Wed, 27 May 2026 20:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779912603;
	bh=H5Z4ARx03OBFgTDhNknOHWXfPOP7tDx5AxIk0S8sS74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hlG7BzvwVlbl+7oOOM9vAEreMs4Sk8Uxd+lGROE2dNwYE6UiMrJd9lKXeTXX1tvJa
	 g8EMREXiBinKdu+Er2yJauBXSH/mmIGLI2getLX2MUkZJVtiasfl9H0gBM6dSF4M/n
	 CsFiVxLTvMyJi0QRnM0Z4z5VmfHCJcDeO0oP9MDt86jNRBoZsLz9UphDJoV1oOWl8b
	 hs7cXBBdAP3p7pRmRjyvbjh25iaavwd7txqzilOrJ+DheFF1uQefOnY3Yi2UUIahLQ
	 hqQEvQi3qzUomo7O7dRoQo20T3M40xV/YZ/eILqicZ+ESZ9W2SQXiXyIy9Q5zQ5JXp
	 U4s2I7aT1ifKA==
Date: Wed, 27 May 2026 16:09:57 -0400
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
Subject: Re: [PATCH v16 02/20] unwind_user/sframe: Add support for reading
 .sframe headers
Message-ID: <20260527160957.1d3751b1@fedora>
In-Reply-To: <20260521142546.3908498-3-jremus@linux.ibm.com>
References: <20260521142546.3908498-1-jremus@linux.ibm.com>
	<20260521142546.3908498-3-jremus@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 16:25:28 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> +static int sframe_read_header(struct sframe_section *sec)
> +{
> +	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
> +	struct sframe_header shdr;
> +	unsigned int num_fdes;
> +
> +	if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
> +		dbg("header usercopy failed\n");
> +		return -EFAULT;
> +	}
> +
> +	if (shdr.preamble.magic != SFRAME_MAGIC ||
> +	    shdr.preamble.version != SFRAME_VERSION_3 ||
> +	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> +	    !(shdr.preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
> +	    shdr.auxhdr_len) {
> +		dbg("bad/unsupported sframe header\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!shdr.num_fdes || !shdr.num_fres) {
> +		dbg("no fde/fre entries\n");
> +		return -EINVAL;
> +	}
> +
> +	header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
> +	if (header_end >= sec->sframe_end) {
> +		dbg("header doesn't fit in section\n");
> +		return -EINVAL;
> +	}
> +
> +	num_fdes   = shdr.num_fdes;
> +	fdes_start = header_end + shdr.fdes_off;
> +	fdes_end   = fdes_start + (num_fdes * sizeof(struct sframe_fde_v3));
> +
> +	fres_start = header_end + shdr.fres_off;
> +	fres_end   = fres_start + shdr.fre_len;
> +
> +	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
> +		dbg("inconsistent fde/fre offsets\n");
> +		return -EINVAL;
> +	}

I really think we should also test if fres_start >= fres_end. Because
if fres_start is near sec->sframe_end and on 32bit archs fre_len makes
fres_end overflow, this doesn't catch it.

Even if it doesn't cause issues later, I rather have it caught here.

-- Steve

> +
> +	sec->num_fdes		= num_fdes;
> +	sec->fdes_start		= fdes_start;
> +	sec->fres_start		= fres_start;
> +	sec->fres_end		= fres_end;
> +
> +	sec->ra_off		= shdr.cfa_fixed_ra_offset;
> +	sec->fp_off		= shdr.cfa_fixed_fp_offset;
> +
> +	return 0;
> +}
