Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987473624D7
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475881; cv=pass; b=BlaloCQQUX3QW5Pg3odmLkFMko+FVMAbUNKD+2A5hJZy84rV2yUTh0wmJmQLQWpTtWfkuONnc9Ay8okQRDsJlOKZpbLoV4eQpdpxcVmDzTP+OZseoxwSydnLiyJT3W64HP4llnuDIE9gHYNujTQTQBmZXXJ2sN6Li/2xRjRqdfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475881; c=relaxed/simple;
	bh=9z43nsKfJPyDKxJZ1fFGdLcfiKwE6x911r+pE9P8b1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aq89YuqmYJD2Klj+osNHiWwNoRYpnkGNkwqFRzJ27d3bno3tfO2HAZs2PvHRGUhYZvipyqy2nfeHN3GzG9ZUeXftfJ4/Km0ItxWslci5wc+fTe4T/HGQCiAN8V9FQ7ZUZa3/yKIggCtIvJ5F6S3JRh5GyJ0whP1nH/RfJgy8TAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjWFvhQ7; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjWFvhQ7"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b4583f0a1aso52689915ad.3
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779475880; cv=none;
        d=google.com; s=arc-20240605;
        b=CpCN16NSxeM0cqhmrjTQ5Xe255UWQCVG1joPJPe+tDYDlQAQVoHPBdIEYqKcZWa3Fx
         nCvLkJz+MSvWqWv+1MJh2wghvMvf/Vbf4B4JKxIB5SO+wHR/maYn+1GFcG0zMoUvMXCn
         CkWqE9hqtFVeLzjdPomaG9Mlt8og8PTL28LfwwJERTHN4s8BNYyy/JFWFBPaD5gG0znf
         NPEtqRLmXsl7MODWvVZIlsVyRg/D0znWchWBR0DLmcC+MFhuSdFGBOPUjMpLTNrcN9Tn
         nTjb23vkYo9U+KNrcowRQCbAE38nA6b4pnNx76oezDITlphtVFoBSHKgUZPSZsd2Zar0
         8mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZyEtR3Dzvg4iCrKjMeeFlIVr7ScvRo9PP++E/GQiMYQ=;
        fh=Q4OmJhDgowCHpiZEVWUNbTj/g5o+QZ+E1tSZ2n1Uzdo=;
        b=IIeEUD+LgL4JbBWgVcOql7oyZWRMFVplgvKKWBuyXlZYA7EGuUIgOc5dr5LkPJw8NV
         PKxwf6TCvA1x83TyRY9eA3vEwxoT6rOJhXMjCJURd3h+Y6fM+5wWRGr6gXHP1jMgcEaE
         7Aidr9og+ucKSmc0D1Gc4If0dmHWVJyfvkRjt/B+AZnxYYUbKHSnBWl31QXQmVuUcUbA
         sjteHpbTF9lqIVogMmSRQrleUmN68hMstSzjJPy5JEc7yiXSz7U6vRyD6MfEMjgD0qYz
         HHD87bLE0kFddvOqSLwuKAuWMfHeYRGN03yzqbSztLhLXjvE0p0GVC3nfX7e3vjY2zv3
         khCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475880; x=1780080680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyEtR3Dzvg4iCrKjMeeFlIVr7ScvRo9PP++E/GQiMYQ=;
        b=qjWFvhQ72bR7RNCY0TKHMrzNKFH1kKR5qp+4QiD+KVVngsi6IySw9JoWJ25cy6q/KH
         iTbbMow75WeLAML2dDtEF/EaGy3RQW7MmlrvYfgdSCLduJUtaJ6qTuwh3vafKb/hl8c3
         FBwSNhSgKeq4c69l4d7rWzfrjs/Mj1kf8n5mJPUVuwD84WJrVpt8NaIIbPO7HzWCeiuA
         O19ldELI9hXz0k4fs4xxQfCb6AF64HHTzv4n24YZxJ/Ri9ReKtldHbzpn2g3u6HIPSQF
         9yaDGY6akD6t6baAa0Qb7nuzc86tLbouEJr5o7iapzyTEtgAoLlceWYs4I6K2uKpc251
         AcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475880; x=1780080680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZyEtR3Dzvg4iCrKjMeeFlIVr7ScvRo9PP++E/GQiMYQ=;
        b=cZDYo7OUPtoAq+y11o+P+y5JkatBLLmiz8MpQSeMBAUcusmF8Ws4D0ddZgXcVS8iX3
         IXU/jDa1vkLLcAUcH0K2QNEjbG43FRNfMagZxv+n8NOslkqoMZZOQVP9nSd12SK33AZP
         HR7kBXV/22/9gKDChY4j7nKR3dhBl3vJLalJs2Dzr626ogQVVSCN51RYNRQEMoE5aByB
         dtv3H23gMj1fR6At++VUzomWn4l/DGIj0D9DegvzV1ndzzfEuhf/oTOksNQLZ8Magdsv
         1vuUSu8veHIZhGinZHGfwPgbBO0Gb+CBHBzx3MRnhT52/NZXEv07mHRadj8oPboWgYKD
         adwg==
