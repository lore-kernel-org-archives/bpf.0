Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAB175A5
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327810; cv=pass; b=Kn4pFQ/suOJ1iy0CvESVcwDK2o8HK4rpU8D+aNztKfatN+56ooYaMzKU1bqtNpiL8DnzaW/PoFp6x0ZWjB0V2VYx77G/SXWR68/DaDCpV30bNEK6vBku2M1McJlxmh0s0NMZNYx4sxOjRbzlJPVMrPABo6aekbfpgjmycTfijms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327810; c=relaxed/simple;
	bh=eDv9Ms7BHi4UpLs/xou8L3EuVrqRPx28h9CcZ7tGmZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmwMPLxPWmxBZRcOsIz6mDIErpsVPezbs4xe0aTkbBWIFftN2ubiFxKfqK/U9iJzg7rx5wdVRzxG1QFf8ZexmjpMyDwt+ShOswGTKOTcOBlVQqy8Oblb3GIZdCTHQ7XaC4F/k6F+JXbrrZpFWctnGslPFwV49dnrw8+h0Y8EaeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcXvQq4X; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcXvQq4X"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so8356536a12.2
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 15:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784327807; cv=none;
        d=google.com; s=arc-20260327;
        b=kYzHu+d/5FNihVb0JeOMLwdzv5BDQRb6azK1J1tTskNOFaZLHGi0N0S2Kd/TuBxDUz
         rZR74HcbrA1WT8N5zjOX2CIpDvHbMGG8F87KG400KxCvYb4Q0pKmfORK4HJvfRxHYGqX
         xQtZYeMdI0J6Y0yA6akt7EvphcijonaztjjFMzWoK+/7bTl2+Yv0FQs5AWrhwgwjSKKP
         5wqjMTedbTo3J8TtQ7HetMPqIE2m29tMyi18duhTw9+IVPwi76nByxRpPhfMXnlKbS6b
         RVRSXFRbkpeaEhmusk1mufu64O5ofYwfUGgmKcu0vAIM1sKHXS1SqiM7N86sRdQuv5i7
         aouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eDv9Ms7BHi4UpLs/xou8L3EuVrqRPx28h9CcZ7tGmZo=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=TXVdqa52hhJ8Hb1Dp3y2BVWNC6352aMurfpF7ABxvyU8z71N1c+0t7MUfn7HJ+2SF9
         I0oLxACojXnXgQ6y5GOfLartfU+ZC6yDd/m5xvuRBNSaUrMw5KMCIRa1Jf96R73z6Daq
         MN3AhNT7z+Yv7OaFYmbcX8QH8/Mf5Y2pOo99zFwrDlbMAegfoxcwlQBQ9wesHpgHR//O
         Vfw8zCpCfWBhpQZJ6gstVR0X08qFgHgjpGi4UlqkbBlTeaadqLpQCCDMuXOOSpCRENL3
         CeXn++dPKeG+nOUwtL2+nCuPwrScC+megpfhBTveIyi4hkIrc4FZmPIMQoEKxzCt6d8u
         Izmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784327807; x=1784932607; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDv9Ms7BHi4UpLs/xou8L3EuVrqRPx28h9CcZ7tGmZo=;
        b=NcXvQq4XlMdaivaFNRihFyOJgbtIx17SgRzLc/40dBQ0WtPIiNHqGdIllO8a3BKJQg
         Bn6I7ih8cj84nW8WwEFXAZsHlkb/MJbpWYEl6/6MNPItinwC1GGlrt5YDAzOkI5ucwmv
         v4umQC9wfCUJJawgTyLgN5KvoFcEnZIzBCSPMDFlYKBuVX/zRNAj+YvXtwQdKiYTKCdK
         UdOAaQzFJUFj8DtzFSyXPN/uNpnU1OdIUW1xQT16qfB/Z+D1EK8Tq9X/CfEzrSTg3oKs
         tBORYHZdMR/aJIMvLHeLVg7DQUWd/TanxPw9qU600QShi3KkyVzhjHiMLg34uATHovwW
         RYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784327807; x=1784932607;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eDv9Ms7BHi4UpLs/xou8L3EuVrqRPx28h9CcZ7tGmZo=;
        b=jh1AuRswnpjMiLHKM0AJ+b+T6S70bgwEPqi6OA5ngScFPNZq+iYg99Wnl15cOI5dAB
         YS7MLUihx3SeKpMcrh6Z9ut1uXEwHsUlOVT/VfNLm1odebHWxmf/fedwZQ/fi8+XZw6S
         ynkbcy+jWIVxQz6HSQ96710xXJG4T3FulEIgZdVOqSXewaalZr97WCm3zb8kMrWNrLZk
         oykso+iC7Z4UDScZZFiKpVci3GFZGkowfuPbiplMXV4yfvYC8roP+R2ZpPMiUDMund4W
         49kzIAq4zTcMrMt5C888mV5HQx3rTsXA8D/kjTChlrvQYowiamVKayMC+sGGSWKXEltA
         oI3A==
