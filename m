Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794666498;
	b=ltamoODJlSFRq2BzA8oNe45CmbXOCxctQsIaGPJLvq2jHAYgTbtuYxzaMSZFVED2KxpN
	 1On2CeqkSxWDJhJknlPGu2tzAaybzKK6tRGMUJ0nFSSuMgwx3m9nyns6vRWvXB6CeogPw
	 1LBMIdX0bCqo+3wDHvTC0T8bEF8rk0DkZa6ddtj0rFOszZHnj5Lg8SLe2wWGjQuCdp/n2
	 GRPF9zjuQZ16nMVrgZEJSdV4AZa7/ZIpRzD4lbKKhgbcnokjpgpdPY87TNwyHCFd+INvT
	 rlKUsmDTXJEQJpBLR1pd0MQXSwsxh0oNhvq8NnEK0aydQmrI1FC+c7Tggp8j6WcAyaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794666498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MKd4jZbLeaqRjSZ/bcG2vE1bYEI/pNWLpN8kMR29sBs=;
	b=biCiV2KQfcBcFsYU1k0EUKDbDWfIeQH8oIM2Bc+e3WW8FM/S+kRD25LdUPf8kx8FyN0S
	 1VBI0dx2+SJ7IZQxz0R+VkG2YYQI2BcpcNUpEVoeq9+yyS6bitWnuvjaAD4a16A8kq8fV
	 YRv4CCE6u4LmxALtsWkHi8n1H6E1UAJbLYCq4z0Ddk5HMskg89/pXxroABo7PRLAAlnqz
	 k0XLg7IVPhKgBcpJFsttf9ngSBfHNx2mCLdMezgZ1lghyXyHyNwwR02QAetlk7XvoYX0e
	 kT3I8NcnK+IquPLjo0VfFhI3/GZjvdeLHuYeyFp6eFNviyeWz+2koAMstjafqpMqfEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q+4R3ovY;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C4606A330
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 14:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 600C4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q+4R3ovY
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so28571665e9.2
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794666497; x=1795271297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MKd4jZbLeaqRjSZ/bcG2vE1bYEI/pNWLpN8kMR29sBs=;
        b=q+4R3ovYZbd3E1S20U1Aa4ML4vU6N0d9VX4pI7dJC1FzV1C0gYGljRlnC27lur9gQZ
         YugQHs5bQxVznydDn3qYG2pwcBsqY/YiYexRPjAPgU8L1MmWkLFLKM4dNsWF6X9DLjTv
         65bsh7L0NNvNMpKQQfDOODwA+FtWtNz/sH9kH+GVKC/sy+14ztxMurYyTlLolP7GVb7r
         rQN/GfkPzqJnser1+TZnLpkoIyYQpSidIKcBPq2zoZVkJ7gQbs5UXo/q/hYcW4OIpgEK
         hY0jrQYC8qQ33c/FtAr7PGt7x6IvOSF1XPh3lSYdkkofselScUqnYK4OqdxON+6oB8aC
         C7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794666497; x=1795271297;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKd4jZbLeaqRjSZ/bcG2vE1bYEI/pNWLpN8kMR29sBs=;
        b=eXWfzVdRVVU/EB6MPPp2fF/m9smokwDAEF6868P43l/SjUrTHgwOk2aet4Sduio92u
         uwPvQ54wl9G51BQF4v5QlqtgHth3PklYxNNOFxpNdc+ZgvHO/ssy1VPD2ETAEPjl779T
         m92rYEw5wYQNsXg7PNl+BxSHils21PTKiDJqkVfClQZLW+rinJZaOtQh0cBZ09+OTbuM
         QHb1Vh4KAkr6OJMIng27wUjtBf3pMt1sfAHx7Y9TEH1tOgwioNH2EN8sTo8urpheXBug
         DHQkwTMVkTRO62x3ttNdEQpyfgcc99lRUX7gXpO8acC+qe2NjjByjM+E9fsMghgEKvgv
         pPNQ==
X-Forwarded-Encrypted: i=1; AL+hErHJHgqto6lKTyXgaUEWjJZJHVqylvqg2XvPAbXDalnDQFmo9Um9002WadO0EG42LWbHLaY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hagx0f7Wn4FWdN6Tov2EtnHJN5yE7H+JwZZ/uE3rsH1m3oYWF
	Zrablj5MhUtp327lwxKU0tawYJod9VEaghoDxbM/s+aRvVGjQneQWSka
