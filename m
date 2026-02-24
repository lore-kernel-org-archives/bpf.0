Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720A3AA18B
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958050; cv=none; b=nzfYYKWCMI9/znsvL/CDmNwv1Ui7qHYcM/b3cAQ+8PPLJFsQC4ETQM0oLLZJ+qNqnsq5vuIXOa1yY63QmboUwMVjQctBABpFM5k2E/QIFl/Gyvjbrj0ruhj8HI6WzWRXAuYhncD4rwFJkjSUCHgRF34vtUp35TMXakOQpzUUcDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958050; c=relaxed/simple;
	bh=J11iK2XwIj2+zXIcYCQZxiKQs/qMUnRO89klT0AGl1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XaH/LcRJf/Er/skb42REP8s90LkXG9FfvcJwqk6mk3E+L7KE2efYhwo0NP1iGy7DuxgDhpIomQ9FFOul30Qvzci55QkiKpgtqElxBE983l/oeKK4d9Xr3XSTUhBwdx5njhM6ctU6A2NERMw5HQgoccLoEIor3BLgOZnPzQqJh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2PxMZRMk; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2PxMZRMk"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdbe1bd565so238921eec.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 10:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771958048; x=1772562848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrjBvSrm8JFCEhJvVydTf7Q6kCsOJiDnm0ZLRH2yvhY=;
        b=2PxMZRMkvwdPT6xmoQWt26Bz7LxYouErxHbvwHpyCRpyKkAEiMZw8KBiIBg284l0UR
         rtByLaeejleh76tViNccPtvMoMwjDzGLrD8GMB6spm/oT7ULoRjp1sJEIDvccw+AM5f0
         mL5Owi6Pjy/3hz5snmZIlMTcB4gQMBt2Qw3ti9ulThlUP93RHkgKVKk+otIiSlsSaPQU
         /c4AwOHIwI9Ojy63pFWM1uUZTr/9Ytq610yfVjDwuk0RhrulAAvSttVQOXYCPxn776E+
         rGOG3KK/FH14b2fU5OqogoRGcN7f8Lkuq5lIa6icsKjV1Bw+UkgETMBU2Tdilub01cme
         OFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958048; x=1772562848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrjBvSrm8JFCEhJvVydTf7Q6kCsOJiDnm0ZLRH2yvhY=;
        b=eFBfYEZEYbTvbHnpw6wR8PF/+ofUNJJmQwoDx550shGJp3ZOMuqMFHD2tYSFk5v56O
         x76UZC308YFJcDPed/x1TcDV/kBXjjx+pNeRAs+6vdkdbR1DctJ6I04RwBFUAT2cs7Xm
         3BLPrkGwq8bZ5r4qpzJrPXXwB2ClJTOii2SCKeFrSsdbRhfBgolI1QwaKOb9z7uJ1/43
         Gfqswf+NxxFRPzMzN3CsAzCdWTEI1IA2yBNp6dJYtZWWqrQBPjYJ0dFPLDZeJzys45x3
         VOivYT8fbyJHs+V/lEzmldJPRcidHTlP+sGExc6TfQanbtHRRErZ7kjFLzIOaUlWs7/k
         0dTw==
X-Forwarded-Encrypted: i=1; AJvYcCX+s89QTkt9C3Zu6FdOgQfX9GAuH+96nl/CCrJgot42KppcKwzngAa7tkCPyVyp0NeanLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+kI1wZJp9YNSJIASvuI3oSNUdm+hA7OuVIBl0SAw48+VtxQK
	yZvwq0pCSiMeU6YmkixR2GupLDqo5gnK1ETcayLV8VHADyUbl1XnW4XaMgaopZH1rdDWtF8RRQb
	5lppXmlVbd0ieZ7X2WPCQ812KS70ixQ==
X-Received: from dycng10.prod.google.com ([2002:a05:7300:ce0a:b0:2ba:963b:54da])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:d718:b0:2ba:6ffe:450 with SMTP id 5a478bee46e88-2bd7bd3aa44mr4531030eec.33.1771958047807;
 Tue, 24 Feb 2026 10:34:07 -0800 (PST)
Date: Tue, 24 Feb 2026 18:34:06 +0000
In-Reply-To: <20251230183208.1317279-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251230183208.1317279-1-ihor.solodrai@linux.dev>
X-Mailer: b4 0.14.3
Message-ID: <177195804671.1905199.15508123005606240406.b4-ty@google.com>
Subject: Re: [PATCH] module: Fix kernel panic when a symbol st_shndx is out of bounds
From: Sami Tolvanen <samitolvanen@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Tue, 30 Dec 2025 10:32:08 -0800, Ihor Solodrai wrote:
> The module loader doesn't check for bounds of the ELF section index in
> simplify_symbols():
> 
>        for (i = 1; i < symsec->sh_size / sizeof(Elf_Sym); i++) {
> 		const char *name = info->strtab + sym[i].st_name;
> 
> 		switch (sym[i].st_shndx) {
> 		case SHN_COMMON:
> 
> [...]

Applied to modules-next, thanks!

[1/1] module: Fix kernel panic when a symbol st_shndx is out of bounds
      commit: f9d69d5e7bde2295eb7488a56f094ac8f5383b92

Best regards,

	Sami