X-Gm-Message-State: AOJu0YwfCNOdoY6iXdl0FqhWk8gbIUyM1mt8UXp1fiM6xhrFV/uK7BvD
	DRBwbBYv946pKUB8USN/vnCFztRPj/EjLbZ3k0ycVU1WVpwj0l1LoxWLnDWrpS1huHPRUaF8Bwc
	H6uQq03tzAD1YGt0CDMK9qx7/LtIZGTEhDosv
X-Gm-Gg: AfdE7cmX8rBo3oiwKZZJ7/1HQdcT/gz45/b6G4xPlxxVSs8QccuEZXDdssWLI3l/wke
	1Ks7a6Pg7saRuSuJhz1LK4D4eLV86RYxP1FLo5e+s5GIEi0h3OA24FmuFT2nov8Ay6kwDxpJ9UO
	AOcQfXsE/s9rxBteAhegS8duu5tEzurSe80jG7cj75jUtVsy/ySO0PSpLsRJDHraOHmNqbdW+VM
	B+QfGTeLQ5QebAUV2Xv6jXoQOoS0FMsS1GsXxZxCyUz9mXd8ukTMqT3hrjH53X3
X-Received: by 2002:a17:907:c896:b0:c12:6ad6:6398 with SMTP id
 a640c23a62f3a-c16b4854d08mr179515966b.34.1784327807057; Fri, 17 Jul 2026
 15:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717190544.257306-1-main.kalliope@gmail.com>
 <20260717190544.257306-2-main.kalliope@gmail.com> <20260717191621.0D7DC1F000E9@smtp.kernel.org>
In-Reply-To: <20260717191621.0D7DC1F000E9@smtp.kernel.org>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Fri, 17 Jul 2026 18:36:35 -0400
X-Gm-Features: AUfX_mz3U8rrl-xwWmug0jkD8niv-ww2HS3xyRgdhTsJTy89w3l1EwIrfTwuEdA
Message-ID: <CAJZwKkicFPW=duFFpqOB6XhFS57M7mxOEe6s0tPxWs3W5B2XTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, parisc: Add support for BPF_SDIV and
 BPF_SMOD in the parisc64 JIT
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 17, 2026 at 19:16 UTC, sashiko-bot@kernel.org wrote:
> [High] The patch implements BPF_SDIV and BPF_SMOD for the 64-bit
> PA-RISC JIT but omits the 32-bit JIT, causing signed divisions to be
> silently miscompiled as unsigned.

This is a two-patch series; patch 2/2 ("bpf, parisc: Add support for
BPF_SDIV and BPF_SMOD in the parisc32 JIT") adds the parisc32 support,
threading is_signed = (insn->off == 1) through emit_alu_r32()/
emit_alu_r64() and using $$divI/$$remI and hppa_sdiv64()/
hppa_sdiv64_rem() on the signed path. Patch 1/2 provides the shared
helpers patch 2/2 uses. With both applied, the parisc32 signed div/mod
tests pass.

Nicholas
