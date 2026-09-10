Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130636DA00;
	Thu, 10 Sep 2026 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007612; cv=none; b=L5Za6LaRA+xOKIiB3H3fqBRxywtlV7TRi5Um/Ks6tP8cGzZ+JmOqjvEL5hCZxr4A6kzCVrrNyuSqZ+TfZiByUc9bQxUaG0aFk2wG/7JVDRMqebs3wsp8DmyQYGXr5yzhwAo59hPeRTQfLH22VNbI6NyvUPo677oTjpAw5dvgtzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007612; c=relaxed/simple;
	bh=rCnCVPWOoi+VTV1Z5KfuWjIYvFqLdVyl4ef1c7Wk5Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8C42oTM3tiQe1GSe5acKpkW5OMQUf0OF1Q+mh/W5wUNGxkmqzVK9oBjv0ey4pMRCwltgsU6xfKyteCZfr9pio30cI3l2p6gIxZ3HWgST7kYrE0NhUip6Gma9EiC6NLUAfc0pVQzJj25XMhboq3uGmsHRvYhskxoN+rXZHdzy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dRn6NekY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dRn6NekY"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C0F0740E00E8;
	Thu, 10 Sep 2026 02:33:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jYEDatXiYrTV; Thu, 10 Sep 2026 02:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789007596; bh=CvBCsqM24ZHvzS1IiTaODTjyVXUo3s7E7NsLy/NcZk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dRn6NekYce19LgPIiJKdKDlIra1LFGukMMnyhazzpGuX7O2os37VW6mg35w2zAFR1
	 uAn6R/KCRz+zijje1ImMSPYsXTXR4JeGwGbNOmIZw0nc1eWG7uwtS24eVpgtqhzjpM
	 UD/fVgyKFL4QGtzKXn+r17S9HHNbvm4WUayUOXAPsJA1KRrNvwITtrrRqLBNsTCuo/
	 FXfZaxsYAJaOF80OguKz+Yk+HhbXGj6R2CZnIUoQDKdiRVghx5EkL9maNka3KefPtq
	 UhAk2Os+w8vfGt1P6M52avDuHD141lwpb3jsz20e67v4bboTfSg/lIGkL0Usy2whba
	 lXMQZr5ZmprJrI1RgnYRm4K/ZMCGD87SwAuhJzFmzgGxnDDbZCsNugn0Ia1hQDyqYy
	 c1U2hNyM0kMp94YrNsoudZuirFRgmt5NDjvnbc175iHM+rk4Al/2CJ8DWSxTP1Uhno
	 V3RtcbSJAQJeRZ9yOgAaUqzxvN4y7TeFZ4Bgyy50/pU9LrLyYXl8F46aLbTGGhdyL9
	 xVzUCIYbzAujK/sbpjalZrMn5unbTUA4eK+KGmsJUd6HEE5YIpzXnwxqdgsrDoiftY
	 EQcfBxuIyMwpWQRQhxv+qDP1GjYvfbXfxSJKqDTWPT7cMYmczuMzwshoBF7ht8CkKh
	 WDYmmmZDMNfWSCpkGl62SoKI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0F3240E00B9;
	Thu, 10 Sep 2026 02:32:59 +0000 (UTC)
Date: Wed, 9 Sep 2026 19:32:55 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/5] x86/cpu: Factor init_cpu_info() out of
 identify_cpu()
Message-ID: <20260910023255.GDaqIW1ynrVQBDcESZ@fat_crate.local>
References: <20260814235134.3461435-1-ihor.solodrai@linux.dev>
 <20260814235134.3461435-2-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814235134.3461435-2-ihor.solodrai@linux.dev>

On Fri, Aug 14, 2026 at 04:51:30PM -0700, Ihor Solodrai wrote:
> identify_cpu() unconditionally resets the struct cpuinfo_x86 fields to
> their default values and clears the capability arrays with memset()
> before rescanning the CPU to fill it in again.
> 
> However the boot CPU capabilities have already been scanned by
> early_identify_cpu(), with interrupts disabled.
> 
> Introduce init_cpu_info() helper in preparation for letting the
> callers decide whether the reset is needed.
> 
> early_identify_cpu() starts using the helper in the next patch.

No need for that sentence. I'll zap it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
