Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A721CFE0
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771003342; cv=none; b=p7j/LsIx2CzgNRBqCA7Rhg3UeVp/JoNqelhbusprmHPKQkB2ObdgrRm+aYTRVBKijWnBaUkuVcLZvGcvRROs679eMruRw9LAms2Tq2oa3kyRKm9TwvJ+bn/Z7J5KuDA5B9cBrD2tf1jC2vxIxOQ4VvVyUT98envyl0Km68UEs0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771003342; c=relaxed/simple;
	bh=Li7RA7rb91C+NtViKhE1zNDAnOUxmCPSlSLpIaAiwX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InTsKllrLs91cYMG570Jxht6B73FomdU2hdNoSFu1BXXxGeYdc3atY1I/5SFc/xyycGQS6yghM8p9pqnR12Earts9DhmZw2Ra5cBpXkNn+08zcfGduFHmB6iEd3ypmkenSW3wEEIZBPhpaXT8wp7NCbOQvmyGPwHvYVZ9MQm9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjwWXoH9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjwWXoH9"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-354b20c1112so738712a91.3
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 09:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771003341; x=1771608141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Li7RA7rb91C+NtViKhE1zNDAnOUxmCPSlSLpIaAiwX8=;
        b=cjwWXoH9ItHJw/oYsEa5vWFAr2epzYrYfN0gYPTeKElg4h82wrCwNpuSqECjnPy6Gq
         ItSxSQhKXvJVTB+L6H8810Wi2C33bsuUlNwgEBXpj7EJZsGTSv8xkXqX7PP108RVzDiD
         4vzqpkuKBrtzzIBpix/3aqTAyFCpPInY6BW9XeVcE7jTq0uWShZoE2lRf7EPR98mL4NC
         NBQkSE9fpS7t7KqIqXaF/aXVlrvLwml4KUj/Ul9TOvz9Cm+GmNzBksTegM3WFYjP2lPX
         8ax5BqQV8V/E4aaxutrDvu0xuqqy/F0QnYY12/4CoQvdNf9huhH7P69n/35pD+zflkCC
         tRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771003341; x=1771608141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Li7RA7rb91C+NtViKhE1zNDAnOUxmCPSlSLpIaAiwX8=;
        b=g4F64PCSL/65wETD1sjllJkQOUxqJqHlz4yfd9uzMBSkVFg1j99QpeIlh6lyO/a5Q8
         +Dw+b0XP4uEU2XPDqXzqvLnfXBbFHn+Il/Hg+KyXd/XgAotgmxENRFJgRlQvhwkz2mVx
         Opw6vrPmAwdxVkKHaSrx2DYVewDMCEIE2OK+nz82p2JIUvL7Oi8L07MJ7+JVtEnoJIwt
         pffIzE/UqnKVKfkAttOmSAxB9MdnAb76U1fG9eAwPfCZipV+kAp7RFz1jlM1nkQApSrC
         ZxzwCVIBS5k64NTE7Xq3Wbu/SIe2aweF56/JyeGAn0A1oIlOn0l22m6b38qQiUWv1CqT
         kT3g==
X-Forwarded-Encrypted: i=1; AJvYcCX0W/xkzS6eQvh0dULf5xIJKV9UqCb0MSmpRK4xTSIKtSUJ7i7C62yHWzpIwvhZHgAjcr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhFWbE7P+/d/qde9ibPF+AahEg9+Fo4Vnbr2HsWqVxNPDPfYaj
	XYqCvpvVscLblTaeWdwqYA+CmwezbhGOnu3NfKT6Xl3RtBarcJjUg2Kn
X-Gm-Gg: AZuq6aL8wcJxCFE3gyHXiH3Kr/RFuv5TXSThttQGEpVFPmqJ0DsHussgKv1nKRR+p0x
	NYxy6UyMhJvQoif84HSvvARRNdcZ9gQTnE0i7355GQ8LIutS2LM/oylMxXMBD/1uSfgkc84syzV
	wsRgSMpZZUluMFQlGBurVzfpq7ktA928+f2/9bJCFJi+tBG7GJS+EuQ25vqN9TWaIozF7pxeEVN
	C35PRLIif82l9n4aG2DWc3trpIHOxQbByQxwRm2NgmlqyMgVYZG5UkZBUCUwZoUF5MouWKh7I+6
	KBL4ek0z37wz+8GUABSpvV7VVMRFDcObRMWhT8yFlIdR+VLqDd2Yy2Fg+PyEh8UM6wJA4OjgMNg
	Egkbc40MfbUY2aEw6dVCCojfoGhiYLR6XwIR6a7JAaf+uMbEUQl43lrbf8rmPrwOFcrN6iFSv5a
	5IoETzSeW6CuyGOnrWVHIsRy/ZEhcUKensIpqWofALEKrFQuA=
X-Received: by 2002:a17:90b:3ecc:b0:353:e91:9b2f with SMTP id 98e67ed59e1d1-356a7aab90emr3096968a91.37.1771003341122;
        Fri, 13 Feb 2026 09:22:21 -0800 (PST)
Received: from roxy ([2a09:bac5:40b5:1aaa::2a8:23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662fac3c1sm12572425a91.17.2026.02.13.09.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 09:22:20 -0800 (PST)
Date: Fri, 13 Feb 2026 22:52:12 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: andrii@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 1/1] libbpf: Auto-upgrade uprobes to
 multi-uprobes when supported
Message-ID: <aY9dxEBCvurRfzJU@roxy>
References: <20260212152013.17351-1-varunrmallya@gmail.com>
 <20260212152013.17351-2-varunrmallya@gmail.com>
 <82d31503-24d8-45b8-b1dd-2cb35bd28509@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82d31503-24d8-45b8-b1dd-2cb35bd28509@linux.dev>

On Thu, Feb 12, 2026 at 04:06:22PM -0800, Yonghong Song wrote:
>
>
> On 2/12/26 7:20 AM, Varun R Mallya wrote:
> > This patch modifies libbpf to automatically "upgrade" standard
> > SEC("uprobe") and SEC("uretprobe") programs to use the multi-uprobe
> > infrastructure (BPF_TRACE_UPROBE_MULTI) at load time if the kernel
> > supports it, making them compatible with BPF tokens.
> >
> > To maintain backward compatibility and handle rare cases where singular
> > uprobes are required, new SEC("uprobe.single") and SEC("uretprobe.single")
> > section types are introduced. These force libbpf to use the legacy
> > perf_event_open() attachment path.
>
> Maybe you can have bpf programs for both uprobe/uretprobe
> and uprobe.multi/uretprobe.multi?
>
> You can add "?" before the section name (e.g., SEC("?uprobe") so you can
> selectively enable those programs before loading. This one if one choice
> e.g. uprobe/uretprobe is not working, you can then try
> uprobe.multi/uretprobe.multi.

This is a good idea, but isn't making the upgradation built-in a better
choice ?
This way, anyone writing the program does not have to rewrite
the same thing twice, keeping their programs pretty clean. This also
moves the upgradation logic (which is probably going to be repeated multiple times)
into the library which makes it easier for anyone to have something BPF
Token compatible without having to write all this extra logic. Since "uprobe.multi"
is compatible with "uprobe", I don't think anything will break as well.
(The current breakages in the selftests are due to the patch being in
nascent stages and I'll fix it after I get some feedback on my
questions.)

