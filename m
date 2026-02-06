Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103C35C1A5
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370122; cv=none; b=KuVtGN49fXaiAH4lWa6mi0dOBGusfxhUTg8/Z9OpmcQFxda46qIV5tWcvnNKShwiGsWPnoUX5kZ5ba/CqqO93ZdmgJSWXFPSG9j6VDwEdBYLKhmLWdOZq6DaFwBhPamNAyEQkDT7NgyUJL0rzFfoyfti+/uarC3fZUMMGW1HZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370122; c=relaxed/simple;
	bh=zxnWFKojQO6aFxUH+flhLRJNy7Of3GO5/A4vWbmORUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebSWFxgY1cTOpmtLwr6d6etlQIfzNpIXtyPBxe10Ixhr1/LiCaTL49YhcmGxxYJ4ab4aXmSHhnNT4PqREADPGbGWUSskrkbenFrAXZlmil39zA2Gd9rXycGHkaoy0Do03Qfebc2PaSHG7oBsDtEzywx89l49joxA6KsF5HRTW7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PLPmOquR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PLPmOquR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so18502785e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 01:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770370120; x=1770974920; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7l0eS4ZS3Hx+zo3TMXCKY57/2jbb8XJIpZBlk+Z8Kik=;
        b=PLPmOquRlqttTDpJlTcWj0yxpCyLhnXDN7i12F8mxfYHkL0CQznOgP8rAMFrJqI722
         5FFsIakeIDvnzQVVYZBXk2xpxLR/LYPbJg0P6KIyRipdx8aNGNRsjGrr1sqOLoa8BGyE
         gnVKTM5nMb+Jan4dQH9F4eHCXaUETJzgqMbu6h6ThXODjm6VwcdzmwIlBzWo1OAb/3qM
         6xtFw7NASJOBVdutsGusc0GIgogP7KGXP69xlQXsv4icESCYs9BkaY6Se2rfm+Hv5Oq/
         UP+q17zYzs/DMFK72W6d6qrgM/jQFD6FEy5t5TPIysovL16FaBDRg74quAsUSnpL76HY
         pEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370120; x=1770974920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7l0eS4ZS3Hx+zo3TMXCKY57/2jbb8XJIpZBlk+Z8Kik=;
        b=qhN52ry8FKiHaSV5E6xwNwvmu5C07fbHCbpSnkEFnl8azOjlYhNj9BJ8g7/C77OSIB
         o993DUhEcEj8suSCwzod214OF8ezy7/WHzo3810Z/wgPPdDGR2VAigQ2qMzudm9gUZZ1
         7Wx9bSNK/JEXxlDMq5M7suvvQOVAIHcOSCddcRIZWfulI6A8oGh1ooQ1QRqNIwsbdxYF
         DaNTw9dSpgFgGbjbCYn/B9J/A/6yQj1zIzPlM1TC6RYPnJnM75Y/USqir5lwSMbkFDjr
         CMWe2mMKSpBsj/BOL6qKssQ0qLRyKlUlUde4HQurtCfJK7hSXxF6i7c/99Td35jA50QY
         fZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUmubW9IK1bwd+A0GkdNE+hNZd2LqrCwxuNgXJeYThx4A62rEIjz+13ak0uqu9Hjw4rNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVi9oT68brQpc7b2TesV4LLpcYKoQ8tn1bqigXBOXeulK3aQV
	LafFEhUsTcevOgKlE72N0ocamJXXxdZjgRn2/semRNwWo+4nJlpaIgdKY3FCH2lOn3U=
