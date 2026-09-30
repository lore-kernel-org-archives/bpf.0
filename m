Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DDC3CB541;
	Wed, 30 Sep 2026 06:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749570; cv=none; b=qt3lUEQgUEjGBW4UekU4cJn89/gZ15zEfpw9TlY9A1LGqxLihoGFghwBOBXKp0YhcqqT8LboYp4YxbjaLmgzK2NXjVafhPgdUikZPAQuxEzBiWBIOVisgOL4S5RHSOC0jA/l+bop62QpvOnf9poDHeJR9jTg1+P5uXJJPIpvKxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749570; c=relaxed/simple;
	bh=0NvyQ7Lhy0zOc+2x5j45PfQS7hAYHpnenIM4jeWcRLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4MqHEEKsrnjsxIB+nc5oyOOLkYw/gwT2uTRKbI0s3reJZ5TtOQq9cykVp6x2oYAakjlPWw+ueiekZdud4eAf4HYunj40c8DLx4rom9aa5+FyhYc5E6IDvaiUJbc/sz5UdBw9/DTJNaroJ3D1PNcR5aOxQLyQJEVfZxRjkgcycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLqB/OqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLqB/OqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0441F000FF;
	Wed, 30 Sep 2026 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790749567;
	bh=W6CVv6netXtQi2yXCagH7cZ+eCADzZUg5oVn2dFur6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NLqB/OqOnfmkUYiYtPwMw1Oja5FurkIhi15w23bbPMuye9dM+w7b+UJvg8Lb1gCES
	 +Q0Wm93LzxpLakuFDlcUXN8+l8B1qWg6vvLfpvRVPFZ9NEDWR8OzTh4uvpAWrgAray
	 IFdZaJbJp7tA8k4km3SoKTRaE8dKTC6v8LxBT+ghvKCvSZ8loUG1ar/aMy1a0Lixp5
	 0lsA8R6SUdJsRkudpo8O9SOlVzNkHE6NbwVjnyr31NDQbM1Eb9TYShxZ1jIn6DnBWF
	 kr9b23dSSz7lE29jOBGrYObY3qvkSATBjdTOf6aZn8secPofFZWzZSdfRxvTs7qEQ8
	 ALzj5mcKW/jtw==
Date: Tue, 29 Sep 2026 23:26:06 -0700
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
Subject: Re: [PATCH v7 1/3] kallsyms: Match compressed tokens on the fly
 during binary search
Message-ID: <202609292325.7C5769454@keescook>
References: <20260929-ksyms-tune-v7-0-be568ceef41e@gmail.com>
 <20260929-ksyms-tune-v7-1-be568ceef41e@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-ksyms-tune-v7-1-be568ceef41e@gmail.com>

On Tue, Sep 29, 2026 at 12:07:30PM -0600, Jim Cromie via B4 Relay wrote:
> So we introduce kallsyms_strcmp_symbol() to compare ASCII search_name
> against tokenized symbols on the fly.  Like strcmp, it tests the
> strings char by char, but when it hits a token in the symbol-string,
> it continues the char-test against that token-string, which is in
> kallsyms_token_table[].  It returns +- on 1st mismatch.
> 
> Measured across all ~184k symbols via CONFIG_KALLSYMS_SELFTEST, this
> shaves ~530 ns (~14%) off average kallsyms_lookup_name() latency (from
> ~3810 ns to ~3280 ns on the default 256:1 baseline) and drops the
> 512-byte namebuf buffer stack-alloc in kallsyms_lookup_names().
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Reviewed-by: Kees Cook <kees@kernel.org>

This is a nice win with no downside. :)

-- 
Kees Cook