X-Gm-Gg: AYBFou1Xda+RmWrhGqUqplX+ErLmj27l8RfiGEIz5XNPG7uV19VTev7IxdlXEydqzei
	Hp43YhvgF5ZX8YT9o9MoC62s3hDwQndIkkUZ2QN62CGGQx8/+syyDjRdMdby2UjzDr14+vdSBUj
	4UY6ezasMUvlDu/O+wcLGcAQwrl8i8S2506sOjS9CMB/Ro8MZlRsd1Hv5RnAQUyJ7hydRwrKfEk
	9KbjtKsdtutGUoc6FmyLWcBdxd1AxXBx6pzeBr3406Hk8SAbA0A7rilZLv0UyUIBxAmgwSFUTuS
	J4CyTrs20NeBM78LJK0THdZAB12NK/GmvHaT0Q3ZqhVRfemFpSRger1463AnuR0snGFt5V4uE7J
	G8Kc57qBxlqh965Tp8yW0xFEBFN10mWdtHIcsuUEGfMNvO8FsJCfNfLHGHnIG7BMyRCJafKFHAc
	YYXBO85/vLUWPyDj6TQapdEnK7CTfpZiNpU7T69c/kLS3V2shrVb5xxLThEAQfLtOta5xIbEruY
	s9bRlI5YHkhyPimwOH0JiAUthTEg1QRH/TRYbw67M1o5Zpy5OatZssiyyBmztaetOBrGZiOMLj9
	u/h9TYDYqGxObNbLng+03bAYC63TxkTStTGGIUfQ1m1Zpqxzpla05+/LOpTTwwGHnQ==
X-Received: by 2002:a05:600c:83ca:b0:4a2:1612:637a with SMTP id 5b1f17b1804b1-4bb55a4e680mr118360915e9.16.1794666496622;
        Sat, 14 Nov 2026 06:28:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ae5299sm156028195e9.11.2026.11.14.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 06:28:16 -0800 (PST)
Date: Sat, 14 Nov 2026 14:28:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Petr Mladek" <pmladek@suse.com>, "Kees
 Cook" <kees@kernel.org>, linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
 "Jim Cromie" <jim.cromie@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Andrey Grodzovsky"
 <andrey.grodzovsky@crowdstrike.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Samuel Wu"
 <wusamuel@google.com>, nathan@kernel.org, nsc@kernel.org
Subject: Re: [PATCH v3 next 02/13] scripts/kallsyms: Improve error reporting
Message-ID: <20261114142814.30c8786d@pumpkin>
In-Reply-To: <sashiko-outbox-208961@kernel.org>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
	<20261111115911.1142000-3-david.laight.linux@gmail.com>
	<sashiko-outbox-208961@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 12:14:50 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] scripts/kallsyms: incomplete errx() conversion in write_src()
> --

I need to do a v4, I'll change the message (and remove the '\n').

David

> 
> commit 74224a3e189e43104e9d68aefe42fe16a066052c
> Author: David Laight <david.laight.linux@gmail.com>
> 
> scripts/kallsyms: Improve error reporting
> 
> This commit converts fatal error reporting in scripts/kallsyms.c to use
> err() and errx(), updates the usage message, and adds a --verbose option
> for timing output.
> 
> > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > index 140e888bf7133..aa3a8ec83fbb8 100644
> > --- a/scripts/kallsyms.c
> > +++ b/scripts/kallsyms.c  
> 
> [ ... ]
> 
> > @@ -490,7 +485,7 @@ static void write_src(FILE *out_bin_file, const char *out_bin_name)
> >  			long long offset = table[i]->addr - _text;
> >  
> >  			if (offset < INT_MIN || offset > INT_MAX) {
> > -				fprintf(stderr, "kallsyms failure: "
> > +				errx(EXIT_FAILURE, "kallsyms failure: "
> >  					"relative symbol value %#llx out of range\n",
> >  					table[i]->addr);
> >  				exit(EXIT_FAILURE);  
> 
> [Severity: Low]
> Since errx() already prepends the program name, appends a newline, and
> does not return, should the "kallsyms failure: " prefix, the trailing
> newline, and the unreachable exit(EXIT_FAILURE) call be dropped here?
> 