X-Gm-Gg: AZuq6aIV8IhkLk/2kj5vRbM3PiNvDW9sqwP5xZ2gvPke+S7A7QcFsxEjIgSX1ulozit
	oPn3rWI529UKzGuFQwwBnUxgduTnW1VEXFJ3anfdnS5E4bC8Q4K1n7RVc5XEMPcvMy4SbmbiE9K
	rpYUvsdJv2ExunsdZ7jmYCBStVr63RanYmyUA1Pnnp6Gm8NvFSWxfqwQmFyfbuZ3TrdkykfI9rz
	/blPIM5jXP2fImo5sySVW9PEa3W7I5qsMF3EI2LBuarPqGjVG1w/ketgvT2ZBtNlBaUGjEc/Rm2
	X6795hAi2BUsNZZgQ8fXZcWwT+d1NUZOnwadccIh3zsUoZjPwK5tO0sDhXTsuTNLP2sjQZaK1zZ
	DmzvLp7lPA3yVAMBMpNrXTV0vAW9LMDAMc6vkCgqNIwvOkIbxWnUnke4fm6NRW7Cx5WpmrBKLKs
	RewQmTNcHtyvP7Bj6Dguu03mFG
X-Received: by 2002:a05:600c:5020:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-483201e72f5mr28128425e9.10.1770370120138;
        Fri, 06 Feb 2026 01:28:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832039d238sm25524675e9.0.2026.02.06.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:28:39 -0800 (PST)
Date: Fri, 6 Feb 2026 10:28:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel test robot <lkp@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-hardening@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] vsnprintf: drop __printf() attributes on binary printing
 functions
Message-ID: <aYW0RN2R_8zngExH@pathway.suse.cz>
References: <20260204132643.1302967-1-arnd@kernel.org>
 <aYRapf5K8wFGEO8v@pathway.suse.cz>
 <4637e47c-61b0-43bf-996e-6291f2b49f31@app.fastmail.com>
 <CAADnVQJ5uHCVm3d_hO35cgrrcoLYBgk9x5iee0rNXBqKkHjj4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ5uHCVm3d_hO35cgrrcoLYBgk9x5iee0rNXBqKkHjj4Q@mail.gmail.com>

On Thu 2026-02-05 07:58:10, Alexei Starovoitov wrote:
> On Thu, Feb 5, 2026 at 2:13 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Feb 5, 2026, at 09:53, Petr Mladek wrote:
> > > On Wed 2026-02-04 14:26:23, Arnd Bergmann wrote:
> > >> Fixes: 6b2c1e30ad68 ("seq_file: Mark binary printing functions with __printf() attribute")
> > >> Fixes: 7bf819aa992f ("vsnprintf: Mark binary printing functions with __printf() attribute")
> > >
> > > From the commit message, it is not obvious why reverting these commits
> > > won't bring back the warnings in the modified functions.
> > >
> > > My understanding is that the warnings won't get back thanks to
> > > the commit bd67c1c3c353b6560 ("vsnprintf: Silence false positive
> > > GCC warning for va_format()") as explained by the original cover
> > > letter, see
> > > https://lore.kernel.org/all/20250321144822.324050-1-andriy.shevchenko@linux.intel.com/#t
> > >
> > > It would be worth to mentionin this in the commit message.
> >
> > Unfortunately, I have not been able to reproduce the original
> > warnings at all. The va_format() warning and the patch to
> > silence that look entirely unrelated here, that was just the
> > compiler incorrectly identifying a function that does not even
> > take a format argument.
> >
> > I'm sure some other intermediate change managed to shut up
> > the warnings, but I don't know which one. My best guess would
> > be that 938df695e98d ("vsprintf: associate the format state with
> > the format pointer") made gcc no longer warn about bstr_printf(),
> > but that predates Andy's patch and I can't easily revert it for
> > testing. Checking out a kernel before those patches does have
> > the warning on va_format() but not on the other ones.

OK. The commit will include link to this thread. It should be good
enough ;-)

> > > I wonder who should take this patch. Should it go via
> > > printk/bpf/tracing or another tree?
> > > Does anyone has any preference, please?
> >
> > I think your tree makes most sense here, but I have no strong
> > preference.
> 
> As long as it makes into the upcoming merge window any tree is fine.
> Let's go via printk.

OK, I have committed the patch into printk/linux.git, branch for-6.20.

Best Regards,
Petr
