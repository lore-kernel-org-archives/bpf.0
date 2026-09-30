Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298A3C5540;
	Wed, 30 Sep 2026 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749708; cv=none; b=J52OMDoRuGSAvJ6KyH2xHvgIWZSBYCEuVdetR5QaZOPyesKR0aKs/HE50sn6hwErdsSrwy2pgXxsCunExoJ6JBIJAqnA4Ljp76vDAFEGcGnCfyz8yi7Bl9G2dps7VSZtNnPr3IFuprhXrQokTtbNTOw/HPw69UuNsDr6KWMtmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749708; c=relaxed/simple;
	bh=FRI4aS0wW3RhjMwsIBKxV6eO9lO/UX2j33PcxZ3VRe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPs3RNgJGfK43O+yfjakkS8xlZoI8gbyoQ+L8J2BfTV+hSXcml+kSiFdTY5ffvo3AvnnsbeUPXngn58/IJ3gJ2/UHwBC3XI9S83E5AkX3lhrOwrLbQIspGEF/fkJWIojuuCcdPM+v3Vxc/1wIEyvTEsnsa5Lzq4se+boI1ekudI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuuMpoel; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuuMpoel"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE2A1F000FF;
	Wed, 30 Sep 2026 06:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790749707;
	bh=8Obt37QKmluj6+dRVLXMq2gRzO43UN0vtkxkPGsuceA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GuuMpoelsu55oFZpU1GAdKork/vTVqxjs11dkUKJFDY8YDSiJFvjWUz0oLw500o5d
	 s+b29fNKg++g5BVZnO37ufGF95QG4eepxi0LKzoBPgpO1qpMAKUjb3tepIIi+zPWt6
	 qysNlYeOH016tqLUGSVqX3TGwbf56Z4HN1sfrFKB8Xfw1ws1QyWFYLbMnjmzzKMHGt
	 tm8IVgirgJo1JKJDBaviGqb2epSbBpVGCveN74VIY+b1ACSjgraf7fnlP8vd/zRw2Z
	 M0jO4ZPEsoHR8HVVeDPgdzh2lUAgjaaiZfCOU3dcGe94hY5smgouytCloQXbc4suy4
	 xwzHOomnQI3Pg==
Date: Tue, 29 Sep 2026 23:28:26 -0700
From: Kees Cook <kees@kernel.org>
To: jim.cromie@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v7 2/3] kallsyms: Increase marker density to 16:1 to
 accelerate lookups
Message-ID: <202609292326.C88BC5F0@keescook>
References: <20260929-ksyms-tune-v7-0-be568ceef41e@gmail.com>
 <20260929-ksyms-tune-v7-2-be568ceef41e@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-ksyms-tune-v7-2-be568ceef41e@gmail.com>

On Tue, Sep 29, 2026 at 12:07:31PM -0600, Jim Cromie via B4 Relay wrote:
> Without altering the underlying storage layout, we can retune this
> trade-off directly by increasing marker density from 256:1 down to
> 16:1 (KALLSYMS_MARKER_SHIFT 4) in kernel/kallsyms_internal.h, shared
> between scripts/kallsyms.c and kernel/kallsyms.c.
> 
> This caps the remainder scan at 15 symbols and cuts average scan distance
> from 127.5 down to 7.5 hops (a 17x reduction).  Across a 17-step binary
> search, total hops collapse from ~2,170 down to ~127.  For a kernel with
> ~184,000 symbols, this adds ~10,800 u32 marker entries (+42 KiB) to
> write-protected .rodata.

Thanks for trying a non 1:1 route. I think this is a reasonable time/space
trade-off. ~42k .rodata to get a large speed-up.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
