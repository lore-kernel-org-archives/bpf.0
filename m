Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C11B34CFA7;
	Wed, 27 May 2026 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909596; cv=none; b=aIMeg31AHVEiknMhyEIi/1ztWTBObWox2TICblUXLsaYPLfs+fapsrSAHKySMurjtHCrTCYMeDSAeTv4sJOAJtQ8bFJTQ5aGdaggl25euQWQ31q42ePoguQZDuct9JQY/CCn6ToAoo4GpGNFolw2GAcXvnLjfM025Zokj12yAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909596; c=relaxed/simple;
	bh=wTlo1P/2QYTnG0EkidkDSxIu2cM5UI3t/ni73RCyaa8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=sdfpijf4JgmlhA8l/m1w3Gj7iAa0ixkmg7uiktb0maYF0QIQ1dekQ/oEM/+C82OfpEJFV3kpbmSSQA6TMNxjRjf577TtkO/JR2J08zN+/NDBjxM65hAtYp4TBa7kmg4zk+mR1Wnxvae8MBIcFwXi9qjPe8E5wDV9uJrSkbti4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=25H2CkGF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="25H2CkGF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DB5021A36F4;
	Wed, 27 May 2026 19:19:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93D84601A1;
	Wed, 27 May 2026 19:19:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD2F11088818E;
	Wed, 27 May 2026 21:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779909591; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wTlo1P/2QYTnG0EkidkDSxIu2cM5UI3t/ni73RCyaa8=;
	b=25H2CkGFIOBOEg5XPFhvQRuNkyTwWmIdTDt/9x9dphptyf9N1d5Un3wCVAgkKGI4AQneQm
	5FC9JwjBnQZjncewYC2nQpoHscjDYUPLOCx+lOyFxvAsCcGfPm+gUXvaTKbBtk12/k1Fjh
	WfNJ3kIwDJFTvay9icB1N02cOI9ihiSBX5WTUprfHzMlz7swP4LnnAnDFrPDkvEaFijxhE
	OJG0xoAE/8N2ARIbYHNmDeG6ka9UsDnn/zeLaTrYPisLEb4U739F1VPLw55gd7gFv+LHcQ
	RnrXvbiEw+4BkCdEqVGQVFfBTRpa93Q5xcfjlOPUF/ubITvVxU1Jjd08arYzBg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 21:19:47 +0200
Message-Id: <DITPAGA18EUH.26LNYC9K9KX1P@bootlin.com>
Subject: Re: [PATCH bpf-next] x86/ftrace: relocate %rip-relative percpu refs
 in dynamic trampolines
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Ingo Molnar"
 <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Uros Bizjak" <ubizjak@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260527-fix_call_depth_in_trampoline-v1-1-d0292bfe7eed@bootlin.com>
In-Reply-To: <20260527-fix_call_depth_in_trampoline-v1-1-d0292bfe7eed@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed May 27, 2026 at 9:08 PM CEST, Alexis Lothor=C3=A9 (eBPF Foundation) =
wrote:

[...]

> Fixes: 59bec00ace28 ("x86/percpu: Introduce %rip-relative addressing to P=
ER_CPU_VAR()")
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>

Please ignore the 'bpf-next' target for the patch, this is a mistake (I
used my bpf tree to prepare this patch), I am really targeting the trace
tree here.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

