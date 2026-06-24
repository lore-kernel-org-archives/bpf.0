Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A3826A0B9;
	Wed, 24 Jun 2026 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316252; cv=none; b=JguZEAN8TtI92/Ce4APzPuoXNOyzFu8qbBGQW40szIvmEUvqtJmfdQ2AuDNw+2wPoQ+cHqfpZ1Z6iZB8QUYSSyhuC+Sxsx6DDS6OnW8sCePWJMqy2EXtlOn+Nkj9vPR7J70Cl+nemrP5ezNLWNsNvhBApSy5PNmqBNVvVX7qtxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316252; c=relaxed/simple;
	bh=uQtzTJ6URDqpjagy1a7OXpydALicjh7xI3FPLQtdz6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxTu+1LE+/lizjqzBYkEVf3ZwauHWs6Px5YcwNdHYIxMtW7HElZbtUVtVN7uJ848/TGXRKsNIg15+3brnDF4rR0WdabIInpgojZfIkIZwwwL81llsV7ZCfNLAUBm73CbHJUCrMGmxCoAVslJjaQ/wdTqE9z8RF8EydeLX95RWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nVZynwdc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nVZynwdc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7pRlBLyW0rZ9a8pbzBcOWWJR3Cglg/eninZwUlynwgk=; b=nVZynwdcx5kKz0BZiDTzoFN+8W
	qam37WbJaU26Mi0zC7cLhqAd/2HT/VoKM3IlJ5RDzTke7Aj7UQhJqMSqdiTSPTR6diY9EcPXcA0X9
	7QlU4W206TL/k7iipxTFTab7WudMlJOoFsTqoBOxXehVAHlhLjfB9Ll9MALNOnoycloeHramf1bd5
	M9Q78G2yED5HKOmsx/nuKbmczZ8Cekh+mZLhIGVRN57ln7cDL1Jn47UNWokk0x+SPDUb8uK8ksa+a
	ePqIhlG36LdDVu3lGQ3rrTgQRCdg24ZqRj2RW5O+QAXUcnJOm43sgymznmSAYJ9EryVUzwzXmKyo+
	8RvvlLAA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wcPru-002X68-31;
	Wed, 24 Jun 2026 15:50:27 +0000
Date: Wed, 24 Jun 2026 08:50:20 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, paulmck@kernel.org, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, linux-doc@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v6 6/8] Documentation: bootconfig: document build-time
 cmdline rendering
Message-ID: <ajv8puUv7wE7raef@gmail.com>
References: <20260623-bootconfig_using_tools-v6-0-640c2f587a3c@debian.org>
 <20260623-bootconfig_using_tools-v6-6-640c2f587a3c@debian.org>
 <20260624174737.a4862dcd86f3d746b788d197@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624174737.a4862dcd86f3d746b788d197@kernel.org>
X-Debian-User: leitao

On Wed, Jun 24, 2026 at 05:47:37PM +0900, Masami Hiramatsu wrote:
> On Tue, 23 Jun 2026 09:15:33 -0700
> >
> > +The option requires ``CONFIG_BOOT_CONFIG_EMBED=y``, a non-empty
> > +``CONFIG_BOOT_CONFIG_EMBED_FILE``, and an architecture that selects
> > +``CONFIG_ARCH_SUPPORTS_CMDLINE_FROM_BOOTCONFIG``. Currently only x86
> > +selects it; on other architectures the embedded bootconfig still works,
> > +but only through the late runtime parser.
> 
> As commented by Sashiko, here we need to mention that this option requires
> CONFIG_CMDLINE to be empty. This means user can NOT set both option
> at once (This also means user doesn't have to worry about configuration
> conflicts.)

Ack! I will update.

--breno