X-Forwarded-Encrypted: i=1; AFNElJ/HNFLbtw+0tWXaKBBVNlVLVhpCO9uz7++e3Nu/xGuqEZfntpxjOpBbx10af1GOrRswhZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xBNDa/p/XTH8SP5hleZEazEylMRyqjQk302AOug9Cxzm3nE1
	tHEe2/rER6L2y8G6kM5P+TLVnKA6e5fkTFx0CBRchaWvXVgKc+g2w146wZ2FAhH6YIokx3NAuAk
	TtnPYKAiJvrytG6TJ27+883SU0T9SfZU=
X-Gm-Gg: Acq92OGVsxJe3Mml4eG+CDG4AgcQCpWZ+Mf+l9CkbK+j324TDyjvabUAm2IbND10VXr
	x6sWxaIdTfwlktml7B9cDQuaUtAJ2j5CSlJImoMphx2vLvnjh4lAHkvoiPJGd7hE8/4nT83RkiD
	zN1HOQZf0+0WbsgDxxAz9+KCDUETmWVDfLb1YDbE6ejDslHZdykl7fnG/n5fm7mf36nGH3m+a0Y
	1MpjAlmcpI78GSPR18bJ/2FqypI8eCyB7irefr4dUo1qOdBThRdzubuXJkzIIa45GRAsLCez8jA
	n3zih7MlwTiW7S4OuAhwRk8=
X-Received: by 2002:a17:90b:564f:b0:35c:30a8:32a with SMTP id
 98e67ed59e1d1-36a674d88edmr4333745a91.9.1779475879901; Fri, 22 May 2026
 11:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-3-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:50:58 -0700
X-Gm-Features: AVHnY4KWVpkBrOSue6VVsgOwf2DPF4XM-24nyQisnEZqeRMi2MKFAftQwgEohR0
Message-ID: <CAEf4BzZOJn4ynhqQv+n2L3Cb+=teptBD4jLg5axSXQGD9T9pvw@mail.gmail.com>
Subject: Re: [PATCHv3 02/12] uprobes/x86: Remove struct uprobe_trampoline object
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:44=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Removing struct uprobe_trampoline object and it's tracking code,
> because it's not needed. We can do same thing directly on top of
> struct vm_area_struct objects.
>
> This makes the code simpler and allows easy propagation of the
> trampoline vma object into child process in following change.
>
> Note the original code called destroy_uprobe_trampoline if the
> optimiation failed, but it only freed the struct uprobe_trampoline
> object, not the vma.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/kernel/uprobes.c | 102 ++++++++------------------------------
>  include/linux/uprobes.h   |   5 --
>  kernel/events/uprobes.c   |  10 ----
>  kernel/fork.c             |   1 -
>  4 files changed, 20 insertions(+), 98 deletions(-)
>

nice cleanup

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]
