Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DCD471257;
	Tue, 21 Jul 2026 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657629; cv=none; b=Mk+cwlDLnZi1+Ux8BsYlcMGaMc9aWA+xSFel3S5yrUlaTEu+ar1aVWPAgAraeRHRbMFHKRrSD4Q3wVYGWu4HQUEsFSTl56awepYomkvEQ5uQLVUBatgcM6C9f8+4ThrX1kzogSChDLH1okjvnpFwldA603ngeS0XADMJaMHsoVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657629; c=relaxed/simple;
	bh=EFAQxgd+oUJ+jH2aGiUQecL7qwwmxU50Ap/j9C3g7fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWMvPC8s62zbZWDswBCvbhgyGhnRv20FBGAziTafsRKHHn/qYrc6MBZDXIQ77wVii5LWg8NlhP5DL1e76SDXOlUdbPXsBEIlr+juYSU7fpnnlNW5Blim0aFwrYfoBdMKiV8z5HuBxHFGhLymMkiKFt4WCh/35vPhqzR94fVLwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AFG+8oMq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AFG+8oMq"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 04AB040E00C3;
	Tue, 21 Jul 2026 18:13:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WAgM4pQygBNu; Tue, 21 Jul 2026 18:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784657615; bh=LSfkR1e/dR8kqPxQlWrl73BK+AJy0HI9oL3YLggpuKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFG+8oMqJ6CM22RRudRv/nXdW5UuYrbU46fmTTZlALzETNNr9CwP4cZbj+QgQOxkh
	 9hw+oXsWm5DhTcDpNXuGs/YaK9pFU0L9TIXnkESUOmFRlNIcTGyk6+nDFaRzeg1Qmp
	 dzgEU5UiguZUOojfrsjzaGNbEZOZa2HT5ih8y5OM13Pnl0VYhYin8b2Nkpny3l/u2C
	 rktizLJ48mqBMrjD8CFdkklVH8Q3inF4tCYFexQKghkl3miTHh7yAlOZoTNfIJ55id
	 UlpSM6QZM3uOCg63I8/rTdWRN0gwZNPl8Nrnic0062Bx+A8JsZIEQocUyMj3Y4nikl
	 9owLsJzseUxstriow0FasdINPHKxavLfkxW9UsQ6EaXH3XvNMZGsHBzvUfMR0SrgQN
	 SJDtzRl9sZzag3zbCFNbDZJH/qEn8zG2oa/llXQCN6PMmBoF9ru6EQ28SR7baXL/jE
	 MfLjcKh+7rqtWDuo86Rz25IvPKUyjsexNDvlecm56E2jpambnMRwBgPM0iWYUPqZvt
	 cnMGp0GyLIhZNJShDQ4F+iLCCuqIYfJpSBPMxgw0qFnOusN2uaJyCjPdf6jwdpiSbQ
	 ya1WUb+rjROSj2Rc/tDGNBbURH+R5lNWBMyqNlt8aGTp9ehn28FLWJ+ee1oEcq/8gw
	 MH8GvTKPSj6o5/oBONJ9AO3Y=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 690BE40E00E6;
	Tue, 21 Jul 2026 18:13:19 +0000 (UTC)
Date: Tue, 21 Jul 2026 11:13:16 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>, bpf@vger.kernel.org,
	kernel-team@meta.com, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] x86/cpu: Refactor identify_cpu()
Message-ID: <20260721181316.GFal-2vGmvOGqbq8mW@fat_crate.local>
References: <20260704002046.3859585-1-ihor.solodrai@linux.dev>
 <7c79eb26-0986-41c8-a5f9-5911a2e71175@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c79eb26-0986-41c8-a5f9-5911a2e71175@linux.dev>

On Tue, Jul 21, 2026 at 10:23:25AM -0700, Ihor Solodrai wrote:
> Bumping the thread as it's been a couple of weeks.

You don't have to - it is on the TODO list.

> Please take a look when you get a chance. Thanks!

There's this thing called fires which need to be handled yesterday and we're
all drowning in them. So yeah, I know, but pls be patient.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
